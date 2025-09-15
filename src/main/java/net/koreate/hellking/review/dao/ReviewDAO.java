package net.koreate.hellking.review.dao;

import org.apache.ibatis.annotations.*;
import net.koreate.hellking.review.vo.*;
import java.util.List;
import java.util.Map;

@Mapper
public interface ReviewDAO {
    
    // 리뷰 기본 CRUD
    @Insert("INSERT INTO hk_reviews (user_num, chain_num, rating, title, content) " +
            "VALUES (#{userNum}, #{chainNum}, #{rating}, #{title}, #{content})")
    @Options(useGeneratedKeys = true, keyProperty = "reviewNum")
    int insertReview(ReviewVO review);
    
    @Select("SELECT r.*, u.username, u.profile_image as user_profile_image, " +
            "       c.chain_name, c.address as chain_address, " +
            "       COUNT(rc.comment_num) as comment_count " +
            "FROM hk_reviews r " +
            "JOIN hk_users u ON r.user_num = u.user_num " +
            "JOIN hk_chains c ON r.chain_num = c.chain_num " +
            "LEFT JOIN hk_review_comments rc ON r.review_num = rc.review_num " +
            "WHERE r.review_num = #{reviewNum} " +
            "GROUP BY r.review_num, r.user_num, r.chain_num, r.rating, r.title, " +
            "         r.content, r.like_count, r.dislike_count, r.is_excellent, " +
            "         r.view_count, r.created_at, u.username, u.profile_image, " +
            "         c.chain_name, c.address")
    ReviewVO selectByReviewNum(Long reviewNum);
    
    @Update("UPDATE hk_reviews SET title = #{title}, content = #{content}, rating = #{rating} " +
            "WHERE review_num = #{reviewNum} AND user_num = #{userNum}")
    int updateReview(ReviewVO review);
    
    @Delete("DELETE FROM hk_reviews WHERE review_num = #{reviewNum} AND user_num = #{userNum}")
    int deleteReview(@Param("reviewNum") Long reviewNum, @Param("userNum") Long userNum);
    
    // *** 문제 해결: CLOB 컬럼을 GROUP BY에서 제외하고 서브쿼리 사용 ***
    @Select("SELECT r.review_num, r.user_num, r.chain_num, r.rating, r.title, " +
            "       SUBSTR(r.content, 1, 200) as content, " +  // CLOB을 VARCHAR로 변환
            "       r.like_count, r.dislike_count, r.is_excellent, " +
            "       r.view_count, r.created_at, " +
            "       u.username, u.profile_image as user_profile_image, " +
            "       c.chain_name, " +
            "       (SELECT COUNT(*) FROM hk_review_comments rc WHERE rc.review_num = r.review_num) as comment_count " +
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
    
    // 가맹점별 리뷰 - 동일한 방식으로 수정
    @Select("SELECT r.review_num, r.user_num, r.chain_num, r.rating, r.title, " +
            "       SUBSTR(r.content, 1, 200) as content, " +
            "       r.like_count, r.dislike_count, r.is_excellent, " +
            "       r.view_count, r.created_at, " +
            "       u.username, u.profile_image as user_profile_image, " +
            "       (SELECT COUNT(*) FROM hk_review_comments rc WHERE rc.review_num = r.review_num) as comment_count " +
            "FROM hk_reviews r " +
            "JOIN hk_users u ON r.user_num = u.user_num " +
            "WHERE r.chain_num = #{chainNum} " +
            "ORDER BY r.created_at DESC " +
            "OFFSET #{offset} ROWS FETCH NEXT #{size} ROWS ONLY")
    List<ReviewVO> selectByChainNum(@Param("chainNum") Long chainNum,
                                   @Param("offset") int offset, 
                                   @Param("size") int size);
    
    // 사용자별 리뷰
    @Select("SELECT r.review_num, r.user_num, r.chain_num, r.rating, r.title, " +
            "       SUBSTR(r.content, 1, 200) as content, " +
            "       r.like_count, r.dislike_count, r.is_excellent, " +
            "       r.view_count, r.created_at, " +
            "       c.chain_name, " +
            "       (SELECT COUNT(*) FROM hk_review_comments rc WHERE rc.review_num = r.review_num) as comment_count " +
            "FROM hk_reviews r " +
            "JOIN hk_chains c ON r.chain_num = c.chain_num " +
            "WHERE r.user_num = #{userNum} " +
            "ORDER BY r.created_at DESC")
    List<ReviewVO> selectByUserNum(Long userNum);
    
    // 우수 리뷰
    @Select("SELECT r.review_num, r.user_num, r.chain_num, r.rating, r.title, " +
            "       SUBSTR(r.content, 1, 200) as content, " +
            "       r.like_count, r.dislike_count, r.is_excellent, " +
            "       r.view_count, r.created_at, " +
            "       u.username, u.profile_image as user_profile_image, " +
            "       c.chain_name, " +
            "       (SELECT COUNT(*) FROM hk_review_comments rc WHERE rc.review_num = r.review_num) as comment_count " +
            "FROM hk_reviews r " +
            "JOIN hk_users u ON r.user_num = u.user_num " +
            "JOIN hk_chains c ON r.chain_num = c.chain_num " +
            "WHERE r.rating >= 4.5 AND r.like_count >= 10 " +
            "ORDER BY r.like_count DESC, r.rating DESC " +
            "FETCH FIRST #{limit} ROWS ONLY")
    List<ReviewVO> selectExcellentReviews(int limit);
    
    // 조회수 증가
    @Update("UPDATE hk_reviews SET view_count = view_count + 1 WHERE review_num = #{reviewNum}")
    int increaseViewCount(Long reviewNum);
    
    // 댓글 관련
    @Insert("INSERT INTO hk_review_comments (review_num, user_num, content) " +
            "VALUES (#{reviewNum}, #{userNum}, #{content})")
    int insertComment(ReviewCommentVO comment);
    
    @Select("SELECT rc.*, u.username, u.profile_image as user_profile_image " +
            "FROM hk_review_comments rc " +
            "JOIN hk_users u ON rc.user_num = u.user_num " +
            "WHERE rc.review_num = #{reviewNum} " +
            "ORDER BY rc.created_at ASC")
    List<ReviewCommentVO> selectCommentsByReviewNum(Long reviewNum);
    
    @Delete("DELETE FROM hk_review_comments WHERE comment_num = #{commentNum} AND user_num = #{userNum}")
    int deleteComment(@Param("commentNum") Long commentNum, @Param("userNum") Long userNum);
    
    // 좋아요/싫어요 관련
    @Insert("INSERT INTO hk_review_likes (review_num, user_num, like_type) " +
            "VALUES (#{reviewNum}, #{userNum}, #{likeType}) " +
            "ON DUPLICATE KEY UPDATE like_type = #{likeType}")
    int insertOrUpdateLike(@Param("reviewNum") Long reviewNum, 
                          @Param("userNum") Long userNum, 
                          @Param("likeType") String likeType);
    
    @Delete("DELETE FROM hk_review_likes WHERE review_num = #{reviewNum} AND user_num = #{userNum}")
    int deleteLike(@Param("reviewNum") Long reviewNum, @Param("userNum") Long userNum);
    
    @Select("SELECT like_type FROM hk_review_likes WHERE review_num = #{reviewNum} AND user_num = #{userNum}")
    String getUserLikeType(@Param("reviewNum") Long reviewNum, @Param("userNum") Long userNum);
    
    // 좋아요/싫어요 수 업데이트
    @Update("UPDATE hk_reviews SET like_count = (" +
            "  SELECT COUNT(*) FROM hk_review_likes WHERE review_num = #{reviewNum} AND like_type = 'LIKE'" +
            "), dislike_count = (" +
            "  SELECT COUNT(*) FROM hk_review_likes WHERE review_num = #{reviewNum} AND like_type = 'DISLIKE'" +
            ") WHERE review_num = #{reviewNum}")
    int updateLikeCounts(Long reviewNum);
    
    // 검색 - 수정
    @Select("SELECT r.review_num, r.user_num, r.chain_num, r.rating, r.title, " +
            "       SUBSTR(r.content, 1, 200) as content, " +
            "       r.like_count, r.dislike_count, r.is_excellent, " +
            "       r.view_count, r.created_at, " +
            "       u.username, u.profile_image as user_profile_image, " +
            "       c.chain_name, " +
            "       (SELECT COUNT(*) FROM hk_review_comments rc WHERE rc.review_num = r.review_num) as comment_count " +
            "FROM hk_reviews r " +
            "JOIN hk_users u ON r.user_num = u.user_num " +
            "JOIN hk_chains c ON r.chain_num = c.chain_num " +
            "WHERE r.title LIKE '%'||#{keyword}||'%' " +
            "   OR DBMS_LOB.INSTR(r.content, #{keyword}) > 0 " +  // CLOB 검색 방법 변경
            "   OR c.chain_name LIKE '%'||#{keyword}||'%' " +
            "ORDER BY r.created_at DESC " +
            "OFFSET #{offset} ROWS FETCH NEXT #{size} ROWS ONLY")
    List<ReviewVO> searchReviews(@Param("keyword") String keyword,
                                @Param("offset") int offset, 
                                @Param("size") int size);
    
    // 통계
    @Select("SELECT COUNT(*) FROM hk_reviews")
    int getTotalReviewCount();
    
    @Select("SELECT COUNT(*) FROM hk_reviews WHERE chain_num = #{chainNum}")
    int getChainReviewCount(Long chainNum);
    
    @Select("SELECT COUNT(*) FROM hk_reviews WHERE user_num = #{userNum}")
    int getUserReviewCount(Long userNum);
}