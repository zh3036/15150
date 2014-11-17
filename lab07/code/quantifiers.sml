datatype 'a tree = Empty
                 | Node of 'a tree * 'a * 'a tree

(* reduce f e t ==> v
   ENSURES: v is the result of recursively combining all the values
            in t according to f, with e as a base value
 *)
fun reduce (f: 'a * 'b * 'a -> 'a) (e: 'a) (Empty: 'b tree): 'a = e
  | reduce f e (Node(tL,x,tR)) = f (reduce f e tL, x, reduce f e tR)


fun Exists p t= 
	reduce (fn (x,y,z)=>(x orelse (p y ) orelse z)) false t

fun Forall p t= 
	reduce (fn (x,y,z)=>(x andalso (p y ) andalso z)) true t

(*fun Forall p = raise Fail "Unimplemented"*)


(* foldr is predefined *)

fun exists p l=
	foldr (fn (x,y)=>((p x) orelse y)) false l

fun forall p l=
	foldr (fn (x,y)=>((p x) andalso y)) true l



val a = Node(Empty,5,Empty);
val b = Node(a,6,a);
val c= Node(b,1,b);
val true = Forall (fn x => (x<100)) c;
val true = Exists (fn x => (x=1)) c;


val d= [1,2,3,4,5]
val false = exists (fn x => (x=0)) d;
val true = exists (fn x => (x=3)) d;
val true = forall (fn x => (x>0)) d;
val false = forall (fn x => (x>2)) d;
