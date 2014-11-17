<TeXmacs|1.0.7.21>

<style|generic>

<\body>
  <doc-data|<doc-title|hw03>|<doc-author|<\author-data|<author-name|zihan
  zhou>>
    \;
  </author-data>>>

  <section|>

  <section|>

  <subsection|>

  <\equation*>
    <choice|<tformat|<table|<row|<cell|multTail<rprime|'><around*|(|nil,x|)>=x>>|<row|<cell|multTail<rprime|'><around*|(|n\<colons\>l,x|)>=<around*|(|multTail<rprime|'><around*|(|l,n\<times\>x|)>|)>>>>>>
  </equation*>

  <\equation*>
    multTail<around*|(|l|)>=multTail<rprime|'><around*|(|l,1|)>
  </equation*>

  <subsection|>

  <subsection|>

  <subsubsection|>

  <\equation*>
    <choice|<tformat|<table|<row|<cell|W<rsub|m><around*|(|<around*|[|
    |]>|)>=k<rsub|0>>>|<row|<cell|W<rsub|m><around*|(|a\<colons\>l|)>=W<rsub|m><around*|(|l|)>+k<rsub|1>>>>>>
  </equation*>

  closed:

  <\equation*>
    W<rsub|m><around*|(|l|)>=len<around*|(|l|)>\<times\>k<rsub|1>+k<rsub|0>
  </equation*>

  it is <math|O<around*|(|n|)>>

  <subsubsection|>

  <math|W<rsub|T><around*|(|l|)>=W<rsub|T<rprime|'>><around*|(|l,1|)>>

  <\equation*>
    <choice|<tformat|<table|<row|<cell|W<rsub|T<rprime|'>><around*|(|<around*|[|
    |]>,1|)>=k<rsub|0>>>|<row|<cell|W<rsub|T<rprime|'>><around*|(|a\<colons\>l,x|)>=W<rsub|T<rprime|'>><around*|(|l,x-1|)>+k<rsub|1>>>>>>
  </equation*>

  <\math>
    W<rsub|T><around*|(|l|)>=len<around*|(|l|)>\<times\>k<rsub|1>+k<rsub|0>

    it is O<around*|(|n|)>
  </math>

  <subsubsection|>

  tail is more effcient

  <subsection|>

  <\lemma>
    <math|multTail<rprime|'><around*|(|l,x|)>\<times\>a=multTail<rprime|'><around*|(|l,x\<times\>a|)>>
  </lemma>

  <\proof>
    by list indution on <math|l>

    2 case l is nil, l is not

    bc: l=nil

    ts: multTail'(nil,x)<math|\<times\>>a=multTail'(nil,x<math|\<times\>>a)

    <math|multTail<around*|(|nil,x|)>\<times\>a=x\<times\>a=multTail<rprime|'><around*|(|nil,x\<times\>a|)>>

    Ind ca: <math|l=b\<colons\>l<rprime|'>>

    ts multTail'(b::l',x)<math|\<times\>>a=multTail'(b::l',x<math|\<times\>>a)

    ih: <math|multTail<rprime|'><around*|(|l<rprime|'>,x<rprime|'>|)>\<times\>a<rprime|'>=multTail<rprime|'><around*|(|l<rprime|'>,x<rprime|'>\<times\>a<rprime|'>|)>>

    <math|<tabular|<tformat|<table|<row|<cell|multTail<rprime|'><around*|(|b\<colons\>l<rprime|'>,x|)>\<times\>a>|<cell|=>|<cell|multTail<rprime|'><around*|(|l<rprime|'>,b\<times\>x|)>\<times\>a>|<cell|
    >|<cell|by def>>|<row|<cell|>|<cell|=>|<cell|multTail<rprime|'><around*|(|l<rprime|'>,b\<times\>x\<times\>a|)>>|<cell|>|<cell|by
    ih>>|<row|<cell|>|<cell|=>|<cell|multTail<rprime|'><around*|(|b\<colons\>l<rprime|'>,x\<times\>a|)>>|<cell|>|<cell|by
    def>>>>>>
  </proof>

  \;

  <\proposition>
    \;

    for all l <math|\<in\>> <math|\<bbb-L\><rsub|z>>,

    mult(l)=multTail(l)
  </proposition>

  <\proof>
    by list induction on l.

    there are two cases : l is nil or l is not.

    base case: l = nil

    to show : mult(nil)=multiTail(nil)

    mult(nil)=nil=mutilTail'(nil,1)=mutilTail(nil) \ by def

    Inductive case <math|l=a\<colons\>l<rprime|'>>

    to show: mult(a::l')=multTail(a::l')

    IH: mult(l')=multTail(l')

    <math|<tabular|<tformat|<table|<row|<cell|mult<around*|(|a\<colons\>l<rprime|'>|)>>|<cell|=>|<cell|mult<around*|(|l<rprime|'>|)>\<times\>a>|<cell|by
    def>>|<row|<cell|>|<cell|=>|<cell|multTail<around*|(|l<rprime|'>|)>*\<times\>a>|<cell|by
    ih>>|<row|<cell|>|<cell|=>|<cell|multTail<around*|(|l<rprime|'>,1|)>*\<times\>a>|<cell|by
    def>>|<row|<cell|>|<cell|=>|<cell|multTail<rprime|'><around*|(|l<rprime|'>,a|)>>|<cell|by
    lemma 1>>|<row|<cell|>|<cell|=>|<cell|multTail<around*|(|a\<colons\>l<rprime|'>|)>>|<cell|by
    def>>>>>>
  </proof>

  <subsection|>

  <\equation*>
    <choice|<tformat|<table|<row|<cell|even<around*|(|nil|)>=nil>>|<row|<cell|even<around*|(|a\<colons\>l|)>=<around*|(|a
    mod 2|)>\<colons\>even<around*|(|l|)>>>>>>
  </equation*>

  <subsection|>

  <subsection|>

  <subsubsection|>

  <\equation*>
    <choice|<tformat|<table|<row|<cell|W<rsub|eT<rprime|'>><around*|(|nil,x|)>=k<rsub|0>>>|<row|<cell|W<rsub|eT<rprime|'>><around*|(|a\<colons\>l,x|)>=W<rsub|eT<rprime|'>><around*|(|l,x\<circ\><around*|[|a|]>|)>+<around*|(|1+len<around*|(|x|)>|)>*k<rsub|2>*+k<rsub|1>>>>>>
  </equation*>

  <\equation*>
    W<rsub|eT><around*|(|l|)>=W<rsub|eT<rprime|'>><around*|(|l,<around*|[||]>|)>
  </equation*>

  close:

  <\equation*>
    <tabular|<tformat|<table|<row|<cell|W<rsub|eT><around*|(|l|)>>|<cell|=>|<cell|k<rsub|0>+len<around*|(|l|)>\<times\>k<rsub|1>+<frac|len<around*|(|l|)>\<times\><around*|(|len<around*|(|l|)>+1|)>|2>\<times\>k<rsub|2>>>>>>
  </equation*>

  <math|O<around*|(|n<rsup|2>|)>>

  <subsubsection|>

  <\equation*>
    <choice|<tformat|<table|<row|<cell|W<rsub|e><around*|(|nil|)>=k<rsub|0>>>|<row|<cell|W<rsub|e><around*|(|a\<colons\>l|)>=W<rsub|e><around*|(|l|)>+k<rsub|1>>>>>>
  </equation*>

  close

  <\equation*>
    W<rsub|e><around*|(|l|)>=k<rsub|0>+len<around*|(|l|)>\<times\>k<rsub|1>
  </equation*>

  <\math>
    O<around*|(|n|)>
  </math>

  <subsection|>

  <subsection|>

  <\proposition>
    \;

    for all l: int list

    even l <math|\<cong\>> evenTail l

    which is a special case k=nil for the following line\ 

    k <math|\<circ\>> even l<math| \<cong\>> evenTail'(l,k)
  </proposition>

  <\proof>
    \ by list induction on l

    thre are two cases: l is nil, l is a::l'.

    base case l=nil:

    ts: <math|k\<circ\>even nil \<cong\> evenTail<rprime|'>
    <around*|(|nil,k|)>>

    <math|k\<circ\>even nil=k=evenTail'(nil,k)>

    induitive case: <math|l=a\<colons\>l<rprime|'>>

    ts: <math|k\<circ\>>even (a::l') = evenTail'(a::l',k)

    IH: <math|k\<circ\>>even(l')=evenTail(l',k)

    <\math>
      <tabular|<tformat|<table|<row|<cell|evenTail<rprime|'><around*|(|a\<colons\>l<rprime|'>,k|)>>|<cell|=>|<cell|evenTail<rprime|'><around*|(|l<rprime|'>,k\<circ\><around*|[|<around*|(|a
      mod 2|)>|]>|)>>|<cell|by def>>|<row|<cell|>|<cell|=>|<cell|k\<circ\><around*|[|<around*|(|a
      mod 2|)>|]>\<circ\>even<around*|(|l<rprime|'>|)>>|<cell|by
      ih>>|<row|<cell|>|<cell|=>|<cell|k\<circ\><around*|(|<around*|(|a mod
      2|)>\<colons\>even<around*|(|l<rprime|'>|)>|)>>|<cell|by list function
      lema>>|<row|<cell|>|<cell|=>|<cell|k\<circ\>even<around*|(|a\<colons\>l<rprime|'>|)>>|<cell|by
      def>>>>>
    </math>

    \;
  </proof>

  <subsection|>

  we do not worry about mathematical property but only the definiton of the
  structure, in this case, list.

  It is still induction, but with less concern.

  <subsection|>

  <\equation*>
    <choice|<tformat|<table|<row|<cell|treepod<around*|(|Leaf<around*|(|z|)>|)>=z>>|<row|<cell|treepod<around*|(|node<around*|(|x,y|)>|)>=treepod<around*|(|x|)>\<times\>treepod<around*|(|y|)>>>>>>
  </equation*>

  <subsection|>

  <subsection|>

  no because it has two recursive calls, before reaching leaf, there are
  nothing to accumulate for node.

  <section|>

  <\subsection>
    ~ 3.7\ 

    3.8
  </subsection>

  <\code>
    smSum,smSum_cert,smSum_check
  </code>

  <\equation*>
    <choice|<tformat|<table|<row|<cell|W<rsub|s><around*|(|i,<around*|[|
    |]>|)>>|<cell|=>|<cell|k<rsub|0>>>|<row|<cell|W<rsub|s><around*|(|i,a\<colons\>l|)>>|<cell|=>|<cell|W<rsub|s><around*|(|i-a,l|)>+W<rsub|s><around*|(|i,l|)>+k<rsub|1>>>>>>
  </equation*>

  <math|let n denote the length of > <math|input> list. in the worst case,

  <\equation*>
    W<rsub|s>=2<rsup|n>*k<rsub|1>+k<rsub|0>
  </equation*>

  <\equation*>
    <choice|<tformat|<table|<row|<cell|S<rsub|s><around*|(|i,<around*|[|
    |]>|)>>|<cell|=>|<cell|k<rsub|0>>>|<row|<cell|S<rsub|s><around*|(|i,a\<colons\>l|)>>|<cell|=>|<cell|max<around*|(|W<rsub|s><around*|(|i-a,l|)>,W<rsub|s><around*|(|i,l|)>|)>+k<rsub|1>>>>>>
  </equation*>

  <math|let n denote the length of > <math|input> list. in the worst case,

  <\equation*>
    S<rsub|s>=n*k<rsub|1>+k<rsub|0>
  </equation*>

  for <verbatim|smSum_cert>, it just has larger <math|k<rsub|1>> , but
  essestially the same.

  for <verbatim|smSum_check>, it calls addtional <verbatim|sum> function
  which is completely sequential in my implementation, in worst case it adds
  <math|n*k<rsub|2>> to both work and span

  <\equation*>
    W<rsub|s>=2<rsup|n>*k<rsub|1>+k<rsub|0>+n*k<rsub|2>
  </equation*>

  <\equation*>
    S<rsub|check><around*|(|i,l|)>=n*<around*|(|k<rsub|1>+k<rsub|2>|)>+k<rsub|0>
  </equation*>

  in general <math|O<around*|(|S<rsub|>|)>=O<around*|(|n|)>>, and
  <math|O<around*|(|W|)>=2<rsup|n>>

  <section|>

  \;
</body>

<initial|<\collection>
</collection>>

<\references>
  <\collection>
    <associate|auto-1|<tuple|1|?>>
    <associate|auto-10|<tuple|2.5|?>>
    <associate|auto-11|<tuple|2.6|?>>
    <associate|auto-12|<tuple|2.7|?>>
    <associate|auto-13|<tuple|2.7.1|?>>
    <associate|auto-14|<tuple|2.7.2|?>>
    <associate|auto-15|<tuple|2.8|?>>
    <associate|auto-16|<tuple|2.9|?>>
    <associate|auto-17|<tuple|2.10|?>>
    <associate|auto-18|<tuple|2.11|?>>
    <associate|auto-19|<tuple|2.12|?>>
    <associate|auto-2|<tuple|2|?>>
    <associate|auto-20|<tuple|2.13|?>>
    <associate|auto-21|<tuple|3|?>>
    <associate|auto-22|<tuple|3.1|?>>
    <associate|auto-23|<tuple|4|?>>
    <associate|auto-25|<tuple|3.4|?>>
    <associate|auto-3|<tuple|2.1|?>>
    <associate|auto-31|<tuple|3.10|?>>
    <associate|auto-34|<tuple|3.13|?>>
    <associate|auto-4|<tuple|2.2|?>>
    <associate|auto-5|<tuple|2.3|?>>
    <associate|auto-6|<tuple|2.3.1|?>>
    <associate|auto-7|<tuple|2.3.2|?>>
    <associate|auto-8|<tuple|2.3.3|?>>
    <associate|auto-9|<tuple|2.4|?>>
  </collection>
</references>

<\auxiliary>
  <\collection>
    <\associate|toc>
      <vspace*|1fn><with|font-series|<quote|bold>|math-font-series|<quote|bold>|1<space|2spc>>
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-1><vspace|0.5fn>

      <vspace*|1fn><with|font-series|<quote|bold>|math-font-series|<quote|bold>|2<space|2spc>>
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-2><vspace|0.5fn>

      <with|par-left|<quote|1tab>|2.1<space|2spc>
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-3>>

      <with|par-left|<quote|1tab>|2.2<space|2spc>
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-4>>

      <with|par-left|<quote|1tab>|2.3<space|2spc>
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-5>>

      <with|par-left|<quote|2tab>|2.3.1<space|2spc>
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-6>>

      <with|par-left|<quote|2tab>|2.3.2<space|2spc>
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-7>>

      <with|par-left|<quote|2tab>|2.3.3<space|2spc>
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-8>>

      <with|par-left|<quote|1tab>|2.4<space|2spc>
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-9>>

      <with|par-left|<quote|1tab>|2.5<space|2spc>
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-10>>

      <with|par-left|<quote|1tab>|2.6<space|2spc>
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-11>>

      <with|par-left|<quote|1tab>|2.7<space|2spc>
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-12>>

      <with|par-left|<quote|2tab>|2.7.1<space|2spc>
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-13>>

      <with|par-left|<quote|2tab>|2.7.2<space|2spc>
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-14>>

      <with|par-left|<quote|1tab>|2.8<space|2spc>
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-15>>

      <with|par-left|<quote|1tab>|2.9<space|2spc>
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-16>>

      <with|par-left|<quote|1tab>|2.10<space|2spc>
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-17>>

      <with|par-left|<quote|1tab>|2.11<space|2spc>
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-18>>

      <with|par-left|<quote|1tab>|2.12<space|2spc>
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-19>>

      <with|par-left|<quote|1tab>|2.13<space|2spc>
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-20>>
    </associate>
  </collection>
</auxiliary>