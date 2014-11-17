functor Referee (structure Maxie  : PLAYER
                 structure Minnie : PLAYER
		 sharing type Maxie.Game.state = Minnie.Game.state
		 sharing type Maxie.Game.move = Minnie.Game.move)
	: REFEREE =
  struct
    structure Game = Maxie.Game

    val outcomeToString = Game.est_toString o Game.Definitely

    fun play state =
      case Game.status state
        of Game.Over outcome =>
              let val () = print ((Game.state_toString state) ^ "\n")
                  val () = print ("Game over! " ^ outcomeToString outcome ^ "\n")
              in
                  ()
              end
         | Game.In_play =>
           let
             val () = print ((Game.state_toString state) ^ "\n")
             val t0 = Time.now ()
             val move =
                 case Game.player state of
                   Game.Maxie => Maxie.next_move state
                 | Game.Minnie => Minnie.next_move state
             val t1 = Time.now ()

             val () = print ((case Game.player state of
                                Game.Maxie => "Maxie"
                              | Game.Minnie => "Minnie")
                             ^ " decides to make the move "
                             ^ (Game.move_toString move)
                             ^ " in " ^
                             IntInf.toString(Time.toSeconds(Time.-(t1,t0))) ^
                                   " seconds.\n")
           in
             play (Game.make_move (state,move))
           end


    fun go () = play (Game.start)
end (* functor Referee *)
