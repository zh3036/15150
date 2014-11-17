structure GTree = GameTree
val N = GTree.Node
val E = GTree.Est


(* run with search depth 2*)
structure HandoutSmall : GAME =
ExplicitGame(structure G = GTree
             val tree = N ("a", 0,
			   [N("b", 1,
			      [E("c", 3),E("d",6),E("e",~2)]),
			    N("f", 3,
			      [E("g", 6),E("h",4),E("i",10)]),
			    N("j", ~1,
			      [E("k", 1),E("l",30),E("m",9)])]))

(* run with search depth 4*)
structure HandoutBig : GAME =
ExplicitGame(structure G = GTree
             val tree = N ("a", 0,
			   [N("b", 1,
			      [N("c", 2,
				 [N("d", 3,
				    [E("e",3), E("f",5)]),
				  N("g", 0,
				    [E("h",2), E("i",7)])]),
			       N("j", ~1,
				 [N("k", ~2,
				    [E("l",10), E("m",4)])])]),
			    N("n", 2,
			      [N("o", 1,
				 [N("p", 3,
				    [E("q",2), E("r",7)])]),
                               N("s", 5,
				 [N("t", 6,
				    [E("u",8), E("v",2)]),
                                  N("w", 12,
				    [E("x",4), E("y",6)])])])]))

(*
(* run with search depth 2*)
structure HandoutSmall : GAME =
ExplicitGame(structure G = GameTree
             val tree = G.Node ("a",
				[G.Node("b",
					[G.Est("c", 3),G.Est("d",6),G.Est("e",~2)]),
				 G.Node("f",
					[G.Est("g", 6),G.Est("h",4),G.Est("i",10)]),
				 G.Node("j",
					[G.Est("k", 1),G.Est("l",30),G.Est("m",9)])]))

(* run with search depth 4*)
structure HandoutBig : GAME =
ExplicitGame(structure G = GameTree
             val tree = G.Node ("a",
				[G.Node("b",
					[G.Node("c",
						[G.Node("d",[G.Est("e",3),
							     G.Est("f",5)]),
						 G.Node("g",[G.Est("h",2),
							     G.Est("i",7)])]),
					 G.Node("j",
						[G.Node("k",[G.Est("l",10),
							     G.Est("m",4)])])]),
				 G.Node("n",
					[G.Node("o",
						[G.Node("p",[G.Est("q",2),
							     G.Est("r",7)])]),
                                     G.Node("s",
					    [G.Node("t",[G.Est("u",8),
							 G.Est("v",2)]),
                                             G.Node("w",[G.Est("x",4),
							 G.Est("y",6)])])])]))
*)
