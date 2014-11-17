functor EstimateLE (G : GAME): RELATION =
struct
  type t = G.est

  fun r (x,y) =
     x=y orelse
     case (x,y)
       of (G.Definitely (G.Winner G.Minnie), _)                               => true
        | (_,                                G.Definitely (G.Winner G.Maxie)) => true
        | (G.Guess x,                        G.Definitely G.Draw)             => x <= 0
        | (G.Definitely G.Draw,              G.Guess x)                       => 0 <= x
        | (G.Guess x,                        G.Guess y)                       => x <= y
        | (_,                                _)                               => false
end (* functor EstimateLE *)


functor EstOrdered (G: GAME): ORDERED = LEOrdered (EstimateLE (G))
