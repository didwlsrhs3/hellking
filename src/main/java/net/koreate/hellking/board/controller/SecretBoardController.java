package net.koreate.hellking.board.controller;

<<<<<<< HEAD
import java.util.List;

=======
>>>>>>> b65c320 (Initial commit)
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
<<<<<<< HEAD
import org.springframework.web.bind.annotation.RequestMapping;
=======
>>>>>>> b65c320 (Initial commit)
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import lombok.RequiredArgsConstructor;
import net.koreate.hellking.board.service.SecretBoardService;
<<<<<<< HEAD
import net.koreate.hellking.board.vo.SecretBoardVO;
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
	@GetMapping("board/secretmodify")
	public void modify(int bno, Model model) throws Exception{
		SecretBoardVO board = service.read(bno);
		model.addAttribute(board); // boardVO
	}
	
	
	/**
	 * 게시글 수정 요청 처리 -> 수정된 게시글 상세보기 페이지 이동
	 * Post : board/modify
	 */
	@PostMapping("board/secretmodify")
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
	
	
	
	
=======
import net.koreate.hellking.board.util.BoardCriteria;
import net.koreate.hellking.board.util.BoardPageMaker;
import net.koreate.hellking.board.vo.SecretBoardVO;

import java.util.List;

@Controller
@RequiredArgsConstructor
public class SecretBoardController {

    private final SecretBoardService service;

    /** 글쓰기 페이지 */
    @GetMapping("board/secretregister")
    public void register() {}

    /** 글 등록 */
    @PostMapping("board/secretregister")
    public String registerPost(SecretBoardVO board, HttpSession session) throws Exception {
        String result = service.regist(board);
        session.setAttribute("msg", result);
        return "redirect:/board/secretboard";
    }

    /** 목록 */
    @GetMapping("board/secretboard")
    public String secretboard(BoardCriteria cri, Model model) throws Exception {
        List<SecretBoardVO> allList = service.listCriteria(cri);
        model.addAttribute("allList", allList);

        BoardPageMaker pm = new BoardPageMaker();
        pm.setCri(cri);
        pm.setTotalCount(service.totalCount());
        model.addAttribute("pm", pm);

        return "board/secretboard";
    }

    /** 상세보기 */
    @GetMapping("secretreadPage")
    public String readPage(@RequestParam("bno") int bno, Model model) throws Exception {
        service.updateCnt(bno);
        SecretBoardVO board = service.read(bno);
        model.addAttribute("list", board);
        return "board/secretread";
    }

    /** 글 수정 (비밀번호 확인 포함) */
    @PostMapping("board/secretmodify")
    public String modify(SecretBoardVO board,
                         @RequestParam("password") String password,
                         HttpSession session) throws Exception {
        boolean success = service.modify(board, password);
        session.setAttribute("result", success ? "수정 성공" : "비밀번호 불일치");
        return "redirect:/secretreadPage?bno=" + board.getBno();
    }

    /** 글 삭제 (비밀번호 확인 포함) */
    @PostMapping("board/secretremove")
    public String remove(@RequestParam("bno") int bno,
                         @RequestParam("password") String password,
                         HttpSession session) throws Exception {
        boolean success = service.remove(bno, password);
        session.setAttribute("result", success ? "삭제 성공" : "비밀번호 불일치");
        return "redirect:/board/secretboard";
    }

    /** 추천 */
    @PostMapping("board/secretagree")
    @ResponseBody
    public int plusAgree(@RequestParam("bno") int bno) throws Exception {
        service.plusAgree(bno);
        return service.AgreeCount(bno);
    }
>>>>>>> b65c320 (Initial commit)
}
