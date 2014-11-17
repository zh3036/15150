functor PairPrintable (structure P1: PRINTABLE
                       structure P2: PRINTABLE) : PRINTABLE =
struct
  type t = P1.t * P2.t
  fun toString (x,y) = "(" ^ P1.toString x ^ ", " ^ P2.toString y ^ ")"
end (* functor PairPrintable *)
