(* 2 September 2014 *)
(* Lecture 4: SML datatypes, list *)
Control.Print.printDepth  :=  100;
Control.Print.printLength :=  500;
Control.Print.stringDepth := 1000;

(************************* Datatypes ******************************)
(* Family tree *)
datatype famTree = NA
		 | FT of string * famTree * famTree

val clancy: famTree = FT("Clancy", NA, NA)
val jackie: famTree = FT("Jackie", NA, NA)
val marge: famTree  = FT("Marge", jackie, clancy)
val mona: famTree   = FT("Mona", NA, NA)
val abraham         = FT("Abraham", NA, NA)
val homer           = FT("Homer", mona, abraham)
val lisa            = FT("Lisa", marge, homer)

val selma           = FT("Selma", jackie, clancy)
val ling            = FT("Ling", selma, NA)

val evil = FT("haha",lisa,lisa)
val evil2=FT("haha",evil,NA)
val evil3=FT("haha",evil2,NA)
val good = FT("haha",NA,NA);
val nor=FT("hei",good,evil3);
(* size (t) ==> n
 * REQUIRES: true
 * ENSURES: n is the number of strings in t
 *)
fun size (NA: famTree): int = 0
  | size (FT(x, m, f)) = 1 + size m + size f

val 0 = size NA
val 4 = size ling

(*
toList(f) ==>l
requires: f is a famtree
ensures: l is a list of all the name in f; 
*)
fun toList(NA:famTree): string list = []
  | toList(FT(x,m,f))=x::toList(m) @ toList(f)


fun isAncestor(NA:famTree,n:string):bool =false
  | isAncestor(FT(x,m,f),n)=
  if x=n then true
  else isAncestor(m,n) orelse isAncestor(f,n)

fun countName(NA,n:string):int = 0
  | countName(FT(x,m,f),n)=
  if x=n then 1+countName(m,n)+countName(f,n)
  else countName(m,n)+countName(f,n)

fun unique2(t,n:string):bool= 
  (isAncestor(t,n) andalso countName(t,n)=1)



fun unique(NA:famTree,n:string):bool=false
  | unique(FT(x,m,f),n)=
  if x=n then not (isAncestor(m,n) orelse isAncestor(f,n))
  else 
    (unique(m,n)  andalso (not isAncestor(f,n)))
    orelse (unique(f,n)  andalso ( not (isAncestor(m,n) andalso true)))
(* question here, why can not i use "not isAncestor" 
zihan zhou
  operator domain: bool
  operand:         famTree * string -> bool


  *)



datatype genealogy = ukn
		   | gen of string * int * genealogy * genealogy


val clancy'  = gen("Clancy", 1942, ukn, ukn)
val jackie'  = gen("Jackie", 1943, ukn, ukn)
val marge'   = gen("Marge", 1969, clancy', jackie')
val mona'    = gen("Mona", 1937, ukn, ukn)
val abraham' = gen("Abraham", 1936, ukn, ukn)
val homer'   = gen("Homer", 1966, abraham', mona')
val lisa'    = gen("Lisa", 1991, homer', marge')

val selma'   = gen("Selma", 1973, clancy', jackie')
val ling'    = gen("Ling", 2001, ukn, selma')


(* convert (g) ==> t
 * REQUIRES: true
 * ENSURES: t is the famTree that corresponds to g
 *)
fun convert (ukn: genealogy): famTree = NA
  | convert (gen(x, _, f, m)) = FT(x, convert m, convert f)

val true = ling = convert ling'
val true = lisa = convert lisa'

(* size' (g) ==> n
 * REQUIRES: true
 * ENSURES: n is the number of strings in g
 *)
fun size' (ukn: genealogy): int = 0
  | size' (gen(_, _, f, m)) = 1 + size' f + size' m

(* after (g, y) ==> g'
 * REQUIRES: children are born after parents
 * ENSURES: g' is the subtree of g of people born after y
 *)
fun after (ukn: genealogy, y: int): genealogy = ukn
  | after (gen(x, d, f, m), y) =
    if y > d
       then ukn
    else gen(x, d, after(f, y), after(m, y))

val gen("Lisa", 1991, ukn, ukn) = after (lisa', 1980)


(* Lists *)

datatype List = Nil
	      | Cons of string * List

val abc = Cons("a", Cons("b", Cons("c", Nil)))
val xyz = Cons("x", Cons("y", Cons("z", Nil)))

(* Length l ==> n
 * REQUIRES: true
 * ENSURES: n is the length of list l
 *)
fun Length (Nil: List): int = 0
  | Length (Cons(x, l)) = 1 + Length l

val 3 = Length abc

(* Append (l1, l2) ==> l3
 * REQUIRES: true
 * ENSURES: l3 is the result of appending l2 at the end of l1
 *)
fun Append (Nil: List, l2: List): List = l2
  | Append (Cons(x,l1), l2) = Cons(x, Append(l1, l2))

val abcxyz = Cons ("a",Cons ("b",Cons ("c",Cons ("x",Cons ("y",Cons ("z",Nil))))))
val true = abcxyz = Append(abc, xyz)

(* Rev l ==> l'
 * REQUIRES: true
 * ENSURES: l' is the list l reversed
 *)
fun Rev (Nil: List): List = Nil
  | Rev (Cons(x, l))  = Append(Rev l, Cons(x, Nil))

val Cons ("c",Cons ("b",Cons ("a",Nil))) = Rev abc

(* Match redundant
fun Rev (Nil: List): List = Nil
  | Rev (Cons(x, l))  = Append(Rev l, Cons(x, Nil))
  | Rev (Cons(x, Nil)) = Cons(x, Nil)
*)

(* Another match redundant
fun Rev (NIL: List): List = Nil
  | Rev (Cons(x, l))  = Append(Rev l, Cons(x, Nil))
*)

(* Match non-exhaustive
fun Rev (Nil: List): List = Nil
*)


(* SML predefined lists *) 

val 3 = length ["a", "b", "c"]
val ["a", "b", "c", "x", "y", "z"] = ["a", "b", "c"] @ ["x", "y", "z"]
val ["c", "b", "a"] = rev ["a", "b", "c"]


(* fLineage g ==> ss
 * REQUIRES: true
 * ENSURES: ss is the list containing the matrilineal lineage of g
 *)
fun fLineage (ukn: genealogy): string list = nil
  | fLineage (gen(x, _, f, m)) = x :: fLineage m

val ["Lisa","Marge","Jackie"] = fLineage (lisa')



(************************* product type ******************************)

(* transpose ((x,y), d) ==> (x',y')
 * ENSURES: (x',y') is the result of transposing (x,y) by d
 *)
fun transpose ((x,y): real * real, d: real): real * real =
    (x+d, y+d)

val p1 = transpose ((3.5, 7.3), 1.2)
val (x,y) = transpose (p1, 2.4)


(* dist0 (x,y) ==> d
 * ENSURES: d is the distance of point (x,y) from the origin
 *)
fun dist0 ((x,y): real * real): real = Math.sqrt(x*x + y*y)
fun dist0 (x: real, y: real): real = Math.sqrt(x*x + y*y)


val d = dist0 (x,y)
val p2 = transpose (p1, ~d)


(******************* type declaration ***********************)

type point = real * real * real

(* dist (p1, p2) ==> d
 * ENSURES: d is the Cartesian distance between p1 and p2
 *)
fun dist ((x1, y1, z1): point, (x2, y2, z2): point): real =
  Math.sqrt ((x2-x1)*(x2-x1) + (y2-y1)*(y2-y1) + (z2-z1)*(z2-z1))



  ;
