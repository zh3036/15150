functor SeqMatrix (S : SEQUENCE) : MATRIX =
struct
    structure Seq = S

    datatype 'a absmat = M of ('a Seq.seq) Seq.seq

    (* this doesn't actually work, because the data is column-major, so it's not
     * a part of the public interface *)
    fun toString (e2s: 'a -> string) (M cols) =
        Seq.toString (fn s => "\n" ^ (Seq.toString e2s s)) cols

    fun eq (elem_eq: 'a * 'a -> bool) (M c1, M c2) =
      Seq.eq (Seq.eq elem_eq) (c1, c2) 

    type 'a matrix = 'a absmat

    fun size (M cols) = (Seq.length cols, Seq.length (Seq.nth 0 cols))
                          handle (Seq.Range _) => (0, 0)

    fun sub (M cols) (i, j) = Seq.nth j (Seq.nth i cols)

    fun repeat x (width, height) =
        M (Seq.repeat width (Seq.repeat height x))

    fun tabulate f (w, h) =
        M (Seq.tabulate (fn i => Seq.tabulate (fn j => f (i,j)) h) w)

    fun map f (M cols) = M (Seq.map (Seq.map f) cols)

    fun update (m as (M cols)) ((i, j), x) =
        let
          val (w, h) = size m

          fun update_one (s : 'a Seq.seq) (ind : int) (x : 'a) (k : int) =
              case ind = k of
                  true => x
                | false => Seq.nth k s
        in
          M (Seq.tabulate (update_one cols i
                             (Seq.tabulate
                                (update_one (Seq.nth i cols) j x) h)) w)
        end

    fun matching_subs (p : 'a -> bool) (m as (M cols)) =
        let
          val (w, h) = size m

          val rc_indexed =
              Seq.tabulate (fn i => Seq.tabulate
                                      (fn j => ((i,j), sub m (i, j)))
                                      h)
                           w

          val fst = fn (x, y) => x
          val snd = fn (x, y) => y
        in
          Seq.flatten (Seq.map
                         (fn c => Seq.map fst
                                          (Seq.filter (p o snd) c))
                         rc_indexed)
        end

    fun rows m =
        let
          val (w, h) = size m
        in
          Seq.tabulate (fn j => (Seq.tabulate (fn i => sub m (i, j)) w)) h
        end

    fun cols (M cols) = cols

    fun from_cols cols = M cols
    fun from_rows rows =
        let
            val iftheywerecols = M rows
            val (w, h) = size iftheywerecols
        in
            M (Seq.tabulate
                (fn i => Seq.tabulate
                    (fn j => sub iftheywerecols (j,i)) w) h)
        end


    fun diags1 m =
        let
          val (w, h) = size m
          val dmin = Int.min (w, h)
          val dmax = Int.max (w, h)
          val num_diags = w + h - 1

          fun take_diag (starti : int, k : int, len : int) =
              Seq.tabulate (fn i => sub m (i + starti, k - (i+starti))) len

          fun gen_diag (k : int) =
              case k < dmin of
                  true => take_diag (0, k, k + 1)
                | false =>
                  (case k >= dmax of
                       true =>
                           let
                             val num_elmts = num_diags - k
                           in
                             take_diag (w - num_elmts, k, num_elmts)
                           end
                     | false =>
                           (case w < h of
                                true => take_diag (0, k, dmin)
                              | false => take_diag (k - dmin + 1, k, dmin)
                                ))
        in
          Seq.tabulate gen_diag num_diags
        end

    fun diags2 m =
        let
          val (w, h) = size m
        in
          diags1 (M (Seq.tabulate (fn i => Seq.tabulate (fn j => sub m (i, h - j - 1)) h) w))
        end
end
