(* qatar Id: ______zihan zhou__________ *)

(* Left and right delimiters *)
datatype par = L of string | R of string
type pList = par list

(* Parse tree for parentheses *)
datatype pTree = empty                     (* no parentheses *)
               | nested of string * pTree  (* nested parentheses *)
               | sbs of pTree * pTree      (* side by side *)

(* Stack of either open parentheses or parse trees *)
datatype stackItem = OPEN of string
                   | T of pTree
type stack = stackItem list


(********************* Begin utility functions *********************)

(* pList_fromString s ==> ps
 * ENSURES: convert the string s of delimiters of the form "(s" or
            ")s" where s is any parenthesis-free string into the
            corresponding entity ps of type pList.
 *)
fun pList_fromString (s: string): pList =
  let
    datatype del = Ld (* left delimiter marker *)
                 | Rd (* right delimiter marker *)
    fun parsed (Ld, acc) = L (String.implode (rev acc))
      | parsed (Rd, acc) = R (String.implode (rev acc))
    fun scan ([]: char list, w: del * char list): pList = [parsed w]
      | scan (#"("::cs, w) = (parsed w) :: scan (cs, (Ld,[]))
      | scan (#")"::cs, w) = (parsed w) :: scan (cs, (Rd,[]))
      | scan (c::cs, (d,acc)) = scan (cs, (d, c::acc))
    fun pfs ([]: char list): pList = []
      | pfs (#"("::cs) = scan (cs, (Ld, []))
      | pfs (#")"::cs) = scan (cs, (Rd, []))
      | pfs cs = raise Fail ("Malformed delimiter string " ^ String.implode cs)
  in
    pfs (String.explode s)
  end

(* pList_toString ps ==> s
 * ENSURES: converts ps into the string s
 *)
fun pList_toString ([]: pList): string = ""
  | pList_toString ((L s)::ps) = "(" ^ s ^ pList_toString ps
  | pList_toString ((R s)::ps) = ")" ^ s ^ pList_toString ps

(* pTree_toString t ==> s
 * ENSURES: converts parse tree t into the string s
 *)
fun pTree_toString (empty: pTree): string = ""
  | pTree_toString (nested (s,t)) = "(" ^ s ^ pTree_toString t ^ ")" ^ s
  | pTree_toString (sbs (t1,t2)) = pTree_toString t1 ^
                                   pTree_toString t2

(* stack_toString S ==> s
 * ENSURES: converts stack S into the string s
 *)
fun stack_toString ([]: stack): string = "#"
  | stack_toString ((OPEN s)::S) = "(" ^ s^ " | " ^ stack_toString S
  | stack_toString (T t::S)  = pTree_toString t ^ " | " ^
                               stack_toString S

(********************** End utility functions **********************)

(*fun valid' ([]:pList,x:int,r:string):(bool * pList)=
    if x=0 then (true,[]) else (false,[])
    | valid' (p::pl,x,r)=
    if x<0 then (false,[])
    else
        case p of
            L(r) => valid'(pl,x+1,r)
            | R(r) => valid'(pl,x-1,r)
            | R(s) => 
                if x=0 then
            | L(s) => 
*)

fun valid' (pl,R(str1)::L(str2)::S)=
    if str1=str2 then valid'(pl,S) else false
    | valid' (p::pl,S)=valid'(pl,p::S)
    | valid' ([], _::_)=false
    | valid' ([]:pList, []:pList):bool = true

val s = "(d(a)a(b(c)c)b)d"
val pl=pList_fromString(s)
val true=valid'(pl,[])
val s2 = "(d(a)a(b)c)b)d"
val pl2=pList_fromString(s2)
val false=valid'(pl2,[])

fun valid(pl)=valid'(pl,[])

fun flattenPTree (empty: pTree): pList = []
    | flattenPTree (nested (s,t)) = L(s)::flattenPTree(t)@[R(s)]
    | flattenPTree (sbs (t1,t2)) = flattenPTree(t1)@flattenPTree(t2)



fun pp ([]:pList,[]:stack):pTree = empty
    | pp ([],T(pt)::nil)=pt
    | pp (L(str)::pl,S)=pp(pl,OPEN(str)::S)
    | pp (R(str1)::pl,OPEN(str2)::S)=
    if str1=str2 then pp(pl,T(nested(str1,empty))::S)
    else raise Fail "invalid pList or stack"
    | pp (R(str1)::pl,T(pt)::OPEN(str2)::S)=
    if str1=str2 then pp(pl,T(nested(str1,pt))::S)
    else raise Fail "invalid pList or stack"
    | pp (pl,T(pt1)::T(pt2)::S)=pp(pl,T(sbs(pt2,pt1))::S)

val pt=pp(pl,[])
val s3=pTree_toString(pt)
val true = (s=s3)

(*
parsePar(pl)==>t
requires valid(pl)
ensures pTree_toString(parsePar(pl))=pList_toString(pl)
    *)
fun parsePar(pl:pList):pTree = pp(pl,[])


  ;
