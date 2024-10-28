<%@page import="java.sql.SQLException"%>
<%@page import="kr.co.sist.user.board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    info=""
    %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../common/jsp/session_chk.jsp" %>
<%@ include file="../common/jsp/post_chk.jsp" %>
<jsp:useBean id="bVO" class="kr.co.sist.user.board.BoardVO" scope="page"/>
<jsp:setProperty name="bVO" property="*"/>
<!-- 글제목, 글내용, 글번호가 bVO객체에 입력 -->
<%
//작성자는 로그인한 세션에서 받아온다.
bVO.setWriter(sessionId);

BoardDAO bDAO=BoardDAO.getInstance();
int rowCnt;

try{
	rowCnt=bDAO.deleteBoard(bVO);//0,1
}catch(SQLException se){
	rowCnt=-1;//DB에서 문제 발생
	se.printStackTrace();
}
pageContext.setAttribute("rowCnt", rowCnt);//${rowCnt}

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

<script type="text/javascript">
var msg="문제가 발생했습니다. 잠시 후 다시 시도해주세요";
var cnt=${rowCnt};

var flag=false;
if(cnt==0){
	msg="번호는 외부에서 임의로 편집할 수 없습니다.";
}
if(cnt==1){
	msg="${param.num}번 글 삭제 성공";
}

alert(msg);

if(flag){
	location.href="board_list.jsp?currentPage=${param.currentPage}";
}else{
	history.back();
}
$(function(){

});//ready
</script>
</head>
<body>
</body>
</html>
