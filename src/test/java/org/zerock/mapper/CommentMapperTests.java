package org.zerock.mapper;

import static org.junit.Assert.*;



import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.zerock.domain.BoardVO;
import org.zerock.domain.CommentVO;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class CommentMapperTests {
	
	@Setter(onMethod_ = @Autowired)
	private CommentMapper mapper;
	
	@Setter(onMethod_ = @Autowired)
	private BoardMapper bmapper;
	
	@Test
	public void testExist() {
		assertNotNull(mapper);
	}
	
	@Test
	public void testGetList() {
		List<CommentVO> list = mapper.getList();
		assertNotEquals(list.size(), 0);
	}
	
	@Test
	public void testRegister() {
		BoardVO board = new BoardVO();
		board.setTitle("게시판에 새로 작성");
		board.setContent("추가 내용");
		board.setWriter("lee won seok");
		bmapper.insertSelectKey(board);
		
		CommentVO comment = new CommentVO();
		comment.setBno(board.getBno());
		comment.setContent("신규 작성된 댓글");
		comment.setWriter("lee won seok");
		
		int before = mapper.getList().size();
		
		mapper.insertSelectKey(comment);
		
		int after = mapper.getList().size();
		
		assertEquals(before + 1, after);
	}
	
	@Test
	public void testDelete() {
		BoardVO board = new BoardVO();
		board.setTitle("testDelete");
		board.setContent("testDelete");
		board.setWriter("won seok");
		bmapper.insertSelectKey(board);
		
		CommentVO comment = new CommentVO();
		comment.setBno(board.getBno());
		comment.setContent("testDelete");
		comment.setWriter("won seok");
		mapper.insertSelectKey(comment);
		
		int before = mapper.getList().size();
		
		int cnt = mapper.delete(comment.getCno());
		bmapper.delete(board.getBno());
		
		assertEquals(1, cnt);
		
		int after = mapper.getList().size();
		
		assertEquals(before - 1, after);
	}
	
	@Test
	public void testUpdate() {
		BoardVO board = new BoardVO();
		board.setTitle("testUpdate");
		board.setContent("testUpdate");
		board.setWriter("won seok");
		bmapper.insertSelectKey(board);
		
		CommentVO comment = new CommentVO();
		comment.setBno(board.getBno());
		comment.setContent("testUpdate");
		comment.setWriter("won seok");
		mapper.insertSelectKey(comment);
		
		comment.setContent("변경된 내용z");
		mapper.update(comment);
		
		int cnt = mapper.update(comment);
		
		assertEquals(1, cnt);
		
		CommentVO updateVO = mapper.read(comment.getCno());
		assertEquals("변경된 내용z", updateVO.getContent());
		
	}
	
	@Test
	public void testRead() {
		BoardVO board = new BoardVO();
		board.setTitle("testRead");
		board.setContent("testRead에서 작성됨");
		board.setWriter("wonseok");
		bmapper.insertSelectKey(board);
		
		CommentVO comment = new CommentVO();
		comment.setBno(board.getBno());
		comment.setContent("testRead");
		comment.setWriter("wonseok");

		mapper.insertSelectKey(comment);
		
		CommentVO readComment = mapper.read(comment.getCno());
		
		assertNotNull(readComment);
		assertNotEquals(readComment.getCno(), 0L);
	}
}
