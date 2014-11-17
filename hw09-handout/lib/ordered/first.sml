functor Pair1Ordered (structure Left  : ORDERED
                      structure Right : ORDERED) : ORDERED =
struct
    type t = Left.t * Right.t
    fun compare ((x , _) , (y , _)) = Left.compare (x,y)
end (* functor Pair1Ordered *)
