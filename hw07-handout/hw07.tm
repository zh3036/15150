<TeXmacs|1.99.2>

<style|generic>

<\body>
  <doc-data|<doc-title|HW07>|<doc-author|<\author-data|<author-name|zihan
  zhou>>
    \;
  </author-data>>>

  <section|WILD>

  Case <math|r\<cong\>> Wild:

  to show :

  <math|\<forall\>cs:char list,k: char list\<rightarrow\> bool>
  <math|<around*|{|match wild cs k \<hookrightarrow\>true\|\<exists\>p,s,p\<circ\>s\<cong\>cs
  \<wedge\> p\<in\> L<around*|(|_|)> \<wedge\> k s \<hookrightarrow\>
  true|}>>

  <\code>
    match Wild cs k =\ 

    \ \ \ \ (case cs of

    \ \ \ \ \ \ nil =\<gtr\> false

    \ \ \ \ \ \ \| c'::cs' =\<gtr\> k cs')
  </code>

  Since match Wild cs k <math|\<cong\>> true

  then cs is for sure not nil.

  so cs must has form <em|c'::cs'>, and <em|k cs'><math|\<hookrightarrow\>>
  true

  let p = [c'], s=cs',

  then cs=p@s, and p<math|\<in\>>L(_), and k s <math|\<hookrightarrow\>true>

  <section|BOTH>

  Case r \<sim\>= Both(r1, r2): To show:\ 

  <math|\<forall\>cs:char list,k:<around*|(|char
  list\<rightarrow\>bool|)><around*|{|match<around*|(|Both<around*|(|r<rsub|1>,r<rsub|2>|)>|)>
  cs<rprime|'> k \<hookrightarrow\>true\<nocomma\>\|\<exists\>p,s:char
  list,p\<circ\>s\<cong\>cs<rprime|'> \<wedge\>
  p\<in\>L<around*|(|r<rsub|1>\<cap\>r<rsub|2>|)> <rsup|>\<wedge\> k s
  \<hookrightarrow\>true|}>>

  two IHs:

  IH1: <math|\<forall\>cs<rsub|1>:char list,k<rsub|1>:<around*|(|char
  list\<rightarrow\>bool|)><around*|{|match<around*|(|r<rsub|1>|)> cs<rsub|1>
  k<rsub|1> \<hookrightarrow\>true\<nocomma\>\|\<exists\>p<rsub|1>,s<rsub|1>:char
  list,p<rsub|1>\<circ\>s<rsub|1>\<cong\>cs<rsub|1> \<wedge\>
  p<rsub|1>\<in\>L<around*|(|r<rsub|1>|)> <rsup|>\<wedge\> k<rsub|1>
  s<rsub|1> \<hookrightarrow\>true|}>>

  IH2: <math|\<forall\>cs<rsub|2>:char list,k<rsub|2>:<around*|(|char
  list\<rightarrow\>bool|)><around*|{|match<around*|(|r<rsub|2>|)> cs<rsub|2>
  k<rsub|2> \<hookrightarrow\>true\<nocomma\>\|\<exists\>p<rsub|2>,s<rsub|2>:char
  list,p<rsub|2>\<circ\>s<rsub|2>\<cong\>cs<rsub|2> \<wedge\>
  p<rsub|2>\<in\>L<around*|(|r<rsub|2>|)> <rsup|>\<wedge\> k<rsub|2>
  s<rsub|2> \<hookrightarrow\>true|}>>

  \;

  <\code>
    \ \ \ \| match (Both(r1,r2)) cs k =\ 

    \ \ \ match r1 cs (fn u1=\<gtr\>

    \ \ \ \ match r2 cs (fn u2=\<gtr\>

    \ \ \ \ \ \ u1=u2 andalso k(u1) andalso k(u2)))
  </code>

  we know\ 

  1.match (Both(r1,r2)) cs k <math|\<hookrightarrow\>true>

  so

  match r1 cs (fn u1=\<gtr\>

  \ \ \ \ match r2 cs (fn u2=\<gtr\>

  \ \ \ \ \ \ u1=u2 andalso k(u1) andalso k(u2)))
  <math|\<hookrightarrow\>true>

  by IH1:

  let <math|> <math|cs<rsub|1>=cs>,\ 

  let <math|k<rsub|1>=>(fn u1=\<gtr\>

  \ \ \ \ match r2 cs (fn u2=\<gtr\>

  \ \ \ \ \ \ u1=u2 andalso k(u1) andalso k(u2)))

  then we have

  2.<math|cs<rsub|1>=p<rsub|1>\<circ\>u<rsub|1>>

  <\math>
    3.p<rsub|1>\<in\>L<around*|(|r1|)>
  </math>

  4.<label|4>(fn u1=\<gtr\>

  \ \ \ \ match r2 cs (fn u2=\<gtr\>

  \ \ \ \ \ \ u1=u2 andalso k(u1) andalso k(u2)))
  <math|u1\<hookrightarrow\>true>

  5. match r2 cs (fn u2=\<gtr\>

  \ \ \ \ \ \ u1=u2 andalso k(u1) andalso k(u2))<math|\<hookrightarrow\>true>

  apply IH2 on 5.

  let <math|cs<rsub|2>=cs>

  let <math|k<rsub|2>=>(fn u2=\<gtr\>

  \ \ \ \ \ \ u1=u2 andalso k(u1) andalso k(u2))

  then we have

  6.<math|cs<rsub|2>=p<rsub|2>\<circ\>u<rsub|2>>

  <\math>
    7.p<rsub|2>\<in\>L<around*|(|r2|)>
  </math>

  8.(fn u2=\<gtr\>

  \ \ \ \ \ \ u1=u2 andalso k(u1) andalso k(u2)) u2
  <math|\<hookrightarrow\>true>

  9.u1=u2 andalso k(u1) andalso k(u2) <math|\<hookrightarrow\>true>

  by lemma 1

  because u1 =u2 and p1@u1=p2@u2=cs ,so p1=p2

  So we find\ 

  p=p1=p2

  <math|p\<in\>L<around*|(|r1|)>\<cap\>L<around*|(|r2|)>\<Rightarrow\>p\<in\>L<around*|(|r1\<cap\>r2|)>>

  u=u1=u2

  <math|cs<rprime|'>>=cs=p@u

  k u= true

  QED

  \;

  \;
</body>

<\initial>
  <\collection>
    <associate|visited-color|magenta>
  </collection>
</initial>

<\references>
  <\collection>
    <associate|4|<tuple|2|?|../../.TeXmacs/texts/scratch/no_name_17.tm>>
    <associate|auto-1|<tuple|1|?|../../.TeXmacs/texts/scratch/no_name_17.tm>>
    <associate|auto-2|<tuple|2|?|../../.TeXmacs/texts/scratch/no_name_17.tm>>
    <associate|here|<tuple|2|?|../../.TeXmacs/texts/scratch/no_name_17.tm>>
    <associate|jhj|<tuple|2|?|../../.TeXmacs/texts/scratch/no_name_17.tm>>
  </collection>
</references>

<\auxiliary>
  <\collection>
    <\associate|toc>
      <vspace*|1fn><with|font-series|<quote|bold>|math-font-series|<quote|bold>|1<space|2spc>WILD>
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-1><vspace|0.5fn>

      <vspace*|1fn><with|font-series|<quote|bold>|math-font-series|<quote|bold>|2<space|2spc>BOTH>
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-2><vspace|0.5fn>
    </associate>
  </collection>
</auxiliary>