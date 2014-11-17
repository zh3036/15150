(* 28 October 2014 *)
(* Lecture 17: Regular expressions (fixed), partial evaluation *)
val _ = Control.Print.printDepth  :=  100
val _ = Control.Print.printLength :=  500
val _ = Control.Print.stringDepth := 1000


datatype regex = One
    | Char  of char
    | Times of regex * regex
    | Plus  of regex * regex
    | Star  of regex

(* match from last lecture *)

(* match r s k ==> b
   ENSURES: b = true iff
    - s = pu
    - p in L(r)
    - k u = true
 *)
fun match (One: regex) (s: char list) (k: char list -> bool): bool = k s
  | match (Char c) s k =
    (case s
       of c'::u => (c = c') andalso k u
	| nil    => false)
  | match (Times (r1, r2)) s k =
      match r1 s  (fn u1 => 
      match r2 u1 k)
  | match (Plus (r1, r2)) s k =
      match r1 s k  orelse  match r2 s k
  | match (Star r) s k =
             k s
      orelse match r        s  (fn u1 =>
             match (Star r) u1 k)

(* accept r s ==> b
   ENSURES: b iff s in L(r)
 *)
fun accept (r: regex) (s: string): bool =
      match r (String.explode s) (fn u => u = nil)
(* ... but ... *)

(* Abbreviations *)
val s1 = #"a"
val s2 = #"b"
val a  = Char #"a"
val r1 = Star One            (* r1 = 1* *)
val r2 = Times(r1, a)        (* r2 = 1*a *)
val r3 = Star(Plus(One, a))  (* r3 = (1 + a)* *)
val k0 = fn u => u = nil

(* Tests *)
val true = accept r1 ""
(* val false = accept r1 "a" -- loops! *)
val true = accept r2 "a"
(* val true  = accept r3 "a" -- loops! *)
(* val false = accept r3 "b" -- loops! *)

(* Equivalently *)
val true = match r1 [] k0
(* val false = match r1 [s1] k0 -- loops! *)
val true = match r2 [s1] k0
(* val true  = match r3 [s1] k0 -- loops! *)
(* val false = match r3 [s2] k0 -- loops! *)


(* Fixing match -- same specs, now satisfied *)
fun match (One: regex) (s: char list) (k: char list -> bool): bool = k s
  | match (Char c) s k =
    (case s
       of c'::u => (c = c') andalso k u
	| nil    => false)
  | match (Times (r1, r2)) s k =
      match r1 s  (fn u1 => 
      match r2 u1 k)
  | match (Plus (r1, r2)) s k =
      match r1 s k  orelse  match r2 s k
  | match (Star r) s k =
             k s
      orelse match r        s  (fn u1 => u1 <> s andalso
             match (Star r) u1 k)

fun accept (r: regex) (s: string): bool =
      match r (String.explode s) (fn s' => s' = nil)


val true  = accept r1 ""
val false = accept r1 "a"
val true  = accept r2 "a"
val true  = accept r3 "a"
val false = accept r3 "b"



(* Staged computation *)

type matcher = char list -> (char list -> bool) -> bool

(* Same as above, but highlighting just the first argument of clause *)
fun match (One: regex): matcher = (fn s => fn k => k s)
  | match (Char c) =
    (fn s => fn k =>
        (case s
	   of c'::u => (c = c') andalso k u
	    | nil   => false))
  | match (Times (r1, r2)) = 
    (fn s => fn k =>
       match r1 s  (fn u1 =>
       match r2 u1 k))
  | match (Plus (r1, r2)) = 
    (fn s => fn k =>
       match r1 s k  orelse  match r2 s k)
  | match (Star r) =
    (fn s => fn k =>
              k s
       orelse match r        s  (fn u1 => u1 <> s andalso
              match (Star r) u1 k))


(* regexp combinators *)
val NULL: matcher = fn s => fn k =>  k s

fun CHAR (c: char): matcher =
fn s => fn k =>
      (case s
	 of c'::u => (c = c') andalso k u
	  | nil   => false)

infixr 9 THEN
fun (m1: matcher) THEN (m2: matcher): matcher =
fn s => fn k =>
      m1 s  (fn u1 =>
      m2 u1 k)

infixr 8 OR
fun (m1: matcher) OR (m2: matcher): matcher =
fn s => fn k =>
      m1 s k orelse m2 s k

fun REPEAT (m: matcher): matcher =
fn s => fn k =>
             k s
      orelse m s        (fn u1 => u1 <> s andalso
	     REPEAT m u1 k)

(* match r ==> m
   ENSURES: m s k = true iff
    - s = pu
    - p in L(r)
    - k u = true
 *)
fun match (One: regex): matcher = NULL
  | match (Char c)              = CHAR c
  | match (Times (r1, r2))      = match r1 THEN match r2
  | match (Plus (r1, r2))       = match r1 OR match r2
  | match (Star r)              = REPEAT (match r)


(* (ab)* *)
val r4 = Star (Times (Char #"a", Char #"b"))
val m0 = match r4
val m0'= REPEAT (CHAR #"a" THEN CHAR #"b") (* no mention of match! *)
val abab = [#"a", #"b", #"a", #"b"]
val true = m0 abab k0

(* The old accept works *)
fun accept (r: regex) (s: string): bool =
      match r (String.explode s) (fn sn => sn = nil)

val true  = accept r1 ""
val false = accept r1 "a"
val true  = accept r2 "a"
val true  = accept r3 "a"
val false = accept r3 "b"
val true  = accept r4 "abab"


(* a variant that generates specialized acceptors by first compiling the regexp
   to a matcher *)
type acceptor = string -> bool

(* accept r ==> m
   ENSURES: m s = true iff s in L(r)
 *)
fun accept (r: regex): acceptor =
  let
      val m = match r
  in
      fn s => m (String.explode s) (fn sn => sn = nil)
  end

val acc1 = accept r1
val acc2 = accept r2
val acc3 = accept r3
val acc4 = accept r4

val true  = acc1 ""
val false = acc1 "a"
val true  = acc2 "a"
val true  = acc3 "a"
val false = acc3 "b"
val true  = acc4 "abab"