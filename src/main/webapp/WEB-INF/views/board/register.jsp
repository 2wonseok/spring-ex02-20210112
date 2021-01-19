<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>   
<%@ taglib prefix="u" tagdir="/WEB-INF/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<title>게시물 작성</title>
</head>
<body>
<u:navbar/>

<div class="container col-3">
<h2>게시물 작성</h2>
	<form action="${root}/board/register" method="post">
		<div class="form-group">		
			<label for="input1">제목</label> 
			<input type="text" class="form-control" name="title" placeholder="제목을 입력하세요"/> <br/>
		</div>
		<div class="form-group">
			<label for="input1">내용</label> 
			<textarea class="form-control" name="content" placeholder="내용을 입력하세요" cols="30" rows="10"></textarea> <br/>
		</div>
		<div class="form-group">
			<label for="input1">작성자</label>
			<input type="text" class="form-control" name="writer" placeholder="이름을 입력하세요"/> <br/>
		</div>
		<input type="submit" class="btn btn-success" value="게시글등록"/>
		<input type="button" onclick="location.href='${root}/board/list'" value="목록" class="btn btn-dark"/>
	</form>
</div>
</body>
</html>