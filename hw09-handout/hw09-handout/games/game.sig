signature GAME =
sig
  datatype player  = Minnie                 (* players *)
		   | Maxie

  datatype outcome = Winner of player       (* outcome of the game *)
		   | Draw

  datatype status  = Over of outcome        (* status of the game *)
		   | In_play

  datatype est     = Definitely of outcome  (* estimate, if in play *)
	           | Guess of int

  type state (* state of the game; e.g. board and player *)
  type move  (* moves *)

  (* printing functions *)
  val player_toString: player -> string
  val outcome_toString: outcome -> string
  val status_toString: status -> string
  val est_toString: est -> string
  val move_toString: move -> string
  val state_toString: state -> string

  (* equality functions *)
  val player_eq: player * player -> bool
  val outcome_eq: outcome * outcome -> bool
  val status_eq: status * status -> bool
  val est_eq: est * est -> bool
  val move_eq: move * move -> bool
  val state_eq: state * state -> bool

  (* parsing functions *)
  (* parse_move: s i ==> m?
     ENSURES: returns move represented by user input i from state s
      - m? is NONE if move is invalid, or i contains a new-line
      - m? is SOME m otherwise
   *)
  val parse_move : state -> string -> move option


  (* game functions *)

  (* initial state *)
  val start: state

  (* status s ==> u
     ENSURES: u is the status of the game in state s
   *)
  val status: state -> status

  (* player s ==> P
     ENSURES: P is who's turn it is to play in state s
   *)
  val player: state -> player

  (* moves s ==> M
     REQUIRES: status s <> Over _
     ENSURES: - M is the collection of valid moves from state s
              - Always generates at least one move
   *)
  val moves: state -> move Seq.seq

  (* make_move (s,m) ==> s'
     REQUIRES: m is a valid move in s
     ENSURES: s' is the state resulting from making move m in s
   *)
  val make_move: state * move -> state (* assumes move is valid in that state *)

  (* The sign of a guess is absolute, rather than relative to whose turn it is:
     negative values are better for Minnie
     and positive values are better for Maxie. *)

  (* estimate the value of the state, which is assumed to be In_play *)
  val estimate: state -> est

end (* signature GAME *)
