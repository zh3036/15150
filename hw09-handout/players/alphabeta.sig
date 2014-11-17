signature ALPHABETA =
sig
  structure Game : GAME
  structure EstOrd: ORDERED_EXT where type t = Game.est

  type edge = Game.move * Game.est
 
  datatype value = BestEdge of edge
		 | Pruned

  type alphabeta = value * value (* invariant: alpha < beta *)

  datatype result = Value of value
		  | ParentPrune   (* an evaluation result *)

  val search_depth: int
  val edge_toString:      edge      -> string
  val value_toString:     value     -> string
  val result_toString:    result    -> string
  val alphabeta_toString: alphabeta -> string
  val edge_eq:      edge      * edge      -> bool
  val value_eq:     value     * value     -> bool
  val alphabeta_eq: alphabeta * alphabeta -> bool
  val result_eq:    result    * result    -> bool

  val updateAB: Game.state -> alphabeta -> value -> alphabeta
  val value_for: Game.state -> alphabeta -> value
  val check_bounds: alphabeta -> Game.state -> Game.move -> Game.est -> result
  val evaluate: int -> alphabeta -> Game.state -> Game.move         -> result
  val search:   int -> alphabeta -> Game.state -> Game.move Seq.seq -> value
  val next_move: Game.state -> Game.move
end (* signature ALPHABETA *)
