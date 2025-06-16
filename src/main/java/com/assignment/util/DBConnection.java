package com.assignment.util;

import org.apache.commons.dbcp2.BasicDataSource;

import java.sql.Connection;
import java.sql.SQLException;

public class DBConnection {

    private static final BasicDataSource dataSource = new BasicDataSource();

    static {
        try {
            dataSource.setDriverClassName("com.mysql.cj.jdbc.Driver");
            dataSource.setUrl("jdbc:mysql://localhost:3306/complaint_db");
            dataSource.setUsername("root");
            dataSource.setPassword("Ijse@1234");

            // Pool settings
            dataSource.setInitialSize(5);
            dataSource.setMaxTotal(20);
            dataSource.setMinIdle(5);
            dataSource.setMaxIdle(10);
            dataSource.setMaxWaitMillis(10000);

            System.out.println("[DBConnection] ✅ Connection Pool Initialized");

        } catch (Exception e) {
            System.err.println("[DBConnection] ❌ Failed to initialize DB pool: " + e.getMessage());
        }
    }

    // Return a connection from the pool
    public static Connection getConnection() throws SQLException {
        return dataSource.getConnection();
    }

    // Optional shutdown method
    public static void shutdown() {
        try {
            dataSource.close();
            System.out.println("[DBConnection] 🛑 Connection Pool Closed");
        } catch (Exception e) {
            System.err.println("[DBConnection] ❌ Error closing DB pool: " + e.getMessage());
        }
    }
}
