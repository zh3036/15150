structure SeqUtil : SEQUTIL =
struct
  fun reduce1 (c: 'a * 'a -> 'a) (s: 'a Seq.seq): 'a =
   let
     fun mergeo (NONE: 'a option , y: 'a option): 'a option = y
       | mergeo (x, NONE) = x
       | mergeo (SOME x, SOME y) = SOME (c (x,y))
   in
     case Seq.mapreduce SOME NONE mergeo s
       of SOME x => x
        | NONE   => raise Fail "called reduce1 on an empty sequence"
   end


  fun filtermap (f: 'a -> 'b option) (s: 'a Seq.seq): 'b Seq.seq =
    let
      val sf = Seq.map f s
      val sf'= Seq.filter (fn SOME _ => true
			    | NONE   => false) sf
      val s' = Seq.map (fn SOME x => x
			 | NONE   => raise Fail "bug in filtermap") sf'
    in s' end


  fun max (cmp: 'a * 'a -> order) (min: 'a) (s: 'a Seq.seq): 'a =
    Seq.reduce (fn (x,y) => (case cmp (x, y)
			       of LESS => y
                                | _    => x)) min s
end (* structure SeqUtils *)
