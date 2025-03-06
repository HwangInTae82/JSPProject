<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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

        .outer table{
            border: 1px solid white;
        }

        .outer table th,
        .outer table td{
            border: 1px solid white; 
        }

        .outer > form input,
        .outer > form textarea{
            width: 100%;
            height: 100%;
            box-sizing: border-box;
        }

        .outer img:hover{
            cursor: pointer;
            background: #83aeff;
        }
    </style>
</head>
<body>
	<%@ include file="../common/menubar.jsp" %>

    <div class="outer">
        <br>
        <h2 align="center">사진게시글 작성하기</h2>
        <br>

        <form action="${pageContext.request.contextPath}/insert.th" method="post" enctype="multipart/form-data">
            <table border="1" align="center">
                <tr>
                    <th>제목</th>
                    <td colspan="3">
                        <input type="text" name="title" required>
                    </td>
                </tr>
                <tr>
                    <th>내용</th>
                    <td colspan="3">
                        <textarea name="content" rows="5" style="resize: none;"></textarea>
                    </td>
                </tr>
                <tr>
                    <th>대표이미지</th>
                    <td colspan="3">
                        <img id="tumbnail-img" width="250" height="170" onclick="chooseFile('#file1')">
                    </td>
                </tr>
                <tr>
                    <th>상세이미지</th>
                    <td><img id="content-img1" width="150" height="120" onclick="chooseFile('#file2')"></td>
                    <td><img id="content-img2" width="150" height="120" onclick="chooseFile('#file3')"></td>
                    <td><img id="content-img3" width="150" height="120" onclick="chooseFile('#file4')"></td>
                </tr>
            </table>

            <div style="display: none;">
                <input type="file" name="file1" id="file1" required onchange="loadImg(this, '#tumbnail-img')">
                <input type="file" name="file2" id="file2" onchange="loadImg(this, '#content-img1')">
                <input type="file" name="file3" id="file3" onchange="loadImg(this, '#content-img2')">
                <input type="file" name="file4" id="file4" onchange="loadImg(this, '#content-img3')">
            </div>

            <br>

            <div align="center">
                <button type="submit">작성하기</button>
                <button type="reset">취소하기</button>
            </div>

            <script>
                function loadImg(changeInput, targetImg){
                    //파일객체 -> files -> 선택된파일들이 담겨있음
                    console.log(changeInput.files[0])
                    const img = document.querySelector(targetImg);
                    console.log(img)
                    if(changeInput.files.length > 0){ //파일은 선택했을 때
                        //파일을 읽어들일 객체
                        const reader = new FileReader();

                        //해당 파일을 읽얻들여 해당파일만의 고유한 url을 부여
                        //url : Base64로 인코딩된 데이터 url(파일을 실제로 표현하는 형식인 바이너리 코드를 텍스트문자열로 인코딩한 방식)
                        reader.readAsDataURL(changeInput.files[0]);

                        //파일읽어들이기를 완료 했을 때 이벤트핸들러를 실행시켜줘
                        reader.onload = function(ev){
                            img.src = ev.target.result //이미지 요소에 불러온 파일의 url을 넣어준다.
                        }


                    } else { //파일이 있었는데 선택 후 취소했을 때
                        img.src = null;
                    }
                }
                function chooseFile(selector){
                    const fileInput = document.querySelector(selector);
                    fileInput.click();
                }
            </script>
        </form>
    </div>
</body>
</html>