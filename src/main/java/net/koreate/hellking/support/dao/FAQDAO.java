package net.koreate.hellking.support.dao;

import org.apache.ibatis.annotations.*;
import net.koreate.hellking.support.vo.FAQVO;
import net.koreate.hellking.support.vo.SupportSearchVO;
import java.util.List;

@Mapper
public interface FAQDAO {
    
    // FAQ 목록 조회 (페이징)
    @Results({
        @Result(property = "faqNum", column = "faq_num"),
        @Result(property = "title", column = "title"),
        @Result(property = "content", column = "content"),
        @Result(property = "createdAt", column = "created_at"),
        @Result(property = "updatedAt", column = "updated_at"),
        @Result(property = "createdBy", column = "created_by"),
        @Result(property = "status", column = "status"),
        @Result(property = "viewCount", column = "view_count"),
        @Result(property = "createdByName", column = "created_by_name")
    })
    @Select("SELECT f.faq_num, f.title, f.content, f.created_at, f.updated_at, " +
            "f.created_by, f.status, f.view_count, u.username as created_by_name " +
            "FROM hk_faq f " +
            "JOIN hk_users u ON f.created_by = u.user_num " +
            "WHERE f.status = 'ACTIVE' " +
            "ORDER BY f.created_at DESC " +
            "OFFSET #{offset} ROWS FETCH NEXT #{pageSize} ROWS ONLY")
    List<FAQVO> selectFAQListPaging(SupportSearchVO searchVO);
    
    // FAQ 검색 목록 조회
    @Results({
        @Result(property = "faqNum", column = "faq_num"),
        @Result(property = "title", column = "title"),
        @Result(property = "content", column = "content"),
        @Result(property = "createdAt", column = "created_at"),
        @Result(property = "updatedAt", column = "updated_at"),
        @Result(property = "createdBy", column = "created_by"),
        @Result(property = "status", column = "status"),
        @Result(property = "viewCount", column = "view_count"),
        @Result(property = "createdByName", column = "created_by_name")
    })
    @Select("<script>" +
            "SELECT f.faq_num, f.title, f.content, f.created_at, f.updated_at, " +
            "f.created_by, f.status, f.view_count, u.username as created_by_name " +
            "FROM hk_faq f " +
            "JOIN hk_users u ON f.created_by = u.user_num " +
            "WHERE f.status = 'ACTIVE' " +
            "<if test='searchKeyword != null and searchKeyword != \"\"'>" +
            "AND (" +
            "<choose>" +
            "<when test='searchType == \"title\"'>f.title LIKE '%'||#{searchKeyword}||'%'</when>" +
            "<when test='searchType == \"content\"'>f.content LIKE '%'||#{searchKeyword}||'%'</when>" +
            "<otherwise>(f.title LIKE '%'||#{searchKeyword}||'%' OR f.content LIKE '%'||#{searchKeyword}||'%')</otherwise>" +
            "</choose>" +
            ")" +
            "</if>" +
            "ORDER BY f.created_at DESC " +
            "OFFSET #{offset} ROWS FETCH NEXT #{pageSize} ROWS ONLY" +
            "</script>")
    List<FAQVO> selectFAQSearchList(SupportSearchVO searchVO);
    
    // FAQ 총 개수 조회
    @Select("SELECT COUNT(*) FROM hk_faq WHERE status = 'ACTIVE'")
    int selectFAQTotalCount();
    
    // FAQ 검색 총 개수 조회
    @Select("<script>" +
            "SELECT COUNT(*) FROM hk_faq f " +
            "WHERE f.status = 'ACTIVE' " +
            "<if test='searchKeyword != null and searchKeyword != \"\"'>" +
            "AND (" +
            "<choose>" +
            "<when test='searchType == \"title\"'>f.title LIKE '%'||#{searchKeyword}||'%'</when>" +
            "<when test='searchType == \"content\"'>f.content LIKE '%'||#{searchKeyword}||'%'</when>" +
            "<otherwise>(f.title LIKE '%'||#{searchKeyword}||'%' OR f.content LIKE '%'||#{searchKeyword}||'%')</otherwise>" +
            "</choose>" +
            ")" +
            "</if>" +
            "</script>")
    int selectFAQSearchTotalCount(SupportSearchVO searchVO);
    
    // FAQ 상세 조회
    @Results({
        @Result(property = "faqNum", column = "faq_num"),
        @Result(property = "title", column = "title"),
        @Result(property = "content", column = "content"),
        @Result(property = "createdAt", column = "created_at"),
        @Result(property = "updatedAt", column = "updated_at"),
        @Result(property = "createdBy", column = "created_by"),
        @Result(property = "status", column = "status"),
        @Result(property = "viewCount", column = "view_count"),
        @Result(property = "createdByName", column = "created_by_name")
    })
    @Select("SELECT f.faq_num, f.title, f.content, f.created_at, f.updated_at, " +
            "f.created_by, f.status, f.view_count, u.username as created_by_name " +
            "FROM hk_faq f " +
            "JOIN hk_users u ON f.created_by = u.user_num " +
            "WHERE f.faq_num = #{faqNum}")
    FAQVO selectFAQByNum(Long faqNum);
    
    // FAQ 등록
    @Insert("INSERT INTO hk_faq (title, content, created_by) " +
            "VALUES (#{title}, #{content}, #{createdBy})")
    @Options(useGeneratedKeys = true, keyProperty = "faqNum", keyColumn = "faq_num")
    int insertFAQ(FAQVO faq);
    
    // FAQ 수정
    @Update("UPDATE hk_faq SET title = #{title}, content = #{content}, " +
            "updated_at = CURRENT_TIMESTAMP " +
            "WHERE faq_num = #{faqNum}")
    int updateFAQ(FAQVO faq);
    
    // FAQ 삭제 (상태 변경)
    @Update("UPDATE hk_faq SET status = 'DELETED' WHERE faq_num = #{faqNum}")
    int deleteFAQ(Long faqNum);
    
    // FAQ 조회수 증가
    @Update("UPDATE hk_faq SET view_count = view_count + 1 WHERE faq_num = #{faqNum}")
    int updateFAQViewCount(Long faqNum);
}