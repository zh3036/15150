(* derive max and min for any ordered type *)
functor OrderedExt (O: ORDERED): ORDERED_EXT =
struct
  open O

  fun min (x,y) = case O.compare(x,y) of GREATER => y | _ => x
  fun max (x,y) = case O.compare(x,y) of LESS    => y | _ => x

  fun le (x,y) = case O.compare(x,y) of GREATER => false | _ => true
  fun lt (x,y) = case O.compare(x,y) of LESS    => true  | _ => false
  fun ge (x,y) = case O.compare(x,y) of LESS    => false | _ => true
  fun gt (x,y) = case O.compare(x,y) of GREATER => true  | _ => false
  fun eq (x,y) = case O.compare(x,y) of EQUAL   => true  | _ => false
end (* functor OrderedExt *)
