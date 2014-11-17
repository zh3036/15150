(* andrew Id: _zihanz_ *)

structure Util : UTIL =
struct


(*
    chop' f as (x-> tf:bool)->l1->l2
    requires true 
    ensures every elem satify f from the left of of l1 will be
    removed, until get l2. 
    *)

fun chop' f nil = nil
    | chop' f (x::l) = 
        if (f x) 
            then chop' f l 
            else x::l 

val  [~1,0,2,0]=chop' (fn x => x>1) [3,4,~1,0,2,0]


(*
    chop f as (x-> tf:bool)->l1->l2
    requires true 
    ensures every elem satify f from the right of of l1 will be
    removed, become l2. 
    *)

fun chop f l = 
    let 
        val l'=rev(l)
    in
        rev(chop' f l')
    end
val [1,0]=chop (fn x => x=1)  [1,0,1,1]
(*
combine f as ((x1,x2)->x3) (l1,l2)->l3
requires l1 and l2 has same type
ensures apply f on each elem of l1 l2 and get l3 has same type as 
l1 l2.
    *)

fun combine f (nil,nil)  = nil
    | combine f (x::l,nil) = x::l
    | combine f (nil,x::l) = x::l
    | combine f (x::l1,y::l2)=f(x,y)::(combine f (l1,l2))
val [ 2,  4,6]= combine (op +) ([1,1,6],[1,3])
(*
combineS f as ((x1,x2)->x3) (l1,l2)->l3
requires true
ensures apply f on each elem of l1 l2 ,but does not ensure type
    *)
fun combineS f (nil,nil)  = nil
    | combineS f (x::l,nil) = nil
    | combineS f (nil,x::l) = nil
    | combineS f (x::l1,y::l2)=f(x,y)::(combineS f (l1,l2))
val [[1,2,3],[2,4,6]]=combineS (fn (x,l)=>x::l) ([1,2],[[2,3],[4,6]])
(*
reduce f e l = x
requires f takes 2 args give 1
ensures result given repetively apply f on elems of l
    *)
fun reduce f e []= e
    | reduce f e (x::l)=f(x,reduce f e l)

val 10 = reduce (op +) 0 [1,2,3,4]

end (* structure Util *)
