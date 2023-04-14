# Garrett Green & Logan 
# Section: 03 
# CPE 315: Commented java function and .asm file to reverse a 32 bit number.

# public void main(){
#.   string welcome = "This program returns the reverse (bit) of a 32 bit number \n\n";
#    string prompt = " Enter an Integer: ";
#    string remainder = " \n Reverse: ";
#    system.out.print(welcome);
#    system.out.print(prompt);
#   //scan integer from command line  (x)
#    Scanner scan = new Scanner(system.in);	
#    int num = scan.nextInt();
#    int counter = 0;
#    int reverse_num = 0;
#    while (counter < 32){
#		int bit_change = num >> counter & 1;
#       reversed = reversed << 1 | bit;
#       counter++;
#}	
#    system.out.print(remainder);
#	 system.out.print(reverse_num);
#}


# declare global so programmer can see actual addresses.
.globl welcome
.globl prompt
.globl sumText

#  Data Area (this area contains strings to be displayed during the program)
.data

welcome:
	.asciiz "This program returns the reverse of a 32-bit number \n\n"

prompt:
	.asciiz " Enter an integer: "
    
sumText: 
	.asciiz " \n Reverse = "

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
	ori     $a0, $a0,0x38
	syscall

    # Read 1st integer from the user (numerator)
	ori     $v0, $0, 5
	syscall

     # Put num into s0
    addi $s0, $v0, 0

	# $s1 carries counter var
	addi $s1, $0, 0

loop:
	
	srl $s2, $s0, $s1
	andi $s3, $s2, 0x01
	sll $s4, $s4, 1
	or $s4, $s4, $s3
	addi $s1, $s1, 1

	blt $s1, 32, loop

	#display text
    ori     $v0, $0, 4			
	lui     $a0, 0x1001
	ori     $a0, $a0,0x4E
	syscall

	# load syscall to print integer and set $a0 to reverse number
	li $v0, 1
	addi $a0, $s4, 0
	syscall

	ori $v0, $0, 10
    syscall

