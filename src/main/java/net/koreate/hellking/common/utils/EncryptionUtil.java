package net.koreate.hellking.common.utils;

import javax.crypto.Cipher;
import javax.crypto.spec.SecretKeySpec;
import java.util.Base64;
import java.util.Date;

public class EncryptionUtil {
    
    // 암호화 키 (실제 운영에서는 설정파일이나 환경변수로 관리)
    private static final String SECRET_KEY = "MySecretKey12345"; // 16자리
    private static final String ALGORITHM = "AES";
    
    /**
     * 문자열 암호화
     */
    public static String encrypt(String plainText) {
        try {
            if (plainText == null || plainText.trim().isEmpty()) {
                return "";
            }
            
            SecretKeySpec secretKey = new SecretKeySpec(SECRET_KEY.getBytes(), ALGORITHM);
            Cipher cipher = Cipher.getInstance(ALGORITHM);
            cipher.init(Cipher.ENCRYPT_MODE, secretKey);
            
            byte[] encryptedBytes = cipher.doFinal(plainText.getBytes());
            return Base64.getEncoder().encodeToString(encryptedBytes);
            
        } catch (Exception e) {
            System.err.println("[보안오류] 암호화 실패: " + e.getMessage());
            e.printStackTrace();
            return plainText; // 암호화 실패시 원문 반환 (임시)
        }
    }
    
    /**
     * 문자열 복호화
     */
    public static String decrypt(String encryptedText) {
        try {
            if (encryptedText == null || encryptedText.trim().isEmpty()) {
                return "";
            }
            
            SecretKeySpec secretKey = new SecretKeySpec(SECRET_KEY.getBytes(), ALGORITHM);
            Cipher cipher = Cipher.getInstance(ALGORITHM);
            cipher.init(Cipher.DECRYPT_MODE, secretKey);
            
            byte[] decodedBytes = Base64.getDecoder().decode(encryptedText);
            byte[] decryptedBytes = cipher.doFinal(decodedBytes);
            
            return new String(decryptedBytes);
            
        } catch (Exception e) {
            System.err.println("[보안오류] 복호화 실패: " + e.getMessage());
            e.printStackTrace();
            return ""; // 복호화 실패시 빈 문자열 반환
        }
    }
    
    /**
     * 계좌번호 마스킹 (화면 표시용)
     */
    public static String maskAccountNumber(String accountNumber) {
        if (accountNumber == null || accountNumber.length() < 4) {
            return "****";
        }
        
        String prefix = accountNumber.substring(0, 4);
        String suffix = accountNumber.substring(accountNumber.length() - 2);
        String middle = "*".repeat(Math.max(0, accountNumber.length() - 6));
        
        return prefix + middle + suffix;
    }
    
    /**
     * 이름 마스킹 (화면 표시용)
     */
    public static String maskName(String name) {
        if (name == null || name.length() < 2) {
            return "**";
        }
        
        if (name.length() == 2) {
            return name.charAt(0) + "*";
        }
        
        String first = String.valueOf(name.charAt(0));
        String last = String.valueOf(name.charAt(name.length() - 1));
        String middle = "*".repeat(name.length() - 2);
        
        return first + middle + last;
    }
    
    /**
     * 보안 접근 로그 기록
     */
    public static void logSecurityAccess(String adminId, String action, String refundNum, String clientIp) {
        String logMessage = String.format(
            "[보안로그] %s | 관리자: %s | 작업: %s | 환불번호: %s | IP: %s",
            new Date().toString(), adminId, action, refundNum, clientIp
        );
        
        System.out.println(logMessage);
        
        // 실제 운영에서는 파일이나 DB에 로그 저장
        // logger.info(logMessage);
    }
}