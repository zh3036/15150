(* qatar Id: ____zihan_____________________________ *)

(* lasHlep(l,x,c)->(l2,c')
* requires true or c>=0 depends on your need
* ensures l2 is the list remove all consecutive x from head
* of l, and c = len(l)-len(l2)+c
*)
fun lasHelp([]:int list,_:int,c:int):(int list)*int=([],c)
  | lasHelp(a::l,x,c)=
  case a=x
    of true => lasHelp(l,x,c+1)
     | false=> (a::l,c)
val ([1,2,3],2)=lasHelp([4,4,1,2,3],4,0)
(* lookAndSay(l)=l2
* requires true
* ensures l2 is the look and say list of l
*)
fun lookAndSay([]:int list):int list = []
  | lookAndSay(a::l)=
  let val (l',c)=lasHelp(a::l,a,0)
  in 
    c::a::lookAndSay(l')
  end
val [2,3,3,2,1,1] = lookAndSay([3,3,2,2,2,1]);
