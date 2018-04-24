import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.*;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.*;
import com.connection.DBConnection;

/**
 * Servlet implementation class UpdateEmployeeProfile
 */
public class UpdateUserProfile extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public UpdateUserProfile() {
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
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String ename = request.getParameter("ename");
		String eadd = request.getParameter("eadd");
		String emobile = request.getParameter("emobile");
		String eemail = request.getParameter("eemail");
		String edesignation = request.getParameter("edesignation");
		String uname = request.getParameter("uname");
		String pass = request.getParameter("pass");
		String answer=request.getParameter("answer");
		HttpSession hs = request.getSession();
		try {
			Connection con = DBConnection.getConn();
			Statement st = con.createStatement();
			int update = st.executeUpdate("update user_details set username='" + ename + "',user_address='" + eadd
					+ "',user_mobile='" + emobile + "',user_email='" + eemail + "',user_designation='" + edesignation
					+ "',uname='" + uname + "',password='" + pass + "',answer='"+answer+"' where uname='"+hs.getAttribute("uid")+"'");
			if (update > 0) {
				response.sendRedirect("UserProfileUpdateSuccessfully.jsp");
			} else {
				response.sendRedirect("EditProfile.jsp");
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		doGet(request, response);
	}

}
