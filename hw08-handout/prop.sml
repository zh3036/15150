(* andrew Id: _______zihanz_______________ *)

functor Prop (structure U: UTIL
              structure L: LITERAL) : PROP where L=L =
struct
  structure L = L
  structure R = L.R

  datatype fla = Var of R.letter
               | True
               | False
               | And of fla * fla
               | Or  of fla * fla
               | Not of fla

val p=U.ppar
  (* toString F ==> s
     ENSURES: s is a string representation of F
   *)
  fun toString (Var l: fla): string = R.toString l
    | toString True  = "t"
    | toString False = "f"
    | toString (And (F1,F2)) = "("^ toString F1 ^" & "^ toString F2 ^")"
    | toString (Or  (F1,F2)) = "("^ toString F1 ^" | "^ toString F2 ^")"
    | toString (Not F) = "~" ^ toString F

  (* eq (F1,F2) ==> b
     ENSURES: b == true iff F1 and F2 are syntactically identical formulas
   *)
  fun eq (Var l1: fla,  Var l2: fla): bool = R.eq (l1,l2)
    | eq (True,         True)         = true
    | eq (False,        False)        = true
    | eq (And(F1a,F1b), And(F2a,F2b)) = eq (F1a,F2a) andalso eq (F1b,F2b)
    | eq (Or(F1a,F1b),  Or(F2a,F2b))  = eq (F1a,F2a) andalso eq (F1b,F2b)
    | eq (Not F1,       Not F2)       = eq (F1,F2)
    | eq _ = false
  
  (* pushNot F ==> F'
     ENSURES: F' is a formula equivalent to F where all the negation
              are pushed to the propositional letters.
   *)

    fun pushNot (Not(True))=False
        | pushNot (Not(False))=True
        | pushNot (Not(And(F1,F2)))=
        Or(p pushNot (Not F1 ,Not F2 ))        
        | pushNot (Not(Or(F1,F2)))=
        And(p pushNot (Not F1 ,Not F2 ))
        | pushNot (Not(Not(x)))=pushNot(x)
        | pushNot(And(x,y))=And(p pushNot (x,y))
        | pushNot (Or(x,y))=Or(p pushNot (x,y))
        | pushNot x=x

(*
    #Analysis
    Work and Span of pushnot and eq and toString  is same.
    Because they have at most two recursive call each time
    and the nested level of them always decrease by 1 for
    each recursive call

    W_3(d)=W(d-1)*2+c
    W_3(d)=O(2**d)

    S_3(d)=S(d-1)+c
    S_3(d)=O(d)
    *)



    fun distribute (Or(_,True))=True
        | distribute (Or(True, _))=True


        | distribute (Or(F,And(F1,F2)))=
        And(p distribute ((Or(p distribute (F,F1))),
                    (Or(p distribute (F,F2)))))
        
        | distribute (Or(And(F1,F2),F))=
        And(p distribute ((Or(p distribute (F,F1))),
                    (Or(p distribute (F,F2)))))

        | distribute (And(F1,F2))=
        And(p distribute (F1,F2))

        | distribute (a as (Or(F1,F2)))=
        let 
            val x=Or( p distribute (F1,F2))
        in
            if eq(x,a) then x else distribute x
        end

        | distribute (Not x)= Not(distribute x)
        
        | distribute x= x

(*
    #Analysis
    distribute k=>k'
    Span_dis is simillar to the work of last three functions
    however, in one step, if k is Or(a,b) and both a and b 
    is not And or True, then the nested level does not change.
    and it stops only when k'=k.
    if a or b is false or var, then it will definitely not change, and
    will cause the terminiation.
    so we wonly discuss when a or b is OR.
    and the only case the nested level is not decreasing
    is when there is a AND deep in the nested OR,
    then we need d steps to reach the AND and make everything
    esle fine and d steps to bring AND up, and keep the rest
    satify the invariant. So it totally need 2d steps As span.
    So S_dis(d)=d
    and W_dis(d)=2**d
    *)


  (* toCNF F ==> F'
     ENSURES: F' is a CNF formula equivalent to F
     I think i must assume F does not have true or false inside
   *)

    val Sin=Seq.singleton
    fun toCNF ((Var x))= Sin(Sin(L.Pos x))
        | toCNF (Not(Var x))=Sin(Sin(L.Neg x))
        | toCNF (Or(False,x))=toCNF x
        | toCNF (Or(x,False))=toCNF x
(*        | toCNF(And(_,False))=False
        | toCNF (And(False,_))=False*)
        | toCNF (And(True,x))=toCNF x
        | toCNF (And(x,True))=toCNF x
        | toCNF (And(x,y))=if eq(x,y) then toCNF(x)
        else
            Seq.append (toCNF x) (toCNF y)
        | toCNF (Or(x,y))=if eq(x,y) then toCNF(x) 
        else
          Sin(
            Seq.flatten(
                Seq.append (toCNF x) (toCNF y) ))

(*
    #Analysis
    in worst case
    W_cnf(d)
    =W_cnf(d-1)+W_append(2**d)+W_flatten(2**d)
    =O(d)*O(2**d)
    =O(2**d)

    S_cnf(d)
    =S_cnf(d-1)+S_apeend(2**d)+W_flatten(2**d)
    =O(d)*O(1)
    =O(d)

    *)

        (*| toCNF *)
end (* functor Prop *)
