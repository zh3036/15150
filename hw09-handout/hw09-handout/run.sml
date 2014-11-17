structure Con4 = Connect4(val num_cols = 7
                          val num_rows = 6)

(* Players *)
structure HumanC4 = HumanPlayer(Con4)
structure MM5C4   = MiniMax(structure G = Con4
                            (* search depth 4 is relatively instantaneous;
                               5 takes about 5 seconds per move *)
                            val search_depth = 5)

structure AB5C4 = struct end (* AlphaBeta *)
structure J5C4  = struct end (* Jamboree  *)

(* Plays *)
structure C4_HvMM = Referee(structure Maxie = HumanC4
                            structure Minnie = MM5C4)

structure C4_HvAB = struct end (* AlphaBeta vs. human *)
structure C4_HvJ  = struct end (* Jamboree  vs. human *)
