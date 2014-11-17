# print bin(0x38)
# a= 0b11111111
# b=a<<3
# a=(a<<6)
# print bin(b)
# print bin(a)


a = 0x80000000

a = a | a>>16;
a = a | a>>8;
a = a | a>>4;
a = a | a>>2;
a = a| a>>1;
a = a&1
print hex(a)

a= 0xf
print bin(a)
print bin(a>>3)


print ~-6

