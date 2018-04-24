package com.connection;

import java.sql.*;

public class DBConnection {

	public static Connection getConn() {
		Connection con = null;
		try {
			Class.forName("com.mysql.jdbc.Driver");
			String url = "jdbc:mysql://localhost:3306/digilocker";
			con = DriverManager.getConnection(url, "root", "root");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return con;
	}

}
