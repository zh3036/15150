Control.Print.printDepth  := 50;
Control.Print.printLength := 50;

(* Tagged trees are binary trees whose nodes are pairs
   consisting of a tag and some data. Tags are not necessarily 
   unique in a tree, nor are tagged trees necessarily ordered.
 *)
type tag = int
type 'a entry = tag * 'a
datatype 'a tree = Empty
                 | Node of 'a tree * 'a entry * 'a tree

(* The next 4 functions searchX (i,t) search a tagged tree t
   with a given tag i, returning the associated data.  They
   vary on the implementation technique and on what exactly
   is returned.  They make use of the auxiliary functions
   searchX'.
*)

(* plain recursive implementation *)
(* search1: tag * 'a tree -> 'a option *)
fun search1 (tag,Empty)= NONE
  | search1 (tag,Node(tl,(tg,e),tr))=
  if tag=tg then SOME e else
      case search1(tag,tl) of
           NONE => search1(tag,tr)
         | SOME x=>SOME x

val x: string tree = Node(Node(Empty,
                                 (1,"bar"),
                                  Empty),
                            (2,"foo"),
Empty)

val y= Node(x,(1,"hi"),Empty)
val z= Node(y,(1,"hehe"),Empty)

(* using failure continuation -- same behavior *)
(* search2': tag * 'a tree -> (unit -> 'a option) -> 'a option *)
fun search2'(tag, Empty) k = k()
  | search2'(tag, Node(tl,(tg,e),tr)) k =
  if tag=tg then SOME e else
    search2'(tag,tl) (fn()=>
    search2'(tag,tr) k)

(* search2: tag * 'a tree -> 'a option *)
fun search2(tag,t)=search2'(tag,t) (fn()=>NONE) 


(* using success continuation, returns all data with tag i *)
(* search3': tag * 'a tree -> ('a list -> 'a list) -> 'a list *)
fun search3'(tag,Empty) k = k([])
  | search3'(tag,Node(tl,(tg,e),tr)) k=
  search3'(tag,tl) (fn l1=>
  search3'(tag,tr) (fn l2=>k(
  if tg=tag then e::l1@l2 else l1 @l2)))

(* search3: tag * 'a tree -> 'a list *)
fun search3(tag,t)=search3'(tag,t) (fn l=>l) 


(* Return the first entry found, and a function that when
   called returns the next entry.
 *)
datatype 'a result = NoMore
                   | Next of 'a * (unit -> 'a result)

(* search4': tag * 'a tree -> (unit -> 'a result) -> 'a result *)
fun search4'(tag,Empty) k = k()
  | search4'(tag,Node(tl,(tg,e),tr)) k =
  let 
    val f= (fn()=>
    search4'(tag,tl) (fn()=>
    search4'(tag,tr) k))
  in
  if tag=tg then Next(e,f)
  else f()
  end


(* search4: tag * 'a tree -> 'a result *) 
fun search4(tag,t) = search4'(tag,t) (fn()=>NoMore) 

val Next(e,f)=search4(1,z)
val Next(_,f2)=f()
val Next(_,f3)=f2()
val n=f3()

(* Test cases here *)

