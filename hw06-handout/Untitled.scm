hw06zihan zhou
work of convolve
list
a,b is length of list
W_(con')(a,b)=W_add(b)+W_scale(b)+W_(con')(a-1,b)+c_0
W_(con')(0,b)=k_o
trivial to show work of add and scale are O(n).
W_(con')(a,b)=k*b+W(a-1,b)+c_o
W_(con')(a,b)=O(a×b)
work of convolve is convolve' with chop, chop is O(a+b) so in sum
W_con=O(a*b)
sparse
a,b is length of list

W_con(a,b)=W_add(b)+W_scale(b)+W_map(b)+W_con(a-1,b)
W_con(0,b)=W_chop(a+b)+k_o
W_con(a,b)=O(a*b)
fun
add and scale are O(k)
W_con(a,b)=W_add(b)+W_scale(b)+W_con(a-1,b)
W_con(0,b)=k_o
W_con(a,b)=O(a*)

work of mult
for the function here because reduce combine and map are all for list, and not for infvec, so i have to keep calling toList and toVec, which consumes a lot, in the computation , i will assume using the infvec version of map reduce and combine.
W_vProd((a,c),n)=min(a,n)×W_(vec.scale)(c)×min(a,n)×W_(vec.add)(c)=
O{a*c*n} listVec
O(a*n)   funVec


the first min (a,n) is for combineS, then each elem apply scale, secon min for reduce each elems apply add.

W_mult((a,b),(c,d))=c×W_vprod((a,b),d)=
O(a*c^2 n) listvec
O{a*c*n}   funvec


