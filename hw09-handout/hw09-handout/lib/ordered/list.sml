functor ListOrdered (O : ORDERED) : ORDERED = 
struct
    type t = O.t list 

    fun compare ([], []) = EQUAL
      | compare ([],  _) = LESS
      | compare (_ , []) = GREATER
      | compare (x::xs, y::ys) =
	case O.compare(x,y)
	  of LESS    => LESS
           | EQUAL   => compare(xs,ys)
           | GREATER => GREATER
end (* functor ListOrdered *)
