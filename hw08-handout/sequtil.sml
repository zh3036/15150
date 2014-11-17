(* andrew Id: ______zihanz___________ *)

structure SeqUtil : SEQUTIL =
struct
  (* uniquify cmp s ==> s'
     ENSURES: s' contains all the elements in s without duplicates
   *)
  fun uniquify (cmp: 'a * 'a -> order) (s: 'a Seq.seq): 'a Seq.seq =
    let
    (* combine (s1, s2) ==> s
       REQUIRES: s1 and s2 are do not contain duplicates
       ENSURES s contains all the elements of s1 and s2 without duplicates
     *)
    fun combine (s1: 'a Seq.seq, s2: 'a Seq.seq): 'a Seq.seq =
      (case (Seq.length s1, Seq.length s2)
         of (0,_) => s2
          | (_,0) => s1
          | _ =>
  	  case  cmp (Seq.nth 0 s1, Seq.nth 0 s2)
  	    of LESS    => Seq.cons (Seq.nth 0 s1) (combine (Seq.drop 1 s1, s2))
  	     | EQUAL   => Seq.cons (Seq.nth 0 s1) (combine (Seq.drop 1 s1, Seq.drop 1 s2))
  	     | GREATER => Seq.cons (Seq.nth 0 s2) (combine (s1, Seq.drop 1 s2)))

      val elem = Seq.map (fn x => Seq.singleton x) s
    in
      Seq.reduce (fn xy => combine xy) (Seq.empty()) elem
    end

  (* permeq (S1,S2) ==> b
     ENSURES: b == true iff S1 and S2 are equal up to permutation
   *)
  fun permeq (eq: 'a * 'a -> bool) (S1: 'a Seq.seq, S2: 'a Seq.seq): bool =
    if Seq.length S1 = 0 then Seq.length S2 = 0
    else
      let
        val x = Seq.nth 0 S1
	val X1  = Seq.filter (fn y => eq (x,y)) S1
	val X2  = Seq.filter (fn y => eq (x,y)) S2
	val S1' = Seq.filter (fn y => not (eq (x,y))) S1
	val S2' = Seq.filter (fn y => not (eq (x,y))) S2
      in
	Seq.length X1 = Seq.length X2 andalso permeq eq (S1', S2')
      end

(*  
     par2 f (x1,x2) ==> (y1,y2)
     ENSURES: apply f to x1 and x2 in parallel obtaining y1 and y2.
*)

    fun ppar f (x1,x2)=
        let
            val [x1',x2'] = 
            Seq.toList
            (Seq.map f 
                (Seq.append
                    (Seq.singleton x1) (Seq.singleton x2)))
        in
            (x1',x2')
        end
        
  (* all bs ==> b
     ENSURES: b == true iff all elements in bs are true
   *)
    fun all s=
        Seq.reduce (fn(x,y)=>x andalso y) true s
(*  
    #Analysis   
    Because the Work of fn does not depend on "s"
    WORK_all(n) = WORK_reduce(n)=O(n)
    SPAN_all(n)=SPAN_reduce(n)=O(log n)
*)

  (* some bs ==> b
     ENSURES: b == true iff at least one element in bs is true
   *)
    fun some s =
        Seq.reduce (fn(x,y)=> x orelse y) false s
(*  
    #Analysis   
    Because the Work of fn does not depend on "s"
    WORK_some(n) = WORK_reduce(n)=O(n)
    SPAN_some(n)=SPAN_reduce(n)=O(log n)
*)
end (* structure SeqUtil *)
