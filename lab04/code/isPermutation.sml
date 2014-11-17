val a : int list = [1,2,3,4]

fun member(a:int,[]:int list):bool=false
    | member(a:int,b::l)= if a=b then true else member(a,l)

fun remove(a:int,[]:int list):int list=[]
    | remove(a,b::l)=if a=b then l else b::remove(a,l)

fun isPermutation([]:int list,[]:int list):bool=true
    (*| isPermutation(a::l1,[])=false*)
    | isPermutation([],b::l2)=false
    | isPermutation(a::l1,l2)=
    if member(a,l2) then isPermutation(l1,remove(a,l2))
    else false
;
