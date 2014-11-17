structure IntinfOrdered : ORDERED =
struct
  type t = IntInf.int
  val compare = IntInf.compare
end (* structure IntinfOrdered *)
