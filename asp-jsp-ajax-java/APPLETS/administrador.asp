<html>
<body>
<%
if (session("login")=false) then
	Response.Redirect("index.asp")
end if
%>
<!-- width=970 -->
<applet code=cliApplet.class width=1200 height=400></applet></body>
</html>