package net.koreate.hellking.review.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import net.koreate.hellking.review.service.ReviewService;
import net.koreate.hellking.review.vo.*;
import net.koreate.hellking.user.service.UserService;
import net.koreate.hellking.chain.service.ChainService;
import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/reviews/")
public class ReviewController {
    
    @Autowired
    private ReviewService reviewService;
    
    @Autowired
    private UserService userService;
    
    @Autowired
    private ChainService chainService;
    
    // 전체 리뷰 목록
    @GetMapping("list")
    public String list(@RequestParam(defaultValue = "latest") String sort,
                      @RequestParam(defaultValue = "1") int page,
                      @RequestParam(defaultValue = "12") int size,
                      Model model) {
        
        Map<String, Object> reviewData = reviewService.getAllReviews(sort, page, size);
        List<ReviewVO> excellentReviews = reviewService.getExcellentReviews(3);
        
        model.addAttribute("reviewData", reviewData);
        model.addAttribute("excellentReviews", excellentReviews);
        model.addAttribute("currentSort", sort);
        
        return "reviews/list";
    }
    
    // 리뷰 상세보기
    @GetMapping("detail/{reviewNum}")
    public String detail(@PathVariable Long reviewNum, Model model, HttpSession session) {
        Long currentUserNum = userService.getCurrentUserNum(session);
        
        ReviewVO review = reviewService.getReviewDetail(reviewNum, currentUserNum);
        List<ReviewCommentVO> comments = reviewService.getComments(reviewNum);
        
        model.addAttribute("review", review);
        model.addAttribute("comments", comments);
        
        return "reviews/detail";
    }
    
    // 리뷰 작성 페이지
    @GetMapping("write")
    public String writeForm(@RequestParam(required = false) Long chainNum, 
                           Model model, HttpSession session) {
        Long userNum = userService.getCurrentUserNum(session);
        if (userNum == null) {
            return "redirect:/user/login";
        }
        
        if (chainNum != null) {
            model.addAttribute("chain", chainService.getChainDetail(chainNum));
        }
        
        return "reviews/write";
    }
    
    // 리뷰 작성 처리
    @PostMapping("write")
    public String writePost(ReviewVO review, HttpSession session, RedirectAttributes rttr) {
        Long userNum = userService.getCurrentUserNum(session);
        if (userNum == null) {
            return "redirect:/user/login";
        }
        
        review.setUserNum(userNum);
        
        try {
            boolean success = reviewService.writeReview(review);
            if (success) {
                rttr.addFlashAttribute("message", "리뷰가 작성되었습니다.");
                return "redirect:/reviews/list";
            } else {
                rttr.addFlashAttribute("message", "리뷰 작성에 실패했습니다.");
            }
        } catch (Exception e) {
            rttr.addFlashAttribute("message", e.getMessage());
        }
        
        return "redirect:/reviews/write?chainNum=" + review.getChainNum();
    }
    
    // 리뷰 수정 페이지
    @GetMapping("edit/{reviewNum}")
    public String editForm(@PathVariable Long reviewNum, Model model, HttpSession session) {
        Long userNum = userService.getCurrentUserNum(session);
        if (userNum == null) {
            return "redirect:/user/login";
        }
        
        ReviewVO review = reviewService.getReviewDetail(reviewNum, userNum);
        
        // 작성자 본인만 수정 가능
        if (!review.getUserNum().equals(userNum)) {
            model.addAttribute("message", "리뷰 수정 권한이 없습니다.");
            return "error/403";
        }
        
        model.addAttribute("review", review);
        return "reviews/edit";
    }
    
    // 리뷰 수정 처리
    @PostMapping("edit")
    public String editPost(ReviewVO review, HttpSession session, RedirectAttributes rttr) {
        Long userNum = userService.getCurrentUserNum(session);
        if (userNum == null) {
            return "redirect:/user/login";
        }
        
        try {
            boolean success = reviewService.updateReview(review, userNum);
            if (success) {
                rttr.addFlashAttribute("message", "리뷰가 수정되었습니다.");
                return "redirect:/reviews/detail/" + review.getReviewNum();
            } else {
                rttr.addFlashAttribute("message", "리뷰 수정에 실패했습니다.");
            }
        } catch (Exception e) {
            rttr.addFlashAttribute("message", e.getMessage());
        }
        
        return "redirect:/reviews/edit/" + review.getReviewNum();
    }
    
    // 리뷰 삭제
    @PostMapping("delete/{reviewNum}")
    public String delete(@PathVariable Long reviewNum, HttpSession session, RedirectAttributes rttr) {
        Long userNum = userService.getCurrentUserNum(session);
        if (userNum == null) {
            return "redirect:/user/login";
        }
        
        try {
            boolean success = reviewService.deleteReview(reviewNum, userNum);
            if (success) {
                rttr.addFlashAttribute("message", "리뷰가 삭제되었습니다.");
            } else {
                rttr.addFlashAttribute("message", "리뷰 삭제에 실패했습니다.");
            }
        } catch (Exception e) {
            rttr.addFlashAttribute("message", e.getMessage());
        }
        
        return "redirect:/reviews/list";
    }
    
    // 가맹점별 리뷰 (AJAX)
    @GetMapping("chain/{chainNum}")
    @ResponseBody
    public Map<String, Object> chainReviews(@PathVariable Long chainNum,
                                           @RequestParam(defaultValue = "1") int page,
                                           @RequestParam(defaultValue = "5") int size) {
        return reviewService.getChainReviews(chainNum, page, size);
    }
    
    // 리뷰 검색
    @GetMapping("search")
    public String search(@RequestParam String keyword,
                        @RequestParam(defaultValue = "1") int page,
                        @RequestParam(defaultValue = "12") int size,
                        Model model) {
        
        Map<String, Object> searchResult = reviewService.searchReviews(keyword, page, size);
        model.addAttribute("searchResult", searchResult);
        
        return "reviews/search";
    }
    
    // 내 리뷰 목록
    @GetMapping("my")
    public String myReviews(HttpSession session, Model model) {
        Long userNum = userService.getCurrentUserNum(session);
        if (userNum == null) {
            return "redirect:/user/login";
        }
        
        List<ReviewVO> myReviews = reviewService.getUserReviews(userNum);
        Map<String, Object> stats = reviewService.getUserReviewStats(userNum);
        
        model.addAttribute("myReviews", myReviews);
        model.addAttribute("stats", stats);
        
        return "reviews/my";
    }
    
    // AJAX - 댓글 작성
    @PostMapping("comment")
    @ResponseBody
    public Map<String, Object> writeComment(ReviewCommentVO comment, HttpSession session) {
        Map<String, Object> result = new HashMap<>();
        
        try {
            Long userNum = userService.getCurrentUserNum(session);
            if (userNum == null) {
                result.put("success", false);
                result.put("message", "로그인이 필요합니다.");
                return result;
            }
            
            comment.setUserNum(userNum);
            boolean success = reviewService.writeComment(comment);
            
            result.put("success", success);
            result.put("message", success ? "댓글이 작성되었습니다." : "댓글 작성에 실패했습니다.");
            
        } catch (Exception e) {
            result.put("success", false);
            result.put("message", "댓글 작성 중 오류가 발생했습니다.");
        }
        
        return result;
    }
    
    // AJAX - 좋아요/싫어요
    @PostMapping("like")
    @ResponseBody
    public Map<String, Object> toggleLike(@RequestParam Long reviewNum,
                                         @RequestParam String type,
                                         HttpSession session) {
        Map<String, Object> result = new HashMap<>();
        
        try {
            Long userNum = userService.getCurrentUserNum(session);
            if (userNum == null) {
                result.put("success", false);
                result.put("message", "로그인이 필요합니다.");
                return result;
            }
            
            result = reviewService.toggleLike(reviewNum, userNum, type.toUpperCase());
            
        } catch (Exception e) {
            result.put("success", false);
            result.put("message", "처리 중 오류가 발생했습니다.");
        }
        
        return result;
    }
    
    @GetMapping("checkLogin")
    @ResponseBody
    public Map<String, Object> checkLogin(HttpSession session) {
        Map<String, Object> result = new HashMap<>();
        Long userNum = userService.getCurrentUserNum(session);
        result.put("loggedIn", userNum != null);
        result.put("userNum", userNum);
        result.put("userId", session.getAttribute("userId"));
        result.put("username", session.getAttribute("username"));
        return result;
    }
}