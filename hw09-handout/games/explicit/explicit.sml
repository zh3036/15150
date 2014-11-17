(* useful for testing search algorithms that use the estimator;
   unbounded complete search would loop.
 *)
functor ExplicitGame (structure G: GAMETREE
                      val tree : G.tree)
	: GAME where type move = int =
struct
  open G

  datatype player  = Minnie
		   | Maxie

  datatype outcome = Winner of player
		   | Draw

  datatype status  = Over of outcome
		   | In_play

  datatype est     = Definitely of outcome
	           | Guess of int

  type move = int

  datatype absstate = S of (tree * player)
  type state = absstate


  (* printing functions *)
  fun player_toString Maxie  = "Maxie"
    | player_toString Minnie = "Minnie"

  fun outcome_toString (Winner P) = player_toString P ^ " wins!"
    | outcome_toString Draw       = "It's a draw!"

  fun status_toString (Over O) = "Over ("^ outcome_toString O ^")"
    | status_toString In_play  = "Still playing"

  fun est_toString (Definitely O) = outcome_toString O
    | est_toString (Guess i)      = "Guess:" ^ Int.toString i

  val move_toString = Int.toString

  fun state_toString (S(t,p)) =
    "("^ player_toString p ^","^ G.toString t ^")"

  (* equality functions *)
  val player_eq  = (op=)
  val outcome_eq = (op=)
  val status_eq  = (op=)
  val est_eq     = (op=)
  val move_eq    = (op=)
  val state_eq   = (op=)

  (* parsing functions *)
  fun parse_move s = raise Fail ""


  (* game functions *)
  val start = S (tree, Maxie)

  fun status (S t) = In_play

  fun moves (S (Est v, _)) = Seq.tabulate (fn x => x) 1
    | moves (S (Node (_,_,succs), _)) = 
        Seq.tabulate (fn x => x) (List.length succs)

  fun player (S (_, p)) = p

  fun flip_player Minnie = Maxie
    | flip_player Maxie  = Minnie

  fun make_move (S (Est _, p), i) =
       raise Fail "called make_move on an Est state"
    | make_move (S (Node (_,_,next), p), i) = 
        S(List.nth (next,i), flip_player p)

    (* estimate the value of the state, which is assumed to be In_play *)
    fun estimate (S(Est(s,v), p)) =
        (print ("Estimating state " ^ s ^ "[" ^ Int.toString v ^ "]\n") ;
         Guess v)
      | estimate (S(Node(s,v,_), p)) =
        (print ("Estimating state " ^ s ^ "[" ^ Int.toString v ^ "]\n") ;
         Guess v)

end (* functor ExplicitGame *)
