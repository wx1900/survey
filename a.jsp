<%@page contentType="text/html;charset=utf-8" import="java.sql.*" %>
<%
    String driver = "com.mysql.jdbc.Driver"; 
    String url = "jdbc:mysql://localhost:3306/tomcat"; //数据库web
    String user = "root"; 
    String password = "2018"; 
    try { 
        Class.forName(driver); 
        Connection conn = DriverManager.getConnection(url, user, password);

        if(!conn.isClosed()) 
            out.println("success"); 
        conn.close(); 
    } 
    catch(ClassNotFoundException e) { 
        out.println("no..."); 
        e.printStackTrace(); 
    } 
    catch(SQLException e) { 
        e.printStackTrace(); 
    } 
%>
