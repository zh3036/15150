structure Nim : GAME =
struct
  datatype player  = Minnie
		   | Maxie

  datatype outcome = Winner of player
		   | Draw

  datatype status  = Over of outcome
		   | In_play

  datatype est     = Definitely of outcome
	           | Guess of int

  datatype state = State of int * player (* int is how many pebbles are left *)
  datatype move = Move of int (* how many pebbles to pick up *)

  (* printing functions *)
  fun player_toString Maxie  = "Maxie"
    | player_toString Minnie = "Minnie"

  fun outcome_toString (Winner P) = player_toString P ^ " wins!"
    | outcome_toString Draw       = "It's a draw!"

  fun status_toString (Over O) = "Over ("^ outcome_toString O ^")"
    | status_toString In_play  = "Still playing"

  fun est_toString (Definitely O) = outcome_toString O
    | est_toString (Guess i)      = "Guess:" ^ Int.toString i

  fun state_toString (State (n, p)) =
      Int.toString n ^ " left, and it is " ^ player_toString p ^ "'s turn"

  fun move_toString (Move take) = Int.toString take

  (* equality functions *)
  val player_eq  = (op=)
  val outcome_eq = (op=)
  val status_eq  = (op=)
  val est_eq     = (op=)
  val state_eq   = (op=)
  val move_eq    = (op=)

  (* parsing functions *)
  fun parse_move (State (pile,_)) s =
      let fun enough n =
          if n <= pile
            then SOME (Move n)
            else NONE
      in
          case s
            of "1" => enough 1
             | "2" => enough 2
             | "3" => enough 3
             | _ => NONE
      end


  (* game functions *)
  fun player (State (_, p)) = p

  fun status (State (0, p)) = Over (Winner p)
    | status _              = In_play

  val start = State (15, Maxie)

  fun moves (State (pile , _)) =
    Seq.tabulate (fn x => Move (x + 1)) (Int.min (pile , 3))

  fun flip Maxie  = Minnie
    | flip Minnie = Maxie

  fun make_move (State (pile, player), Move n) =
      if (pile >= n)
        then State (pile - n, flip player)
        else raise Fail "tried to make an illegal move"

  (* cf. Sprague-Grundy theorem *)
  fun estimate (State (pile, p)) =
      case (pile mod 4)
        of 1 => Definitely (Winner (flip p))
         | _ => Definitely (Winner p)

end (* structure Nim *)
