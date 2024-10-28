<%@page import="day_1001.ImgVO"%>
<%@page import="java.util.List"%>
<%@page import="day_1001.DataProcess"%>
<%@page import="java.time.LocalDate"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.concurrent.Callable"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
<!-- JQuery CDN 시작-->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>

<style type="text/css">

</style>
<script type="text/javascript">
$(function(){
	$("#btn").click(function () {
		printDate();
	})
});//ready

function printDate() {
	let yaer=$("#year").val();
	let month=$("#month").val();
	let day=$("#day").val();
	
	$("#output").html(year+"년" +month+"월" +day+"일");
}
</script>
</head>
<body>
<div id="wrap">
<select id="year" >
<% 
Calendar cal = Calendar.getInstance();

int lastDay= Calendar.getInstance().getActualMaximum(Calendar.DATE);

int year = cal.get(Calendar.YEAR);
 
for(int i=year;i>1979;i--){ %>

<option ><%=i %></option>
<% } %>
</select>년

<select id="month">
<%
int nowMonth = cal.get(Calendar.MONDAY)+1;
for(int i=1;i<13;i++){ 
	if(nowMonth==i){%>
		<option selected=<%=nowMonth %>><%=nowMonth %></option>
	<%} %>
	<option value="i" ><%=i %></option>
<%} %>
</select>월 
<select id="day">
<%
int nowDay = cal.get(Calendar.DAY_OF_MONTH);
for(int i=1;i<lastDay+1;i++){
	if(nowDay==i){%>
		<option selected=<%=nowDay %>><%=nowDay %></option>
	<%} %>
	<option><%=i %></option>
<%} %>
</select>일
<input type="button" value="날짜얻기" class="btn btn-primary btn-sm" id="btn">
<div id="output" style="height: 40px"></div>

<div>
<% for(int i=1;i<7;i++){ %>
<img  src="images/dice_<%=i %>.png">
<%} %>
</div>
<div style="width: 800px;">
<%
String[] names={"김지훈","김현우","이일환","이인혁","황찬욱"};
%>
<table class="table table-hover">
<thead>
<tr>
	<th style="width: 90px">이름</th>
	<th style="width: 610px">점수</th>
</tr>
</thead>
<tbody>
	<%for(int i=0;i<names.length;i++){ %>
<tr>
	<td><strong><%=names[i] %></strong></td>
	<td>
	<% for(int j=0;j<11;j++){ %>
	<input type="radio" name="score<%=i %>"<%=
	j==0?"checked='checked'":""%>> <%=j %>점 
	<%} %>
	</td>
</tr>
	<%} %>
	
</tbody>
</table>
<%
	//List에 저장된 이미지와 설명을 Card로 출력
	DataProcess dp=new DataProcess();
	List<ImgVO> list=dp.searchData();
	
	if(list.isEmpty()){
%>
	<marquee>로딩된 이미지가 없습니다.</marquee>
	<%} 
 for(ImgVO iVO:list){ %>
	<div class="card" style="width: 18rem;">
	<img  src="http://localhost/jsp_prj/day1001/images/<%=iVO.getImg()%>">
	<div class="card-body">
	<% String info=iVO.getInfo();
		%>
		<p class="card-text"><%= info.length()>50?
				info.substring(0,49)+"...":"" %></p>
	</div>
	</div>

<%} %>

<%
	//scriptlet에서는 method를 작성할 수 없다.
	//public void test(){}
	
	
%>
</div>
</div>
</body>
</html>
