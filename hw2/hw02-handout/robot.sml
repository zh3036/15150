(* qatar Id: zihanz *)

datatype instruction = Right
    | Step of int

type itinerary = instruction list

datatype orientation = North | East | South | West

type position = int * int * orientation

(*
    turnRight(p) ==> p2
    REQUIRES true
    ENSURES p2 is p1 after turnRight
    *)
fun turnRight((x,y,East):position):position = (x,y,South)
    | turnRight((x,y,South))=(x,y,West)
    | turnRight((x,y,West))=(x,y,North)
    | turnRight((x,y,North))=(x,y,East)

val (1,2,East)=turnRight(1,2,North)

(*
move(n,p) ==> p2
requires true
ENsures p2 is from p move forward n
    *)
fun move(n:int,(x,y,East):position):position = (x+n,y,East)
    | move(n,(x,y,South))=(x,y-n,South)
    | move(n,(x,y,West))=(x-n,y,West)
    | move(n,(x,y,North))=(x,y+n,North)

val (1,2,North)=move(1,(1,1,North))
(*
getPositon(I,P)==>P2
REQUIRES true
ENSURES P2 is the pos after I move from P
    *)
fun getPosition([]:itinerary,p:position) :position=p
    | getPosition(Right::lis,p)
        =getPosition(lis,turnRight(p))
    | getPosition(Step(n)::lis,p)
        =getPosition(lis,move(n,p)) 

val (2,2,East)=getPosition([Step 2,Right,Step 2],(0,0,North))

(*
goback(I)==>I2
REQUIRS TRUE
ENSURES I2 is the reverse of I1
    *)
fun goBack([]:itinerary):itinerary=[]
    | goBack(Right::lis)=goBack(lis)@[Right,Right,Right]
    | goBack(Step(n)::lis)=goBack(lis)@[Step (~n)]

val [Step 3,Right,Right,Right,Step(~2)] =goBack([Step 2, Right, Step(~3)])
    ;