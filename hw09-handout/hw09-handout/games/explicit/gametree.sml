structure GameTree : GAMETREE =
struct
  datatype tree = Est  of string * int
		| Node of string * int * tree list

  fun toString (Est (s,i)) = s
    | toString (Node(s,_,_)) = s

  val eq = (op=)
end (* structure GameTree *)
