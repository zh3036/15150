structure IntOrdered : ORDERED =
struct
  type t = int
  val compare = Int.compare
end (* structure IntOrdered *)
