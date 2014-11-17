(* qatar Id: zihanz *)

datatype treeS = emptyS
    | leafS of char
    | nodeS of treeS * treeS

(*traverseS(x)==>y
requires true
ensures y is a list of char in x *)

fun traverseS (emptyS:treeS):char list = []
    | traverseS (leafS c)=[c]
    | traverseS (nodeS(a,b))=traverseS(a)@traverseS(b)

val a:treeS=nodeS(leafS #"a",leafS #"b")
val [#"a",#"b"]=traverseS(a)

(*canoical(x)==>y
    reuqires true
    ensures y is whether canonical or not 
    *)
fun canonical(emptyS:treeS):bool = true
    | canonical(leafS _)=true
    | canonical(nodeS(a,b))=
    if a=emptyS orelse b=emptyS then false 
    else 
        canonical(a) andalso canonical(b)

val true=canonical(a)

(*simplify(x)=y
    requires true
    ensures traverse(x)=traverse(y)
    ensures canoical (y)
    *)
fun simplify (emptyS:treeS):treeS=emptyS
    | simplify (leafS c)=leafS c
    | simplify (nodeS(a,emptyS))=simplify(a)
    | simplify (nodeS(emptyS,b))=simplify(b)
    | simplify (nodeS(a,b))=
    let
        val nodeS(x,y) = nodeS(simplify(a),simplify(b))
    in
        if  not (x = emptyS) andalso not (y=emptyS )
        then nodeS(x,y)
        else simplify(nodeS(x,y))
    end
        

val b:treeS=nodeS(a,emptyS)
val c:treeS=nodeS(b,nodeS(emptyS,emptyS))
val nodeS (leafS #"a",leafS #"b")= simplify(b)
val nodeS (leafS #"a",leafS #"b")=simplify(c)

fun simplify_safe (t:treeS):treeS = 
    let
        val t' = simplify(t)
    in
        if canonical(t') andalso traverseS(t')=traverseS(t) then t'
        else raise Fail "Ensures falied"
    end
    


;