.data 
A: .word 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11,12,13,14,15,16 # The first vector A
B: .word 17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32 # The second vector B
n: .word 16  # The length of the vectors

.text
la $t0, A   #load A to $t0
la $t1, B   #load A to $t1
la $t2, n   #load n to $t2
lw $t2, 0($t2)

# inside code
li $t3, 1 # index of the loop
li $s7, 0 # store the result
loop: 
 lw $s0, 0($t0) # loading A[i] value
 lw $s1, 0($t1) # loading B[i] value
 addi $t0, $t0, 4 # move the value to A's next index 
 addi $t1, $t1, 4 # # move the value to B's next index
 mult $s0, $s1 # calculate A[i] X B[i]
 mflo $t5 # move the result of a multiplication into a general purpose register
 add $s7, $s7, $t5 # retult  = retult + A[i]*B[i]
 addi $t3, $t3, 1 # i++
 ble $t3, $t2, loop # for loop if i>length(), branch out of the loop

# print out result
li $v0, 1           
add $a0, $s7, 0      
syscall            