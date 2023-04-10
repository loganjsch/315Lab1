# Demo Program
# 
#   CPE 315

# declare global so programmer can see actual addresses.
.globl welcome
.globl promptHigh
.globl promptLow
.globl promptDivisor
.globl quotientHighText
.globl quotientLowText

#  Data Area (this area contains strings to be displayed during the program)
.data

welcome:
	.asciiz "This divides a 64-bit unsigned number with a 31-bit unsigned number. \n\n"

promptHigh:
	.asciiz "Enter the dividend higher 32 bits: "

promptLow:
	.asciiz "Enter the dividend lower 32 bits: "

promptDivisor:
	.asciiz "Enter the divisor: "

quotientHighText: 
	.asciiz " \n Quotient higher 32 bits = "

quotientLowText: 
	.asciiz " \nQuotient lower 32 bits = "

#Text Area (i.e. instructions)
.text

main:

	# Display the welcome message (load 4 into $v0 to display)
	ori     $v0, $0, 4			
	# This generates the starting address for the welcome message.
	# (assumes the register first contains 0).
	lui     $a0, 0x1001
	syscall


    # Display promptHigh
	ori     $v0, $0, 4			
	# This is the starting address of the prompt (notice the
	# different address from the welcome message)
	lui     $a0, 0x1001
	ori     $a0, $a0, 0x48
	syscall
	# Read 1st integer from the user (5 is loaded into $v0, then a syscall)
	ori     $v0, $0, 5
	syscall
	# Clear $s0 for promptHigh
	ori     $s0, $0, 0	
	# Add high end dividend to $s0
	addu    $s0, $v0, $s0


    # Display promptLow
	ori     $v0, $0, 4			
	# This is the starting address of the prompt (notice the
	# different address from the welcome message)
	lui     $a0, 0x1001
	ori     $a0, $a0, 0x6C
	syscall
	# Read 1st integer from the user (5 is loaded into $v0, then a syscall)
	ori     $v0, $0, 5
	syscall
	# Clear $s1 for low end 
	ori     $s1, $s1, 0	
	# Add high end dividend to $s0
	addu    $s1, $v0, $s1


    # Display promptDivisor
	ori     $v0, $0, 4			
	# This is the starting address of the prompt (notice the
	# different address from the welcome message)
	lui     $a0, 0x1001
	ori     $a0, $a0, 0x8F
	syscall
	# Read 1st integer from the user (5 is loaded into $v0, then a syscall)
	ori     $v0, $0, 5
	syscall
	# Clear $s2 for divisor
	ori     $s2, $s2, 0	
	# Add high end dividend to $s0
	addu    $s2, $v0, $s2

    # dividend = (upperBits << 32) | lowerBits;
    sll     $t0, $s0, 31
    or      $s3, $t0, $s1 

    # power = 0 = $t0
    addi $t0, $0, 0
    addi $t1, $0, 1

# this while loop gives the number of tiems to loop through to divide
while:
	# if divisor = 1,  end loop
	beq $s2, $t1, endwhile
    # divisor /= 2
    srl $s2, $s2, 1
    # power += 1;
    addi $t0, $t0, 1
    j while

endwhile:

    # sets i = 0 = t3
    addi $t3, $0, 0

for:
    # set t4 if i < power
	seq $t4, $t3, $t0
	# if i > power 
	bne $t4, $0, endfor

    srl $s1, $s1, 1

if: # if 0 bit upper = 1
    li $t5, 0x0001
    and $t6, $s0, $t5
    beq $s2, $0, not_set
    j set

    not_set: 

        j ifend
    
    set:
        
        li $t7, 0x80000000
        or $s1, $s1, $t7
        j ifend

ifend:
    
    srl $s0, $s0, 1
    # i ++
    addi $t3, $t3, 1
    j for


endfor:

    # quotient = $s3 and clear it 
    #addi $s4, $0, 0
    # quotient = dividend >>> power
    #srl $s5, $s0, $t0
    # quotient = dividend >>> power
    #srl $s6, $s1, $t0

    #srl $s5, $s4, 31
    #and $s6, $s4, 0xFFFFFFFF


    # Display the quotienthigh text
	# 0x22 is hexidecimal for 34 decimal (the length of the previous welcome message)
	ori     $v0, $0, 4			
	lui     $a0, 0x1001
	ori     $a0, $a0,0xA6
	syscall
	# Display the upperquotient
	# load 1 into $v0 to display an integer
	ori     $v0, $0, 1			
	add 	$a0, $s0, $0
	syscall


    # Display the quotientlow text
	# 0x22 is hexidecimal for 34 decimal (the length of the previous welcome message)
	ori     $v0, $0, 4			
	lui     $a0, 0x1001
	ori     $a0, $a0, 0xC2
	syscall
	# Display the lwoer quotient
	# load 1 into $v0 to display an integer
	ori     $v0, $0, 1			
	add 	$a0, $s1, $0
	syscall

	
	# Exit (load 10 into $v0)
	ori     $v0, $0, 10
	syscall










