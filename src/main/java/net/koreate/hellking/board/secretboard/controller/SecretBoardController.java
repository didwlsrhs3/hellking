package net.koreate.hellking.board.secretboard.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import lombok.RequiredArgsConstructor;
import net.koreate.hellking.board.secretboard.service.SecretBoardService;
import net.koreate.hellking.board.secretboard.vo.SecretBoardVO;
import net.koreate.hellking.common.util.Criteria;
import net.koreate.hellking.common.util.PageMaker;

@Controller
@RequiredArgsConstructor
@RequestMapping("/board")
public class SecretBoardController {

	private final SecretBoardService service;

	/**
	 * 게시글 작성 페이지 요청 
	 * Get : board/register
	 */
	@GetMapping("secretregister")
	public void register() throws Exception{
		System.out.println("게시글 작성 페이지 요청");
	}	
	
	/**
	 * 게시글 등록 요청 처리
	 * Post : board/register 
	 */
	@PostMapping("secretregister")
	public String registerPost(SecretBoardVO board, HttpSession session) throws Exception {
		System.out.println("param data : " + board);
		String result = service.regist(board);
		session.setAttribute("msg", result);
		return "redirect:/board/secretboard";
	}
	
	/**
	 * 게시글 상세보기 요청 시 조회 수 증가
	 * GET : board/readPage
	 */
	@GetMapping("secretreadPage")
	public String readPage(int bno, Model model) throws Exception{
		
		// 조회수 증가
		service.updateCnt(bno);
		
		// 상세보기 게시글 정보
		SecretBoardVO board = service.read(bno);
		model.addAttribute("list", board);
		
		return "board/secretread";
	}
	
	
	/**
	 * 게시글 수정 페이지 요청
	 * GET : board/modify
	 */
	@GetMapping("board/modify")
	public void modify(int bno, Model model) throws Exception{
		SecretBoardVO board = service.read(bno);
		model.addAttribute(board); // boardVO
	}
	
	
	/**
	 * 게시글 수정 요청 처리 -> 수정된 게시글 상세보기 페이지 이동
	 * Post : board/modify
	 */
	@PostMapping("board/modify")
	public String modify(SecretBoardVO board, HttpSession session)throws Exception{
		String result = service.modify(board);
		session.setAttribute("result", result);
		return "redirect:/board/secretboard/readPage?bno=" + board.getBno();
	}
	
	
	/**
	 * 게시글 삭제 요청 처리 -> 게시글 삭제 후 목록 페이지 이동
	 * Get : board/remove 
	 */
	@GetMapping("board/secretremove")
	public String remove(int bno, HttpSession session) throws Exception{
		String result = service.remove(bno);
		session.setAttribute("result", result);
		return "redirect:/board/secretboard";
	}
	
	
	@PostMapping("board/secretagree")
	@ResponseBody
	public int plusAgree(@RequestParam("bno") int bno) throws Exception{
		service.plusAgree(bno); // 추천수 증가
		int result = service.AgreeCount(bno);
		System.out.println(result);
		return result;
	}
	
	
	
	
}
