<%-- this is used to transfor information from client to server. --%>
<%-- version 3.0 2018.02.04 --%>
<%@page contentType="text/html;charset=utf-8" import="java.sql.*" %>
<%
int startpos =  Integer.parseInt(request.getParameter("part")); // startpos
int part_num = Integer.parseInt(request.getParameter("part_num")); // howmanny sections
int endpos = startpos + part_num;
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
                    <%-- <div> --%>
                    <%-- <img src="pikaq.png"> --%>
                    <%-- </div> --%>
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
                        //out.print("part = " +part+" ; part_num = "+part_num+"\n");
                        String name = "";
                        String occupation = "";
                        String email = "";
                        String gender = "";
                        int age = 20;
                        if (request.getParameter("name") != null) {
                            name = request.getParameter("name");
                            age = Integer.parseInt(request.getParameter("age"));
                            occupation = request.getParameter("occupation");
                            email = request.getParameter("email");
                            // gender = request.getParameter("gender");
                            out.print("<script>console.log(\"");
                            out.print("<p>测试数据:</p>");
                            out.print("name = "+name+"\n");
                            out.print("age = "+age+"\n");
                            out.print("occupation = "+occupation+"\n");
                            out.print("email = "+email+"\n");
                            // out.print("gender = "+gender+"\n");
                            out.print("insert into participant values('"+name+"',"+age+",'"+occupation+"','"+email+"');\n");
                            sql.execute("insert into participant values('"+name+"',"+age+",'"+occupation+"','"+email+"');");
                        } else {
                            //out.print("#$%$@%^%$@^!!@#@\n");
                        }

                        // out.print("!#%%^&!@$#^%%^*!@#@#%#$^#$^%$\n");
                        // seqcontentj, emcontentj, ecmcontentposj, ecmcontentnegj, ourscontent1j,ouscontent2j
                        // ourscontent3j, ourcontent4j, userknj, emoknj, emohiddenknj
                         
                        for (int j = startpos; j <= endpos; j++) {
                            out.print("start-\n");
                            String content[] = {"seqcontent"+j, "emcontent"+j,
                                                "ecmcontentpos"+j, "ecmcontentneg"+j,
                                                "ourscontent1"+j, "ourscontent2"+j,
                                                "ourscontent3"+j, "ourscontent4"+j};
                            String table[] = {
                                "seqcontent", "emcontent", "ecmcontentpos", "ecmcontentneg",
                                "ourscontent", "ourscontent","ourscontent","ourscontent"
                            };
                            int value = 0;
                            for (int i = 0; i < 8; i++) {
                                if (request.getParameter(content[i]) != null) {
                                    value = Integer.parseInt(request.getParameter(content[i]));
                                    out.print(content[i] + " = "+value+" \n");
                                    out.print("insert into "+table[i]+" values("+value+","+j+",'"+name+"');");
                                    sql.execute("insert into "+table[i]+" values("+value+","+j+",'"+name+"');");
                                    // insert [table] value, id, name;
                                }
                            }
                            
                            for (int i = 0; i < 4; i++) {
                                // 统计对统一post随即选取的用户的userstyle的准确度，value=1, 答案正确，value=0, 答案错误
                                if (request.getParameter("user"+i+"n"+j) != null) {
                                    value = Integer.parseInt(request.getParameter("user"+i+"n"+j));
                                    out.print("user"+i+"n"+j+" = "+value+"\n");
                                    // insert value, id, name;
                                    out.print("insert into oursuser values("+value+","+j+",'"+name+"');");
                                    sql.execute("insert into oursuser values("+value+","+j+",'"+name+"');");
                                }
                                // 对随即选出的reply的情感统计5分档，同时记录正确答案。
                                if (request.getParameter("emo"+i+"n"+j) != null) {
                                    // 五分打分
                                    value = Integer.parseInt(request.getParameter("emo"+i+"n"+j));
                                    out.print("emo"+i+"n"+j+" = "+value+"<br>");
                                    int ans = Integer.parseInt(request.getParameter("emohidden"+i+"n"+j));
                                    // insert value, id, i, name; i表示第j部分的第i个reply
                                    sql.execute("insert into useremo values("+value+","+ans+","+j+",'"+name+"');");
                                }
                            }
                        }
                        out.print("the end.");
                        out.print("\");</script>");
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