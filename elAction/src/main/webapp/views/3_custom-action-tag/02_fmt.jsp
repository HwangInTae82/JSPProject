<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
    <h3>1. fomatNumber</h3>
    <p>
        숫자데이터의 포멧(형식) 지정 <br>
        - 표현하고자하는 숫자데이터의 형식을 통화기호, %등으로 원하는 방식에 맞게 지정하는 태그로

        (fmt:formatNumber value="출력할 값" [groupingUsed="true | false" type="percent | currency" currencySymbol="문자"])
    </p>

    <c:set var="num1" value="123456789" />
    <c:set var="num2" value="0.75" />
    <c:set var="num3" value="50000" />

    출력 : ${num1} <br>
    세자리마다 구문해서 출력 : <fmt:formatNumber value="${num1}" /> <br>
    원래 숫자만 출력 : <fmt:formatNumber value="${num1}" groupingUsed="false"/> <br>

    percent : <fmt:formatNumber value="${num2}" type="percent"/> <br>
    percent : <fmt:formatNumber value="${num3}" type="currency" currencySymbol="$"/> <br>

    <h3>2. formatDate</h3>
    <p>날짜및 시간데이터의 포멧지정(단, java.util.Date객체 사용)</p>

    <c:set var="current" value="<%= new java.util.Date() %>" />
    출력 : ${current}

    <ul>
        <li>현재 날짜 : <fmt:formatDate value="${current}" type="date"/></li>
        <li>현재 시간 : <fmt:formatDate value="${current}" type="time"/></li>
        <li>둘 다 : <fmt:formatDate value="${current}" type="both"/></li>
        <li>medium : <fmt:formatDate value="${current}" type="both" dateStyle="medium" timeStyle="medium"/></li>
        <li>long : <fmt:formatDate value="${current}" type="both" dateStyle="long" timeStyle="long"/></li>
        <li>short : <fmt:formatDate value="${current}" type="both" dateStyle="short" timeStyle="short"/></li>
        <li>full : <fmt:formatDate value="${current}" type="both" dateStyle="full" timeStyle="full"/></li>
        <li>pattern : <fmt:formatDate value="${current}" type="both" pattern="yyyy-MM-dd(E) a HH:mm:ss "/></li>
    </ul>
</body>
</html>