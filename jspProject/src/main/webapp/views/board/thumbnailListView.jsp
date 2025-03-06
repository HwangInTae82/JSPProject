<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Insert title here</title>
    <style>
        .outer {
            background: #4b89fc;
            color: white;
            width: 1000PX;
            margin: auto;
            margin-top: 50px;
            padding: 10px 0px 50px;
        }
        .list-area{
            max-width: 850px;
            min-height: 500px;
            margin: auto;
        }

        .thumbnail{
            display: inline-block;
            border: 1px solid white;
            width: 250px;
            padding: 12px;
            margin: 14px;
            box-sizing: border-box;
        }

        .thumbnail p > span{
            display: inline-block;
            width: 220px;
            text-overflow: ellipsis;
            white-space: nowrap;
            overflow: hidden;
        }
         .thumbnail:hover{
            cursor: pointer;
         	background: #82adfd;
         }
    </style>
</head>
<body>
	<%@ include file="../common/menubar.jsp" %>
	
	<div class="outer">
        <br>
        <h2 align="center">사진게시판</h2>
        <br>
        
        <c:if test="${loginUser != null}">
            <div align="right" style="width: 870px; margin-bottom: 6px;">
                <a href="${pageContext.request.contextPath}/enrollForm.th" class="btn btn-sm btn-primary">게시글 작성</a>
            </div>
        </c:if>

        <div class="list-area">
            <c:choose>
                <c:when test="${not empty list}">
                    <c:forEach var="b" items="${list}">
                    
                        <div class="thumbnail" align="center" onclick="location.href='${pageContext.request.contextPath}/detail.th?bno=${b.boardNo}'">
                            <img width="200px" height="150px" src="${pageContext.request.contextPath}/${b.thumbnailImg}" alt="썸네일이미지">
                            <p>
                                <span>No. ${b.boardNo} ${b.boardTitle}</span><br>
                                조회수 : ${b.count}
                            </p>
                        </div>
                        
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <h1 align="center">게시글이 없습니다.</h1>
                    <c:if test="${loginUser != null}">
                        <div align="center">
                            <a href="${pageContext.request.contextPath}/enrollForm.th" class="btn btn-sm btn-primary">게시글 작성</a>
                        </div>
                    </c:if>
                </c:otherwise>
            </c:choose>
        </div>
	</div>
</body>
</html>