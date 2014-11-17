(* andrew Id: _________zihanz___________ *)

structure Cooking: COOKING =
struct
  type ingr = string
  type dish = string
  type recipe = dish * dish list
  type cookBook = recipe list
  type fridge = ingr list

  (* lookupRecipe d B ==> l
     ENSURES:
       - l = SOME ingr if cookBook B has recipe ingr for dish d
       - l = NONE otherwise
   *)
  fun lookupRecipe (d: dish) ([]: cookBook): ingr list option = NONE
    | lookupRecipe d ((d',ingr)::B) = 
        if d=d'
          then SOME ingr
          else lookupRecipe d B

  (* checkFridge d F ==> b
     ENSURES: b iff fridge F contains ingredient/dish d
   *)
  fun checkFridge (d: ingr) ([]: fridge): bool = false
    | checkFridge d (d'::F) = d = d' orelse checkFridge d F
(*
canMakeDish d F B k => b

ensures b iff with F and B d can be made and k()=true
    *)

    fun canMakeDish d F B k=
            case checkFridge d F of
                true => k()
                | false => 
            case (lookupRecipe d B) of
                   NONE => false
                   | SOME iL => (canFindIngr iL F B k) andalso k()
(*
canFindIngr I F B k=> b
ensures b iff all elem in I can be get from F and B and k()= true
    *)

    and canFindIngr [] F B k = k()
        | canFindIngr (ing::ings) F B k =
            canFindIngr ings F B (fn()=>
             canMakeDish ing F B k)
            
  (* canCook d f B ==> b
     ENSURES: b = true iff dish d can be prepared from ingredients
              in fridge F according to cookbook B
   *)
  fun canCook (d: dish) (F: fridge) (B: cookBook): bool =
        canMakeDish d F B (fn () => true)

(*missingIngr d F B k=>L
ensures L=k(l) iff l is all missing ings for d with F and B 
    *)

    fun missingIngr d F B k=
        case (canCook d F B) of
            true   => k([])
            | false => 
                case (lookupRecipe d B) of
                    NONE => k([d])
                    | SOME iL => 
                missingIngrList iL F B k
(*
missingIngrList L F B k =>L'
ensures L'=k(l) iff l is all missing ings in L with F and B
    *)
    and missingIngrList [] F B k = k([])
         | missingIngrList (ig::igs) F B k =
         missingIngrList igs F B (fn(ms)=>
            ms@(missingIngr ig F B k))

  (* marketRun d F B ==> ingr
     ENSURES: ingr is the list of the ingredients that are missing
              in order to cook dishes d according to cookbook B and
              contents F of the fridge
  *)

  fun marketRun (d: dish) (F: fridge) (B: cookBook): ingr list =
        missingIngr d F B (fn l => l)

(*
feasible dl B F k=dl'
ensures dl'=k(dl'') iff
dl'' is the largest subset of dl that
all elem in dl'' can be made with B and F

    *)
  fun feasible [] B F k=k([])
    | feasible (d::ds) B F k=
    feasible ds B F (fn fd=>
        if canCook d F B then k(d::fd)
        else k(fd))
        (*
canMake B F=>dl
ensures dl is a list of all dish thata can be mde
with B and F
            *)
  fun canMake B F =
    feasible (List.map (fn (x,_)=>x) B) B F (fn l=>l)
end (* structure Cooking *)
