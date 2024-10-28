<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    info="데이터 처리 결과를 받아와서 화면을 구현하여 응답되는 페이지"
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
	$("#navUl").click(function () {
		
	})
});//ready
</script>
</head>
<body>
<div id="wrap">
<%
//업무처리한 결과(request scope에 저장)를 받아와서 화면을 구현하는 일
String name=(String)request.getAttribute("name");
List<String> list=(List<String>)request.getAttribute("data");

String paramSelStNum=request.getParameter("selectNum");
int selectNum=paramSelStNum==null?0:Integer.parseInt(paramSelStNum);
%>
<h3><%=name %></h3>
<ul class="nav nav-underline" id="navUl">
<%for(int i=0; i<list.size(); i++){ %>
  <li class="nav-item" >
    <a class="nav-link" <%=i==0?" active":"" %>" aria-current="page" href="forward_a.jsp?selectNum=<%=i%>"><%=list.get(i) %></a>
  </li>
  <%} %>
</ul>
</div>
</body>
</html>
