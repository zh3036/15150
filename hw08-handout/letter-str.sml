structure StrLetter : LETTER =
struct
  type letter = string

  val toString = (fn s => s)
  val eq       = (op=)
  val cmp      = String.compare
end (* structure StrLetter *)
