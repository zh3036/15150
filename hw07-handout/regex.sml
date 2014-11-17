(* andrew Id: ______zihanz_________ *)

structure Regex: REGEX =
struct

datatype regex = One
               | Char of char
               | Times of regex * regex
               | Plus of regex * regex
               | Star of regex
               | Wild
               | Both of regex * regex

(* match r cs k ==> b
   ENSURES: b = true iff
    - cs = p@s
    - p in L(r)
    - k s ==> true
 *)
fun match (One: regex) (cs: char list) (k: char list -> bool) = k cs
  | match (Char c) cs k =
     (case cs
        of nil     => false
         | c'::cs' => c=c' andalso k cs')
  | match (Times(r1,r2)) cs k = 
      match r1 cs (fn cs' =>   
      match r2 cs' k)
   | match (Plus(r1,r2)) cs k =
      match r1 cs k  orelse  match r2 cs k
   | match (Star r) cs k = k cs orelse
      match r cs (fn cs' =>
      cs <> cs' andalso match (Star r) cs' k)
   | match Wild cs k = 
    (case cs of
      nil => false
      | c'::cs' => k cs')
   | match (Both(r1,r2)) cs k = 
   match r1 cs (fn u1=>
    match r2 cs (fn u2=>
      u1=u2 andalso k(u1) andalso k(u2)))

(* accept r s ==> b
   ENSURES: b = true iff s in L(r)
 *)
fun accept r s =
  match r (String.explode s) (fn [] => true | _ => false)

end (* structure Regex *)
