package net.koreate.hellking.board.controller;

<<<<<<< HEAD
import java.util.List;

=======
import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;
>>>>>>> b65c320 (Initial commit)
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
<<<<<<< HEAD
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
=======
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import lombok.RequiredArgsConstructor;
import net.koreate.hellking.board.dao.BoardDAO;
import net.koreate.hellking.board.service.BoardService;
import net.koreate.hellking.board.service.CommentService;
import net.koreate.hellking.board.service.LocalBoardService;
import net.koreate.hellking.board.service.SecretBoardService;
import net.koreate.hellking.board.util.BoardCriteria;
import net.koreate.hellking.board.util.BoardPageMaker;
import net.koreate.hellking.board.util.BoardSearchCriteria;
import net.koreate.hellking.board.vo.BoardVO;
import net.koreate.hellking.board.vo.CommentVO;
import net.koreate.hellking.board.vo.FileVO;
>>>>>>> b65c320 (Initial commit)

@Controller
@RequiredArgsConstructor
public class BoardController {
	
	private final BoardService service;
	private final SecretBoardService sService;
	private final LocalBoardService lService;
<<<<<<< HEAD

=======
	private final BoardDAO dao;
	private final CommentService cService;
	
>>>>>>> b65c320 (Initial commit)
	/**
	 * 게시글 작성 페이지 요청 
	 * Get : board/register
	 */
	@GetMapping("board/register")
	public void register() throws Exception{
		System.out.println("게시글 작성 페이지 요청");
<<<<<<< HEAD
		// "/WEB-INF/views/" + "board/register" + ".jsp"	
		//  /WEB-INF/views/board/register.jsp
	}	
	
=======
	}	
		
>>>>>>> b65c320 (Initial commit)
	/**
	 * 게시글 등록 요청 처리
	 * Post : board/register 
	 */
<<<<<<< HEAD
	@PostMapping("board/register")
	public String registerPost(BoardVO board, HttpSession session) throws Exception {
		System.out.println("param data : " + board);
		String result = service.regist(board);
		session.setAttribute("msg", result);
		return "redirect:/";
	}
	
=======
	@PostMapping("/board/register")
	public String registerPost(BoardVO board,
	                           @RequestParam("uploadFile") MultipartFile[] uploadFile,
	                           HttpSession session) throws Exception {

	    // 로그인 체크
	    net.koreate.hellking.user.vo.UserVO user =
	            (net.koreate.hellking.user.vo.UserVO) session.getAttribute("loginUser");

	    if (user == null) {
	        return "redirect:/user/login";
	    }

	    // 작성자 닉네임 세팅
	    board.setNickname(user.getUsername());
	    board.setUserId(user.getUserId());
	    
	    // 글 등록 + 파일 저장
	    String result = service.regist(board, uploadFile);
	    session.setAttribute("msg", result);

	    return "redirect:/board/boardlist";
	}

>>>>>>> b65c320 (Initial commit)
	/**
	 * 게시글 상세보기 요청 시 조회 수 증가
	 * GET : board/readPage
	 */
	@GetMapping("board/readPage")
<<<<<<< HEAD
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
=======
	public String readPage(int bno, Model model) throws Exception {
	    service.updateCnt(bno); // 조회수 증가
	    BoardVO board = service.read(bno); // 글 정보

	    List<FileVO> files = dao.getFilesByBno(bno, board.getBoardType()); // 첨부파일 조회
	    board.setFiles(files);

	    // 댓글 목록 조회
	    List<CommentVO> comments = cService.listComment(bno);

	    // 상세보기 데이터
	    model.addAttribute("list", board);
	    model.addAttribute("comments", comments);

	    return "board/read";
	}
	
	@GetMapping("/board/download")
	public void download(
	        @RequestParam("file") String savedName,
	        @RequestParam("path")  String uploadPath,
	        HttpServletResponse response) throws Exception {

	    // System.out.println("savedName : " + savedName);
	    // System.out.println("uploadPath : " + uploadPath);

	    File file = new File(uploadPath, savedName);
	    // System.out.println("absolutePath : " + file.getAbsolutePath());
	    // System.out.println("exists? : " + file.exists());

	    String encodedName = URLEncoder.encode(savedName, StandardCharsets.UTF_8).replaceAll("\\+", "%20");

	    response.setContentType("application/octet-stream");
	    response.setHeader("Content-Disposition",
	            "attachment; filename=\"" + encodedName + "\"");
	    response.setHeader("Content-Transfer-Encoding", "binary");

	    try (InputStream in = new FileInputStream(file);
	         OutputStream out = response.getOutputStream()) {

	        FileCopyUtils.copy(in, out);
	        out.flush();
	    }
	}
	
	
    /**
     * 게시글 수정 페이지 요청
     * GET : /board/modify
     */
    @GetMapping("/board/modify")
    public String modifyForm(@RequestParam("bno") int bno, Model model) throws Exception {
    	
        BoardVO board = service.read(bno);
        
        model.addAttribute("board", board); // 게시글
        model.addAttribute("files", board.getFiles()); // 첨부파일
        
        return "board/modify"; // modify.jsp
    }

    /**
     * 게시글 수정 처리
     * POST : /board/modify
     */
    @PostMapping("/board/modify")
    public String modify(BoardVO board,
                         @RequestParam(value="delFiles", required=false) List<Integer> delFiles,
                         @RequestParam(value="uploadFile", required=false) MultipartFile[] uploadFiles,
                         HttpSession session) throws Exception {

        String result = service.modify(board, delFiles, uploadFiles);
        session.setAttribute("result", result);

        return "redirect:/board/readPage?bno=" + board.getBno();
    }
    
>>>>>>> b65c320 (Initial commit)
	@GetMapping("board/remove")
	public String remove(int bno, HttpSession session) throws Exception{
		String result = service.remove(bno);
		session.setAttribute("result", result);
<<<<<<< HEAD
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
	
	
	
	
=======
		return "redirect:/board/freeboard";
	}
	
    /**
     * 페이징 처리된 게시글 목록 페이지 요청
     * Get : board/boardlist
     * parameter : page, perPageNum
     */
    @GetMapping("board/boardlist")
    public String boardlist(BoardCriteria cri, Model model, HttpSession session) throws Exception {
        System.out.println("게시글 목록 listPage 요청");

        // Criteria 값 보정
        if (cri.getPage() <= 0) {
            cri.setPage(1);
        }
        if (cri.getPerPageNum() <= 0) {
            cri.setPerPageNum(10);
        }

        // 세션 처리
        String result = (String) session.getAttribute("result");
        if (result != null) {
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

        // PageMaker 생성
        BoardPageMaker pm = service.getPageMaker(cri);
        model.addAttribute("pm", pm);

        // Debug log
        System.out.println("DEBUG size=" + allList.size());
        allList.forEach(vo -> System.out.println("DEBUG bno=" + vo.getBno()));

        return "board/boardlist";
    }

	
	
	@GetMapping("board/freeboard")
	public String freeboard(Model model, BoardSearchCriteria cri) throws Exception{
		
	    // 기본 보정
	    if (cri.getPage() == null || cri.getPage() <= 0) cri.setPage(1);
	    if (cri.getPerPageNum() == null || cri.getPerPageNum() <= 0) cri.setPerPageNum(10);

	    // 게시글 목록
	    List<BoardVO> allList = service.listSearch(cri);
	    model.addAttribute("allList", allList);

	    // 페이지 정보
	    BoardPageMaker pm = service.getPageMaker(cri);
	    model.addAttribute("pm", pm);

	    return "board/freeboard";
	}

	@PostMapping("/board/toggleAgree")
	@ResponseBody
	public Map<String, Object> toggleAgree(
	        @RequestParam("bno") int bno,
	        HttpSession session) throws Exception {
	    net.koreate.hellking.user.vo.UserVO user =
	            (net.koreate.hellking.user.vo.UserVO) session.getAttribute("loginUser");

	    if (user == null) {
	        throw new RuntimeException("로그인 필요");
	    }

	    String userId = user.getUserId(); // 또는 username / email, PK에 맞게
	    return service.toggleAgree(bno, userId);
	}
	
>>>>>>> b65c320 (Initial commit)
}
