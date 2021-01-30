<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="u" tagdir="/WEB-INF/tags"%>
<!DOCTYPE html>
<html>
<head>
<script>
var appRoot = '${root}';
var bno = '${read.bno}';
</script>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script src="${root }/resources/js/reply.js"></script>
<script>
//	console.log(replyService.name);
//	replyService.add("my reply");
/* replyService.add({
		bno:321, 
		reply:"new reply 댓글", 
		replyer:"tester"
	}, function(result) {
		console.log(result);
	}, function(err) {
		console.log(err);
	}); */
	
/* replyService.getList(
	{bno:321,page:1},
	function(data) {
		console.log(data);
	},
	function() {
		console.log("error");
	});	 */
	
/* replyService.remove(62, function(data) {
			console.log(data);
		}, function(error) {
				console.log(error);
		}); */

/* replyService.update(
		{rno:63, reply:"update reply~ㅋㅋ"},
		function(data) {
			console.log(data);
		}, function(error) {
				console.log(error);
		}); */
		
/* replyService.get(63, function(data) {
	console.log(data);
}, function(error) {
	console.log(error);
}); */
</script>
<script>
	$(document).ready(function() {
		
		function dateString(date) {
			var d = new Date(date);
			return d.toISOString().split("T")[0];
		}
		
		function showList() {
			replyService.getList({bno:bno}, function(list) {
				//console.log(list);
				var replyUL = $("#reply-ul").empty();
				
				for (var i = 0; i < list.length; i++) {
					var rno = list[i].rno;
					var replyer = list[i].replyer;
					var replyDate = list[i].replyDate;
					var reply = list[i].reply;
					
					var replyLI = '<li class="media" data-rno="'+rno+'">'+
												'<div class="media-body">'+
												'<h5>'+replyer+' <small class="float-right">'+dateString(replyDate)+'</small>'+
												'</h5>'+reply+'<hr></div></li>';
					
					replyUL.append(replyLI);
				}
			});
		} // showList and
		
		$("#new-reply-button").click(function() {
			console.log("new-reply-button click");
			$("#new-reply-modal").modal("show");
			
		}); //new-reply-button and
		
		$("#reply-submit-button").click(function() {
			var reply = $("#reply-input").val();
			var replyer = $("#replyer-input").val();
			
			var data = {bno:bno, reply:reply , replyer:replyer};
			
			replyService.add(data, function() {
				showList();
				alert('등록 성공');
			}, function() {
				alert('등록 실패');
			});
			
			$("#new-reply-modal").modal("toggle"); // 등록 이후 modal 닫기
			$("#new-reply-modal input").val(""); // 밸류값 초기화
			
		}); //reply-submit-button
		
		// 하나의 댓글 조회
		$("#reply-ul").on("click","li", function() {
			//console.log("reply ul clicked.....");
			//console.log($(this).attr("data-rno"));
			var rno = $(this).attr("data-rno");
			
			replyService.get(rno, function(data) {
				$("#rno-input2").val(rno);
				$("#reply-input2").val(data.reply);
				$("#replyer-input2").val(data.replyer);
				$("#modify-reply-modal").modal("show");
			});
		});
		
		// 수정
		$("#reply-modify-button").click(function() {
			var reply = $("#reply-input2").val();
			var rno = $("#rno-input2").val();

			var data = {rno:rno , reply: reply};

			replyService.update(data, function() {
				alert('수정 성공');
				$("#modify-reply-modal").modal("toggle"); // 등록 이후 modal 닫기
				$("#modify-reply-modal input").val(""); // 밸류값 초기화
				showList();
			});
		});
		
		// 삭제
		$("#reply-remove-button").click(function() {
			var rno = $("#rno-input2").val();
			
			var con = confirm("삭제하시겠습니까?");
			
			if (con) {
				replyService.remove(rno, function() {
					alert('삭제되었습니다.');
					$("#modify-reply-modal").modal("toggle"); // 등록 이후 modal 닫기
					$("#modify-reply-modal input").val(""); // 밸류값 초기화
					showList();
				}, function() {
					alert('삭제 실패');
				});
			} else {
				return false;
			}
		});
		
		
		showList();
	});	

</script>
<title>get Page</title>
</head>
<body>
<u:navbar/>

<div class="container col-6">
<h2>게시물 보기</h2>
	<div class="form-group">		
		<label for="input1">번호</label> 
		<input type="text" class="form-control" value="${read.bno }"  readonly/> <br/>
	</div>
	<div class="form-group">
		<label for="input2">제목</label> 
		<input type="text" class="form-control" value="<c:out value='${read.title }'/>"  readonly/><br/>
	</div>
	<div class="form-group">
		<label for="input3">내용</label> 
		<textarea class="form-control" readonly><c:out value="${read.content }"/></textarea> <br/>
	</div>
	<div class="form-group">
		<label for="input4">작성자</label> 
		<input type="text" class="form-control"  value="<c:out value='${read.writer }'/>"  readonly/> <br/>
	</div>
	<c:url value="/board/modify" var="modifyLink">
		<c:if test="${cri.type != null && cri.keyword != null }">
			<c:param name="type" value="${cri.type }"></c:param>
			<c:param name="keyword" value="${cri.keyword }"></c:param>
		</c:if>
		<c:param name="bno" value="${read.bno }"></c:param>
		<c:param name="pageNum" value="${cri.pageNum }"></c:param>
		<c:param name="amount" value="${cri.amount }"></c:param>
	</c:url>
	<a href="${modifyLink}" class="btn btn-secondary">수정</a>
		<%-- <a href="${root}/board/list?pageNum=${param.pageNum}&?amount=${param.amount}" class="btn btn-primary">뒤로가기</a> --%>
<%-- 		<a href="${root}/board/remove?bno=${read.bno}" class="btn btn-danger">삭제</a> --%>
</div>

<div class="container col-6 mt-3">
	<div class="card">
		<div class="card-header d-flex justify-content-between align-items-center">
			<span>
				댓글 목록
			</span>
			<button class="btn btn-info" id="new-reply-button">댓글 달기</button>
		</div>
		
		<div class="card-body">
			<ul class="list-unstyled" id="reply-ul">				
			</ul>
		</div>
	</div>
</div>

<div class="modal fade" id="new-reply-modal">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title">
					새 댓글
				</h5>
				<button type="button" class="close" data-dismiss="modal">
					<span>&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<div class="form-group">
					<label for="reply-input" class="col-form-label">
						댓글
					</label>
					<input type="text" class="form-control" id="reply-input">
				</div>
				<div class="form-group">
					<label for="replyer-input" class="col-form-label">
						작성자
					</label>
					<input type="text" class="form-control" id="replyer-input">
				</div>	
			</div>
			
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
				<button type="button" class="btn btn-primary" id="reply-submit-button">등록</button>
			</div>
			
		</div>
	</div>
</div>

<div class="modal fade" id="modify-reply-modal">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title">
					수정 / 삭제
				</h5>
				<button type="button" class="close" data-dismiss="modal">
					<span>&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<input type="hidden" id="rno-input2"/>
				<div class="form-group">
					<label for="reply-input2" class="col-form-label">
						댓글
					</label>
					<input type="text" class="form-control" id="reply-input2">
				</div>
				<div class="form-group">
					<label for="replyer-input2" class="col-form-label">
						작성자
					</label>
					<input type="text" class="form-control" id="replyer-input2" readonly>
				</div>	
			</div>
			
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
				<button type="button" class="btn btn-primary" id="reply-modify-button">수정</button>
				<button type="button" class="btn btn-danger" id="reply-remove-button">삭제</button>
			</div>
			
		</div>
	</div>
</div>
</body>
</html>