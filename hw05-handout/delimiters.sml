(* qatar Id: ______zihanz___________ *)


(* Left and right parentheses *)
datatype par = LPAR | RPAR
type pList = par list

(* Parse tree for parentheses *)
datatype pTree = empty                (* no parentheses *)
               | nested of pTree      (* nested parentheses *)
               | sbs of pTree * pTree (* side by side *)

(* Stack of either open parentheses or parse trees *)
datatype stackItem = OPEN
                   | T of pTree
type stack = stackItem list


(********************* Begin utility functions *********************)

(* pList_fromString s ==> ps
 * ENSURES: convert the string of parentheses s into the corresponding
            entity ps of type pList; raises an exception if s
            contains characters other than "(" and ")".
 *)
fun pList_fromString (s: string): pList =
  let
    fun pts ([]: char list): pList = []
      | pts (#"("::l) = LPAR :: pts l
      | pts (#")"::l) = RPAR :: pts l
      | pts ps = raise Fail ("Bad parentheses string starting at " ^
                              String.implode ps)
  in
    pts (String.explode s)
  end

(* pList_toString ps ==> s
 * ENSURES: converts ps into the string s
 *)
fun pList_toString ([]: pList): string = ""
  | pList_toString (LPAR::ps) = "(" ^ pList_toString ps
  | pList_toString (RPAR::ps) = ")" ^ pList_toString ps

(* pTree_toString t ==> s
 * ENSURES: converts parse tree t into the string s
 *)
fun pTree_toString (empty: pTree): string = ""
  | pTree_toString (nested t) = "(" ^ pTree_toString t ^ ")"
  | pTree_toString (sbs (t1,t2)) = pTree_toString t1 ^
                                   pTree_toString t2

(* stack_toString S ==> s
 * ENSURES: converts stack S into the string s
 *)
fun stack_toString ([]: stack): string = "#"
  | stack_toString (OPEN::S) = "( | " ^ stack_toString S
  | stack_toString (T t::S)  = pTree_toString t ^ " | " ^
                               stack_toString S

(********************** End utility functions **********************)
(*
valid(L)=tf
requires true
ensures tf is true if L is properly paired

    *)
fun valid'([]:pList,x)=
        if x=0 then true else false
    | valid'(p::pL,x)= 
        if x <0 then false
        else 
        case p of
             LPAR => valid'(pL,x+1)
            | RPAR => valid'(pL,x-1)
fun valid(L):bool = valid'(L,0)

val pl=pList_fromString("()(())()(())")
val pl2=pList_fromString("()(())()(()))")
val true=valid(pl)
val false=valid(pl2)


(* flattenPTree t ==> l
 * ENSURES: converts parse tree t into the plist l
 *)
fun flattenPTree (empty: pTree): pList= []
    | flattenPTree (nested t) = LPAR:: flattenPTree(t) @ [RPAR]
    | flattenPTree (sbs (t1,t2)) = flattenPTree t1 @ flattenPTree t2 

val a=empty
val b=nested a
val c=nested(sbs(b,b))
val l=flattenPTree(c)
val "(()())"=pList_toString(l)

(*
  pp(pl,s)==>pt
  requires pl and S are proper...
  ensures pl and S are still proper 
  *)
fun pp ([]:pList,[]:stack):pTree = empty
    | pp ([],T(pt)::nil)= pt
    | pp (LPAR::pl,s)=pp(pl,OPEN::s)
    | pp (RPAR::pl,OPEN::s)=pp (pl,T(nested empty)::s)
    | pp (RPAR::pl,T(pt)::OPEN::s)=pp (pl,T(nested pt)::s)
    | pp (pl,T(pt1)::T(pt2)::s)=pp(pl,T(sbs(pt2,pt1))::s)

    
val s1:stack=[]
val pl1=pList_fromString("((()())())()")
val true = valid(pl1)
val pt=pp(pl1,s1)
val pl2=flattenPTree(pt)
val true=(pl1 = pl2)

(* parsePar(pl)-->pt
  reuqires valid( pl) 
   ensures flattenPTree(pt)=pl*)
fun parsePar (pl:pList):pTree = pp(pl,[])






;

