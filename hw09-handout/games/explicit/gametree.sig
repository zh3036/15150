signature GAMETREE =
sig
  datatype tree = Est  of string * int
		| Node of string * int * tree list

  val toString: tree -> string
  val eq: tree * tree -> bool

end (* signature GAMETREE *)
