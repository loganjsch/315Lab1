# Garrett Green
# mod.asm 
# CPE 315


# declare global so programmer can see actual addresses.
.globl welcome
.globl prompt
.globl sumText

#  Data Area (this area contains strings to be displayed during the program)
.data

welcome:
	.asciiz " This program returns the remainder of a given number & divisor \n\n"

prompt:
	.asciiz " Enter an integer: "
    
sumText: 
	.asciiz " \n remainder = "

#Text Area (i.e. instructions)
.text

main:

	# Display the welcome message (load 4 into $v0 to display)
	ori     $v0, $0, 4			

	# This generates the starting address for the welcome message.
	# (assumes the register first contains 0).
	lui     $a0, 0x1001
	syscall

	# Display prompt
	ori     $v0, $0, 4			
	
	# This is the starting address of the prompt (notice the
	# different address from the welcome message)
	lui     $a0, 0x1001
	ori     $a0, $a0,0x22
	syscall

    # Read 1st integer from the user (numerator)
	ori     $v0, $0, 5
	syscall

    # Put numerator into s0
    addi $s0, $v0, 0

    # Display prompt (4 is loaded into $v0 to display)
	# 0x22 is hexidecimal for 34 decimal (the length of the previous welcome message)
	ori     $v0, $0, 4			
	lui     $a0, 0x1001
	ori     $a0, $a0,0x22
	syscall

    # Read 2nd integer (denominator)
	ori	$v0, $0, 5			
	syscall
	# $v0 now has the value of the second integer

    addi $s1, $v0, 0

loop:
    sub $s2, $s0, $s1
    blt $s2, $s1, final
    addi $s0, $s2, 0
    j loop
    
final:
#display text
    ori     $v0, $0, 4			
	lui     $a0, 0x1001
	ori     $a0, $a0,0x36
	syscall

    ori $v0, $0, 1 
    add $a0, $s2, $0
    syscall

    ori $v0, $0, 10
    syscall
