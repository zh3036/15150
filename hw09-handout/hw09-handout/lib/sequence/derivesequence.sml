functor DeriveSequence (S : SEQUENCECORE) :> SEQUENCE =
struct
  open S

  fun mapreduce f b c s = reduce c b (map f s)
      handle (Range s) =>
             raise Range ("mapreduce called with a function that raised Range with \""
                   ^ s ^ "\"")

  fun toString eltToString s =
      let
        fun f (NONE, x) = x
          | f (x, NONE) = x
          | f (SOME x, SOME y) = SOME (x ^ ", " ^ y)
      in
        "[" ^
         (case mapreduce (SOME o eltToString) NONE f s
           of NONE => "" | SOME s => s)
         ^ "]"
      end

  fun repeat n x = tabulate (fn _ => x) n

  fun zip (sa, sb) = tabulate (fn n => (nth n sa, nth n sb))
                              (Int.min(length sa, length sb))

  fun append s1 s2 = hidet (Node (s1, s2))

  fun empty () : 'a seq = hidel Nil

  fun singleton x = hidet (Leaf x)

  (* FIXME: implement using tabulate for better work/span? *)
  fun split i s =
      case i of 0 => (empty() , s)
              | _ => (* i > 0 *)
          (case (i,showt s) of
                (_,Empty) => raise Range "split can't get more than 0 elements of Empty"
              | (1, Leaf x) => (singleton x, empty ())
              | (_, Leaf _) => raise Range "split can't get more than 1 element of a Leaf"
              | (_, Node (l,r)) =>
                    let val ls = length l
                    in case Int.compare (i, ls)
                        of LESS => let val (ll, lr) = split i l
                                   in (ll, append lr r)
                                   end
                      | EQUAL => (l, r)
                      | GREATER => let val (rl, rr) = split (i - ls) r
                                   in (append l rl, rr)
                                   end
                    end)

  (* FIXME: implement directly for O(i) work ? *)
  fun take i s = (fn (x,_) => x) (split i s)
  fun drop i s = (fn (_,y) => y) (split i s)

  fun cons x s = hidel (Cons (x,s))

  (* FIXME: implement with tabulate instead for better work/span? *)
  fun flatten ss = reduce (fn (x,y) => append x y) (empty ()) ss


  (* Added ic *)
fun exists (p: 'a -> bool) (s: 'a seq): bool =
  mapreduce p false (fn (b1: bool, b2: bool) => b1 orelse b2) s

fun all (p: 'a -> bool) (s: 'a seq): bool =
  mapreduce p true (fn (b1: bool, b2: bool) => b1 andalso b2) s

fun eq (eq: 'a * 'a -> bool) (s1: 'a seq, s2: 'a seq): bool =
  length s1 = length s2 andalso all eq (zip (s1,s2))

(* equality modulo permutation *)
fun permeq (eq: 'a * 'a -> bool) (s1: 'a seq, s2: 'a seq): bool =
  if length s1 = 0 then length s2 = 0
  else
    let
      val x = nth 0 s1
      val X1  = filter (fn y => eq (x,y)) s1
      val X2  = filter (fn y => eq (x,y)) s2
      val s1' = filter (fn y => not (eq (x,y))) s1
      val s2' = filter (fn y => not (eq (x,y))) s2
    in
      length X1 = length X2 andalso permeq eq (s1', s2')
    end

fun toList (s: 'a seq): 'a list =
  let
    fun toList' 0 = []
      | toList' n = (nth (n-1) s) :: toList' (n-1)
    val l = length s
  in
    List.rev (toList' l)
  end
end
