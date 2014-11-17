(* Duplicates are permitted in the insert/union functions *)
(* intset.sig contains descriptions of all the functions *)
structure SetKeepDuplicates : INTSET =
struct
    type set = int list

    val empty = [] (* Change me *)
    fun member (_:int, []):bool = false
        | member (a,e::s)= if a=e then true else member(a,s)

    fun insert (a,s) = a::s
        (*| insert (a,e::s) = if a=e then a::e::s else insert(a,s)*)

    fun delete (_,[]) = []
        | delete (a,e::s) = if a=e then delete(a,s) else e::delete(a,s)

    fun union(a,b)=a @ b
    fun intersection([],s)=[]
        | intersection(e::a,b)= 
            if member(e,b) then e::intersection(a,b)
            else intersection(a,b)

    fun difference(s,[])=s
        | difference([],s)=[]
        | difference(e::s1,s2)=
            if member(e,s2) then difference(s1,s2)
            else e::difference(s1,s2)

    fun equal(a,b)= difference(a,b)=[] andalso difference(b,a)=[]
end 
;