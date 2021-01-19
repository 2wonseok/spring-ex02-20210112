package org.zerock.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.zerock.domain.BoardVO;
import org.zerock.domain.Criteria;
import org.zerock.domain.PageDTO;
import org.zerock.service.BoardService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@AllArgsConstructor
@Log4j
@RequestMapping("/board/*")
public class BoardController {
	
	private BoardService service;

	/*
	@Autowired
	public BoardController(BoardService service) {
			super();
			this.service = service;
		}
	*/

//	@RequestMapping(value = "/list", method = RequestMethod.GET)
//	@GetMapping("/list")
//	public void list(Model model) {
//		log.info("***************** List ****************");
//		List<BoardVO> list = service.getList();
//		model.addAttribute("list", list);
//	}
	
	@GetMapping("/list")
	public void list(Criteria cri, Model model) {
		List<BoardVO> list = service.getList(cri);
		
		int total = service.getTotal(cri);
		
		model.addAttribute("list", list);
		model.addAttribute("pageMaker", new PageDTO(cri, total));
	}
	
	@GetMapping("/register")
	public void register() {
		
	}
	
	@PostMapping("/register")
	public String register(BoardVO board, Model model, RedirectAttributes rttr) {
		service.register(board);
		rttr.addFlashAttribute("result", board.getBno());
		rttr.addFlashAttribute("message", board.getBno()+"번 글이 등록되었습니다.");
		return "redirect:/board/list";
	}
	
	@GetMapping({"/get", "/modify"})	
	public void get(@RequestParam Long bno, Model model) {
		model.addAttribute("read", service.get(bno));
	}
	
	@PostMapping("/modify")
	public String modify(BoardVO board, RedirectAttributes rttr) {
		if (service.modify(board)) {
			rttr.addFlashAttribute("result", "modifySuccess");
			rttr.addFlashAttribute("message", board.getBno()+"번 글이 수정되었습니다.");
		}
		return "redirect:/board/list";
	}
	
	@PostMapping("/remove")
	public String remove(@RequestParam Long bno, RedirectAttributes rttr) {
		if (service.remove(bno)) {
			rttr.addFlashAttribute("result", "deleteSuccess");
			rttr.addFlashAttribute("message", bno+"번 글이 삭제되었습니다.");
		}
		
		return "redirect:/board/list";
	}
	
	@PostMapping("/checkDel")
	public String checkDel(@RequestParam("bno") ArrayList<Long> bno, RedirectAttributes rttr) {
		for (Long no : bno) {
			if (service.remove(no)) {
				rttr.addFlashAttribute("result", "deleteSuccess");
				rttr.addFlashAttribute("message", bno+"번 글이 삭제되었습니다.");
			}
		}
		return "redirect:/board/list";
	}
	
}
