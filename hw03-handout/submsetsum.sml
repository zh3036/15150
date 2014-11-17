(* qatar Id: Zihanz____________________ *)

type certificate = int list
(*valid(i,l)--> x
* requires true
* ensures x gives bool for whether i is vaild.
*)
fun valid(i:int,l:int list):bool=
  if i<0 then false
  else if i>length(l)-1 then false
  else true 
val true= valid(1,[1,2,3])
val false= valid(1,[])
(* ith(i,l)==>y
* requires valid(i,l)
* ensures ith(i,l) is the ith elem of l
*)
fun ith(0:int,a::l:int list):int=a
  | ith(x,a::l)=ith(x-1,l)
val a:int list=[1,2,3,4,5,6]
val 3=ith(2,a)
val 4=ith(3,a)

(*inlist(i,l)-->y
* requires true
* ensures y is true if i in l false otherwise
*)
fun inlist(_:int,[]:int list):bool=false
  | inlist(x,a::l)= if x = a then true else inlist(x,l) 
val true = inlist(1,[1])
val false= inlist(0,[1])

(*valid_cert(lc,l)==>y
* requires true
* ensures y is true if lc is valid cert false otherwise
*)

fun valid_cert([]:certificate,_:int list):bool = true
  | valid_cert(a::lc,l)
    =valid(a,l) 
    andalso valid_cert(lc,l) 
    andalso not (inlist(a,lc))
val l=[1,2,3,4,5]
val c=[2,3]
val c2=3::c;
val c3=8::c;
val true = valid_cert(c,l)
val false= valid_cert(c2,l)
val false= valid_cert(c3,l)


(*indirect_add(lc,l)=>S
* requires valid_cert(lc,l)
* ensures S is the sum of all indices in lc of l.
*)
fun indirect_add([]:certificate,_:int list):int = 0
  | indirect_add(a::lc,l)=ith(a,l)+indirect_add(lc,l)
val a=[1,~2,3]
val b=[0,1]
val ~1=indirect_add(b,a)

(* smSum(i,l)-->y
* requires true
* ensures y is true if some submulist of l add up to i 
* and false otherwise
*)

fun smSum(i:int,[]:int list):bool=if i=0 then true else false
(*  | smSum(i,a::[])= if i=a then true else false*)
  | smSum(i,a::l)=if i=a then true 
                  else smSum(i-a,l) orelse smSum(i,l)


val a:int list = [1,2,2,4,~4,~10]
val true = smSum(~6,a)
val false = smSum(100,a)

(* smSum_cert(i,l)-->(b,y)
* requires true
* ensures b is true if some submulist y(in indices)
* of l add up to i and false otherwise(y=[]) , 
*)
fun smSum_c'(i:int,[]:int list,c:int list
            ,acc:int):(bool*(int list))
    = if i=0 then (true,c) else (false,[])
(*  | smSum_c'(i,a::[],cert)
    = if i=a orelse i=0
      then (true,a::cert)
      else (false,[])*)
  | smSum_c'(i,a::l,cert,acc)
    = if i=0 then (true,cert)
      else 
      let 
        val (b1,c1)=smSum_c'(i-a,l,acc::cert,acc+1)  
        val (b2,c2)=smSum_c'(i,l,cert,acc+1)
      in 
        if b1 then (b1,c1)
        else if b2 then(b2,c2)
        else (false,[])
      end

fun smSum_cert(i:int,l:int list):(bool*(int list))=
    smSum_c'(i,l,[],0)

val a:int list = [1,2,2,4,4,10,~1,~15,14,~54]
val (false,[]) = smSum_cert(100,a)
val (true,[7,6,4,3,1,0])=smSum_cert(~5,a)
val (true,[8,7,6,5,3,2,1,0])=smSum_cert(17,a)

(* smSum_check(i,l)-->y
* requires true 
* ensures y is true when smSum_cert(i,l) gives (true,c) and 
* the elem of c indirect adds up to i, and false otherwise.
*)
fun smSum_check(i:int,l:int list):bool=
  let 
    val (b,c)=smSum_cert(i,l)
  in 
    if b andalso valid_cert(c,l) 
      then (indirect_add(c,l)=i)
    else false
  end
val true =  smSum_check(~5,a)
val true =  smSum_check(17,a)
