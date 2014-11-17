structure IntLetter : LETTER =
struct
  type letter = int

  fun toString l = "V" ^ Int.toString l
  val eq       = (op=)
  val cmp      = Int.compare
end (* structure IntLetter *)
