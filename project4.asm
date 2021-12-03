.data
	string1: .asciiz "Input 1st integer A: "
	string2: .asciiz "Input 2nd integer B: "
	string3: .asciiz "Input 3rd integer C: "
	string4: .asciiz "Input 4th integer D: "
	string5: .asciiz "F = "
	string6: .asciiz "G = "
  	stringBlank: .asciiz "\n" 
 	fpnum1: .float 0.1
	fpnum2: .float 0.2
	fpnum3: .float 0.3
	fpnum4: .float 0.4
	zero:   .float 0.0
  	
.text
	li $v0, 4 # Integer A input
	la $a0, string1 
	syscall 
	
	li $v0, 5 # 1st input storing
	syscall 
	move $t4, $v0 # for use in function F
	move $t1, $t4 # for use in function G
	
	# calling a^4
	move $s0, $t4 # correct power result for A
	move $s1, $t4 # iteration \
	move $s2, $zero # reset
	addi $s2, $s2, 1 # sets the second loop's iterator
	move $t8, $zero # reset
	addi $t8, $t8, 1 # setting the iterator
	move $t9, $zero # reset
	addi $t9, $t9, 4
	jal loopT0 # running exponent looper
	move $s4, $s3 # setting $s4 to what a^4 was
	
	# calculating a^4's value in function f
	l.s $f0, fpnum1 # loads in our floating point number
	move $t0, $s4 # sets the parameter to a^4
	l.s $f1, zero # reset
	jal multiFP # calls the Floating point multiplication procedure
	mov.s $f2, $f1 # sets $f2 = 0.1 x a^4
	
	li $v0, 4 # Integer B input
	la $a0, string2
	syscall
	
	li $v0, 5 # second input storing
	syscall
	move $t4, $v0 # for use in function F
	move $t2, $t4 # for use in function G
	
	# calling b^3
	move $s0, $t4 # correct power result for B
	move $s1, $t4 # iteration \
	move $s2, $zero # reset
	addi $s2, $s2, 1 # sets the second loop's iterator
	move $t8, $zero # reset
	addi $t8, $t8, 1 # setting the iterator
	move $t9, $zero # reset
	addi $t9, $t9, 3 # exponent
	jal loopT0 # running exponent looper
	move $s5, $s3 # setting $s4 to what b^3 was 
	
	# calculating b^3's value in function f
	l.s $f0, fpnum2 # loads in our floating point number
	move $t0, $s5 # sets the parameter to b^3
	l.s $f1, zero # reset
	jal multiFP # calls the Floating point multiplication procedure
	mov.s $f3, $f1 # sets $f3 = 0.2 x b^3
	
	li $v0, 4 # Integer C input
	la $a0, string3
	syscall
	
	li $v0, 5 # third input storing
	syscall
	move $t4, $v0 # for use in function F
	
	# calling c^2
	move $s0, $t4 # correct power result for C
	move $s1, $t4 # iteration \
	move $s2, $zero # reset
	addi $s2, $s2, 1 # sets the second loop's iterator
	move $t8, $zero # reset
	addi $t8, $t8, 1 # setting the iterator
	move $t9, $zero # reset
	addi $t9, $t9, 2 # exponent
	jal loopT0 # running exponent looper
	move $s6, $s3 # setting $s4 to what c^2 was
	
	# calculating c^2's value in function f
	l.s $f0, fpnum3 # loads in our floating point number
	move $t0, $s6 # sets the parameter to c^2
	l.s $f1, zero # reset
	jal multiFP # calls the Floating point multiplication procedure
	mov.s $f4, $f1 # sets $f4 = 0.3 x c^2
	
	li $v0, 4 # integer D input 
	la $a0, string4
	syscall
	
	li $v0, 5 # fourth input storing
	syscall
	move $s7, $v0 # for use in function F
	move $t3, $s7 # for use in function G 
	
	# calculating d's value in function f
	l.s $f0, fpnum4 # loads in our floating point number
	move $t0, $s7 # sets the parameter to d
	l.s $f1, zero # reset
	jal multiFP # calls the Floating point multiplication procedure
	mov.s $f5, $f1 # sets $f5 = 0.4 x d
	
	
	# setting up values for function G
	# $t1 = A
	# $t2 = B
	# $s6 = C
	# $t3 = D
	
	# finding B^2
	move $t4, $t2 # initializing
	move $s0, $t4 # correct power result for C
	move $s1, $t4 # iteration \
	move $s2, $zero # reset
	addi $s2, $s2, 1 # sets the second loop's iterator
	move $t8, $zero # reset
	addi $t8, $t8, 1 # setting the iterator
	move $t9, $zero # reset
	addi $t9, $t9, 2 # exponent
	jal loopT0 # running exponent looper
	move $t2, $s3 
	
	# finding D^3
	move $t4, $t3 # initializing
	move $s0, $t4 # correct power result for C
	move $s1, $t4 # iteration \
	move $s2, $zero # reset
	addi $s2, $s2, 1 # sets the second loop's iterator
	move $t8, $zero # reset
	addi $t8, $t8, 1 # setting the iterator
	move $t9, $zero # reset
	addi $t9, $t9, 3 # exponent
	jal loopT0 # running exponent looper
	move $t3, $s3 
	
	# multiplying A x B^2
	move $t0, $t1 # move in A
	move $s3, $t2 # move in B^2
	jal multiNorm # call normal multiplication
	
	# multiplying 0.1 by A x B^2
	l.s $f0, fpnum1 # loads in our floating point number 0.1
	move $t0, $t7 # sets the parameter to AxB
	l.s $f1, zero # reset
	jal multiFP # call floating point multiplication
	mov.s $f6, $f1 # set $f6 = (0.1) x (A x B^2)
	
	# multiplying C^2 x D^3
	move $t0, $s6 # move in c^2
	move $s3, $t3 # move in d^3
	move $t7, $zero # reset
	jal multiNorm # call normal multiplication
	
	# multiplying 0.2 by C^2 x D^3
	l.s $f0, fpnum2 # loads in our floating point number 0.2
	move $t0, $t7 # sets the parameter to C^2 x D^3
	l.s $f1, zero # reset
	jal multiFP # call floating point multiplication
	mov.s $f7, $f1 # set $f7 = (0.2) x (C^2 x D^3)
	
	j testPrint

loopT0: 
	move $s3, $s0 
	beq  $t8, $t9, loopCheckpoint1 # start of the expo function
	addi $t8, $t8, 1 # loops through multiplying the value by itself once until the exponent is done
	move $s1, $s0 # increases my iterator so it will match the needed value to get the right power
	move $s2, $zero # reset
	addi $s2, $s2, 1 # iterates the I loop
	j MultiT4
	
# multiples a value A by A B number of times
MultiT4: 
	beq $s2, $t4, loopT0 
	add $s0, $s0, $s1 # multiplies the variable A 
	addi $s2, $s2, 1 # iterates the J loop
	j MultiT4

# resets the exponent loop's 
loopCheckpoint1:
	ble  $t8, 1, end 
	move $s0, $t5
	move $s1, $t5
	subi $t8, $t8, 1
	move $s2, $zero
	j loopCheckpoint1
# returns	
end:
	jr $ra 

# multiples a floating point number by a whole integer
multiFP:
	ble $t0, 0, end2 # checks if the int has hit 0 
	add.s $f1, $f1, $f0 # adds the floating point number by itself
	subi $t0, $t0, 1 # iterates
	j multiFP # recursion

# returns 	
end2: 
	jr $ra

# multiplies 2 integers
multiNorm: 
	ble $t0, 0, end3 # checks if value A is <= 0
	add $t7, $t7, $s3 # adds the integer B by itself
	subi $t0, $t0, 1 # iterates so long as there is an A value
	j multiNorm # recursion
	
# returns
end3: 
	jr $ra

# runs the functions F and G
runFunc:
	# function F
	sub.s $f10, $f2, $f3 # f = (0.1 x a^4) - (0.2 x b^3)
	add.s $f10, $f10, $f4 # f = f + (0.3 x c^2)
	sub.s $f10, $f10, $f5 # f = f - (0.4 x d)
	
	# function G
	add.s $f11, $f6, $f7 # g = (0.1 x AB^2) + (0.2xC^2D^3)
	
	jr $ra # returns

# prints out the answers 
testPrint:
	 jal runFunc # calls the function procedure
	 
	 li $v0, 4 # F = string printer
	 la $a0, string5 
	 syscall 
	 
	 li $v0, 2 # prints the result of the F function
	 mov.s $f12, $f10
	 syscall
	 
	 li $v0, 4 # printing blank
	 la $a0, stringBlank
	 syscall
	 
	 li $v0, 4 # G = string Printer
	 la $a0, string6 
	 syscall 
	
	 li $v0, 2 # Prints the result of the G function
	 mov.s $f12, $f11
	 syscall
	 
	 li $v0, 10
      	 syscall
