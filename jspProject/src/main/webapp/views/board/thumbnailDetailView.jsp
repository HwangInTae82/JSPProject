<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
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

            .outer table {
                border: 1px solid white;
            }

            .outer table th,
            .outer table td {
                border: 1px solid white;
            }

            .outer>form input,
            .outer>form textarea {
                width: 100%;
                height: 100%;
                box-sizing: border-box;
            }

            .outer img:hover {
                cursor: pointer;
                background: #83aeff;
            }
        </style>
    </head>

    <body>
        <%@ include file="../common/menubar.jsp" %>

            <div class="outer">
                <br>
                <h2 align="center">사진게시글 상세보기</h2>
                <br>
                <table border="1" align="center">
                    <tr>
                        <th>제목</th>
                        <td colspan="3">
                            ${b.boardTitle}
                        </td>
                    </tr>
                    <tr>
                        <th>작성자</th>
                        <td>${b.userId}</td>
                        <th>작성일</th>
                        <td>${b.createDate}</td>
                    </tr>
                    <tr>
                        <th>대표이미지</th>
                        <td colspan="3">
                            <img id="tumbnail-img" width="250" height="170"
                                src="${pageContext.request.contextPath}/${list[0].filePath}${list[0].changeName}">
                        </td>
                    </tr>
                    <tr>
                        <th>상세이미지</th>
                        <c:forEach var="at" items="${list}">
                            <c:if test="${at.fileLevel == 2}">
                                <td><img width="150" height="120"
                                        src="${pageContext.request.contextPath}/${at.filePath}${at.changeName}">
                                </td>
                            </c:if>
                        </c:forEach>
                    </tr>
                </table>

                <br>
     
                <div align="center">
                    <a href="${pageContext.request.contextPath}/list.th" class="btn btn-sm">목록가기</a>
                </div>
            </div>
    </body>

    </html>