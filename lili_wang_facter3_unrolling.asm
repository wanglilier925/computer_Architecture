# c） unrolling with a factor of 3
.data 
A: .float 2.0,1.9,3.7,0.6,2.2,0.4,0.2,2.6,2.1,0.9,2.6,2.7,3.7,0.8,0.1,4.2,0.5,2.6,3.1,1.1,0.4,2.6,2.6,2.1,1.7,0.3,2.0,0.7,0.7,2.1,1.6,3.0,0.1,1.8,2.3,2.4,1.0,1.8,5.3,2.7,1.0,2.3,1.6,2.1,1.0,0.5,1.0,2.2,0.7,1.0,0.2,2.7,1.7,2.5,0.7,0.4,1.3,0.3,1.7,0.2
B: .float 0.5,2.9,1.7,0.3,3.0,1.7,0.1,1.5,0.6,10.9,3.0,1.3,3.0,2.4,0.9,0.4,2.0,1.7,0.5,0.3,0.6,2.8,3.0,3.1,4.2,1.7,2.9,0.5,13.1,1.9,1.3,1.1,0.8,2.7,2.4,1.4,0.3,1.5,2.5,0.8,0.9,1.9,2.8,0.1,2.7,2.8,3.0,1.6,3.0,1.2,1.6,2.6,2.1,2.6,2.0,0.1,1.0,2.3,0.3,2.4
zero: .float 0
n:.word 60  # the length of the vectors 

.text 
la $t0, A   #load  A to $t0
la $t1, B   #load  B to $t1
la $t2, n   #load  n to $t2
lw $s0, 0($t2)  

#inside code

#############
# initialize accumulator
	
l.s   $f7, zero
	
loop:
 	
 	
	l.s       $f10, 0($t0)     	 # loading A[i] to $f10
	l.s       $f12, 0($t1)      	 # loading B[i] to $f12
	l.s       $f8,  4($t0)     	 # loading A[i-1] to $f8
	l.s       $f14, 4($t1)      	 # loading B[i-1] to $f14
	l.s       $f6,  8($t0)     	 # loading A[i-2] to $f6
	l.s       $f16, 8($t1)      	 # loading B[i-2] to $f16
	
	mul.s     $f10, $f10, $f12    	 # calculate a[i]*b[i] -->f10
	add.s     $f7, $f7, $f10    	 # sum = sum + f10	
	mul.s     $f9, $f8, $f14    	 # calculate a[i-1]*b[i-1] -->f9	
	add.s     $f7, $f7, $f9    	 # sum = sum + f9
	mul.s     $f6, $f6, $f16    	 # calculate a[i-2]*b[i-2] -->f6
	add.s     $f7, $f7, $f6    	 # sum = sum + f6			
   	addi      $t0, $t0, 12       	 # increment pointer for A[i-3]
        addi      $t1, $t1, 12        	 # increment pointer for B[i-3]
        addi      $s0, $s0, -3		 # i=i-3
test:

        bgtz       $s0, loop	 # branch:  continue if i>0
        
#############close loop
li     $v0, 2           # print a float
mov.s   $f12, $f7         # print the final result in $f12
syscall          
