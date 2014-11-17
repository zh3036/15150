(* andrew Id: __________zhanz_________ *)

structure Test =
struct
(* Use this structure for outside-the-box testing.  There is one
   section for each structure or functor you are asked to implement.
   Functors are pre-instantiated with provided parameters, but feel
   free to try more instances.  Use the nickname defined in each
   section to write your tests, but do not open any of these structures.
 *)
 
(* *********************** File Systems *********************** *)
  structure F = GenericFs
  (*open F;*)
      val a0 = F.File(0,"abc")
    val a1 = F.File(1,"abc")
    val a2 = F.File(2,"abc")
    val a3 = F.File(3,"abc")
    val a4 = F.File(4,"abc")
    val a5 = F.File(5,"abc")
    val f1 = F.Dir(6,[a1,a2,a3,a4,a0,a5])
    val f2 = F.Dir(7,[f1,a2,f1,a4,a0,a5])
    val (16,3)=F.count f2


    val b0 = F.File(0,"1abc")
    val b1 = F.File(1,"1abc")
    val b2 = F.File(2,"1abc")
    val b3 = F.File(3,"1abc")
    val b4 = F.File(4,"1abc")
    val b5 = F.File(5,"1abc")
    val bf1 = F.Dir(7,[b1,b2,b3,b4,b0,b5])
    val bf2 = F.Dir(8,[bf1,b2,bf1,b4,b0,b5])

    val true = ((F.map (fn(i,s)=>(i,"1"^s)) (fn x=>x+1) f2) = bf2)


  structure B = Basix (F)


  (* Insert tests for structure GenericFs here *)

  (*open B;*)
  val a = B.F.File ("a","asd")
  val a = B.F.Dir ("a",[a])
  val c = B.F.Dir ("c",[a])
  val b = B.cp a ["root"] (B.mkfs "root")
  val B.F.Dir ("root",[B.F.Dir ("a",[B.F.File ("a","asd")])])= B.cp a ["root","a"] b
 val  B.F.Dir
    ("root",
     [B.F.Dir ("a",[B.F.Dir ("c",[B.F.Dir ("a",[B.F.File ("a","asd")])]),B.F.File ("a","asd")])])
    =B.cp c ["root","a"] b
   (*Insert tests for functor Basix here *)

  structure M = Minix (B)


val b =
  B.F.Dir
    ("root",
     [B.F.File ("k","asd"),
      B.F.Dir ("a",[B.F.File ("m","fasd"),B.F.File ("j","asd"),B.F.File ("a","asd")])])

val B.F.Dir
    (("root",1024),
     [B.F.File (("k",3),"asd"),
      B.F.Dir
        (("a",1024),
         [B.F.File (("m",4),"fasd"),B.F.File (("j",3),"asd"),B.F.File (("a",3),"asd")])])
=M.basix2minix b

val c = M.basix2minix b;

val true = (b = M.minix2basix c)
  (* Insert tests for functor Minix here *)


    (*for some reaon, i can not test , here , so i test inside
  i think because i open F inside B, and thus
    here it telling no DIR in B.FILE*)
(*val M.B.FDir ("root", 1024, [])= M.mkfs "root"*)

(* ************************** Cooking ************************* *)
  structure C = Cooking
  (* Insert tests for structure Cooking here *)
  (* the recipes *)
  val lasagna   = ("lasagna",   ["pasta", "bechamel", "meat",
                                 "bolognese", "parmesan"])
  val pasta     = ("pasta",     ["flour", "egg"])
  val bechamel  = ("bechamel",  ["flour", "butter", "milk", "pepper"])
  val bolognese = ("bolognese", ["tomato", "onion", "pepper", "secret"])
  val secret    = ("secret",    ["balsamic", "parsley", "mozzarella"])
  (* The cookbook *)
  val italianCookbook = [lasagna, pasta, bechamel, bolognese, secret]
  (* Two different fridges *)
  val bigFridge   = ["flour", "egg", "milk", "butter", "pepper", "tomato",
                     "onion", "balsamic", "parsley", "meat", "parmesan"]
  val smallFridge = ["pasta", "bolognese", "meat", "parmesan", "flour",
                     "milk", "butter", "pepper"]

  val true = C.canCook "bechamel" bigFridge italianCookbook;
  val false = C.canCook "secret" bigFridge italianCookbook;


   val ["mozzarella"]=C.marketRun "secret" bigFridge italianCookbook
   val ["mozzarella","parsley","balsamic"]=C.marketRun "secret" smallFridge italianCookbook
   val ["pasta","bechamel"]=C.canMake italianCookbook bigFridge
   val ["lasagna","pasta","bechamel","bolognese"]=C.canMake italianCookbook smallFridge


  structure C2 = Cooking2
  (* Insert tests for structure Cooking2 here *)


(* ******************** Regular Expressions ******************* *)

  (* Insert tests for structure Regex here *)
  structure R = Regex
  val a = R.Char #"a"
  val p= R.Times(a,a);
  val p= R.Times(a,p);
  val s = R.Star a;
  val b = R.Both(s,p)
  val true = R.accept b "aaa"
  val false = R.accept b "aa"
  val false = R.accept b "aaaa"
  val w = R.Wild;
  val w2 = R.Times(w,w);
   val w2 = R.Times(w2,w);
   val b = R.Both(s,w2);
   val false = R.accept b "aaaa"
   val true = R.accept b "aaa"

val nw =
  R.Times
    (R.Both
       (R.Times (R.Times (R.Wild,R.Wild),R.Times (R.Wild,R.Wild)),
        R.Star (R.Times (R.Char #"a",R.Char #"b"))),R.Star R.Wild)

val true = R.accept nw "ababccc"
val false = R.accept nw "abcccc"




(* Bonus: define map in terms of reduce *)
  fun map _ = raise Fail "Unimplemented"

end (* structure Test *)
