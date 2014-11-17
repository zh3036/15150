(* andrew Id: _____zihanz___________ *)

functor Assignment (structure U: UTIL
                    structure R: LETTER): ASSIGNMENT where R=R =
struct
  structure R = R

  type assignment = (R.letter * bool) Seq.seq
  (* REPRESENTATION INVARIANT:
     Each letter occurs at most once in an assignment *)

  (* toString A ==> s
     ENSURES: s is a string representation of A
   *)
  fun toString (A: assignment): string =
     Seq.toString (fn s => s)
                  (Seq.map (fn (l,true)  => R.toString l ^ ": t"
                             | (l,false) => R.toString l ^ ": f") A)
(*
    #Analysis
    W_ts(n)
    =W_S.ts(n)+W_Smap(n)
    =n*k1+n*k2+c
    =O(n)

    S_ts(n)
    =S_S.ts(n)+S_Smap(n)
    =(log n)*k1+1*k2+c
    =O(log n)
    
    I do not know how Seq.tostring is implemented
    but i suppose it used Seq.reduce
    thus is should be O(log n)
    *)





  (* eq (A1,A2) ==> b
     ENSURES: b == true iff A1 and A2 assign the same truth
              values to each letter in them
   *)
  fun eq (A1: assignment, A2: assignment): bool =
      U.permeq (fn ((l1,b1),(l2,b2)) => R.eq(l1,l2) andalso b1=b2) (A1,A2)

(*
    #Analysis
    W_eq(n,m)=W_per(n,m)
    S_eq(n,m)=S_per(n,m)
    
    W_per(0)=c
    W_per(n,m)
    =W_per(n-1,m)+2*(W_S.filter(n)+W_S.filter(m))
    =W_per(n-1,m)+2*(n+m)*k
    
    W_per(n,m)=O(n(n+m))

    S_per(0)=c
    S_per(n,m)
    =S_per(n-1,m)+2*(S_S.filter(n)+S_S.filter(m))
    =S_per(n-1,m)+2*(O(1) + O(1))*k
    
    S_per(n,m)=O(n)
    *)


  (* valid A ==> b
     ENSURES: checks the underlying representation invariant.
   *)
    fun valid A = 
            eq(A, U.uniquify 
              (fn ((l1,b1),(l2,b2)) => R.cmp(l1,l2)) A)
(*
    #Analysis
    W_valid(n)=W_eq(2)+W_uniquify(n)*W_R.cmp(2)

    W_eq(2)=c
    W_R.cmp(2)=c
    W_uniquify(n)=W_reduce(n)*W_combine(n)
    W_combine(n)=W_combine(n-1)+c
    W_combine(n)=c*n
    W_uniquify(n)=n*n*c=O(n^2)

    W_valid(n)=O(n^2)

    S_valid is the same except that S_reduce is O(log n)

    so S_valid =O(n * (log n))


    *)





  (* fromList (P,N) ==> A
     REQUIRES: P and N have no common elements
     ENSURES: A is the assignment of true to all letters in P
              and of false to all letters in N
   *)
    fun fromList (T,F)=
        let
            val Tl=length(T)
            val Fl=length(F)
            val TF = 
                Seq. append (Seq.fromList T) (Seq.fromList F)
            fun f(n)=(Seq.nth n TF ,n <Tl ) 
               
        in
            Seq.tabulate f (Tl+Fl)
        end
(*
    #Analysis
    W_fromlist(n)
    =W_append(n)+W_f(c)+W_tabulate(n) +W_SfromList(n)
    =n+c+n+n
    =O(n)

    S_fromlist(n)
    =S_apeend(n)+S_f(c)+S_tabulate(n)+S_SfromList(n)
    =O(1)+O(1)+O(1)+O(n)
    =O(n)

    

    *)

  (* toList A ==> (P,N)
     ENSURES: P is the list of the positive literals in A and
              L is the list of its negative literals
   *)        
    fun toList(A:assignment)=
        let 
            val T =
            Seq.toList(
                Seq.map
                    (fn (l,_)=>l)
                    (Seq.filter (fn(_,b)=>b) A))
            val F = 
            Seq.toList(
                Seq.map
                    (fn (l,_) =>l)
                    (Seq.filter (fn(_,b)=>not b) A))
        in
            (T,F)
        end
(*
    #Analysis
    W_toL(n)
    =W_StoL(n)+2*W_Smap(n)+2*W_Sfilter(n)
    =O(n)+O(n)+O(n)
    =O(n)

    S_toL(n)
    =S_Stol(n)+2*S_Smap(n)+2*S_Sfilter(n)
    =O(n)+O(1)+O(1)
    =O(n)
    

    *)



    (* eval l A ==> b
     REQUIRES: l occurs in A
     ENSURES: b is the truth value of l in A
   *)
    fun eval L A = 
        let 
            val (_,b)=Seq.nth 0
            (Seq.filter (fn (l,_)=>R.eq(l,L)) A)
        in
            b
        end
(*
    #Analysis

    W_ev(n)
    =W_Snth(n)+W_Sfilter(n)*R.eq(2)
    =O(1)+O(n)*O(2)
    =O(n)
    S_ev(n)
    =S_Snth(n)+S_Sfilter(n)*R.eq(2)
    =O(1)+O(1)*O(2)
    =O(1)

    

    *)
    
    (* genAll L ==> As
     REQUIRES: L does not contain duplicates
     ENSURES: L is the list of all possible truth assignments
              for the letters in L
   *)

    fun genAll (L):assignment Seq.seq=
        let
            fun f (n)=
                Seq.tabulate 
                    (fn(x)=>(Seq.nth x L,U.bit(n,x))) 
                    (Seq.length L)
        in
            Seq.tabulate f (U.exp2 (Seq.length L))
        end

        
(*
    #Analysis
    W_geA(n)
    =W_tabulate(2**n)*W_tabulate(n)*(W_nth(n)+W_bit(n))
    =O(2**n)*O(n)*(O(1)+O(1))
    =O(2**n)
    S_geA(n)
    =S_tabulate(2**n)*S_tabulate(n)*(S_nth(n)+S_bit(n))
    =O(1)*O(1)*(O(1)+O(1))
    =O(1)


    *)
        
end (* functor Assignment *)
