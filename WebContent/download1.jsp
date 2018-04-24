<%@page import="java.util.Random"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.io.OutputStream"%>
<%@page import="java.sql.Blob"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="com.connection.MyConnection"%>
<%
	int a = 0;
	double tcount = 0;
	double prec = 0;
	double recall = 0;
	double fitness = 0;

	Connection conn = MyConnection.getConnection();
	Statement st2 = conn.createStatement();
	ResultSet rs2 = st2
			.executeQuery("select count(*) from access where fromuser='" + session.getAttribute("uid") + "'");
	while (rs2.next()) {
		tcount = rs2.getDouble(1);
	}

	Random r = new Random();
	double no = r.nextDouble();
	prec = no / tcount;
	recall = (tcount - no) / tcount;
	fitness = (2 * prec * recall);

	Statement st1 = conn.createStatement();
	st1.executeUpdate("insert into analysis values('" + a + "','" + session.getAttribute("Filename") + "','"+ prec + "','" + recall + "','" + fitness + "')");
	String filename = request.getParameter("filename");
	ResultSet rs = MyConnection.getResultFromSqlQuery("select filename, type, content from Documents where FileName = '" + filename + "'");
	rs.next();
	response.reset();
	if (rs.getString(2) == ".txt") {
		response.setContentType("application/octet-stream");
	} else if (rs.getString(2) == ".pdf") {
		response.setContentType("application/pdf");
	} else if ((rs.getString(2) == ".doc") || rs.getString(2) == ".docx") {
		response.setContentType("application/msword");
	} else if ((rs.getString(2) == ".xls") || (rs.getString(2) == ".xlsx")) {
		response.setContentType("application/vnd.ms-excel");
	}
	response.addHeader("Content-Disposition", "attachment; filename=" + rs.getString(1));
	Blob blb = rs.getBlob(3);
	byte[] bdata = blb.getBytes(1, (int) blb.length());

	OutputStream output = response.getOutputStream();
	output.write(bdata);
	output.close();

	rs.close();
	MyConnection.CloseConnection();
%>