structure UnitOrdered : ORDERED =
struct
  type t = unit
  fun compare _ = EQUAL
end (* structure UnitOrdered *)
