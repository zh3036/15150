structure TestSeqUtil =
struct
    val test0 = Seq.fromList [84, 32, ~4, 0]
    val test1 = Seq.map (fn x => ((),x)) test0

    val min0 = SeqUtil.reduce1 (fn (x,y) => if x < y then x else y) test0

    structure O = OrderedExt (Pair2Ordered (structure Left = UnitOrdered
                                            structure Right= IntOrdered))
    val test = SeqUtil.reduce1 O.min test1

end (* structure TestSeqUtil *)
