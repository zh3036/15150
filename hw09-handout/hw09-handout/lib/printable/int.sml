structure IntPrintable : PRINTABLE =
struct
  type t = int
  val toString = Int.toString
end (* structure IntPrintable *)
