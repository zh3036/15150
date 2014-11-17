(* andrew Id: ______zihanz___________________________ *)
(*  type basix = string F.fs
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
*)

(*functor Basix (F: FS) :> BASIX where F=F =*)
functor Basix (F: FS) : BASIX where F=F =
struct
  structure F=F
  open F;
  type basix = string fs
  type path = string list

  fun mkfs s = Dir(s,[])

(*
entnoint(x,y)=>tf
basix* basix list -> bool
ensures 
    if there are same name(content does not matter), 
    then retrun false
    otherwise return true
*)
    fun equName(File(a,_),File(b,_))= (a=b)
      | equName(File(a,_),Dir(b,_))= (a=b)
      | equName(Dir(a,_),File(b,_))= (a=b)
      | equName(Dir(a,_),Dir(b,_))= (a=b)

    fun entnotin(x,[])=true
        | entnotin(x,y::l)=
            if equName(x,y) then false else entnotin(x,l)
        
(*
cp e p sys => sys
 val cp: basix -> path -> basix -> basix
 ensures insert at most one thing, either dir or file
 ensures if same name then do nothing
ensures if path not right do nothing

*)

    fun cp e [] sys = sys
        | cp e p (File(n,d)) = File(n,d)
        | cp e [s] (Dir(n:string,fs))=
        if n=s andalso entnotin(e,fs) then Dir(n,e::fs) else Dir(n,fs)
        | cp e (s::p) (Dir(n:string,fs))=
        if n = s then
            Dir(n,List.map (fn x=>cp e p x) fs)
        else
            Dir(n,fs)


      val a = File ("a","asd")
      val c = Dir ("c",[File ("a","asd")]) : string fs
      val a = Dir ("a",[a])
      val b = cp a ["root"] (mkfs "root")
      val Dir ("root",[Dir ("a",[Dir ("c",[File ("a","asd")]),File ("a","asd")])]) = cp c ["root","a"] b
      val Dir ("root",[Dir ("a",[File ("a","asd")])]) = cp a ["root","a"] b

(*

mkdir d p sys=>sys'
  ensures if p exist, and no d in p exsit, then sys' will have 
    one more empty dir with name d.
  *)
    
    fun mkdir d p sys = 
        cp (Dir(d,[])) p sys

(*mkfile d p sys=>sys'
  ensures if p exist, and no d in p exsit, then sys' will have 
    one more empty file with name d.
  *)

    fun mkfile (n,c) p sys=
        cp (File(n,c)) p sys


(*

mkdir d p sys=>sys'
  ensures sys' will have path p, iff p start with the name of sys
  *)
    
    fun mkdir_p (n2::p) sys = 
        let 
            fun mkdir_p' [] tp sys = sys
                | mkdir_p' (d::p) tp (Dir(n,fs)) = 
                    mkdir_p' p (tp@[d]) (mkdir d tp (Dir(n,fs)))
                | mkdir_p' _ _ sys = sys
        in
            mkdir_p' p [n2] sys
            (*Dir(n,fs)*)
        end
        | mkdir_p _ sys=sys

val a =mkfs "root"
val Dir ("root",[Dir ("a",[Dir ("b",[])])])= mkdir_p ["root","a","b"] a


(*
hasname n,sys=>b
ensures b iff sys has name n
  *)
    fun hasname(n,Dir(m,_)):bool = 
        if n = m then true else false
        | hasname(n,File(m,_)):bool = 
        if n = m then true else false

    fun getname(Dir(m,_)) = m
        | getname(File(m,_))= m
(*
exec f p sys=>x;
ensures if sys has p, then x is not NONE
  *)
    fun exec f [n] (Dir(m,con)) = 
            if n=m then SOME (f(Dir(m,con))) else NONE
        (*|  exec f (n::n2::p) (Dir(_,[])) = NONE*)
        |  exec f (n::n2::p) (Dir(m,fs::con)) = 
            if (not(n=m)) then NONE 
            else
                if hasname(n2,fs) 
                then 
                    exec f (n2::p) fs
                else
                    exec f (n::n2::p) (Dir(m,con))
        | exec _ _ _ = NONE


 fun f (Dir(s,_))=s
     | f _ = raise Fail "asd"
val b=Dir ("r",[Dir ("a",[Dir ("b",[])])])
(*val k = exec f ["r","a"] b*)
 val  SOME "b"= exec f ["r","a","b"] b;
 val NONE = exec f ["r","b"] b

(*
ls p sys=>con
ensures if p exist in sys, then con is not nil
  *)
    fun ls p sys = 
        let 
            fun show(Dir(n,con))=List.map getname con
                | show(File(n,_))=[n]
                (*| show _ = []*)
            val out=exec show p sys
        in
            case out of
                NONE => []
                | SOME k => k
        end

      val a = File ("a","asd")
      val c = Dir ("c",[File ("a","asd")]) : string fs
      val a = Dir ("a",[a])
      val b = cp a ["root"] (mkfs "root")
    (*val ["a"]=ls ["root","a"] b*)
    val ["a"]=ls ["root","a"] b



(*
grep_r f sys =>list
  ensures if sys has entry name f, list will contain these entries
  *)

    fun grep_r f sys= 
        let 
            fun satisfyFile(n,con)=
                if f(con) then [n] else []
            fun convertList(_,dl)=List.foldr (op@) [] dl
        in
            reduce satisfyFile convertList sys
        end

val b= mkfile ("k","asd") ["root"] b;
val b= mkfile ("j","asd") ["root","a"] b;
val b= mkfile ("m","fasd") ["root","a"] b;
val f = fn x=> if x="asd" then true else false;
val ["k","j","a"]=grep_r f b;

(*grep_r f sys =>list
  ensures if sys has entry name f, list will contain these entries' path
  *)

    fun grep_rl f sys= 
        let 
            fun satisfyFile(n,con)=
                if f(con) then [[n]] else []
            fun convertList(n,dl)=
                List.map (fn x=>n::x) (List.foldr (op@) [] dl)
        in
            reduce satisfyFile convertList sys
        end
val [["root","k"],["root","a","j"],["root","a","a"]]=grep_rl f b;


end (* functor Basix *)
