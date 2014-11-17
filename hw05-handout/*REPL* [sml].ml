Standard ML of New Jersey v110.76 [built: Sat Aug 23 12:34:55 2014]
- [autoloading]
[library $smlnj/compiler/current.cm is stable]
[library $smlnj/compiler/x86.cm is stable]
[library $smlnj/viscomp/core.cm is stable]
[library $smlnj/viscomp/basics.cm is stable]
[library $smlnj/viscomp/elabdata.cm is stable]
[library $smlnj/viscomp/elaborate.cm is stable]
[library $SMLNJ-BASIS/basis.cm is stable]
[library $smlnj/viscomp/debugprof.cm is stable]
[library $SMLNJ-LIB/Util/smlnj-lib.cm is stable]
[library $smlnj/MLRISC/Control.cm is stable]
[library $SMLNJ-MLRISC/Control.cm is stable]
[library $controls-lib.cm(=$SMLNJ-LIB/Controls)/controls-lib.cm is stable]
[library $smlnj/smlnj-lib/controls-lib.cm is stable]
[autoloading done]
[autoloading]
[autoloading done]
stdIn:101.5-106.27 Warning: match nonexhaustive
          (nil,nil) => ...
          (LPAR :: pl,s) => ...
          (RPAR :: pl,OPEN :: s) => ...
          (RPAR :: pl,T pt :: OPEN :: s) => ...
          (pl,T pt1 :: T pt2 :: s) => ...
          (nil,T pt :: s) => ...
  
datatype par = LPAR | RPAR
type pList = par list
datatype pTree = empty | nested of pTree | sbs of pTree * pTree
datatype stackItem = OPEN | T of pTree
type stack = stackItem list
val pList_fromString = fn : string -> pList
val pList_toString = fn : pList -> string
val pTree_toString = fn : pTree -> string
val stack_toString = fn : stack -> string
val valid' = fn : pList * int -> bool
val valid = fn : pList -> bool
val pl = [LPAR,RPAR,LPAR,LPAR,RPAR,RPAR,LPAR,RPAR,LPAR,LPAR,RPAR,RPAR] : pList
val pl2 = <hidden-value> : pList
val flattenPTree = fn : pTree -> pList
val a = empty : pTree
val b = nested empty : pTree
val c = nested (sbs (nested empty,nested empty)) : pTree
val l = [LPAR,LPAR,RPAR,LPAR,RPAR,RPAR] : pList
val pp = fn : pList * stack -> pTree
val s1 = [] : stack
val pl1 = [LPAR,LPAR,LPAR,RPAR,LPAR,RPAR,RPAR,LPAR,RPAR,RPAR,LPAR,RPAR]
  : pList
val pt =
  sbs
    (nested (sbs (nested (sbs (nested empty,nested empty)),nested empty)),
     nested empty) : pTree
val pl2 = [LPAR,LPAR,LPAR,RPAR,LPAR,RPAR,RPAR,LPAR,RPAR,RPAR,LPAR,RPAR]
  : pList
val parsePar = fn : pList -> pTree
- stdIn:228.5-233.27 Warning: match nonexhaustive
          (nil,nil) => ...
          (LPAR :: pl,s) => ...
          (RPAR :: pl,OPEN :: s) => ...
          (RPAR :: pl,T pt :: OPEN :: s) => ...
          (pl,T pt1 :: T pt2 :: s) => ...
          (nil,T pt :: s) => ...
  
datatype par = LPAR | RPAR
type pList = par list
datatype pTree = empty | nested of pTree | sbs of pTree * pTree
datatype stackItem = OPEN | T of pTree
type stack = stackItem list
val pList_fromString = fn : string -> pList
val pList_toString = fn : pList -> string
val pTree_toString = fn : pTree -> string
val stack_toString = fn : stack -> string
val valid' = fn : pList * int -> bool
val valid = fn : pList -> bool
val pl = [LPAR,RPAR,LPAR,LPAR,RPAR,RPAR,LPAR,RPAR,LPAR,LPAR,RPAR,RPAR] : pList
val pl2 = <hidden-value> : pList
val flattenPTree = fn : pTree -> pList
val a = empty : pTree
val b = nested empty : pTree
val c = nested (sbs (nested empty,nested empty)) : pTree
val l = [LPAR,LPAR,RPAR,LPAR,RPAR,RPAR] : pList
val pp = fn : pList * stack -> pTree
val s1 = [] : stack
val pl1 = [LPAR,LPAR,LPAR,RPAR,LPAR,RPAR,RPAR,LPAR,RPAR,RPAR,LPAR,RPAR]
  : pList
val pt =
  sbs
    (nested (sbs (nested (sbs (nested empty,nested empty)),nested empty)),
     nested empty) : pTree
val pl2 = [LPAR,LPAR,LPAR,RPAR,LPAR,RPAR,RPAR,LPAR,RPAR,RPAR,LPAR,RPAR]
  : pList
val parsePar = fn : pList -> pTree
- stdIn:329.27-329.32 Error: unbound variable or constructor: body2
stdIn:328.21-328.29 Error: operator and operand don't agree [tycon mismatch]
  operator domain: pList * int * string
  operand:         unit
  in expression:
    valid' ()
- nil:nil;
stdIn:1.6-1.9 Error: unbound type constructor: nil
- nil::nil;
val it = [[]] : 'a list list
- nil::[];
val it = [[]] : 'a list list
- stdIn:420.5-421.36 Warning: match nonexhaustive
          (nil,nil) => ...
          (nil,_ :: _) => ...
  
datatype par = L of string | R of string
type pList = par list
datatype pTree = empty | nested of string * pTree | sbs of pTree * pTree
datatype stackItem = OPEN of string | T of pTree
type stack = stackItem list
val pList_fromString = fn : string -> pList
val pList_toString = fn : pList -> string
val pTree_toString = fn : pTree -> string
val stack_toString = fn : stack -> string
val valid' = fn : pList * stack -> bool
val flattenPTree = fn : 'a -> 'b
val pp = fn : 'a -> 'b
val parsePar = fn : 'a -> 'b
- valid'([],[OPEN]);
stdIn:431.1-431.18 Error: operator and operand don't agree [tycon mismatch]
  operator domain: pList * stack
  operand:         par list * (string -> stackItem) list
  in expression:
    valid' (nil,OPEN :: nil)
- valid'([],[OPEN,OPEN]);
stdIn:1.2-340.4 Error: operator and operand don't agree [tycon mismatch]
  operator domain: pList * stack
  operand:         par list * (string -> stackItem) list
  in expression:
    valid' (nil,OPEN :: OPEN :: nil)
- valid'([],[T empty]);
val it = false : bool
- valid'([],[L "s"]);
stdIn:432.1-432.19 Error: operator and operand don't agree [tycon mismatch]
  operator domain: pList * stack
  operand:         par list * par list
  in expression:
    valid' (nil,L "s" :: nil)
- stdIn:512.5-513.36 Warning: match nonexhaustive
          (nil,nil) => ...
          (nil,_ :: _) => ...
  
datatype par = L of string | R of string
type pList = par list
datatype pTree = empty | nested of string * pTree | sbs of pTree * pTree
datatype stackItem = OPEN of string | T of pTree
type stack = stackItem list
val pList_fromString = fn : string -> pList
val pList_toString = fn : pList -> string
val pTree_toString = fn : pTree -> string
val stack_toString = fn : stack -> string
val valid' = fn : pList * pList -> bool
val flattenPTree = fn : 'a -> 'b
val pp = fn : 'a -> 'b
val parsePar = fn : 'a -> 'b
- valid'([],[L "s"]);
val it = false : bool
- valid'([],[]);
val it = true : bool
- stdIn:605.5-608.46 Error: duplicate variable in pattern(s): str
- datatype par = L of string | R of string
type pList = par list
datatype pTree = empty | nested of string * pTree | sbs of pTree * pTree
datatype stackItem = OPEN of string | T of pTree
type stack = stackItem list
val pList_fromString = fn : string -> pList
val pList_toString = fn : pList -> string
val pTree_toString = fn : pTree -> string
val stack_toString = fn : stack -> string
val valid' = fn : par list * par list -> bool
val flattenPTree = fn : 'a -> 'b
val pp = fn : 'a -> 'b
val parsePar = fn : 'a -> 'b
- valid'([],[L "s"]);
val it = false : bool
- valid'([],[]);
val it = true : bool
- valid'([],[L "s",R "s"]);
val it = false : bool
- valid'([],[R "s",L "s"]);