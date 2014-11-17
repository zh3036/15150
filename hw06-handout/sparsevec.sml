(* andrew Id: _zihanz_____________ *)

functor SparseVec(Elt : ELT) :>INFVEC where E = Elt =
struct
  open Util

  structure E : ELT = Elt
  type infvec = (int * E.t) list

  (* toString v ==> s
   * ENSURES: s is a string representation of v
   *)
    fun toString (v: (int * E.t) list): string =
       let
         fun ts (_:int, []: (int * E.t) list): string = "0,..."
           | ts (i, v as (j,x)::v') = 
               if i=j
                 then E.toString x ^ "," ^ ts (i+1, v')
                 else               "0," ^ ts (i+1, v)
       in
         "[" ^ ts (1,v) ^ "]"
       end

 (*
    valid v ==> tf:bool
    ensures return true if v satify invariant 
    *)
    fun valid( nil )= true
        | valid((i,x)::nil)=if E.z(x) orelse i<1 then false else true
        | valid((i1,x1)::(i2,x2)::l)=
        if E.z(x1) orelse E.z(x2) orelse i1<1 orelse i2<=i1 
            then false
            else valid((i2,x2)::l)
    (*
        eq(v,u)=>tf
        requires valid v andalso valid u
        ensures if v and u contain same elem in same pos then true
            else false
        *)
    fun eq (nil:infvec,nil:infvec)=true
        | eq( x::l,nil)=false
        | eq(nil,x::l)=false
        | eq((i1,x1)::l1,(i2,x2)::l2)=
        i1=i2 andalso E.eq(x1,x2) andalso eq(l1,l2)

(*
toVec l => v
ensures valid v 
    *)
(*
    cuthead f (v,i)=>(v2,i2)
    requires valid v  and f:'a =>bool
    ensures chop from the left elem of v that satisfy f
    and i2-i1 is number of elems choped
    *)
    fun cuthead f (nil,n) = (nil,n)
        | cuthead f (x::l,n)=
        if (f x) 
        then cuthead f (l,n+1)
        else (x::l,n)
    fun toVec' (nil,_:int)=nil
        | toVec' (v,n)=
        let
            val (v2,i)=cuthead(E.z)(v,n)
        in
            case v2 of
                nil => nil
                | x::l => (i,x)::toVec'(l,i+1)
        end
    fun toVec (L)=toVec'(L,1) 

(*    fun toList (nil) = nil
        | toList ((1,x)::l)=x::toList(l)
        | toList ((i,x)::l)=E.zero::toList((i-1,x)::l)
*)

(*
tolist v => l
requires valid v
ensures eq(v,toVec l)

    *)
    fun toList(v)=
        let
            fun ts(_:int,nil:(int*E.t) list):E.t list=nil
                | ts(i, v as (j,x)::v')=
                    if i=j
                        then x::ts(i+1,v')
                        else E.zero::ts(i+1,v)
        in
            ts (1,v)
        end

(*
iszero v=> tf
requires valid v
ensures if empty then true
            iszero(toVec[]) = true
    *)
    fun iszero (nil)= true
        | iszero _ = false
(*
flatat v = n
requires valid l
ensures for all i>=n v[i]=E.zero
    *)
    fun flatat  l = 
        let 
            val l'=rev(l)
        in
            case l' of
                nil => 1
                | (i,_)::v => i+1
        end
(*
compent v,i => x
requires valid v i>=1
ensures x is the ith elem of v

ps: in specs  i use v[i] to denote
    compenent(v,i)
    *)
    fun component (nil,_)=E.zero
        | component ((i1,x)::l,i2)=
        if i2<i1 
            then E.zero
            else if i2=i1 then x
            else component(l,i2)
(*
    add (v1,v2)=v3
    requirees valid v1 valid v2
    ensures valid v3 , for all i >=1 v3[i]=E.p(v1[i],v2[i])

    *)
    fun add (nil , v)= v
        | add (v , nil) = v
        | add ((i1,x1)::v1,(i2,x2)::v2)=
        if i1 = i2 then 
            let
                val s = E.p(x1,x2)
            in
                if E.z(s) then add(v1,v2)
                else  (i1, s)::add(v1,v2) 
            end           
        else if i1<i2 then (i1,x1)::add(v1,(i2,x2)::v2)
        else (i2,x2)::add((i1,x1)::v1,v2)

(*
scale (x,v)=>v2
requiqre valid v
ensure svalid v2 andalso v2[i]=E.m(v[i],x)

    *)
    fun scale (x,v)=map (fn (i,j)=>(i,E.m(j,x))) v

        (*
            filter f as(x=>tf:bool) v=>v2
            requires valid v
            ensures valid v2
            v2[i]=v[i] if f v[i] = false else v2[i]=E.zero
            *)

    fun filter  f nil = nil
        | filter f ((i,x)::v)=
        if f x then (i,x)::(filter f v)
        else filter f v
    (*
    convovle (u,v)=>K
    requires valid u and valid v
    ensures valid K
    K is a convolve result of u and v
        *)
    fun convolve(nil, _)= nil
        | convolve((i,x)::nil,v)=scale(x,v)
        | convolve((i,x)::(i2,x2)::l,v)=
        let 
            val V= add(scale(x,v), map (fn (j,x)=>(j+i2-i,x)) (convolve((i2,x2)::l,v)))
        in
            Util.chop (fn (_,x) => E.z(x)) V
        end

end (* functor SparseVec *)
