signature PROP2 =
sig
  structure L: LITERAL

  datatype fla = Var of L.R.letter
               | And of fla Seq.seq
               | Or  of fla Seq.seq
               | Not of fla

  (* toString F ==> s
     ENSURES: s is a string representation of F
   *)
  val toString: fla -> string

  (* eq (F1,F2) ==> b
     ENSURES: b == true iff F1 and F2 are syntactically identical formulas
   *)
  val eq: fla * fla -> bool

  (* pushNot F ==> F'
     ENSURES: F' is a formula equivalent to F where all the negation
              are pushed to the propositional letters.
   *)
  val pushNot: fla -> fla

  (* distribute F ==> F'
     REQUIRES: F has negation in its literals only
     ENSURE: F' is a CNF formula equivalent to F.
   *)
  val distribute: fla -> fla

  (* toCNF F ==> F'
     ENSURES: F' is a CNF formula equivalent to F
   *)
  val toCNF: fla -> L.literal Seq.seq Seq.seq

end (* signature PROP2 *)

