signature INTUTIL =
sig
  (* exp2 n ==> m
     REQUIRES: n >= 0
     ENSURES: m = 2^n
   *)
  val exp2: int -> int

  (* bit (n,i) ==> b
     REQUIRES: i >=0
     ENSURES: b = true if the i-th bit of n in binary is 1
              b = false if it is 0
   *)
  val bit: int * int -> bool
end (* signature INTUTIL *)
