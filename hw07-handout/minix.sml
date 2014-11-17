(* andrew Id: ______zihanz__________ *)

functor Minix (F: BASIX): MINIX where B = F =
struct
  structure B = F

  type meta = string * int
  type minix = meta B.F.fs
  type path = B.path

(*
basix2minix sys=>msys
ensures msys and sys has same content
  *)

    fun basix2minix sys = 
        B.F.map (fn(n,s)=>((n,String.size s),s)) (fn x=>(x,1024)) sys

val b =
  B.F.Dir
    ("root",
     [B.F.File ("k","asd"),
      B.F.Dir ("a",[B.F.File ("m","fasd"),B.F.File ("j","asd"),B.F.File ("a","asd")])])

val B.F.Dir
    (("root",1024),
     [B.F.File (("k",3),"asd"),
      B.F.Dir
        (("a",1024),
         [B.F.File (("m",4),"fasd"),B.F.File (("j",3),"asd"),B.F.File (("a",3),"asd")])])
=basix2minix b

val c = basix2minix b;
(*
  minix2basix sys =>bsys
ensures bsys contain same thing as sys
  *)
      fun minix2basix sys = 
        B.F.map (fn((f,len),s)=>(f,s)) (fn (x,len)=>x) sys

val true = (b = minix2basix c)
(*
  du sys=>n
  ensures n is the size of sys*)
    fun du sys = 
        B.F.reduce (fn((f,len),s)=>len) 
            (fn((f,len),dl)=>List.foldr (op+) len dl) sys

val 2061=du c;

    (*fun mkfs s=basix2minix (B.mkfs s)*)
    val mkfs = basix2minix o B.mkfs



(*
cp e p sys => sys
 val cp: basix -> path -> basix -> basix
 ensures insert at most one thing, either dir or file
 ensures if same name then do nothing
ensures if path not right do nothing

    *)
  fun cp e p sys = 
    basix2minix (B.cp (minix2basix e) p (minix2basix sys))
(*

mkdir d p sys=>sys'
  ensures if p exist, and no d in p exsit, then sys' will have 
    one more empty dir with name d.
  *)
  fun mkdir d p sys=
          basix2minix(B.mkdir d p (minix2basix sys))

(*mkfile d p sys=>sys'
  ensures if p exist, and no d in p exsit, then sys' will have 
    one more empty file with name d.
  *)
  fun mkfile  f p sys=
    basix2minix(B.mkfile f p (minix2basix sys))

(*

mkdir d p sys=>sys'
  ensures sys' will have path p, iff p start with the name of sys
  *)
  fun mkdir_p  p sys =
    basix2minix(B.mkdir_p p (minix2basix sys))
(*
exec f p sys=>x;
ensures if sys has p, then x is not NONE
  *)
  fun exec f p sys = 
    B.exec ( f o basix2minix) p (minix2basix sys)
(*
ls p sys=>con
ensures if p exist in sys, then con is not nil
  *)
  fun ls p sys=
    B.ls p (minix2basix sys)
(*grep_r f sys =>list
  ensures if sys has entry name f, list will contain these entries*)

  fun grep_r   f sys =
    B.grep_r f (minix2basix sys)
(*grep_r f sys =>list
  ensures if sys has entry name f, list will contain these entries' path*)

  fun grep_rl   f sys = 
    B.grep_rl f (minix2basix sys)
end (* functor Minix *)
