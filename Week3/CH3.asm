f =s0
g=s1
h=s2
i=s3
j=s4
slli s2, s4, 1 #h = j * 2^1 ( dich trai 1 bit ) h = j*2 
add s0, s2, s3 # f = h + i
add s0, s0, s1 # f = f + g


slli t0, s0, 2 #t0 = f * (2^2) 
add t0, s6, t0 # t0 = A + t0= A + f*4
lw t3, 0(t0)#t3 = A[f]
lw t4, 4(t0)#t4 = A[f+1] 
add t5, t3, t4 # t5 = t3 + t4
slli t1, s1, 2 #t1= g*(2^2)=g*4
add t1, s7, t1 #t1= B+ t1 = B + 4*g
sw t5, 0(t1)# B[g]=t5