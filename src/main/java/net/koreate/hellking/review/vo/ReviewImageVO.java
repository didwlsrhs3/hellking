package net.koreate.hellking.review.vo;

import lombok.Data;
import java.sql.Timestamp;

@Data
public class ReviewImageVO {
    private Long imageNum;
    private Long reviewNum;
    private String imagePath;
    private String originalName;
    private Integer imageOrder;
    private Long imageSize;
    private Timestamp createdAt;
    
    // 썸네일 경로 생성
    public String getThumbnailPath() {
        if (imagePath == null) return null;
        
        int lastSlash = imagePath.lastIndexOf('/');
        if (lastSlash >= 0) {
            String directory = imagePath.substring(0, lastSlash + 1);
            String filename = imagePath.substring(lastSlash + 1);
            return directory + "s_" + filename;
        }
        return "s_" + imagePath;
    }
    
    // 파일 확장자 가져오기
    public String getFileExtension() {
        if (originalName == null) return "";
        
        int dotIndex = originalName.lastIndexOf('.');
        return dotIndex > 0 ? originalName.substring(dotIndex + 1).toLowerCase() : "";
    }
    
    // 이미지 파일 여부 확인
    public boolean isImageFile() {
        String ext = getFileExtension();
        return ext.equals("jpg") || ext.equals("jpeg") || ext.equals("png") || ext.equals("gif");
    }
    
    // 파일 크기 포맷팅
    public String getFormattedSize() {
        if (imageSize == null || imageSize == 0) return "0 KB";
        
        if (imageSize < 1024) return imageSize + " B";
        if (imageSize < 1024 * 1024) return String.format("%.1f KB", imageSize / 1024.0);
        return String.format("%.1f MB", imageSize / (1024.0 * 1024.0));
    }
    
    // 표시용 파일명 (길이 제한)
    public String getDisplayName() {
        if (originalName == null) return "";
        
        if (originalName.length() > 30) {
            String ext = getFileExtension();
            String nameWithoutExt = originalName.substring(0, originalName.lastIndexOf('.'));
            return nameWithoutExt.substring(0, 25) + "..." + (ext.isEmpty() ? "" : "." + ext);
        }
        return originalName;
    }
}