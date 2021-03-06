(* andrew Id: _________________________________ *)

functor MakeJamboree (structure G : GAME
                      val search_depth : int
                      val prune_percentage : real)
        : JAMBOREE where type Game.move = G.move
                   where type Game.state = G.state =
struct
  structure Game = G
  structure EstOrd = OrderedExt(EstOrdered(Game))

  type edge = Game.move * Game.est
  datatype value = BestEdge of edge
		 | Pruned

  type alphabeta = value * value (* invariant: alpha < beta *)

  datatype result = Value of value
		  | ParentPrune   (* an evaluation result *)


  val search_depth     = search_depth
  val prune_percentage = prune_percentage

  fun edge_toString (m,e) = "(" ^ G.move_toString m ^ ", " ^ G.est_toString e ^ ")"

  fun value_toString (Pruned: value): string = "Pruned"
    | value_toString (BestEdge (_,e)) = "Value(" ^ G.est_toString e ^ ")"

  fun alphabeta_toString (a,b) =
      "(" ^ value_toString a ^ "," ^ value_toString b ^ ")"

  fun result_toString (Value v) = value_toString v
    | result_toString ParentPrune = "ParentPrune"

  (* equality functions *)
  fun edge_eq ((m1,est1), (m2,est2)) =
    Game.move_eq (m1,m2) andalso Game.est_eq(est1,est2)

  fun value_eq (BestEdge e1, BestEdge e2): bool = edge_eq (e1,e2)
    | value_eq (Pruned, Pruned) = true
    | value_eq _ = false

  fun alphabeta_eq ((a1,b1): alphabeta, (a2,b2): alphabeta): bool =
      value_eq(a1,a2) andalso value_eq(b1,b2)

  fun result_eq (Value v1: result, Value v2: result): bool = value_eq (v1,v2)
    | result_eq (ParentPrune, ParentPrune) = true
    | result_eq _ = false


  (* for alpha, we want max(alpha,Pruned) to be alpha, i.e.
     Pruned <= alpha for any alpha;
     otherwise order by the estimates on the edges
     *)
  fun alpha_is_less_than (Pruned: value, v: Game.est): bool = true
    | alpha_is_less_than (BestEdge(_,alphav), v) = EstOrd.lt(alphav,v)

  fun maxalpha (Pruned, v2): value = v2
    | maxalpha (v1, Pruned) = v1
    | maxalpha (v1 as BestEdge(_,e1), v2 as BestEdge(_,e2)) =
       if EstOrd.lt (e1,e2) then v2 else v1

  (* for beta, we want min(beta,Pruned) to be beta, i.e.
     beta <= Pruned for any beta;
     otherwise order by the estimates on the edges
     *)
  fun beta_is_greater_than (v: Game.est, Pruned: value): bool = true
    | beta_is_greater_than (v, BestEdge(_,betav)) = EstOrd.lt(v,betav)

  fun minbeta (Pruned, v2): value = v2
    | minbeta (v1, Pruned) = v1
    | minbeta (v1 as BestEdge(_,e1), v2 as BestEdge(_,e2)) =
       if EstOrd.lt (e1,e2) then v1 else v2


    (*fun updateAB _ (a,b) Pruned = (a,b)*)
      fun updateAB S (a,b) v= 
        case G.player S of
             G.Minnie => (a,minbeta(b,v))
             | G.Maxie => (maxalpha(a,v),b)
        

    fun value_for  S (a,b) = 
        case G.player S 
            of G.Minnie => b
              | G.Maxie =>a

    fun check_bounds (a,b) S mov est=
        if not (beta_is_greater_than(est,b)) then
            case (G.player S)
                of G.Maxie => Value Pruned
                  | G.Minnie=> ParentPrune
        else if not (alpha_is_less_than(a,est)) then
            case G.player S
                of G.Maxie => ParentPrune
                  | G.Minnie => Value Pruned
        else 
            let
                val i = case G.player S
                                of G.Maxie => minbeta(BestEdge(mov,est),b)
                                  | G.Minnie => maxalpha(a,BestEdge(mov,est))
            in
                Value( i)
            end
      


    fun evaluate 0 (a,b) S mov=
        let 
            (*val S'=G.make_move(S,mov)*)
            val k =1
        in
            check_bounds (a,b) S mov (G.estimate S)
        end
        

        | evaluate n (a,b) S mov = 
        let 
            (*val S' = G.make_move(S,mov)*)
            val mvs=G.moves S
            val (abmv,mmmv)=
            Seq.split (floor
              (real(Seq.length mvs)* prune_percentage)) mvs
            val v = search (n) (a,b) S  abmv mmmv
        in
            case v of
                (*Pruned => Value(Pruned)*)
                Pruned =>Value(Pruned) (*
                case G.palyer S of
                  Maxie=>
                  | Minnie => *)
                | BestEdge(_,est) => 
            check_bounds (a,b) S mov (est)
        end


    and search n (a,b) S abmovs mmmovs=

        case Seq.showl abmovs 
             of Seq.Nil=>(*value_for S (a,b)*)
             let 
                val fres=evaluate (n-1) (a,b)
                val vs=Seq.map (fn x=>fres (G.make_move(S,x)) x) mmmovs
                val upab= updateAB S (a,b)
                val vf=value_for S
                val v2ab2v= vf o upab
              in
                if Seq.exists 
                (fn ParentPrune =>true |  _=>false ) vs
                then Pruned 
                else 
                  let
                    val rv=Seq.map v2ab2v 
                    (Seq.map (fn Value(x)=>x |_ =>
                      raise Fail "ParentPrune???") vs)
                  in
                    case G.player S of
                      G.Maxie=> Seq.reduce maxalpha Pruned rv
                      | G.Minnie=>Seq.reduce minbeta Pruned rv
                  end

              end



               | Seq.Cons(mov,abmovs')=>
                    let 
                        val res=evaluate (n-1) (a,b) 
                        (G.make_move(S,mov)) mov 
                    in 
                        case res of 
                            ParentPrune=>Pruned
                            | Value(v)=> 
                            search n 
                            (updateAB S (a,b) v)
                            S abmovs' mmmovs
                    end

  fun next_move  S=
    let
        val mvs=G.moves S
        val (abmv,mmmv)=
        Seq.split (
          floor(real(Seq.length mvs)*prune_percentage)) (mvs)

        val v=
        search 
        search_depth 
        (Pruned,Pruned) S 
        abmv mmmv
    in
        case v of 
            BestEdge(mov,est)=>mov
            | _=> raise Fail "something wrong here"
    end


end (* functor MakeJamboree *)
