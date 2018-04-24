package com.viewprofile;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.sql.Blob;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.connection.MyConnection;

public class DisplayPhotoServlet extends HttpServlet {
	protected void processRequest(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		try {
			Connection con = MyConnection.getConnection();
			PreparedStatement ps = con.prepareStatement("select user_photo from user_details where uname = ?");
			String id = request.getParameter("id");
			ps.setString(1, id);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				Blob b = rs.getBlob("user_photo");
				response.setContentType("image/jpeg");
				response.setContentLength((int) b.length());
				InputStream is = b.getBinaryStream();
				OutputStream os = response.getOutputStream();
				byte buf[] = new byte[(int) b.length()];
				is.read(buf);
				os.write(buf);
				os.close();
			}
		} catch (Exception ex) {
			System.out.println(ex.getMessage());
		}
	}

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		processRequest(request, response);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		processRequest(request, response);
	}
}