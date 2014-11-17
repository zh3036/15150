signature ELT =
sig
  type t
  val zero:     t
  val p:        t * t -> t
  val m:        t * t -> t
  val z:        t -> bool
  val toString: t -> string
  val eq:       t * t -> bool
end

