# Laboratory Exercise 7 Home Assignment 1
.text
main:
li a0, -20 # load input parameter
jal abs # jump and link to abs procedure
li a7, 10 # terminate
ecall
end_main:
abs:
sub s0, zero, a0 # put -a0 in s0; in case a0 < 0
blt a0, zero, done # if a0<0 then done
add s0, a0, zero # else put a0 in s0
done:
jr ra
