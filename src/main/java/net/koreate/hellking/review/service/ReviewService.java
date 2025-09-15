package net.koreate.hellking.review.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import net.koreate.hellking.review.dao.ReviewDAO;
import net.koreate.hellking.review.vo.*;
import net.koreate.hellking.user.service.UserService;
import net.koreate.hellking.common.exception.HellkingException;
import java.util.List;
import java.util.HashMap;
import java.util.Map;

@Service
@Transactional
public class ReviewService {
    
    @Autowired
    private ReviewDAO reviewDAO;
    
    @Autowired
    private UserService userService;
    
    // 리뷰 작성 - 다중 fallback 전략
    public boolean writeReview(ReviewVO review) {
        System.out.println("=== ReviewService.writeReview 시작 ===");
        System.out.println("입력 데이터: " + review.toString());
        
        try {
            // 1차 시도: 기본 insertReview (useGeneratedKeys=true, keyColumn 명시)
            System.out.println("1차 시도: insertReview (useGeneratedKeys + keyColumn)");
            int result = reviewDAO.insertReview(review);
            
            if (result > 0 && review.getReviewNum() != null) {
                System.out.println("✅ 1차 성공: reviewNum = " + review.getReviewNum());
                return true;
            }
            
            System.out.println("1차 실패, 2차 시도로 넘어감");
            
        } catch (Exception e) {
            System.out.println("1차 시도 예외: " + e.getMessage());
        }
        
        try {
            // 2차 시도: SelectKey 사용
            System.out.println("2차 시도: insertReviewWithSelectKey");
            int result = reviewDAO.insertReviewWithSelectKey(review);
            
            if (result > 0 && review.getReviewNum() != null) {
                System.out.println("✅ 2차 성공: reviewNum = " + review.getReviewNum());
                return true;
            }
            
            System.out.println("2차 실패, 3차 시도로 넘어감");
            
        } catch (Exception e) {
            System.out.println("2차 시도 예외: " + e.getMessage());
        }
        
        try {
            // 3차 시도: RETURNING 절 사용 (Oracle 12c+)
            System.out.println("3차 시도: insertReviewWithReturning");
            int result = reviewDAO.insertReviewWithReturning(review);
            
            if (result > 0 && review.getReviewNum() != null) {
                System.out.println("✅ 3차 성공: reviewNum = " + review.getReviewNum());
                return true;
            }
            
            System.out.println("3차 실패");
            
        } catch (Exception e) {
            System.out.println("3차 시도 예외: " + e.getMessage());
        }
        
        System.out.println("❌ 모든 방법 실패");
        throw new HellkingException("리뷰 작성 중 오류가 발생했습니다. 관리자에게 문의해주세요.");
    }
    
    // 리뷰 수정
    public boolean updateReview(ReviewVO review, Long currentUserNum) {
        ReviewVO existingReview = reviewDAO.selectByReviewNum(review.getReviewNum());
        if (existingReview == null) {
            throw new HellkingException("존재하지 않는 리뷰입니다.");
        }
        
        if (!existingReview.getUserNum().equals(currentUserNum)) {
            throw new HellkingException("리뷰 수정 권한이 없습니다.");
        }
        
        try {
            return reviewDAO.updateReview(review) > 0;
        } catch (Exception e) {
            throw new HellkingException("리뷰 수정 중 오류가 발생했습니다: " + e.getMessage());
        }
    }
    
    // 리뷰 삭제
    @Transactional
    public boolean deleteReview(Long reviewNum, Long currentUserNum) {
        ReviewVO existingReview = reviewDAO.selectByReviewNum(reviewNum);
        if (existingReview == null) {
            throw new HellkingException("존재하지 않는 리뷰입니다.");
        }
        
        if (!existingReview.getUserNum().equals(currentUserNum)) {
            throw new HellkingException("리뷰 삭제 권한이 없습니다.");
        }
        
        try {
            return reviewDAO.deleteReview(reviewNum, currentUserNum) > 0;
        } catch (Exception e) {
            throw new HellkingException("리뷰 삭제 중 오류가 발생했습니다: " + e.getMessage());
        }
    }
    
    // 리뷰 상세 조회 (조회수 증가)
    @Transactional
    public ReviewVO getReviewDetail(Long reviewNum, Long currentUserNum) {
        System.out.println("=== ReviewService.getReviewDetail 시작 ===");
        System.out.println("요청된 reviewNum: " + reviewNum);
        System.out.println("현재 사용자 userNum: " + currentUserNum);
        
        try {
            ReviewVO review = reviewDAO.selectByReviewNum(reviewNum);
            System.out.println("DAO 조회 결과: " + (review != null ? "성공" : "실패"));
            
            if (review != null) {
                System.out.println("조회된 리뷰 정보:");
                System.out.println("- reviewNum: " + review.getReviewNum());
                System.out.println("- userNum: " + review.getUserNum());
                System.out.println("- title: " + review.getTitle());
                System.out.println("- chainNum: " + review.getChainNum());
            }
            
            if (review == null) {
                System.out.println("리뷰를 찾을 수 없음 - reviewNum: " + reviewNum);
                throw new HellkingException("리뷰 번호 " + reviewNum + "에 해당하는 리뷰를 찾을 수 없습니다.");
            }
            
            // 조회수 증가 (본인 리뷰가 아닐 경우에만)
            if (currentUserNum == null || !review.getUserNum().equals(currentUserNum)) {
                System.out.println("조회수 증가 처리");
                reviewDAO.increaseViewCount(reviewNum);
                review.setViewCount(review.getViewCount() + 1);
            } else {
                System.out.println("본인 리뷰이므로 조회수 증가 생략");
            }
            
            // 현재 사용자의 좋아요 상태 조회
            if (currentUserNum != null) {
                try {
                    String likeType = reviewDAO.getUserLikeType(reviewNum, currentUserNum);
                    review.setCurrentUserLikeType(likeType);
                    System.out.println("사용자 좋아요 상태: " + likeType);
                } catch (Exception e) {
                    System.out.println("좋아요 상태 조회 실패: " + e.getMessage());
                    // 좋아요 상태 조회 실패는 전체 로직에 영향을 주지 않음
                }
            }
            
            System.out.println("=== ReviewService.getReviewDetail 완료 ===");
            return review;
            
        } catch (HellkingException e) {
            System.out.println("HellkingException 발생: " + e.getMessage());
            throw e;
        } catch (Exception e) {
            System.out.println("예상치 못한 오류 발생: " + e.getMessage());
            e.printStackTrace();
            throw new HellkingException("리뷰 조회 중 오류가 발생했습니다: " + e.getMessage());
        }
    }
    
    // 전체 리뷰 목록
    public Map<String, Object> getAllReviews(String sortBy, int page, int size) {
        if (sortBy == null) sortBy = "latest";
        int offset = (page - 1) * size;
        
        try {
            List<ReviewVO> reviews = reviewDAO.selectAllReviews(sortBy, offset, size);
            int totalCount = reviewDAO.getTotalReviewCount();
            int totalPages = (int) Math.ceil((double) totalCount / size);
            
            Map<String, Object> result = new HashMap<>();
            result.put("reviews", reviews);
            result.put("currentPage", page);
            result.put("totalPages", totalPages);
            result.put("totalCount", totalCount);
            result.put("hasNext", page < totalPages);
            result.put("hasPrev", page > 1);
            
            return result;
        } catch (Exception e) {
            System.out.println("리뷰 목록 조회 오류: " + e.getMessage());
            e.printStackTrace();
            throw new HellkingException("리뷰 목록 조회 중 오류가 발생했습니다: " + e.getMessage());
        }
    }
    
    // 가맹점별 리뷰
    public Map<String, Object> getChainReviews(Long chainNum, int page, int size) {
        int offset = (page - 1) * size;
        
        List<ReviewVO> reviews = reviewDAO.selectByChainNum(chainNum, offset, size);
        int totalCount = reviewDAO.getChainReviewCount(chainNum);
        int totalPages = (int) Math.ceil((double) totalCount / size);
        
        Map<String, Object> result = new HashMap<>();
        result.put("reviews", reviews);
        result.put("currentPage", page);
        result.put("totalPages", totalPages);
        result.put("totalCount", totalCount);
        
        return result;
    }
    
    // 내 리뷰 목록
    public List<ReviewVO> getUserReviews(Long userNum) {
        return reviewDAO.selectByUserNum(userNum);
    }
    
    // 우수 리뷰
    public List<ReviewVO> getExcellentReviews(int limit) {
        try {
            return reviewDAO.selectExcellentReviews(limit);
        } catch (Exception e) {
            System.out.println("우수 리뷰 조회 오류: " + e.getMessage());
            // 우수 리뷰 조회 실패시 빈 리스트 반환
            return new java.util.ArrayList<>();
        }
    }
    
    // 리뷰 검색
    public Map<String, Object> searchReviews(String keyword, int page, int size) {
        int offset = (page - 1) * size;
        
        List<ReviewVO> reviews = reviewDAO.searchReviews(keyword, offset, size);
        
        // getSearchResultCount 메서드가 없다면 기본 카운트 사용
        int totalCount;
        try {
            totalCount = reviewDAO.getSearchResultCount(keyword);
        } catch (Exception e) {
            System.out.println("검색 결과 카운트 조회 실패, 기본값 사용: " + e.getMessage());
            totalCount = reviews.size() < size ? reviews.size() : size * page + 1;
        }
        
        int totalPages = (int) Math.ceil((double) totalCount / size);
        
        Map<String, Object> result = new HashMap<>();
        result.put("reviews", reviews);
        result.put("currentPage", page);
        result.put("totalPages", totalPages);
        result.put("totalCount", totalCount);
        result.put("keyword", keyword);
        result.put("hasNext", page < totalPages);
        result.put("hasPrev", page > 1);
        
        return result;
    }
    
    // 댓글 작성
    public boolean writeComment(ReviewCommentVO comment) {
        try {
            return reviewDAO.insertComment(comment) > 0;
        } catch (Exception e) {
            throw new HellkingException("댓글 작성 중 오류가 발생했습니다: " + e.getMessage());
        }
    }
    
    // 댓글 목록
    public List<ReviewCommentVO> getComments(Long reviewNum) {
        try {
            return reviewDAO.selectCommentsByReviewNum(reviewNum);
        } catch (Exception e) {
            System.out.println("댓글 목록 조회 오류: " + e.getMessage());
            return new java.util.ArrayList<>();
        }
    }
    
    // 좋아요/싫어요 처리
    @Transactional
    public Map<String, Object> toggleLike(Long reviewNum, Long userNum, String likeType) {
        Map<String, Object> result = new HashMap<>();
        
        try {
            String currentLikeType = reviewDAO.getUserLikeType(reviewNum, userNum);
            
            if (likeType.equals(currentLikeType)) {
                // 같은 타입이면 취소
                reviewDAO.deleteLike(reviewNum, userNum);
                result.put("action", "removed");
            } else {
                // 다른 타입이거나 없으면 추가/변경
                reviewDAO.insertOrUpdateLike(reviewNum, userNum, likeType);
                result.put("action", "added");
            }
            
            // 좋아요/싫어요 수 업데이트
            reviewDAO.updateLikeCounts(reviewNum);
            
            // 업데이트된 리뷰 정보 조회
            ReviewVO review = reviewDAO.selectByReviewNum(reviewNum);
            result.put("success", true);
            result.put("likeCount", review.getLikeCount());
            result.put("dislikeCount", review.getDislikeCount());
            result.put("currentUserLikeType", reviewDAO.getUserLikeType(reviewNum, userNum));
            
        } catch (Exception e) {
            result.put("success", false);
            result.put("message", "처리 중 오류가 발생했습니다.");
        }
        
        return result;
    }
    
    // 사용자별 리뷰 통계
    public Map<String, Object> getUserReviewStats(Long userNum) {
        List<ReviewVO> userReviews = reviewDAO.selectByUserNum(userNum);
        
        Map<String, Object> stats = new HashMap<>();
        stats.put("totalCount", userReviews.size());
        
        if (!userReviews.isEmpty()) {
            double avgRating = userReviews.stream()
                .mapToDouble(ReviewVO::getRating)
                .average()
                .orElse(0.0);
            stats.put("avgRating", Math.round(avgRating * 10) / 10.0);
            
            long totalLikes = userReviews.stream()
                .mapToLong(ReviewVO::getLikeCount)
                .sum();
            stats.put("totalLikes", totalLikes);
        } else {
            stats.put("avgRating", 0.0);
            stats.put("totalLikes", 0L);
        }
        
        return stats;
    }
}