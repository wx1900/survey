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
            body,td,th,div {font-family: Verdana, Arial, Helvetica, sans-serif;font-size: 1.23em;color: #1d1007; line-height:24px} 
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
                    The purpose of this questionnaire is to evaluate the machine-generated responses by humen. The evaluation includes two aspects:
                    <ul>
                    <li>Evaluation on the content, this part has eight replies. To each reply, choose a number between 1 and 5 corresponding to the level 1 to 5. 
                                    The higher the level the better the fluency of the content and better grammatical structure</li>
            
                    <li>Evaluate the diversity of responses, including the diversity of emotions and linguistic styles in this part. There are totally 4 responses in this part:</li>
                    <ul>
                    <li> Evaluate the polarity of emotions, divided into five scores of -2, -1, 0, 1, and 2, with negative numbers representing negative status, positive 
                            numbers representing positive status, and 0 representing neutral status. The higher the absolute value of the score, the stronger the emotion. 
                            Such as 2 positive tendencies stronger than 1.</li>
                    <li>To assess the diversity of language styles, in this part below, there are 20 tweets usually sent by each user. 
                            According to the user's usual linguistic style, choose which user might be the author of each reply.
                            The author of the reply may only be these four users. Responses are randomly selected, so there may be multiple replies to the same user.</li>
                        </ul>
                    </ul>
                
                    这个问卷的目的是对机器产生回复进行人工评价．评价包括两个方面:
                    <ul>
                    <li>对内容进行打分，这一部分有一共有８条回复，在每条回复对应的位置，选择１到５之间一个数字，分别对应等级１到５，等级越高表示内容的流畅性和语法结构越好</li>
                    <li>评价回复的多样性，在这一部分包括情感多样性和语言风格多样性，这一部分一共有４条回复</li>
                        <ul>
                        <li> 对情感的极性进行评价，分为-2,-1,0,1,2五个分数，负数代表消极状态，正数代表积极状态，０表示中立状态．分数的绝对值越高表示情感越强烈．比如２的积极倾向比１更强．</li>
                        <li>对语言风格多样性进行评价，在该部分下面给出了每个个用户平时所用发的２０条推文，根据用户平时的语言风格，选择每个回复的作者可能是哪个用户．
   　                    回复的作者只可能是这四个用户．回复是随机选择的，所以可能有多条回复的作者都是同一个用户．</li>
                        </ul>
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
                            
                            // String 
                            String user_reply[] = new String[4];
                            for (int k = 0; k < user_num; k++) {
                                String table = "userpos";
                                if (orderemo[k] == 0)
                                    table = "userneg";
                                rs = sql.executeQuery("select * from "+table+" limit " + (j*2+order[k]) + ",1");
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
                            out.print("<th>Replies</th>");
                            out.print("<th style=\"width:10em\">Which user says that?</th>");
                            out.print("<th>Emotion evaluation</th>");
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
                                out.print("<p class=\"transition hidden\">");
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