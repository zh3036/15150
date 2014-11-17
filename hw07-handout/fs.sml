(* andrew Id: ___________zihanz_______________ *)

(*signature FS =
sig
  type data = string
  datatype 'a fs = File of 'a * data        metadata, file content)
     | Dir  of 'a * 'a fs list  metadata, dir content

  val map: ('a * string -> 'b * string) -> ('a -> 'b) -> 'a fs -> 'b fs
  val reduce: ('a * string -> 'b) -> ('a * 'b list -> 'b) -> 'a fs -> 'b
  val count: 'a fs -> int * int
end*)
(*Control.Print.printDepth := 100;*)


structure GenericFs : FS =
struct
  type data = string
  datatype 'a fs = File of 'a * data        (* (metadata, file content) *)
		 | Dir  of 'a * 'a fs list  (* (metadata, dir contents) *)

    fun map ff fd (File(x)) = File(ff x)
        | map ff fd (Dir(meta,dir)) = 
            Dir(fd(meta),List.map (fn x=>map ff fd x) dir)

    fun reduce ff fd (File(x)) = ff x
        | reduce ff fd(Dir(meta,dir))=
            fd(meta,List.map (fn x=>reduce ff fd x) dir)

    fun count  sys = 
        let 
            fun sum (_,dl)
                =List.foldr (fn((x,y),(x1,y1))=>(x+x1,y+y1)) (0,1) dl
        in
            reduce (fn x=>(1,0)) sum sys
        end

   val a0 = File(0,"abc")
    val a1 = File(1,"abc")
    val a2 = File(2,"abc")
    val a3 = File(3,"abc")
    val a4 = File(4,"abc")
    val a5 = File(5,"abc")
    val f1 = Dir(6,[a1,a2,a3,a4,a0,a5])
    val f2 = Dir(7,[f1,a2,f1,a4,a0,a5])
    val (16,3)=count f2


    val b0 = File(0,"1abc")
    val b1 = File(1,"1abc")
    val b2 = File(2,"1abc")
    val b3 = File(3,"1abc")
    val b4 = File(4,"1abc")
    val b5 = File(5,"1abc")
    val bf1 = Dir(7,[b1,b2,b3,b4,b0,b5])
    val bf2 = Dir(8,[bf1,b2,bf1,b4,b0,b5])

    val true = (map (fn(i,s)=>(i,"1"^s)) (fn x=>x+1) f2 = bf2)

end (* structure GenericFs *)
