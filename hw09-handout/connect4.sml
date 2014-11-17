(* andrew Id: ______zihanz______ *)

functor MakeConnect4 (val num_cols: int
                      val num_rows: int): CONNECT4 =
struct
structure L = LookAndSay
  datatype player  = Minnie
		   | Maxie

  datatype outcome = Winner of player
		   | Draw

  datatype status  = Over of outcome
		   | In_play

  datatype est     = Definitely of outcome
	           | Guess of int

  datatype position = Filled of player
		    | Empty

  (* (0,0) is bottom-left corner *)
  datatype c4state = Unimplemented (* use in starter code only *)
		   | S of (position Matrix.matrix) * player
  type state = c4state

  type move = int (* cols are numbered 0 ... num_cols-1 *)

  val num_cols = num_cols
  val num_rows = num_rows

  (* printing functions *)
  fun player_toString Maxie  = "Maxie"
    | player_toString Minnie = "Minnie"

  fun outcome_toString (Winner P) = player_toString P ^ " wins!"
    | outcome_toString Draw       = "It's a draw!"

  fun status_toString (Over O) = "Over ("^ outcome_toString O ^")"
    | status_toString In_play  = "Still playing"

  fun est_toString (Definitely O) = outcome_toString O
    | est_toString (Guess i)      = "Guess:" ^ Int.toString i

  val move_toString = Int.toString

  fun pos_toString (Filled Minnie) = "O"
    | pos_toString (Filled Maxie)  = "X"
    | pos_toString Empty           = " "

  fun state_toString (board as (S (m, _))) =
      let
        val rows = Matrix.rows m
        val ts : string Seq.seq -> string = Seq.reduce op^ ""
        fun print_row s =
            "|" ^ ts (Seq.map (fn x => pos_toString x ^ "|") s) ^ "\n"
      in
          " " ^ ts (Seq.tabulate (fn i => Int.toString i ^ " ") num_cols)
          ^ "\n" ^
          "-" ^ ts (Seq.tabulate (fn _ => "--") num_cols) ^ "\n" ^
          Seq.mapreduce print_row "" (fn (x,y) => y^x) rows ^ "\n"
      end
    | state_toString Unimplemented = raise Fail "Incomplete implementation"


  (* equality functions *)
  val player_eq  = (op=)
  val outcome_eq = (op=)
  val status_eq  = (op=)
  val est_eq     = (op=)
  val move_eq    = (op=)

  fun pos_eq (Filled p1, Filled p2) = p1=p2
    | pos_eq (Empty, Empty) = true
    | pos_eq _ = false

  fun state_eq (S (m1,p1), S (m2,p2)) =
    Matrix.eq pos_eq (m1,m2) andalso p1=p2


  (* parsing functions *)
    fun lowestFreeRow (S(pm,_)) i =
        let
            val subs=
            Matrix.matching_subs 
            (fn Empty=>true | _=>false) pm
            val subi=SeqUtil.filtermap 
            (fn(c,r)=>if c = i then (SOME r) else NONE) subs
            val sub = SeqUtil.max 
            (fn(x,y)=>Int.compare(y,x)) num_rows subi
        in
            if sub=num_rows then NONE
            else SOME sub
        end




  fun parse_move st input =
     case Int.fromString input
       of SOME i => if i < num_cols
                     then
		       case lowestFreeRow st i
			 of SOME _ => SOME i
                          | _      => NONE
                     else NONE
        | NONE => NONE


    val start       = 
        S(Matrix.tabulate 
            (fn _=>Empty)
            (num_cols,num_rows)
            ,Maxie)


    fun status  (S(M,P))=
    let
        val player = if P=Minnie then Maxie else Minnie
        val cols=Matrix.cols M
        val rows=Matrix.rows M
        val di1=Matrix.diags1 M
        val di2=Matrix.diags2 M
        fun chkwin seqs=
            let    
                val ls=Seq.map 
                (L.lookAndSay pos_eq) seqs
                val win=Seq.exists (fn x=>x)
                    (Seq.map 
                        (Seq.exists
                            (fn(n,Filled(_))=>
                                if n>=4 then true else false
                             | _=>false)

                        ) ls
                    )      
            in win end
        fun chkdraw seqs=
            Seq.all (fn x=>x )
                ( Seq.map
                    ( Seq.all
                        (fn Filled(_)=>true |_ =>false)
                    ) seqs
                )        
    in
        if Seq. exists (fn x=> x)
            (Seq.map chkwin 
                (Seq.fromList [cols,rows,di1,di2]))
        then Over(Winner player)
        else if (chkdraw cols) then Over(Draw)
        else In_play
    end


    fun player  (S(M,P))=P

    fun moves(S(M,P)) =
        SeqUtil.filtermap 
        (fn((x,i))=>if i=num_rows-1 then SOME x  else NONE)
        (Matrix.matching_subs 
            (fn Empty=>true|_=>false) M)

    fun make_move (st as S(mat,P),mov)=
        let 
            val player = if P=Minnie then Maxie else Minnie            
            val (SOME r,c)=((lowestFreeRow st mov),mov)
      in
            S(Matrix.update mat ((c,r),Filled P), player)
        end

    fun cScore s =
        let 
            val slen=Seq.length s
            fun f ((_,Empty),(3,Filled(Maxie)))=64
                | f ((_,Empty),(3,Filled(Minnie)))=(~64)
                | f ((_,Empty),(2,Filled(Minnie)))=(~16)
                | f ((_,Empty),(2,Filled(Maxie)))=16
                | f _ =0
            val sscore = Seq.tabulate 
            (fn x=>f(Seq.nth x s,Seq.nth (x+1) s)
                +f(Seq.nth (x+1) s,Seq.nth x s))
            (slen-1)
        in
            Seq.reduce (op +) 0 sscore
        end

    fun estimate (S(M,P))=
    let
        val player = if P=Minnie then Maxie else Minnie
        val cols=Matrix.cols M
        val rows=Matrix.rows M
        val di1=Matrix.diags1 M
        val di2=Matrix.diags2 M
        fun chkscore seqs=
            let    
                val ls=Seq.map 
                (L.lookAndSay pos_eq) seqs
                val scoreSum=Seq.reduce (op +) 0
                    (Seq.map cScore ls)      
            in scoreSum end

        fun chkdef seqs player=
            let
                val ls=Seq.map 
                (L.lookAndSay pos_eq) seqs
                fun f((_,Empty),(3,Filled(player)))=true
                    | f((3,Filled(player)),(_,Empty))=true
                    | f _ = false
                fun g s=Seq.tabulate
                (fn x=> f(Seq.nth x s, 
                    Seq.nth (x+1) s)) ((Seq.length s)-1)
            in
                Seq.exists (fn x=>x) (
                    Seq.map (
                        Seq.exists (fn x =>x))(Seq.map g ls))
            end
        in
            if chkdef cols P then Definitely(Winner P)
            else Guess ( Seq.reduce (op +) 0(
                            Seq.map chkscore (
                                Seq.fromList[cols,rows,di1,di2]))  )
        end


end (* functor Connect4 *)


