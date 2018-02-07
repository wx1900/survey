<%@page contentType="text/html;charset=utf-8" import="java.sql.*" %>
<%
    int startpos = 0; 
    int part_num = 10;
    int user_num = 4;
    int rate_num = 5;
    double font_size = 1.23;
    if (request.getParameter("start") != null) 
        startpos = Integer.parseInt(request.getParameter("start"));
%>
<html>
    <head>
        <link href="third-party/semantic.css" rel="stylesheet" type="text/css">
        <link href="third-party/jquery.validator.css" rel="stylesheet" type="text/css">
        <script src="third-party/jquery-3.1.1.min.js"></script>
        <script src="third-party/semantic.js"></script>
        <script src="third-party/jquery.validator.js"></script>
        <title>Survey</title>
        <style type="text/css">
            body,td,th,div {font-family: Verdana, Arial, Helvetica, sans-serif;font-size: 1.23em;color: #1d1007; line-height:24px} 
            .ui {font-size: 1.23em}
            .container.segment {font-size: 1.23em}
        </style>
    </head>
    <body>
        <div class = "ui blue inverted vertical segment">
            <h1 class="ui inverted header" style="margin-left:20px">Survey</h1>
        </div>
        <div class = "ui container">       
            <div class = "ui vertical padded segment">
                <div class = "ui padded segment" style="font-size: 1.23em">
                    <div class="ui horizontal divider"><h2>Introduction</h2></div>
                    <p stype="color: red">[TODO]</p>
                    For the following tweet's reply, please rate its language structure and emotional orientation.
                </div>
                <%
                    out.print("<form class = \"ui form vertical segment\" action = \"test2.jsp?part=" + startpos + "&part_num="+part_num+"\" method = \"POST\">");
                %>
                <div class="ui segment"> 
                    <div class="ui horizontal divider"><h2>Info</h2></div>
                    <p style="font-size:1.23em">Tell Us About Yourself</p>
                    <div class="two fields">
                        <div class="field">
                        <label>Name</label>
                        <input placeholder="First Name" name="name" type="text" value="xx">                    
                        </div>
                        <div class="field">
                        <label>Age</label>
                        <input placeholder="" name="age" type="text" value="20">
                        </div>
                    </div>
                    <div class="two fields">
                    <div class="field">
                        <label>Occupation</label>
                        <input placeholder="" name="occupation" type="text" value="xx">
                        <%-- <select class="ui dropdown" name="occupation">
                            <option value="student">Student</option>
                            <option value="teacher">Teacher</option>
                            <option value="programmer">Programmer</option>
                            <option value="engineer">Engineer</option>
                            <option value="clerk">Office clerk</option>
                            <option value="others">Others</option>
                        </select> --%>
                    </div>
                    <div class="field">
                        <label>E-mail</label>
                        <input placeholder="example@gmail.com" name="email" type="text" value="xx">
                    </div>
                    </div>
                    
                    <div class="field">
                    <label>Gender</label>
                    <div class="ui fluid selection dropdown">
                        <input type="hidden" name="gender">
                        <div class="default text">Gender</div>
                        <i class="dropdown icon"></i>
                        <div class="menu">
                        <div class="item" data-value="1">Male</div>
                        <div class="item" data-value="0">Female</div>
                        </div>
                    </div>
                    </div>
                    <div class="inline field">
                    <%-- <fieldset> --%>
                        <%-- <label class="form-label">性别：</label> --%>
                        <label><input type="radio" name="gender" value="1" data-rule="checked">男</label>
                        <label><input type="radio" name="gender" value="2">女</label>
                        <label><input type="radio" name="gender" value="0">保密</label>
                    <%-- </fieldset> --%>
                    </div>
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
                    if(!conn.isClosed()){
                        sql = conn.createStatement();
                        for (int j = startpos; j < (startpos+part_num); j++) {
                            out.print("<div class=\"ui blue segment\">");
                            out.print("<div class=\"ui section"+(j+1)+" horizontal divider\"><h2>Section " + (j-startpos+1) + "/"+part_num+"</h2></div>");
                           
                            out.print("<div class=\"ui message\" style=\"font-size:"+font_size+"em\">");
                            out.print("<div class=\"header\">Post </div>");
                            rs = sql.executeQuery("select * from post limit "+j+",1");
                            while(rs.next()) {
                                out.print("<p style=\"font-size:"+font_size+"em\">"+rs.getString(1)+"</p>");
                            }
                            out.print("</div>");

                            out.print("<table class=\"ui celled structured compact table\">");
                            out.print("<thead>");
                            out.print("<tr>");
                            out.print("<th>Replies</th>");
                            out.print("<th>Evaluation on the content</th>");
                            out.print("</tr></thead>");
                            out.print("<tbody>");

                            out.print("<tr>");
                            // out.print("<td>Seq2Seq</td>");
                            rs = sql.executeQuery("select * from comment limit "+j+",1");
                            while(rs.next()) {
                                out.print("<td>"+rs.getString(1)+"</td>");
                            }
                            out.print("<td>");
                            out.print("<div class=\"inline fields\">");
                            for (int i = 0; i < rate_num; i++) {
                                out.print("<div class=\"field\">");
                                out.print("<div class=\"ui radio checkbox\">");
                                out.print("<input type=\"radio\" name=\"seqcontent"+j+"\" value=\"" + (i+1) + "\" data-rule=\"checked\">");
                                out.print("<label>" + (i+1) + "</label>");
                                out.print("</div>");
                                out.print("</div>");
                            }
                            out.print("</div>");
                            out.print("</td></tr>");
                            
                            out.print("<tr>");
                            // out.print("<td>Embedding</td>");
                            rs = sql.executeQuery("select * from comment limit "+j+",1");
                            while(rs.next()) {
                                out.print("<td>"+rs.getString(1)+"</td>");
                            }
                            out.print("<td>");
                            out.print("<div class=\"inline fields\">");
                            for (int i = 0; i < rate_num; i++) {
                                out.print("<div class=\"field\">");
                                out.print("<div class=\"ui radio checkbox\">");
                                out.print("<input type=\"radio\" name=\"emcontent"+j+"\" value=\"" + (i+1) + "\">");
                                out.print("<label>" + (i+1) + "</label>");
                                out.print("</div>");
                                out.print("</div>");
                            }
                            out.print("</div>");
                            out.print("</td></tr>");
                    
                            out.print("<tr>");
                            // out.print("<td rowspan=\"2\">ECM</td>");
                            rs = sql.executeQuery("select * from comment limit "+j+",1");
                            while(rs.next()) {
                                out.print("<td>"+rs.getString(1)+"</td>");
                            }
                            out.print("<td>");
                            out.print("<div class=\"inline fields\">");
                            for (int i = 0; i < rate_num; i++) {
                                out.print("<div class=\"field\">");
                                out.print("<div class=\"ui radio checkbox\">");
                                out.print("<input type=\"radio\" name=\"ecmcontentpos"+j+"\" value=\"" + (i+1) + "\">");
                                out.print("<label>" + (i+1) + "</label>");
                                out.print("</div>");
                                out.print("</div>");
                            }
                            out.print("</div>");
                            out.print("</td></tr>");
                            out.print("<tr>");
                            rs = sql.executeQuery("select * from comment limit "+j+",1");
                            while(rs.next()) {
                                out.print("<td>"+rs.getString(1)+"</td>");
                            }
                            out.print("<td>");
                            out.print("<div class=\"inline fields\">");
                            for (int i = 0; i < rate_num; i++) {
                                out.print("<div class=\"field\">");
                                out.print("<div class=\"ui radio checkbox\">");
                                out.print("<input type=\"radio\" name=\"ecmcontentneg"+j+"\" value=\"" + (i+1) + "\">");
                                out.print("<label>" + (i+1) + "</label>");
                                out.print("</div>");
                                out.print("</div>");
                            }
                            out.print("</div>");
                            out.print("</td></tr>");

                            out.print("<tr>");
                            // out.print("<td rowspan=\"4\">Ours</td>");
                            rs = sql.executeQuery("select * from comment limit "+j+",1");
                            while(rs.next()) {
                                out.print("<td>"+rs.getString(1)+"</td>");
                            }
                            out.print("<td>");
                            out.print("<div class=\"inline fields\">");
                            for (int i = 0; i < rate_num; i++) {
                                out.print("<div class=\"field\">");
                                out.print("<div class=\"ui radio checkbox\">");
                                out.print("<input type=\"radio\" name=\"ourscontenta"+j+"\" value=\"" + (i+1) + "\">");
                                out.print("<label>" + (i+1) + "</label>");
                                out.print("</div>");
                                out.print("</div>");
                            }
                            out.print("</div>");
                            out.print("</td></tr>");
                            out.print("<tr>");
                            rs = sql.executeQuery("select * from comment limit "+j+",1");
                            while(rs.next()) {
                                out.print("<td>"+rs.getString(1)+"</td>");
                            }
                            out.print("<td>");
                            out.print("<div class=\"inline fields\">");
                            for (int i = 0; i < rate_num; i++) {
                                out.print("<div class=\"field\">");
                                out.print("<div class=\"ui radio checkbox\">");
                                out.print("<input type=\"radio\" name=\"ourscontentb"+j+"\" value=\"" + (i+1) + "\">");
                                out.print("<label>" + (i+1) + "</label>");
                                out.print("</div>");
                                out.print("</div>");
                            }
                            out.print("</div>");
                            out.print("</td></tr>");
                            out.print("<tr>");
                            rs = sql.executeQuery("select * from comment limit "+j+",1");
                            while(rs.next()) {
                                out.print("<td>"+rs.getString(1)+"</td>");
                            }
                            out.print("<td>");
                            out.print("<div class=\"inline fields\">");
                            for (int i = 0; i < rate_num; i++) {
                                out.print("<div class=\"field\">");
                                out.print("<div class=\"ui radio checkbox\">");
                                out.print("<input type=\"radio\" name=\"ourscontentc"+j+"\" value=\"" + (i+1) + "\">");
                                out.print("<label>" + (i+1) + "</label>");
                                out.print("</div>");
                                out.print("</div>");
                            }
                            out.print("</div>");
                            out.print("</td></tr>");
                            out.print("<tr>");
                            rs = sql.executeQuery("select * from comment limit "+j+",1");
                            while(rs.next()) {
                                out.print("<td>"+rs.getString(1)+"</td>");
                            }
                            out.print("<td>");
                            out.print("<div class=\"inline fields\">");
                            for (int i = 0; i < rate_num; i++) {
                                out.print("<div class=\"field\">");
                                out.print("<div class=\"ui radio checkbox\">");
                                out.print("<input type=\"radio\" name=\"ourscontentd"+j+"\" value=\"" + (i+1) + "\">");
                                out.print("<label>" + (i+1) + "</label>");
                                out.print("</div>");
                                out.print("</div>");
                            }
                            out.print("</div>");
                            out.print("</td></tr>");
                            out.print("</tbody></table>");

                            out.print("<table class=\"ui celled compact table\">");
                            out.print("<thead>");
                            out.print("<tr>");
                            out.print("<th>Replies</th>");
                            out.print("<th>Which user says that?</th>");
                            out.print("<th>Emotion evaluation</th>");
                            out.print("</tr></thead>");
                            out.print("<tbody>");
                            for (int k = 0; k < user_num; k++) {
                                out.print("<tr>");
                                rs = sql.executeQuery("select * from comment limit "+j+",1");
                                while(rs.next()) {
                                    out.print("<td>"+rs.getString(1)+"</td>");
                                }
                                
                                out.print("<td>");
                                out.print("<div class=\"field\">");
                                out.print("<div class=\"ui fluid selection dropdown\">");
                                out.print("<input type=\"hidden\" name=\"section"+(j+1)+"reply"+(k+1)+"\">");
                                out.print("<div class=\"default text\" style=\"font-size: 1.23em\">Author</div>");
                                out.print("<i class=\"dropdown icon\"></i>");
                                out.print("<div class=\"menu\">");
                                for (int i = 0; i < user_num; i++) {
                                    out.print("<div class=\"item\" data-value=\""+(i+1)+"\">User&nbsp;"+(i+1)+"</div>");
                                }
                                out.print("</div></div></div></td>");    
                                
                            /*    out.print("<div class=\"inline fields\">");
                                for (int i = 0; i < user_num; i++) {
                                    out.print("<div class=\"field\">");
                                    out.print("<div class=\"ui radio checkbox\">");
                                    out.print("<input type=\"radio\" name=\"user"+j+"n"+k+"\" value=\"" + i + "\">");
                                    out.print("<label>User " + (i+1) + "</label>");
                                    out.print("</div>");
                                    out.print("</div>");
                                }
                                out.print("</div></td>");*/
                                
                                out.print("<td>");
                                out.print("<div class=\"inline fields\">");
                                for (int i = 0; i < rate_num; i++) {
                                    out.print("<div class=\"field\">");
                                    out.print("<div class=\"ui radio checkbox\">");
                                    out.print("<input type=\"radio\" name=\"emo"+j+"n"+k+"\" value=\"" + (i-2) + "\">");
                                    out.print("<label>" + (i-2) + "</label>");
                                    out.print("</div>");
                                    out.print("</div>");
                                }
                                out.print("</div>");


                                /*out.print("<div class=\"inline fields\">");
                                out.print("<div class=\"field\">");
                                out.print("<div class=\"ui radio checkbox\">");
                                out.print("<input type=\"radio\" name=\"emo"+j+"\" value=\"1\">");
                                out.print("<label>" + 1 + "</label>");
                                out.print("</div>");
                                out.print("</div>");
                                out.print("<div class=\"field\">");
                                out.print("<div class=\"ui radio checkbox\">");
                                out.print("<input type=\"radio\" name=\"emo"+j+"\" value=\"0\">");
                                out.print("<label>" + 0 + "</label>");
                                out.print("</div>");
                                out.print("</div>");
                                out.print("</div>");*/
                                out.print("</td></tr>");
                            }
                            out.print("</tbody></table>");

                            // out.print("<div class=\"ui segment\">");
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
                            // out.print("</div>");
                            out.print("</div></div>");
                        }
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

                <div class="ui error message"></div>
                <div class = "field">
                    <button class = "ui primary button">
                    Submit
                    </button>
                </div>
                </form>
            </div>
        </div>
        <script>
        $('.ui.form')
        .form({
            fields: {
            name: {
                identifier: 'name',
                rules: [
                {
                    type   : 'empty',
                    prompt : 'Please enter your name'
                }
                ]
            },
            age: {
                identifier: 'age',
                rules: [
                {
                    type   : 'empty',
                    prompt : 'Please enter your age'
                }
                ]
            },
            occupation: {
                identifier: 'occupation',
                rules: [
                {
                    type   : 'empty',
                    prompt : 'Please enter your occupation'
                }
                ]
            },
            email: {
                identifier: 'email',
                rules: [
                {
                    type   : 'empty',
                    prompt : 'Please enter your email'
                }
                ]
            }
            }
        })
        ;
        </script>
        <script>$('.ui.accordion').accordion();</script>
        <script>
        $('.ui.dropdown')
        .dropdown()
        ;
        $('.ui.form')
        .form({
            fields: {
            gender: 'empty',
            name: 'empty',
            }
        })
        ;
        $('.ui.form')
        .form({
            fields: {
            section1reply1: 'empty',
            // name: 'empty',
            seqcontent1: 'empty'
            }
        })
        ;
        </script>
    </body>
</html>