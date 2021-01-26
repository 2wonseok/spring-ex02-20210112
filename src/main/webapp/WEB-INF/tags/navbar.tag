<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<script>
/* $(document).ready(function(){
	var searchForm = $("#searchForm");
	
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
	
	});
}); */
</script>
<div class="container-sm mb-3">

<nav class="navbar navbar-expand-lg navbar-light bg-light">
  <a class="navbar-brand" href="${root }/board/list">게시판</a>
  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
    <span class="navbar-toggler-icon"></span>
  </button>
<c:url value="/board/list" var="listLink">
	<c:if test="${cri.type != null && cri.keyword != null }">
		<c:param name="type" value="${cri.type }"></c:param>
		<c:param name="keyword" value="${cri.keyword }"></c:param>
	</c:if>
	<c:if test="${cri.pageNum != null && cri.amount != null }">	
		<c:param name="pageNum" value="${cri.pageNum }"></c:param>
		<c:param name="amount" value="${cri.amount }"></c:param>
	</c:if>
</c:url>
  <div class="collapse navbar-collapse" id="navbarSupportedContent">
    <ul class="navbar-nav mr-auto">
      <li class="nav-item active">
	     	<a class="nav-link" href="${listLink }">목록 <span class="sr-only">(current)</span></a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="${root }/board/register">글쓰기</a>
      </li>
    </ul>
		<form id="searchForm" action="${root }/board/list" method="get" class="form-inline my-2 my-lg-0">
			<select name="type" required class="custom-select my-1 mr-sm-2" id="inlineFormCustomSelectPref">
				<option value=""
					<c:out value="${cri.type == null ? 'selected' : '' }"/>>======선택======</option>
				<option value="T"
					<c:out value="${cri.type eq 'T' ? 'selected' : '' }"/>>제목</option>
				<option value="C"
					<c:out value="${cri.type eq 'C' ? 'selected' : '' }"/>>내용</option>
				<option value="W"
					<c:out value="${cri.type eq 'W' ? 'selected' : '' }"/>>작성자</option>
				<option value="TC"
					<c:out value="${cri.type eq 'TC' ? 'selected' : '' }"/>>제목 or 내용</option>
				<option value="TW"
					<c:out value="${cri.type eq 'TW' ? 'selected' : '' }"/>>제목 or 작성자</option>
				<option value="TWC"
					<c:out value="${cri.type eq 'TWC' ? 'selected' : '' }"/>>제목 or 내용 or 작성자</option>
			</select>
			<input type="search" required name="keyword" value="${cri.keyword }" class="form-control mr-sm-2"  placeholder="Search" aria-label="Search"/>
			<input type="hidden" name="pageNum" value="1"/>
			<input type="hidden" name="amount" value="${cri.amount }"/>
			<button class="btn btn-outline-success my-2 my-sm-0" type="submit">Search</button>
		</form>
  </div>
</nav>

</div>
