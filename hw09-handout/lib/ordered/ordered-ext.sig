signature ORDERED_EXT =
sig
  include ORDERED

  (* these return the first argument when the two are EQUAL *)
  val min: t * t -> t
  val max: t * t -> t

  val le: t * t -> bool
  val ge: t * t -> bool
  val lt: t * t -> bool
  val gt: t * t -> bool
  val eq: t * t -> bool
end (* signature ORDERED_EXT *)
