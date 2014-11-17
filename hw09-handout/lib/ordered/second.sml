functor Pair2Ordered (structure Left  : ORDERED
                      structure Right : ORDERED): ORDERED =
struct
    type t = Left.t * Right.t
    fun compare ((_ , x) , (_ , y)) = Right.compare (x,y)
end (* functor Pair2Ordered *)
