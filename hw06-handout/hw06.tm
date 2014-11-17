<TeXmacs|1.0.7.21>

<style|generic>

<\body>
  <doc-data|<doc-title|hw06>|<doc-author|<\author-data|<author-name|zihan
  zhou>>
    \;
  </author-data>>>

  <section|work of convolve>

  <subsection|list>

  a,b is length of list

  <\equation*>
    W<rsub|con<rprime|'>><around*|(|a,b|)>=W<rsub|add><around*|(|b|)>+W<rsub|scale><around*|(|b|)>+W<rsub|con<rprime|'>><around*|(|a-1,b|)>+c<rsub|0>
  </equation*>

  <\equation*>
    W<rsub|con<rprime|'>><around*|(|0,b|)>=k<rsub|o>
  </equation*>

  trivial to show work of add and scale are <math|O<around*|(|n|)>>.

  <\equation*>
    W<rsub|con<rprime|'>><around*|(|a,b|)>=k*b+W<around*|(|a-1,b|)>+c<rsub|o>
  </equation*>

  <\equation*>
    W<rsub|con<rprime|'>><around*|(|a,b|)>=O<around*|(|a\<times\>b|)>
  </equation*>

  work of convolve is convolve' with chop, chop is <math|O<around*|(|a+b|)>>
  so in sum

  <math|W<rsub|con>=O<around*|(|a*b|)>>

  <subsection|sparse>

  a,b is length of list

  \;

  <\math>
    W<rsub|con><around*|(|a,b|)>=W<rsub|add><around*|(|b|)>+W<rsub|scale><around*|(|b|)>+W<rsub|map><around*|(|b|)>+W<rsub|con><around*|(|a-1,b|)>

    W<rsub|con><around*|(|0,b|)>=W<rsub|chop><around*|(|a+b|)>+k<rsub|o>

    W<rsub|con><around*|(|a,b|)>=O<around*|(|a*b|)>
  </math>

  <subsection|fun>

  add and scale are <math|O<around*|(|k|)>>

  <\math>
    W<rsub|con><around*|(|a,b|)>=W<rsub|add><around*|(|b|)>+W<rsub|scale><around*|(|b|)>+W<rsub|con><around*|(|a-1,b|)>

    W<rsub|con><around*|(|0,b|)>=k<rsub|o>

    W<rsub|con><around*|(|a,b|)>=O<around*|(|a*|)>
  </math>

  \;

  <section|work of mult>

  for the function here because reduce combine and map are all for list, and
  not for infvec, so i have to keep calling toList and toVec, which consumes
  a lot, in the computation , i will assume using the infvec version of map
  reduce and combine.

  <\equation*>
    W<rsub|vProd><around*|(|<around*|(|a,c|)>,n|)>=min<around*|(|a,n|)>\<times\>W<rsub|vec.scale><around*|(|c|)>\<times\>min<around*|(|a,n|)>\<times\>W<rsub|vec.add><around*|(|c|)>=<choice|<tformat|<table|<row|<cell|O<around*|{|a*c*n|}>>|<cell|listVec>>|<row|<cell|O<around*|(|a*n|)>>|<cell|funVec>>>>>
  </equation*>

  \;

  the first min (a,n) is for combineS, then each elem apply scale, secon min
  for reduce each elems apply add.

  \;

  <\equation*>
    W<rsub|mult><around*|(|<around*|(|a,b|)>,<around*|(|c,d|)>|)>=c\<times\>W<rsub|vprod><around*|(|<around*|(|a,b|)>,d|)>=<choice|<tformat|<table|<row|<cell|O<around*|(|a*c<rsup|2>
    n|)>>|<cell|listvec>>|<row|<cell|O<around*|{|a*c*n|}>>|<cell|funvec>>>>>
  </equation*>

  \;

  \;
</body>

<initial|<\collection>
</collection>>

<\references>
  <\collection>
    <associate|auto-1|<tuple|1|?|../../.TeXmacs/texts/scratch/no_name_17.tm>>
    <associate|auto-2|<tuple|1.1|?|../../.TeXmacs/texts/scratch/no_name_17.tm>>
    <associate|auto-3|<tuple|1.2|?|../../.TeXmacs/texts/scratch/no_name_17.tm>>
    <associate|auto-4|<tuple|1.3|?|../../.TeXmacs/texts/scratch/no_name_17.tm>>
    <associate|auto-5|<tuple|2|?|../../.TeXmacs/texts/scratch/no_name_17.tm>>
  </collection>
</references>

<\auxiliary>
  <\collection>
    <\associate|toc>
      <vspace*|1fn><with|font-series|<quote|bold>|math-font-series|<quote|bold>|1<space|2spc>work
      of convolve> <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-1><vspace|0.5fn>

      <with|par-left|<quote|1tab>|1.1<space|2spc>list
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-2>>

      <with|par-left|<quote|1tab>|1.2<space|2spc>sparse
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-3>>

      <with|par-left|<quote|1tab>|1.3<space|2spc>fun
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-4>>

      <vspace*|1fn><with|font-series|<quote|bold>|math-font-series|<quote|bold>|2<space|2spc>work
      of mult> <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-5><vspace|0.5fn>
    </associate>
  </collection>
</auxiliary>