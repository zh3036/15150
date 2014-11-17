fun tabulate f 0= []
	| tabulate f n = (tabulate f (n-1))@[(f (n-1))]


fun evens n = tabulate (fn x=>x*2) (n)



fun fact n  = foldr (op * ) 1 (tabulate (fn x=>x+1) n)


;