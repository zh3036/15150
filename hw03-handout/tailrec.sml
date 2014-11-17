(* qatar Id:zihanz *)

(*
* mult(x)=>y
* requires true
* ensures y is the mutlple of all elem in x
* *)
fun mult([]:int list):int =1
  | mult(a::l)=a*mult(l)
val 24 = mult([1,2,3,4])


(*
* multTail(x)==>y
* requires true
* ensure s multTail(x)=mult(x)
*)
fun multT([]:int list,x:int):int=x
  | multT(a::l,x)=multT(l,a*x)
fun multTail(l:int list):int=multT(l,1)

val 24 = multTail([1,2,3,4])

(* evenTail(x)==>y
* requires true
* ensures y is a list of parities of number is x
*)

fun evenTail'([]:int list,k:int list):int list=k
  | evenTail'(a::l,k)=evenTail'(l,k@[(a mod 2)])
fun evenTail(l:int list):int list=evenTail'(l,[])
val [1,0,1]=evenTail([3,4,5])
(* even(x)==>y
* requires true
* ensure y is a list parityeis fo number in x
*)
fun even([]:int list):int list= [] 
  | even(a::l)=(a mod 2)::even(l)
val [1,0,0]=even([3,4,4])

(* evenTailFast(x)==>y
* requires true
* ensures eventailfast(x)=eventail(x)
*)

fun reverse([]:int list,k:int list):int list=k
  | reverse(a::l,k)=reverse(l,a::k)
fun evenTF([]:int list,k:int list):int list=k
  | evenTF(a::l,k)=evenTF(l,((a mod 2)::k)) 
fun evenTailFast(l:int list):int list =reverse(evenTF(l,[]),[])
val [1,0,0]=evenTailFast([3,4,4])

datatype tree = Leaf of int
              | Node of tree * tree

              
(*treeProd(x)-->y
* requires: true
* ensures y is the mutiple of all leaf of x
*)
fun treeProd(Leaf(z):tree):int = z
  | treeProd(Node(t1,t2))=treeProd(t1)*treeProd(t2)

val a:tree=Leaf(2)
val b:tree=Leaf(3)
val c:tree=Node(a,Node(a,b))
val 12=treeProd(c)
  
