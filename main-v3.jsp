<%@page contentType="text/html;charset=utf-8" import="java.sql.*" %>
<%
    int part = Integer.parseInt(request.getParameter("part"));
    int left = 200-part;
    int user_num = 4;
    int rate_num = 3;
    int part_num = Integer.parseInt(request.getParameter("part_num"));
    String name = request.getParameter("name");
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
            <h1 class="ui inverted header" style="margin-left:20px">Survey</h1>
        </div>
        <div class = "ui container">       
            <div class = "ui vertical padded segment">
                <div class = "ui padded segment">
                    For the following tweet's reply, please rate its language structure and emotional orientation.
                </div>
                <%
                    out.print("<form class = \"ui form segment\" action = \"test2.jsp?part=" + (part+part_num) + "&part_num="+part_num+"&name="+name+"\" method = \"POST\">");
                %>
                <div class="ui small header"> This survey has 200 parts, you have finished <%=part%> parts, <%=left%> to go. </div>
                <div class="ui progress" data-value="<%=part %>" data-total="200" id="example6">
                <div class="bar">
                    <div class="progress"></div>
                </div>
                <%-- <div class="label">Carga de archivos</div> --%>
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
                        for (int j = 0; j < part_num; j++) {
                            out.print("<a class=\"ui blue ribbon label\">Part &nbsp;" + (j+1) + "</a>");
                            out.print("<div class = \"ui segments\">");
                            // seq2seq
                            out.print("<h3 class=\"ui top attached header\">Seq2Seq</h3>");
                            out.print("<div class = \"ui blue segment seq\">");
                            out.print("<div class=\"ui vertical padded segment\">");
                                out.print("<h3 class=\"ui header\">Post</h3>");
                                sql = conn.createStatement();
                                rs = sql.executeQuery("select * from post limit "+j+",1");
                                while(rs.next()) {
                                    out.print("<h4>"+rs.getString(1)+"</h4>");
                                }
                                out.print("<div class=\"ui section divider\"></div>");
                                out.print("<h3 class=\"ui header\">Reply</h3>");
                                rs = sql.executeQuery("select * from comment limit "+j+",1");
                                while(rs.next()) {
                                    out.print("<h4>"+rs.getString(1)+"</h4>");
                                }
                            out.print("</div>");
                            out.print("<div class=\"ui vertical padded segment\">");
                                out.print("<div class=\"ui form\">");
                                    out.print("<div class=\"grouped fields\">");
                                        out.print("<h3 class=\"ui header\">Evaluate the syntax and fluency of the above reply.</h3>");
                                        for (int i = 0; i < rate_num; i++) {
                                            out.print("<div class=\"field\">");
                                            out.print("<div class=\"ui radio checkbox\">");
                                            out.print("<input type=\"radio\" id = \"part1\" name=\"seqfluency"+j+"\" value=\"" + i + "\">");
                                            out.print("<label>" + i + "</label>");
                                            out.print("</div>");
                                            out.print("</div>");
                                        }
                                    out.print("</div>");
                                    out.print("<div class=\"grouped fields\">");
                                        out.print("<h3 class=\"ui header\">Evaluate the logical relationship between the tweet and reply.</h3>");
                                        for (int i = 0; i < rate_num; i++) {
                                            out.print("<div class=\"field\">");
                                            out.print("<div class=\"ui radio checkbox\">");
                                            out.print("<input type=\"radio\" id = \"part1\" name=\"seqlogical"+j+"\" value=\"" + i + "\">");
                                            out.print("<label>" + i + "</label>");
                                            out.print("</div>");
                                            out.print("</div>");
                                        }
                                    out.print("</div>");
                                    out.print("<div class=\"grouped fields\">");
                                        out.print("<h3 class=\"ui header\">Please choose the emotional orientation of the reply.</h3>");
                                        out.print("<div class\"field\">");
                                            out.print("<div class=\"ui radio checkbox\">");
                                            out.print("<input type=\"radio\" name=\"seqemotion"+j+"\" value=\"1\">");
                                            out.print("<label>Positive</label>");
                                            out.print("</div>");
                                        out.print("</div>");
                                        out.print("<div class\"field\">");
                                            out.print("<div class=\"ui radio checkbox\">");
                                            out.print("<input type=\"radio\" name=\"seqemotion"+j+"\" value=\"0\">");
                                            out.print("<label>Negative</label>");
                                            out.print("</div>");
                                        out.print("</div>");
                                    out.print("</div>");
                                out.print("</div>");
                            out.print("</div>");
                            out.print("</div>");
                            for (int q = 0; q < 3; q++) {
                            // Embedding, ECM, Ours
                            String algorithm = ""; String table = "";
                            if(q==0) {algorithm = "Embedding"; table = "em";}
                            else if (q==1) {algorithm = "ECM"; table = "ecm";}
                            else if (q==2) {algorithm = "Ours"; table = "our";}
                            out.print("<h3 class=\"ui top attached header\">"+algorithm+"</h3>");
                            out.print("<div class = \"ui blue segment\">");
                            out.print("<div class=\"ui vertical padded segment\">");
                                out.print("<h3 class=\"ui header\">Post</h3>");
                                sql = conn.createStatement();
                                rs = sql.executeQuery("select * from post limit "+j+",1");
                                while(rs.next()) {
                                    out.print("<h4>"+rs.getString(1)+"</h4>");
                                }
                                out.print("<div class=\"ui section divider\"></div>");
                                out.print("<h3 class=\"ui header\">Reply 1</h3>");
                                rs = sql.executeQuery("select * from comment limit "+j+",1");
                                while(rs.next()) {
                                    out.print("<h4>"+rs.getString(1)+"</h4>");
                                }
                                out.print("<h3 class=\"ui header\">Reply 2</h3>");
                                rs = sql.executeQuery("select * from comment limit "+j+",1");
                                while(rs.next()) {
                                    out.print("<h4>"+rs.getString(1)+"</h4>");
                                }
                            out.print("</div>");
                            out.print("<div class=\"ui vertical padded segment\">");
                                out.print("<div class=\"ui form\">");
                                    out.print("<div class=\"grouped fields\">");
                                        out.print("<h3 class=\"ui header\">Evaluate the syntax and fluency of the above replies.</h3>");
                                        out.print("<div class=\"ui horizontal segments\">");
                                        for (int k = 0; k < 2; k++) {
                                            out.print("<div class=\"ui segment\">");
                                            out.print("<div class=\"ui small header\">Reply" + (k+1) + "</div>");
                                            for (int i = 0; i < rate_num; i++) {
                                                out.print("<div class=\"field\">");
                                                out.print("<div class=\"ui radio checkbox\">");
                                                out.print("<input type=\"radio\" name=\""+table+"fluency"+j+"v"+k+"\" value=\"" + i + "\">");
                                                out.print("<label>" + i + "</label>");
                                                out.print("</div>");
                                                out.print("</div>");
                                            }
                                            out.print("</div>");
                                        }
                                        out.print("</div>");
                                    out.print("</div>");
                                    out.print("<div class=\"grouped fields\">");
                                        out.print("<h3 class=\"ui header\">Evaluate the logical relationship between the tweet and replies.</h3>");
                                        out.print("<div class=\"ui horizontal segments\">");
                                        for (int k = 0; k < 2; k++) {
                                            out.print("<div class=\"ui segment\">");
                                            out.print("<div class=\"ui small header\">Reply" + (k+1) + "</div>");
                                            for (int i = 0; i < rate_num; i++) {
                                            out.print("<div class=\"field\">");
                                            out.print("<div class=\"ui radio checkbox\">");
                                            out.print("<input type=\"radio\" name=\""+table+"logical"+j+"v"+k+"\" value=\"" + i + "\">");
                                            out.print("<label>" + i + "</label>");
                                            out.print("</div>");
                                            out.print("</div>");
                                            }
                                            out.print("</div>");
                                        }
                                        out.print("</div>");
                                    out.print("</div>");
                                    out.print("<div class=\"grouped fields\">");
                                        out.print("<h3 class=\"ui header\">Please choose the emotional orientation of the replies.</h3>");
                                        out.print("<div class=\"ui horizontal segments\">");
                                        for (int k = 0; k < 2; k++) {
                                            out.print("<div class=\"ui segment\">");
                                            out.print("<div class=\"ui small header\">Reply"+(k+1)+"</div>");
                                            out.print("<div class\"field\">");
                                                out.print("<div class=\"ui radio checkbox\">");
                                                out.print("<input type=\"radio\" name=\""+table+"emotion"+j+"v"+k+"\" value=\"1\">");
                                                out.print("<label>Positive</label>");
                                                out.print("</div>");
                                            out.print("</div>");
                                            out.print("<div class\"field\">");
                                                out.print("<div class=\"ui radio checkbox\">");
                                                out.print("<input type=\"radio\" name=\""+table+"emotion"+j+"v"+k+"\" value=\"0\">");
                                                out.print("<label>Negative</label>");
                                                out.print("</div>");
                                            out.print("</div>");
                                            out.print("</div>");
                                        }
                                        out.print("</div>");
                                    out.print("</div>");
                                out.print("</div>");
                            out.print("</div>");
                            out.print("</div>");
                            }
                                                        out.print("<h3 class=\"ui top attached header\">User Style</h3>");
                            out.print("<div class = \"ui blue segment\">");
                                out.print("<div class=\"ui vertical segment\">");
                                    out.print("<h3 class=\"ui header\">Post</h3>");
                                    sql = conn.createStatement();
                                    rs = sql.executeQuery("select * from post limit 0,1");
                                    while(rs.next()) {
                                        out.print("<h4>"+rs.getString(1)+"</h4>");
                                    }
                                    out.print("<div class=\"ui section divider\"></div>");
                                    for (int i = 0; i < user_num; i++) {
                                        out.print("<h3 class=\"ui header\">Reply "+(i+1)+"</h3>");
                                        rs = sql.executeQuery("select * from comment limit "+i+",1");
                                        while(rs.next()) {
                                            out.print("<h4>"+rs.getString(1)+"</h4>");
                                        }
                                    }
                                out.print("</div>");
                                out.print("<div class=\"ui vertical segment\">");
                                    out.print("<div class=\"ui form\">");
                                        out.print("<h3 class=\"ui header\">Please select the user with the closest language style. </h3>");
                                        out.print("<div class=\"ui horizontal segments\">");
                                        for (int k = 0; k < user_num; k++) {
                                            out.print("<div class=\"ui segment\">");
                                            out.print("<div class=\"ui small header\">Reply"+(k+1)+"</div>");
                                            out.print("<div class=\"grouped fields\">");
                                            for (int i = 0; i < user_num; i++){
                                                out.print("<div class\"field\">");
                                                out.print("<div class=\"ui radio checkbox\">");
                                                out.print("<input type=\"radio\" name=\"user_reply"+(k+1)+"v"+j+"\" value=\"" + (i+1) + "\">");
                                                out.print("<label>User "+ (i+1) +"</label>");
                                                out.print("</div>");
                                                out.print("</div>");
                                            }
                                            out.print("</div>");
                                            out.print("</div>");
                                        }
                                        out.print("</div>");
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
                            out.print("</div>");
                            out.print("</div>");
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
                    Next page
                    </button>
                </div>
                </form>
            </div>
        </div>
        <script>$('.ui.accordion').accordion();</script>
        <script>
        $('#example6')
        .progress('increment')
        ;
        </script>
    </body>
</html>