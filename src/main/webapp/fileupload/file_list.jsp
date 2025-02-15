<%@ page import="java.util.Date"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.io.File"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="shortcut icon" href="http://localhost/jsp_prj/common/images/favicon-16x16.png"/>
<link rel="stylesheet" type="text/css" href="http://192.168.10.229/jsp_prj/common/css/main_20240911.css">
<!-- bootstrap CDN -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
<!-- JQuery CDN -->
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
        <a href="upload_frm.jsp">업로드</a>
        <table class="table table-hover">
            <thead>
                <tr>
                    <th style="width: 80px">번호</th>
                    <th style="width: 120px">이미지</th>
                    <th style="width: 200px">파일명</th>
                    <th style="width: 150px">파일크기</th>
                    <th style="width: 200px">업로드일</th>
                </tr>
            </thead>
            <tbody>
            <%
            File loadDir = new File("C:/dev/workspase/jsp_prj/src/main/webapp/upload");
            File[] listFile = loadDir.listFiles();
            pageContext.setAttribute("listFile", listFile);
            %>
            <c:choose>
                <c:when test="${empty listFile}">
                    <tr>
                        <td colspan="5">업로드된 파일이 없습니다.</td>
                    </tr>
                </c:when>
                <c:otherwise>
                    <%
                    int ind = 0;
                    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd EEEE HH:mm:ss");
                    String[] validExtensions = {"jpg", "gif", "png", "bmp"};
                    
                    for(File tempFile : listFile){
                        String fileName = tempFile.getName();
                        String fileExt = fileName.substring(fileName.lastIndexOf(".") + 1).toLowerCase();
                        boolean isViewable = false;
                        
                        // 확장자 체크
                        for(String ext : validExtensions) {
                            if(fileExt.equals(ext)) {
                                isViewable = true;
                                break;
                            }
                        }
                    %>
                    <tr>
                        <td><%=++ind%></td>
                        <td>
                            <% if(isViewable) { %>
                                <img src="../upload/<%=fileName%>" style="width: 100px; height: 50px"/>
                            <% } %>
                        </td>
                        <td>
                            <% if(isViewable) { %>
                                <a href="../upload/<%=fileName%>"><%=fileName%></a>
                            <% } else { %>
                                <%=fileName%>
                            <% } %>
                        </td>
                        <td>
                            <%=fileName%>
                            (<a href="download.jsp?fileName=<%=fileName%>">다운로드</a>)
                        </td>
                        <td><%=tempFile.length()%></td>
                        <td><%=sdf.format(new Date(tempFile.lastModified()))%></td>
                    </tr>
                    <%
                    }
                    %>
                </c:otherwise>
            </c:choose>
            </tbody>
        </table>
    </div>
</div>
</body>
</html>