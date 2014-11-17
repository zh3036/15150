
fun fac'(0,k:int):int =k
    | fac'(n,k)=fac'(n-1,k*n)

fun fac(n:int):int=fac'(n,1)

;