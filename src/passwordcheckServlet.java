import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.Random;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.connection.MyConnection;

/**
 * Servlet implementation class passwordcheckServlet
 */
@WebServlet("/passwordcheckServlet")
public class passwordcheckServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public passwordcheckServlet() {
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
		// TODO Auto-generated method stub
		HttpSession session = request.getSession(false);
		String Password = request.getParameter("key");
		try {
			Connection conn = MyConnection.getConnection();
			Statement st = conn.createStatement();
			System.out.println(" file name is " + session.getAttribute("Filename"));
			ResultSet rs = st.executeQuery("select * from documents where FileName='" + session.getAttribute("Filename") + "'");
			
			if (rs.next()) {
				String SysTemPassword = rs.getString("privateKey");
				if (SysTemPassword.equals(Password)) {
					response.sendRedirect("download1.jsp?filename=" + session.getAttribute("Filename"));
				} else {
					System.out.println("Not Download");
					response.sendRedirect("downloadCheck.jsp?message=wrong");
				}

			}
		} catch (Exception e) {
			e.printStackTrace();
		}

	}

}
