signature MATRIX =
sig
  structure E: ELT
  structure Vec: INFVEC where E = E
  type matrix

  val toString: matrix -> string
  val eq:       matrix * matrix -> bool

  val toMat:    E.t list list -> matrix
  val toLists:  matrix -> E.t list list

  val vProd:    matrix * Vec.infvec -> Vec.infvec
  val add:      matrix * matrix -> matrix
  val mult:     matrix * matrix -> matrix
end
