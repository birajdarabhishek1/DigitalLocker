import java.sql.*;
import java.util.Random;
import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.connection.*;

/**
 * Servlet implementation class AccessServlet
 */
@WebServlet("/AccessServlet")
public class AccessServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public AccessServlet() {
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
		System.out.println("In Access Servlet File");
		HttpSession session = request.getSession(false);
		String strFileName = request.getParameter("u");
		session.setAttribute("strFileName", strFileName);
		int a = 0;
		double tcount = 0;
		double prec = 0;
		double recall = 0;
		double fitness = 0;
		try {
			Connection con = MyConnection.getConnection();
			Statement st = con.createStatement();
			ResultSet rs = st.executeQuery("select count(*) from access where touser='" + session.getAttribute("unam") + "'");
			while (rs.next()) {
				tcount = rs.getDouble(1);
			}
			Random r = new Random();
			double no = r.nextDouble();
			prec = no / tcount;
			recall = (tcount - no) / tcount;
			fitness = (2 * prec * recall);
			PreparedStatement pst = con.prepareStatement("insert into analysis values('" + a + "','" + strFileName
					+ "','" + prec + "','" + recall + "','" + fitness + "')");
			int b = pst.executeUpdate();
			if (b > 0) {
				System.out.println("inseted successfully");
			}
		} catch (Exception e) {
			e.printStackTrace();

		}

		RequestDispatcher rd = request.getRequestDispatcher("/PasswordSubmit.jsp");
		rd.include(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

}
