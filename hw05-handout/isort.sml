(* qatar Id: _Zihan Zhou______ *)

(*********************** Insertion sort on lists ***********************)

(* insert(x, l) ==> l'
 * REQUIRES: sorted l
 * ENSURES:
    - isPermutation (x::l, l')
    - sorted l'
 *)
fun insert (x: int, []: int list): int list = [x]
  | insert (x, y::l) =
     if x <= y
       then x::y::l
       else y :: insert (x, l)

(* isort l ==> l'
 * ENSURES:
    - isPermutation (l, l')
    - sorted l'
 *)
fun isort ([]: int list): int list = []
  | isort (x::l) = insert (x, isort l)


  

(*********************** Insertion sort on trees ***********************)

datatype 'a tree = empty
                 | node of 'a tree * 'a * 'a tree


(***** Begin utility functions *****)

(* sorted l ==> b
   ENSURES: b = true iff l is sorted in ascending order
 *)
fun sorted ([]: int list): bool = true
  | sorted [_] = true
  | sorted (x::y::l) = x <= y andalso sorted (y::l)

(* inorder t ==> l
 * ENSURES: l is the inorder traversal of t
 *)
fun inorder (empty: 'a tree): 'a list = []
  | inorder (node(tL, x, tR)) = (inorder tL) @ (x :: inorder tR)

(* Insert (x, t) ==> t'
 * REQUIRES: sorted (inorder t)
 * ENSURES:
    - isPermutation (x::inorder t, inorder t')
    - sorted (inorder t')
 *)
fun Insert (x: int, empty: int tree): int tree = node(empty, x, empty)
  | Insert (x, node(tL,y,tR)) =
     if x <= y
       then node (Insert (x, tL), y, tR)
       else node (tL, y, Insert (x, tR))

(****** End utility functions ******)
(*ILsort' (L:int list)==>T
Requires: true
Ensures: sorted(inorder(T))
  *)
fun ILsort' ([])= empty 
    | ILsort' (x::L)=Insert(x,ILsort'(L))
(*
ILsort t ==>T
requires true
ensures: sorted(inorder(T))
  *)
fun ILsort t = ILsort'(inorder(t))

val x=empty
val a=node(x,1,x)
val b=node(a,2,x)
val c=node(a,3,b)
val d=node(c,4,b)
val s=ILsort(d)
val [1,1,1,2,2,3,4]=inorder(s)

(*
Isort t= T
requires true
ENsures sorted(inorder(T))
  *)
fun Isort'(empty,t)=t
    | Isort'(node(tl,x,tr),T) = Isort'(tl,(Isort'(tr,(Insert(x,T)))))
fun Isort(t)=Isort'(t,empty)
val x=empty
val a=node(x,1,x)
val b=node(a,2,x)
val c=node(a,3,b)
val d=node(c,4,b)
val s=Isort(d)
val l=inorder(s)
val [1,1,1,2,2,3,4]=l
;
