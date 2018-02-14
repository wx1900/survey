<%@page contentType="text/html;charset=utf-8" import="java.sql.*" %>
<%
    int page_num = 0; // 第几份问卷
    int startpos = 0; // 问卷从第几个post开始
    int part_num = 10; // 一份问卷有几个post
    int user_num = 4; // user style 一次评测几个用户
    int rate_num = 5; // 评测等级有几个
    double font_size = 1.23;
    if (request.getParameter("page") != null) 
        page_num = Integer.parseInt(request.getParameter("page"));
    startpos = page_num * part_num;
%>
<html>
    <head>
        <link href="third-party/semantic.css" rel="stylesheet" type="text/css">
        <script src="third-party/jquery-3.1.1.min.js"></script>
        <script src="third-party/semantic.js"></script>
        <title>Survey</title>
        <style type="text/css">
            body,td,th,div {font-size: 1.23em;color: #1d1007; line-height:24px} 
            .ui {font-size: 1.23em}
            .container.segment {font-size: 1.23em}
        </style>
        <script>
        console.log("更新说明：\n (1) 添加表单验证\n (2) 统一修改字体符号为1.23em\n (3) 评价等级修改为5级\n (4) TODO: Introduction 和 添加中文版说明");
        </script>
    </head>
    <body>
        <%-- <script>console.log("test");</script> --%>
        <div class = "ui blue inverted vertical segment">
            <h1 class="ui inverted header" style="margin-left:20px">Survey</h1>
        </div>
        <div class = "ui container">       
            <div class = "ui vertical padded segment">
                <div class = "ui padded segment" style="font-size: 1.23em">
                    <div class="ui horizontal divider"><h2>Introduction</h2></div>
                    The purpose of this questionnaire is to evaluate the machine-generated comments for given post. This evaluation includes three aspects:
                    <ul>
                    <li>content (fluency, grammar, relevence, etc.), rate from 1 (poor) to 5 (good).</li>
                    <li>emotional Polarity, rate from -2 (very opposing) to 2 (very supportive).</li>
                    <li>personalized linguistic style, select from User 1 to User 4, with 20 historical tweets from each user as reference. </li>
                    </ul>
                
                   本调查问卷的目的是评估给定推文的由机器自动生成的评论。 这个评估包括三个方面：
                    <ul>
                    <li>内容（流畅性，语法，相关性等），分数从1（差）到5（好）。</li>
                    <li>情绪表达，分数从-2（最反对）到2（最支持）。</li>
                    <li>个性化的语言风格，参照每个用户的20条历史推文，从用户1到用户4中选择评论者。</li>
                    </ul>
                    </div>
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
                        <input placeholder="Name" name="name" type="text" value="">                    
                        </div>
                        <div class="field">
                        <label>Age</label>
                        <input placeholder="" name="age" type="text" value="">
                        </div>
                    </div>
                    <div class="two fields">
                    <div class="field">
                        <label>Occupation</label>
                        <input placeholder="" name="occupation" type="text" value="">
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
                        <input placeholder="example@gmail.com" name="email" type="text" value="">
                    </div>
                    </div>
                    
                    <%-- <div class="field">
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
                    </div> --%>
                
                </div>
                <div class="ui blue segment">
                <%-- <img src = "intro.jpg"> --%>
                <img class="ui image" src="intro.jpg">
                </div>
                                <% 
                /*String driver = "com.mysql.jdbc.Driver"; 
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
                            out.print("<div class=\"ui blue segment\">");
                            out.print("<div class=\"ui horizontal divider\"><h2>Section 0 (Example)</h2></div>");
                           
                            out.print("<div class=\"ui message\" style=\"font-size:"+font_size+"em\">");
                            out.print("<div class=\"header\">Post </div>");
                            rs = sql.executeQuery("select * from post limit 0,1");
                            while(rs.next()) {
                                out.print("<p style=\"font-size:"+font_size+"em\">"+rs.getString(1)+"</p>");
                            }
                            out.print("</div>");

                            out.print("<table class=\"ui celled structured compact table\">");
                            out.print("<thead>");
                            out.print("<tr>");
                            out.print("<th>Comments</th>");
                            out.print("<th>Content (fluency, grammar, etc.), 1 (poor) to 5 (good)</th>");
                            out.print("</tr></thead>");
                            out.print("<tbody>");

                            out.print("<tr>");
                            // out.print("<td>Seq2Seq</td>");
                            rs = sql.executeQuery("select * from seqreply limit 0,1");
                            while(rs.next()) {
                                out.print("<td>"+rs.getString(1)+"</td>");
                            }
                            out.print("<td>");
                            out.print("<div class=\"inline fields\">");
                            
                            for (int i = 0; i < rate_num; i++) {
                                String checked = "";
                                out.print("<div class=\"field\">");
                                out.print("<div class=\"ui radio checkbox\">");
                                if (i==0)  out.print("<input type=\"radio\" name=\"seqcontent\" value=\"" + (i+1) + "\" checked=\""+checked+"\">");
                                else out.print("<input type=\"radio\" name=\"seqcontent\" value=\"" + (i+1) + "\">");
                                out.print("<label>" + (i+1) + "</label>");
                                out.print("</div>");
                                out.print("</div>");
                            }
                            out.print("</div>");
                            out.print("</td></tr>");
                            
                            out.print("<tr>");
                            // out.print("<td>Embedding</td>");
                            rs = sql.executeQuery("select * from emreply limit 0,1");
                            while(rs.next()) {
                                out.print("<td>"+rs.getString(1)+"</td>");
                            }
                            out.print("<td>");
                            out.print("<div class=\"inline fields\">");
                            
                            for (int i = 0; i < rate_num; i++) {
                                String checked = "";
                                out.print("<div class=\"field\">");
                                out.print("<div class=\"ui radio checkbox\">");
                                if (i == 3) out.print("<input type=\"radio\" name=\"emcontent\" value=\"" + (i+1) + "\" checked=\"checked\">");
                                else out.print("<input type=\"radio\" name=\"emcontent\" value=\"" + (i+1) + "\">");
                                out.print("<label>" + (i+1) + "</label>");
                                out.print("</div>");
                                out.print("</div>");
                            }
                            out.print("</div>");
                            out.print("</td></tr>");
                    
                            out.print("<tr>");
                            // out.print("<td rowspan=\"2\">ECM</td>");
                            rs = sql.executeQuery("select * from ecmreplypos limit 0,1");
                            while(rs.next()) {
                                out.print("<td>"+rs.getString(1)+"</td>");
                            }
                            out.print("<td>");
                            out.print("<div class=\"inline fields\">");
                        
                            for (int i = 0; i < rate_num; i++) {
                                String checked = "";
                                out.print("<div class=\"field\">");
                                out.print("<div class=\"ui radio checkbox\">");
                                if (i == 2) out.print("<input type=\"radio\" name=\"ecmcontentpos\" value=\"" + (i+1) + "\" checked=\""+checked+"\">");
                                else out.print("<input type=\"radio\" name=\"ecmcontentpos\" value=\"" + (i+1) + "\">");
                                out.print("<label>" + (i+1) + "</label>");
                                out.print("</div>");
                                out.print("</div>");
                            }
                            out.print("</td></tr>");
                            out.print("<tr>");
                            rs = sql.executeQuery("select * from ecmreplyneg limit 0,1");
                            while(rs.next()) {
                                out.print("<td>"+rs.getString(1)+"</td>");
                            }
                            out.print("<td>");
                            out.print("<div class=\"inline fields\">");
                            
                            for (int i = 0; i < rate_num; i++) {
                                String checked = "";
                                out.print("<div class=\"field\">");
                                out.print("<div class=\"ui radio checkbox\">");
                                if (i == 3) out.print("<input type=\"radio\" name=\"ecmcontentneg\" value=\"" + (i+1) + "\" checked=\""+checked+"\">");
                                else out.print("<input type=\"radio\" name=\"ecmcontentneg\" value=\"" + (i+1) + "\">");
                                out.print("<label>" + (i+1) + "</label>");
                                out.print("</div>");
                                out.print("</div>");
                            }
                            out.print("</div>");
                            out.print("</td></tr>");

                            /*
                            out.print("<script> console.log(\"Section 0\");</script>");
                            int order[] = new int[4];
                            int orderemo[] = new int[4];
                            for (int k = 0; k < user_num; k++) {
                                double rand = Math.random();
                                if (rand < 0.25) order[k] = 1;
                                else if (rand < 0.5) order[k] = 2;
                                else if (rand < 0.75) order[k] = 3;
                                else order[k] = 4;
                                out.print("<script>console.log(\"order ["+(k+1)+"] = "+order[k]+"\");</script>");
                            }
                            for (int k = 0; k < user_num; k++) {
                                double rand = Math.random();
                                if (rand < 0.5) orderemo[k] = 0;
                                else orderemo[k] = 1;
                                out.print("<script>console.log(\"orderemo ["+(k+1)+"] = "+orderemo[k]+"\");</script>");
                            }*/
                            
                            // String 
                           /* String user_reply[] = new String[4];
                            for (int k = 0; k < user_num; k++) {
                                String table = "userpos";
                                if (orderemo[k] == 0)
                                    table = "userneg";
                                rs = sql.executeQuery("select * from "+table+" limit " + (order[k]) + ",1");
                                while(rs.next()) {
                                    user_reply[k] = rs.getString(1);
                                }
                                out.print("<script>console.log(\""+user_reply[k]+"\");</script>");
                            }*/
/*
                            for (int k = 0; k < user_num; k++) {
                                out.print("<tr>");
                                out.print("<td>"+user_reply[k]+"</td>");
                                out.print("<td>");
                                out.print("<div class=\"inline fields\">");
                                
                                for (int i = 0; i < rate_num; i++) {
                                    out.print("<div class=\"field\">");
                                    out.print("<div class=\"ui radio checkbox\">");
                                    if (i == 4){if(k == 3) out.print("<input type=\"radio\" name=\"ourscontent"+(k)+"\" value=\"" + (i+1) + "\" checked=\"checked\">");
                                    }else if (i == 2){if(k == 2) out.print("<input type=\"radio\" name=\"ourscontent"+(k)+"\" value=\"" + (i+1) + "\" checked=\"checked"\">");
                                    }else if (i==1 & k ==1)out.print("<input type=\"radio\" name=\"ourscontent"+(k)+"\" value=\"" + (i+1) + "\" checked=\"checked"\">");
                                    else if (i==3 & k ==0)out.print("<input type=\"radio\" name=\"ourscontent"+(k)+"\" value=\"" + (i+1) + "\" checked=\"checked"\">");
                                    else out.print("<input type=\"radio\" name=\"ourscontent"+(k)+"\" value=\"" + (i+1) + "\">");
                                    out.print("<label>" + (i+1) + "</label>");
                                    out.print("</div>");
                                    out.print("</div>");
                                }
                                out.print("</div>");
                                out.print("</td></tr>");
                            }*/
                           /* out.print("<tr>");
                            rs = sql.executeQuery("select * from userpos limit 0,1");
                            while(rs.next()) {
                                out.print("<td>"+rs.getString(1)+"</td>");
                            }
                            out.print("<td>");
                            out.print("<div class=\"inline fields\">");
                            for (int i = 0; i < rate_num; i++) {
                                out.print("<div class=\"field\">");
                                out.print("<div class=\"ui radio checkbox\">");
                                if (i == 3) out.print("<input type=\"radio\" name=\"ourscont\" value=\"" + (i+1) + "\" checked=\"checked\">");
                                else out.print("<input type=\"radio\" name=\"ourscont\" value=\"" + (i+1) + "\">");
                                out.print("<label>" + (i+1) + "</label>");
                                out.print("</div>");
                                out.print("</div>");
                            }
                            out.print("</div>");
                            out.print("</td></tr>");
                            out.print("<tr>");
                            rs = sql.executeQuery("select * from userpos limit 3,1");
                            while(rs.next()) {
                                out.print("<td>"+rs.getString(1)+"</td>");
                            }
                            out.print("<td>");
                            out.print("<div class=\"inline fields\">");
                            for (int i = 0; i < rate_num; i++) {
                                out.print("<div class=\"field\">");
                                out.print("<div class=\"ui radio checkbox\">");
                                if (i == 3) out.print("<input type=\"radio\" name=\"oursconten\" value=\"" + (i+1) + "\" checked=\"checked\">");
                                else out.print("<input type=\"radio\" name=\"oursconten\" value=\"" + (i+1) + "\">");
                                out.print("<label>" + (i+1) + "</label>");
                                out.print("</div>");
                                out.print("</div>");
                            }
                            out.print("</div>");
                            out.print("</td></tr>");
                            out.print("<tr>");
                            rs = sql.executeQuery("select * from userneg limit 5,1");
                            while(rs.next()) {
                                out.print("<td>"+rs.getString(1)+"</td>");
                            }
                            out.print("<td>");
                            out.print("<div class=\"inline fields\">");
                            for (int i = 0; i < rate_num; i++) {
                                out.print("<div class=\"field\">");
                                out.print("<div class=\"ui radio checkbox\">");
                                if (i == 2) out.print("<input type=\"radio\" name=\"oursconte\" value=\"" + (i+1) + "\" checked=\"checked\">");
                                else out.print("<input type=\"radio\" name=\"oursconte\" value=\"" + (i+1) + "\">");
                                out.print("<label>" + (i+1) + "</label>");
                                out.print("</div>");
                                out.print("</div>");
                            }
                            out.print("</div>");
                            out.print("</td></tr>");
                            out.print("<tr>");
                            rs = sql.executeQuery("select * from userpos limit 7,1");
                            while(rs.next()) {
                                out.print("<td>"+rs.getString(1)+"</td>");
                            }
                            out.print("<td>");
                            out.print("<div class=\"inline fields\">");
                            for (int i = 0; i < rate_num; i++) {
                                out.print("<div class=\"field\">");
                                out.print("<div class=\"ui radio checkbox\">");
                                if (i == 4) out.print("<input type=\"radio\" name=\"oursco\" value=\"" + (i+1) + "\" checked=\"checked\">");
                                else out.print("<input type=\"radio\" name=\"oursco\" value=\"" + (i+1) + "\">");
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
                            out.print("<th>Comments</th>");
                            out.print("<th style=\"width:10em\">Commentator</th>");
                            out.print("<th>Emotional Polarity, -2 (very opposing) to 2 (very supportive)</th>");
                            out.print("</tr></thead>");
                            out.print("<tbody>");
                                
                                out.print("<tr>");
                                rs = sql.executeQuery("select * from userpos limit 0,1");
                                while(rs.next()) {
                                    out.print("<td>"+rs.getString(1)+"</td>");
                                }                              
                                out.print("<td>");
                                out.print("<div class=\"compact field\">");
                                out.print("<select name=\"user\">");
                                out.print("<option value>Select...</option>");
                                out.print("<option value=\"a"+(1)+"\">User "+(1)+"</option>");
                                out.print("<option value=\"a"+(2)+"\">User "+(2)+"</option>");
                                out.print("<option value=\"a"+(3)+"\">User "+(3)+"</option>");
                                out.print("<option value=\"a"+(4)+"\" selected=\"selected\">User "+(4)+"</option>");
                                out.print("</select></div></td>");
                                
                                out.print("<td>");
                                out.print("<div class=\"inline fields\">");
                                
                                out.print("<div class=\"field\">");
                                out.print("<div class=\"ui radio checkbox\">");
                                out.print("<input type=\"radio\" name=\"emoa\" value=\"" + (-2) + "\">");
                                out.print("<label>" + (-2) + "</label>");
                                out.print("</div>");
                                out.print("</div>");
                                
                                out.print("<div class=\"field\">");
                                out.print("<div class=\"ui radio checkbox\">");
                                out.print("<input type=\"radio\" name=\"emoa\" value=\"" + (-1) + "\" checked=\"checked\">");
                                out.print("<label>" + (-1) + "</label>");
                                out.print("</div>");
                                out.print("</div>");
                                
                                out.print("<div class=\"field\">");
                                out.print("<div class=\"ui radio checkbox\">");
                                out.print("<input type=\"radio\" name=\"emoa\" value=\"" + (0) + "\">");
                                out.print("<label>" + (0) + "</label>");
                                out.print("</div>");
                                out.print("</div>");
                                
                                out.print("<div class=\"field\">");
                                out.print("<div class=\"ui radio checkbox\">");
                                out.print("<input type=\"radio\" name=\"emoa\" value=\"" + (1) + "\">");
                                out.print("<label>" + (1) + "</label>");
                                out.print("</div>");
                                out.print("</div>");

                                out.print("<div class=\"field\">");
                                out.print("<div class=\"ui radio checkbox\">");
                                out.print("<input type=\"radio\" name=\"emoa\" value=\"" + (2) + "\">");
                                out.print("<label>" + (2) + "</label>");
                                out.print("</div>");
                                out.print("</div>");
                                out.print("<tr>");
                                rs = sql.executeQuery("select * from userpos limit 3,1");
                                while(rs.next()) {
                                    out.print("<td>"+rs.getString(1)+"</td>");
                                }                              
                                out.print("<td>");
                                out.print("<div class=\"compact field\">");
                                out.print("<select name=\"user\">");
                                out.print("<option value>Select...</option>");
                                out.print("<option value=\"b"+(1)+"\" selected=\"selected\">User "+(1)+"</option>");
                                out.print("<option value=\"b"+(2)+"\">User "+(2)+"</option>");
                                out.print("<option value=\"b"+(3)+"\">User "+(3)+"</option>");
                                out.print("<option value=\"b"+(4)+"\">User "+(4)+"</option>");
                                out.print("</select></div></td>");
                                
                                out.print("<td>");
                                out.print("<div class=\"inline fields\">");
                                
                                out.print("<div class=\"field\">");
                                out.print("<div class=\"ui radio checkbox\">");
                                out.print("<input type=\"radio\" name=\"emob\" value=\"" + (-2) + "\">");
                                out.print("<label>" + (-2) + "</label>");
                                out.print("</div>");
                                out.print("</div>");
                                
                                out.print("<div class=\"field\">");
                                out.print("<div class=\"ui radio checkbox\">");
                                out.print("<input type=\"radio\" name=\"emob\" value=\"" + (-1) + "\" >");
                                out.print("<label>" + (-1) + "</label>");
                                out.print("</div>");
                                out.print("</div>");
                                
                                out.print("<div class=\"field\">");
                                out.print("<div class=\"ui radio checkbox\">");
                                out.print("<input type=\"radio\" name=\"emob\" value=\"" + (0) + "\">");
                                out.print("<label>" + (0) + "</label>");
                                out.print("</div>");
                                out.print("</div>");
                                
                                out.print("<div class=\"field\">");
                                out.print("<div class=\"ui radio checkbox\">");
                                out.print("<input type=\"radio\" name=\"emob\" value=\"" + (1) + "\">");
                                out.print("<label>" + (1) + "</label>");
                                out.print("</div>");
                                out.print("</div>");

                                out.print("<div class=\"field\">");
                                out.print("<div class=\"ui radio checkbox\">");
                                out.print("<input type=\"radio\" name=\"emob\" value=\"" + (2) + "\" checked=\"checked\">");
                                out.print("<label>" + (2) + "</label>");
                                out.print("</div>");
                                out.print("</div>");
                                out.print("</div>");
                                out.print("</td></tr>");
                                out.print("<tr>");
                                rs = sql.executeQuery("select * from userpos limit 5,1");
                                while(rs.next()) {
                                    out.print("<td>"+rs.getString(1)+"</td>");
                                }                              
                                out.print("<td>");
                                out.print("<div class=\"compact field\">");
                                out.print("<select name=\"user\">");
                                out.print("<option value>Select...</option>");
                                out.print("<option value=\"c"+(1)+"\">User "+(1)+"</option>");
                                out.print("<option value=\"c"+(2)+"\" selected=\"selected\">User "+(2)+"</option>");
                                out.print("<option value=\"c"+(3)+"\">User "+(3)+"</option>");
                                out.print("<option value=\"c"+(4)+"\">User "+(4)+"</option>");
                                out.print("</select></div></td>");
                                
                                out.print("<td>");
                                out.print("<div class=\"inline fields\">");
                                
                                out.print("<div class=\"field\">");
                                out.print("<div class=\"ui radio checkbox\">");
                                out.print("<input type=\"radio\" name=\"emoc\" value=\"" + (-2) + "\">");
                                out.print("<label>" + (-2) + "</label>");
                                out.print("</div>");
                                out.print("</div>");
                                
                                out.print("<div class=\"field\">");
                                out.print("<div class=\"ui radio checkbox\">");
                                out.print("<input type=\"radio\" name=\"emoc\" value=\"" + (-1) + "\" checked=\"checked\">");
                                out.print("<label>" + (-1) + "</label>");
                                out.print("</div>");
                                out.print("</div>");
                                
                                out.print("<div class=\"field\">");
                                out.print("<div class=\"ui radio checkbox\">");
                                out.print("<input type=\"radio\" name=\"emoc\" value=\"" + (0) + "\">");
                                out.print("<label>" + (0) + "</label>");
                                out.print("</div>");
                                out.print("</div>");
                                
                                out.print("<div class=\"field\">");
                                out.print("<div class=\"ui radio checkbox\">");
                                out.print("<input type=\"radio\" name=\"emoc\" value=\"" + (1) + "\">");
                                out.print("<label>" + (1) + "</label>");
                                out.print("</div>");
                                out.print("</div>");

                                out.print("<div class=\"field\">");
                                out.print("<div class=\"ui radio checkbox\">");
                                out.print("<input type=\"radio\" name=\"emoc\" value=\"" + (2) + "\">");
                                out.print("<label>" + (2) + "</label>");
                                out.print("</div>");
                                out.print("</div>");
                                                            
                                out.print("<tr>");
                                rs = sql.executeQuery("select * from userpos limit 7,1");
                                while(rs.next()) {
                                    out.print("<td>"+rs.getString(1)+"</td>");
                                }                              
                                out.print("<td>");
                                out.print("<div class=\"compact field\">");
                                out.print("<select name=\"user\">");
                                out.print("<option value>Select...</option>");
                                out.print("<option value=\"d"+(1)+"\">User "+(1)+"</option>");
                                out.print("<option value=\"d"+(2)+"\" selected=\"selected\">User "+(2)+"</option>");
                                out.print("<option value=\"d"+(3)+"\">User "+(3)+"</option>");
                                out.print("<option value=\"d"+(4)+"\">User "+(4)+"</option>");
                                out.print("</select></div></td>");
                                
                                out.print("<td>");
                                out.print("<div class=\"inline fields\">");
                                
                                out.print("<div class=\"field\">");
                                out.print("<div class=\"ui radio checkbox\">");
                                out.print("<input type=\"radio\" name=\"emod\" value=\"" + (-2) + "\">");
                                out.print("<label>" + (-2) + "</label>");
                                out.print("</div>");
                                out.print("</div>");
                                
                                out.print("<div class=\"field\">");
                                out.print("<div class=\"ui radio checkbox\">");
                                out.print("<input type=\"radio\" name=\"emod\" value=\"" + (-1) + "\" checked=\"checked\">");
                                out.print("<label>" + (-1) + "</label>");
                                out.print("</div>");
                                out.print("</div>");
                                
                                out.print("<div class=\"field\">");
                                out.print("<div class=\"ui radio checkbox\">");
                                out.print("<input type=\"radio\" name=\"emod\" value=\"" + (0) + "\">");
                                out.print("<label>" + (0) + "</label>");
                                out.print("</div>");
                                out.print("</div>");
                                
                                out.print("<div class=\"field\">");
                                out.print("<div class=\"ui radio checkbox\">");
                                out.print("<input type=\"radio\" name=\"emod\" value=\"" + (1) + "\">");
                                out.print("<label>" + (1) + "</label>");
                                out.print("</div>");
                                out.print("</div>");

                                out.print("<div class=\"field\">");
                                out.print("<div class=\"ui radio checkbox\">");
                                out.print("<input type=\"radio\" name=\"emod\" value=\"" + (2) + "\">");
                                out.print("<label>" + (2) + "</label>");
                                out.print("</div>");
                                out.print("</div>");
                            out.print("</tbody></table>");

                            // out.print("<div class=\"ui segment\">");
                            out.print("<div class=\"ui accordion\">");
                            for (int i = 0; i < user_num; i++) {
                                out.print("<div class=\"title\">");
                                out.print("<i class=\"dropdown icon\"></i>");
                                out.print("User "+(i+1));
                                out.print("</div>");
                                out.print("<div class=\"content\">");
                                out.print("<p class=\"transition hidden\"　style=\"font-size:1.23em\">");
                                int no = 1;
                                rs = sql.executeQuery("select * from user"+(page_num*user_num+i+1)+" limit " + (i*20) + ",20");
                                while(rs.next()) {
                                    out.print(no+" "+rs.getString(1)+"<br>");
                                    no++;
                                }
                                out.print("</p>");
                                out.print("</div>");
                            }
                            // out.print("</div>");
                            out.print("</div></div>");
                            out.print("<script>console.log(\"Test\")</script>");
                        }
                    conn.close();                
                } 
                catch(ClassNotFoundException e) { 
                    out.println("找不到驱动程序"); 
                    e.printStackTrace(); 
                } 
                catch(SQLException e) { 
                    e.printStackTrace(); 
                }*/         
                %>
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
                            out.print("<th>Comments</th>");
                            out.print("<th>Content (fluency, grammar, relevence, etc.), 1 (poor) to 5 (good)</th>");
                            out.print("</tr></thead>");
                            out.print("<tbody>");

                            out.print("<tr>");
                            // out.print("<td>Seq2Seq</td>");
                            rs = sql.executeQuery("select * from seqreply limit "+j+",1");
                            while(rs.next()) {
                                out.print("<td>"+rs.getString(1)+"</td>");
                            }
                            out.print("<td>");
                            out.print("<div class=\"inline fields\">");
                            for (int i = 0; i < rate_num; i++) {
                                out.print("<div class=\"field\">");
                                out.print("<div class=\"ui radio checkbox\">");
                                out.print("<input type=\"radio\" name=\"seqcontent"+j+"\" value=\"" + (i+1) + "\" required>");
                                out.print("<label>" + (i+1) + "</label>");
                                out.print("</div>");
                                out.print("</div>");
                            }
                            out.print("</div>");
                            out.print("</td></tr>");
                            
                            out.print("<tr>");
                            // out.print("<td>Embedding</td>");
                            rs = sql.executeQuery("select * from emreply limit "+j+",1");
                            while(rs.next()) {
                                out.print("<td>"+rs.getString(1)+"</td>");
                            }
                            out.print("<td>");
                            out.print("<div class=\"inline fields\">");
                            for (int i = 0; i < rate_num; i++) {
                                out.print("<div class=\"field\">");
                                out.print("<div class=\"ui radio checkbox\">");
                                out.print("<input type=\"radio\" name=\"emcontent"+j+"\" value=\"" + (i+1) + "\" required>");
                                out.print("<label>" + (i+1) + "</label>");
                                out.print("</div>");
                                out.print("</div>");
                            }
                            out.print("</div>");
                            out.print("</td></tr>");
                    
                            out.print("<tr>");
                            // out.print("<td rowspan=\"2\">ECM</td>");
                            rs = sql.executeQuery("select * from ecmreplypos limit "+j+",1");
                            while(rs.next()) {
                                out.print("<td>"+rs.getString(1)+"</td>");
                            }
                            out.print("<td>");
                            out.print("<div class=\"inline fields\">");
                            for (int i = 0; i < rate_num; i++) {
                                out.print("<div class=\"field\">");
                                out.print("<div class=\"ui radio checkbox\">");
                                out.print("<input type=\"radio\" name=\"ecmcontentpos"+j+"\" value=\"" + (i+1) + "\" required>");
                                out.print("<label>" + (i+1) + "</label>");
                                out.print("</div>");
                                out.print("</div>");
                            }
                            out.print("</div>");
                            out.print("</td></tr>");
                            out.print("<tr>");
                            rs = sql.executeQuery("select * from ecmreplyneg limit "+j+",1");
                            while(rs.next()) {
                                out.print("<td>"+rs.getString(1)+"</td>");
                            }
                            out.print("<td>");
                            out.print("<div class=\"inline fields\">");
                            for (int i = 0; i < rate_num; i++) {
                                out.print("<div class=\"field\">");
                                out.print("<div class=\"ui radio checkbox\">");
                                out.print("<input type=\"radio\" name=\"ecmcontentneg"+j+"\" value=\"" + (i+1) + "\" required>");
                                out.print("<label>" + (i+1) + "</label>");
                                out.print("</div>");
                                out.print("</div>");
                            }
                            out.print("</div>");
                            out.print("</td></tr>");

                            
                            out.print("<script> console.log(\"Section "+(j+1)+"\");</script>");
                            int order[] = new int[4];
                            int orderemo[] = new int[4];
                            for (int k = 0; k < user_num; k++) {
                                double rand = Math.random();
                                if (rand < 0.25) order[k] = 1;
                                else if (rand < 0.5) order[k] = 2;
                                else if (rand < 0.75) order[k] = 3;
                                else order[k] = 4;
                                out.print("<script>console.log(\"order ["+(k+1)+"] = "+order[k]+"\");</script>");
                            }
                            for (int k = 0; k < user_num; k++) {
                                double rand = Math.random();
                                if (rand < 0.5) orderemo[k] = 0;
                                else orderemo[k] = 1;
                                out.print("<script>console.log(\"orderemo ["+(k+1)+"] = "+orderemo[k]+"\");</script>");
                                out.print("<input type=\"hidden\" name=\"emohidden"+k+"n"+j+"\" value=\""+orderemo[k]+"\">");
                                //out.print("<script>console.log(\"<input type=\"hidden\" name=\"emohidden"+j+"n"+k+"\" value=\""+orderemo[k]+"\">\");</script>");
                            }
                            order[0] = 0; order[1] = 2; order[2] = 1; order[3]=3;
                            // String 
                            String user_reply[] = new String[4];
                            for (int k = 0; k < user_num; k++) {
                                String table = "userpos";
                                if (orderemo[k] == 0)
                                    table = "userneg";
                                rs = sql.executeQuery("select * from "+table+" limit " + (j*4+order[k]) + ",1");
                                while(rs.next()) {
                                    user_reply[k] = rs.getString(1);
                                }
                                out.print("<script>console.log(\""+user_reply[k]+"\");</script>");
                            }

                            for (int k = 0; k < user_num; k++) {
                                out.print("<tr>");
                                out.print("<td>"+user_reply[k]+"</td>");
                                out.print("<td>");
                                out.print("<div class=\"inline fields\">");
                                for (int i = 0; i < rate_num; i++) {
                                    out.print("<div class=\"field\">");
                                    out.print("<div class=\"ui radio checkbox\">");
                                    out.print("<input type=\"radio\" name=\"ourscontent"+(k+1)+""+j+"\" value=\"" + (i+1) + "\" required>");
                                    out.print("<label>" + (i+1) + "</label>");
                                    out.print("</div>");
                                    out.print("</div>");
                                }
                                out.print("</div>");
                                out.print("</td></tr>");
                            }
                            out.print("</tbody></table>");

                            out.print("<table class=\"ui celled compact table\">");
                            out.print("<thead>");
                            out.print("<tr>");
                            out.print("<th>Comments</th>");
                            out.print("<th style=\"width:10em\">Commentator</th>");
                            out.print("<th>Emotional Polarity, -2 (very opposing) to 2 (very supportive)</th>");
                            out.print("</tr></thead>");
                            out.print("<tbody>");
                            for (int k = 0; k < user_num; k++) {
                                out.print("<tr>");
                                out.print("<td>"+user_reply[k]+"</td>");                                
                                out.print("<td>");
                                out.print("<div class=\"compact field\">");
                                out.print("<select name=\"user"+k+"n"+j+"\" required>");
                                out.print("<option value>Select...</option>");
                                for (int i = 0; i < user_num; i++) {
                                    int value = 0;
                                    if (i == (order[k]-1))
                                        value = 1;
                                    out.print("<script>console.log(\"section "+(j+1)+" reply "+(k+1)+" user "+(i+1)+" value "+value+"\");</script>");
                                    out.print("<option value=\""+value+"\">User "+(i+1)+"</option>");
                                }
                                out.print("</select></div></td>");
                                
                                out.print("<td>");
                                out.print("<div class=\"inline fields\">");
                                for (int i = 0; i < rate_num; i++) {
                                    out.print("<div class=\"field\">");
                                    out.print("<div class=\"ui radio checkbox\">");
                                    out.print("<input type=\"radio\" name=\"emo"+k+"n"+j+"\" value=\"" + (i-2) + "\" required>");
                                    out.print("<label>" + (i-2) + "</label>");
                                    out.print("</div>");
                                    out.print("</div>");
                                }
                                out.print("</div>");
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
                                out.print("<p class=\"transition hidden\"　style=\"font-size:1.23em\">");
                                int no = 1;
                                rs = sql.executeQuery("select * from user"+(i+1)+" limit " + (i*20) + ",20");
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
            age: 'empty',
            occupation: 'empty',
            email:'empty'
            }
        })
        ;
        </script>
    </body>
</html>