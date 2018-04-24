package com.filesharing;
import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class ShareServlet
 */
@WebServlet("/ShareServlet")
public class ShareServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public ShareServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession(false);
		String[] Checkbox = request.getParameterValues("Checkbox");

		String Checked[] = Checkbox;
		int i = 0;
		try {

			String Key = "";
			Connection con = Dbconn.conn();
			Statement st1 = con.createStatement();
			ResultSet rs3 = st1
					.executeQuery("select * from data where filename='" + session.getAttribute("FileName") + "'");
			if (rs3.next()) {
				Key = rs3.getString("privatekey");
			}

			for (String s : Checkbox) {
				Checked[i] = s;
				System.out.println("CheckBox Values" + s);
				i++;
				ResultSet rs1 = st1.executeQuery("select * from register where uname='" + s + "'");
				if (rs1.next()) {
					SendMail.mailSend((String) session.getAttribute("FileName"), Key, rs1.getString("email"));
					// SMSsend.send(rs1.getString(1),
					// "Key-"+session.getAttribute("FileName"), Key);
				}

				Statement st = con.createStatement();
				st.executeUpdate("insert into access values('" + session.getAttribute("unam") + "' , '"+ session.getAttribute("FileName") + "' , '" + s + "')");
				RequestDispatcher rd = request.getRequestDispatcher("/mainPage.jsp");
				rd.include(request, response);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

	}

}
