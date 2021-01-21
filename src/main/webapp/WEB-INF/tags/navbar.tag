<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<div class="container-sm mb-3">

<nav class="navbar navbar-expand-lg navbar-light bg-light">
  <a class="navbar-brand" href="${root }/board/list">게시판</a>
  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
    <span class="navbar-toggler-icon"></span>
  </button>
<c:url value="/board/list" var="listLink">
	<c:if test="${param.type != null && param.keyword != null }">
		<c:param name="type" value="${param.type }"></c:param>
		<c:param name="keyword" value="${param.keyword }"></c:param>
	</c:if>
	<c:if test="${param.pageNum  != null && param.amount != null }">	
		<c:param name="pageNum" value="${param.pageNum }"></c:param>
		<c:param name="amount" value="${param.amount }"></c:param>
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
  </div>
</nav>

</div>
