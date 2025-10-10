package net.koreate.hellking.support.vo;

import lombok.Data;
import java.util.Date;

@Data
public class InquiryAttachmentVO {
    private Long attachmentNum;
    private Long inquiryNum;
    private String originalFilename;
    private String savedFilename;
    private Long fileSize;
    private String filePath;
    private Date uploadDate;
    
    // 유틸리티 메서드
    public String getFileSizeDisplay() {
        if (fileSize == null) return "0 KB";
        
        if (fileSize < 1024) {
            return fileSize + " B";
        } else if (fileSize < 1024 * 1024) {
            return String.format("%.1f KB", fileSize / 1024.0);
        } else {
            return String.format("%.1f MB", fileSize / (1024.0 * 1024.0));
        }
    }
    
    public String getFileExtension() {
        if (originalFilename != null && originalFilename.contains(".")) {
            return originalFilename.substring(originalFilename.lastIndexOf(".") + 1).toLowerCase();
        }
        return "";
    }
    
    public boolean isImageFile() {
        String ext = getFileExtension();
        return "jpg".equals(ext) || "jpeg".equals(ext) || "png".equals(ext) || "gif".equals(ext);
    }
}