functor Jamboree (structure G : GAME
                  val search_depth : int
                  val prune_percentage : real)
        : PLAYER where type Game.move = G.move
                 where type Game.state = G.state =
struct
structure J = MakeJamboree (structure G = G
                            val search_depth = search_depth
			    val prune_percentage = prune_percentage)
  open J
end (* functor Jamboree *)
