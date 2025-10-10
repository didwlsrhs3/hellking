package net.koreate.hellking.support.dao;

import org.apache.ibatis.annotations.*;
import net.koreate.hellking.support.vo.InquiryVO;
import net.koreate.hellking.support.vo.SupportSearchVO;
import java.util.List;

@Mapper
public interface InquiryDAO {
    
    // 문의사항 목록 조회 (원글만, 페이징)
    @Results({
        @Result(property = "inquiryNum", column = "inquiry_num"),
        @Result(property = "parentNum", column = "parent_num"),
        @Result(property = "title", column = "title"),
        @Result(property = "content", column = "content"),
        @Result(property = "createdAt", column = "created_at"),
        @Result(property = "updatedAt", column = "updated_at"),
        @Result(property = "createdBy", column = "created_by"),
        @Result(property = "status", column = "status"),
        @Result(property = "isPrivate", column = "is_private"),
        @Result(property = "hasAttachment", column = "has_attachment"),
        @Result(property = "viewCount", column = "view_count"),
        @Result(property = "createdByName", column = "created_by_name"),
        @Result(property = "createdById", column = "created_by_id")
    })
    @Select("SELECT i.inquiry_num, i.parent_num, i.title, i.content, i.created_at, i.updated_at, " +
            "i.created_by, i.status, i.is_private, i.has_attachment, i.view_count, " +
            "u.username as created_by_name, u.user_id as created_by_id " +
            "FROM hk_inquiry i " +
            "JOIN hk_users u ON i.created_by = u.user_num " +
            "WHERE i.parent_num IS NULL AND i.status != 'DELETED' " +
            "ORDER BY i.created_at DESC " +
            "OFFSET #{offset} ROWS FETCH NEXT #{pageSize} ROWS ONLY")
    List<InquiryVO> selectInquiryListPaging(SupportSearchVO searchVO);
    
    // 문의사항 검색 목록 조회
    @Results({
        @Result(property = "inquiryNum", column = "inquiry_num"),
        @Result(property = "parentNum", column = "parent_num"),
        @Result(property = "title", column = "title"),
        @Result(property = "content", column = "content"),
        @Result(property = "createdAt", column = "created_at"),
        @Result(property = "updatedAt", column = "updated_at"),
        @Result(property = "createdBy", column = "created_by"),
        @Result(property = "status", column = "status"),
        @Result(property = "isPrivate", column = "is_private"),
        @Result(property = "hasAttachment", column = "has_attachment"),
        @Result(property = "viewCount", column = "view_count"),
        @Result(property = "createdByName", column = "created_by_name"),
        @Result(property = "createdById", column = "created_by_id")
    })
    @Select("<script>" +
            "SELECT i.inquiry_num, i.parent_num, i.title, i.content, i.created_at, i.updated_at, " +
            "i.created_by, i.status, i.is_private, i.has_attachment, i.view_count, " +
            "u.username as created_by_name, u.user_id as created_by_id " +
            "FROM hk_inquiry i " +
            "JOIN hk_users u ON i.created_by = u.user_num " +
            "WHERE i.parent_num IS NULL AND i.status != 'DELETED' " +
            "<if test='searchKeyword != null and searchKeyword != \"\"'>" +
            "AND (" +
            "<choose>" +
            "<when test='searchType == \"title\"'>i.title LIKE '%'||#{searchKeyword}||'%'</when>" +
            "<when test='searchType == \"content\"'>i.content LIKE '%'||#{searchKeyword}||'%'</when>" +
            "<when test='searchType == \"author\"'>u.username LIKE '%'||#{searchKeyword}||'%'</when>" +
            "<otherwise>(i.title LIKE '%'||#{searchKeyword}||'%' OR i.content LIKE '%'||#{searchKeyword}||'%' OR u.username LIKE '%'||#{searchKeyword}||'%')</otherwise>" +
            "</choose>" +
            ")" +
            "</if>" +
            "<if test='status != null and status != \"\"'>" +
            "AND i.status = #{status}" +
            "</if>" +
            "ORDER BY i.created_at DESC " +
            "OFFSET #{offset} ROWS FETCH NEXT #{pageSize} ROWS ONLY" +
            "</script>")
    List<InquiryVO> selectInquirySearchList(SupportSearchVO searchVO);
    
    // 문의사항 총 개수 조회
    @Select("SELECT COUNT(*) FROM hk_inquiry WHERE parent_num IS NULL AND status != 'DELETED'")
    int selectInquiryTotalCount();
    
    // 문의사항 검색 총 개수 조회
    @Select("<script>" +
            "SELECT COUNT(*) FROM hk_inquiry i " +
            "JOIN hk_users u ON i.created_by = u.user_num " +
            "WHERE i.parent_num IS NULL AND i.status != 'DELETED' " +
            "<if test='searchKeyword != null and searchKeyword != \"\"'>" +
            "AND (" +
            "<choose>" +
            "<when test='searchType == \"title\"'>i.title LIKE '%'||#{searchKeyword}||'%'</when>" +
            "<when test='searchType == \"content\"'>i.content LIKE '%'||#{searchKeyword}||'%'</when>" +
            "<when test='searchType == \"author\"'>u.username LIKE '%'||#{searchKeyword}||'%'</when>" +
            "<otherwise>(i.title LIKE '%'||#{searchKeyword}||'%' OR i.content LIKE '%'||#{searchKeyword}||'%' OR u.username LIKE '%'||#{searchKeyword}||'%')</otherwise>" +
            "</choose>" +
            ")" +
            "</if>" +
            "<if test='status != null and status != \"\"'>" +
            "AND i.status = #{status}" +
            "</if>" +
            "</script>")
    int selectInquirySearchTotalCount(SupportSearchVO searchVO);
    
    // 문의사항 상세 조회
    @Results({
        @Result(property = "inquiryNum", column = "inquiry_num"),
        @Result(property = "parentNum", column = "parent_num"),
        @Result(property = "title", column = "title"),
        @Result(property = "content", column = "content"),
        @Result(property = "createdAt", column = "created_at"),
        @Result(property = "updatedAt", column = "updated_at"),
        @Result(property = "createdBy", column = "created_by"),
        @Result(property = "status", column = "status"),
        @Result(property = "isPrivate", column = "is_private"),
        @Result(property = "hasAttachment", column = "has_attachment"),
        @Result(property = "viewCount", column = "view_count"),
        @Result(property = "createdByName", column = "created_by_name"),
        @Result(property = "createdById", column = "created_by_id")
    })
    @Select("SELECT i.inquiry_num, i.parent_num, i.title, i.content, i.created_at, i.updated_at, " +
            "i.created_by, i.status, i.is_private, i.has_attachment, i.view_count, " +
            "u.username as created_by_name, u.user_id as created_by_id " +
            "FROM hk_inquiry i " +
            "JOIN hk_users u ON i.created_by = u.user_num " +
            "WHERE i.inquiry_num = #{inquiryNum}")
    InquiryVO selectInquiryByNum(Long inquiryNum);
    
    // 문의사항 답글 조회
    @Results({
        @Result(property = "inquiryNum", column = "inquiry_num"),
        @Result(property = "parentNum", column = "parent_num"),
        @Result(property = "title", column = "title"),
        @Result(property = "content", column = "content"),
        @Result(property = "createdAt", column = "created_at"),
        @Result(property = "updatedAt", column = "updated_at"),
        @Result(property = "createdBy", column = "created_by"),
        @Result(property = "status", column = "status"),
        @Result(property = "isPrivate", column = "is_private"),
        @Result(property = "hasAttachment", column = "has_attachment"),
        @Result(property = "viewCount", column = "view_count"),
        @Result(property = "createdByName", column = "created_by_name"),
        @Result(property = "createdById", column = "created_by_id")
    })
    @Select("SELECT i.inquiry_num, i.parent_num, i.title, i.content, i.created_at, i.updated_at, " +
            "i.created_by, i.status, i.is_private, i.has_attachment, i.view_count, " +
            "u.username as created_by_name, u.user_id as created_by_id " +
            "FROM hk_inquiry i " +
            "JOIN hk_users u ON i.created_by = u.user_num " +
            "WHERE i.parent_num = #{parentNum} AND i.status != 'DELETED' " +
            "ORDER BY i.created_at ASC")
    List<InquiryVO> selectInquiryReplies(Long parentNum);
    
    // 문의사항 등록
    @Insert("INSERT INTO hk_inquiry (parent_num, title, content, created_by, is_private, has_attachment) " +
            "VALUES (#{parentNum, jdbcType=NUMERIC}, #{title}, #{content}, #{createdBy}, #{isPrivate, jdbcType=CHAR}, #{hasAttachment, jdbcType=CHAR})")
    @Options(useGeneratedKeys = true, keyProperty = "inquiryNum", keyColumn = "inquiry_num")
    int insertInquiry(InquiryVO inquiry);
    
    // 문의사항 수정
    @Update("UPDATE hk_inquiry SET title = #{title}, content = #{content}, " +
            "updated_at = CURRENT_TIMESTAMP " +
            "WHERE inquiry_num = #{inquiryNum}")
    int updateInquiry(InquiryVO inquiry);
    
    // 문의사항 삭제 (상태 변경)
    @Update("UPDATE hk_inquiry SET status = 'DELETED' WHERE inquiry_num = #{inquiryNum}")
    int deleteInquiry(Long inquiryNum);
    
    // 문의사항 조회수 증가
    @Update("UPDATE hk_inquiry SET view_count = view_count + 1 WHERE inquiry_num = #{inquiryNum}")
    int updateInquiryViewCount(Long inquiryNum);
    
    // 첨부파일 여부 업데이트
    @Update("UPDATE hk_inquiry SET has_attachment = #{hasAttachment} WHERE inquiry_num = #{inquiryNum}")
    int updateInquiryAttachmentFlag(@Param("inquiryNum") Long inquiryNum, @Param("hasAttachment") String hasAttachment);
    
    // 내 문의사항 목록 조회
    @Results({
        @Result(property = "inquiryNum", column = "inquiry_num"),
        @Result(property = "parentNum", column = "parent_num"),
        @Result(property = "title", column = "title"),
        @Result(property = "content", column = "content"),
        @Result(property = "createdAt", column = "created_at"),
        @Result(property = "updatedAt", column = "updated_at"),
        @Result(property = "createdBy", column = "created_by"),
        @Result(property = "status", column = "status"),
        @Result(property = "isPrivate", column = "is_private"),
        @Result(property = "hasAttachment", column = "has_attachment"),
        @Result(property = "viewCount", column = "view_count"),
        @Result(property = "createdByName", column = "created_by_name"),
        @Result(property = "createdById", column = "created_by_id")
    })
    @Select("SELECT i.inquiry_num, i.parent_num, i.title, i.content, i.created_at, i.updated_at, " +
            "i.created_by, i.status, i.is_private, i.has_attachment, i.view_count, " +
            "u.username as created_by_name, u.user_id as created_by_id " +
            "FROM hk_inquiry i " +
            "JOIN hk_users u ON i.created_by = u.user_num " +
            "WHERE i.created_by = #{userNum} AND i.parent_num IS NULL AND i.status != 'DELETED' " +
            "ORDER BY i.created_at DESC " +
            "OFFSET #{offset} ROWS FETCH NEXT #{pageSize} ROWS ONLY")
    List<InquiryVO> selectMyInquiryList(@Param("userNum") Long userNum, @Param("offset") int offset, @Param("pageSize") int pageSize);
    
    // 내 문의사항 총 개수
    @Select("SELECT COUNT(*) FROM hk_inquiry WHERE created_by = #{userNum} AND parent_num IS NULL AND status != 'DELETED'")
    int selectMyInquiryTotalCount(Long userNum);
}