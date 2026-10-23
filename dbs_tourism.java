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
        Scanner sc = new Scanner(System.in);
        
        System.out.print("Username: ");
        String user = sc.nextLine();

        System.out.print("Password: ");
        String password = sc.nextLine();

        String url = "jdbc:mysql://localhost:3306/abdillah_17900375";

        try {
            Connection conn = DriverManager.getConnection(url, user, password);
            Statement stmt = conn.createStatement();
            System.out.println("Connected to database : " + conn.getCatalog());

            
            
        } catch (SQLException e) {
            System.out.println("Database error: " + e.getMessage());
        }

        sc.close();
    }
}
