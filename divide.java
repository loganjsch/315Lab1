import java.util.Scanner;

public class divide{

    public static void main (String[] args){

        Scanner input = new Scanner(System.in);

        System.out.print("Enter first integer");
        int upperBits = input.nextInt();

        System.out.print("Enter second integer");
        int lowerBits = input.nextInt();

        System.out.print("Enter the divisor");
        int divisor = input.nextInt();

        input.close();

        long newUp = (long)upperBits;
        long newlow = (long)lowerBits;

        long dividend = (newUp << 32) | newlow;

        int power = 0;

        while (divisor != 1){
            divisor /= 2;
            power += 1;
        }

        long quotient = dividend >>> power;

        long upperResult = quotient >>> 32;
        long lowerResult = quotient & 0xFFFFFFFFF;
        System.out.println("Quotient (Upper 32 bits): " + upperResult);
        System.out.println("Quotient (Lower 32 bits): " + lowerResult);

    }

}