structure IntinfPrintable : PRINTABLE =
struct
  type t = IntInf.int
  val toString = IntInf.toString
end (* structure IntinfPrintable *)
