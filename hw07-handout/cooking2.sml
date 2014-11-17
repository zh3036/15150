(* andrew Id: _________________________________ *)

structure Cooking2: COOKING2 =
struct
  type ingr = real * string
  type dish = real * string
  type recipe = dish * dish list
  type cookBook = recipe list
  type fridge = ingr list

  datatype status = Pos of ingr
                  | Neg of ingr

  fun lookupRecipe _ = raise Fail "Unimplemented"
  fun checkFridge  _ = raise Fail "Unimplemented"

  fun canMakeDish _ = raise Fail "Unimplemented"
  and canFindIngr _ = raise Fail "Unimplemented"
  fun canCook     _ = raise Fail "Unimplemented"

  fun missingIngr     _ = raise Fail "Unimplemented"
  and missingIngrList _ = raise Fail "Unimplemented"
  fun marketRun       _ = raise Fail "Unimplemented"

  fun feasible _ = raise Fail "Unimplemented"
  fun canMake  _ = raise Fail "Unimplemented"

end (* structure Cooking2 *)
