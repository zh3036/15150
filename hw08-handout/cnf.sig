signature CNF =
sig
  structure L: LITERAL
  structure A: ASSIGNMENT where R = L.R

  type cnf = L.literal Seq.seq Seq.seq

  (* toString F ==> s
     ENSURES: s is a string representation of F
   *)
  val toString: cnf -> string

  (* eq (F1,F2) ==> b
     ENSURES: b == true iff F1 and F2 are the same formula
   *)
  val eq: cnf * cnf -> bool

  (* toLists F ==> Ls
   * ENSURES: Ls is the lists whose elements are the
              lists of the literals in each clause of F
   *)
  val toLists: cnf -> L.literal list list

  (* fromLists Ls ==> F
     ENSURES: F is the CNF whose clauses are the disjunction
              of the elements of each list in Ls
   *)
  val fromLists: L.literal list list -> cnf

  (* letters F ==> L
     ENSURES: L is the list of all the prop letters in F without duplicates
   *)
  val letters: cnf -> L.R.letter Seq.seq

  (* eval F A ==> b
     REQUIRES: every prop letter in F occurs in A
     ENSURES: b is the result of evaluating F w.r.t. A
   *)
  val eval: cnf -> A.assignment -> bool

  (* valid F ==> b
     ENSURES: b == true iff F is valid
   *)
  val valid: cnf -> bool

  (* satisfiable F ==> As
     ENSURES: As is the sequence of all assignments
              that make F satisfiable
   *)
  val satisfiable: cnf -> A.assignment Seq.seq

  (* unsat F ==> b
     ENSURES: b == true iff F is unsatisfiable
   *)
  val unsat: cnf -> bool
end (* signature CNF *)
