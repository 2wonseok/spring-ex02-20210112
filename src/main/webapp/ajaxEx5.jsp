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
<script>
	$(document).ready(function() {
		$("#btn-1").click(function() {
			$.ajax("/replies/new", {
				type: "post",
				contentType:"application/json",
				data:'{"bno":321,"reply":"새 댓글2!", "replyer":"이원석"}',
				complete: function(jqXHR, status) {
					console.log("complete");
					console.log(status);
				}
			});
		});
		
		$("#btn-2").click(function() {
			$.ajax("/replies/new", {
				type: "post",
				contentType:"application/json",
				data:'{"reply":"새 댓글2!", "replyer":"이원석"}',
				complete: function(jqXHR, status) {
					console.log("errors");
					console.log(status);
				}
			});
		});
		
		$("#btn-3").click(function() {
			$.ajax("/replies/new", {
				type: "post",
				contentType:"application/json",
				data:'{"bno":321, "reply":"0128댓글", "replyer":"이원석"}',
			}).done(function(data, status, xhr) {
				console.log("등록 성공");
				console.log(data);
			}).fail(function() {
				console.log("등록 실패");
			});
		});
		
		$("#btn-4").click(function() {
			$.ajax("/replies/pages/321/1", {
				type: "get",
				contentType:"application/json"
			}).done(function(data, status, xhr) {
				console.log(data);
			});
		});
		
		$("#btn-5").click(function() {
			$.ajax("/replies/55", {
				type: "put",
				data: '{"bno":321,"reply":"수정테스트"}',
				contentType:"application/json"
			}).done(function(data, status, xhr) {
				console.log("수정을 성공했습니다.");
				console.log(data);
			}).fail(function() {
				console.log("수정 실패");
			});
		});
		
		$("#btn-6").click(function() {
			$.ajax("/replies/61", {
				type: "delete",
				contentType:"application/json"
			}).done(function(data, status, xhr) {
				console.log("삭제 성공.");
				console.log(data);
			}).fail(function() {
				console.log("삭제 실패");
			});
		});
		
		$("#btn-7").click(function () {
			$.ajax("/replies/64", {
				type: "get",
				contentType:"application/json",
			}).done(function(data) {
				console.log(data);
			});
		});
		
	});
</script>
<title>Insert title here</title>
</head>
<body>
<h1>AJAX ex 5</h1>
<div>
	<button id="btn-1">댓글 등록 성공</button>
</div>
<div>
	<button id="btn-2">댓글 등록 실패</button>
</div>
<div>
	<button id="btn-3">댓글 등록 성공 또는 실패</button>
</div>
<div>
	<button id="btn-4">댓글 목록 보기</button>
</div>
<div>
	<button id="btn-5">댓글 수정</button>
</div>
<div>
	<button id="btn-6">댓글 삭제</button>
</div>
<div>
	<button id="btn-7">댓글 조회</button>
</div>
</body>
</html>