(* andrew Id: _____zihanz______________ *)

functor Cnf (structure U: UTIL
             structure L: LITERAL
             structure A: ASSIGNMENT where R=L.R) : CNF where L=L and A=A =
struct
  structure A = A
  structure L = L
  structure R = L.R

  type cnf = L.literal Seq.seq Seq.seq

  (* toString F ==> s
     ENSURES: s is a string representation of F
   *)
  fun toString (F: cnf): string =
    Seq.toString (Seq.toString L.toString) F

  (* eq (F1,F2) ==> b
     ENSURES: b == true iff F1 and F2 are the same formula
   *)
  val eq = U.permeq (U.permeq L.eq)

  (* fromLists Ls ==> F
     ENSURES: F is the CNF whose clauses are the disjunction
              of the elements of each list in Ls
   *)
    fun fromLists l=
        Seq.fromList(
            List.map Seq.fromList l)
(*
  #Analysis
  W_fl(m*n)=W_Sfl(n)+W_lmap(n)*W_Sfl(m)
  where n is the length of list, and m is the length of
  nested those.
  W_fl(m*n)
  =O(n)+O(n)*O(m)
  =O(m*n)

  S_fl(m*n)=S_Sfl(n)+S_lmap(n)*S_Sfl(m)
  =O(n)+O(n)*O(m)
  =O(m*n)
    *)


  (* toLists F ==> Ls
   * ENSURES: Ls is the lists whose elements are the
              lists of the literals in each clause of F
   *)

    fun toLists  s=
        Seq.toList(
            Seq.map Seq.toList s)

(*
  #Analysis
  It is the reverse of Fromlist, 
  (W_Stolist=W_Sfromlist)
  the work and span are the same.
 
    *)

      (* letters F ==> L
         ENSURES: L is the list of all the prop letters in F without duplicates
       *)
    fun gl(L.Pos x)=x
        | gl(L.Neg x)=x
    (*fun cmp(x, y)=R.cmp(gl x, gl y)*)
    fun letters c = U.uniquify R.cmp 
        (Seq.map gl (Seq.flatten c))
(*
    #Analysis
    W_letters(n)
    =W_Smap(n)*W_gl(2)+W_flatten(n) +W_uniquify(n)*W_R.cmp(2)

    W_gl(2)=c
    W_R.cmp(2)=c
    W_Smap(n)=n
    W_flatten(n)=n
    W_uniquify(n)=W_reduce(n)*W_combine(n)
    W_combine(n)=W_combine(n-1)+c
    W_combine(n)=c*n
    W_uniquify(n)=n*n*c=O(n^2)

    W_letters(n)
    =O(n)*O(1)+O(n)+O(N^2)*O(1)
    =O(n^2)


    S_letters is the same except that S_reduce is O(log n)

    so S_letters =O(n * (log n))


    *)


      (* eval F A ==> b
         REQUIRES: every prop letter in F occurs in A
         ENSURES: b is the result of evaluating F w.r.t. A
       *)
      (*val eval: cnf -> A.assignment -> bool*)
    fun eval c a= 
        let
            fun ev(L.Pos x)=A.eval x a
                | ev(L.Neg x)=not (A.eval x a) 
            fun mf s=
                U.some(
                    Seq.map ev s)
        in
            U.all(
                Seq.map mf c)             
        end
(*
    #Analysis
    W_eval(c,a)
    =W_all(c)+W_Smap(c)*W_mf(a)
    =W_all(c)+W_Smap(c)*(W_some(a)+W_Smap(a)*W_ev(2))
    =O(c)+O(c)*(O(a)+O(a)*O(1))
    =O(c*a)

    S_eval(c,a)
    =S_all(c)+S_Smap(c)*S_mf(a)
    =S_all(c)+S_Smap(c)*(S_some(a)+S_Smap(a)*S_ev(2))
    =O(1)+O(1)*(O(1)+O(1)*O(1))
    =O(1)


    *)

      (* valid F ==> b
         ENSURES: b == true iff F is valid
       *)
      (*val valid: cnf -> bool*)
    fun valid c = 
        U.all(
            Seq.map 
                (fn(a)=>eval c a) 
                    (A.genAll(letters c)))


      (* satisfiable F ==> As
         ENSURES: As is the sequence of all assignments
                  that make F satisfiable
       *)
      (*val satisfiable: cnf -> A.assignment Seq.seq*)
    fun satisfiable c=
        Seq.filter
            (fn(a)=>eval c a)
                (A.genAll(letters c))



      (* unsat F ==> b
         ENSURES: b == true iff F is unsatisfiable
       *)
      (*val unsat: cnf -> bool*)
    fun unsat c=
        not (
            U.some(
                Seq.map 
                    (fn(a)=>eval c a) 
                        (A.genAll(letters c))))

(*
    #Analysis
    the work and of valid, satisfiable and unsat will be the same
    because they Seq.map and Seq.filtier are the same,
    rest are the same, U.some or all is just add a O(n), but
    genAll is defintely more owrk than O(n) , so that does not affect

    I will only compute unsat
    where n is the size of cnf and k is the number of litereals
    W_uns(n,k)
    =W_some(2**k)+W_Smap(2**k)*W_eval(n,k)+W_genALL(k)
    =O(2**k)+O(2**k)*O(k*n)+O(2**k)
    =O(2**k)
    S_uns(n,k)
    =S_some(2**k)+S_Smap(2**k)*S_eval(n,k)+S_genALL(k)
    =O(1)+O(1)*O(1)+O(1)
    =O(1)
    *)

end (* functor Cnf *)
