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
                        int age = 20;
                        if (request.getParameter("name") != null) {
                            name = request.getParameter("name");
                        }
                        if (request.getParameter("age") != null) {
                            age = Integer.parseInt(request.getParameter("age"));
                            occupation = request.getParameter("occupation");
                            email = request.getParameter("email");
                            /*out.print("name = "+name+"<br>");
                            out.print("age = "+age+"<br>");
                            out.print("occupation = "+occupation+"<br>");
                            out.print("email = "+email+"<br>");
                            out.print("insert into participant values('"+name+"',"+age+",'"+occupation+"','"+email+"');");*/
                            sql.execute("insert into participant values('"+name+"',"+age+",'"+occupation+"','"+email+"');");
                        } else {
                            //out.print("#$%$@%^%$@^!!@#@<br>");
                        }
                        //out.print("!#%%^&!@$#^%%^*!@#@#%#$^#$^%$<br>");
                        String table[] = {"seq","em","ecm","our"};
                        String term[] = {"fluency","logical","emotion"}; 
                        for (int j = part-part_num; j < part; j++) {
                            String pname = "";
                            int seq[] = new int[3];
                            for (int i = 0; i < 3; i++) {
                                pname = table[0] + term[i] + "" + j;
                                if (request.getParameter(pname) != null) {
                                    seq[i] = Integer.parseInt(request.getParameter(pname));
                                } else {
                                    seq[i] = 1;
                                }
                                //out.print(pname+"="+seq[i]+"<br>");
                            }
                            sql.execute("insert into seq values("+seq[0]+","+seq[1]+","+seq[2]+","+j+",'"+name+"');");
                            int res0[] = new int[3]; // result for em,ecm,our
                            int res1[] = new int[3];
                            for (int k = 1; k < 4; k++) {
                                for (int i = 0; i < 3; i++) {
                                    pname = table[k] + term[i] + "" + j;
                                    String sname = pname + "v0";
                                    if (request.getParameter(sname) != null) {
                                        res0[i] = Integer.parseInt(request.getParameter(sname));
                                    } else {
                                        res0[i] = 0;
                                    }
                                    //out.print(sname+"="+res0[i]+"<br>");
                                    sname = pname + "v1";
                                    if (request.getParameter(sname) != null) {
                                        res1[i] = Integer.parseInt(request.getParameter(sname));
                                    } else {
                                        res1[i] = 1;
                                    }
                                    //out.print(sname+"="+res1[i]+"<br>");
                                }
                                if (k==1) {
                                    sql.execute("insert into em0 values("+res0[0]+","+res0[1]+","+res0[2]+","+j+",'"+name+"');");
                                    sql.execute("insert into em1 values("+res1[0]+","+res1[1]+","+res1[2]+","+j+",'"+name+"');");
                                }
                                if (k==2) {
                                    sql.execute("insert into ecm0 values("+res0[0]+","+res0[1]+","+res0[2]+","+j+",'"+name+"');");
                                    sql.execute("insert into ecm1 values("+res1[0]+","+res1[1]+","+res1[2]+","+j+",'"+name+"');");
                                }
                                if (k==3) {
                                    sql.execute("insert into our0 values("+res0[0]+","+res0[1]+","+res0[2]+","+j+",'"+name+"');");
                                    sql.execute("insert into our1 values("+res1[0]+","+res1[1]+","+res1[2]+","+j+",'"+name+"');");
                                }
                            }
                            for (int k = 1; k <= user_num; k++) {
                                String str = "user_reply"+k+"v"+j;
                                int userreply = 0;
                                if (request.getParameter(str) != null) {
                                    userreply = Integer.parseInt(request.getParameter(str));
                                }
                                if (userreply == k) { // assume this order is the right answer for now
                                    sql.execute("insert into userstyle values (" + j + ",1,'"+name+"');");
                                } else {
                                    sql.execute("insert into userstyle values (" + j + ",0,'"+name+"');");
                                }
                            }
                        }
                        if (part < 200) {
                            out.print("redirect..."+part);
                            String site = new String("main.jsp?part="+part+"&part_num="+part_num+"&name="+name);
                            response.setStatus(response.SC_MOVED_TEMPORARILY);
                            response.setHeader("Location", site); 
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
            
            <%-- <%
                String driver = "com.mysql.jdbc.Driver"; 
                String url = "jdbc:mysql://localhost:3306/tomcat"; //数据库web
                String user = "tomcat"; 
                String password = "123456"; 
                try { 
                    Class.forName(driver); 
                    Connection conn = DriverManager.getConnection(url, user, password);
                    Statement sql;
                    ResultSet rs;
                    int score = Integer.parseInt(request.getParameter("score"));
                    int emotion = Integer.parseInt(request.getParameter("emotion"));
                    int users = Integer.parseInt(request.getParameter("user"));
                    if(!conn.isClosed()){
                        sql = conn.createStatement();
                        sql.execute("insert into result values(" + score + "," + emotion + "," + users +");");
                        out.print("Successfully!");
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
            %> --%>
        </div>
        <script>
        $('.value')
         .transition('jiggle')
        ;
        </script>
    </body>
</html>