package net.koreate.hellking.support.dao;

import org.apache.ibatis.annotations.*;
import net.koreate.hellking.support.vo.InquiryAttachmentVO;
import java.util.List;

@Mapper
public interface InquiryAttachmentDAO {
    
    // 첨부파일 목록 조회
    @Results({
        @Result(property = "attachmentNum", column = "attachment_num"),
        @Result(property = "inquiryNum", column = "inquiry_num"),
        @Result(property = "originalFilename", column = "original_filename"),
        @Result(property = "savedFilename", column = "saved_filename"),
        @Result(property = "fileSize", column = "file_size"),
        @Result(property = "filePath", column = "file_path"),
        @Result(property = "uploadDate", column = "upload_date")
    })
    @Select("SELECT attachment_num, inquiry_num, original_filename, saved_filename, " +
            "file_size, file_path, upload_date " +
            "FROM hk_inquiry_attachment " +
            "WHERE inquiry_num = #{inquiryNum} " +
            "ORDER BY upload_date ASC")
    List<InquiryAttachmentVO> selectAttachmentsByInquiryNum(Long inquiryNum);
    
    // 첨부파일 상세 조회
    @Results({
        @Result(property = "attachmentNum", column = "attachment_num"),
        @Result(property = "inquiryNum", column = "inquiry_num"),
        @Result(property = "originalFilename", column = "original_filename"),
        @Result(property = "savedFilename", column = "saved_filename"),
        @Result(property = "fileSize", column = "file_size"),
        @Result(property = "filePath", column = "file_path"),
        @Result(property = "uploadDate", column = "upload_date")
    })
    @Select("SELECT attachment_num, inquiry_num, original_filename, saved_filename, " +
            "file_size, file_path, upload_date " +
            "FROM hk_inquiry_attachment " +
            "WHERE attachment_num = #{attachmentNum}")
    InquiryAttachmentVO selectAttachmentByNum(Long attachmentNum);
    
    // 첨부파일 등록
    @Insert("INSERT INTO hk_inquiry_attachment (inquiry_num, original_filename, saved_filename, file_size, file_path) " +
            "VALUES (#{inquiryNum}, #{originalFilename}, #{savedFilename}, #{fileSize}, #{filePath})")
    @Options(useGeneratedKeys = true, keyProperty = "attachmentNum", keyColumn = "attachment_num")
    int insertAttachment(InquiryAttachmentVO attachment);
    
    // 첨부파일 삭제
    @Delete("DELETE FROM hk_inquiry_attachment WHERE attachment_num = #{attachmentNum}")
    int deleteAttachment(Long attachmentNum);
    
    // 문의사항별 첨부파일 일괄 삭제
    @Delete("DELETE FROM hk_inquiry_attachment WHERE inquiry_num = #{inquiryNum}")
    int deleteAttachmentsByInquiryNum(Long inquiryNum);
    
    // 첨부파일 개수 조회
    @Select("SELECT COUNT(*) FROM hk_inquiry_attachment WHERE inquiry_num = #{inquiryNum}")
    int countAttachmentsByInquiryNum(Long inquiryNum);
}