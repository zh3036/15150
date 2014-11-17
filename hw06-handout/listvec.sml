(* andrew Id: zihanz___ *)

functor ListVec(Elt : ELT) :> INFVEC where E = Elt =
struct
  open Util

  structure E : ELT = Elt
  type infvec = E.t list

  (* toString v ==> s
   * ENSURES: s is a string representation of v
   *)
  fun toString (v: E.t list): string =
   let
     fun ts ([]: E.t list): string = "0,..."
         | ts (x::v) = E.toString x ^ "," ^ ts v
   in
     "[" ^ ts v ^ "]"
   end

   (*
    valid v ==> tf:bool
    ensures return true if v satify invariant 
    *)

    fun valid ( [] ) = true
        | valid ( x::nil)= if E.z(x) then false else true
        | valid (x::l)=valid l

    val false = valid [E.zero]
    (*
        eq(v,u)=>tf
        requires valid v andalso valid u
        ensures if v and u contain same elem in same pos then true
            else false
        *)
    fun eq([],[])=true
        | eq(x::l1,y::l2)=E.eq(x,y) andalso eq(l1,l2)
        | eq _ = false
(*
toVec l => v
ensures valid v 
    *)
    fun toVec  x = chop (E.z) x
(*
tolist v => l
requires valid v
ensures eq(v,toVec l)

    *)
    fun toList  x = x
(*
iszero v=> tf
requires valid v
ensures if empty then true

    *)
    fun iszero ([]) = true
        | iszero _ = false
(*
flatat v = n
requires valid l
ensures for all i>=n v[i]=E.zero
    *)
    fun flatat l = length(l)+1
(*
compent v,i => x
requires valid v i>=1
ensures x is the ith elem of v

ps: in specs  i use v[i] to denote
    compenent(v,i)
    *)
    fun component(nil,i)=E.zero
        | component(x::l,1)=x
        | component(x::l,i)=component(l,i-1)

(*
    fun add(nil,nil)=nil
        | add(x::l,nil)=x::l
        | add(nil,x::l)=x::l
        | add(x::l1,y::l2)=E.p(x,y)::add(l1,l2)
*)

(*
    add (v1,v2)=v3
    requirees valid v1 valid v2
    ensures valid v3 , for all i >=1 v3[i]=E.p(v1[i],v2[i])

    *)
    fun add(v1,v2)=
        Util.chop E.z (Util.combine E.p (v1,v2))

(*    fun scale(x,nil)=nil
        | scale(x,a::l)=E.m(x,a)::scale(x,l)*)
(*
scale (x,v)=>v2
requiqre valid v
ensure svalid v2 andalso v2[i]=E.m(v[i],x)

    *)
    fun scale (x,v) = map (fn j=> E.m(j,x)) v

        (*
            filter f as(x=>tf:bool) v=>v2
            requires valid v
            ensures valid v2
            v2[i]=v[i] if f v[i] = false else v2[i]=E.zero
            *)

    fun filter' f nil = nil
        | filter' f (x::l)=
            if (f x)
                then x::(filter' f l)
                else E.zero::(filter' f l)

    fun filter f l = Util.chop E.z (filter' f l)

    (*
    convovle (u,v)=>K
    requires valid u and valid v
    ensures valid K
    K is a convolve result of u and v
        *)
    fun convolve'(nil, _)= nil
        | convolve'(x::l,v)=add(scale(x,v),E.zero::convolve'(l,v))

    fun convolve(v,u)=Util.chop E.z (convolve'(v,u))

end (* functor ListVec *)
