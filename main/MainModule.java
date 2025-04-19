
package main;
import java.util.Scanner;

public class MainModule {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        System.out.println("===== Student Information System =====");
        System.out.println("1. Add Student");
        System.out.println("2. Enroll Student");
        System.out.println("3. Exit");
        System.out.print("Enter your choice: ");
        int choice = scanner.nextInt();
        switch (choice) {
            case 1:
                System.out.println("--> Student Aman Patel added successfully.");
                break;
            case 2:
                System.out.println("--> Enrollment complete.");
                break;
            default:
                System.out.println("Exiting...");
        }
    }
}
