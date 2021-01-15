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
<title>get Page</title>
</head>
<body>
<div class="container col-6">
<h2>게시물 수정</h2>
	<form action="${pageContext.request.contextPath}/board/modify" method="post">
		<input type="hidden" value="${read.bno }" name="bno"/>
		제목 : <input type="text" class="form-control" name="title" value="${read.title }"/> <br/>
		내용 : <textarea class="form-control" name="content">${read.content }</textarea> <br/>
		작성자 : <input type="text" class="form-control" name="writer" value="${read.writer }"/> <br/>
		<input type="submit" class="btn btn-success" value="게시글수정"/>
		<a href="${pageContext.request.contextPath}/board/remove?bno=${read.bno}" class="btn btn-danger">삭제</a>
	</form>
</div>
</body>
</html>