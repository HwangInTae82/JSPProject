<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
	<!DOCTYPE html>
	<html>

	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
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
				margin: auto;
			}
		</style>
	</head>

	<body>
		<%@ include file="../common/menubar.jsp" %>

			<div class="outer">
				<br>
				<h2 align="center">회원가입</h2>
				<form action="${pageContext.request.contextPath}/insert.me" method="post" id="enroll-form">
					<table>
						<tr>
							<td>* 아이디</td>
							<td><input type="text" name="userId" maxlength="15" required></td>
							<td><button type="button" onclick="idCheck()">중복확인</button></td>
						</tr>
						<tr>
							<td>* 비밀번호</td>
							<td><input type="password" name="userPwd" maxlength="15" required></td>
							<td></td>
						</tr>
						<tr>
							<td>* 비밀번호 확인</td>
							<td><input type="password" name="userPwdCheck" maxlength="15" required></td>
							<td></td>
						</tr>
						<tr>
							<td>* 이름</td>
							<td><input type="text" name="userName" maxlength="8" required></td>
							<td></td>
						</tr>
						<tr>
							<td>전화번호</td>
							<td><input type="text" name="phone" placeholder="- 포함해서 입력"></td>
							<td></td>
						</tr>
						<tr>
							<td>이메일</td>
							<td><input type="text" name="email"></td>
							<td></td>
						</tr>
						<tr>
							<td>주소</td>
							<td><input type="text" name="address"></td>
							<td></td>
						</tr>
						<tr>
							<td>관심분야</td>
							<td colspan="2">
								<label>
									<input type="checkbox" name="interest" value="운동">
									운동
								</label>
								<label>
									<input type="checkbox" name="interest" value="등산">
									등산
								</label>
								<label>
									<input type="checkbox" name="interest" value="낚시">
									낚시
								</label>
								<br>
								<label>
									<input type="checkbox" name="interest" value="요리">
									요리
								</label>
								<label>
									<input type="checkbox" name="interest" value="게임">
									게임
								</label>
								<label>
									<input type="checkbox" name="interest" value="영화">
									영화
								</label>
								<label>
									<input type="checkbox" name="interest" value="기타">
									기타
								</label>
							</td>
						</tr>
					</table>

					<br><br>

					<div align="center">
						<button type="submit" onclick="return checkPwd()" disabled>회원가입</button>
						<button type="reset">초기화</button>
					</div>
				</form>
			</div>

			<script>

				function idCheck() {
					//중복확인버튼 클릭시 사용자가 입력한 아이디값을 서버로 전달하여 요청
					// 응답1 --> 사용불가 --> alert메세지출력(이미 존재하는 아이디입니다.)
					// 응답2 --> 사용가능 --> 진짜 사용할거니? ok : 더이상 변경못하게
					// 										 no : 다시 입력하도록 유도
					const checkId = document.querySelector("#enroll-form input[name=userId]").value;
					$.ajax({
						type: "get",
						url: "idCheck.me",
						data: {
							checkId: checkId
						},
						success: function (result) {
							const idInput = document.querySelector("#enroll-form input[name=userId]");
							if (result === "NNNNY") {
								if (confirm("사용가능한 ID입니다. 정말 사용하시겠습니까?")) {
									idInput.setAttribute("readonly", true);

									const submitBtn = document.querySelector("#enroll-form button[type=submit]");
									submitBtn.removeAttribute("disabled");

								} else {
									idInput.focus();
								}
							} else {
								alert("이미 존재하는 ID입니다.");
								idInput.focus();
							}
						},
						error: function(err) {
							console.log("실패 : ", err);
						}
					})


					/* 이런것도 있다...
					const xhr = new XMLHttpRequest();
					xhr.open("GET", "idCheck.me?checkId="+ encodeURIComponent(checkId), true);

					xhr.onreadystatechange = function(){
						if(xhr.readyState === 4){ //요청완료상태
							if(xhr.status === 200){ //응답성공
								const result = xhr.responseText;
								if(result === "Y"){
									//응답이 Y일때 실행하고싶은 코드
								} else{
									//응답이 N일때 실행하고싶은 코드
								}
							}

						}
					}
						*/
				}
				function checkPwd() {
					const pwd = document.querySelector("#enroll-form input[name=userPwd]").value;
					const pwdCheck = document.querySelector("#enroll-form input[name=userPwdCheck]").value;

					if (pwd !== pwdCheck) {
						alert("비밀번호가 일치하지 않습니다.");
						return false;
					}
				}


			</script>
	</body>

	</html>