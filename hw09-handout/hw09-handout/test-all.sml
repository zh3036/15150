(* andrew Id: _________________________________ *)

structure Test =
struct
(* Use this structure for outside-the-box testing.  There is one
   section for each structure or functor you are asked to implement.
   Functors are pre-instantiated with provided parameters, but feel
   free to try more instances.  Use the nickname defined in each
   section to write your tests, but do not open any of these structures.
 *)

  structure L = LookAndSay
  (* Insert tests for structure LookAndSay here *)
 

  structure C = MakeConnect4(val num_cols = 7
                             val num_rows = 6)
  (* Insert tests for functor Connect4 here *)


  structure A = MakeAlphaBeta(structure G = HandoutBig
                              val search_depth = 4)
  (* Insert tests for functor MakeAlphaBeta here *)


  structure J = MakeJamboree(structure G = HandoutBig
                             val search_depth = 4
                             val prune_percentage = 0.3)
  (* Insert tests for functor MakeJamboree here *)

end (* structure Test *)
