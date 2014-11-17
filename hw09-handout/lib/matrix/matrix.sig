signature MATRIX =
sig
  structure Seq : SEQUENCE

  type 'a matrix

  (* coordinates are always (column, row), or (width, height)
     e.g. Matrix.repeat - (x, y) 
     makes a matrix with x columns and y rows

     width = number of columns
     height = number of rows
  *)

  (* Returns (width, height) of the matrix *)
  val size : 'a matrix -> (int * int)
  (* Returns the value of the matrix at the given subscripts (indexed from 0) *)
  val sub  : 'a matrix -> (int * int) -> 'a
  
  (* Returns the matrix with the given dimensions and the given value at each
   * position. *)
  val repeat : 'a -> (int * int) -> 'a matrix

  (* tabulate f (w, h) returns the matrix with the given dimensions such that
   * the value in position (i,j) is f(i,j) where (i, j) is (col, row) *)
  val tabulate : (int * int -> 'a) -> (int * int) -> 'a matrix
  (* maps the given function to each value in the matrix *)
  val map : ('a -> 'b) -> 'a matrix -> 'b matrix

  (* Returns the matrix with the value at the given subscript updated to the
   * given value *)
  val update : 'a matrix -> ((int * int) * 'a) -> 'a matrix

  (* Returns the subscripts of the elements in the matrix for which the given
   * predicate evaluates to true *)
  val matching_subs : ('a -> bool) -> 'a matrix -> (int * int) Seq.seq

  (* Returns the sequence of rows in the matrix *)
  val rows : 'a matrix -> ('a Seq.seq) Seq.seq
  (* Returns the sequence of columns in the matrix *)
  val cols : 'a matrix -> ('a Seq.seq) Seq.seq

  (* Returns the matrix from a sequence of rows *)
  val from_rows : ('a Seq.seq) Seq.seq -> 'a matrix 
  (* Returns the sequence from a sequence of columns *)
  val from_cols : ('a Seq.seq) Seq.seq -> 'a matrix

  (* diags1 and diags2 returns the two sequences of diagonals in the matrix,
   * from bottom left to top right and from top left to bottom right. *)
  val diags1 : 'a matrix -> ('a Seq.seq) Seq.seq
  val diags2 : 'a matrix -> ('a Seq.seq) Seq.seq

  (* printing and equality functions *)
  val toString: ('a -> string) -> 'a matrix -> string
  val eq: ('a * 'a -> bool) -> 'a matrix * 'a matrix -> bool
end
