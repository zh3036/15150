signature INFVEC =
sig
  structure E : ELT
  type infvec

  val toString:  infvec -> string
  val valid:     infvec -> bool
  val eq:        infvec * infvec -> bool

  val toVec:     E.t list -> infvec
  val toList:    infvec -> E.t list

  val iszero:    infvec -> bool
  val flatat:    infvec -> int
  val component: infvec * int -> E.t

  val add:       infvec * infvec -> infvec
  val scale:     E.t * infvec -> infvec
  val convolve:  infvec * infvec -> infvec

  val filter:    (E.t -> bool) -> infvec -> infvec
end (* signature INFVEC *)
