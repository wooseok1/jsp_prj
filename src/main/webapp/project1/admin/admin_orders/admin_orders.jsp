<%@page import="kr.co.truetrue.admin.order.OrderVO"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.SQLException"%>
<%@page import="kr.co.truetrue.admin.order.OrderDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 주문관리</title>
<link rel="stylesheet" type="text/css" href="../common/css/admin.css">
<link rel="stylesheet" type="text/css" href="css/admin_orders.css">
<!-- JQuery CD작-->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
<script src="js/admin_orders.js" defer></script>
</head>
<body>
<jsp:include page="../common/admin.jsp" />
<div class="common_admin">
<h1>주문관리</h1>
<jsp:useBean id="sVO" class="kr.co.sist.user.board.SearchVO" scope="page"/>
<jsp:setProperty property="*" name="sVO"/>
<% 
//1.총 레코드 수 구하기
	int totalCount=0;
	
	OrderDAO oDAO=OrderDAO.getInstance();
	try{
		totalCount=oDAO.selectTotalCount(sVO);
	}catch(SQLException se){
		se.printStackTrace();
	}
	//2.한 화면에 보여줄 레코드의 수
	int pageScale=10;
	
	//3.총 페이지 수
	int totalPage=(int)Math.ceil((double)totalCount/pageScale );
	
	//4.검색의 시작번호를 구하기(pagination의 번호[1][2][3]
	String paramPage=request.getParameter("currentPage");
	
	int currentPage=1;
	
	if(paramPage != null){
		try{
			currentPage=Integer.parseInt(paramPage);
		}catch(NumberFormatException nfe){
		}
	}
			
	int startNum=currentPage*pageScale-pageScale+1;//시작번호
	//5.끝 번호
	int endNum=startNum+pageScale-1;//끝번호
	
	sVO.setCurrentPage(currentPage);
	sVO.setStartNum(startNum);
	sVO.setEndNum(endNum);
	sVO.setTotalPage(totalPage);
	sVO.setTotalCount(totalCount);
	
	List<OrderVO> listBoard=null;
	try{
	listBoard=oDAO.selectAllOrder();
	}catch(SQLException se){
		se.printStackTrace();
	}
	pageContext.setAttribute("totalCount", totalCount);
	pageContext.setAttribute("pageScale",pageScale );
	pageContext.setAttribute("totalPage", totalPage); 
	pageContext.setAttribute("currentPage", currentPage); 
	pageContext.setAttribute("startNum", startNum); 
	pageContext.setAttribute("endNum", endNum); 
	pageContext.setAttribute("listBoard", listBoard); 
	
	%>
<div class="order-management">
    <div class="order-header">
    	<div class="order-button">
	        <button class="new-order-btn">신규 주문 내역</button>
	        <button class="previous-order-btn">이전 주문 내역</button>
        </div>
        <div class="date-range">
            <label for="date-range">거래기간:</label>
            <input type="date" id="start-date">
            <span>~</span>
            <input type="date" id="end-date">
            
            <input type="text" placeholder="상품명 검색" class="search-bar">
        	<button class="search-btn">검색</button>
        </div>
    </div>
    
    <table class="order-table">
        <thead> 
            <tr>
                <th>주문 ID</th>
                <th>고객 ID</th>
                <th>결제일</th>
                <th>결제금액</th>
                <th>주문주소</th>
                <th>주문상태</th>
                <th style="width: 230px;">
                	<div class="pagination">
				        <span>주문 상태 변경</span>
				    </div>
                </th>
            </tr>
        </thead>
        <tbody>
        <c:forEach var="oVO" items="${listBoard }" varStatus="i">
            <tr>
        	<td><c:out value="${oVO.order_id }"/></td>
        	<td><c:out value="${oVO.user_id }"/></td>
        	<td><c:out value="${oVO.payment_date }"/></td>
        	<td><c:out value="${oVO.total_price }"/></td>
        	<td><c:out value="${oVO.address }"/></td>
        	<td><c:out value="${oVO.delivery_status }"/></td>
        	<td>
        		<button class="action-btn" id="start_btn" onclick="editProduct('PROD001')">배송 시작</button>
        		<button class="action-btn" onclick="editProduct('PROD001')">배송 완료</button>
                <button class="action-btn delete-btn" onclick="deleteProduct()">취소</button>
        	</td>
        </tr>
        </c:forEach>
        </tbody>
    </table>
    <div class="pagination">
        <button class="prev-page">◀</button>
        <span>${startNum} / ${endNum }</span>
        <button class="next-page">▶</button>
    </div>
</div>
</div>
<script src="../common/js/admin.js"></script>
</body>
</html>