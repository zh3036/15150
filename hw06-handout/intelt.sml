structure IntElt : ELT =
struct
  type t = int
  val zero = 0
  val p = op+
  val m = op*
  fun z x = x=0
  val toString = Int.toString
  val eq = op=
end
