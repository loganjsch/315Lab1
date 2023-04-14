# Logan Schwarz Garret Green
# section
#   Asks user for two inputs x and y, and computes and returns x ^ y.

#import java.util.Scanner;

#public class exponent {

#    public static void main(String[] args) {
#        Scanner input = new Scanner(System.in);
#        System.out.print("Enter first integer");
#        int x = input.nextInt();
#        System.out.print("Enter second integer");
#        int y = input.nextInt();
#        input.close();

#        int answer = x;
#        int increment = x;

#        for (int i = 1; i < y; i++){
#            for (int j = 1; j < x; j++) {
#               answer += increment;
#            }
#            increment = answer;
#        }
#       System.out.println(answer);
# 	  }
#}

# declare global so programmer can see actual addresses.
.globl welcome
.globl promptx
.globl prompty
.globl expText

#  Data Area (this area contains strings to be displayed during the program)
.data

welcome:
	.asciiz "This program exponentiates two numbers \n\n"

promptx:
	.asciiz " Enter first integer: "

prompty:
    .asciiz " Enter second integer: "

expText: 
	.asciiz " \n Exponentiation = "


.text

main:



	# Display the welcome message (load 4 into $v0 to display)
	ori     $v0, $0, 4			

	# This generates the starting address for the welcome message.
	# (assumes the register first contains 0).
	lui     $a0, 0x1001
	syscall




	# Display promptx
	ori     $v0, $0, 4			
	
	# This is the starting address of the prompt (notice the
	# different address from the welcome message)
	lui     $a0, 0x1001
	ori     $a0, $a0, 0x2B
	syscall

	# Read 1st integer from the user (5 is loaded into $v0, then a syscall)
	ori     $v0, $0, 5
	syscall

	# Clear $s0 for x
	ori     $s0, $0, 0	

	# Add 1st integer to x 
	# (could have put 1st integer into $s0 and skipped clearing it above)
	addu    $s0, $v0, $s0




	# Display prompty
	ori     $v0, $0, 4			
	
	# This is the starting address of the prompt (notice the
	# different address from the welcome message)
	lui     $a0, 0x1001
	ori     $a0, $a0, 0x42
	syscall

	# Read 1st integer from the user (5 is loaded into $v0, then a syscall)
	ori     $v0, $0, 5
	syscall

	# Clear $s1 for y
	ori     $s1, $0, 0	

	# Add 2nd integer to y 
	# (could have put 1st integer into $s0 and skipped clearing it above)
	addu    $s1, $v0, $s1

	# Loop preparations:
	# answer = x 
	add $a2, $s0, $0
	# increment = x 
	add $a1, $s0, $0
	# clear $t0 = i
	ori     $t0, $0, 0	
	# i = 1
	addi $t0, $t0, 1



for1:

	# set t2 if  i < y
	slt $t2, $t0, $s1
	# if i > y, (t2 = 0) end loop
	beq $t2, $0, endfor1

	# clear j = $t1
	ori $t1, $0, 0
	# j = 1
	addi $t1, $t1, 1

	for2:

		#set t3 if j < x
		slt $t3, $t1, $s0
		beq $t3, $0, endfor2

		# answer += increment
		add $a2, $a2, $a1

		#j++
		addi $t1, $t1, 1

		j for2

	endfor2:

	# increment = answer
	add $a1, $a2, $0

	#i++
	addi $t0, $t0, 1

	j for1

endfor1:


	# Display the exponentiation text
	# 0x22 is hexidecimal for 34 decimal (the length of the previous welcome message)
	ori     $v0, $0, 4			
	lui     $a0, 0x1001
	ori     $a0, $a0,0x5C
	syscall
	
	# Display the sum
	# load 1 into $v0 to display an integer
	ori     $v0, $0, 1			
	add 	$a0, $a2, $0
	syscall
	
	# Exit (load 10 into $v0)
	ori     $v0, $0, 10
	syscall

