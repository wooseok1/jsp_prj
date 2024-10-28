<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    info="JSTL 변수의 사용"
    %>
<!-- 지시자 선언 -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
<!-- 2. Tag Lib에서 제공하는 태그를 사용 -->
<!-- 변수 선언 -->
<c:set var="msg" value="오늘은 목요일입니다." />
<c:set var="day" value="17" />
<!-- 출력 => EL  -->
${msg }<br>
<c:out value="msg"></c:out>
<c:out value="${msg}"></c:out><br>
<c:out value="${day}"></c:out>일<br>
<c:out value="${day+1}"></c:out>일<br>
<!-- 변수 삭제 -->
<h2>변수 삭제 후 출력</h2>
<!-- 삭제 후 변수를 출력하면 아무것도 출력되지 않는다. -->
<c:remove var="msg"/>
msg : <c:out value="${msg }"></c:out><br>
day : <c:out value="${day }"></c:out>일<br>

<h2>태그 출력</h2>
<c:set var="tag" value="오늘은 <strog>목요일</strong>입니다."></c:set>
EL : ${tag }<br>
<c:out value="${tag }"></c:out><br>
<c:out value="${tag }" escapeXml="false"></c:out><br>

<c:set var="name" value="이인혁"></c:set>
<input type="checkbox" value="${name}"><c:out value="${name }"/>


</div>
</body>
</html>
