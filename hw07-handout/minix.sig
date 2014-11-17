signature MINIX =
sig
  structure B: BASIX

  type meta = string * int
  type minix = meta B.F.fs
  type path = B.path

  val basix2minix: B.basix -> minix
  val minix2basix: minix -> B.basix
  val du: minix -> int

  val mkfs: string -> minix
  val cp: minix -> path -> minix -> minix
  val mkdir: string -> path -> minix -> minix
  val mkfile: string * string -> path -> minix -> minix
  val mkdir_p: path -> minix -> minix

  val exec: (minix -> 'a) -> path -> minix -> 'a option
  val ls: path -> minix -> string list

  val grep_r: (string -> bool) -> minix -> string list
  val grep_rl: (string -> bool) -> minix -> path list
end (* signature MINIX *) 
