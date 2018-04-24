package com.simplecodestuffs.jdbc;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DataAccessObject {
	private static Connection dbConnection = null;
	private static final String dbDriver = "com.mysql.jdbc.Driver";
	private static String serverName = "localhost";
	private static String portNumber = "3306";
	private static String sid = "digilocker";
	private static final String dbUrl = "jdbc:mysql://" + serverName + ":" + portNumber + "/" + sid;
	private static final String dbUser = "root";
	private static final String dbPassword = "root";

	public static Connection getConnection() {
		if (dbConnection != null)
			return dbConnection;
		else {
			try {
				Class.forName(dbDriver);
			} catch (ClassNotFoundException e) {
				System.out.println("Add Oracle JDBC Driver in classpath ");
				e.printStackTrace();
			}

			try {
				dbConnection = DriverManager.getConnection(dbUrl, dbUser, dbPassword);
			} catch (SQLException e) {
				e.printStackTrace();
			}

			if (dbConnection == null) {
				System.out.println("Failed to make connection!");
			}
		}
		return dbConnection;
	}
}