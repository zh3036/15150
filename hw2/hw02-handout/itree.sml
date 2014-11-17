(* qatar Id:zihanz *)

datatype tree = Empty
    | Leaf of string
    | Node of tree * tree

datatype itree = iEmpty
    | iLeaf of string
    | iNode of itree * int * itree


val t = Node (Leaf "b",Node (Empty,Leaf "a")) : tree
val t' = iNode (iLeaf "b",0,iNode (iEmpty,1,iLeaf "a")) : itree
(*
iSize(x)==>y
REQUIRES:true
ENSURES: y is the size of x
    *)

fun iSize(iEmpty) :int = 0
    | iSize(iLeaf(_))= 1
    | iSize(iNode(t1,_,t2))=iSize(t1)+iSize(t2)

val 2=iSize(t')
(*
validate(x)==>y
REQUIRES true
ENSURES if x is valid itree then y is true if x is not y is false
    *)

fun validate(iEmpty):bool = true
    | validate(iLeaf(_))=true
    | validate(iNode(tl,i,tr)) = validate(tl) andalso validate(tr) 
     andalso (i=iSize(tr)-iSize(tl))

val true=validate(t')
(*
instrument(x)==>y
REQUIRES true
ENSURES y is a valid itree that is correpoding to x
    *)
fun instrument (Empty):itree = iEmpty
    | instrument(Leaf str)=iLeaf str
    | instrument(Node(tl,tr))=iNode(instrument tl,
        iSize(instrument tr)-iSize(instrument tl),instrument tr)

val true= (t'=instrument(t))
(*
iSize'(x)==>y
REQUIRES validate(x)
ENSRES y = iSize(x)
    *)
fun iSize' (iEmpty):int = 0
    | iSize' (iLeaf _)=1
    | iSize' (iNode(tl,i,tr))=iSize'(tl)*2+i

val 2=iSize'(t')
(*
tileLeft(x)==>y
REQUIRES validate(x)
ENSURES validate(y) and all i in y's nodes are non-positive 
    and y is a corresponding tree to x
    *)
fun tiltLeft(iEmpty):itree = iEmpty
    | tiltLeft(iLeaf str)= iLeaf str
    | tiltLeft(iNode(tl,i,tr))=
    if i <=0 then iNode(tiltLeft(tl),i,tiltLeft(tr))
    else iNode(tiltLeft(tr),~i,tiltLeft(tl))

val iNode (iLeaf "b",0,iNode (iLeaf "a",~1,iEmpty)) =tiltLeft(t')
;

print  "1";
