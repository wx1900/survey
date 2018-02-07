<%-- version 1.0 --%>
<%-- this version we have three questions --%>
<%@page contentType="text/html;charset=utf-8" import="java.sql.*" %>
<html>
    <head>
        <link href="third-party/semantic.css" rel="stylesheet" type="text/css">
        <script src="third-party/jquery-3.1.1.min.js"></script>
        <script src="third-party/semantic.js"></script>
        <title>Survey</title>
    </head>
    <body>
        <div class = "ui inverted vertical segment">
            <h1 class="ui inverted header" style="margin-left:20px">Survey</h1>
        </div>
        <div class = "ui container">       
            <div class = "ui vertical padded segment">
                <div class = "ui padded segment">
                    For the following tweet's reply, please rate its language structure and emotional orientation.
                </div>
                <form class = "ui form segment" action = "test2.jsp" method = "POST">
                <div class = "ui padded segment">
                    <div class="ui horizontal divider">or</div>
                    <p>Tell Us About Yourself</p>
                    <div class="two fields">
                        <div class="field">
                        <label>Name</label>
                        <input placeholder="First Name" name="name" type="text">
                        </div>
                        <div class="field">
                        <label>Age</label>
                        <input placeholder="" name="age" type="text">
                        </div>
                    </div>
                    <div class="two fields">
                    <div class="field">
                        <label>Occupation</label>
                        <select class="ui dropdown" name="occupation">
                            <option value="student">Student</option>
                            <option value="teacher">Teacher</option>
                            <option value="programmer">Programmer</option>
                            <option value="engineer">Engineer</option>
                            <option value="clerk">Office clerk</option>
                            <option value="others">Others</option>
                        </select>
                    </div>
                    <div class="field">
                        <label>E-mail</label>
                        <input placeholder="example@gmail.com" name="email" type="text">
                    </div>
                    </div>
                    <div class="ui error message"></div>
                </div>
                <%
                String driver = "com.mysql.jdbc.Driver"; 
                String url = "jdbc:mysql://localhost:3306/tomcat"; 
                String user = "tomcat"; 
                String password = "123456"; 
                try { 
                    Class.forName(driver); 
                    Connection conn = DriverManager.getConnection(url, user, password);
                    Statement sql;
                    ResultSet rs;
                    int user_num = 4;
                    int rate_num = 5;
                    if(!conn.isClosed()){
                        out.print("<div class=\"ui raised segment\">");
                        out.print("<h3 class=\"ui header\">Post</h3>");
                        sql = conn.createStatement();
                        rs = sql.executeQuery("select * from post limit 0,1");
                        while(rs.next()) {
                            out.print("<h4>"+rs.getString(1)+"</h4>");
                        }
                        out.print("<div class=\"ui section divider\"></div>");
                        out.print("<h3 class=\"ui header\">Reply</h3>");
                        rs = sql.executeQuery("select * from comment limit 0,1");
                        while(rs.next()) {
                            out.print("<h4>"+rs.getString(1)+"</h4>");
                        }
                        out.print("</div>");
                        out.print("<div class=\"ui segment\">");
                        out.print("<div class=\"ui form\">");
                        out.print("<div class=\"grouped fields\">");
                            out.print("<label>Please rate the integrity of the language structure of the reply.The higher the score, the more complete the language structure. </label>");
                            out.print("<div class=\"field\">");
                                out.print("<div class=\"ui radio checkbox\">");
                                out.print("<input type=\"radio\" name=\"score\" checked=\"checked\" value=\"1\">");
                                out.print("<label>1</label>");
                                out.print("</div>");
                            out.print("</div>");
                            for (int i = 1; i < rate_num; i++) {
                                out.print("<div class=\"field\">");
                                out.print("<div class=\"ui radio checkbox\">");
                                out.print("<input type=\"radio\" name=\"score\" value=\"" + (i+1) + "\">");
                                out.print("<label>" + (i+1) + "</label>");
                                out.print("</div>");
                                out.print("</div>");
                            }
                        out.print("</div>");
                        out.print("<div class=\"grouped fields\">");
                            out.print("<label>Please choose the emotional orientation of reply.</label>");
                            out.print("<div class\"field\">");
                                out.print("<div class=\"ui radio checkbox\">");
                                out.print("<input type=\"radio\" name=\"emotion\" checked=\"checked\" value=\"1\">");
                                out.print("<label>Positive</label>");
                                out.print("</div>");
                            out.print("</div>");
                            out.print("<div class\"field\">");
                                out.print("<div class=\"ui radio checkbox\">");
                                out.print("<input type=\"radio\" name=\"emotion\" value=\"0\">");
                                out.print("<label>Negative</label>");
                                out.print("</div>");
                            out.print("</div>");
                        out.print("</div>");
                        out.print("<div class=\"grouped fields\">");
                            out.print("<label>Please select the user with the closest language style. </label>");
                            out.print("<div class\"field\">");
                                out.print("<div class=\"ui radio checkbox\">");
                                out.print("<input type=\"radio\" name=\"user\" checked=\"checked\"value=\"1\">");
                                out.print("<label>User 1</label>");
                                out.print("</div>");
                            out.print("</div>");
                            for (int i = 1; i < user_num; i++){
                                out.print("<div class\"field\">");
                                out.print("<div class=\"ui radio checkbox\">");
                                out.print("<input type=\"radio\" name=\"user\" value=\"" + (i+1) + "\">");
                                out.print("<label>User "+ (i+1) +"</label>");
                                out.print("</div>");
                                out.print("</div>");
                            }
                        out.print("<div>");
                        out.print("<div class=\"ui accordion\">");
                        for (int i = 0; i < user_num; i++) {
                            out.print("<div class=\"title\">");
                            out.print("<i class=\"dropdown icon\"></i>");
                            out.print("User "+(i+1));
                            out.print("</div>");
                            out.print("<div class=\"content\">");
                            out.print("<p class=\"transition hidden\">");
                            int no = 1;
                            rs = sql.executeQuery("select * from comment limit " + (i*20) + ",20");
                            while(rs.next()) {
                                out.print(no+" "+rs.getString(1)+"<br>");
                                no++;
                            }
                            out.print("</p>");
                            out.print("</div>");
                        }
                        out.print("</div>");
                        out.print("</div>");
                        out.print("</div>");
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
                <div class = "field">
                    <button class = "ui primary button">
                    Submit
                    </button>
                </div>
                </form>
            </div>
        </div>
        <script>$('.ui.accordion').accordion();</script>
        <script>
            $('.ui.form')
                .form({
                    fields: {
                    name     : 'empty',
                    age   : 'empty',
                    occupation: 'empty',
                    email: 'empty'
                    }
                })
                ;
        </script>
    </body>
</html>