(* andrew Id: ______zihanz_____________ *)

structure LookAndSay : LOOKANDSAY =
struct
(*
lasHelp eq s e n=>(s',n')
REQUIRES n>=0
ensures s' is the seq remove all consecutive e
from head 
ensures n-n' = len(s)-len(s')
    *)
    fun lasHelp eq s e n =
        case Seq.showl s of
            Seq.Nil => (Seq.fromList [],n)
            | Seq.Cons(e',s') => 
                if eq(e,e') 
                then lasHelp eq s' e (n+1)
                else (s,n)
(*
lookAndSay eq s = s'
reuqires ture
ensures s' is the lookandsay of s
    *)


    fun lookAndSay eq s=
        case Seq.showl s 
            of Seq.Nil =>  Seq.fromList []
              | Seq.Cons(e,_) =>
              let val (s',n)=lasHelp eq s e 0 in
              Seq. hidel(
                Seq.Cons(
                    (n,e) ,lookAndSay eq s')) end

end (* structure LookAndSay *)
