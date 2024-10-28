<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    info="EL사용"
    isELIgnored="false"
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
	<div>
	<h2>scope 객체의 사용</h2>
	<%
	String msg="오늘은 목요일 입니다.";
	%>
	
	EL : ${msg }<br>
	Expression : <%=msg%><br>
	<%
	//EL에서 변수를 사용하려면 변수를 scope 객체에 저장하고, scope 객체에 저장된 이름을 사용하여
	//변수를 사용한다
	
	//1. scope 객체에 저장
	pageContext.setAttribute("m",msg);
	%>
	2. EL에서 scope 객체를 사용한 접근 : <strong>${pageScope.m }</strong> 
	
	<%
	pageContext.setAttribute("pMsg","페이지 메시지");
	request.setAttribute("rMsg", "request 메시지");
	session.setAttribute("sMsg", "session 메시지");
	application.setAttribute("aMsg", "application 메시지");
	%>
	scope 객체를 사용한 접근<br>
	pageScope : ${pageScope.pMsg }<br>
	pageScope : ${pageScope.pMsg }<br>
	requestScope : ${requestScope.rMsg }<br>
	sessionScope : ${sessionScope.sMsg }<br>
	applicationScope : ${applicationScope.aMsg }<br>
	
	<%
	pageContext.setAttribute("test2","페이지 메시지");
	request.setAttribute("test", "request 메시지");
	session.setAttribute("test", "session 메시지");
	application.setAttribute("test", "application 메시지");
	%>
	
	scope객체에 같은 이름이 존재<br>
	<!-- scope 객체를 생략하고 이름만 사용하면 가장 생명이 짧은 객체부터 사용한다. -->
	pageScope : ${pageScope.pMsg }(${test })<br>
	requestScope : ${requestScope.rMsg }(${test })<br>
	sessionScope : ${sessionScope.sMsg }(${test })<br>
	applicationScope : ${applicationScope.aMsg }(${test })<br>
</div>
</div>
</body>
</html>
