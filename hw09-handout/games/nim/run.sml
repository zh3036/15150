(* Players *)
structure HumanNim = HumanPlayer(Nim)

structure MMNim5 = MiniMax(structure G = Nim
                           val search_depth = 5)

structure MMNim1 = MiniMax(structure G = Nim
                           val search_depth = 1)


(* Plays *)
structure Nim_HvMM5   = Referee(structure Maxie  = HumanNim
                                structure Minnie = MMNim5)

structure Nim_MM5vMM5 = Referee(structure Maxie  = MMNim5
                              structure Minnie = MMNim5)

structure Nim_HvMM1   = Referee(structure Maxie  = HumanNim
                                structure Minnie = MMNim1)

structure Nim_MM1vH   = Referee(structure Maxie  = MMNim1
                                structure Minnie = HumanNim)
