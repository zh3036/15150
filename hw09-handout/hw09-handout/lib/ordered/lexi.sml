functor Lexi (structure O1 : ORDERED
              structure O2 : ORDERED) : ORDERED = 
struct
  type t = O1.t * O2.t

  fun compare ((x,y), (x',y')) = 
    case O1.compare(x,x') 
     of LESS    => LESS
      | EQUAL   => O2.compare(y,y')
      | GREATER => GREATER    
end (* functor Lexi *)
