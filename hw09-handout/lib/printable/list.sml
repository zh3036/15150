functor ListPrintable (structure P: PRINTABLE) : PRINTABLE =
struct
  type t = P.t list

  fun toString (l: P.t list): string =
    let
        fun lts ([]: P.t list): string = ""
          | lts [x] = P.toString x
          | lts (x::l) = P.toString x ^ ", " ^ lts l
    in
        "[" ^ lts l ^ "]"
    end

end (* functor ListPrintable *)
