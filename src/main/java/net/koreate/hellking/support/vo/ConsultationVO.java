package net.koreate.hellking.support.vo;

import java.sql.Timestamp;
import java.util.Date;

import lombok.Data;


import org.springframework.format.annotation.DateTimeFormat;


/**
 * 상담예약 VO
 */
@Data
public class ConsultationVO {
	
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date consultationDate;
    
    @DateTimeFormat(pattern = "HH:mm")
    private String consultationTime;  // 또는 Time 타입이면 해당 패턴
    
    private Long consultationNum;        // 상담예약번호 (PK)
    private Long userNum;                // 사용자번호 (FK)
    private String name;                 // 예약자명
    private String phone;                // 연락처
    private String email;                // 이메일
    private String content;              // 상담내용
    private String status;               // 상태 (CONFIRMED, CANCELLED)
    private Timestamp createdAt;         // 생성일시
    private Timestamp updatedAt;         // 수정일시
    
    // 추가 필드 (조회용)
    private String userName;             // 사용자명 (JOIN)
    private String userId;               // 사용자ID (JOIN)
    private boolean canCancel;           // 취소 가능 여부
    private String statusText;           // 상태 텍스트
    private String formattedDate;        // 포맷된 날짜
    private String formattedTime;        // 포맷된 시간
    
    /**
     * 상태 텍스트 반환
     */
    public String getStatusText() {
        if ("CONFIRMED".equals(this.status)) {
            return "예약확정";
        } else if ("CANCELLED".equals(this.status)) {
            return "예약취소";
        }
        return "알 수 없음";
    }
    
    /**
     * 취소 가능 여부 확인
     * 예약 당일 1시간 전까지 취소 가능
     */
    public boolean getCanCancel() {
        if (!"CONFIRMED".equals(this.status)) {
            return false;
        }
        
        try {
            // 현재 시간
            long currentTime = System.currentTimeMillis();
            
            // 예약 시간 계산 (예약날짜 + 예약시간)
            long consultationDateTime = this.consultationDate.getTime();
            
            // 시간 파싱 (HH:mm)
            if (this.consultationTime != null && this.consultationTime.length() == 5) {
                String[] timeParts = this.consultationTime.split(":");
                int hour = Integer.parseInt(timeParts[0]);
                int minute = Integer.parseInt(timeParts[1]);
                
                consultationDateTime += (hour * 60 * 60 * 1000) + (minute * 60 * 1000);
            }
            
            // 1시간 전까지 취소 가능
            return (consultationDateTime - currentTime) > (60 * 60 * 1000);
            
        } catch (Exception e) {
            return false;
        }
    }
    
    /**
     * 취소 가능 여부 확인 (boolean 타입)
     */
    public boolean isCanCancel() {
        return getCanCancel();
    }
}