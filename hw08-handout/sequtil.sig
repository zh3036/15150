signature SEQUTIL =
sig
  (* uniquify cmp s ==> s'
     ENSURES: s' contains all the elements in s without duplicates
   *)
  val uniquify: ('a * 'a -> order) -> 'a Seq.seq -> 'a Seq.seq

  (* permeq (S1,S2) ==> b
     ENSURES: b == true iff S1 and S2 are equal up to permutation
   *)
  val permeq: ('a * 'a -> bool) -> 'a Seq.seq * 'a Seq.seq -> bool

  (* par2 f (x1,x2) ==> (y1,y2)
     ENSURES: apply f to x1 and x2 in parallel obtaining y1 and y2.
   *)
  val ppar: ('a -> 'b) -> 'a * 'a -> 'b * 'b

  (* all bs ==> b
     ENSURES: b == true iff all elements in bs are true
   *)
  val all:  bool Seq.seq -> bool

  (* some bs ==> b
     ENSURES: b == true iff at least one element in bs is true
   *)
  val some: bool Seq.seq -> bool

end (* signature SEQUTIL *)
