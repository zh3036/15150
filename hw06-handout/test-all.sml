(* andrew Id: _____zihanz________________ *)

structure Test =
struct
(* Use this structure for outside-the-box testing.  There is one
   section for each structure or functor you are asked to implement.
   Functors are pre-instantiated with provided parameters, but feel
   free to try more instances.  Use the nickname defined in each
   section to write your tests, but do not open any of these structures.
 *)
 
  structure U = Util 
  (* Insert tests for structure Util here *)

  val [1,2,3,4,5] = U.chop (fn x => x mod 2 = 0) [1,2,3,4,5,6,8,10] 
  val [[],[1],[1,2]] = U.chop (fn [] => true | _=> false) [[],[1],[1,2],[],[]]
  val [] = U.chop (fn x => x > 7) [] 
  val  [401, 302, 203, 104]= U.combine op+ ([1,2,3,4], [400, 300, 200, 100])      
  val  [401, 302, 200, 100]= U.combine op+ ([1,2], [400, 300, 200, 100])      
  val  [401, 302, 3, 4] = U.combine op+ ([1,2,3,4], [400, 300])      

  structure L = ListVec (IntElt)
  open L
  val a = toVec[1,2,0]
  val true = valid a
  val b = toVec[1,2,0,0,0]
  val true = eq(a,b)
  val c= toVec[1,2,3]
  val false = eq(b,c)
  val 4 = flatat c;
  val false = iszero c;
  val true = iszero(toVec[])
  val 1 = component(c,1)
  val 2 = component(c,2)
  val 0 = component(c,1123)
  val [2,4,3]=toList(add(b,c))
  val [2,4,6]=toList(scale(2,c))
  val [1,0,3]=toList(filter (fn x=> (x mod 2 =1)) c)
  val [0,2]=toList(filter (fn x=> (x mod 2 =0)) c)
  val  a = toVec[2,7,8]
  val b = toVec[5,1]
  val [10,37,47,8]=toList(convolve(a,b))
  (* Insert tests for functor ListVec here *)
  structure S = SparseVec (IntElt)
    (*structure L = ListVec (IntElt)*)
  open S
  val a = toVec[1,2,0]
  val true = valid a
  val b = toVec[1,2,0,0,0]
  val true = eq(a,b)
  val c= toVec[1,2,3]
  val false = eq(b,c)
  val 4 = flatat c;
  val false = iszero c;
  val true = iszero(toVec[])
  val 1 = component(c,1)
  val 2 = component(c,2)
  val 0 = component(c,1123)
  val [2,4,3]=toList(add(b,c))
  val [2,4,6]=toList(scale(2,c))
  val [1,0,3]=toList(filter (fn x=> (x mod 2 =1)) c)
  val [0,2]=toList(filter (fn x=> (x mod 2 =0)) c)
  val  a = toVec[2,7,8]
  val b = toVec[5,1]
  val [10,37,47,8]=toList(convolve(a,b))
  (* Insert tests for functor SparseVec here *)

  structure F = FunVec (IntElt)
  (* Insert tests for functor FunVec here *)
  (*structure L = ListVec (IntElt)*)
  open F
  val a = toVec[1,2,0]
  val true = valid a
  val b = toVec[1,2,0,0,0]
  val true = eq(a,b)
  val c= toVec[1,2,3]
  val false = eq(b,c)
  val 4 = flatat c;
  val false = iszero c;
  val true = iszero(toVec[])
  val 1 = component(c,1)
  val 2 = component(c,2)
  val 0 = component(c,1123)
  val [2,4,3]=toList(add(b,c))
  val [2,4,6]=toList(scale(2,c))
  val [1,0,3]=toList(filter (fn x=> (x mod 2 =1)) c)
  val [0,2]=toList(filter (fn x=> (x mod 2 =0)) c)
  val  a = toVec[2,7,8]
  val b = toVec[5,1]
  val [10,37,47,8]=toList(convolve(a,b))




  structure M = Matrix (IntElt)
  open M
  val a = toMat[[1,0,7],[3,1],[2,10]]
  val b = toMat[[2,~1,10],[5,1,4]]
  val "[[19,99,14,0,...],[16,41,35,0,...],0,...]" =toString (mult (a,b))
(*mult use vProd, so if mult works then Vprod is also tested*)

end (* structure Test *)
