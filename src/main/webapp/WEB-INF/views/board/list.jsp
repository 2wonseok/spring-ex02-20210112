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
<title>list page</title>
</head>
<script>
$(document).ready(function(){
	var message = '${message}';
	
	checkModal(message);
	
	history.replaceState({}, null, null);
	
	function checkModal(message) {
		if (message && history.state == null) {
			$("#myModal .modal-body p").html(message);
			$("#myModal").modal("show");
		}
	}
	
	$('#allCheck').click(function () {
		if ($("input:checkbox[id='allCheck']").prop("checked")) {
			$("input[type=checkbox]").prop("checked", true);
		} else {
			$("input[type=checkbox]").prop("checked", false);
		}
	});
	
/* 	var searchForm = $("#searchForm");
	
	$("#searchForm button").on("click", function(e) {
		if (!searchForm.find("option:selected").val()) {
			alert('검색 종류를 선택하세요');
			return false;
		}
		
		if (!searchForm.find("input[name='keyword']").val()) {
			alert('키워드를 입력하세요.');
			return false;
		}
		
		searchForm.find("input[name='pageNum']").val("1");
		e.preventDefault();
		
		searchForm.submit();

	}); */
/* 	var actionForm = $("#actionForm");
	
 	$(".page-item a").on("click", function(e) {
		e.preventDefault();
		console.log('click');
		actionForm.find("input[name='pageNum']").val($(this).attr("href"));
		actionForm.submit();
	});  */
});
</script> 
<!-- <script>
$(document).ready(function(){
	var result = '<c:out value="${result}"/>';
	
	checkModal(result);
	
	history.replaceState({}, null, null);
	function checkModal(result) {
		//parseInt(result) > 0 
		if (result === '' || history.state) {
			return;
		}
		
		if (parseInt(result) > 0) {
			$("#myModal .modal-body p").html("게시글" + result + "번이 등록되었습니다.");
		}
		
		if (result === 'modifySuccess') {
			$("#myModal .modal-body p").html("수정이 완료되었습니다.");
		}
		
		if (result === 'deleteSuccess') {
			$("#myModal .modal-body p").html("삭제가 완료되었습니다.");
		}
		
		$("#myModal").modal("show");
	}
	
	$('#allCheck').click(function () {
		if ($("input:checkbox[id='allCheck']").prop("checked")) {
			$("input[type=checkbox]").prop("checked", true);
		} else {
			$("input[type=checkbox]").prop("checked", false);
		}
	});
});
</script> -->
<body>
<u:navbar/>

<div class="container">
<h1>board list page입니다.</h1>
	<form action="${root }/board/checkDel" method="post">
	<a href="${root}/board/register" class="btn btn-dark">글쓰기</a>
	<input type="submit" value="선택 삭제" class="btn btn-danger"/>
	<table class="table table-striped">
		<thead>
			<tr>
				<th><input type="checkbox" id="allCheck" value="${board.bno }"/></th>
				<th>번호</th>
				<th>제목</th>
				<th>작성자</th>
				<th>작성일</th>
			</tr>
		</thead>
		<c:forEach items="${list }" var="board">
			<c:url value="/board/get" var="readLink">
				<c:if test="${cri.type != null && cri.keyword != null }">
					<c:param name="type" value="${cri.type }"></c:param>
					<c:param name="keyword" value="${cri.keyword }"></c:param>
				</c:if>	
				<c:param name="bno" value="${board.bno }"></c:param>
				<c:param name="pageNum" value="${cri.pageNum }"></c:param>
				<c:param name="amount" value="${cri.amount }"></c:param>
			</c:url>
			<tr>
				<td><input type="checkbox" id="bno" name="bno" value="${board.bno }" /></td>
				<td>${board.bno }</td>
				<td>
					<a href="${readLink }"><c:out value="${board.title }"></c:out>
					<c:if test="${board.replyCnt > 0}">
						<span class="badge badge-info">
								${board.replyCnt }
						</span>
					</c:if>
					</a>
				</td>
				<td><c:out value="${board.writer }"></c:out></td>
				<td><fmt:formatDate pattern="yyyy-MM-dd" value="${board.regdate }"/></td>
			</tr>
		</c:forEach>
	</table>
	</form>
</div>
<%-- <div class="container d-flex">
	<form id="searchForm" action="${root }/board/list" method="get">
		<select name="type" class="form-control" style="width:220px; display:inline;">
			<option value=""
				<c:out value="${pageMaker.cri.type == null ? 'selected' : '' }"/>>======선택======
			<option value="T"
				<c:out value="${pageMaker.cri.type eq 'T' ? 'selected' : '' }"/>>제목</option>
			<option value="C"
				<c:out value="${pageMaker.cri.type eq 'C' ? 'selected' : '' }"/>>내용</option>
			<option value="W"
				<c:out value="${pageMaker.cri.type eq 'W' ? 'selected' : '' }"/>>작성자</option>
			<option value="TC"
				<c:out value="${pageMaker.cri.type eq 'TC' ? 'selected' : '' }"/>>제목 or 내용</option>
			<option value="TW"
				<c:out value="${pageMaker.cri.type eq 'TW' ? 'selected' : '' }"/>>제목 or 작성자</option>
			<option value="TWC"
				<c:out value="${pageMaker.cri.type eq 'TWC' ? 'selected' : '' }"/>>제목 or 내용 or 작성자</option>
		</select>
		<input type="text" name="keyword" class="form-control" placeholder="search" style="width:300px; display:inline;"/>
		<input type="hidden" class="form-control" name="pageNum" value="${pageMaker.cri.pageNum }"/>
		<input type="hidden" class="form-control" name="amount" value="${pageMaker.cri.amount }"/>
		<button class="btn btn-primary mb-1">Search</button>
	</form>
</div> --%>
<div class="container-sm mt-3">
	<div class="row justify-content-center">
		<nav aria-label="Page navigation example">
<%-- 	 	 	<form id="actionForm" action="${root }/board/list" method="get">
				<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum }">
				<input type="hidden" name="amount" value="${pageMaker.cri.amount }"> --%>
			<ul class="pagination">
				<c:if test="${pageMaker.prev}">
					<c:url value="/board/list" var="preLink">
						<c:if test="${pageMaker.cri.type != null && pageMaker.cri.keyword != null }">
							<c:param name="type" value="${pageMaker.cri.type }"></c:param>
							<c:param name="keyword" value="${pageMaker.cri.keyword }"></c:param>
						</c:if>
						<c:param name="pageNum" value="${pageMaker.startPage - 1 }"></c:param>
						<c:param name="amount" value="${pageMaker.cri.amount}"></c:param>
					</c:url>
					<li class="page-item"><a class="page-link" href="${preLink}">Previous</a></li>
			<%-- 		<li class="page-item"><a class="page-link" href="${pageMaker.startPage - 1 }">Previous</a></li> --%>
				</c:if>
				
				<c:forEach var="num" begin="${pageMaker.startPage }" end="${pageMaker.endPage }">
					<c:url value="/board/list" var="pageLink">
						<c:if test="${pageMaker.cri.type != null && pageMaker.cri.keyword != null }">
							<c:param name="type" value="${param.type }"></c:param>
							<c:param name="keyword" value="${param.keyword }"></c:param>
						</c:if>	
						<c:param name="pageNum" value="${num }"></c:param>
						<c:param name="amount" value="${pageMaker.cri.amount }"></c:param>
					</c:url>
					<li class="page-item ${pageMaker.cri.pageNum == num ? 'active' : ''}"><a class="page-link" href="${pageLink}">${num }</a></li>
					<%-- <li class="page-item ${pageMaker.cri.pageNum == num ? 'active' : ''}"><a class="page-link" href="${num}">${num }</a></li> --%>
				</c:forEach>
				
				<c:if test="${pageMaker.next }">
					<c:url value="/board/list" var="nextLink">
						<c:if test="${pageMaker.cri.type != null && pageMaker.cri.keyword != null }">
							<c:param name="type" value="${pageMaker.cri.type }"></c:param>
							<c:param name="keyword" value="${pageMaker.cri.keyword }"></c:param>
						</c:if>
						<c:param name="pageNum" value="${pageMaker.endPage + 1 }"></c:param>
						<c:param name="amount" value="${pageMaker.cri.amount}"></c:param>
					</c:url>
					<li class="page-item"><a class="page-link" href="${nextLink }">Next</a></li>
					<%-- <li class="page-item"><a class="page-link" href="${pageMaker.endPage + 1  }">Next</a></li> --%>
				</c:if>
			</ul>
<!-- 		 	</form>  -->
		</nav>
	</div>
</div>

<div class="modal" id="myModal" tabindex="-1">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title">알림</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <p>크크크크크크</p>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
      </div>
    </div>
  </div>
</div>
</body>
</html>