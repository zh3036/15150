signature UTIL =
sig
  val chop: ('a -> bool) -> 'a list -> 'a list
  val combine: ('a * 'a -> 'a) -> ('a list * 'a list) -> 'a list
(*  val combineS: ('a * 'a -> 'a) -> ('a list * 'a list) -> 'a list
  val combineS:('a * 'a ->a') ->('a list * 'a list) ->'a list
  val reduce: ('a * 'a  -> 'a) -> 'a list -> 'a
*)
val combineS : ('a * 'b -> 'c) -> 'a list * 'b list -> 'c list
val reduce : ('a * 'b -> 'b) -> 'b -> 'a list -> 'b
end (* signature UTIL *)
