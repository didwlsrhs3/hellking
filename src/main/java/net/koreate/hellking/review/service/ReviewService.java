package net.koreate.hellking.review.service;

<<<<<<< HEAD
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
=======
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import net.koreate.hellking.chain.dao.ChainDAO;
import net.koreate.hellking.common.exception.HellkingException;
import net.koreate.hellking.review.dao.ReviewDAO;
import net.koreate.hellking.review.vo.ReviewCommentVO;
import net.koreate.hellking.review.vo.ReviewImageVO;
import net.koreate.hellking.review.vo.ReviewVO;
import net.koreate.hellking.user.service.UserService;
>>>>>>> b65c320 (Initial commit)

@Service
@Transactional
public class ReviewService {
    
    @Autowired
    private ReviewDAO reviewDAO;
    
    @Autowired
    private UserService userService;
    
<<<<<<< HEAD
    // 리뷰 작성 - 다중 fallback 전략
=======
    @Autowired
    private ChainDAO chainDAO;
    
    // ===== 기본 리뷰 작성 (평점 자동 반영) =====
>>>>>>> b65c320 (Initial commit)
    public boolean writeReview(ReviewVO review) {
        System.out.println("=== ReviewService.writeReview 시작 ===");
        System.out.println("입력 데이터: " + review.toString());
        
        try {
<<<<<<< HEAD
            // 1차 시도: 기본 insertReview (useGeneratedKeys=true, keyColumn 명시)
=======
            // 1차 시도: 기본 insertReview
>>>>>>> b65c320 (Initial commit)
            System.out.println("1차 시도: insertReview (useGeneratedKeys + keyColumn)");
            int result = reviewDAO.insertReview(review);
            
            if (result > 0 && review.getReviewNum() != null) {
                System.out.println("✅ 1차 성공: reviewNum = " + review.getReviewNum());
<<<<<<< HEAD
=======
                // 가맹점 평점 자동 업데이트
                updateChainRatingByReview(review.getChainNum());
>>>>>>> b65c320 (Initial commit)
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
<<<<<<< HEAD
=======
                // 가맹점 평점 자동 업데이트
                updateChainRatingByReview(review.getChainNum());
>>>>>>> b65c320 (Initial commit)
                return true;
            }
            
            System.out.println("2차 실패, 3차 시도로 넘어감");
            
        } catch (Exception e) {
            System.out.println("2차 시도 예외: " + e.getMessage());
        }
        
        try {
<<<<<<< HEAD
            // 3차 시도: RETURNING 절 사용 (Oracle 12c+)
=======
            // 3차 시도: RETURNING 절 사용
>>>>>>> b65c320 (Initial commit)
            System.out.println("3차 시도: insertReviewWithReturning");
            int result = reviewDAO.insertReviewWithReturning(review);
            
            if (result > 0 && review.getReviewNum() != null) {
                System.out.println("✅ 3차 성공: reviewNum = " + review.getReviewNum());
<<<<<<< HEAD
                return true;
            }
            
            System.out.println("3차 실패");
            
=======
                // 가맹점 평점 자동 업데이트
                updateChainRatingByReview(review.getChainNum());
                return true;
            }
            
>>>>>>> b65c320 (Initial commit)
        } catch (Exception e) {
            System.out.println("3차 시도 예외: " + e.getMessage());
        }
        
        System.out.println("❌ 모든 방법 실패");
        throw new HellkingException("리뷰 작성 중 오류가 발생했습니다. 관리자에게 문의해주세요.");
    }
    
<<<<<<< HEAD
    // 리뷰 수정
=======
    // ===== 이미지 포함 리뷰 작성 (평점 자동 반영) =====
    @Transactional
    public boolean writeReviewWithImages(ReviewVO review, List<String> imageFileNames) {
        System.out.println("=== ReviewService.writeReviewWithImages 시작 ===");
        System.out.println("이미지 파일 개수: " + (imageFileNames != null ? imageFileNames.size() : 0));
        
        try {
            // 1. 리뷰 저장 (기존 로직 사용)
            boolean reviewSaved = writeReview(review);
            if (!reviewSaved || review.getReviewNum() == null) {
                throw new HellkingException("리뷰 저장에 실패했습니다.");
            }
            
            System.out.println("리뷰 저장 완료, reviewNum: " + review.getReviewNum());
            
            // 2. 이미지 저장
            if (imageFileNames != null && !imageFileNames.isEmpty()) {
                saveReviewImages(review.getReviewNum(), imageFileNames);
            }
            
            // 3. 가맹점 평점은 writeReview에서 이미 업데이트됨
            System.out.println("리뷰 및 이미지 저장 완료");
            return true;
            
        } catch (Exception e) {
            System.err.println("리뷰 이미지 저장 오류: " + e.getMessage());
            throw new HellkingException("리뷰 저장 중 오류가 발생했습니다: " + e.getMessage());
        }
    }
    
    // ===== 리뷰 수정 (평점 자동 반영) =====
>>>>>>> b65c320 (Initial commit)
    public boolean updateReview(ReviewVO review, Long currentUserNum) {
        ReviewVO existingReview = reviewDAO.selectByReviewNum(review.getReviewNum());
        if (existingReview == null) {
            throw new HellkingException("존재하지 않는 리뷰입니다.");
        }
        
        if (!existingReview.getUserNum().equals(currentUserNum)) {
            throw new HellkingException("리뷰 수정 권한이 없습니다.");
        }
        
        try {
<<<<<<< HEAD
            return reviewDAO.updateReview(review) > 0;
=======
            boolean success = reviewDAO.updateReview(review) > 0;
            if (success) {
                // 가맹점 평점 자동 업데이트
                updateChainRatingByReview(review.getChainNum());
            }
            return success;
>>>>>>> b65c320 (Initial commit)
        } catch (Exception e) {
            throw new HellkingException("리뷰 수정 중 오류가 발생했습니다: " + e.getMessage());
        }
    }
    
<<<<<<< HEAD
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
=======
    // ===== 이미지 포함 리뷰 수정 (평점 자동 반영) =====
    @Transactional
    public boolean updateReviewWithImages(ReviewVO review, List<String> newImageFileNames, 
                                         List<Long> deleteImageIds, Long currentUserNum) {
        try {
            // 1. 리뷰 기본 정보 수정
            boolean updated = updateReview(review, currentUserNum);
            if (!updated) {
                return false;
            }
            
            // 2. 삭제할 이미지 처리
            if (deleteImageIds != null && !deleteImageIds.isEmpty()) {
                for (Long imageId : deleteImageIds) {
                    reviewDAO.deleteReviewImage(imageId);
                }
                System.out.println("삭제된 이미지 개수: " + deleteImageIds.size());
            }
            
            // 3. 새 이미지 추가
            if (newImageFileNames != null && !newImageFileNames.isEmpty()) {
                List<ReviewImageVO> existingImages = reviewDAO.selectImagesByReviewNum(review.getReviewNum());
                int nextOrder = existingImages.size() + 1;
                
                for (int i = 0; i < newImageFileNames.size(); i++) {
                    String fileName = newImageFileNames.get(i);
                    
                    ReviewImageVO reviewImage = new ReviewImageVO();
                    reviewImage.setReviewNum(review.getReviewNum());
                    reviewImage.setImagePath(fileName);
                    reviewImage.setImageOrder(nextOrder + i);
                    
                    if (fileName.contains("_")) {
                        String originalName = fileName.substring(fileName.indexOf("_") + 1);
                        reviewImage.setOriginalName(originalName);
                    } else {
                        reviewImage.setOriginalName(fileName);
                    }
                    
                    reviewDAO.insertReviewImage(reviewImage);
                }
                System.out.println("추가된 이미지 개수: " + newImageFileNames.size());
            }
            
            // 4. 가맹점 평점은 updateReview에서 이미 업데이트됨
            return true;
            
        } catch (Exception e) {
            System.err.println("리뷰 이미지 수정 오류: " + e.getMessage());
            throw new HellkingException("리뷰 수정 중 오류가 발생했습니다: " + e.getMessage());
        }
    }
    
    // ===== 리뷰 삭제 (평점 자동 반영) =====
    @Transactional
    public boolean deleteReview(Long reviewNum, Long currentUserNum) {
        try {
            // 1. 가맹점 번호 미리 조회 (평점 업데이트용)
            ReviewVO review = reviewDAO.selectByReviewNum(reviewNum);
            if (review == null || !review.getUserNum().equals(currentUserNum)) {
                throw new HellkingException("리뷰 삭제 권한이 없습니다.");
            }
            
            Long chainNum = review.getChainNum();
            
            // 2. 리뷰 이미지 먼저 삭제
            reviewDAO.deleteAllImagesByReviewNum(reviewNum);
            
            // 3. 리뷰 삭제
            boolean deleted = reviewDAO.deleteReview(reviewNum, currentUserNum) > 0;
            
            // 4. 가맹점 평점 자동 업데이트
            if (deleted) {
                updateChainRatingByReview(chainNum);
            }
            
            return deleted;
            
        } catch (Exception e) {
            System.err.println("리뷰 삭제 오류: " + e.getMessage());
>>>>>>> b65c320 (Initial commit)
            throw new HellkingException("리뷰 삭제 중 오류가 발생했습니다: " + e.getMessage());
        }
    }
    
<<<<<<< HEAD
    // 리뷰 상세 조회 (조회수 증가)
=======
    // ===== 리뷰 상세 조회 (이미지 포함) =====
>>>>>>> b65c320 (Initial commit)
    @Transactional
    public ReviewVO getReviewDetail(Long reviewNum, Long currentUserNum) {
        System.out.println("=== ReviewService.getReviewDetail 시작 ===");
        System.out.println("요청된 reviewNum: " + reviewNum);
        System.out.println("현재 사용자 userNum: " + currentUserNum);
        
        try {
            ReviewVO review = reviewDAO.selectByReviewNum(reviewNum);
<<<<<<< HEAD
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
=======
            
            if (review == null) {
>>>>>>> b65c320 (Initial commit)
                throw new HellkingException("리뷰 번호 " + reviewNum + "에 해당하는 리뷰를 찾을 수 없습니다.");
            }
            
            // 조회수 증가 (본인 리뷰가 아닐 경우에만)
            if (currentUserNum == null || !review.getUserNum().equals(currentUserNum)) {
<<<<<<< HEAD
                System.out.println("조회수 증가 처리");
                reviewDAO.increaseViewCount(reviewNum);
                review.setViewCount(review.getViewCount() + 1);
            } else {
                System.out.println("본인 리뷰이므로 조회수 증가 생략");
=======
                reviewDAO.increaseViewCount(reviewNum);
                review.setViewCount(review.getViewCount() + 1);
>>>>>>> b65c320 (Initial commit)
            }
            
            // 현재 사용자의 좋아요 상태 조회
            if (currentUserNum != null) {
                try {
                    String likeType = reviewDAO.getUserLikeType(reviewNum, currentUserNum);
                    review.setCurrentUserLikeType(likeType);
<<<<<<< HEAD
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
=======
                } catch (Exception e) {
                    System.out.println("좋아요 상태 조회 실패: " + e.getMessage());
                }
            }
            
            // 리뷰 이미지 조회 추가
            try {
                List<ReviewImageVO> images = reviewDAO.selectImagesByReviewNum(reviewNum);
                review.setImages(images);
                System.out.println("리뷰 이미지 " + images.size() + "개 조회 완료");
                
                // 추가 디버그 로그
                for (ReviewImageVO image : images) {
                    System.out.println("이미지 경로: " + image.getImagePath());
                    System.out.println("원본 이름: " + image.getOriginalName());
                }
                
            } catch (Exception e) {
                System.err.println("리뷰 이미지 조회 오류: " + e.getMessage());
                review.setImages(new ArrayList<>());
            }
            
            return review;
            
        } catch (HellkingException e) {
            throw e;
        } catch (Exception e) {
            System.err.println("예상치 못한 오류 발생: " + e.getMessage());
>>>>>>> b65c320 (Initial commit)
            e.printStackTrace();
            throw new HellkingException("리뷰 조회 중 오류가 발생했습니다: " + e.getMessage());
        }
    }
    
<<<<<<< HEAD
    // 전체 리뷰 목록
    public Map<String, Object> getAllReviews(String sortBy, int page, int size) {
        if (sortBy == null) sortBy = "latest";
        int offset = (page - 1) * size;
        
        try {
            List<ReviewVO> reviews = reviewDAO.selectAllReviews(sortBy, offset, size);
=======
    // ===== 전체 리뷰 목록 조회 (10개 단위, 이미지 포함) =====
    public Map<String, Object> getAllReviews(String sortBy, int page, int size) {
        if (sortBy == null) sortBy = "latest";
        if (size != 10) size = 10; // 강제로 10개로 설정
        
        int offset = (page - 1) * size;
        
        try {
            System.out.println("=== 전체 리뷰 조회 ===");
            System.out.println("정렬: " + sortBy + ", 페이지: " + page + ", 크기: " + size);
            
            List<ReviewVO> reviews = reviewDAO.selectAllReviews(sortBy, offset, size);
            
            // 각 리뷰에 이미지 정보 추가
            for (ReviewVO review : reviews) {
                try {
                    List<ReviewImageVO> images = reviewDAO.selectImagesByReviewNum(review.getReviewNum());
                    review.setImages(images);
                } catch (Exception e) {
                    System.err.println("리뷰 " + review.getReviewNum() + " 이미지 로딩 실패: " + e.getMessage());
                    review.setImages(new ArrayList<>());
                }
            }
            
>>>>>>> b65c320 (Initial commit)
            int totalCount = reviewDAO.getTotalReviewCount();
            int totalPages = (int) Math.ceil((double) totalCount / size);
            
            Map<String, Object> result = new HashMap<>();
            result.put("reviews", reviews);
            result.put("currentPage", page);
            result.put("totalPages", totalPages);
            result.put("totalCount", totalCount);
            result.put("hasNext", page < totalPages);
            result.put("hasPrev", page > 1);
<<<<<<< HEAD
            
            return result;
        } catch (Exception e) {
            System.out.println("리뷰 목록 조회 오류: " + e.getMessage());
            e.printStackTrace();
=======
            result.put("pageSize", size);
            
            System.out.println("조회 완료: " + reviews.size() + "개 (전체 " + totalCount + "개)");
            
            return result;
        } catch (Exception e) {
            System.err.println("리뷰 목록 조회 오류: " + e.getMessage());
>>>>>>> b65c320 (Initial commit)
            throw new HellkingException("리뷰 목록 조회 중 오류가 발생했습니다: " + e.getMessage());
        }
    }
    
<<<<<<< HEAD
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
=======
    // ===== 리뷰 검색 (정렬 포함, 10개 단위, 이미지 포함) =====
    public Map<String, Object> searchReviews(String keyword, String sortBy, int page, int size) {
        if (keyword == null || keyword.trim().isEmpty()) {
            return getAllReviews(sortBy, page, size);
        }
        
        if (sortBy == null) sortBy = "latest";
        if (size != 10) size = 10; // 강제로 10개로 설정
        
        int offset = (page - 1) * size;
        String trimmedKeyword = keyword.trim();
        
        try {
            System.out.println("=== 리뷰 검색 ===");
            System.out.println("키워드: '" + trimmedKeyword + "', 정렬: " + sortBy);
            System.out.println("페이지: " + page + ", 크기: " + size);
            
            List<ReviewVO> reviews = reviewDAO.searchReviews(trimmedKeyword, sortBy, offset, size);
            
            // 각 리뷰에 이미지 정보 추가
            for (ReviewVO review : reviews) {
                try {
                    List<ReviewImageVO> images = reviewDAO.selectImagesByReviewNum(review.getReviewNum());
                    review.setImages(images);
                } catch (Exception e) {
                    System.err.println("리뷰 " + review.getReviewNum() + " 이미지 로딩 실패: " + e.getMessage());
                    review.setImages(new ArrayList<>());
                }
            }
            
            int totalCount;
            try {
                totalCount = reviewDAO.getSearchResultCount(trimmedKeyword);
            } catch (Exception e) {
                totalCount = reviews.size() < size ? reviews.size() : size * page + 1;
            }
            
            int totalPages = (int) Math.ceil((double) totalCount / size);
            
            Map<String, Object> result = new HashMap<>();
            result.put("reviews", reviews);
            result.put("currentPage", page);
            result.put("totalPages", totalPages);
            result.put("totalCount", totalCount);
            result.put("keyword", trimmedKeyword);
            result.put("hasNext", page < totalPages);
            result.put("hasPrev", page > 1);
            result.put("pageSize", size);
            result.put("isSearchResult", true);
            
            System.out.println("검색 완료: " + reviews.size() + "개 (전체 " + totalCount + "개)");
            
            return result;
        } catch (Exception e) {
            System.err.println("리뷰 검색 오류: " + e.getMessage());
            throw new HellkingException("리뷰 검색 중 오류가 발생했습니다: " + e.getMessage());
        }
    }
    
    // ===== 카테고리별 리뷰 조회 =====
    public Map<String, Object> getReviewsByCategory(String category, String sortBy, int page, int size) {
        if (sortBy == null) sortBy = "latest";
        if (size != 10) size = 10; // 강제로 10개로 설정
        
        int offset = (page - 1) * size;
        
        try {
            List<ReviewVO> reviews;
            int totalCount;
            
            switch (category) {
                case "excellent":
                    reviews = reviewDAO.selectExcellentReviewsWithPaging(sortBy, offset, size);
                    totalCount = reviewDAO.getExcellentReviewCount();
                    break;
                    
                case "recent":
                    reviews = reviewDAO.selectRecentReviews(sortBy, 30, offset, size);
                    totalCount = reviewDAO.getRecentReviewCount(30);
                    break;
                    
                case "popular":
                    reviews = reviewDAO.selectPopularReviews(sortBy, offset, size);
                    totalCount = reviewDAO.getPopularReviewCount();
                    break;
                    
                default:
                    return getAllReviews(sortBy, page, size);
            }
            
            // 각 리뷰에 이미지 정보 추가
            for (ReviewVO review : reviews) {
                try {
                    List<ReviewImageVO> images = reviewDAO.selectImagesByReviewNum(review.getReviewNum());
                    review.setImages(images);
                } catch (Exception e) {
                    System.err.println("리뷰 " + review.getReviewNum() + " 이미지 로딩 실패: " + e.getMessage());
                    review.setImages(new ArrayList<>());
                }
            }
            
            int totalPages = (int) Math.ceil((double) totalCount / size);
            
            Map<String, Object> result = new HashMap<>();
            result.put("reviews", reviews);
            result.put("currentPage", page);
            result.put("totalPages", totalPages);
            result.put("totalCount", totalCount);
            result.put("hasNext", page < totalPages);
            result.put("hasPrev", page > 1);
            result.put("pageSize", size);
            result.put("category", category);
            
            System.out.println("카테고리 '" + category + "' 리뷰 " + reviews.size() + "개 조회 완료");
            
            return result;
        } catch (Exception e) {
            System.err.println("카테고리별 리뷰 조회 오류: " + e.getMessage());
            throw new HellkingException("카테고리별 리뷰 조회 중 오류가 발생했습니다: " + e.getMessage());
        }
    }
    
    // ===== 카테고리별 리뷰 개수 조회 =====
    public Map<String, Long> getReviewCountByCategory() {
        Map<String, Long> categoryCount = new HashMap<>();
        
        try {
            // 전체 리뷰 수
            categoryCount.put("all", (long) reviewDAO.getTotalReviewCount());
            
            // 우수 리뷰 수
            categoryCount.put("excellent", (long) reviewDAO.getExcellentReviewCount());
            
            // 이달의 리뷰 수 (최근 30일)
            categoryCount.put("recent", (long) reviewDAO.getRecentReviewCount(30));
            
            // 인기 리뷰 수 (좋아요 5개 이상)
            categoryCount.put("popular", (long) reviewDAO.getPopularReviewCount());
            
        } catch (Exception e) {
            System.err.println("카테고리별 리뷰 개수 조회 오류: " + e.getMessage());
            // 기본값 설정
            categoryCount.put("all", 0L);
            categoryCount.put("excellent", 0L);
            categoryCount.put("recent", 0L);
            categoryCount.put("popular", 0L);
        }
        
        return categoryCount;
    }
    
    // ===== 가맹점별 리뷰 조회 (이미지 포함) =====
    public Map<String, Object> getChainReviews(Long chainNum, int page, int size) {
        int offset = (page - 1) * size;
        
        try {
            List<ReviewVO> reviews = reviewDAO.selectByChainNum(chainNum, offset, size);
            
            // 각 리뷰에 이미지 정보 추가
            for (ReviewVO review : reviews) {
                try {
                    List<ReviewImageVO> images = reviewDAO.selectImagesByReviewNum(review.getReviewNum());
                    review.setImages(images);
                } catch (Exception e) {
                    System.err.println("리뷰 " + review.getReviewNum() + " 이미지 로딩 실패: " + e.getMessage());
                    review.setImages(new ArrayList<>());
                }
            }
            
            int totalCount = reviewDAO.getChainReviewCount(chainNum);
            int totalPages = (int) Math.ceil((double) totalCount / size);
            
            Map<String, Object> result = new HashMap<>();
            result.put("reviews", reviews);
            result.put("currentPage", page);
            result.put("totalPages", totalPages);
            result.put("totalCount", totalCount);
            
            System.out.println("가맹점 " + chainNum + " 리뷰 " + reviews.size() + "개 조회 완료 (이미지 포함)");
            
            return result;
        } catch (Exception e) {
            System.err.println("가맹점 리뷰 조회 오류: " + e.getMessage());
            throw new HellkingException("가맹점 리뷰 조회 중 오류가 발생했습니다: " + e.getMessage());
        }
    }
    
    // ===== 사용자별 리뷰 조회 (이미지 포함) =====
    public List<ReviewVO> getUserReviews(Long userNum) {
        try {
            List<ReviewVO> reviews = reviewDAO.selectByUserNum(userNum);
            
            // 각 리뷰에 이미지 정보 추가
            for (ReviewVO review : reviews) {
                try {
                    List<ReviewImageVO> images = reviewDAO.selectImagesByReviewNum(review.getReviewNum());
                    review.setImages(images);
                } catch (Exception e) {
                    System.err.println("리뷰 " + review.getReviewNum() + " 이미지 로딩 실패: " + e.getMessage());
                    review.setImages(new ArrayList<>());
                }
            }
            
            System.out.println("사용자 " + userNum + " 리뷰 " + reviews.size() + "개 조회 완료 (이미지 포함)");
            
            return reviews;
        } catch (Exception e) {
            System.err.println("사용자 리뷰 조회 오류: " + e.getMessage());
            return new ArrayList<>();
        }
    }
    
    // ===== 우수 리뷰 조회 (이미지 포함) =====
    public List<ReviewVO> getExcellentReviews(int limit) {
        try {
            List<ReviewVO> reviews = reviewDAO.selectExcellentReviews(limit);
            
            // 각 리뷰에 이미지 정보 추가
            for (ReviewVO review : reviews) {
                try {
                    List<ReviewImageVO> images = reviewDAO.selectImagesByReviewNum(review.getReviewNum());
                    review.setImages(images);
                } catch (Exception e) {
                    System.err.println("리뷰 " + review.getReviewNum() + " 이미지 로딩 실패: " + e.getMessage());
                    review.setImages(new ArrayList<>());
                }
            }
            
            System.out.println("우수 리뷰 " + reviews.size() + "개 조회 완료 (이미지 포함)");
            
            return reviews;
        } catch (Exception e) {
            System.out.println("우수 리뷰 조회 오류: " + e.getMessage());
            return new ArrayList<>();
        }
    }
    
    // ===== 이미지 관련 메서드 =====
    private void saveReviewImages(Long reviewNum, List<String> imageFileNames) {
        for (int i = 0; i < imageFileNames.size(); i++) {
            String fileName = imageFileNames.get(i);
            
            ReviewImageVO reviewImage = new ReviewImageVO();
            reviewImage.setReviewNum(reviewNum);
            reviewImage.setImagePath(fileName);
            reviewImage.setImageOrder(i + 1);
            reviewImage.setImageSize(0L); // 기본값 설정
            
            if (fileName.contains("_")) {
                String originalName = fileName.substring(fileName.indexOf("_") + 1);
                reviewImage.setOriginalName(originalName);
            } else {
                reviewImage.setOriginalName(fileName);
            }
            
            try {
                reviewDAO.insertReviewImage(reviewImage);
                System.out.println("이미지 저장 완료: " + fileName + " (순서: " + (i + 1) + ")");
            } catch (Exception e) {
                System.err.println("이미지 저장 실패: " + fileName + " - " + e.getMessage());
            }
        }
    }
    
    @Transactional
    public boolean updateImageOrders(List<Map<String, Object>> imageOrders) {
        try {
            for (Map<String, Object> orderInfo : imageOrders) {
                Long imageNum = Long.valueOf(orderInfo.get("imageNum").toString());
                Integer newOrder = Integer.valueOf(orderInfo.get("order").toString());
                
                reviewDAO.updateImageOrder(imageNum, newOrder);
            }
            System.out.println("이미지 순서 변경 완료: " + imageOrders.size() + "개");
            return true;
            
        } catch (Exception e) {
            System.err.println("이미지 순서 변경 오류: " + e.getMessage());
            return false;
        }
    }
    
    // ===== 가맹점 평점 자동 반영 메서드 =====
    
    /**
     * 리뷰 작성/수정/삭제 시 가맹점 평점 자동 업데이트
     */
    @Transactional
    public void updateChainRatingByReview(Long chainNum) {
        try {
            System.out.println("=== 가맹점 평점 자동 업데이트 시작 ===");
            System.out.println("대상 가맹점: " + chainNum);
            
            // 가맹점 평점 업데이트 (리뷰 평점 평균 계산)
            int updateCount = reviewDAO.updateChainRating(chainNum);
            System.out.println("가맹점 " + chainNum + " 평점 업데이트 완료: " + updateCount + "건");
            
            // 업데이트 결과 확인 및 로깅
            Map<String, Object> stats = reviewDAO.getChainRatingStats(chainNum);
            if (stats != null) {
                Double avgRating = (Double) stats.get("avgRating");
                Long reviewCount = ((Number) stats.get("reviewCount")).longValue();
                System.out.println("가맹점 평점 현황 - 리뷰수: " + reviewCount + 
                                 ", 평균평점: " + String.format("%.1f", avgRating != null ? avgRating : 0.0));
            }
            System.out.println("=== 가맹점 평점 자동 업데이트 완료 ===");
            
        } catch (Exception e) {
            System.err.println("가맹점 평점 업데이트 오류: " + e.getMessage());
            // 평점 업데이트 실패는 전체 트랜잭션을 롤백시키지 않음 (로그만 남김)
        }
    }
    
    /**
     * 모든 가맹점 평점 재계산 (관리자용)
     */
    @Transactional
    public Map<String, Object> recalculateAllChainRatings() {
        Map<String, Object> result = new HashMap<>();
        
        try {
            System.out.println("=== 전체 가맹점 평점 재계산 시작 ===");
            int updatedCount = reviewDAO.updateAllChainRatings();
            
            result.put("success", true);
            result.put("updatedChains", updatedCount);
            result.put("message", updatedCount + "개 가맹점의 평점이 재계산되었습니다.");
            
            System.out.println("전체 가맹점 평점 재계산 완료: " + updatedCount + "개");
            
        } catch (Exception e) {
            result.put("success", false);
            result.put("message", "평점 재계산 중 오류 발생: " + e.getMessage());
            System.err.println("평점 재계산 오류: " + e.getMessage());
        }
>>>>>>> b65c320 (Initial commit)
        
        return result;
    }
    
<<<<<<< HEAD
    // 댓글 작성
=======
    // ===== 댓글 관련 메서드 =====
    
>>>>>>> b65c320 (Initial commit)
    public boolean writeComment(ReviewCommentVO comment) {
        try {
            return reviewDAO.insertComment(comment) > 0;
        } catch (Exception e) {
            throw new HellkingException("댓글 작성 중 오류가 발생했습니다: " + e.getMessage());
        }
    }
    
<<<<<<< HEAD
    // 댓글 목록
=======
>>>>>>> b65c320 (Initial commit)
    public List<ReviewCommentVO> getComments(Long reviewNum) {
        try {
            return reviewDAO.selectCommentsByReviewNum(reviewNum);
        } catch (Exception e) {
            System.out.println("댓글 목록 조회 오류: " + e.getMessage());
<<<<<<< HEAD
            return new java.util.ArrayList<>();
        }
    }
    
    // 좋아요/싫어요 처리
=======
            return new ArrayList<>();
        }
    }
    
    // ===== 좋아요/싫어요 관련 메서드 =====
    
>>>>>>> b65c320 (Initial commit)
    @Transactional
    public Map<String, Object> toggleLike(Long reviewNum, Long userNum, String likeType) {
        Map<String, Object> result = new HashMap<>();
        
        try {
            String currentLikeType = reviewDAO.getUserLikeType(reviewNum, userNum);
            
            if (likeType.equals(currentLikeType)) {
<<<<<<< HEAD
                // 같은 타입이면 취소
                reviewDAO.deleteLike(reviewNum, userNum);
                result.put("action", "removed");
            } else {
                // 다른 타입이거나 없으면 추가/변경
=======
                reviewDAO.deleteLike(reviewNum, userNum);
                result.put("action", "removed");
            } else {
>>>>>>> b65c320 (Initial commit)
                reviewDAO.insertOrUpdateLike(reviewNum, userNum, likeType);
                result.put("action", "added");
            }
            
<<<<<<< HEAD
            // 좋아요/싫어요 수 업데이트
            reviewDAO.updateLikeCounts(reviewNum);
            
            // 업데이트된 리뷰 정보 조회
=======
            reviewDAO.updateLikeCounts(reviewNum);
            
            int totalReactions = reviewDAO.getTotalReactions(reviewNum);
            reviewDAO.updateExcellentStatusByReaction(reviewNum);
            
            if (totalReactions >= 5) {
                result.put("excellentStatusChanged", "promoted");
            } else if (totalReactions == 4) {
                result.put("excellentStatusChanged", "candidate");
            }
            
>>>>>>> b65c320 (Initial commit)
            ReviewVO review = reviewDAO.selectByReviewNum(reviewNum);
            result.put("success", true);
            result.put("likeCount", review.getLikeCount());
            result.put("dislikeCount", review.getDislikeCount());
<<<<<<< HEAD
            result.put("currentUserLikeType", reviewDAO.getUserLikeType(reviewNum, userNum));
            
        } catch (Exception e) {
=======
            result.put("totalReactions", totalReactions);
            result.put("isExcellent", review.getIsExcellent());
            result.put("currentUserLikeType", reviewDAO.getUserLikeType(reviewNum, userNum));
            
        } catch (Exception e) {
            System.err.println("좋아요/싫어요 처리 중 오류: " + e.getMessage());
>>>>>>> b65c320 (Initial commit)
            result.put("success", false);
            result.put("message", "처리 중 오류가 발생했습니다.");
        }
        
        return result;
    }
    
<<<<<<< HEAD
    // 사용자별 리뷰 통계
    public Map<String, Object> getUserReviewStats(Long userNum) {
        List<ReviewVO> userReviews = reviewDAO.selectByUserNum(userNum);
=======
    // ===== 통계 관련 메서드 =====
    
    public Map<String, Object> getUserReviewStats(Long userNum) {
        List<ReviewVO> userReviews = getUserReviews(userNum);
>>>>>>> b65c320 (Initial commit)
        
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
<<<<<<< HEAD
=======
    
    public Map<String, Object> getExcellentReviewStats() {
        Map<String, Object> stats = new HashMap<>();
        
        try {
            int totalExcellent = reviewDAO.getExcellentReviewCount();
            List<ReviewVO> candidates = reviewDAO.getCandidateReviews();
            
            stats.put("totalExcellentReviews", totalExcellent);
            stats.put("candidateReviews", candidates.size());
            stats.put("candidateList", candidates);
            
        } catch (Exception e) {
            System.err.println("우수리뷰 통계 조회 오류: " + e.getMessage());
            stats.put("totalExcellentReviews", 0);
            stats.put("candidateReviews", 0);
            stats.put("candidateList", new ArrayList<>());
        }
        
        return stats;
    }
    
    @Transactional
    public Map<String, Object> recalculateAllExcellentStatus() {
        Map<String, Object> result = new HashMap<>();
        
        try {
            int beforeCount = reviewDAO.getExcellentReviewCount();
            int updatedCount = reviewDAO.updateAllExcellentStatus();
            int afterCount = reviewDAO.getExcellentReviewCount();
            
            result.put("success", true);
            result.put("beforeCount", beforeCount);
            result.put("afterCount", afterCount);
            result.put("updatedReviews", updatedCount);
            result.put("message", "우수리뷰 상태가 재계산되었습니다. " +
                                "이전: " + beforeCount + "개 → 현재: " + afterCount + "개");
            
        } catch (Exception e) {
            result.put("success", false);
            result.put("message", "재계산 중 오류 발생: " + e.getMessage());
        }
        
        return result;
    }
>>>>>>> b65c320 (Initial commit)
}