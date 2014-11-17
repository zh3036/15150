(* Duplicates are permitted in the insert/union functions *)
(* intset.sig contains descriptions of all the functions *)
structure SetNoDuplicates : INTSET =
struct
    type set = int list

    val empty = [] (* Change me *)
    fun member (_:int, []):bool = false
        | member (a,e::s)= if a=e then true else member(a,s)

    fun insert (a,[]) = a::nil
        | insert (a,e::s) = if a=e then e::s else e::insert(a,s)

    fun delete (_,[]) = []
        | delete (a,e::s) = if a=e then s else e::delete(a,s)

    fun intersection([],s)=[]
        | intersection(e::a,b)= 
            if member(e,b) then e::intersection(a,b)
            else intersection(a,b)
        
    fun difference(s,[])=s
        | difference([],_)=[]
        | difference(e::s1,s2)=
            if member(e,s2) then difference(s1,s2)
            else e::difference(s1,s2)


    fun union([],b)=b
        | union(a::s1,s2)=
            if member(a,s2) then union(s1,s2) 
            else a::union(s1,s2)

    fun equal(a,b)= difference(a,b)=[] andalso difference(b,a)=[]
end 
;