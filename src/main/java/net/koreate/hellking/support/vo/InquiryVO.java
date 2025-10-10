package net.koreate.hellking.support.vo;

import lombok.Data;
import java.util.Date;
import java.util.List;
import com.fasterxml.jackson.annotation.JsonIgnore;
import org.springframework.web.multipart.MultipartFile;

/**
 * 수정된 InquiryVO - 파일 업로드 바인딩 오류 해결
 */
@Data
public class InquiryVO {
    private Long inquiryNum;
    private Long parentNum;
    private String title;
    private String content;
    private Date createdAt;
    private Date updatedAt;
    private Long createdBy;
    private String status;
    private String isPrivate;
    private String hasAttachment;
    private Long viewCount;
    
    // 조인용 필드
    private String createdByName; // 작성자 이름
    private String createdById;   // 작성자 ID
    
    // 관계형 필드 - 조회용만, 파일 업로드와 분리
    @JsonIgnore // JSON 직렬화 시 제외
    private List<InquiryVO> replies; // 답글 목록
    
    @JsonIgnore // JSON 직렬화 시 제외
    private List<InquiryAttachmentVO> attachments; // 첨부파일 목록 (조회용)
    
    // 유틸리티 메서드
    public boolean isReply() {
        return this.parentNum != null;
    }
    
    public boolean isOriginalPost() {
        return this.parentNum == null;
    }
    
    public boolean isActive() {
        return "ACTIVE".equals(this.status);
    }
    
    public boolean isCompleted() {
        return "COMPLETED".equals(this.status);
    }
    
    public boolean hasAttachments() {
        return "Y".equals(this.hasAttachment);
    }
    
    public boolean isPrivateInquiry() {
        return "Y".equals(this.isPrivate);
    }
    
    public String getShortContent() {
        if (content != null && content.length() > 150) {
            return content.substring(0, 150) + "...";
        }
        return content;
    }
    
    public String getStatusDisplayName() {
        if (status == null) return "대기중";
        
        switch (status) {
            case "ACTIVE": 
                return replies != null && !replies.isEmpty() ? "답변완료" : "대기중";
            case "COMPLETED": 
                return "해결완료";
            case "DELETED": 
                return "삭제됨";
            default: 
                return status;
        }
    }
}