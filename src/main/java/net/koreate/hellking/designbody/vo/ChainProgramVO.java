package net.koreate.hellking.designbody.vo;

import lombok.Data;
import java.util.Date;

/**
 * 체인점별 디자인바디 프로그램 VO
 * 기존 DesignBodyVO를 확장하여 체인점 정보 포함
 */
@Data
public class ChainProgramVO extends DesignBodyVO {
    
    // 체인점 정보
    private Long chainNum;
    private String chainName;
    private String chainAddress;
    private String chainPhone;
    
    // 체인점별 프로그램 운영 정보
    private String programRoom;        // 프로그램실 이름
    private String operatingDays;      // 운영요일
    private String operatingTime;      // 운영시간
    private String holidayInfo;        // 휴무일 정보
    private Integer maxCapacity;       // 최대 정원
    private Integer currentEnrollment; // 현재 등록자수
    private Long chainPrice;           // 체인점별 가격
    
    // 계산된 필드
    private Integer availableSpots;    // 남은 자리수
    private String enrollmentStatus;   // 등록 상태 (AVAILABLE, ALMOST_FULL, FULL)
    
    // 체인점 좌표 정보 (지도 표시용)
    private Double chainLatitude;
    private Double chainLongitude;
    private Double distance;           // 사용자로부터의 거리
    
    /**
     * 최종 가격 반환 (체인점 가격이 있으면 체인점 가격, 없으면 기본 가격)
     */
    public Long getFinalPrice() {
        return chainPrice != null ? chainPrice : getPrice();
    }
    
    /**
     * 최종 가격 포맷팅
     */
    public String getFormattedFinalPrice() {
        Long finalPrice = getFinalPrice();
        if (finalPrice != null && finalPrice > 0) {
            return String.format("%,d원", finalPrice);
        }
        return "무료";
    }
    
    /**
     * 남은 자리수 계산
     */
    public Integer getAvailableSpots() {
        if (maxCapacity != null && currentEnrollment != null) {
            return maxCapacity - currentEnrollment;
        }
        return 0;
    }
    
    /**
     * 등록 가능 여부
     */
    public boolean isAvailable() {
        return "AVAILABLE".equals(enrollmentStatus) || "ALMOST_FULL".equals(enrollmentStatus);
    }
    
    /**
     * 마감 임박 여부
     */
    public boolean isAlmostFull() {
        return "ALMOST_FULL".equals(enrollmentStatus);
    }
    
    /**
     * 마감 여부
     */
    public boolean isFull() {
        return "FULL".equals(enrollmentStatus);
    }
    
    /**
     * 등록률 계산 (백분율)
     */
    public int getEnrollmentRate() {
        if (maxCapacity != null && maxCapacity > 0 && currentEnrollment != null) {
            return Math.round((float) currentEnrollment / maxCapacity * 100);
        }
        return 0;
    }
    
    /**
     * 운영 요일 배열로 반환
     */
    public String[] getOperatingDaysArray() {
        if (operatingDays != null) {
            return operatingDays.split(",");
        }
        return new String[0];
    }
    
    /**
     * 운영 요일 한글 표시
     */
    public String getOperatingDaysKorean() {
        if (operatingDays == null) return "";
        
        String days = operatingDays;
        days = days.replace("MON", "월");
        days = days.replace("TUE", "화");
        days = days.replace("WED", "수");
        days = days.replace("THU", "목");
        days = days.replace("FRI", "금");
        days = days.replace("SAT", "토");
        days = days.replace("SUN", "일");
        days = days.replace(",", ", ");
        
        return days + "요일";
    }
    
    /**
     * 체인점까지의 거리 포맷팅
     */
    public String getFormattedDistance() {
        if (distance == null) return "";
        
        if (distance < 1) {
            return String.format("%.0fm", distance * 1000);
        } else {
            return String.format("%.1fkm", distance);
        }
    }
    
    /**
     * 정원 대비 현재 등록자 표시
     */
    public String getCapacityInfo() {
        if (currentEnrollment != null && maxCapacity != null) {
            return currentEnrollment + "/" + maxCapacity + "명";
        }
        return "정보없음";
    }
    
    /**
     * 등록 상태에 따른 CSS 클래스 반환
     */
    public String getStatusBadgeClass() {
        if (enrollmentStatus == null) return "bg-secondary";
        
        switch (enrollmentStatus) {
            case "AVAILABLE": return "bg-success";
            case "ALMOST_FULL": return "bg-warning";
            case "FULL": return "bg-danger";
            default: return "bg-secondary";
        }
    }
    
    /**
     * 등록 상태 한글 표시
     */
    public String getStatusText() {
        if (enrollmentStatus == null) return "정보없음";
        
        switch (enrollmentStatus) {
            case "AVAILABLE": return "등록가능";
            case "ALMOST_FULL": return "마감임박";
            case "FULL": return "마감";
            default: return "정보없음";
        }
    }
    
    /**
     * 체인점 주소 축약 표시
     */
    public String getShortAddress() {
        if (chainAddress == null) return "";
        
        // 구까지만 표시
        String[] parts = chainAddress.split(" ");
        if (parts.length >= 3) {
            return parts[0] + " " + parts[1] + " " + parts[2];
        }
        return chainAddress;
    }
    
    /**
     * 오늘 운영하는지 확인
     */
    public boolean isOperatingToday() {
        if (operatingDays == null) return false;
        
        // 현재 요일 확인 (1=일요일, 2=월요일, ...)
        java.util.Calendar cal = java.util.Calendar.getInstance();
        int dayOfWeek = cal.get(java.util.Calendar.DAY_OF_WEEK);
        
        String[] days = {"SUN", "MON", "TUE", "WED", "THU", "FRI", "SAT"};
        String today = days[dayOfWeek - 1];
        
        return operatingDays.contains(today);
    }
    
    /**
     * 가격 할인 여부 확인 (체인점 가격이 기본 가격보다 저렴한 경우)
     */
    public boolean hasDiscount() {
        return chainPrice != null && getPrice() != null && chainPrice < getPrice();
    }
    
    /**
     * 할인율 계산
     */
    public int getDiscountRate() {
        if (hasDiscount()) {
            return Math.round((float)(getPrice() - chainPrice) / getPrice() * 100);
        }
        return 0;
    }
}