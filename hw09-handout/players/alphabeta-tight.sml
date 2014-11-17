functor AlphaBeta (structure G : GAME
                   val search_depth : int)
        : PLAYER where type Game.move = G.move
                 where type Game.state = G.state =
struct
structure AB = MakeAlphaBeta (structure G = G
		              val search_depth = search_depth)
  open AB
end
