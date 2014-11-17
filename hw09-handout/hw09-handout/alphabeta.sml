(* andrew Id: _________________________________ *)

functor MakeAlphaBeta (structure G : GAME
                       val search_depth : int)
        : ALPHABETA where type Game.move = G.move
                      and type Game.state = G.state =
struct
  structure Game = G
  structure EstOrd = OrderedExt(EstOrdered(Game))

  type edge = Game.move * Game.est
  datatype value = BestEdge of edge
		 | Pruned

  type alphabeta = value * value (* invariant: alpha < beta *)

  datatype result = Value of value
		  | ParentPrune   (* an evaluation result *)


  val search_depth = search_depth

  (* printing functions *)
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


  fun updateAB     _ = raise Fail "Unimplemented"
  fun value_for    _ = raise Fail "Unimplemented"
  fun check_bounds _ = raise Fail "Unimplemented"
  fun evaluate     _ = raise Fail "Unimplemented"
  and search       _ = raise Fail "Unimplemented"
  fun next_move    _ = raise Fail "Unimplemented"

end (* functor MakeAlphaBeta *)
