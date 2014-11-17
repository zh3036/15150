functor FlipOrder(O : ORDERED) : ORDERED =
struct
  type t = O.t
  fun compare p = case O.compare p
                    of LESS    => GREATER
                     | EQUAL   => EQUAL
                     | GREATER => LESS
end (* functor FlipOrder *)
