import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class ListPhotosServlet extends HttpServlet {

	protected void processRequest(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
		int empid = Integer.parseInt(request.getParameter("id"));
		try {
			Class.forName("com.mysql.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/digilocker", "root", "root");
			PreparedStatement ps = con.prepareStatement("select * from user_details where userid='" + empid + "'");
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				out.print("<br><br><br><br><br><br>");
				out.print("<center>");
				out.print("<fieldset style='width:300px;background-color:#F8F8F8 ;'>");
				out.print("<table>");
				out.print("<tr>");
				out.print("<center>");
				out.print("<h2><font color='blue'>Your ID Card</font></h2>");
				out.print("</center>");
				out.print("</tr>");
				out.print("<br>");
				out.print("<tr>");
				out.print("<img width='100' height='100' border='1' src=displayphoto?id=" + rs.getString("userid")+"></img> <p/>");
				out.print("</tr>");
				out.print("<tr>");
				out.print("<td><strong>Employee Id : </strong> </td>");
				out.print("<td>");
				out.println(rs.getString("userid"));
				out.print("</td>");
				out.print("</tr>");
				out.print("<tr>");
				out.print("<td><strong>Employee Name : </strong> </td>");
				out.print("<td>");
				out.println(rs.getString("username"));
				out.print("</td>");
				out.print("</tr>");
				out.print("<tr>");
				out.print("<td><strong>Address : </strong> </td>");
				out.print("<td>");
				out.println(rs.getString("user_address"));
				out.print("</td>");
				out.print("</tr>");
				out.print("<tr>");
				out.print("<td><strong>Mobile : </strong> </td>");
				out.print("<td>");
				out.println(rs.getString("user_mobile"));
				out.print("</td>");
				out.print("</tr>");
				out.print("<tr>");
				out.print("<td><strong>Email : </strong> </td>");
				out.print("<td>");
				out.println(rs.getString("user_email"));
				out.print("</td>");
				out.print("</tr>");
				out.print("<tr>");
				out.print("<td><strong>Occupation:</strong></td>");
				out.print("<td>");
				out.println(rs.getString("user_designation"));
				out.print("</td>");
				out.print("</tr>");
				out.print("</table>");
				out.print("</fieldset>");
				out.print("<br>");
				out.print("<table>");
				out.print("<input type='button' value='Print Your Identity Card' onClick='window.print()' style='height:35px;color:white;background-color:#660099;border-radius: 8px;'>");
				out.print("</table>");
				out.print("<table>");
				out.print("<a href='EmployeeSearch.jsp'>Back</a>");
				out.print("</table>");
				out.print("</center>");
			} else {
				out.print("<br><br><br><br><br><br>");
				out.print("<center>");
				out.print("<fieldset style='width:300px;background-color:#F8F8F8 ;'>");
				out.print("<table>");
				out.print("Employee Record Not Found");
				out.print("<br>");
				out.print("<a href='EmployeeSearch.jsp'>Click Here</a>");
				out.print("</table>");
				out.print("</fieldset>");
				out.print("</center>");
			}
			con.close();
		} catch (Exception ex) {

		} finally {
			out.close();
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