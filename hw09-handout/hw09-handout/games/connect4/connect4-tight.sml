functor Connect4 (val num_cols: int
                  val num_rows: int) : GAME =
struct
structure C4 = MakeConnect4 (val num_cols = num_cols
		             val num_rows = num_rows)
  open C4
end (* functor Connect4 *)
