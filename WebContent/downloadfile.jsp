<%@page import="java.sql.ResultSet"%>
<%@page import="com.connection.MyConnection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>download file Page!</h1> <br/>
        
        <table border="1">
            <tr><th>File Name</th><th>Uploaded By</th><th>File Type</th><th>Upload Time</th><th>Action</th></tr>
            <%
                ResultSet rs = MyConnection.getResultFromSqlQuery("select doc_id,filename,type, upload_time, upload_by from documents");
                int count =0;
                while(rs.next())
                {
                   out.println("<tr>"
                           + "<td>"+rs.getString(2)+"</td>"
                           + "<td>"+rs.getString(5)+"</td>"
                           + "<td>"+rs.getString(3)+"</td>"
                           + "<td>"+rs.getString(4)+"</td>"
                           + "<td><a href='download.jsp?Doc_id="+rs.getInt(1) +"'> Download </a></td>"                                                      
                           + "</tr>");
                   count++;
                }
                rs.close();
                MyConnection.CloseConnection();
                if(count==0)
                {
                    out.println("<tr><td colspan='4'> No File Found..!! </td></tr>");
                }
            %>            
        </table>
        <br/>
        <a href="index.jsp">Home Page </a>
    </body>
</html>
