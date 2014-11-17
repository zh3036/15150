(* andrew Id: _________________________________ *)

functor MakeConnect4 (val num_cols: int
                      val num_rows: int): CONNECT4 =
struct
  datatype player  = Minnie
		   | Maxie

  datatype outcome = Winner of player
		   | Draw

  datatype status  = Over of outcome
		   | In_play

  datatype est     = Definitely of outcome
	           | Guess of int

  datatype position = Filled of player
		    | Empty

  (* (0,0) is bottom-left corner *)
  datatype c4state = Unimplemented (* use in starter code only *)
		   | S of (position Matrix.matrix) * player
  type state = c4state

  type move = int (* cols are numbered 0 ... num_cols-1 *)

  val num_cols = num_cols
  val num_rows = num_rows

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

  fun pos_toString (Filled Minnie) = "O"
    | pos_toString (Filled Maxie)  = "X"
    | pos_toString Empty           = " "

  fun state_toString (board as (S (m, _))) =
      let
        val rows = Matrix.rows m
        val ts : string Seq.seq -> string = Seq.reduce op^ ""
        fun print_row s =
            "|" ^ ts (Seq.map (fn x => pos_toString x ^ "|") s) ^ "\n"
      in
          " " ^ ts (Seq.tabulate (fn i => Int.toString i ^ " ") num_cols)
          ^ "\n" ^
          "-" ^ ts (Seq.tabulate (fn _ => "--") num_cols) ^ "\n" ^
          Seq.mapreduce print_row "" (fn (x,y) => y^x) rows ^ "\n"
      end
    | state_toString Unimplemented = raise Fail "Incomplete implementation"


  (* equality functions *)
  val player_eq  = (op=)
  val outcome_eq = (op=)
  val status_eq  = (op=)
  val est_eq     = (op=)
  val move_eq    = (op=)

  fun pos_eq (Filled p1, Filled p2) = p1=p2
    | pos_eq (Empty, Empty) = true
    | pos_eq _ = false

  fun state_eq (S (m1,p1), S (m2,p2)) =
    Matrix.eq pos_eq (m1,m2) andalso p1=p2


  (* parsing functions *)
  fun lowestFreeRow _ = raise Fail "Unimplemented"

  fun parse_move st input =
     case Int.fromString input
       of SOME i => if i < num_cols
                     then
		       case lowestFreeRow st i
			 of SOME _ => SOME i
                          | _      => NONE
                     else NONE
        | NONE => NONE


  val start       = Unimplemented  (* Change me *)
  fun status    _ = raise Fail "Unimplemented"
  fun player    _ = raise Fail "Unimplemented"
  fun moves     _ = raise Fail "Unimplemented"
  fun make_move _ = raise Fail "Unimplemented"
  fun estimate  _ = raise Fail "Unimplemented"

end (* functor Connect4 *)


