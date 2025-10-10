package net.koreate.hellking.user.service;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import javax.servlet.ServletContext;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.URL;
import java.net.URLConnection;
import java.util.UUID;

/**
 * 소셜 로그인에서 받은 프로필 이미지를 다운로드하고 저장하는 서비스
 */
@Service
@Slf4j
@RequiredArgsConstructor
public class ProfileImageService {
    
    private final ServletContext servletContext;
    private final RestTemplate restTemplate;
    
    @Value("${upload.path:upload}")
    private String uploadPath;
    
    @Value("${profile.image.max.size:5242880}") // 5MB
    private long maxFileSize;
    
    @Value("${profile.image.allowed.types:jpg,jpeg,png,gif,webp}")
    private String allowedTypes;
    
    /**
     * 소셜 프로필 이미지 URL에서 이미지를 다운로드하고 저장
     * 
     * @param imageUrl 소셜에서 받은 프로필 이미지 URL
     * @param userId 사용자 ID (파일명에 사용)
     * @param provider 소셜 제공자 (naver, kakao, google)
     * @return 저장된 파일명 (실패시 null)
     */
    public String downloadAndSaveSocialProfileImage(String imageUrl, String userId, String provider) {
        if (imageUrl == null || imageUrl.trim().isEmpty()) {
            log.debug("프로필 이미지 URL이 없음: userId={}", userId);
            return null;
        }
        
        try {
            // URL 유효성 검증
            if (!isValidImageUrl(imageUrl)) {
                log.warn("유효하지 않은 이미지 URL: {}", imageUrl);
                return null;
            }
            
            // 파일 확장자 추출
            String extension = extractExtension(imageUrl);
            if (!isAllowedExtension(extension)) {
                log.warn("지원하지 않는 이미지 형식: {}", extension);
                return null;
            }
            
            // 저장 경로 설정
            String realPath = servletContext.getRealPath(File.separator + uploadPath + File.separator + "profiles");
            File uploadDir = new File(realPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdirs();
            }
            
            // 파일명 생성: social_{provider}_{userId}_{timestamp}.{extension}
            String fileName = String.format("social_%s_%s_%d.%s", 
                provider.toLowerCase(), 
                userId, 
                System.currentTimeMillis(), 
                extension);
            
            File destFile = new File(uploadDir, fileName);
            
            // 이미지 다운로드 및 저장
            boolean downloaded = downloadImage(imageUrl, destFile);
            
            if (downloaded) {
                log.info("소셜 프로필 이미지 다운로드 성공: userId={}, fileName={}", userId, fileName);
                return fileName;
            } else {
                log.warn("소셜 프로필 이미지 다운로드 실패: userId={}, url={}", userId, imageUrl);
                return null;
            }
            
        } catch (Exception e) {
            log.error("소셜 프로필 이미지 다운로드 중 오류: userId={}, url={}", userId, imageUrl, e);
            return null;
        }
    }
    
    /**
     * 이미지 URL 유효성 검증
     */
    private boolean isValidImageUrl(String imageUrl) {
        if (imageUrl == null || imageUrl.trim().isEmpty()) {
            return false;
        }
        
        // HTTPS 또는 HTTP만 허용
        if (!imageUrl.startsWith("http://") && !imageUrl.startsWith("https://")) {
            return false;
        }
        
        // 일반적인 이미지 확장자 확인
        String lowerUrl = imageUrl.toLowerCase();
        return lowerUrl.contains(".jpg") || lowerUrl.contains(".jpeg") || 
               lowerUrl.contains(".png") || lowerUrl.contains(".gif") ||
               lowerUrl.contains(".webp") || 
               // 쿼리 파라미터가 있는 경우도 고려
               lowerUrl.contains("image") || lowerUrl.contains("photo") ||
               lowerUrl.contains("avatar") || lowerUrl.contains("profile");
    }
    
    /**
     * URL에서 파일 확장자 추출
     */
    private String extractExtension(String imageUrl) {
        try {
            // 쿼리 파라미터 제거
            String url = imageUrl.split("\\?")[0];
            
            // 확장자 추출
            int lastDot = url.lastIndexOf('.');
            if (lastDot > 0 && lastDot < url.length() - 1) {
                return url.substring(lastDot + 1).toLowerCase();
            }
            
            // 확장자가 명확하지 않으면 jpg로 기본 설정
            return "jpg";
            
        } catch (Exception e) {
            log.warn("확장자 추출 실패, 기본값 사용: {}", imageUrl);
            return "jpg";
        }
    }
    
    /**
     * 허용된 확장자인지 확인
     */
    private boolean isAllowedExtension(String extension) {
        if (extension == null) return false;
        String[] allowed = allowedTypes.split(",");
        for (String allowedType : allowed) {
            if (allowedType.trim().equalsIgnoreCase(extension)) {
                return true;
            }
        }
        return false;
    }
    
    /**
     * 이미지 다운로드 및 저장 실행
     */
    private boolean downloadImage(String imageUrl, File destFile) {
        try {
            URL url = new URL(imageUrl);
            URLConnection connection = url.openConnection();
            
            // User-Agent 설정 (일부 서버에서 요구)
            connection.setRequestProperty("User-Agent", 
                "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36");
            
            // 타임아웃 설정
            connection.setConnectTimeout(10000); // 10초
            connection.setReadTimeout(30000);    // 30초
            
            // Content-Length 확인 (파일 크기 제한)
            long contentLength = connection.getContentLengthLong();
            if (contentLength > maxFileSize) {
                log.warn("이미지 파일 크기가 너무 큼: {} bytes (최대: {} bytes)", contentLength, maxFileSize);
                return false;
            }
            
            // 파일 다운로드
            try (InputStream in = connection.getInputStream();
                 FileOutputStream out = new FileOutputStream(destFile)) {
                
                byte[] buffer = new byte[8192];
                int bytesRead;
                long totalBytesRead = 0;
                
                while ((bytesRead = in.read(buffer)) != -1) {
                    totalBytesRead += bytesRead;
                    
                    // 다운로드 중 파일 크기 재확인
                    if (totalBytesRead > maxFileSize) {
                        log.warn("다운로드 중 파일 크기 초과: {} bytes", totalBytesRead);
                        destFile.delete(); // 부분 다운로드된 파일 삭제
                        return false;
                    }
                    
                    out.write(buffer, 0, bytesRead);
                }
                
                log.debug("이미지 다운로드 완료: {} bytes", totalBytesRead);
                return true;
            }
            
        } catch (IOException e) {
            log.error("이미지 다운로드 중 IO 오류: {}", imageUrl, e);
            // 실패한 파일 삭제
            if (destFile.exists()) {
                destFile.delete();
            }
            return false;
        } catch (Exception e) {
            log.error("이미지 다운로드 중 예상치 못한 오류: {}", imageUrl, e);
            if (destFile.exists()) {
                destFile.delete();
            }
            return false;
        }
    }
    
    /**
     * 기존 소셜 프로필 이미지 삭제
     */
    public void deleteSocialProfileImage(String fileName) {
        if (fileName == null || !fileName.startsWith("social_")) {
            return;
        }
        
        try {
            String realPath = servletContext.getRealPath(File.separator + uploadPath + File.separator + "profiles");
            File file = new File(realPath, fileName);
            
            if (file.exists() && file.delete()) {
                log.info("소셜 프로필 이미지 삭제 완료: {}", fileName);
            }
            
        } catch (Exception e) {
            log.warn("소셜 프로필 이미지 삭제 실패: {}", fileName, e);
        }
    }
}