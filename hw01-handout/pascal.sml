(* qatar Id: _zihanz_________________________ *)

(* pascal(r,k)=p
 * REQUIRES: 0<=k<=r
 * ENSURES:  p is (r choose k).
 *) 
fun pascal (r:int ,0:int) :int=1 
	|	pascal(r,k)=if r=k 
								then 1
								else 
									pascal(r-1,k)+pascal(r-1,k-1);
val 6 = pascal (4,2)
val 70= pascal(8,4)
val 84= pascal(9,3)

(* sumpascal(n,k)=S;
 * REQUIRES: 0<=k<=n;
 * ENSURES:  S is sum from pascal(n,0) to pascal(n,k);
 *) 
fun sumpascal(n:int, 0:int): int = pascal(n,0)
	|	sumpascal(n,k)=pascal(n,k)+sumpascal(n,k-1);
val 11= sumpascal(4,2)
val 42= sumpascal(6,3)
val 502=sumpascal(9,7)


(* exp(n)=p;
 * REQUIRES: n>=0;	
 * ENSURES:  p is 2 to the pwoer of n;
 *) 
fun exp (n:int):int=sumpascal(n,n); 
val 8 = exp(3);
val 16 = exp(4);
val 32 = exp(5);



(* normalexp(n)=p;
 * REQUIRES: n>=0;
 * ENSURES:  p is 2 to the pwoer of n;
 *)
fun normalexp(0:int):int = 1
	|  normalexp(n)=2*normalexp(n-1);

val 8 = normalexp(3);
val 16 = normalexp(4);
val 32 = normalexp(5);
