import javax.servlet.*;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
public class AdminLogin extends HttpServlet {
	private static final long serialVersionUID = 1L;
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String uname = request.getParameter("uid");
		String pass = request.getParameter("pass");
		HttpSession hs=request.getSession();
		if (uname.equals("admin") && pass.equals("admin")) {
			hs.setAttribute("uname", uname);
			response.sendRedirect("UnderAdminPage.jsp");
		} else {
			response.sendRedirect("adminLogin.jsp");
		}
		
	}

}
