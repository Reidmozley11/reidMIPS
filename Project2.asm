.data
	string1: .asciiz "The South Carolina Gamecocks football program represents the University of South Carolina in the sport of American football. The Gamecocks compete in the Football Bowl Subdivision of the National Collegiate Athletic Association (NCAA) and the Eastern Division of the Southeastern Conference. Will Muschamp currently serves as the team's head coach. They play their home games at Williams-Brice Stadium. Currently, it is the 20th largest stadium in college football."
	input1: .asciiz "Please input the first word you would like to search for: "
	input2: .asciiz "Please input the first word you would like to search for: "
	userInput1: .space 50
	userInput2: .space 50

.text
	main:
  		la $a0, string1 # loads the address of our hard coded string
        	jal stringLength 
        	move $s0, $t0 # sets the length of the hardcoded string to $s0
        	subi $s0, $s0, 1 # fixes the offset 
        
        	# prints input1
        	li $v0, 4
		la $a0, input1
		syscall
		
		# gets user input and stores it in the array userInput1
		li $v0, 8
		la $a0, userInput1
		li $a1, 50 
		syscall 
		
		la $a0, userInput1
		jal stringLength
		move $s1, $t0 # stores the length of the users input in $s1
		subi $s1, $s1, 1 # fixes the offset 
	
		# prints input2
		li $v0, 4
		la $a0, input2
		syscall
	
		# gets user input and stores it in the array userInput2
		li $v0, 8
		la $a0, userInput2
		li $a1, 50 
		syscall 
		
		la $a0, userInput2
		jal stringLength
		move $s2, $t0 # stores the length of the users input in $s2
		subi $s2, $s2, 1 # fixes the offset 
		
		# prints userInput 1
			#li $v0, 4
			#la $a0, userInput1
			#syscall
		
		# prints userInput 2
			#li $v0, 4
			#la $a0, userInput2
			#syscall
		
		# prints the length of the hardcoded string
			#li $v0, 1
			#move $a0, $s0
			#syscall 
		# prints the length of the users first input
			#li $v0, 1
			#move $a0, $s1
			#syscall
		#prints the length of the users second input
			#li $v0, 1
			#move $a0, $s2
			#syscall
		
		jal strfind1
        
        	addi $a1, $a0, 0        # Move address of string to $a1
        	addi $v1, $v0, 0        # Move length of string to $v1
        	addi $v0, $0, 11        # System call code for message.
        
        	addi $v0, $0, 10        # System call code for exit.
        	syscall


	stringLength:
		li $t0, 0 # initialize the count to zero
	loop:
		lb $t1, 0($a0) # load the next character into t1
		beq $t1, $zero, exit # check for the null character
		addi $a0, $a0, 1 # move through the string
		addi $t0, $t0, 1 # increase the variable for length 
		j loop # keep looping
	exit:
		jr $ra
	

	strfind1: 
		move $t4, $zero # iterator i
		move $t5, $zero # iterator j 
		
		move $t2, $s1 # t1 is now the temp value for users first input length
		sub $t3, $s0, $s1
		addi $t3, $t2, 1 # t2 is now the variable for the end of the search
		
		j nestLoop 
	bigLoop: 
		 bge $t4, $t3, exit2
		 addi $t4, $t4, 1 
		 move $t5, $zero # resets iterator j 
		 j nestLoop 
	
	nestLoop: 
		bge $t5, $t2, bigLoop
	
	exit2:
		jr $ra
		
		
	
		
		
	