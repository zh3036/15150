datatype 'a tree = Empty
                 | Node of 'a tree * 'a * 'a tree


val _ = Control.Print.printDepth := 100;



(* inorder t ==> l
 * ENSURES: l is the in-order traversal of t
 *)
fun inorder (Empty: 'a tree): 'a list = nil
  | inorder (Node(tL,x,tR)) = (inorder tL) @ (x :: inorder tR)

(*  merge t1 t2=>t
    ensures inorder(t)=inorder(t1)@inorder(t2)
    *)
fun merge (t1: 'a tree, Empty: 'a tree): 'a tree =t1
    | merge (t,Node(t1,_,_))=merge(t,t1)

fun member (x: ''a, nil: ''a list): bool = false
    | member(x,y::l)= 
    case x=y of
        true => true
        | false => member(x,l)

fun indexOf'(x: ''a, nil : ''a list, i : int): int option= NONE
    | indexOf'(x,y::l,i)=
    case x=y of
        true => SOME i
        | false => indexOf'(x,l,i+1)


fun indexOf (x: ''a, l: ''a list): int option = indexOf'(x,l,0)

(*
fun remove1 (x: ''a, l: ''a list): ''a list =
    body*)
fun remove (x: ''a, nil: ''a list): ''a list    = nil
    | remove (x,y::l)=
    case x=y of
        true => remove(x,l)
        | false => y::remove(x,l)
;


datatype direction = L | R

fun removeT (x: ''a, Empty: ''a tree): ''a tree     = Empty
    | removeT (x: ''a, Node(t1,y   ,t2))=
    if x=y   
        then Node(removeT(x,t1),y,removeT(x,t2))
        | true => merge(removeT(x,t1),removeT(x,t2))
(*val a=Empty
val b=Node(a,1,a)
val c=Node(a,2,b)
val d=Node(c,3,a)
val e=Node(d,4,c)
*)
fun path' (x:''a, Empty: ''a tree, l: direction list):direction list option=
    
    | path (x,Node(t1,y,t2),l)=
    case compare of
        true => l
        | false => body2

fun path (x: ''a, t: ''a tree): direction list option = raise Fail "Unimplemented"


;
