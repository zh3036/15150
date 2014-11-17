structure Binary : ARITHMETIC =
struct
   
   (* Given these two types, implement the rest of the functions *)
   type digit = int (* uses 0, 1 *)
   type integer = digit list
   
   fun rep _ = raise Fail "unimplemented"


   (* adding two base 2 numbers together *)
   (* hint : you may need a helper function to determine carrys*)
   fun add _ = raise Fail "unimplemented"
   
   (* multiply two base 2 numbers together *)
   (* hint : you may want to use a helper function that has spec : *)
   (* digit -> integer -> integer *)

   fun mult _ = raise Fail "unimplemented"

   (* the display function, which may help while debugging *)
   fun display L =  foldl (fn (d, s) => Int.toString d ^ s) "" L
   
   (* the toInt function, which may help with testing *)
   fun pow(b,e) = if (e = 0) then 1 else (b * pow(b,e-1))

   fun toInt L =
     let
        fun toIntHelper(m, i) =
           case m of
              [] => 0
           |  x :: xs => (x * pow(2,i)) + toIntHelper(xs, i+1)
     in
        toIntHelper(L,0)
     end 
               
end

