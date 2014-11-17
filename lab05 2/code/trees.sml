val _ = Control.Print.printDepth := 100;

datatype 'a tree = Empty
                 | Node of 'a tree * 'a * 'a tree

(* inorder t ==> l
 * ENSURES: l is the in-order traversal of t
 *)
fun inorder (Empty: 'a tree): 'a list = nil
  | inorder (Node(tL,x,tR)) = (inorder tL) @ (x :: inorder tR)

fun merge (t1: 'a tree, t2: 'a tree): 'a tree = raise Fail "Unimplemented"

fun member (x: ''a, l: ''a list): bool        = raise Fail "Unimplemented"

fun indexOf (x: ''a, l: ''a list): int option = raise Fail "Unimplemented"

fun remove (x: ''a, l: ''a list): ''a list    = raise Fail "Unimplemented"
