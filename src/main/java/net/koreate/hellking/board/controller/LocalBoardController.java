package net.koreate.hellking.board.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import lombok.RequiredArgsConstructor;
import net.koreate.hellking.board.service.LocalBoardService;
import net.koreate.hellking.board.vo.LocalBoardVO;

@Controller
@RequiredArgsConstructor
@RequestMapping("/board")
public class LocalBoardController {

	private final LocalBoardService service;

	/**
	 * 게시글 작성 페이지 요청 
	 * Get : board/register
	 */
	@GetMapping("localregister")
	public void register() throws Exception{
		System.out.println("게시글 작성 페이지 요청");
	}	
	
	/**
	 * 게시글 등록 요청 처리
	 * Post : board/register 
	 */
	@PostMapping("localregister")
	public String registerPost(LocalBoardVO board, HttpSession session) throws Exception {
		System.out.println("param data : " + board);
		String result = service.regist(board);
		session.setAttribute("msg", result);
		return "redirect:/board/localboard";
	}
	
	/**
	 * 게시글 상세보기 요청 시 조회 수 증가
	 * GET : board/readPage
	 */
	@GetMapping("localreadPage")
	public String readPage(int bno, Model model) throws Exception{
		
		// 조회수 증가
		service.updateCnt(bno);
		
		// 상세보기 게시글 정보
		LocalBoardVO board = service.read(bno);
		model.addAttribute("list", board);
		
		return "board/localread";
	}

	/*
	 * @GetMapping("board/localboard/{categoryId}")
	 * 
	 * @ResponseBody public List<LocalBoardVO> findCategory(@PathVariable int
	 * categoryId) throws Exception {
	 * 
	 * return service.findCategory(categoryId); }
	 */
	
	/**
	 * 게시글 수정 페이지 요청
	 * GET : board/modify
	 */
	@GetMapping("board/localmodify")
	public void modify(int bno, Model model) throws Exception{
		LocalBoardVO board = service.read(bno);
		model.addAttribute(board); // boardVO
	}
	
	
	/**
	 * 게시글 수정 요청 처리 -> 수정된 게시글 상세보기 페이지 이동
	 * Post : board/modify
	 */
	@PostMapping("board/localmodify")
	public String modify(LocalBoardVO board, HttpSession session)throws Exception{
		String result = service.modify(board);
		session.setAttribute("result", result);
		return "redirect:/board/localboard/readPage?bno=" + board.getBno();
	}
	
	
	/**
	 * 게시글 삭제 요청 처리 -> 게시글 삭제 후 목록 페이지 이동
	 * Get : board/remove 
	 */
	@GetMapping("board/localremove")
	public String remove(int bno, HttpSession session) throws Exception{
		String result = service.remove(bno);
		session.setAttribute("result", result);
		return "redirect:/board/localboard";
	}
	
	
	@PostMapping("board/localagree")
	@ResponseBody
	public int plusAgree(@RequestParam("bno") int bno) throws Exception{
		service.plusAgree(bno); // 추천수 증가
		int result = service.AgreeCount(bno);
		System.out.println(result);
		return result;
	}
	
	
	
	
}
