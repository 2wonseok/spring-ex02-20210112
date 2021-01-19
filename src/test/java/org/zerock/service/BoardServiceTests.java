package org.zerock.service;

import static org.junit.Assert.*;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.ui.Model;
import org.zerock.domain.BoardVO;
import org.zerock.domain.Criteria;
import org.zerock.mapper.BoardMapper;
import org.zerock.mapper.BoardMapperTests;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class BoardServiceTests {
	
	@Setter(onMethod_ = @Autowired)
	private BoardService service;
	
	@Setter(onMethod_ = @Autowired)
	private BoardMapper mapper;
	
	@Test
	public void testExist() {
		assertNotNull(service);
	}
	
//	@Test
//	public void testRegister() {
//		BoardVO board = new BoardVO();
//		board.setTitle("testRegister");
//		board.setContent("새로 작성하는 내용");
//		board.setWriter("이원석");
//		
//		int before = mapper.getList().size();
//		
//		service.register(board);
//		
//		int after = mapper.getList().size();
//		
//		assertEquals(before + 1, after);
//	}

	@Test
	public void testList() {
		Criteria cri = new Criteria(2, 10);
		List<BoardVO> list = service.getList(cri);
		
		assertNotNull(list);
		assertNotEquals(list.size(),0);
		assertEquals(list.size(), 10);
	}
	
//	@Test
//	public void testGetList() {
//		List<BoardVO> list = service.getList();
//		
//		assertNotNull(list);
//		assertNotEquals(list.size(), 0);
//	}
	
//	@Test
//	public void testGet() {
//		BoardVO board = new BoardVO();
//		board.setTitle("testGet");
//		board.setContent("testGet에서 새로 작성하는 내용");
//		board.setWriter("이원석");
//		
//		service.register(board);
//		
//		BoardVO read = service.get(board.getBno());
//		
//		assertNotNull(read);
//		assertEquals(read.getBno(), board.getBno());
//	}
//	
//	@Test
//	public void testDelete() {
//		BoardVO board = new BoardVO();
//		board.setTitle("testDelete");
//		board.setContent("testRemove에서 새로 작성하는 내용");
//		board.setWriter("이원석");
//		
//		service.register(board);
//		
//		boolean remove = service.remove(board.getBno());
//		
//		assertTrue(remove);
//	}
//	
//	@Test
//	public void testUpdate() {
//		BoardVO board = new BoardVO();
//		board.setTitle("testUpdate");
//		board.setContent("testModify에서 새로 작성하는 내용");
//		board.setWriter("이원석");
//		
//		service.register(board);
//		
//		BoardVO update = new BoardVO();
//		update.setBno(board.getBno());
//		update.setTitle("testModify");
//		update.setContent("testModify에서 수정한 내용");
//		update.setWriter(board.getWriter());
//		
//		boolean modify = service.modify(update);
//		
//		assertTrue(modify);
//		
//		BoardVO update2 = service.get(board.getBno());
//		
//		assertEquals("testModify", update2.getTitle());
//		assertEquals("testModify에서 수정한 내용", update2.getContent());
//	}
}
