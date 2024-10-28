<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    info="이름이 중복되는 HTML Form Control 값 받기"
    %>
<%//POST 방식일때 한글처리
	request.setCharacterEncoding("UTF-8");
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
.blue{color: #0000FF}
.red{color: #FF0000}
</style>
<script type="text/javascript">
$(function(){

});//ready
</script>
</head>
<body>
<div id="wrap">
<%
String method=request.getMethod();
String css="blue";
if("POST".equals(method)){
	css="red";
}
%>
<h2><span class="<%=css %>"><%=method %></span>방식의 요청</h2>

<%
String gender= request.getParameter("gender");
String[] hobby=request.getParameterValues("hobby");
%>
성별 : <%=gender %><br>
취미 : 
<ul>
<% if(hobby==null){ %>
	<li>선택한 취미가 없습니다.</li>
<%}else{
	for(String selectHobby : hobby){
%>
	<li><%=selectHobby %></li>
<%
	}//endfor
}//endelse %>
</ul>
</div>
</body>
</html>
