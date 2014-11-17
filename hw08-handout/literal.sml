functor Literal (R: LETTER) :> LITERAL where R=R =
struct
  structure R = R

  datatype literal = Pos of R.letter
                   | Neg of R.letter

  (* toString F ==> s
     ENSURES: s is a string representation of F
   *)
  fun toString (Pos l) =       R.toString l
    | toString (Neg l) = "~" ^ R.toString l

  (* eq (F1,F2) ==> b
     ENSURES: checks that F1 and F2 are the same literal.
   *)
  fun eq (Pos l1, Pos l2) = R.eq (l1,l2)
    | eq (Neg l1, Neg l2) = R.eq (l1,l2)
    | eq _ = false

end (* structure Literal *)
