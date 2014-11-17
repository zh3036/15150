signature SEQUTIL =
sig
  (* assume sequence is non-empty *)
  val reduce1: ('a * 'a -> 'a) -> 'a Seq.seq -> 'a

  val filtermap: ('a -> 'b option) -> 'a Seq.seq -> 'b Seq.seq

  val max: ('a * 'a -> order) -> 'a -> 'a Seq.seq -> 'a
end (* signature SEQUTIL *)
