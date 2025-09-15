package net.koreate.hellking.board.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import lombok.RequiredArgsConstructor;
import net.koreate.hellking.board.service.BoardService;
import net.koreate.hellking.board.service.LocalBoardService;
import net.koreate.hellking.board.service.SecretBoardService;
import net.koreate.hellking.board.vo.BoardVO;
import net.koreate.hellking.board.vo.LocalBoardVO;
import net.koreate.hellking.board.vo.SecretBoardVO;
import net.koreate.hellking.common.util.Criteria;
import net.koreate.hellking.common.util.PageMaker;

@Controller
@RequiredArgsConstructor
public class BoardController {
	
	private final BoardService service;
	private final SecretBoardService sService;
	private final LocalBoardService lService;

	/**
	 * 게시글 작성 페이지 요청 
	 * Get : board/register
	 */
	@GetMapping("board/register")
	public void register() throws Exception{
		System.out.println("게시글 작성 페이지 요청");
		// "/WEB-INF/views/" + "board/register" + ".jsp"	
		//  /WEB-INF/views/board/register.jsp
	}	
	
	/**
	 * 게시글 등록 요청 처리
	 * Post : board/register 
	 */
	@PostMapping("board/register")
	public String registerPost(BoardVO board, HttpSession session) throws Exception {
		System.out.println("param data : " + board);
		String result = service.regist(board);
		session.setAttribute("msg", result);
		return "redirect:/";
	}
	
	/**
	 * 게시글 상세보기 요청 시 조회 수 증가
	 * GET : board/readPage
	 */
	@GetMapping("board/readPage")
	public String readPage(int bno, Model model) throws Exception{
		
		// 조회수 증가
		service.updateCnt(bno);
		
		// 상세보기 게시글 정보
		BoardVO board = service.read(bno);
		model.addAttribute("list", board);
		
		return "board/read";
	}
	
	
	/**
	 * 게시글 수정 페이지 요청
	 * GET : board/modify
	 */
	@GetMapping("board/modify")
	public void modify(int bno, Model model) throws Exception{
		BoardVO board = service.read(bno);
		model.addAttribute(board); // boardVO
	}
	
	
	/**
	 * 게시글 수정 요청 처리 -> 수정된 게시글 상세보기 페이지 이동
	 * Post : board/modify
	 */
	@PostMapping("board/modify")
	public String modify(BoardVO board, HttpSession session)throws Exception{
		String result = service.modify(board);
		session.setAttribute("result", result);
		return "redirect:/board/readPage?bno=" + board.getBno();
	}
	
	
	/**
	 * 게시글 삭제 요청 처리 -> 게시글 삭제 후 목록 페이지 이동
	 * Get : board/remove 
	 */
	@GetMapping("board/remove")
	public String remove(int bno, HttpSession session) throws Exception{
		String result = service.remove(bno);
		session.setAttribute("result", result);
		return "redirect:/board/boardlist";
	}
	
	/**
	 * 페이징 처리된 게시글 목록 페이지 요청
	 * Get : board/boardlist
	 * parameter : page, perPageNum
	 */
	@GetMapping("board/boardlist")
	public String boardlist(Criteria cri, Model model, HttpSession session) throws Exception{
		System.out.println("게시글 목록 listPage 요청");
		String result = (String)session.getAttribute("result");
		if(result != null) {
			model.addAttribute("result", result);
			session.removeAttribute("result");
		}
		System.out.println("boardlist : " + cri);
		// 조회된 게시글 목록
		int HotAgree = 20;
		
		List<BoardVO> allList = service.listCriteria(cri);
		List<BoardVO> hotlist = service.getHotBoard(HotAgree);
		model.addAttribute("allList", allList);
		model.addAttribute("hotlist", hotlist);
		PageMaker pm = service.getPageMaker(cri);
		model.addAttribute("pm", pm);
		
		return "board/boardlist";
	}
	
	
	@GetMapping("board/freeboard")
	public String freeboard(Model model, Criteria cri) throws Exception{
		List<BoardVO> allList = service.listCriteria(cri);
		model.addAttribute("allList", allList);
		PageMaker pm = service.getPageMaker(cri);
		model.addAttribute("pm", pm);
		
		return "board/freeboard";
	}
	
	@GetMapping("board/secretboard")
	public String secretboard(SecretBoardVO board, Criteria cri, Model model) throws Exception{
		
		List<SecretBoardVO> allList = sService.listCriteria(cri);
		model.addAttribute("allList", allList);
		PageMaker pm = service.getPageMaker(cri);
		model.addAttribute("pm", pm);
		
		return "board/secretboard";
	}
	
	@GetMapping("board/localboard")
	public String localboard(LocalBoardVO board, Criteria cri, Model model) throws Exception{
		
		List<LocalBoardVO> allList = lService.listCriteria(cri);
		model.addAttribute("allList", allList);
		PageMaker pm = service.getPageMaker(cri);
		model.addAttribute("pm", pm);
		
		return "board/localboard";
	}
	
	@GetMapping("board/localboard/{categoryId}")
	@ResponseBody
	public List<LocalBoardVO> findCategory(@PathVariable int categoryId) throws Exception {

	    return lService.findCategory(categoryId);
	}
	
	@PostMapping("agree")
	@ResponseBody
	public int plusAgree(@RequestParam("bno") int bno) throws Exception{
		service.plusAgree(bno); // 추천수 증가
		int result = service.AgreeCount(bno);
		System.out.println(result);
		return result;
	}
	
	
	
	
}
