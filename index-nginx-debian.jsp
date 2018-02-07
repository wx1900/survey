<%
String site = new String("http://176.122.181.61/survey");
response.setStatus(response.SC_MOVED_TEMPORARILY);
response.setHeader("Location", site); 
%>