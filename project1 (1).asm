    .data
	string1: .asciiz "Input 1st integer A: "
	string2: .asciiz "Input 2nd integer B: "
	string3: .asciiz "Input 3rd integer C: "
	string4: .asciiz "Input 4th integer D: "
  	stringBlank: .asciiz "\n" 
  	string5: .asciiz "The quotient is: "
  	string6: .asciiz "The remainder is: "
  	
.text
	li $v0, 4 # Integer A input
	la $a0, string1 
	syscall 
	
	li $v0, 5 # 1st input storing
	syscall 
	move $t4, $v0 
	
	li $v0, 4 # Integer B input
	la $a0, string2
	syscall
	
	li $v0, 5 # second input storing
	syscall
	move $t5, $v0
	
	li $v0, 4 # Integer C input
	la $a0, string3
	syscall
	
	li $v0, 5 # third input storing
	syscall
	move $t6, $v0 
	
	li $v0, 4 # integer D input 
	la $a0, string4
	syscall
	
	li $v0, 5 # fourth input storing
	syscall
	move $t7, $v0 
	
	addi $t0, $zero, 3 # storing carolina card digits into temporary values to be used for the expo function 
	addi $t1, $zero, 5
	addi $t2, $zero, 3
	addi $t3, $zero, 4
	addi $t8, $t8, 1 # setting the iterator
	
	move $s0, $t4 # correct power result for A
	move $s1, $t4 # iteration \
	addi $s2, $s2, 1 # sets the second loop's iterator
	  
loopT0: 
	move $s3, $s0
	beq  $t8, $t0, loopCheckpoint1 # start of the expo function for A
	addi $t8, $t8, 1 # loops through multiplying the value by itself once until the exponent is done
	move $s1, $s0 # increases my iterator so it will match the needed value to get the right power
	move $s2, $zero
	addi $s2, $s2, 1
	j MultiT4

MultiT4: 
	beq $s2, $t4, loopT0 
	add $s0, $s0, $s1 # multiplies the variable A 
	addi $s2, $s2, 1
	j MultiT4

loopCheckpoint1:
	ble  $t8, 1, loopT1
	move $s0, $t5
	move $s1, $t5
	subi $t8, $t8, 1
	move $s2, $zero
	j loopCheckpoint1

loopT1: 
	move $s4, $s0
	beq  $t8, $t1, loopCheckpoint2 # start of the expo function for A
	addi $t8, $t8, 1 # loops through multiplying the value by itself once until the exponent is done
	move $s1, $s0 # increases my iterator so it will match the needed value to get the right power
	move $s2, $zero
	addi $s2, $s2, 1
	j MultiT5

MultiT5: 
	beq $s2, $t5, loopT1
	add $s0, $s0, $s1 # multiplies the variable A 
	addi $s2, $s2, 1
	j MultiT5
	
loopCheckpoint2:
	ble  $t8, 1, loopT2
	move $s0, $t6
	move $s1, $t5
	subi $t8, $t8, 1
	move $s2, $zero
	j loopCheckpoint2
	
loopT2: 
	move $s5, $s0
	beq  $t8, $t2, loopCheckpoint3 # start of the expo function for A
	addi $t8, $t8, 1 # loops through multiplying the value by itself once until the exponent is done
	move $s1, $s0 # increases my iterator so it will match the needed value to get the right power
	move $s2, $zero
	addi $s2, $s2, 1
	j MultiT6

MultiT6: 
	beq $s2, $t6, loopT2
	add $s0, $s0, $s1 # multiplies the variable A 
	addi $s2, $s2, 1
	j MultiT6
	
loopCheckpoint3:
	ble  $t8, 1, loopT3
	move $s0, $t7
	move $s1, $t5
	subi $t8, $t8, 1
	move $s2, $zero
	j loopCheckpoint3
	
loopT3: 
	move $s6, $s0
	beq  $t8, $t3, loopCheckpoint4 # start of the expo function for A
	addi $t8, $t8, 1 # loops through multiplying the value by itself once until the exponent is done
	move $s1, $s0 # increases my iterator so it will match the needed value to get the right power
	move $s2, $zero
	addi $s2, $s2, 1
	j MultiT7

MultiT7: 
	beq $s2, $t7, loopT3
	add $s0, $s0, $s1 # multiplies the variable A 
	addi $s2, $s2, 1
	j MultiT7
	
loopCheckpoint4:
	ble  $t8, 1, endExpoLoops
	subi $t8, $t8, 1
	j loopCheckpoint4
	
endExpoLoops:
	
	move $t8, $zero
	move $t9, $zero
	
	add $t8, $s3, $s4
	add $t9, $s5, $s6
	
	li $v0, 1 # printing results A
	la $a0, ($t8)
	syscall
	
	li $v0, 4 # printing blank
	la $a0, stringBlank
	syscall
	
	li $v0, 35 # printing binary A
	la $a0, ($t8)
	syscall
	
	li $v0, 4 # printing blank
	la $a0, stringBlank
	syscall
	
	li $v0, 1 # printing results B
	la $a0, ($t9)
	syscall
	
	li $v0, 4 # printing blank
	la $a0, stringBlank
	syscall
	
	li $v0, 35 # printing binary B
	la $a0, ($t9)
	syscall
	
	j divisonBuild
	
divisonBuild:
	move $t0, $zero # x
	move $t1, $zero # y
	move $t2, $zero # q
	move $t3, $zero # r
	
	addi $t0, $t0, 13 # the x variable
	addi $t1, $t1, 5 # the y variable 
	
	li $v0, 4 # printing blank
	la $a0, stringBlank
	syscall
	
	li $v0, 1 # printing X variable
	la $a0, ($t0)
	syscall
	
	li $v0, 4 # printing blank
	la $a0, stringBlank
	syscall
	
	j throw

throw: 
	bge $t0, $t1, while
	ble  $t0, $t1, setter
	
while:  sub $t0, $t0, $t1
	addi $t2, $t2, 1
	j throw 
	
setter:
	add $t3, $t0, $zero
	j printer
	
printer:
	li $v0, 1 # printing y variable
	la $a0, ($t1)
	syscall
	
	li $v0, 4 # printing blank
	la $a0, stringBlank
	syscall
	
	li $v0, 4 # printing blank
	la $a0, string5
	syscall
	
	li $v0, 1 # printing q variable
	la $a0, ($t2)
	syscall
	
	li $v0, 4 # printing blank
	la $a0, stringBlank
	syscall
	
	li $v0, 4 # printing blank
	la $a0, string6
	syscall
	
	li $v0, 1 # printing r variable
	la $a0, ($t3)
	syscall
	
	
	
	
	
	
	
	
	
