<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<title>list page</title>
</head>
<script>
$(document).ready(function(){
	$('#allCheck').click(function () {
		if ($("input:checkbox[id='allCheck']").prop("checked")) {
			$("input[type=checkbox]").prop("checked", true);
		} else {
			$("input[type=checkbox]").prop("checked", false);
		}
	});
});
</script>
<body>
<div class="container">
<h1>board list page입니다.</h1>
	<form action="${pageContext.request.contextPath }/board/checkDel" method="post">
	<a href="${pageContext.request.contextPath }/board/register" class="btn btn-dark">글쓰기</a>
	<input type="submit" value="선택 삭제" class="btn btn-danger"/>
	<table class="table table-striped">
		<thead>
			<tr>
				<th><input type="checkbox" id="allCheck" name="bno" value="${board.bno }"/></th>
				<th>번호</th>
				<th>제목</th>
				<th>작성자</th>
				<th>작성일</th>
			</tr>
		</thead>
		<c:forEach items="${list }" var="board">
			<tr>
				<td><input type="checkbox" id="bno" name="bno" value="${board.bno }" /></td>
				<td>${board.bno }</td>
				<td><a href="${pageContext.request.contextPath}/board/get?bno=${board.bno }"><c:out value="${board.title }"></c:out></a></td>
				<td><c:out value="${board.writer }"></c:out></td>
				<td><fmt:formatDate pattern="yyyy-MM-dd" value="${board.regdate }"/></td>
			</tr>
		</c:forEach>
	</table>
	</form>
</div>
</body>
</html>