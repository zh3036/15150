structure UnitPrintable : PRINTABLE =
struct
  type t = unit
  fun toString () = "()"
end (* structure UnitPrintable *)
