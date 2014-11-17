signature BASIX =
sig
  structure F: FS

  type basix = string F.fs
  type path = string list

  val mkfs: string -> basix
  val cp: basix -> path -> basix -> basix
  val mkdir: string -> path -> basix -> basix
  val mkfile: string * string -> path -> basix -> basix
  val mkdir_p: path -> basix -> basix

  val exec: (basix -> 'a) -> path -> basix -> 'a option
  val ls: path -> basix -> string list

  val grep_r: (string -> bool) -> basix -> string list
  val grep_rl: (string -> bool) -> basix -> path list
end (* signature BASIX *)

