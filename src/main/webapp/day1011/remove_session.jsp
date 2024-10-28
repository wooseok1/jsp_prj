<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    info=""
    %>
<%
//세션 값 삭제
session.removeAttribute("age");
session.removeAttribute("name");

//세션자체 무효화
session.invalidate();

//System.out.println(session.getAttribute("name"));

response.sendRedirect("get_session.jsp");


%>
