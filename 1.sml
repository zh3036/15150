
(*Zihanz@andrew.cmu.edu*)

(* fib: int -> int
 * REQUIRES n>=0
 * ENSURES fib(n) is the n th fib number
 *)

fun fib(0:int): int = 1
	| fib(1)=1
	| fib(n)=fib(n-1)+fib(n-2);


(* fib2: int -> int
 * REQUIRES n>=0
 * ENSURES fib2(n) is the n th fib number
 *)

fun fib2(n: int): int =
	if n=0 then 1
	else if n=1 then 1
	else 
		fib2(n-1)+fib2(n-2);

val f5:bool = fib(5)=8;
val 8 = fib 5;




