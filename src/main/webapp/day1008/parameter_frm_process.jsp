<%@page import="java.net.URLEncoder"%>
<%@page import="java.net.URLDecoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    info="HTML Form Control에 입력값을 받는 일"
    %>
    <!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="shortcut icon" href="http://localhost/jsp_prj/common/images/favicon-16x16.png"/>
<link rel="stylesheet" type="text/css" href="http://192.168.10.229/jsp_prj/common/css/main_20240911.css">
<!-- bootstrap CDN 시작-->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
<!-- JQuery CD작-->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>

<style type="text/css">

</style>
<script type="text/javascript">
$(function(){

});//ready
</script>
</head>
<body>
<div id="wrap">
<%String method=request.getMethod();
%>
<h2><%=method %>방식의 요청</h2>
<%
//POST방식일때만 동작한다. : 입력 스트림의 모든 charset을 변환
request.setCharacterEncoding("UTF-8");

//이름이 유일한 web parameter 받기
//parameter_frm_process.jsp?text=321&pass=231&chk=on&hid=%EC%88%A8%EA%B9%80%EA%B0%92&sel=%EC%9E%90%EB%B0%94&ta=123
String text=request.getParameter("text");
String pass=request.getParameter("pass");
String chk=request.getParameter("chk");
String hid=request.getParameter("hid");
String sel=request.getParameter("sel");
String ta=request.getParameter("ta");

//POST방식일 때 한글 변환
/* if("POST".equals(method)){
	//String class 를 사용한 변환(문자열을 byte로 쪼개서 인코딩 수행)
	text=new String(text.getBytes("8859_1"),"UTF-8");
	hid=URLDecoder.decode(URLEncoder.encode(hid,"8859_1"),"UTF-8");
	
} */

%>

<ul>
	<li>입력값</li>
	<li>text : <%=text %></li>
	<li>password : <%=pass %></li>
	<li>checkbox : <%=chk %></li>
	<li>hidden : <%=hid %></li>
	<li>select : <%=sel %></li>
	<li>textarea : <%=ta %></li>
</ul>
<input type="text" value="<%=text%>">

</div>
</body>
</html>
