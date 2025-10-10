package net.koreate.hellking.board.controller;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import net.koreate.hellking.board.service.CommentService;
import net.koreate.hellking.board.vo.CommentVO;

@Controller
@RequestMapping("/comment/*")
public class CommentController {

    @Inject
    private CommentService service;

    // 댓글 작성
    @PostMapping("/add")
    public String addComment(CommentVO vo, @RequestParam("bno") int bno) throws Exception {
        service.addComment(vo);
        // 댓글 추가 후, 다시 게시글 상세 페이지로 리다이렉트
        return "redirect:/board/readPage?bno=" + bno;
    }
    
    // 답글 등록
    @PostMapping("/reply")
    public String addReply(CommentVO vo) throws Exception {
        service.addReply(vo);
        return "redirect:/board/readPage?bno=" + vo.getBno();
    }
    
    // 댓글 수정
    @PostMapping("/update")
    public String updateComment(CommentVO vo, @RequestParam("bno") int bno) throws Exception {
        service.updateComment(vo);
        return "redirect:/board/readPage?bno=" + bno;
    }

    // 댓글 삭제
    @PostMapping("/delete")
    public String deleteComment(@RequestParam("cno") int cno, @RequestParam("bno") int bno) throws Exception {
        service.deleteComment(cno);
        return "redirect:/board/readPage?bno=" + bno;
    }

    // 특정 게시글 댓글 목록
    @GetMapping("/list")
    public String listComment(@RequestParam("bno") int bno, Model model) throws Exception {
        List<CommentVO> comments = service.listComment(bno);
        model.addAttribute("comments", comments);
        return "board/commentList"; // JSP 만들어야 함
    }
    
}