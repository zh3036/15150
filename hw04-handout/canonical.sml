(* qatar Id: zihanz *)

datatype treeC' = leafC of char
                | nodeC of treeC' * treeC'
datatype treeC  = emptyC
                | T of treeC'

datatype treeS = emptyS
               | leafS of char
               | nodeS of treeS * treeS


(* If you need any function you wrote in sloppy.sml to define the
   following functions, copy them between the following comments *)

(*********************** Begin code from sloppy.sml ***********************)

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

(************************ End code from sloppy.sml ************************)

(*traverseC(x)==>y
    requires true
    ensures y is a list of char in x
*)

fun traverseC(emptyC:treeC):char list=[]
    | traverseC(T(leafC c))=[c]
    | traverseC(T(nodeC(tl,tr)))=
    traverseC(T(tl))@traverseC(T(tr))

val [#"a",#"b"]=traverseC(T(nodeC(leafC #"a",leafC #"b")))
(*convertCan'(x)=->y
    requires x!= emtpyS andalso canonical(x)
    ensures traverseC(T(y))=traverseS(x)
    *)

fun convertCan'(leafS c:treeS):treeC'=leafC c
    | convertCan'(nodeS(x,y))=
        nodeC(convertCan' x, convertCan' y)
val nodeC (leafC #"a",leafC #"b") : treeC'= convertCan'(a)
(*concertCan(x)==>y
    requires canonical(x)
    ensures  traversS(x)=traverseC(y)
*)
fun convertCan(emptyS:treeS):treeC=emptyC
    | convertCan(t)=T(convertCan'(t))

val T(nodeC (leafC #"a",leafC #"b")): treeC= convertCan(a)  



fun convertCan_safe(t:treeS):treeC=
    if not (canonical t) then 
        raise Fail "Requires specs falied"
    else
        let
            val t':treeC = convertCan(t)
        in
            if traverseC(t')=traverseS(t) then t'
            else 
                raise Fail "Ensures specs failed"
        end

val T(nodeC (leafC #"a",leafC #"b")): treeC= convertCan_safe(a)  

(* convertSloppy(x)==>y
    requires true
    ensures traverseC(y)=traverseS(x) *)

fun convertSloppy(t:treeS):treeC=
    let
        val t' = simplify_safe(t)
    in
        convertCan_safe(t')
    end

val T(nodeC (leafC #"a",leafC #"b")): treeC= convertSloppy(c)  

;
