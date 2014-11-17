fun intToString (x: int): string = Int.toString x

(* Example *)
(* factorial n ==> m
   REQUIRES: n >= 1
   ENSURES: m is the product of all integers between 1 and n
 *)
fun factorial (1: int): int = 1
  |  factorial n = n * factorial(n-1)

(* summorial n ==> m
   REQUIRES: n >= 0
   ENSURES: m is the sum of all integers between 0 and n
 *)
fun summorial (0: int): int = 0
  | summorial n = n+ summorial(n-1)

(* summorial' (n,a) ==> m
   REQUIRES: n >= 0
   ENSURES: m is the sum of all integers between 0
    and n plus a
;
 *)
fun summorial' (0: int, a: int): int = a
  | summorial' (n, a) = summorial' ((n-1), n+a)
;