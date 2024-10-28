<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    info="내부인지 외부인지 판단"
    %>
<%
request.setCharacterEncoding("UTF-8");
String movePage="kor.jsp";
String lang="한국어"; //web parameter로 전송  web parameter로 생성된 한글은 전송될 때 깨진다.
//request 객체의 charset을 encoding해야한다.

if(!"localhost".equals(request.getServerName())){
	movePage="eng.jsp";
	lang="ebglish";
}
%>
<jsp:forward page="<%=movePage %>">
	<jsp:param value="<%= lang %>" name="lang"/>
</jsp:forward>