datatype 'a tree=empty
                        | node of 'a tree * 'a * 'a tree

;


;

fun f x =
    let
        val x = 3
        val y = x
    in
        y
    end
;



fun f x =
    let
        val y = x + 3
        val 4=y   
        fun g z = z + y    
        val 4=y
        val y = 7
        fun h 0 = 0
            | h n = y - x + h (n-1)
        val 7=y
        val 5 = g x
        val 6 = h x
    in
        g x+ h x
    end
val result = f 1

;