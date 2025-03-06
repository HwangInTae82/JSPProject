<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
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
            border: 1px solid white;
            text-align: center;
        }

        .list-area td, .list-area th{
            border: 1px solid white; 
        }

		.list-area select, .list-area input, .list-area textarea{
			width: 100%;
			box-sizing: border-box;
			background: #ffffff;
    		color: black;
		}
	</style>
</head>

<body>
	<%@ include file="../common/menubar.jsp" %>

	<div class="outer">
		<br>
		<h2 align="center">일반게시글 수정하기</h2>
		<br>
		
		<form action="${pageContext.request.contextPath}/update.bo" method="post" enctype="multipart/form-data">
			<input type="hidden" name="bno" value="${b.boardNo}">
			<table align="center" class="list-area">
				<tr>
					<th width="70">카테고리</th>
					<td width="500">
						<select name="category">
							<c:forEach var="c" items="${list}">
								<c:choose>
									<c:when test="${c.categoryNo == b.categoryNo}">
										<option value="${c.categoryNo}" selected>${c.categoryName}</option>
									</c:when>
									<c:otherwise>
										<option value="${c.categoryNo}">${c.categoryName}</option>
									</c:otherwise>
								</c:choose>
							</c:forEach>
						</select>
					</td>
				</tr>
				<tr>
					<th>제목</th>
					<td>
						<input type="text" name="title" required value="${b.boardTitle}">
					</td>
				</tr>
				<tr>
					<th>내용</th>
					<td>
						<textarea name="content" rows="10" style="resize: none;">${b.boardContent}</textarea>
					</td>
				</tr>
				<tr>
					<th>첨부파일</th>
					<td>
						<c:if test="${at != null}">
							${at.originName}
							<input type="hidden" name="originFileNo" value="${at.fileNo}">
						</c:if>
						<input type="file" name="upfile">
					</td>
				</tr>
			</table>

			<br>

			<div align="center">
				<button type="submit">수정하기</button>
				<button type="reset">취소하기</button>
			</div>
		</form>
	</div>
</body>

</html>