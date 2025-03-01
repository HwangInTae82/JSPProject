<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
    <% 
        String year= new java.text.SimpleDateFormat("yyyy").format(new java.util.Date());
    %>
    Copyright © 1995-2025 Samsung. All Rights Reserved.
    test : ${param.test}

</body>
</html>