signature LITERAL =
sig
  structure R : LETTER
  datatype literal = Pos of R.letter
                   | Neg of R.letter

  (* toString F ==> s
     ENSURES: s is a string representation of F
   *)
  val toString: literal -> string

  (* eq (F1,F2) ==> b
     ENSURES: checks that F1 and F2 are the same literal.
   *)
  val eq: literal * literal -> bool
end (* signature LITERAL *)
