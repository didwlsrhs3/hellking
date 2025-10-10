package net.koreate.hellking.review.dao;

<<<<<<< HEAD
import org.apache.ibatis.annotations.*;
import net.koreate.hellking.review.vo.*;
import java.util.List;
=======
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Options;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.SelectKey;
import org.apache.ibatis.annotations.Update;

import net.koreate.hellking.review.vo.ReviewCommentVO;
import net.koreate.hellking.review.vo.ReviewImageVO;
import net.koreate.hellking.review.vo.ReviewVO;
>>>>>>> b65c320 (Initial commit)

@Mapper
public interface ReviewDAO {
    
    // Oracle IDENTITY 컬럼용 - Options로 keyColumn 명시
    @Insert("INSERT INTO hk_reviews (user_num, chain_num, rating, title, content) " +
            "VALUES (#{userNum}, #{chainNum}, #{rating}, #{title}, #{content})")
    @Options(useGeneratedKeys = true, keyProperty = "reviewNum", keyColumn = "review_num")
    int insertReview(ReviewVO review);
    
    // 백업 방법: SelectKey 사용
    @Insert("INSERT INTO hk_reviews (user_num, chain_num, rating, title, content) " +
            "VALUES (#{userNum}, #{chainNum}, #{rating}, #{title}, #{content})")
    @SelectKey(statement = "SELECT review_num FROM hk_reviews WHERE ROWID = (SELECT MAX(ROWID) FROM hk_reviews)", 
               keyProperty = "reviewNum", before = false, resultType = Long.class)
    int insertReviewWithSelectKey(ReviewVO review);
    
    // 대안 방법: RETURNING 절 사용 (Oracle 12c+)
    @Insert("INSERT INTO hk_reviews (user_num, chain_num, rating, title, content) " +
            "VALUES (#{userNum}, #{chainNum}, #{rating}, #{title}, #{content}) " +
            "RETURNING review_num INTO #{reviewNum}")
    int insertReviewWithReturning(ReviewVO review);
    
    // 리뷰 상세 조회
    @Select("SELECT r.review_num as reviewNum, " +
            "       r.user_num as userNum, " +
            "       r.chain_num as chainNum, " +
            "       r.rating, r.title, r.content, " +
            "       r.like_count as likeCount, " +
            "       r.dislike_count as dislikeCount, " +
            "       r.is_excellent as isExcellent, " +
            "       r.view_count as viewCount, " +
            "       r.created_at as createdAt, " +
            "       u.username, " +
            "       u.profile_image as userProfileImage, " +
            "       c.chain_name as chainName, " +
            "       c.address as chainAddress " +
            "FROM hk_reviews r " +
            "LEFT JOIN hk_users u ON r.user_num = u.user_num " +
            "LEFT JOIN hk_chains c ON r.chain_num = c.chain_num " +
            "WHERE r.review_num = #{reviewNum}")
    ReviewVO selectByReviewNum(Long reviewNum);
    
    @Update("UPDATE hk_reviews SET title = #{title}, content = #{content}, rating = #{rating} " +
            "WHERE review_num = #{reviewNum} AND user_num = #{userNum}")
    int updateReview(ReviewVO review);
    
    @Delete("DELETE FROM hk_reviews WHERE review_num = #{reviewNum} AND user_num = #{userNum}")
    int deleteReview(@Param("reviewNum") Long reviewNum, @Param("userNum") Long userNum);
    
<<<<<<< HEAD
    // 전체 리뷰 목록
=======
    // 전체 리뷰 목록 (10개 단위 페이징)
>>>>>>> b65c320 (Initial commit)
    @Select("SELECT r.review_num as reviewNum, " +
            "       r.user_num as userNum, " +
            "       r.chain_num as chainNum, " +
            "       r.rating, r.title, " +
            "       SUBSTR(r.content, 1, 200) as content, " +
            "       r.like_count as likeCount, " +
            "       r.dislike_count as dislikeCount, " +
            "       r.is_excellent as isExcellent, " +
            "       r.view_count as viewCount, " +
            "       r.created_at as createdAt, " +
            "       u.username, " +
            "       u.profile_image as userProfileImage, " +
            "       c.chain_name as chainName, " +
            "       (SELECT COUNT(*) FROM hk_review_comments rc WHERE rc.review_num = r.review_num) as commentCount " +
            "FROM hk_reviews r " +
            "JOIN hk_users u ON r.user_num = u.user_num " +
            "JOIN hk_chains c ON r.chain_num = c.chain_num " +
            "ORDER BY " +
            "CASE WHEN #{sortBy} = 'latest' THEN r.created_at END DESC, " +
            "CASE WHEN #{sortBy} = 'rating' THEN r.rating END DESC, " +
            "CASE WHEN #{sortBy} = 'like' THEN r.like_count END DESC, " +
            "CASE WHEN #{sortBy} = 'view' THEN r.view_count END DESC " +
            "OFFSET #{offset} ROWS FETCH NEXT #{size} ROWS ONLY")
    List<ReviewVO> selectAllReviews(@Param("sortBy") String sortBy, 
                                   @Param("offset") int offset, 
                                   @Param("size") int size);
    
    // 가맹점별 리뷰
    @Select("SELECT r.review_num as reviewNum, " +
            "       r.user_num as userNum, " +
            "       r.chain_num as chainNum, " +
            "       r.rating, r.title, " +
            "       SUBSTR(r.content, 1, 200) as content, " +
            "       r.like_count as likeCount, " +
            "       r.dislike_count as dislikeCount, " +
            "       r.is_excellent as isExcellent, " +
            "       r.view_count as viewCount, " +
            "       r.created_at as createdAt, " +
            "       u.username, " +
            "       u.profile_image as userProfileImage, " +
            "       (SELECT COUNT(*) FROM hk_review_comments rc WHERE rc.review_num = r.review_num) as commentCount " +
            "FROM hk_reviews r " +
            "JOIN hk_users u ON r.user_num = u.user_num " +
            "WHERE r.chain_num = #{chainNum} " +
            "ORDER BY r.created_at DESC " +
            "OFFSET #{offset} ROWS FETCH NEXT #{size} ROWS ONLY")
    List<ReviewVO> selectByChainNum(@Param("chainNum") Long chainNum,
                                   @Param("offset") int offset, 
                                   @Param("size") int size);
    
    // 사용자별 리뷰
    @Select("SELECT r.review_num as reviewNum, " +
            "       r.user_num as userNum, " +
            "       r.chain_num as chainNum, " +
            "       r.rating, r.title, " +
            "       SUBSTR(r.content, 1, 200) as content, " +
            "       r.like_count as likeCount, " +
            "       r.dislike_count as dislikeCount, " +
            "       r.is_excellent as isExcellent, " +
            "       r.view_count as viewCount, " +
            "       r.created_at as createdAt, " +
            "       c.chain_name as chainName, " +
            "       (SELECT COUNT(*) FROM hk_review_comments rc WHERE rc.review_num = r.review_num) as commentCount " +
            "FROM hk_reviews r " +
            "JOIN hk_chains c ON r.chain_num = c.chain_num " +
            "WHERE r.user_num = #{userNum} " +
            "ORDER BY r.created_at DESC")
    List<ReviewVO> selectByUserNum(Long userNum);
    
<<<<<<< HEAD
    // 우수 리뷰
=======
    // 우수 리뷰 조회 (개선된 기준)
    @Select("SELECT r.review_num as reviewNum, " +
            "       r.user_num as userNum, " +
            "       r.chain_num as chainNum, " +
            "       r.rating, r.title, " +
            "       SUBSTR(r.content, 1, 200) as content, " +
            "       r.like_count as likeCount, " +
            "       r.dislike_count as dislikeCount, " +
            "       r.is_excellent as isExcellent, " +
            "       r.view_count as viewCount, " +
            "       r.created_at as createdAt, " +
            "       u.username, " +
            "       u.profile_image as userProfileImage, " +
            "       c.chain_name as chainName, " +
            "       (r.like_count - r.dislike_count) as netLikes, " +
            "       (r.like_count + r.dislike_count) as totalReactions, " +
            "       (SELECT COUNT(*) FROM hk_review_comments rc WHERE rc.review_num = r.review_num) as commentCount " +
            "FROM hk_reviews r " +
            "JOIN hk_users u ON r.user_num = u.user_num " +
            "JOIN hk_chains c ON r.chain_num = c.chain_num " +
            "WHERE (r.like_count + r.dislike_count) >= 5 " +
            "ORDER BY (r.like_count - r.dislike_count) DESC, " +
            "         r.view_count DESC, " +
            "         r.created_at DESC " +
            "FETCH FIRST #{limit} ROWS ONLY")
    List<ReviewVO> selectExcellentReviews(int limit);
    
    // 우수 리뷰 페이징 조회
    @Select("SELECT r.review_num as reviewNum, " +
            "       r.user_num as userNum, " +
            "       r.chain_num as chainNum, " +
            "       r.rating, r.title, " +
            "       SUBSTR(r.content, 1, 200) as content, " +
            "       r.like_count as likeCount, " +
            "       r.dislike_count as dislikeCount, " +
            "       r.is_excellent as isExcellent, " +
            "       r.view_count as viewCount, " +
            "       r.created_at as createdAt, " +
            "       u.username, " +
            "       u.profile_image as userProfileImage, " +
            "       c.chain_name as chainName, " +
            "       (r.like_count - r.dislike_count) as netLikes, " +
            "       (r.like_count + r.dislike_count) as totalReactions, " +
            "       (SELECT COUNT(*) FROM hk_review_comments rc WHERE rc.review_num = r.review_num) as commentCount " +
            "FROM hk_reviews r " +
            "JOIN hk_users u ON r.user_num = u.user_num " +
            "JOIN hk_chains c ON r.chain_num = c.chain_num " +
            "WHERE (r.like_count + r.dislike_count) >= 5 " +
            "ORDER BY " +
            "CASE WHEN #{sortBy} = 'latest' THEN r.created_at END DESC, " +
            "CASE WHEN #{sortBy} = 'rating' THEN r.rating END DESC, " +
            "CASE WHEN #{sortBy} = 'like' THEN (r.like_count - r.dislike_count) END DESC, " +
            "CASE WHEN #{sortBy} = 'view' THEN r.view_count END DESC, " +
            "(r.like_count - r.dislike_count) DESC, " +
            "r.view_count DESC, " +
            "r.created_at DESC " +
            "OFFSET #{offset} ROWS FETCH NEXT #{size} ROWS ONLY")
    List<ReviewVO> selectExcellentReviewsWithPaging(@Param("sortBy") String sortBy,
                                                  @Param("offset") int offset, 
                                                  @Param("size") int size);
    
    // 검색 기능 (정렬 포함)
>>>>>>> b65c320 (Initial commit)
    @Select("SELECT r.review_num as reviewNum, " +
            "       r.user_num as userNum, " +
            "       r.chain_num as chainNum, " +
            "       r.rating, r.title, " +
            "       SUBSTR(r.content, 1, 200) as content, " +
            "       r.like_count as likeCount, " +
            "       r.dislike_count as dislikeCount, " +
            "       r.is_excellent as isExcellent, " +
            "       r.view_count as viewCount, " +
            "       r.created_at as createdAt, " +
            "       u.username, " +
            "       u.profile_image as userProfileImage, " +
            "       c.chain_name as chainName, " +
            "       (SELECT COUNT(*) FROM hk_review_comments rc WHERE rc.review_num = r.review_num) as commentCount " +
            "FROM hk_reviews r " +
            "JOIN hk_users u ON r.user_num = u.user_num " +
            "JOIN hk_chains c ON r.chain_num = c.chain_num " +
<<<<<<< HEAD
            "WHERE r.rating >= 4.0 " +
            "ORDER BY r.rating DESC, r.like_count DESC " +
            "FETCH FIRST #{limit} ROWS ONLY")
    List<ReviewVO> selectExcellentReviews(int limit);
=======
            "WHERE UPPER(r.title) LIKE UPPER('%'||#{keyword}||'%') " +
            "   OR UPPER(DBMS_LOB.SUBSTR(r.content, 4000, 1)) LIKE UPPER('%'||#{keyword}||'%') " +
            "   OR UPPER(c.chain_name) LIKE UPPER('%'||#{keyword}||'%') " +
            "   OR UPPER(u.username) LIKE UPPER('%'||#{keyword}||'%') " +
            "ORDER BY " +
            "CASE WHEN #{sortBy} = 'latest' THEN r.created_at END DESC, " +
            "CASE WHEN #{sortBy} = 'rating' THEN r.rating END DESC, " +
            "CASE WHEN #{sortBy} = 'like' THEN r.like_count END DESC, " +
            "CASE WHEN #{sortBy} = 'view' THEN r.view_count END DESC, " +
            "r.created_at DESC " +
            "OFFSET #{offset} ROWS FETCH NEXT #{size} ROWS ONLY")
    List<ReviewVO> searchReviews(@Param("keyword") String keyword,
                               @Param("sortBy") String sortBy,
                               @Param("offset") int offset, 
                               @Param("size") int size);
    
    // 최근 리뷰 조회 (Oracle 문법 수정)
    @Select("SELECT r.review_num as reviewNum, " +
            "       r.user_num as userNum, " +
            "       r.chain_num as chainNum, " +
            "       r.rating, r.title, " +
            "       SUBSTR(r.content, 1, 200) as content, " +
            "       r.like_count as likeCount, " +
            "       r.dislike_count as dislikeCount, " +
            "       r.is_excellent as isExcellent, " +
            "       r.view_count as viewCount, " +
            "       r.created_at as createdAt, " +
            "       u.username, " +
            "       u.profile_image as userProfileImage, " +
            "       c.chain_name as chainName, " +
            "       (SELECT COUNT(*) FROM hk_review_comments rc WHERE rc.review_num = r.review_num) as commentCount " +
            "FROM hk_reviews r " +
            "JOIN hk_users u ON r.user_num = u.user_num " +
            "JOIN hk_chains c ON r.chain_num = c.chain_num " +
            "WHERE r.created_at >= CURRENT_TIMESTAMP - #{days} " +
            "ORDER BY " +
            "CASE WHEN #{sortBy} = 'latest' THEN r.created_at END DESC, " +
            "CASE WHEN #{sortBy} = 'rating' THEN r.rating END DESC, " +
            "CASE WHEN #{sortBy} = 'like' THEN r.like_count END DESC, " +
            "CASE WHEN #{sortBy} = 'view' THEN r.view_count END DESC " +
            "OFFSET #{offset} ROWS FETCH NEXT #{size} ROWS ONLY")
    List<ReviewVO> selectRecentReviews(@Param("sortBy") String sortBy,
                                     @Param("days") int days,
                                     @Param("offset") int offset, 
                                     @Param("size") int size);
    
    // 인기 리뷰 조회
    @Select("SELECT r.review_num as reviewNum, " +
            "       r.user_num as userNum, " +
            "       r.chain_num as chainNum, " +
            "       r.rating, r.title, " +
            "       SUBSTR(r.content, 1, 200) as content, " +
            "       r.like_count as likeCount, " +
            "       r.dislike_count as dislikeCount, " +
            "       r.is_excellent as isExcellent, " +
            "       r.view_count as viewCount, " +
            "       r.created_at as createdAt, " +
            "       u.username, " +
            "       u.profile_image as userProfileImage, " +
            "       c.chain_name as chainName, " +
            "       (SELECT COUNT(*) FROM hk_review_comments rc WHERE rc.review_num = r.review_num) as commentCount " +
            "FROM hk_reviews r " +
            "JOIN hk_users u ON r.user_num = u.user_num " +
            "JOIN hk_chains c ON r.chain_num = c.chain_num " +
            "WHERE r.like_count >= 5 " +
            "ORDER BY " +
            "CASE WHEN #{sortBy} = 'latest' THEN r.created_at END DESC, " +
            "CASE WHEN #{sortBy} = 'rating' THEN r.rating END DESC, " +
            "CASE WHEN #{sortBy} = 'like' THEN r.like_count END DESC, " +
            "CASE WHEN #{sortBy} = 'view' THEN r.view_count END DESC " +
            "OFFSET #{offset} ROWS FETCH NEXT #{size} ROWS ONLY")
    List<ReviewVO> selectPopularReviews(@Param("sortBy") String sortBy,
                                      @Param("offset") int offset, 
                                      @Param("size") int size);
>>>>>>> b65c320 (Initial commit)
    
    // 조회수 증가
    @Update("UPDATE hk_reviews SET view_count = view_count + 1 WHERE review_num = #{reviewNum}")
    int increaseViewCount(Long reviewNum);
    
    // 댓글 관련
    @Insert("INSERT INTO hk_review_comments (review_num, user_num, content) " +
            "VALUES (#{reviewNum}, #{userNum}, #{content})")
    @Options(useGeneratedKeys = true, keyProperty = "commentNum", keyColumn = "comment_num")
    int insertComment(ReviewCommentVO comment);
    
    @Select("SELECT rc.comment_num as commentNum, " +
            "       rc.review_num as reviewNum, " +
            "       rc.user_num as userNum, " +
            "       rc.content, " +
            "       rc.created_at as createdAt, " +
            "       u.username, " +
            "       u.profile_image as userProfileImage " +
            "FROM hk_review_comments rc " +
            "JOIN hk_users u ON rc.user_num = u.user_num " +
            "WHERE rc.review_num = #{reviewNum} " +
            "ORDER BY rc.created_at ASC")
    List<ReviewCommentVO> selectCommentsByReviewNum(Long reviewNum);
    
    @Delete("DELETE FROM hk_review_comments WHERE comment_num = #{commentNum} AND user_num = #{userNum}")
    int deleteComment(@Param("commentNum") Long commentNum, @Param("userNum") Long userNum);
    
    // 좋아요/싫어요 관련
    @Update("MERGE INTO hk_review_likes hl " +
            "USING (SELECT #{reviewNum} as review_num, #{userNum} as user_num, #{likeType} as like_type FROM dual) src " +
            "ON (hl.review_num = src.review_num AND hl.user_num = src.user_num) " +
            "WHEN MATCHED THEN UPDATE SET hl.like_type = src.like_type " +
            "WHEN NOT MATCHED THEN INSERT (review_num, user_num, like_type) " +
            "VALUES (src.review_num, src.user_num, src.like_type)")
    int insertOrUpdateLike(@Param("reviewNum") Long reviewNum, 
                          @Param("userNum") Long userNum, 
                          @Param("likeType") String likeType);
    
    @Delete("DELETE FROM hk_review_likes WHERE review_num = #{reviewNum} AND user_num = #{userNum}")
    int deleteLike(@Param("reviewNum") Long reviewNum, @Param("userNum") Long userNum);
    
    @Select("SELECT like_type FROM hk_review_likes WHERE review_num = #{reviewNum} AND user_num = #{userNum}")
    String getUserLikeType(@Param("reviewNum") Long reviewNum, @Param("userNum") Long userNum);
    
    // 좋아요/싫어요 수 업데이트
    @Update("UPDATE hk_reviews SET " +
            "like_count = (SELECT COUNT(*) FROM hk_review_likes WHERE review_num = #{reviewNum} AND like_type = 'LIKE'), " +
            "dislike_count = (SELECT COUNT(*) FROM hk_review_likes WHERE review_num = #{reviewNum} AND like_type = 'DISLIKE') " +
            "WHERE review_num = #{reviewNum}")
    int updateLikeCounts(Long reviewNum);
    
<<<<<<< HEAD
    // 검색
    @Select("SELECT r.review_num as reviewNum, " +
            "       r.user_num as userNum, " +
            "       r.chain_num as chainNum, " +
            "       r.rating, r.title, " +
            "       SUBSTR(r.content, 1, 200) as content, " +
            "       r.like_count as likeCount, " +
            "       r.dislike_count as dislikeCount, " +
            "       r.is_excellent as isExcellent, " +
            "       r.view_count as viewCount, " +
            "       r.created_at as createdAt, " +
            "       u.username, " +
            "       u.profile_image as userProfileImage, " +
            "       c.chain_name as chainName, " +
            "       (SELECT COUNT(*) FROM hk_review_comments rc WHERE rc.review_num = r.review_num) as commentCount " +
            "FROM hk_reviews r " +
            "JOIN hk_users u ON r.user_num = u.user_num " +
            "JOIN hk_chains c ON r.chain_num = c.chain_num " +
            "WHERE UPPER(r.title) LIKE UPPER('%'||#{keyword}||'%') " +
            "   OR UPPER(DBMS_LOB.SUBSTR(r.content, 4000, 1)) LIKE UPPER('%'||#{keyword}||'%') " +
            "   OR UPPER(c.chain_name) LIKE UPPER('%'||#{keyword}||'%') " +
            "ORDER BY r.created_at DESC " +
            "OFFSET #{offset} ROWS FETCH NEXT #{size} ROWS ONLY")
    List<ReviewVO> searchReviews(@Param("keyword") String keyword,
                                @Param("offset") int offset, 
                                @Param("size") int size);
    
    // 통계
=======
    // 통계 조회 메서드들
>>>>>>> b65c320 (Initial commit)
    @Select("SELECT COUNT(*) FROM hk_reviews")
    int getTotalReviewCount();
    
    @Select("SELECT COUNT(*) FROM hk_reviews WHERE chain_num = #{chainNum}")
    int getChainReviewCount(Long chainNum);
    
    @Select("SELECT COUNT(*) FROM hk_reviews WHERE user_num = #{userNum}")
    int getUserReviewCount(Long userNum);
    
<<<<<<< HEAD
    // 검색 결과 개수
    @Select("SELECT COUNT(*) FROM hk_reviews r " +
            "JOIN hk_chains c ON r.chain_num = c.chain_num " +
            "WHERE UPPER(r.title) LIKE UPPER('%'||#{keyword}||'%') " +
            "   OR UPPER(DBMS_LOB.SUBSTR(r.content, 4000, 1)) LIKE UPPER('%'||#{keyword}||'%') " +
            "   OR UPPER(c.chain_name) LIKE UPPER('%'||#{keyword}||'%')")
    int getSearchResultCount(@Param("keyword") String keyword);
=======
    // 검색 결과 개수 (사용자명 검색 추가)
    @Select("SELECT COUNT(*) FROM hk_reviews r " +
            "JOIN hk_chains c ON r.chain_num = c.chain_num " +
            "JOIN hk_users u ON r.user_num = u.user_num " +
            "WHERE UPPER(r.title) LIKE UPPER('%'||#{keyword}||'%') " +
            "   OR UPPER(DBMS_LOB.SUBSTR(r.content, 4000, 1)) LIKE UPPER('%'||#{keyword}||'%') " +
            "   OR UPPER(c.chain_name) LIKE UPPER('%'||#{keyword}||'%') " +
            "   OR UPPER(u.username) LIKE UPPER('%'||#{keyword}||'%')")
    int getSearchResultCount(@Param("keyword") String keyword);
    
    // 최근 리뷰 개수 (Oracle 문법 수정)
    @Select("SELECT COUNT(*) FROM hk_reviews " +
            "WHERE created_at >= CURRENT_TIMESTAMP - #{days}")
    int getRecentReviewCount(@Param("days") int days);
    
    // 인기 리뷰 개수
    @Select("SELECT COUNT(*) FROM hk_reviews WHERE like_count >= 5")
    int getPopularReviewCount();
    
    // 우수리뷰 관련 메서드들
    
    // 실시간 우수리뷰 상태 업데이트
    @Update("UPDATE hk_reviews SET is_excellent = " +
            "CASE " +
            "  WHEN (like_count + dislike_count) >= 5 THEN 'Y' " +
            "  ELSE 'N' " +
            "END " +
            "WHERE review_num = #{reviewNum}")
    int updateExcellentStatusByReaction(Long reviewNum);
    
    // 모든 리뷰의 우수리뷰 상태 일괄 업데이트
    @Update("UPDATE hk_reviews SET is_excellent = " +
            "CASE " +
            "  WHEN (like_count + dislike_count) >= 5 THEN 'Y' " +
            "  ELSE 'N' " +
            "END")
    int updateAllExcellentStatus();
    
    // 특정 리뷰의 총 반응수 조회
    @Select("SELECT (like_count + dislike_count) as totalReactions " +
            "FROM hk_reviews " +
            "WHERE review_num = #{reviewNum}")
    int getTotalReactions(Long reviewNum);
    
    // 우수리뷰 개수 조회
    @Select("SELECT COUNT(*) FROM hk_reviews " +
            "WHERE (like_count + dislike_count) >= 5")
    int getExcellentReviewCount();
    
    // 우수리뷰 후보 조회 (반응수 4개)
    @Select("SELECT r.review_num as reviewNum, " +
            "       r.user_num as userNum, " +
            "       r.title, " +
            "       r.like_count as likeCount, " +
            "       r.dislike_count as dislikeCount, " +
            "       (r.like_count + r.dislike_count) as totalReactions " +
            "FROM hk_reviews r " +
            "WHERE (r.like_count + r.dislike_count) = 4 " +
            "ORDER BY r.created_at DESC")
    List<ReviewVO> getCandidateReviews();
    
    // 우수리뷰 상태 업데이트 (수동)
    @Update("UPDATE hk_reviews SET is_excellent = #{status} WHERE review_num = #{reviewNum}")
    int updateExcellentStatus(@Param("reviewNum") Long reviewNum, @Param("status") String status);
    
    // ===== 리뷰 이미지 관련 메서드 =====
    
    // 리뷰 이미지 삽입
    @Insert("INSERT INTO hk_review_images (review_num, image_path, original_name, image_order, image_size) " +
            "VALUES (#{reviewNum}, #{imagePath}, #{originalName}, #{imageOrder}, #{imageSize, jdbcType=NUMERIC})")
    @Options(useGeneratedKeys = true, keyProperty = "imageNum", keyColumn = "image_num")
    int insertReviewImage(ReviewImageVO reviewImage);
    
    // 특정 리뷰의 이미지 목록 조회
    @Select("SELECT image_num as imageNum, review_num as reviewNum, " +
            "       image_path as imagePath, original_name as originalName, " +
            "       image_order as imageOrder, image_size as imageSize, created_at as createdAt " +
            "FROM hk_review_images " +
            "WHERE review_num = #{reviewNum} " +
            "ORDER BY image_order, created_at")
    List<ReviewImageVO> selectImagesByReviewNum(Long reviewNum);
    
    // 리뷰 이미지 삭제 (특정 이미지)
    @Delete("DELETE FROM hk_review_images WHERE image_num = #{imageNum}")
    int deleteReviewImage(Long imageNum);
    
    // 리뷰 삭제시 모든 이미지 삭제
    @Delete("DELETE FROM hk_review_images WHERE review_num = #{reviewNum}")
    int deleteAllImagesByReviewNum(Long reviewNum);
    
    // 이미지 순서 업데이트
    @Update("UPDATE hk_review_images SET image_order = #{imageOrder} WHERE image_num = #{imageNum}")
    int updateImageOrder(@Param("imageNum") Long imageNum, @Param("imageOrder") Integer imageOrder);
    
    // ===== 가맹점 평점 관련 메서드 =====
    
    // 특정 가맹점의 평점 통계 조회
    @Select("SELECT COUNT(*) as reviewCount, " +
            "       COALESCE(AVG(rating), 0) as avgRating, " +
            "       COALESCE(SUM(CASE WHEN rating >= 4 THEN 1 ELSE 0 END), 0) as positiveReviews " +
            "FROM hk_reviews WHERE chain_num = #{chainNum}")
    Map<String, Object> getChainRatingStats(Long chainNum);
    
    // 가맹점 평점 업데이트
    @Update("UPDATE hk_chains SET " +
            "avg_rating = (SELECT COALESCE(AVG(rating), 0) FROM hk_reviews WHERE chain_num = #{chainNum}), " +
            "review_count = (SELECT COUNT(*) FROM hk_reviews WHERE chain_num = #{chainNum}) " +
            "WHERE chain_num = #{chainNum}")
    int updateChainRating(Long chainNum);
    
    // 모든 가맹점 평점 일괄 업데이트
    @Update("UPDATE hk_chains c SET " +
            "(avg_rating, review_count) = (" +
            "  SELECT COALESCE(AVG(r.rating), 0), COUNT(r.review_num) " +
            "  FROM hk_reviews r WHERE r.chain_num = c.chain_num" +
            ")")
    int updateAllChainRatings();
>>>>>>> b65c320 (Initial commit)
}