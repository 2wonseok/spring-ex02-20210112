package org.zerock.service;

import static org.junit.Assert.*;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.zerock.domain.CommentVO;
import org.zerock.mapper.CommentMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class CommentServiceTests {
	
/*인터페이스를 구현하는 클래스가 2개 이상일경우 @Qualifire("빈 이름") 으로 명시
	@Autowired
	@Qualifire("빈 이름(클래스명 앞이 소문자)")
	private CommentService service;
*/	
	@Setter(onMethod_ = @Autowired)
	private CommentService service;
	
	@Setter(onMethod_ = @Autowired)
	private CommentMapper mapper;
	
	@Test
	public void testExist() {
		assertNotNull(service);
	}
	
	@Test
	public void testGetList() {
		List<CommentVO> list = service.getList();
		assertNotEquals(list.size(), 0);
	}
	
	@Test
	public void testRegister() {

		CommentVO comment = new CommentVO();
		comment.setBno(3L);
		comment.setContent("신규 작성된 댓글");
		comment.setWriter("lee won seok");
		
		int before = service.getList().size();
		
		service.register(comment);
		
		int after = service.getList().size();
		
		assertEquals(before + 1, after);
	}
	
	@Test
	public void testDelete() {
		CommentVO comment = new CommentVO();
		comment.setBno(3L);
		comment.setContent("testDelete");
		comment.setWriter("won seok");
		service.register(comment);
		
		int before = service.getList().size();
		
		service.remove(3L);
		
		assertTrue(service.remove(comment.getCno()));
		
		int after = service.getList().size();
		
		assertEquals(before - 1, after);
	}
	
	@Test
	public void testUpdate() {
		CommentVO comment = new CommentVO();
		comment.setBno(3L);
		comment.setContent("testUpdate");
		comment.setWriter("won seok");
		service.register(comment);
		
		comment.setContent("변경된 내용service");
		service.modify(comment);
		
		int cnt = mapper.update(comment);
		
		assertEquals(1, cnt);
		
		CommentVO updateVO = service.get(comment.getCno());
		assertEquals("변경된 내용service", updateVO.getContent());
		
	}
	
	@Test
	public void testRead() {
		CommentVO comment = new CommentVO();
		comment.setBno(3L);
		comment.setContent("testRead");
		comment.setWriter("wonseok");

		service.register(comment);
		
		CommentVO readComment = service.get(comment.getCno());
		
		assertNotNull(readComment);
		assertNotEquals(readComment.getCno(), 0L);
	}
}
