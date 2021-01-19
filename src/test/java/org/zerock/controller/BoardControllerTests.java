package org.zerock.controller;

import static org.junit.Assert.*;

import java.util.List;
import java.util.Map;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MockMvcBuilder;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.ResultActions;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.servlet.FlashMap;
import org.springframework.web.servlet.ModelAndView;
import org.zerock.domain.BoardVO;
import org.zerock.mapper.BoardMapper;
import org.zerock.service.CommentServiceTests;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@WebAppConfiguration
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(
		{"file:src/main/webapp/WEB-INF/spring/root-context.xml",
			"file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml"})
@Log4j
public class BoardControllerTests {
	
	@Setter(onMethod_ = @Autowired)
	private WebApplicationContext ctx;
	
	@Setter(onMethod_ = @Autowired)
	private BoardMapper mapper;
	
	private MockMvc mockMvc;
	
	@Before
	public void setup() {
		this.mockMvc = MockMvcBuilders.webAppContextSetup(ctx).build();
	}
	
	@Test
	public void testExist() {
		assertNotNull(ctx);
		assertNotNull(mockMvc);
	}
	
	@Test
	public void testListPaging() throws Exception {

		MvcResult result = mockMvc.perform(MockMvcRequestBuilders.get("/board/list")
				.param("pageNum", "2")
				.param("amount", "10"))
				.andReturn();
		
		Map<String, Object> model = result.getModelAndView().getModel();
		List list = (List) model.get("list");
		
		assertEquals(10, list.size());
	}
	
//	@Test
//	public void testList() throws Exception {
////		ResultActions result = mockMvc.perform(MockMvcRequestBuilders.get("/board/list"));
////		MvcResult rs = result.andReturn();
////		ModelAndView mv = rs.getModelAndView();
////		log.info(mv.getView());
////		log.info(mv.getModel().get("list"));
//		
//		Object o = mockMvc.perform(MockMvcRequestBuilders.get("/board/list"))
//				.andReturn()
//				.getModelAndView()
//				.getModel().get("list");
//		
//		assertNotNull(o);
//		assertTrue(o instanceof List);
//		assertNotEquals(((List) o).size(), 0);
//	}
	
	@Test
	public void testRegister() throws Exception {
		int before = mapper.getList().size();
		
		MvcResult result = mockMvc.perform(MockMvcRequestBuilders.post("/board/register")
				.param("title", "새로 작성한 글")
				.param("content", "새로 작성한 내용")
				.param("writer", "leewonseok"))
				.andReturn();
		
		ModelAndView mv = result.getModelAndView();
		FlashMap map = result.getFlashMap();
		
		int after = mapper.getList().size();
		
		assertEquals(before + 1, after);
		assertEquals("redirect:/board/list", mv.getViewName());
		assertNotNull(map.get("result"));
		
		log.info(map.get("result") + "*************************");
	}
	
	@Test
	public void testGet() throws Exception {
		MvcResult result = mockMvc.perform(MockMvcRequestBuilders.get("/board/get")
				.param("bno", "1"))
			.andReturn();
		
		String viewName = result.getModelAndView().getViewName();
		Map<String, Object> modelMap = result.getModelAndView().getModel();
		
		assertEquals("board/get", viewName);
		assertNotNull(modelMap.get("read"));
		assertEquals(new Long(1), ((BoardVO) modelMap.get("read")).getBno());
	}
	
	@Test
	public void testModify() throws Exception {
		BoardVO board = new BoardVO();
		board.setContent("새 게시물");
		board.setTitle("새 제목");
		board.setWriter("user00");
		mapper.insertSelectKey(board);
		
		Long key = board.getBno();
		
		MvcResult result = mockMvc.perform(MockMvcRequestBuilders.post("/board/modify")
				.param("bno", key + "")
				.param("title", "수정한 제목112")
				.param("content", "수정한 내용112")
				.param("writer", "user00"))
				.andReturn();
		
		BoardVO mod = mapper.read(key);
		ModelAndView mv = result.getModelAndView();
		FlashMap map = result.getFlashMap();
		
		assertEquals("수정한 제목112", mod.getTitle());
		assertEquals("수정한 내용112", mod.getContent());
		assertEquals("redirect:/board/list", mv.getViewName());
		assertEquals("success", map.get("result"));
		
		log.info(map.get("result") + "*************************");
				
	}
	
	@Test
	public void testRemove() throws Exception {
		BoardVO board = new BoardVO();
		board.setContent("삭제할 게시물");
		board.setTitle("삭제할 제목");
		board.setWriter("user00");
		mapper.insertSelectKey(board);
		
		Long key = board.getBno();
		
		int before = mapper.getList().size();
		
		MvcResult result = mockMvc.perform(MockMvcRequestBuilders.post("/board/remove")
				.param("bno", key + ""))
				.andReturn();
		
		String viewName = result.getModelAndView().getViewName();
		int after = mapper.getList().size();
		
		assertEquals(before - 1, after);
		assertEquals("redirect:/board/list", viewName);
		assertEquals("success", result.getFlashMap().get("result"));		
	}
}
