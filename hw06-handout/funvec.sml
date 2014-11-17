(* andrew Id: _____zihanz____________ *)

functor FunVec(Elt : ELT) :> INFVEC where E = Elt =
struct
  open Util

  structure E : ELT = Elt
  type infvec = int * (int -> E.t)

  (* toString v ==> s
   * ENSURES: s is a string representation of v
   *)
  fun toString (v: int * (int -> E.t)): string =
   let
     fun ts ((1,f): int * (int -> E.t)): string = "0,..."
       | ts (n,f) = E.toString (f 1) ^ "," ^ ts (n-1, fn x => f (x+1))
   in
     "[" ^ ts v ^ "]"
   end
   (*
    valid v ==> tf:bool
    ensures return true if v satify invariant 
    *)
    fun valid ((i,f))=
        if i<1 then false
        else if i=1 then true
        else not(E.z(f(i-1)))  
    (*
        eq(v,u)=>tf
        requires valid v andalso valid u
        ensures if v and u contain same elem in same pos then true
            else false
        *)
  fun eq((1,_):infvec,(1,_))=true
    | eq((i,f),(j,g))= 
    if i = j then E.eq(f (i-1) , g (i-1)) andalso eq((i-1,f),(i-1,g))
    else false 
(*
    fun funA(f:int -> E.t ,g: int -> E.t):int -> E.t = 
        fn x=> f x + g x*)



(*a spcial chop for function implementation
    *)
(*
    chop f as (x-> tf:bool)->l1->l2
    requires true 
    ensures every elem satify f from the right of of l1 will be
    removed, become l2. 
    *)


    fun chop((1,f):infvec)=(1,f)
        | chop ((n,f))=         
            if E.z(f (n-1)) then chop(n-1,f)
             else (n,f) 



(*
    fun toVec' (nil, i) = (i,fn x => E.zero)
        | toVec' (x::v,i) = 
        let 
            val (ei,f) = toVec'(v,i+1)
        in
            (ei,fn y =>E.p( (fn j => if j=i then x else E.zero) y , f y ))
        end
*)
(*
toVec'' l,i => v
ensures if i =1 then valid v 
    *)


    fun toVec'' (nil, i) = (i,fn x => E.zero)
        | toVec'' (x::v,i) = 
        let 
            val (ei,f) = toVec''(v,i+1)
        in
            (ei,fn y =>if y=i then x else  f y )
        end
(*
toVec l => v
ensures valid v 
    *)
    fun toVec v = chop (toVec''(v,1))

(*
tolist v => l
requires valid v
ensures eq(v,toVec l)

    *)
    fun toList (1,_)=nil
        | toList (n,f)=toList(n-1,f)@[(f (n-1))]
(*
iszero v=> tf
requires valid v
ensures if empty then true

    *)
    fun iszero (1,_)=true
        | iszero _ = false
(*
flatat v = n
requires valid l
ensures for all i>=n v[i]=E.zero
    *)

    fun flatat (i,_)=i
(*
compent v,i => x
requires valid v i>=1
ensures x is the ith elem of v

ps: in specs  i use v[i] to denote
    compenent(v,i)
    *)
    fun component ((_,f),i)=f i
(*
    add (v1,v2)=v3
    requirees valid v1 valid v2
    ensures valid v3 , for all i >=1 v3[i]=E.p(v1[i],v2[i])

    *)

    fun add' ((i1,f1),(i2,f2))= 
        if i1 > i2 
        then (i1,fn x => E.p(f2 x ,f1 x))
        else (i2, fn x => E.p(f2 x ,f1 x))

    (*fun add  _ = raise Fail ""*)
    val add = chop o add'

(*
scale (x,v)=>v2
requiqre valid v
ensure svalid v2 andalso v2[i]=E.m(v[i],x)

    *)
    fun scale (x,(i,f)) = (i,fn j => E.m((f j),x))

(*    fun filter g (i,f) =
        body*)
        (*
            filter f as(x=>tf:bool) v=>v2
            requires valid v
            ensures valid v2
            v2[i]=v[i] if f v[i] = false else v2[i]=E.zero
            *)
    fun filter' g ((i,h):infvec) = 
        (i, fn x => if g (h x) then h x else E.zero)

    fun filter g v = chop (filter' g v)        

    (*
    convovle (u,v)=>K
    requires valid u and valid v
    ensures valid K(((( ))))
    K is a convolve result of u and v
        *)
    fun convolve'((1,f),_)=(1,fn x=>E.zero)
        | convolve'((n,f),v)=
        let
            val (i,g) = scale(f(n-1),v)
        in
            add((i+n-2,fn x=>g(x-(n-2)) ),convolve'((n-1,f),v))
        end
    val convolve = chop o convolve'

(*    fun convolve'(nil, v)= nil
        | convolve'(x::l,v)=add(scale(x,v),E.zero::convolve'(l,v))
*)

end (* functor FunVec *)
