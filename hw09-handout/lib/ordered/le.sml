functor LEOrdered (R: RELATION) : ORDERED =
struct
  type t = R.t
  fun compare(x,y) =
   case (R.r(x,y), R.r(y,x))
     of (true,  true)  => EQUAL
      | (true,  false) => LESS
      | (false, true)  => GREATER
      | (false, false) => raise Fail "LEOrdered: no relation"
end (* functor LEOrdered *)
