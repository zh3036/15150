signature ASSIGNMENT =
sig
  structure R: LETTER
  type assignment = (R.letter * bool) Seq.seq

  (* toString A ==> s
     ENSURES: s is a string representation of A
   *)
  val toString: assignment -> string

  (* eq (A1,A2) ==> b
     ENSURES: b == true iff A1 and A2 assign the same truth
              values to each letter in them
   *)
  val eq: assignment * assignment -> bool

  (* valid A ==> b
     ENSURES: checks the underlying representation invariant.
   *)
  val valid: assignment -> bool

  (* fromList (P,N) ==> A
     REQUIRES: P and N have no common elements
     ENSURES: A is the assignment of true to all letters in P
              and of false to all letters in N
   *)
  val fromList: R.letter list * R.letter list -> assignment

  (* toList A ==> (P,N)
     ENSURES: P is the list of the positive literals in A and
              L is the list of its negative literals
   *)
  val toList: assignment -> R.letter list * R.letter list

  (* eval l A ==> b
     REQUIRES: l occurs in A
     ENSURES: b is the truth value of l in A
   *)
  val eval: R.letter -> assignment -> bool

  (* genAll L ==> As
     REQUIRES: L does not contain duplicates
     ENSURES: L is the list of all possible truth assignments
              for the letters igenn L
   *)
  val genAll: R.letter Seq.seq -> assignment Seq.seq
end (* signature ASSIGNMENT *)
