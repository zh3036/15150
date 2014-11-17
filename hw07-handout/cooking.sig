signature COOKING =
sig
  type ingr     = string
  type dish     = string
  type recipe   = dish * dish list
  type cookBook = recipe list
  type fridge   = ingr list

  val lookupRecipe: dish -> cookBook -> dish list option
  val checkFridge: ingr -> fridge -> bool
  val canMakeDish: dish -> fridge -> cookBook -> (unit -> bool) -> bool
  val canFindIngr: ingr list -> fridge -> cookBook -> (unit -> bool) -> bool
  val canCook: dish -> fridge -> cookBook -> bool
  val missingIngr: dish -> fridge -> cookBook -> (ingr list -> ingr list)
               -> ingr list
  val missingIngrList: ingr list -> fridge -> cookBook -> (ingr list -> ingr list)
               -> ingr list
  val marketRun: dish ->  fridge -> cookBook -> ingr list

  val feasible: dish list -> cookBook -> fridge -> (dish list -> dish list)
            -> dish list
  val canMake: cookBook -> fridge -> dish list

end (* signature COOKING *)
