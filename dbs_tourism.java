/*
ISYS2014 - DATABASE SYSTEM
RAIHAN KHALIL ABDILLAH
17900375
FRIDAY 10AM
*/

import java.sql.*;
import java.util.*;

public class dbs_tourism {
    public static void main(String[] args) {
        int sel = 100000;
        Scanner sc = new Scanner(System.in);
        
        System.out.print("Username: ");
        String user = sc.nextLine();

        System.out.print("Password: ");
        String password = sc.nextLine();

        System.out.print("Database: ");
        String db = sc.nextLine();

        String url = "jdbc:mysql://localhost:3306/" + db;

        try {
            Connection conn = DriverManager.getConnection(url, user, password);
            Statement stmt = conn.createStatement();
            System.out.println("Connected to database : " + conn.getCatalog());

            while(sel != 0) {
            System.out.println("Select menu:");
            System.out.println("1. printAllUsers\n2. RandomNames7000.csv\n0. exit");
            
            try {
                sel = sc.nextInt();
                switch(sel) {
                    case 1:
                        // manual stuf
                        printAllUser(sc, stmt);
                        break;
                    case 2:
                        // randomnames7000csv
                        //autoSelection2(sc);
                        break;
                    case 0:
                        break;
                    default:
                        System.out.println("Wrong selection");
                }
            }  catch (InputMismatchException e) {
                sel = 100000;
                sc.nextLine();
                System.out.println(e + ". Please input selection properly.");
                
            } catch (NoSuchElementException e2) {
                System.out.println(e2);
            }
        
            }
            
        } catch (SQLException e) {
            System.out.println("Database error: " + e.getMessage());
        }

        sc.close();
    }

    public static void printAllUser(Scanner sc, Statement stmt) {
        String selectQ1 = "SELECT * FROM users";
        
        try {
            ResultSet rs = stmt.executeQuery(selectQ1);

            while(rs.next()) {
                System.out.println("| " + rs.getString(1) + " | " + rs.getString(2) + " | " + rs.getString(3) + " |");
            }
            
        } catch (SQLException e) {
            System.out.println("Database error: " + e.getMessage());
        }
 
    }
}
