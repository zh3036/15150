(* andrew Id: _________zihanz_____________ *)

structure Test =
struct
(* Use this structure for outside-the-box testing.  There is one
   section for each structure or functor you are asked to implement.
   Functors are pre-instantiated with provided parameters, but feel
   free to try more instances.  Use the nickname defined in each
   section to write your tests, but do not open any of these structures.
 *)

  structure Q = SeqUtil
  val (3,4) = Q.ppar (fn x=> x+1) (2,3);
  (* Insert tests for structure SeqUtil here *)
 val a=Seq.repeat 3 true;
 val b=Seq.cons false a;
 val c=Seq.repeat 3 false;
 val true= Q.all a;
 val false=Q.all b;
 val true=Q.some b;
 val false =Q.some c;

  structure U = Util (structure I = IntUtil
                      structure S = SeqUtil)

  structure A = Assignment (structure U = U
                            structure R = StrLetter)
  val a =(["A","F"],["B","C"])
  val b = A.fromList a;
  val  "[A: t, F: t, B: f, C: f]"=A.toString b
  val true = A.valid b;
  val (["A","F"],["B","C"])=A.toList b;
  val true = A.eval "A" b;
  val false = A.eval "B" b;
  (* Insert tests for functor Assignment here *)

  val   [[("A",false),("B",false),("C",false)],[("A",true),("B",false),("C",false)],
   [("A",false),("B",true),("C",false)],[("A",true),("B",true),("C",false)],
   [("A",false),("B",false),("C",true)],[("A",true),("B",false),("C",true)],
   [("A",false),("B",true),("C",true)],[("A",true),("B",true),("C",true)]]
  = map (Seq.toList) 
      (Seq.toList(A.genAll (Seq.fromList ["A","B","C"])))

  structure LS = Literal (StrLetter)
  structure P = Prop (structure U = U
                      structure L = LS)
  (* Insert tests for functor Prop here *)
  val e = P.Not (P.Or (P.Or (P.Var "A",P.And (P.Var "A",P.Var "A")),P.And (P.Var "A",P.Var "A")))
  val   P.And
    (P.And (P.Not (P.Var "A"),P.Or (P.Not (P.Var "A"),P.Not (P.Var "A"))),
     P.Or (P.Not (P.Var "A"),P.Not (P.Var "A")))= P.pushNot e

    val a= P.Var "a"
    val b= P.Var "b"
    val c=P.And(a,b)
    val d=P.Or(c,c)

    val v1= P.Var "V1"
    val v0=P.Var "V0"
    val v3 =P.Var "V3"
    val v4=P.Var "V4"
    val vv=P.And(P.Or(v4,v0),P.Or(v3,P.Or(P.False,P.Not(v1))))
    val xzv=P.distribute vv
    val P.And (P.Or (P.Var "V4",P.Var "V0"),P.Or (P.Var "V3",P.Or (P.False,P.Not (P.Var "V1"))))=P.distribute vv

  structure C = Cnf (structure U = U
                     structure L = LS
                     structure A = A)
  (* Insert tests for functor Cnf here *)
    val cv=P.And(vv,vv)
    val testletters=C.letters (P.toCNF cv)
    val  ["V0","V1","V3","V4"]=Seq.toList(testletters)
    val testev = C.eval (P.toCNF cv )
           (Seq.nth 3 (A.genAll (Seq.fromList ["V1","V0","V3","V4"])))
    val false = testev
    val av=P.Or(v1,P.Not(v1))
    val true=C.valid (P.toCNF av)

    val testsat=C.satisfiable (P.toCNF cv)
    val  ["[V0: t, V1: f, V3: f, V4: f]","[V0: t, V1: f, V3: t, V4: f]",
   "[V0: t, V1: t, V3: t, V4: f]","[V0: f, V1: f, V3: f, V4: t]",
   "[V0: t, V1: f, V3: f, V4: t]","[V0: f, V1: f, V3: t, V4: t]",
   "[V0: t, V1: f, V3: t, V4: t]","[V0: f, V1: t, V3: t, V4: t]",
   "[V0: t, V1: t, V3: t, V4: t]"] 
   =map A.toString (Seq.toList testsat);


    val us=P.And(v1,P.Not(v1))
    val true=C.unsat (P.toCNF us)





  structure P2 = Prop2 (structure U = U
                        structure L = LS)
  (* Insert tests for functor Prop here *)
    val a= P2.Var "a"
    val b= P2.Var "b"
    val l1=P2.And(Seq.fromList [ a,b,a,b,a,a,a ])
    val l2=P2.And(Seq.fromList[l1,b,a])
    val l3=P2.Or(Seq.fromList [l1,a,l2])
    val l4=P2.Not l3
    val l5=P2.Or(Seq.fromList [l3,l4,a])
    val l6=P2.pushNot l5
    (*val l7=P2.distribute l6*)

    val s1=P2.And(Seq.fromList [ a,b ])
    val s2=P2.Not(P2.Or(Seq.fromList[s1,b]))
    val s3=P2.Not(s2)
    val s4=P2.pushNot(s3)
    val s5=P2.distribute s4
    val c1=P2.toCNF s5

    val sb1=P2.And(Seq.fromList [a,b,a])
    val sb2=P2.And(Seq.fromList [sb1,sb1])
    val sb3=P2.And(Seq.fromList [sb2,sb1])
    val sth=P2.distribute sb3

end (* structure Test *)
