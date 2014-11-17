(* andrew Id: _________________________________ *)

functor Prop2 (structure U: UTIL
               structure L: LITERAL) :> PROP2 where L=L =
struct
  structure L = L
  structure R = L.R

  datatype fla = Var of R.letter
               | And of fla Seq.seq
               | Or  of fla Seq.seq
               | Not of fla

  (* toString F ==> s
     ENSURES: s is a string representation of F
   *)
  fun toString (Var l: fla): string = R.toString l
    | toString (And Fs) = "&" ^ (Seq.toString toString Fs)
    | toString (Or  Fs) = "|" ^ (Seq.toString toString Fs)
    | toString (Not F) = "~" ^ toString F

  (* eq (F1,F2) ==> b
     ENSURES: b == true iff F1 and F2 are syntactically identical formulas
   *)
  fun eq (Var l1, Var l2) = R.eq (l1,l2)
    | eq (And Fs1, And Fs2) = U.permeq eq (Fs1,Fs2)
    | eq (Or  Fs1, Or  Fs2) = U.permeq eq (Fs1,Fs2)
    | eq (Not F1,  Not F2 ) = eq (F1,F2)
    | eq _ = false

  (* pushNot F ==> F'
     ENSURES: F' is a formula equivalent to F where all the negation
              are pushed to the propositional letters.
   *)   
    fun pushNot (And x)=And(Seq.map pushNot x)
        | pushNot (Or x)=Or(Seq.map pushNot x)
        | pushNot (Not (Not f))=pushNot f
        | pushNot (Not(And f))=
            Or(Seq.map (fn x=>pushNot (Not x)) f)
        | pushNot (Not(Or f))=
            And(Seq.map (fn x=>pushNot(Not x)) f)
        | pushNot x=x

    fun wA(And _)=true 
        | wA _ =false
    fun wO(Or _)=true
        | wO _ = false

    fun distribute (Not x)=Not (distribute x)
        | distribute (And x)=
            if Seq.length(x)=1 then distribute(Seq.nth 0 x)
            else if (Seq.exists wA x)
                then
                let 
                    val fa=
                    And(Seq.append
                                    (Seq.flatten( 
                                                        Seq.map
                                                        (fn(And k)=>Seq.map distribute k) 
                                                        (Seq.filter wA x)))
                                    (Seq.filter (fn j=> not(wA j)) x))
                in
                    if eq(fa,And(x)) then fa
                    else distribute (fa)
                end


            else And(Seq.map distribute x)
        | distribute (Or F)=  
        if Seq.length(F)=1 then distribute(Seq.nth 0 F)
        else if (Seq.exists wA F)
        then 
            let
                val F'=Seq.filter wA F
                val And(ad)=Seq.nth 0 F'
                val Lr=Seq.drop 1 F'
                val Fr=Seq.filter (fn x=>not(wA x)) F
                val Fw=Or(Seq.append Lr Fr)
            in
                And(Seq.map (fn(x)=>
                    distribute(
                        Or(Seq.fromList  [x,Fw])) ) ad)
            end

(*        else if (Seq.exists wO F)
            then
            let 
                val fa=
                Or(Seq.append
                                (Seq.flatten( 
                                                    Seq.map
                                                    (fn(Or k)=>Seq.map distribute k) 
                                                    (Seq.filter wO F)))
                                (Seq.filter (fn x=> not(wO x)) F))
            in
                if eq(fa,Or(F)) then fa
                else distribute (fa)
            end*)


        else 
            let
                val dis = Seq.map distribute F
            in
                if eq(Or(dis),Or(F)) 
                then Or(dis) 
                else distribute(Or(dis))
            end
        | distribute x= x




    val Sin=Seq.singleton
    fun toCNF ((Var x))= Sin(Sin(L.Pos x))
        | toCNF (Not(Var x))=Sin(Sin(L.Neg x))
        | toCNF (And F)=
        Seq.flatten(Seq.map (toCNF) F)
        | toCNF (Or F)=
        Sin(
            Seq.flatten(
                Seq.flatten(Seq.map toCNF F)))
end (* functor Prop2 *)
