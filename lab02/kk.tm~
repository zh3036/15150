<TeXmacs|1.0.7.21>

<style|generic>

<\body>
  <doc-data|<doc-title|lab02>|<doc-author|<\author-data|<author-name|zihanzhou>>
    \;

    \;
  </author-data>>>

  <section|>

  <section|>

  <subsection|>

  <\proposition>
    \;

    For all L <math|\<in\>> LZ, length(rev(L)) = length(L)
  </proposition>

  <\proof>
    \;

    <frame|The proof proceeds by list induction
    on<nbsp><math|<with|font-shape|italic|l>>>

    <\frame>
      We have two cases, one base case when<nbsp><math|<with|font-shape|italic|L>><nbsp>is
      the empty list<nbsp><math|<with|font-shape|italic|n><with|font-shape|italic|i><with|font-shape|italic|l>>,
      and one inductive case for a\ 

      non-empty list.
    </frame>

    <\frame>
      <with|font-series|bold|Base case,<nbsp><math|<with|font-shape|italic|l><nbsp>=<nbsp><with|font-shape|italic|n><with|font-shape|italic|i><with|font-shape|italic|l>>:>

      <frame|Here, we want to prove that<nbsp><math|length(<with|font-shape|italic|rev<around*|(|nil|)>>)
      =<nbsp><with|font-shape|italic|length<around*|(|nil|)>>>.><math|>

      <frame|by definition , rev(nil) = nil . so it si proved.>

      \;
    </frame>

    <\frame>
      <em|<strong|inductive case>>: <math|L=x\<colons\>L<rprime|'>>

      <\frame>
        To show:\ 

        <em|length(rev(x::L'))=length(x::L')>
      </frame>

      <\frame>
        IH:\ 

        <em|length(rev(L'))=length(L')>
      </frame>

      <\frame>
        <\em>
          proof:

          length(rev(x::L'))=length(append(rev(L'),x::nil))

          \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ =length(rev(L'))+length(x::nil)

          \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ =length(x::nil)+length(L')

          \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ =length(x::L')
        </em>

        \;
      </frame>
    </frame>

    EQD

    \;

    \;
  </proof>

  <subsection|>

  <\proposition>
    \;

    For all L <math|\<in\>L<rsub|Z>>, rev(rev(L)) = L
  </proposition>

  <\proof>
    by list induction on L

    three case:

    base case1 L is nil.

    base case2 L is x::nil

    inductive case L is not nil.

    <strong|Base case1: L=nil:>

    to show : <em|rev(rev(nil))=nil>

    by definiton <em|rev(rev(nil))=rev(nil)=nil>

    <strong|Basae cae2 L=x::nil>:

    to show: <math|rev<around*|(|rev<around*|(|x\<colons\>nil|)>|)>=rev<around*|(|x\<colons\>nil|)>>

    becasue <math|rev<around*|(|x::nil|)>=><math|rev<around*|(|append<around*|(|rev<around*|(|nil|)>,rev<around*|(|x:nil|)>|)>|)>=x\<colons\>nil>

    <math|rev<around*|(|rev<around*|(|x\<colons\>nil|)>|)>=rev<around*|(|x::nil|)>==x\<colons\>nil>

    <\strong>
      inductive case: L=append(L1,L2), where
      <math|L<rsub|1>\<neq\>nil,L2\<neq\>nil>
    </strong>

    <em|to show>: rev(rev(append(L1,L2)))=append(L1,L2)

    IH: rev(rev(L1))=L1, rev(rev(L2))=L2

    <\math>
      rev<around*|(|rev<around*|(|append<around*|(|L1,L2|)>|)>|)>=rev<around*|(|append<around*|(|rev<around*|(|L2|)>,rev<around*|(|L1|)>|)>|)>

      =append<around*|(|rev<around*|(|rev<around*|(|L2|)>|)>,rev<around*|(|rev<around*|(|L1|)>|)>|)>=append<around*|(|L1,L2|)>
    </math>

    QED

    \;
  </proof>

  <section|>

  <\subsection>
    \;
  </subsection>

  <subsection|>

  <\proposition>
    For all T <math|\<in\>> <math|T<rsub|Z>>, size(T) = length(inorder (T))
  </proposition>

  <\proof>
    by list induction on L

    two case :\ 

    base case T is empty

    inducitive case: T is not empty but rather <em|node(<math|t1,x,t2>)>

    <\strong>
      base case T = empty
    </strong>

    to show: <em|size(empty)=length(inorder(empty))>

    size(empty)=0 \ \ \ -\<gtr\>by definition

    length(inorder(empty))=length(nil)=0 -\<gtr\>by def

    so equal

    <\strong>
      inducitive case T=node(t1,x,t2):
    </strong>

    to show:<em|size(node(t1,x,t2))=length(inorder(node(t1,x,t2)))>

    IH: <math|size<around*|(|t1|)>=length<around*|(|inorder<around*|(|t1|)>|)>>,

    \ \ \ \ \ <math|size<around*|(|t2|)>=length<around*|(|inorder<around*|(|t2|)>|)>>

    \;

    <math|<tabular|<tformat|<table|<row|<cell|size<around*|(|node<around*|(|t1,x,t2|)>|)>>|<cell|=>|<cell|1+size<around*|(|t1|)>+size<around*|(|t2|)>>>|<row|<cell|>|<cell|=>|<cell|1+length<around*|(|inorder<around*|(|t1|)>|)>+length<around*|(|inorder<around*|(|t2|)>|)>>>|<row|<cell|>|<cell|>|<cell|>>|<row|<cell|length<around*|(|inorder<around*|(|node<around*|(|t1,x,t2|)>|)>|)>>|<cell|=>|<cell|length<around*|(|append<around*|(|inorder<around*|(|t1|)>,x\<colons\>inorder<around*|(|t2|)>|)>|)>>>|<row|<cell|>|<cell|=>|<cell|length<around*|(|inorder<around*|(|t1|)>|)>+length<around*|(|x\<colons\>nil|)>+length<around*|(|inorder<around*|(|t2|)>|)>>>|<row|<cell|>|<cell|=>|<cell|1+length<around*|(|inorder<around*|(|t1|)>|)>+length<around*|(|inorder<around*|(|t2|)>|)>>>|<row|<cell|>|<cell|>|<cell|>>|<row|<cell|left>|<cell|=>|<cell|right>>>>>>

    EQD

    \;
  </proof>
</body>

<initial|<\collection>
</collection>>

<\references>
  <\collection>
    <associate|auto-1|<tuple|1|?|../../.TeXmacs/texts/scratch/no_name_17.tm>>
    <associate|auto-2|<tuple|2|?|../../.TeXmacs/texts/scratch/no_name_17.tm>>
    <associate|auto-3|<tuple|2.1|?|../../.TeXmacs/texts/scratch/no_name_17.tm>>
    <associate|auto-4|<tuple|2.2|?|../../.TeXmacs/texts/scratch/no_name_17.tm>>
    <associate|auto-5|<tuple|3|?|../../.TeXmacs/texts/scratch/no_name_17.tm>>
    <associate|auto-6|<tuple|3.1|?|../../.TeXmacs/texts/scratch/no_name_17.tm>>
    <associate|auto-7|<tuple|3.2|?|../../.TeXmacs/texts/scratch/no_name_17.tm>>
    <associate|auto-9|<tuple|3.4|?|../../.TeXmacs/texts/scratch/no_name_17.tm>>
  </collection>
</references>