structure IntUtil : INTUTIL =
struct
  (* exp2 n ==> m
     ENSURES: m = n^2
   *)
  fun square (x: int): int = x*x

  (* exp2 n ==> m
     REQUIRES: n >= 0
     ENSURES: m = 2^n
   *)
  fun exp2 (0: int): int = 1
    | exp2 n =
       if n mod 2 = 0
         then square (exp2 (n div 2))
         else 2 * exp2 (n - 1)

  (* bit (n,i) ==> b
     REQUIRES: i >=0
     ENSURES: b = true if the i-th bit of n in binary is 1
              b = false if it is 0
   *)
  fun bit (m: int, i: int): bool =
      (m div (exp2 i)) mod 2 = 1
end (* structure IntUtil *)
