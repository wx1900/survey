<%-- this is used to transfor information from client to server. --%>
<%-- version 3.0 2018.02.04 --%>
<%@page contentType="text/html;charset=utf-8" import="java.sql.*" %>
<%
int part =  Integer.parseInt(request.getParameter("part"));
int part_num = Integer.parseInt(request.getParameter("part_num"));
int user_num = 4;
%>
<html>
    <head>
        <link href="third-party/semantic.css" rel="stylesheet" type="text/css">
        <script src="third-party/jquery-3.1.1.min.js"></script>
        <script src="third-party/semantic.js"></script>
        <title>Survey</title>        
    </head>
    <body>
        <div class = "ui blue inverted vertical segment">
            <h1 class="ui inverted header"  style="margin-left:20px">Survey</h1>
        </div>
        <div class = "ui container">       
            <div class = "ui middle aligned center aligned grid" style="margin-top: 30%">
                <div class="ui large statistic" >
                    <div class="value">
                        Thank you!
                    </div>
                    <div>
                    <img src="pikaq.png">
                    </div>
                </div>
            </div>
            <%
                String driver = "com.mysql.jdbc.Driver"; 
                String url = "jdbc:mysql://localhost:3306/tomcat"; //数据库web
                String user = "tomcat"; 
                String password = "123456"; 
                try { 
                    Class.forName(driver); 
                    Connection conn = DriverManager.getConnection(url, user, password);
                    Statement sql;
                    ResultSet rs;
                    if(!conn.isClosed()){
                        sql = conn.createStatement();
                        //out.print("part = " +part+" ; part_num = "+part_num+"<br>");
                        String name = "";
                        String occupation = "";
                        String email = "";
                        String gender = "";
                        int age = 20;
                        if (request.getParameter("name") != null) {
                            name = request.getParameter("name");
                        }
                        if (request.getParameter("age") != null) {
                            age = Integer.parseInt(request.getParameter("age"));
                            occupation = request.getParameter("occupation");
                            email = request.getParameter("email");
                            gender = request.getParameter("gender");
                            out.print("<p>测试数据:</p>");
                            out.print("name = "+name+"<br>");
                            out.print("age = "+age+"<br>");
                            out.print("occupation = "+occupation+"<br>");
                            out.print("email = "+email+"<br>");
                            out.print("gender = "+gender+"<br>");
                            out.print("insert into participant values('"+name+"',"+age+",'"+occupation+"','"+email+"');");
                           // sql.execute("insert into participant values('"+name+"',"+age+",'"+occupation+"','"+email+"');");
                        } else {
                            //out.print("#$%$@%^%$@^!!@#@<br>");
                        }
                        //out.print("!#%%^&!@$#^%%^*!@#@#%#$^#$^%$<br>");
                    }    
                    conn.close();                
                } 
                catch(ClassNotFoundException e) { 
                    out.println("找不到驱动程序"); 
                    e.printStackTrace(); 
                } 
                catch(SQLException e) { 
                    e.printStackTrace(); 
                } 
            %>
            
        </div>
        <script>
        $('.value')
         .transition('jiggle')
        ;
        </script>
    </body>
</html>