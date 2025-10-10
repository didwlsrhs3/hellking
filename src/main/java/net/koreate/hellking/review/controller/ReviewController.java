package net.koreate.hellking.review.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
<<<<<<< HEAD
=======
import org.springframework.web.multipart.MultipartFile;
import org.springframework.http.ResponseEntity;
import org.springframework.http.HttpStatus;

>>>>>>> b65c320 (Initial commit)
import net.koreate.hellking.review.service.ReviewService;
import net.koreate.hellking.review.vo.*;
import net.koreate.hellking.user.service.UserService;
import net.koreate.hellking.chain.service.ChainService;
<<<<<<< HEAD
=======
import net.koreate.hellking.common.controller.FileController;

>>>>>>> b65c320 (Initial commit)
import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
<<<<<<< HEAD
=======
import java.util.ArrayList;
>>>>>>> b65c320 (Initial commit)

@Controller
@RequestMapping("/reviews/")
public class ReviewController {
    
    @Autowired
    private ReviewService reviewService;
    
    @Autowired
    private UserService userService;
    
    @Autowired
    private ChainService chainService;
    
<<<<<<< HEAD
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
=======
    @Autowired
    private FileController fileController;
    
    // ===== 전체 리뷰 목록 (검색 및 카테고리 필터 통합) =====
    @GetMapping("list")
    public String list(@RequestParam(defaultValue = "latest") String sort,
                      @RequestParam(defaultValue = "1") int page,
                      @RequestParam(defaultValue = "10") int size,  // 10개로 변경
                      @RequestParam(required = false) String keyword,  // 검색 키워드
                      @RequestParam(required = false) String category,  // 카테고리 필터
                      Model model) {
        
        // 강제로 size를 10으로 설정
        size = 10;
        
        Map<String, Object> reviewData;
        
        try {
            // 카테고리와 검색 조건에 따른 분기
            if (keyword != null && !keyword.trim().isEmpty()) {
                // 검색 기능
                reviewData = reviewService.searchReviews(keyword.trim(), sort, page, size);
                model.addAttribute("keyword", keyword.trim());
                model.addAttribute("isSearch", true);
                System.out.println("검색 실행: " + keyword.trim());
                
            } else if (category != null && !category.isEmpty() && !"all".equals(category)) {
                // 카테고리 필터
                reviewData = reviewService.getReviewsByCategory(category, sort, page, size);
                model.addAttribute("category", category);
                model.addAttribute("isCategory", true);
                System.out.println("카테고리 필터: " + category);
                
            } else {
                // 전체 리뷰
                reviewData = reviewService.getAllReviews(sort, page, size);
                model.addAttribute("isSearch", false);
                model.addAttribute("isCategory", false);
            }
            
            // 우수 리뷰는 항상 표시 (상단 3개)
            List<ReviewVO> excellentReviews = reviewService.getExcellentReviews(3);
            
            // 카테고리별 개수 조회 (필터링용)
            Map<String, Long> categoryCount = reviewService.getReviewCountByCategory();
            
            model.addAttribute("reviewData", reviewData);
            model.addAttribute("excellentReviews", excellentReviews);
            model.addAttribute("currentSort", sort);
            model.addAttribute("categoryCount", categoryCount);
            
            // 디버깅 정보
            System.out.println("=== 리뷰 목록 조회 완료 ===");
            System.out.println("검색어: " + keyword);
            System.out.println("카테고리: " + category);
            System.out.println("정렬: " + sort);
            System.out.println("페이지: " + page + "/" + reviewData.get("totalPages"));
            System.out.println("총 개수: " + reviewData.get("totalCount"));
            System.out.println("조회된 리뷰 수: " + ((List<?>) reviewData.get("reviews")).size());
            
        } catch (Exception e) {
            System.err.println("리뷰 목록 조회 중 오류: " + e.getMessage());
            e.printStackTrace();
            
            // 오류 시 빈 결과 반환
            reviewData = new HashMap<>();
            reviewData.put("reviews", new ArrayList<>());
            reviewData.put("currentPage", 1);
            reviewData.put("totalPages", 0);
            reviewData.put("totalCount", 0);
            reviewData.put("hasNext", false);
            reviewData.put("hasPrev", false);
            
            model.addAttribute("reviewData", reviewData);
            model.addAttribute("excellentReviews", new ArrayList<>());
            model.addAttribute("error", "리뷰를 불러오는 중 오류가 발생했습니다.");
        }
>>>>>>> b65c320 (Initial commit)
        
        return "reviews/list";
    }
    
<<<<<<< HEAD
    // 리뷰 상세보기
=======
    // ===== 리뷰 상세보기 =====
>>>>>>> b65c320 (Initial commit)
    @GetMapping("detail/{reviewNum}")
    public String detail(@PathVariable Long reviewNum, Model model, HttpSession session) {
        Long currentUserNum = userService.getCurrentUserNum(session);
        
        ReviewVO review = reviewService.getReviewDetail(reviewNum, currentUserNum);
        List<ReviewCommentVO> comments = reviewService.getComments(reviewNum);
        
        model.addAttribute("review", review);
        model.addAttribute("comments", comments);
        
        return "reviews/detail";
    }
    
<<<<<<< HEAD
    // 리뷰 작성 페이지
=======
    // ===== 리뷰 작성 페이지 =====
>>>>>>> b65c320 (Initial commit)
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
    
<<<<<<< HEAD
    // 리뷰 작성 처리
=======
    // ===== 기본 리뷰 작성 처리 =====
>>>>>>> b65c320 (Initial commit)
    @PostMapping("write")
    public String writePost(ReviewVO review, HttpSession session, RedirectAttributes rttr) {
        System.out.println("=== 리뷰 작성 요청 받음 ===");
        System.out.println("받은 데이터: " + review.toString());
        
        Long userNum = userService.getCurrentUserNum(session);
<<<<<<< HEAD
        System.out.println("현재 사용자: " + userNum);
        
        if (userNum == null) {
            System.out.println("로그인되지 않은 사용자");
=======
        if (userNum == null) {
>>>>>>> b65c320 (Initial commit)
            return "redirect:/user/login";
        }
        
        review.setUserNum(userNum);
<<<<<<< HEAD
        System.out.println("최종 저장할 데이터: " + review.toString());
        
        try {
            boolean success = reviewService.writeReview(review);
            System.out.println("저장 결과: " + success);
            
            if (success) {
                rttr.addFlashAttribute("message", "리뷰가 작성되었습니다.");
                return "redirect:/reviews/list";
            } else {
                System.out.println("저장 실패");
                rttr.addFlashAttribute("message", "리뷰 작성에 실패했습니다.");
            }
        } catch (Exception e) {
            System.out.println("예외 발생: " + e.getMessage());
            e.printStackTrace();
=======
        
        try {
            boolean success = reviewService.writeReview(review);
            
            if (success) {
                // 가맹점 평점 자동 업데이트 (서비스에서 처리됨)
                rttr.addFlashAttribute("message", "리뷰가 작성되었습니다.");
                return "redirect:/reviews/list";
            } else {
                rttr.addFlashAttribute("message", "리뷰 작성에 실패했습니다.");
            }
        } catch (Exception e) {
            System.err.println("예외 발생: " + e.getMessage());
>>>>>>> b65c320 (Initial commit)
            rttr.addFlashAttribute("message", e.getMessage());
        }
        
        return "redirect:/reviews/write?chainNum=" + review.getChainNum();
    }
    
<<<<<<< HEAD
    // 리뷰 수정 페이지
=======
    // ===== 이미지 포함 리뷰 작성 처리 =====
    @PostMapping("writeWithImages")
    public String writeWithImages(@RequestParam("chainNum") Long chainNum,
                                 @RequestParam("rating") Double rating,
                                 @RequestParam("title") String title,
                                 @RequestParam("content") String content,
                                 @RequestParam(value = "imageFileNames", required = false) List<String> imageFileNames,
                                 HttpSession session, RedirectAttributes rttr) {
        
        System.out.println("=== 이미지 포함 리뷰 작성 요청 ===");
        
        Long userNum = userService.getCurrentUserNum(session);
        if (userNum == null) {
            return "redirect:/user/login";
        }
        
        try {
            ReviewVO review = new ReviewVO();
            review.setUserNum(userNum);
            review.setChainNum(chainNum);
            review.setRating(rating);
            review.setTitle(title);
            review.setContent(content);
            
            List<String> finalImageFileNames = new ArrayList<>();
            if (imageFileNames != null && !imageFileNames.isEmpty()) {
                finalImageFileNames.addAll(imageFileNames);
            }
            
            boolean success = reviewService.writeReviewWithImages(review, finalImageFileNames);
            
            if (success) {
                rttr.addFlashAttribute("message", "리뷰가 등록되었습니다.");
                return "redirect:/reviews/list";
            } else {
                rttr.addFlashAttribute("message", "리뷰 등록에 실패했습니다.");
            }
            
        } catch (Exception e) {
            System.err.println("리뷰 작성 예외: " + e.getMessage());
            e.printStackTrace();
            rttr.addFlashAttribute("message", e.getMessage());
        }
        
        return "redirect:/reviews/write?chainNum=" + chainNum;
    }
    
    // ===== 리뷰 수정 페이지 =====
>>>>>>> b65c320 (Initial commit)
    @GetMapping("edit/{reviewNum}")
    public String editForm(@PathVariable Long reviewNum, Model model, HttpSession session) {
        Long userNum = userService.getCurrentUserNum(session);
        if (userNum == null) {
            return "redirect:/user/login";
        }
        
        ReviewVO review = reviewService.getReviewDetail(reviewNum, userNum);
        
<<<<<<< HEAD
        // 작성자 본인만 수정 가능
=======
>>>>>>> b65c320 (Initial commit)
        if (!review.getUserNum().equals(userNum)) {
            model.addAttribute("message", "리뷰 수정 권한이 없습니다.");
            return "error/403";
        }
        
        model.addAttribute("review", review);
        return "reviews/edit";
    }
    
<<<<<<< HEAD
    // 리뷰 수정 처리
=======
    // ===== 기본 리뷰 수정 처리 =====
>>>>>>> b65c320 (Initial commit)
    @PostMapping("edit")
    public String editPost(ReviewVO review, HttpSession session, RedirectAttributes rttr) {
        Long userNum = userService.getCurrentUserNum(session);
        if (userNum == null) {
            return "redirect:/user/login";
        }
        
        try {
            boolean success = reviewService.updateReview(review, userNum);
            if (success) {
<<<<<<< HEAD
=======
                // 가맹점 평점 자동 업데이트 (서비스에서 처리됨)
>>>>>>> b65c320 (Initial commit)
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
    
<<<<<<< HEAD
    // 리뷰 삭제
=======
    // ===== 이미지 포함 리뷰 수정 처리 =====
    @PostMapping("editWithImages")
    public String editWithImages(ReviewVO review,
                                @RequestParam(value = "newImages", required = false) List<MultipartFile> newImages,
                                @RequestParam(value = "deleteImages", required = false) String deleteImageIds,
                                HttpSession session, RedirectAttributes rttr) {
        Long userNum = userService.getCurrentUserNum(session);
        if (userNum == null) {
            return "redirect:/user/login";
        }
        
        try {
            List<String> newImageFileNames = new ArrayList<>();
            List<Long> deleteImageList = new ArrayList<>();
            
            // 새 이미지 업로드
            if (newImages != null && !newImages.isEmpty()) {
                for (MultipartFile image : newImages) {
                    if (!image.isEmpty()) {
                        try {
                            List<String> uploadResult = fileController.uploadFile(List.of(image));
                            if (!uploadResult.isEmpty()) {
                                newImageFileNames.add(uploadResult.get(0));
                            }
                        } catch (Exception e) {
                            System.err.println("이미지 업로드 실패: " + e.getMessage());
                        }
                    }
                }
            }
            
            // 삭제할 이미지 ID 파싱
            if (deleteImageIds != null && !deleteImageIds.trim().isEmpty()) {
                String[] ids = deleteImageIds.split(",");
                for (String id : ids) {
                    try {
                        deleteImageList.add(Long.parseLong(id.trim()));
                    } catch (NumberFormatException e) {
                        System.err.println("잘못된 이미지 ID: " + id);
                    }
                }
            }
            
            boolean success = reviewService.updateReviewWithImages(review, newImageFileNames, deleteImageList, userNum);
            
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
    
    // ===== 리뷰 삭제 =====
>>>>>>> b65c320 (Initial commit)
    @PostMapping("delete/{reviewNum}")
    public String delete(@PathVariable Long reviewNum, HttpSession session, RedirectAttributes rttr) {
        Long userNum = userService.getCurrentUserNum(session);
        if (userNum == null) {
            return "redirect:/user/login";
        }
        
        try {
            boolean success = reviewService.deleteReview(reviewNum, userNum);
            if (success) {
<<<<<<< HEAD
=======
                // 가맹점 평점 자동 업데이트 (서비스에서 처리됨)
>>>>>>> b65c320 (Initial commit)
                rttr.addFlashAttribute("message", "리뷰가 삭제되었습니다.");
            } else {
                rttr.addFlashAttribute("message", "리뷰 삭제에 실패했습니다.");
            }
        } catch (Exception e) {
            rttr.addFlashAttribute("message", e.getMessage());
        }
        
        return "redirect:/reviews/list";
    }
    
<<<<<<< HEAD
    // 가맹점별 리뷰 (AJAX)
=======
    // ===== AJAX - 이미지 업로드 =====
    @PostMapping("uploadImage")
    @ResponseBody
    public Map<String, Object> uploadImage(@RequestParam("image") MultipartFile image, 
                                          HttpSession session) {
        Map<String, Object> result = new HashMap<>();
        
        try {
            Long userNum = userService.getCurrentUserNum(session);
            if (userNum == null) {
                result.put("success", false);
                result.put("message", "로그인이 필요합니다.");
                return result;
            }
            
            if (image.isEmpty()) {
                result.put("success", false);
                result.put("message", "이미지 파일을 선택해주세요.");
                return result;
            }
            
            // 파일 크기 체크 (10MB 제한)
            if (image.getSize() > 10 * 1024 * 1024) {
                result.put("success", false);
                result.put("message", "이미지 파일은 10MB 이하만 업로드 가능합니다.");
                return result;
            }
            
            // 파일 형식 체크
            String contentType = image.getContentType();
            if (contentType == null || !contentType.startsWith("image/")) {
                result.put("success", false);
                result.put("message", "이미지 파일만 업로드 가능합니다.");
                return result;
            }
            
            List<String> uploadResult = fileController.uploadFile(List.of(image));
            
            if (!uploadResult.isEmpty()) {
                String fileName = uploadResult.get(0);
                
                result.put("success", true);
                result.put("fileName", fileName);
                result.put("originalName", image.getOriginalFilename());
                result.put("fileSize", image.getSize());
                result.put("message", "이미지가 업로드되었습니다.");
                
                System.out.println("AJAX 이미지 업로드 성공: " + fileName);
            } else {
                result.put("success", false);
                result.put("message", "이미지 업로드에 실패했습니다.");
            }
            
        } catch (Exception e) {
            System.err.println("AJAX 이미지 업로드 오류: " + e.getMessage());
            result.put("success", false);
            result.put("message", "이미지 업로드 중 오류가 발생했습니다: " + e.getMessage());
        }
        
        return result;
    }
    
    // ===== AJAX - 이미지 삭제 =====
    @PostMapping("deleteImage")
    @ResponseBody
    public Map<String, Object> deleteImage(@RequestParam("fileName") String fileName,
                                          HttpSession session) {
        Map<String, Object> result = new HashMap<>();
        
        try {
            Long userNum = userService.getCurrentUserNum(session);
            if (userNum == null) {
                result.put("success", false);
                result.put("message", "로그인이 필요합니다.");
                return result;
            }
            
            ResponseEntity<String> deleteResult = fileController.deleteFile(fileName);
            
            if (deleteResult.getStatusCode() == HttpStatus.OK) {
                result.put("success", true);
                result.put("message", "이미지가 삭제되었습니다.");
            } else {
                result.put("success", false);
                result.put("message", "이미지 삭제에 실패했습니다.");
            }
            
        } catch (Exception e) {
            System.err.println("이미지 삭제 오류: " + e.getMessage());
            result.put("success", false);
            result.put("message", "이미지 삭제 중 오류가 발생했습니다.");
        }
        
        return result;
    }
    
    // ===== AJAX - 이미지 순서 변경 =====
    @PostMapping("updateImageOrder")
    @ResponseBody
    public Map<String, Object> updateImageOrder(@RequestBody List<Map<String, Object>> imageOrders,
                                               HttpSession session) {
        Map<String, Object> result = new HashMap<>();
        
        try {
            Long userNum = userService.getCurrentUserNum(session);
            if (userNum == null) {
                result.put("success", false);
                result.put("message", "로그인이 필요합니다.");
                return result;
            }
            
            boolean success = reviewService.updateImageOrders(imageOrders);
            result.put("success", success);
            result.put("message", success ? "이미지 순서가 변경되었습니다." : "이미지 순서 변경에 실패했습니다.");
            
        } catch (Exception e) {
            result.put("success", false);
            result.put("message", "이미지 순서 변경 중 오류가 발생했습니다.");
        }
        
        return result;
    }
    
    // ===== 가맹점별 리뷰 (AJAX) =====
>>>>>>> b65c320 (Initial commit)
    @GetMapping("chain/{chainNum}")
    @ResponseBody
    public Map<String, Object> chainReviews(@PathVariable Long chainNum,
                                           @RequestParam(defaultValue = "1") int page,
                                           @RequestParam(defaultValue = "5") int size) {
        return reviewService.getChainReviews(chainNum, page, size);
    }
    
<<<<<<< HEAD
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
=======
    // ===== 내 리뷰 목록 =====
>>>>>>> b65c320 (Initial commit)
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
    
<<<<<<< HEAD
    // AJAX - 댓글 작성
=======
    // ===== AJAX - 댓글 작성 =====
>>>>>>> b65c320 (Initial commit)
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
    
<<<<<<< HEAD
    // AJAX - 좋아요/싫어요
=======
    // ===== AJAX - 좋아요/싫어요 =====
>>>>>>> b65c320 (Initial commit)
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
    
<<<<<<< HEAD
=======
    // ===== AJAX - 로그인 상태 확인 =====
>>>>>>> b65c320 (Initial commit)
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
<<<<<<< HEAD
=======
    
    // ===== AJAX - 카테고리별 리뷰 개수 조회 =====
    @GetMapping("getCategoryCount")
    @ResponseBody
    public Map<String, Long> getCategoryCount() {
        try {
            return reviewService.getReviewCountByCategory();
        } catch (Exception e) {
            System.err.println("카테고리 개수 조회 오류: " + e.getMessage());
            Map<String, Long> emptyResult = new HashMap<>();
            emptyResult.put("all", 0L);
            emptyResult.put("excellent", 0L);
            emptyResult.put("recent", 0L);
            emptyResult.put("popular", 0L);
            return emptyResult;
        }
    }
    
    // ===== 우수리뷰 통계 조회 (AJAX) =====
    @GetMapping("excellentStats")
    @ResponseBody
    public Map<String, Object> getExcellentStats() {
        try {
            Map<String, Object> stats = reviewService.getExcellentReviewStats();
            stats.put("success", true);
            return stats;
        } catch (Exception e) {
            Map<String, Object> result = new HashMap<>();
            result.put("success", false);
            result.put("message", "통계 조회 중 오류가 발생했습니다: " + e.getMessage());
            return result;
        }
    }
    
    // ===== 우수리뷰 상태 일괄 재계산 (관리자용) =====
    @PostMapping("admin/recalculateExcellent")
    @ResponseBody
    public Map<String, Object> recalculateExcellentStatus(HttpSession session) {
        try {
            return reviewService.recalculateAllExcellentStatus();
        } catch (Exception e) {
            Map<String, Object> result = new HashMap<>();
            result.put("success", false);
            result.put("message", "재계산 중 오류가 발생했습니다: " + e.getMessage());
            return result;
        }
    }
    
    // ===== 가맹점 평점 재계산 (관리자용) =====
    @PostMapping("admin/recalculateChainRatings")
    @ResponseBody
    public Map<String, Object> recalculateChainRatings(HttpSession session) {
        try {
            return reviewService.recalculateAllChainRatings();
        } catch (Exception e) {
            Map<String, Object> result = new HashMap<>();
            result.put("success", false);
            result.put("message", "평점 재계산 중 오류가 발생했습니다: " + e.getMessage());
            return result;
        }
    }
>>>>>>> b65c320 (Initial commit)
}