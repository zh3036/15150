datatype 'a tree = Empty
                 | Node of 'a tree * 'a * 'a tree

datatype direction = L | R

fun merge _ = raise Fail "Paste from previous exercise"

fun removeT (x: ''a, t: ''a tree): ''a tree           = raise Fail "Unimplemented"

fun path (x: ''a, t: ''a tree): direction list option = raise Fail "Unimplemented"
