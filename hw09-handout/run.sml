structure Con4 = Connect4(val num_cols = 8
                          val num_rows = 3)

(* Players *)
structure HumanC4 = HumanPlayer(Con4)
structure MM5C4   = MiniMax(structure G = Con4
                            (* search depth 4 is relatively instantaneous;
                               5 takes about 5 seconds per move *)
                            val search_depth = 5)

structure AB5C4 = MakeAlphaBeta(structure G=Con4
	val search_depth=7)
(* AlphaBeta *)
structure J5C4  =  MakeJamboree(structure G=Con4
	val search_depth=7 
	val prune_percentage = 0.3)(* Jamboree  *)

(* Plays *)
structure C4_HvMM = Referee(structure Maxie = HumanC4
                            structure Minnie = MM5C4)
structure C4_MMvAB=Referee(structure Maxie=MM5C4
	structure Minnie = AB5C4)

structure C4_HvAB = Referee(structure Maxie=HumanC4
	structure Minnie=AB5C4) (* AlphaBeta vs. human *)
structure C4_HvJ  = Referee(structure Maxie=HumanC4
	structure Minnie=J5C4 )  (* Jamboree  vs. human *)
