import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.*;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.*;
import com.connection.DBConnection;

/**
 * Servlet implementation class EmployeeLogin
 */

public class UserLogin extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public UserLogin() {
		super();
		// TODO Auto-generated constructor stub
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String uid = request.getParameter("uid");
		String pass = request.getParameter("pass");
		try {
			HttpSession hs = request.getSession();
			Connection con = DBConnection.getConn();
			Statement st = con.createStatement();
			Statement st2 = con.createStatement();

			ResultSet rs = st.executeQuery("select uname,password,user_email from user_details where uname='" + uid+ "' and password='" + pass + "'");
			if (rs.next()) {
				ResultSet rs2 = st2.executeQuery("select * from blockuser where user='" + uid + "' and times > '4'");
				if (rs2.next()) {
					response.sendRedirect("index.jsp?message=blockuser");
				} else {

					hs.setAttribute("uid", rs.getString(1));
					hs.setAttribute("email", rs.getString(3));
					response.sendRedirect("afterLoginPage.jsp");
				}
			} else {
				response.sendRedirect("index.jsp");
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

	}

}
