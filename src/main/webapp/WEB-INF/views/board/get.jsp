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
<title>get Page</title>
</head>
<body>
<u:navbar/>

<div class="container col-6">
<h2>게시물 보기</h2>
		<div class="form-group">		
			<label for="input1">번호</label> 
			<input type="text" class="form-control" value="${read.bno }" name="bno" readonly/> <br/>
		</div>
		<div class="form-group">
			<label for="input2">제목</label> 
			<input type="text" class="form-control" name="title" value="<c:out value='${read.title }'/>"  readonly/><br/>
		</div>
		<div class="form-group">
			<label for="input3">내용</label> 
			<textarea class="form-control" name="content" readonly><c:out value="${read.content }"/></textarea> <br/>
		</div>
		<div class="form-group">
			<label for="input4">작성자</label> 
			<input type="text" class="form-control" name="writer" value="<c:out value='${read.writer }'/>"  readonly/> <br/>
		</div>				
		<a href="${root}/board/modify?bno=${read.bno}" class="btn btn-secondary">수정</a>
		<a href="${root}/board/list?pageNum=${param.pageNum}&?amount=${param.amount}" class="btn btn-primary">뒤로가기</a>
<%-- 		<a href="${root}/board/remove?bno=${read.bno}" class="btn btn-danger">삭제</a> --%>
</div>
</body>
</html>