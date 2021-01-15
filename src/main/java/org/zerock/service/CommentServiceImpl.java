package org.zerock.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.zerock.domain.CommentVO;
import org.zerock.mapper.BoardMapper;
import org.zerock.mapper.CommentMapper;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Service
@AllArgsConstructor
@Log4j
public class CommentServiceImpl implements CommentService {
	
	private CommentMapper mapper;

	@Override
	public void register(CommentVO comment) {
		mapper.insertSelectKey(comment);
	}

	@Override
	public List<CommentVO> getList() {
		return mapper.getList();
	}

	@Override
	public CommentVO get(Long cno) {
		return mapper.read(cno);
	}

	@Override
	public boolean remove(Long cno) {
		return mapper.delete(cno) == 1;
	}

	@Override
	public boolean modify(CommentVO comment) {
		return mapper.update(comment) == 1;
	}
}
