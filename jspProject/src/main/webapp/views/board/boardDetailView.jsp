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

<body onload="init(${board.boardNo})">
	<%@ include file="../common/menubar.jsp" %>

	<div class="outer">
		<br>
		<h2 align="center">일반게시글 상세보기</h2>
		<br>

		
        <table align="center" class="list-area">
            <tr>
                <th width="70">카테고리</th>
                <td width="70">${board.categoryName}</td>
                <th width="70">제목</th>
                <td width="350">${board.boardTitle }</td>
            </tr>
            <tr>
                <th>작성자</th>
                <td>${board.userId}</td>
                <th>작성일</th>
                <td>${board.createDate}</td>
            </tr>
            <tr>
                <th>내용</th>
                <td colspan="3">
                   <p style="height: 200px;">
                        ${board.boardContent}
                   </p>
                </td>
            </tr>
            <tr>
                <th>첨부파일</th>
                <td colspan="3">
                    <c:choose>
                    	<c:when test="${empty attachment}">
                    		첨부파일이 없습니다.
                    	</c:when>
                    	<c:otherwise>
                    		<a download="${attachment.originName }" 
                    		   href="${pageContext.request.contextPath}/${attachment.filePath}${attachment.changeName}">
                    		   ${attachment.originName}
                    		</a>
                    	</c:otherwise>
                    </c:choose>
                </td>
            </tr>
        </table>

        <br>

        <div align="center">
            <a class="btn btn-sm btn-primary" href="${pageContext.request.contextPath}/list.bo?cpage=1">목록가기</a>
            <c:if test="${loginUser != null && loginUser.userId == board.userId}">
	            <a class="btn btn-sm btn-primary" href="${pageContext.request.contextPath}/updateForm.bo?bno=${board.boardNo}">수정하기</a>
	            <a class="btn btn-sm btn-primary">삭제하기</a>
            </c:if>
        </div>

        <br>

        <div id="reply-area">
            <table align="center" class="list-area">
                <thead>
                    <tr>
                        <th>댓글작성</th>
                        <c:choose>
                            <c:when test="${loginUser == null}">
                                <td>
                                    <textarea cols="50" rows="3" style="resize: none;" readonly>댓글등록을 하시려면 로그인이 필요합니다.</textarea>
                                </td>
                                <td>
                                    <button disabled>댓글등록</button>
                                </td>
                            </c:when>
                            <c:otherwise>
                                <td>
                                    <textarea id="reply-content" cols="50" rows="3" style="resize: none;"></textarea>
                                </td>
                                <td>
                                    <button onclick="insertReply(${board.boardNo})">댓글등록</button>
                                </td>
                            </c:otherwise>
                        </c:choose>
                    </tr>
                </thead>
                <tbody>
                    <!-- <tr>
                        <td>user01</td>
                        <td>안녕하세요. 저는 ~입니다.</td>
                        <td>2025.03.05</td>
                    </tr>
                    <tr>
                        <td>admin</td>
                        <td>후후하하호호 야호</td>
                        <td>2025.03.02</td>
                    </tr>
                    <tr>
                        <td>pass11</td>
                        <td>엄청나군요.</td>
                        <td>2025.03.01</td>
                    </tr> -->
                </tbody>
            </table>

            <script>
                function init(bno){
                    getReplyList(bno, function(data){
                        drawReplyList(data);
                    });
                }

                function insertReply(bno){
                   const contentArea = document.querySelector("#reply-content");

                   $.ajax({
                    url: "rinsert.bo",
                    type: "post",
                    data: {
                        boardNo: bno,
                        content: contentArea.value  
                    },
                    success: function(res){
                        contentArea.value = ""; //댓글 입력창 초기화
                        //댓글목록 다시 불러와서 그려주기
                        getReplyList(bno, function(data){
                            drawReplyList(data);
                        });
                    },
                    error: function(error){
                        console.log("댓글 작성 ajax통신 실패");
                    }
                   })
                }

                function getReplyList(boardNo, callback){
                    $.ajax({
                        url : "rlist.bo",
                        // contextType: "application/json",
                        dataType: "json", //응답 데이터 타입(json, text, html, xml)
                        data : {
                            bno : boardNo
                        },
                        success: function(replyList){
                            callback(replyList);
                        }, 
                        error: function(){
                            console.log("댓글 조회 ajax통신 실패");
                        }
                    })
                }

                function drawReplyList(replyList){
                    let str = "";
                    for(let r of replyList) {
                        str += "<tr>" +
                                "<td>" + r.userId + "</td>" +
                                "<td>" + r.replyContent + "</td>" +
                                "<td>" + r.createDate + "</td>" +
                              "</tr>";
                    }

                    const replyBody = document.querySelector("#reply-area tbody");
                    replyBody.innerHTML = str;
                }


               
            </script>
        </div>

	</div>
</body>

</html>