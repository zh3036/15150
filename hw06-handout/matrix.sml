(* andrew Id: ______zihanz____________ *)


functor Matrix (Elt : ELT) :> MATRIX where E = Elt =
struct
  open Util
    structure E: ELT = Elt
    structure Vec: INFVEC where E = E = ListVec (E)
  (* SparseVec(E) and FunVec(E) would work equally well *)
    structure InfecElt : ELT =
    struct
        type t = Vec.infvec
        val zero = Vec.toVec(nil)
        val p = Vec.add
        val m = Vec.convolve
        fun z x = Vec.iszero(x)
        val toString = Vec.toString
        val eq = Vec.eq
    end

  structure IF = ListVec(InfecElt)
  (*
Matrix here is just a infvec of infevec of E.t
so no particular invariant, as long as you contruct
    this way , it is automatically valid
    *)

        fun combineS f (nil,nil)  = nil
        | combineS f (x::l,nil) = nil
        | combineS f (nil,x::l) = nil
        | combineS f (x::l1,y::l2)=f(x,y)::(combineS f (l1,l2))
    fun reduce f e []= e
        | reduce f e (x::l)=f(x,reduce f e l)


  type matrix = IF.infvec
  (* toString v ==> s
   * ENSURES: s is a string representation of v
   *)

  val toString = IF.toString
    (*
        eq(v,u)=>tf
        ensures if v and u contain same elem in same pos then true
            else false
        *)
  val eq = IF.eq
  (*tolists tomat x=> x
    requires x : list list 'a
    *)
    fun toMat l = IF.toVec(map Vec.toVec l)
  fun toLists  m = map Vec.toList (IF.toList(m))
    (*
everything is ensures by infect invariant
        *)
  val add= IF.add



(*
vProd(m,v)=>u
ensures u is the mutiple of m and v

    *)


    fun vProd(m,v):Vec.infvec= 
        reduce Vec.add (Vec.toVec [])
        (combineS Vec.scale ((Vec.toList v),(IF.toList m)))
(*v
    mult (m1,m2)=>m3
    ensures m3 is a multiple of m1 and m2

    *)

  fun mult(m1,m2)=(*raise Fail "asd"*)
    IF.toVec(map (fn v => (vProd(m1,v))) (IF.toList m2))

end (* functor Matrix *)


