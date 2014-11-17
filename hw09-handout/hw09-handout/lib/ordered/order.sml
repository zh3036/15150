functor LEOrder (X : sig
                         type t
                         val le : t * t -> bool
                     end) : ORDERED =
struct
    type t = X.t
    fun compare(x,y) =
        case (X.le(x,y), X.le(y,x)) of
            (true,true) => EQUAL
          | (true,false) => LESS
          | (false,true) => GREATER
          | (false,false) => raise Fail "LEOrder: no relationship"
end



