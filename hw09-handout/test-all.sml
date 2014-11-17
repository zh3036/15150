(* andrew Id: ________zihanz____________ *)

structure Test =
struct
(* Use this structure for outside-the-box testing.  There is one
   section for each structure or functor you are asked to implement.
   Functors are pre-instantiated with provided parameters, but feel
   free to try more instances.  Use the nickname defined in each
   section to write your tests, but do not open any of these structures.
 *)

  structure L = LookAndSay
  val a = Seq. fromList[1,1,3,3,3,3,4,5,5,5]
  val b =L.lookAndSay (fn (x,y)=>x=y) a
  val [(2,1),(4,3),(1,4),(3,5)]=Seq.toList b

  (* Insert tests for structure LookAndSay here *)
 

  structure C = Connect4(val num_cols = 7
                         val num_rows = 6)
  val s=C.start;
  val C.In_play= C.status s
  val C.Maxie=C.player s
  val [0,1,2,3,4,5,6]=Seq.toList(C.moves s)
  val s2 = C.make_move(s,0);
  val s2 = C.make_move(s2,1);
  val s2 = C.make_move(s2,0);
  val s2 = C.make_move(s2,1);
  val s2 = C.make_move(s2,0);
  val s2 = C.make_move(s2,1);
  val s2 = C.make_move(s2,0);
  val C.Over (C.Winner C.Maxie)=C.status s2
  val C.Minnie=C.player s2
  val s2 = C.make_move(s2,1);
  val s2 = C.make_move(s2,0);
  val s2 = C.make_move(s2,1);
  val s2 = C.make_move(s2,0);
  val [1,2,3,4,5,6]=Seq.toList(C.moves s2)
  

  (* Insert tests for functor Connect4 here *)


  structure A = MakeAlphaBeta(structure G = HandoutSmall
                              val search_depth = 2)
  val st=A.Game.start
  val p = A.Pruned
  val ev1 = A.evaluate 2 (p,p) st 0

  (* Insert tests for functor MakeAlphaBeta here *)

 structure AS = MakeAlphaBeta(structure G = HandoutBig
                              val search_depth = 4)

 fun mnv n = AS.BestEdge(0,AS.Game.Guess(n))
 fun mev x = AS.BestEdge(
    0,AS.Game.Definitely(AS.Game.Winner x))
 val st=AS.Game.start
 val a1=mev AS.Game.Minnie
  val g2=mnv 2
    val t= AS.Game.make_move(st,0)
  val t= AS.Game.make_move(t,1)
  val k= AS.Game.make_move(t,0)
  val ab=(AS.Pruned,mnv 3)
  val ev2=AS.evaluate 1 ab k 0
  val AS.ParentPrune=ev2
  val 0=AS.next_move st;

  (* Insert tests for functor MakeAlphaBeta here *)



  structure J = MakeJamboree(structure G = HandoutBig
                             val search_depth = 4
                             val prune_percentage = 0.5)
  fun jmnv n = J.BestEdge(0,J.Game.Guess(n))
  fun jmev x = J.BestEdge(0,J.Game.Definitely(J.Game.Winner x))
  val jst=J.Game.start
  val t= J.Game.make_move(jst,0)
  val t= J.Game.make_move(t,1)
  val k= J.Game.make_move(t,0)
  val ab=(J.Pruned,jmnv 3)
  val J.ParentPrune=J.evaluate 1 ab k 0
  val 0 = J.next_move jst;
  
  (* Insert tests for functor MakeJamboree here *)

end (* structure Test *)
