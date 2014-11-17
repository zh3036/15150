signature FS =
sig
  type data = string
  datatype 'a fs = File of 'a * data        (* (metadata, file content) *)
		 | Dir  of 'a * 'a fs list  (* (metadata, dir contents) *)

  val map: ('a * string -> 'b * string) -> ('a -> 'b) -> 'a fs -> 'b fs
  val reduce: ('a * string -> 'b) -> ('a * 'b list -> 'b) -> 'a fs -> 'b
  val count: 'a fs -> int * int
end (* signature FS *)
