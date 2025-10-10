package net.koreate.hellking.common.service;

import org.springframework.stereotype.Service;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.Date;

@Service
public class SecurityService {
    
    /**
     * 관리자 권한 확인 및 로그 기록
     */
    public boolean checkAdminAccessWithLog(HttpSession session, HttpServletRequest request, 
                                         String action, String target) {
        
        // 디버깅을 위한 세션 정보 출력
        System.out.println("=== SecurityService 디버깅 ===");
        System.out.println("세션 ID: " + session.getId());
        
        // 모든 세션 속성명과 값 출력
        java.util.Enumeration<String> attributeNames = session.getAttributeNames();
        while (attributeNames.hasMoreElements()) {
            String name = attributeNames.nextElement();
            Object value = session.getAttribute(name);
            System.out.println("세션속성 - " + name + ": " + value + " (타입: " + (value != null ? value.getClass().getSimpleName() : "null") + ")");
        }
        
        // userRole만 체크
        String userRole = (String) session.getAttribute("userRole");
        System.out.println("userRole: [" + userRole + "]");
        
        // ADMIN 권한 체크 (대소문자 구분 없이)
        boolean isAdmin = "ADMIN".equalsIgnoreCase(userRole);
        
        System.out.println("권한체크결과:");
        System.out.println("- userRole=='ADMIN': " + isAdmin);
        
        if (!isAdmin) {
            System.out.println("[보안경고] 권한 체크 실패 - userRole이 ADMIN이 아님");
            return false;
        }
        
        // 로그 기록
        String clientIp = getClientIpAddress(request);
        System.out.println("[관리자접근] " + userRole + " -> " + action + " -> " + target + " (IP: " + clientIp + ")");
        
        return true;
    }
    
    /**
     * 클라이언트 IP 주소 추출
     */
    public String getClientIpAddress(HttpServletRequest request) {
        String ip = request.getHeader("X-Forwarded-For");
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("Proxy-Client-IP");
        }
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("WL-Proxy-Client-IP");
        }
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getRemoteAddr();
        }
        return ip;
    }
    
    /**
     * 관리자 접근 로그 기록
     */
    private void logAdminAccess(String adminId, String action, String refundNum, String clientIp) {
        String logMessage = String.format(
            "[관리자접근] %s | 관리자: %s | 작업: %s | 대상: %s | IP: %s",
            new Date().toString(), adminId, action, refundNum, clientIp
        );
        
        System.out.println(logMessage);
        
        // 실제 운영환경에서는 별도 보안 로그 테이블에 저장
        // 예: INSERT INTO hk_admin_logs (admin_id, action, target_id, client_ip, access_time)
    }
    
    /**
     * 민감정보 접근 로그 (계좌 정보 조회시)
     */
    public void logSensitiveDataAccess(String adminId, String action, Long refundNum, 
                                     String clientIp, String dataType) {
        String logMessage = String.format(
            "[민감정보접근] %s | 관리자: %s | 작업: %s | 환불번호: %d | 정보유형: %s | IP: %s",
            new Date().toString(), adminId, action, refundNum, dataType, clientIp
        );
        
        System.out.println(logMessage);
        System.out.println("[보안알림] 계좌 정보 접근이 기록되었습니다.");
        
        // 실제로는 별도 민감정보 접근 로그 테이블에 저장
    }
    
    /**
     * 환불 완료 후 개인정보 삭제 예약
     */
    public void schedulePersonalDataDeletion(Long refundNum) {
        System.out.println("[개인정보보호] 환불번호 " + refundNum + " 계좌정보 삭제 예약됨 (30일 후)");
        
        // 실제로는 스케줄러나 배치 작업으로 처리
        // 예: INSERT INTO hk_data_deletion_schedule (refund_num, scheduled_date, data_type)
    }
}