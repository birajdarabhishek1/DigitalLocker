<%@page import="java.io.OutputStream"%>
<%@page import="java.sql.Blob"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="com.connection.MyConnection"%>
<%
	String doc_id = request.getParameter("Doc_id");
	ResultSet rs = MyConnection
			.getResultFromSqlQuery("select filename, type, content from Documents where doc_id = " + doc_id);
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