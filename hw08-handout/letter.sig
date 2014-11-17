signature LETTER =
sig
  type letter

  (* toString l ==> s
     ENSURES: s is a string representation of l
   *)
  val toString: letter -> string

  (* eq (l1,l2) ==> b
     ENSURES: b == true iff l1 and l2 are the same propositional letter
   *)
  val eq: letter * letter -> bool

  (* cmp (l1,l2) ==> o
     ENSURES: o is the ordering between l1 and l2
   *)
  val cmp: letter * letter -> order
end (* signature LETTER *)
