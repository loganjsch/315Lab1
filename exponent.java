import java.util.Scanner;

public class exponent {

    public static void main(String[] args) {

        Scanner input = new Scanner(System.in);

        System.out.print("Enter first integer");
        int x = input.nextInt();

        System.out.print("Enter second integer");
        int y = input.nextInt();

        input.close();

        int answer = x;
        int increment = x;

        for (int i = 1; i < y; i++){
            for (int j = 1; j < x; j++) {
                answer += increment;
            }
            increment = answer;
        }

        System.out.println(answer);
    }
}
