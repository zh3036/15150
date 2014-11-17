<TeXmacs|1.0.7.21>

<style|generic>

<\body>
  <doc-data|<doc-title|HW02>|<doc-author|<\author-data|<author-name|ZIhan
  \ ZHou>>
    \;
  </author-data>>>

  <section|>

  <section|>

  <subsection|>

  <\equation*>
    <tabular|<tformat|<table|<row|<cell|<choice|<tformat|<table|<row|<cell|isize<around*|(|iEmpty|)>>|<cell|=>|<cell|0>>|<row|<cell|isize<around*|(|iLeaf|)>>|<cell|=>|<cell|1>>|<row|<cell|isize<around*|(|iNode<around*|(|t<rsub|L>,i,t<rsub|R>|)>|)>>|<cell|=>|<cell|isize<around*|(|t<rsub|L>|)>+isize<around*|(|t<rsub|R>|)>>>>>>>>>>>
  </equation*>

  <subsection|>

  <\equation*>
    <choice|<tformat|<table|<row|<cell|validate<around*|(|iEmpty|)>>|<cell|=>|<cell|True>>|<row|<cell|validate<around*|(|iLeaf|)>>|<cell|=>|<cell|True>>|<row|<cell|validate<around*|(|iNode<around*|(|t<rsub|L>,i,t<rsub|R>|)>|)>>|<cell|=>|<cell|validate<around*|(|t<rsub|L>|)>
    and validate<around*|(|t<rsub|R>|)> and
    i\<longequal\>isize<around*|(|t<rsub|R>|)>-isize<around*|(|t<rsub|L>|)>>>>>>
  </equation*>

  <subsection|>

  <\equation*>
    <choice|<tformat|<table|<row|<cell|isize<rprime|'><around*|(|iEmpty|)>>|<cell|=>|<cell|0>>|<row|<cell|isize<rprime|'><around*|(|iLeaf|)>>|<cell|=>|<cell|1>>|<row|<cell|isize<rprime|'><around*|(|iNode<around*|(|t<rsub|L>,i,t<rsub|R>|)>|)>>|<cell|=>|<cell|isize<rprime|'><around*|(|t<rsub|L>|)>\<times\>2+i>>>>>
  </equation*>

  <subsection|>

  <\equation*>
    <choice|<tformat|<table|<row|<cell|tiltLeft<around*|(|iEmpty|)>>|<cell|=>|<cell|iEmpty>>|<row|<cell|tiltLeft<around*|(|iLeaf|)>>|<cell|=>|<cell|iLeaf>>|<row|<cell|tiltLeft<around*|(|iNode<around*|(|t<rsub|L>,i,t<rsub|R>|)>|)>>|<cell|=>|<cell|<choice|<tformat|<table|<row|<cell|if
    i\<leqslant\>0>|<cell|:>|<cell|iNode<around*|(|tiltLeft<around*|(|t<rsub|L>|)>,i,tiltLeft<around*|(|t<rsub|R>|)>|)>>>|<row|<cell|if
    i\<gtr\>0>|<cell|:>|<cell|<around*|\<nobracket\>|iNode<around*|(|tiltLeft<around*|(|t<rsub|R>|)>,-i,tiltLeft<around*|(|t<rsub|L>|)>|\<nobracket\>>|)>>>>>>>>>>>
  </equation*>

  <subsection|>

  <\proposition>
    . For all t <math|\<in\>> TT, if validate(t) = true , then iSize' (t) =
    iSize(t).
  </proposition>

  <\proof>
    by tree induction on t.

    There are three cases: <em|iempty, ileaf, inode.>

    <strong|Base case ><em|t=iempty>:

    <strong|to shhow:> <em|if validate(iempty), then
    iSzize'(iempty)=iSize(iempty)>

    by definition we know that no matter what condition:
    <math|isize<around*|(|imepty|)>=0=iszei<rprime|'><around*|(|iempty|)>>

    <strong|Base case>2 <em|t=iLeaf:>

    <strong|to shhow>: <em|if validate(ileaf), then
    iSzize'(ileaf)=iSize(ileaf)>

    same, by def, we know it is always true.

    <strong|Inductive case> <em|t=iNode<math|<around*|(|t<rsub|L>,i,t<rsub|R>|)>>:>

    <strong|to show> if <em|validate<math|<around*|(|iNode<around*|(|t<rsub|L>,i,t<rsub|R>|)>|)>>
    then iSize<math|<rprime|'><around*|(|iNode<around*|(|t<rsub|L>,i,t<rsub|R>|)>|)>=>iSize<math|<around*|(|iNode<around*|(|t<rsub|L>,i,t<rsub|R>|)>|)>>
    >

    <strong|our IH is> the proposition 1 holds for <math|t<rsub|L> > and
    <math|t<rsub|R>>

    suppose validate<math|<around*|(|iNode<around*|(|t<rsub|L>,i,t<rsub|R>|)>|)>>

    <tabular|<tformat|<table|<row|<cell|iSize<math|<rprime|'><around*|(|iNode<around*|(|t<rsub|L>,i,t<rsub|R>|)>|)>>>|<cell|=>|<cell|<math|isize<rprime|'><around*|(|t<rsub|L>|)>\<times\>2+i>>|<cell|>|<cell|>|<cell|by
    def of isze'>>|<row|<cell|>|<cell|=>|<cell|<math|isize<rprime|'><around*|(|t<rsub|L>|)>\<times\>2+isize<around*|(|t<rsub|R>|)>-isize<around*|(|t<rsub|L>|)>>>|<cell|>|<cell|>|<cell|by
    def validate>>|<row|<cell|>|<cell|=>|<cell|<math|isize<around*|(|t<rsub|L>|)>\<times\>2+isize<around*|(|t<rsub|R>|)>-isize<around*|(|t<rsub|L>|)>>>|<cell|>|<cell|>|<cell|by
    IH>>|<row|<cell|>|<cell|=>|<cell|<math|isize<around*|(|t<rsub|L>|)>+isize<around*|(|t<rsub|R>|)>>>|<cell|>|<cell|>|<cell|by
    math>>|<row|<cell|>|<cell|=>|<cell|<math|isize<around*|(|iNode<around*|(|t<rsub|L>,i,t<rsub|R>|)>|)>>>|<cell|>|<cell|>|<cell|by
    def if isze>>>>>

    \;

    \;

    \;
  </proof>

  <subsection|>

  <\proposition>
    \ For all t <math|\<in\>>TT, if validate(t) = true , then
    validate(tiltLeft(t)) = true .
  </proposition>

  <\lemma>
    For all t <math|\<in\>>TT, iSize(tiltLeft(t)) = iSize(t).
  </lemma>

  <\proof>
    by tree induction on t

    There are three cases: <em|iempty, ileaf, inode.>

    <strong|Base case ><em|t=iempty>:

    <strong|to show> if validate(iempty) = true , then
    validate(tiltLeft(iempty)) = true

    by def, \ validate(tiltLeft(iempty))=validate(iempty) which is always
    true

    <strong|Base case>2 <em|t=iLeaf:>

    <strong|to show> if validate(ileaf) = true , then
    validate(tiltLeft(ileaf)) = true

    same way as base case 1, this is true.

    <strong|Inductive case> <em|t=iNode<math|<around*|(|t<rsub|L>,i,t<rsub|R>|)>>:>

    <strong|IH:> proposition 2 holds for tR and tL

    <strong|to show> if validate(iNode<math|<around*|(|t<rsub|L>,i,t<rsub|R>|)>>)
    = true , then validate(tiltLeft(iNode<math|<around*|(|t<rsub|L>,i,t<rsub|R>|)>>))
    = true

    suppose validate(iNode<math|<around*|(|t<rsub|L>,i,t<rsub|R>|)>>)

    two inductive case, if i\<less\>=0 or i\<gtr\>0

    i\<less\>=0:

    <tabular|<tformat|<table|<row|<cell|validate(tiltLeft(iNode<math|<around*|(|t<rsub|L>,i,t<rsub|R>|)>>))>|<cell|>|<cell|>|<cell|>>|<row|<cell|=validate(<math|iNode<around*|(|tiltLeft<around*|(|t<rsub|L>|)>,i,tiltLeft<around*|(|t<rsub|R>|)>|)>>>|<cell|>|<cell|>|<cell|def
    of tilt>>|<row|<cell|=<math|validate<around*|(|tiltLeft<around*|(|t<rsub|L>|)>|)>
    and validate<around*|(|tiltLeft<around*|(|t<rsub|R>|)>|)> and
    i\<longequal\>isize<around*|(|t<rsub|R>|)>-isize<around*|(|t<rsub|L>|)>>>|<cell|>|<cell|>|<cell|def
    of vali,lema3>>|<row|<cell|=True and True and
    <math|i\<longequal\>isize<around*|(|t<rsub|R>|)>-isize<around*|(|t<rsub|L>|)>>>|<cell|>|<cell|>|<cell|IH>>|<row|<cell|=True
    and True and True>|<cell|>|<cell|>|<cell|def of vali>>>>>

    i\<gtr\>0:

    <tabular|<tformat|<table|<row|<cell|validate(tiltLeft(iNode<math|<around*|(|t<rsub|L>,i,t<rsub|R>|)>>))>|<cell|>|<cell|>|<cell|>>|<row|<cell|=validate(<math|iNode<around*|(|tiltLeft<around*|(|t<rsub|R>|)>,-i,tiltLeft<around*|(|t<rsub|L>|)>|)>>>|<cell|>|<cell|>|<cell|def
    of tilt>>|<row|<cell|=<math|validate<around*|(|tiltLeft<around*|(|t<rsub|R>|)>|)>
    and validate<around*|(|tiltLeft<around*|(|t<rsub|L>|)>|)> and
    -i\<longequal\>isize<around*|(|t<rsub|L>|)>-isize<around*|(|t<rsub|R>|)>>>|<cell|>|<cell|>|<cell|def
    of vali,lema3>>|<row|<cell|=True and True and
    -<math|i\<longequal\>isize<around*|(|t<rsub|L>|)>-isize<around*|(|t<rsub|R>|)>>>|<cell|>|<cell|>|<cell|IH>>|<row|<cell|=True
    and True and True>|<cell|>|<cell|>|<cell|def of vali>>>>>

    \;
  </proof>

  <section|>

  <subsection|>

  Yes they all are.

  <math|for \<bbb-l\>\<nocomma\>,\<bbb-P\>\<nocomma\> ,they> have
  <math|\<bbb-Z\>> in their def, since Z is inducitive domain, then they are
  inductive doman.

  for <math|\<bbb-O\>,>it can be north in O, O turn right still in O.

  for <math|\<bbb-L\><rsub|1>\<nocomma\>>, empty insttruction is in it, and
  any L1 elem with 1 more instruction is also in.

  <subsection|>

  <\math>
    turnRight<around*|(|<around*|(|x,y,o|)>|)>=<choice|<tformat|<table|<row|<cell|if
    o=north>|<cell|<around*|(|x,y,east|)>>>|<row|<cell|if
    o=east>|<cell|<around*|(|x,y,south|)>>>|<row|<cell|if
    o=south>|<cell|<around*|(|x,y,west|)>>>|<row|<cell|if
    o=west>|<cell|<around*|(|x,y,north|)>>>>>>

    \;
  </math>

  <subsection|>

  <math|move<around*|(|n,<around*|(|x,y,o|)>|)>=><math|<choice|<tformat|<table|<row|<cell|if
  o=north>|<cell|<around*|(|x,y+n,north|)>>>|<row|<cell|if
  o=east>|<cell|<around*|(|x+n,y,east|)>>>|<row|<cell|if
  o=south>|<cell|<around*|(|x,y-n,south|)>>>|<row|<cell|if
  o=west>|<cell|<around*|(|x-n,y,west|)>>>>>>>

  <subsection|>

  <\equation*>
    <choice|<tformat|<table|<row|<cell|getPosition <around*|(|<around*|[|
    |]>,<around*|(|x,y,o|)>|)>=<around*|(|x,y,o|)>>>|<row|<cell|getPosition
    <around*|(|R\<circ\>l,<around*|(|x,y,o|)>|)>=getPosition<around*|(|l,turnRight<around*|(|<around*|(|x,y,o|)>|)>|)>>>|<row|<cell|getPosition
    <around*|(|s n\<circ\>l,<around*|(|x,y,0|)>|)>=getPosition<around*|(|l,move<around*|(|n,<around*|(|x,y,o|)>|)>|)>>>>>>
  </equation*>

  <subsection|>

  <\proposition>
    For all l1, l2 <math|\<in\>> LI and for all p <math|\<in\>> P,

    getPosition(l1<math|\<circ\>>l2, p) = getPosition(l2, getPosition(l1, p))
  </proposition>

  <\proof>
    by list induction on <math|l<rsub|1>>

    <strong|3 cases: > one for <math|l<rsub|1>> is [] , two for
    <math|l<rsub|1>> is not [ ]

    <strong|Base case>: <math|l<rsub|1>> is [ ]

    <strong|to show:> getPosition(<math|<around*|[| |]>\<circ\>l<rsub|2>>, p)
    = getPosition(<math|l<rsub|2>>, getPosition(<math|<around*|[| |]>>, p))

    by def, getPosition(<math|l<rsub|2>>, getPosition(<math|<around*|[| |]>>,
    p))=getPosition(<math|l<rsub|2>>, p)=getPosition(<math|<around*|[|
    |]>\<circ\>l<rsub|2>>, p)

    <strong|Inductive case 1> <math|l<rsub|1> =R\<circ\>l<rsub|1><rprime|'>>

    <strong|to show> :getPosition(<math|R\<circ\>l<rsub|1><rprime|'>\<circ\>l<rsub|2>>,
    p) = getPosition(<math|l<rsub|2>>, getPosition(<math|R\<circ\>l<rsub|1><rprime|'>>,
    p))

    <strong|IH:> getPosition(<math|l<rsub|1><rprime|'>\<circ\>l<rsub|2>>, p)
    = getPosition(<math|l<rsub|2>>, getPosition(<math|l<rsub|1><rprime|'>>,
    p))

    <tabular|<tformat|<table|<row|<cell|>|<cell|getPosition(<math|R\<circ\>l<rsub|1><rprime|'>\<circ\>l<rsub|2>>,
    p) >|<cell|=>|<cell|<math|getPosition<around*|(|l<rsub|1><rprime|'>\<circ\>l<rsub|2>,turnRight<around*|(|p|)>|)>>>|<cell|by
    def>>|<row|<cell|>|<cell|>|<cell|=>|<cell|getPosition(<math|l<rsub|2>>,
    getPosition(<math|l<rsub|1><rprime|'>>,
    <math|turnRight<around*|(|p|)>>))>|<cell|by
    IH>>|<row|<cell|>|<cell|>|<cell|=>|<cell|getPosition(<math|l<rsub|2>>,
    getPosition(<math|R\<circ\>l<rsub|1><rprime|'>>, p))>|<cell|by def>>>>>

    \;

    <strong|Inductive case 2> <math|l<rsub|1>=s n\<circ\>l<rsub|1><rprime|'>>

    <strong|to show> :getPosition(<math|s
    n\<circ\>l<rsub|1><rprime|'>\<circ\>l<rsub|2>>, p) =
    getPosition(<math|l<rsub|2>>, getPosition(<math|s
    n\<circ\>l<rsub|1><rprime|'>>, p))

    <strong|IH:> getPosition(<math|l<rsub|1><rprime|'>\<circ\>l<rsub|2>>, p)
    = getPosition(<math|l<rsub|2>>, getPosition(<math|l<rsub|1><rprime|'>>,
    p))

    <tabular|<tformat|<table|<row|<cell|>|<cell|getPosition(<math|s
    n\<circ\>l<rsub|1><rprime|'>\<circ\>l<rsub|2>>, p)
    >|<cell|=>|<cell|<math|getPosition<around*|(|l<rsub|1><rprime|'>\<circ\>l<rsub|2>,move<around*|(|n,p|)>|)>>>|<cell|by
    def>>|<row|<cell|>|<cell|>|<cell|=>|<cell|getPosition(<math|l<rsub|2>>,
    getPosition(<math|l<rsub|1><rprime|'>>,
    <math|move<around*|(|n,p|)>>))>|<cell|by
    IH>>|<row|<cell|>|<cell|>|<cell|=>|<cell|getPosition(<math|l<rsub|2>>,
    getPosition(<math|s n\<circ\>l<rsub|1><rprime|'>>, p))>|<cell|by def>>>>>
  </proof>

  <subsection|>

  <\equation*>
    <choice|<tformat|<table|<row|<cell|goback<around*|(|<around*|[|
    |]>|)>>|<cell|=>|<cell|<around*|[| |]>>>|<row|<cell|goback<around*|(|R\<circ\>l|)>>|<cell|=>|<cell|goback<around*|(|l|)>\<circ\>
    <around*|[|R, R, R|]>>>|<row|<cell|goback<around*|(|s
    n\<circ\>l|)>>|<cell|=>|<cell|goback<around*|(|l|)>\<circ\>s -n>>>>>
  </equation*>

  <subsection|>

  <\proposition>
    For all l <math|\<in\>> L and p <math|\<in\>> P

    <math|getPosition(l<math|\<circ\>>(goBack(l)), p) = p>
  </proposition>

  <\proof>
    by list induction on l

    <strong|3 cases: > one for <math|l<rsub|1>> is [] , two for
    <math|l<rsub|1>> is not [ ]

    <strong|Base case>: <math|l<rsub|>> is [ ]

    <strong|to show> <math|getPosition(<around*|[|
    |]><math|\<circ\>>(goBack(<around*|[| |]>)), p) = p>

    <math|getPosition(<around*|[| |]><math|\<circ\>>(goBack(<around*|[|
    |]>)), p) =getPosition(<around*|[| |]><math|\<circ\>><around*|[| |]>, p)
    >by def

    = <math|p> by def

    <strong|Inductive case 1> <math|l =s n\<circ\>l<rsub|><rprime|'>>

    <strong|to show> <math|getPosition(s n\<circ\>l<rprime|'><rsub|><math|\<circ\>>(goBack(s
    n\<circ\>l<rprime|'><rsub|>)), p) = p>

    <strong|IH <math|>><math|getPosition(l<rprime|'><math|\<circ\>>(goBack(l<rprime|'>)),
    p) = p>

    <tabular|<tformat|<table|<row|<cell|>|<cell|<math|getPosition(s
    n\<circ\>l<rprime|'><rsub|><math|\<circ\>>(goBack(s
    n\<circ\>l<rprime|'><rsub|>)), p)>>|<cell|>|<cell|<math|>>>|<row|<cell|=>|<cell|<math|getPosition(l<rprime|'><rsub|><math|\<circ\>>(goBack(s
    n\<circ\>l<rprime|'><rsub|>)), move<around*|(|n,p|)>)>>|<cell|>|<cell|by
    def of getPos>>|<row|<cell|=>|<cell|<math|getPosition(l<rprime|'><rsub|><math|\<circ\>>(goback<around*|(|l<rprime|'>|)>\<circ\>
    s -n), move<around*|(|n,p|)>)>>|<cell|>|<cell|by def of
    goback>>|<row|<cell|=>|<cell|<math|getPosition(<around*|(|l<rprime|'><rsub|><math|\<circ\>>goback<around*|(|l<rprime|'>|)>|)>\<circ\>
    s -n, move<around*|(|n,p|)>)>>|<cell|>|<cell|assoiciativty>>|<row|<cell|=>|<cell|<math|getPosition(s
    -n,getPosition<around*|(|<around*|(|l<rprime|'><rsub|><math|\<circ\>>goback<around*|(|l<rprime|'>|)>|)>,
    move<around*|(|n,p|)>|)>)>>|<cell|>|<cell|by
    3.6>>|<row|<cell|=>|<cell|<math|getPosition(s
    -n,<around*|\<nobracket\>|move<around*|(|n,p|)>|)>>>|<cell|>|<cell|IH>>|<row|<cell|=>|<cell|p>|<cell|>|<cell|back
    forth>>>>>

    \;

    <strong|Inductive case 12> <math|l<rsub|> =R\<circ\>l<rsub|><rprime|'>>

    <strong|to show> <math|getPosition(R\<circ\>l<rprime|'><rsub|><math|\<circ\>>(goBack(R\<circ\>l<rprime|'><rsub|>)),
    p) = p>

    <strong|IH <math|>><math|getPosition(l<rprime|'><math|\<circ\>>(goBack(l<rprime|'>)),
    p) = p>

    <tabular|<tformat|<table|<row|<cell|>|<cell|<math|getPosition(R\<circ\>l<rprime|'><rsub|><math|\<circ\>>(goBack(R\<circ\>l<rprime|'><rsub|>)),
    p)>>|<cell|>|<cell|<math|>>>|<row|<cell|=>|<cell|<math|getPosition(l<rprime|'><rsub|><math|\<circ\>>(goBack(R\<circ\>l<rprime|'><rsub|>)),
    turnRight<around*|(|p|)>)>>|<cell|>|<cell|by def of
    getPos>>|<row|<cell|=>|<cell|<math|getPosition(l<rprime|'><rsub|><math|\<circ\>>(goback<around*|(|l<rprime|'>|)>\<circ\>
    <around*|[|R, R, R|]>), turnRight<around*|(|p|)>)>>|<cell|>|<cell|by def
    of goback>>|<row|<cell|=>|<cell|<math|getPosition(<around*|(|l<rprime|'><rsub|><math|\<circ\>>goback<around*|(|l<rprime|'>|)>|)>\<circ\>
    <around*|[|R, R, R|]>, turnRight<around*|(|p|)>)>>|<cell|>|<cell|assoiciativty>>|<row|<cell|=>|<cell|<math|getPosition(<around*|[|R,
    R, R|]>,getPosition<around*|(|<around*|(|l<rprime|'><rsub|><math|\<circ\>>goback<around*|(|l<rprime|'>|)>|)>,
    turnRight<around*|(|p|)>|)>)>>|<cell|>|<cell|by
    3.6>>|<row|<cell|=>|<cell|<math|getPosition(<around*|[|R, R,
    R|]>,<around*|\<nobracket\>| turnRight<around*|(|p|)>|)>>>|<cell|>|<cell|IH>>|<row|<cell|=>|<cell|p>|<cell|>|<cell|by
    360>>>>>
  </proof>

  \;

  \;
</body>

<initial|<\collection>
</collection>>

<\references>
  <\collection>
    <associate|auto-1|<tuple|1|?>>
    <associate|auto-10|<tuple|3.1|?>>
    <associate|auto-11|<tuple|3.2|?>>
    <associate|auto-12|<tuple|3.3|?>>
    <associate|auto-13|<tuple|3.4|?>>
    <associate|auto-14|<tuple|3.5|?>>
    <associate|auto-15|<tuple|3.6|?>>
    <associate|auto-16|<tuple|3.7|?>>
    <associate|auto-2|<tuple|2|?>>
    <associate|auto-3|<tuple|2.1|?>>
    <associate|auto-4|<tuple|2.2|?>>
    <associate|auto-5|<tuple|2.3|?>>
    <associate|auto-6|<tuple|2.4|?>>
    <associate|auto-7|<tuple|2.5|?>>
    <associate|auto-8|<tuple|2.6|?>>
    <associate|auto-9|<tuple|3|?>>
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

      <with|par-left|<quote|1tab>|2.4<space|2spc>
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-6>>

      <with|par-left|<quote|1tab>|2.5<space|2spc>
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-7>>

      <with|par-left|<quote|1tab>|2.6<space|2spc>
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-8>>

      <vspace*|1fn><with|font-series|<quote|bold>|math-font-series|<quote|bold>|3<space|2spc>>
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-9><vspace|0.5fn>

      <with|par-left|<quote|1tab>|3.1<space|2spc>
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-10>>

      <with|par-left|<quote|1tab>|3.2<space|2spc>
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-11>>

      <with|par-left|<quote|1tab>|3.3<space|2spc>
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-12>>

      <with|par-left|<quote|1tab>|3.4<space|2spc>
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-13>>

      <with|par-left|<quote|1tab>|3.5<space|2spc>
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-14>>

      <with|par-left|<quote|1tab>|3.6<space|2spc>
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-15>>

      <with|par-left|<quote|1tab>|3.7<space|2spc>
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-16>>
    </associate>
  </collection>
</auxiliary>