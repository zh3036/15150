datatype tree = empty
	| node of (tree * int * tree)


(*
inorder(x)==>y
requires: x is a tree
ensures: y is the list contains all the number of nodes in x.
	*)

fun inorder (empty: tree): int list = []
	| inorder (node(t1,x,t2))      = 
  		inorder(t1)@(x::inorder(t2))

val a= empty;
val b= node(a,1,a);
val c= node(b,5,a);
val d= node(c,5,b);
val [1,5,5,1]=inorder(d)

(*
size(x)==>y
requires x is tree
ensures y is the size of the tree x.

	*)

fun size (empty) = 0
	| size(node(t1,_,t2))=
		1+size(t1)+size(t2) 

val 4 = size(d)



;