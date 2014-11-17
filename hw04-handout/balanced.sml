(* qatar Id: __zihanz_______________ *)

datatype tree = empty
              | node of tree * char * tree

datatype treeC' = leafC of char
                | nodeC of treeC' * treeC'
datatype treeC  = emptyC
                | T of treeC'


(* inorder t ==> l
   ENSURES: l is the inorder traversal of t
 *)
fun inorder (empty: tree): char list = []
  | inorder (node(tL, c, tR)) = (inorder tL) @ (c :: inorder tR)

(* size t ==> n
   ENSURES: n is the number of elements in t
 *)
fun size (empty: tree): int = 0
  | size (node(tL, _, tR)) = 1 + size tL + size tR

(* height t ==> n
   ENSURES: n is the height of tree t
 *)
fun height (empty: tree): int = 0
  | height (node(tL, _, tR)) = 1 + Int.max(height tL, height tR)

(* balanced t ==> b
   ENSURES: b iff the heights of the left and right subtree of every inner
            node differ by at most 1
 *)
fun balanced (empty: tree) : bool = true
  | balanced (node(tL, _, tR)) =
    let
      val hl = height tL
      val hr = height tR
    in
      Int.abs(hl - hr) <= 1 andalso balanced tL andalso balanced tR
    end


(* If you need any function you defined in canonical.sml to define the
   following functions, copy it between the following comments *)

(* Begin code my canonical.sml *)

fun traverseC(emptyC:treeC):char list=[]
    | traverseC(T(leafC c))=[c]
    | traverseC(T(nodeC(tl,tr)))=
    traverseC(T(tl))@traverseC(T(tr))

(* End code from my canonical.sml *)
(*getdelRM(tc)=(chr,tc2)
    requires tc != empty
    ensures chr is the right most chr of tc,
    ensures tc2 is a treeC by removing the right most elem of tc*)
fun getdelRM(emptyC:treeC):(char * treeC)=raise Fail "empty!"
    | getdelRM(T(leafC c))=(c,emptyC)
    | getdelRM(T(nodeC(tL,leafC c)))=(c,T(tL))
    | getdelRM(T(nodeC(tL,tR)))=getdelRM(T(tR))
val a = T (nodeC (leafC #"a",leafC #"b")) : treeC
val (#"b",T (leafC #"a")) : char * treeC=getdelRM(a)
(*convert(tc)=t
    requires true
    ensures inorder(t)=traverseC(tc)*)
fun convert(emptyC:treeC):tree=empty
    | convert(T(leafC c)):tree=node(empty,c,empty)
    | convert(T(nodeC(tL,tR)))=
    let
        val (c,tL') = getdelRM(T(tL))
    in
        node(convert(tL'),c,convert(T(tR)))
    end


fun convert_safe(tc:treeC):tree=
    let
        val t = convert(tc)
    in
        if (inorder(t)=traverseC(tc)) then t
        else
            raise Fail "ensures failed"
    end

val node (empty,#"a",node (empty,#"b",empty)) : tree= convert_safe(a)

;
(* splitN(t,i)=(tl,tr)
    requires i <= size(t)
    ensures size(tl) =i
    ensures inorder(tl)@inorder(tr)=inorder(t)
    *)
fun splitN(empty:tree,_:int):(tree * tree) = (empty,empty)
    | splitN(node(tL,c,tR),i)=
    if size(tL)=i then (tL,node(empty,c,tR))
    else 
        if size(tL) < i 
        then 
            let
                val (r_tL,r_tR) = splitN(tR,i-size(tL)-1)
            in
                (node(tL,c,r_tL),r_tR)
            end
        else      
            let 
                val (l_tL,l_tR)=splitN(tL,i)
            in
                (l_tL,node(l_tR,c,tR))
            end

val  (node (empty,#"a",empty),node (empty,#"b",empty)) = splitN(convert(a),1)
val b:tree=node(node(convert(a),#"d",convert a),#"c",empty)
val (x,y)=splitN(b,2)
val [#"a",#"b",#"d",#"a",#"b",#"c"] = inorder(b)
val node (empty,#"a",node (empty,#"b",empty))=x
val [#"d",#"a",#"b",#"c"]=inorder(y)
;
(*
leftmost(t)=(c,t')
requires c!=empty
ensures c::inorder(t')=inorder(t)
ensures length(inorder(t'))+1=length(inorder(t))
    *)
(*fun leftmost'(empty:tree):(char * tree)=raise Fail "no empty!"
    | leftmost'(node(empty,c,tR))=(c,tR)
    | leftmost'(node(tL,c,tR))=
    let
        val (lc,ltR) = leftmost(tL)
    in
        (lc,node(ltR,c,tR))
    end*)

fun leftmost(t:tree):(char * tree) = 
    let 
        val (node(_,c,_),t2)=splitN(t,1)
    in
        (c,t2)
    end

val (#"a",node (empty,#"b",empty)) = leftmost(convert(a))


(*fun halves(empty:tree):(tree*char*tree)=raise Fail "no empty"
    | halves(node(empty,c,empty))=(empty,c,empty)
    | halves(t)=
    let
        val (tL,tR)=splitN(t,size(t) div 2)
    in
        let 
            val (c,tR')=leftmost(tR)
        in
            (node(halves tL) ,c,node(halves tR'))
        end
    end*)
(*
halves(t)=(t1,c,t2)
requires t != empty
ensures size(t1)=size(t) div 2
ensures inorder(t1) @ c::inorder(t2)= inorder(t)
    *)
fun halves(empty:tree):(tree*char*tree)=raise Fail "no empty"
    | halves(node(empty,c,empty))=(empty,c,empty)
    | halves(t)=
    let
        val (tL,tR)=splitN(t,size(t) div 2)
    in
        let 
            val (c,tR')=leftmost(tR)
        in
            (tL,c,tR')
        end
    end
val k = convert(a)
val (node (empty,#"a",empty),#"b",empty)=halves(k)

(*
rebalance(t)=bt
requires true
ensures inorder(bt)=inorder(t)
ensures balanced(bt)
    *)
fun rebalance(empty:tree):tree= empty
    | rebalance(t)=
    let 
        val (tL,c,tR)=halves(t)
    in
        node(rebalance tL,c,rebalance tR)
    end

val k = rebalance(b)
val j = inorder(b)
val true = balanced(k)
val true = (j=inorder(k))

    ;
