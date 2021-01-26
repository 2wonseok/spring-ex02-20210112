package org.zerock.mapper;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotEquals;
import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.fail;

import java.util.List;
import java.util.stream.IntStream;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.zerock.domain.BoardVO;
import org.zerock.domain.Criteria;
import org.zerock.domain.ReplyVO;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class ReplyMapperTests {
	
	private Long[] bnoArr = {281L, 283L, 301L, 302L, 321L};
	
	@Setter(onMethod_ = @Autowired)
	private ReplyMapper mapper;
	
	@Test
	public void testExist() {
		assertNotNull(mapper);
	}
	
	@Test
	public void testCreate() {
		IntStream.rangeClosed(1, 10).forEach(i -> {
			log.info(i + ", " + (i % 5));
			
			ReplyVO vo = new ReplyVO();
			vo.setBno(bnoArr[i % 5]);
			vo.setReply("댓글 테스트 ㅎ");
			vo.setReplyer("원석" + i);
			
			mapper.insert(vo);
		});
	}
	
	@Test
	public void testCreate2() {
		ReplyVO vo = new ReplyVO();
		vo.setBno(321L);
		vo.setReply("댓글 테스트");
		vo.setReplyer("wonseok");
		
		mapper.insert(vo);
		
		try {
			vo.setBno(300L);
			mapper.insert(vo);
			fail();
		} catch (Exception e) {
			
		}
	}
	
	@Test
	public void testRead() {
		Long targetRno = 6L;
		
		ReplyVO vo = mapper.read(targetRno);
		
		log.info(vo);
		assertEquals("댓글 테스트", vo.getReply());
	}
	
	@Test
	public void testDelete() {
		Long targetRno = 14L;
		
		mapper.delete(targetRno);
	}
	
	@Test
	public void testUpdate() {
		Long targetRno = 10L;
		
		ReplyVO vo = mapper.read(targetRno);
		
		vo.setReply("Update Reply2");
		
		mapper.update(vo);
		
		assertEquals("Update Reply2", vo.getReply());
		
	}
	
	@Test
	public void testList() {
		Criteria cri = new Criteria();
		List<ReplyVO> replies = mapper.getListWithPaging(cri, bnoArr[1]);
		assertNotEquals(0, replies.size());
//		replies.forEach(reply -> log.info(reply));
	}
}






