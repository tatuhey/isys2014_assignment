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
        String input;

        Scanner sc = new Scanner(System.in);
        
        System.out.print("Username: ");
        String user = sc.nextLine();                            // sql username: dsuser

        System.out.print("Password: ");
        String password = sc.nextLine();                        // userCreateSQL

        System.out.print("Database: ");
        String db = sc.nextLine();                              // db of assignment: abdillah_17900375

        String url = "jdbc:mysql://localhost:3306/" + db;

        try {
            Connection conn = DriverManager.getConnection(url, user, password);
            Statement stmt = conn.createStatement();
            System.out.println("Connected to database : " + conn.getCatalog());

            while(sel != 0) {
            System.out.println("Select menu:");
            System.out.println("1. SHOW TABLES\n2. SELECT * FROM\n3. enter any query, NO SEMICOLON\n0. exit");
            try {
                sel = sc.nextInt();
                switch(sel) {
                    case 1:
                        showTables(sc, stmt);

                        break;
                    case 2:
                        sc.nextLine();                              // to clean entry
                        System.out.print("input table name: ");
                        input = sc.nextLine();
                        
                        printAll(sc, stmt, input);
                        break;
                    case 3:
                        sc.nextLine();                              // to clean entry
                        System.out.print("query: ");
                        input = sc.nextLine();
                        
                        freeQuery(sc, stmt, input);
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

    public static void printAll(Scanner sc, Statement stmt, String input) {
        String selectQ1 = "SELECT * FROM " + input;
        
        try {
            ResultSet rs = stmt.executeQuery(selectQ1);
            ResultSetMetaData rsmd = rs.getMetaData();
            int col = rsmd.getColumnCount();

            System.out.print("| ");
            for(int i = 1; i <= col; i++) {                         // column count starts at 1
                System.out.print(rsmd.getColumnName(i) + " | ");
            }
            System.out.println();

            while(rs.next()) {
                System.out.print("| ");
                for(int i = 1; i <= col; i++) {
                    System.out.print(rs.getString(i) + " | ");
                }
                System.out.println();
            }
            
        } catch (SQLException e) {
            System.out.println("Database error: " + e.getMessage());
        }
 
    }

    public static void showTables(Scanner sc, Statement stmt) {
        String selectQ1 = "SHOW TABLES";
        
        try {
            ResultSet rs = stmt.executeQuery(selectQ1);
            ResultSetMetaData rsmd = rs.getMetaData();
            int col = rsmd.getColumnCount();

            System.out.print("| ");
            for(int i = 1; i <= col; i++) {                         // column count starts at 1
                System.out.print(rsmd.getColumnName(i) + " | ");
            }
            System.out.println();

            while(rs.next()) {
                System.out.print("| ");
                for(int i = 1; i <= col; i++) {
                    System.out.print(rs.getString(i) + " | ");
                }
                System.out.println();
            }
            
        } catch (SQLException e) {
            System.out.println("Database error: " + e.getMessage());
        }
 
    }
    
    public static void freeQuery(Scanner sc, Statement stmt, String input) {
        String selectQ1 = input;
        
        try {
            ResultSet rs = stmt.executeQuery(selectQ1);
            ResultSetMetaData rsmd = rs.getMetaData();
            int col = rsmd.getColumnCount();

            System.out.print("| ");
            for(int i = 1; i <= col; i++) {                         // column count starts at 1
                System.out.print(rsmd.getColumnName(i) + " | ");
            }
            System.out.println();

            while(rs.next()) {
                System.out.print("| ");
                for(int i = 1; i <= col; i++) {
                    System.out.print(rs.getString(i) + " | ");
                }
                System.out.println();
            }
            
        } catch (SQLException e) {
            System.out.println("Database error: " + e.getMessage());
        }
 
    }
}
