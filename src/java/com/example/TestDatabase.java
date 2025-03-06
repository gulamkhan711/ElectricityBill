package com.example;

import java.sql.Connection;
import java.sql.DatabaseMetaData;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class TestDatabase {

    private static final String JDBC_URL = "jdbc:derby://localhost:1527/electricitybillingsystem;create=true";
    private static final String JDBC_USER = "root";
    private static final String JDBC_PASSWORD = "root";

    public static void main(String[] args) {
        try (Connection connection = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD)) {
            // Check if the CUSTOMERS table exists
            if (tableExists(connection, "CUSTOMERS")) {
                System.out.println("The CUSTOMERS table exists.");
            } else {
                System.out.println("The CUSTOMERS table does not exist.");
            }

            // Optionally, you can also print all table names in the database
            printAllTables(connection);

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Method to check if a table exists
    private static boolean tableExists(Connection connection, String tableName) {
        ResultSet rs = null;
        try {
            DatabaseMetaData metaData = connection.getMetaData();
            rs = metaData.getTables(null, null, tableName.toUpperCase(), null);
            return rs.next();
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        } finally {
            if (rs != null) {
                try {
                    rs.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    }

    // Method to print all table names in the database
    private static void printAllTables(Connection connection) {
        ResultSet rs = null;
        try {
            DatabaseMetaData metaData = connection.getMetaData();
            rs = metaData.getTables(null, null, null, new String[]{"TABLE"});
            System.out.println("Tables in the database:");
            while (rs.next()) {
                String tableName = rs.getString("TABLE_NAME");
                System.out.println(" - " + tableName);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            if (rs != null) {
                try {
                    rs.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    }
}
