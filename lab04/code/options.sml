(* Example of using int options *)
(* indexAt(x,L): int * int list -> int option
 * REQUIRES: true
 * ENSURES: if x is not in L, then return NONE.
 *          if x in L, return SOME y, where y is the
 *          index of x in L.
 *
 *  Note: in the recursive case, we have to deal with the
 *        possibility that the recursive call is either
 *        NONE or SOME z.
*)
fun indexAt(x: int, nil: int list): int option = NONE
  | indexAt(x, y::L) =
      if x = y
        then SOME 0
        else
          case indexAt(x,L)
            of NONE   => NONE
             | SOME z => SOME (z+1)

val NONE = indexAt(5, [1,2,3,4])
val SOME 3 = indexAt(3, [0,1,2,3])
val SOME 0 = indexAt(0, [0,1,2,3])


(* Insert documentation here *)
fun checkAndGet (x:int,[]:int list):int list option=NONE
    | checkAndGet(x,y::l)=
        if x=y
            then SOME l
        else
            case checkAndGet(x,l) of
                 NONE   => NONE
                | SOME l' => SOME (y::l')

;
(* insert test cases here *)


(* Insert documentation here*)
fun isPermutation2 _ = raise Fail "unimplemented"

(* insert test cases here *)


