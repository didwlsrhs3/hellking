package net.koreate.hellking.support.vo;

import lombok.Data;
import java.util.Date;

@Data
public class ConsultationTimeSlotVO {
    private String timeSlot;     // "10:00", "11:00" 등
    private boolean available;   // 예약 가능 여부
    private Date consultationDate;
    
    public ConsultationTimeSlotVO() {}
    
    public ConsultationTimeSlotVO(String timeSlot, boolean available) {
        this.timeSlot = timeSlot;
        this.available = available;
    }
    
    public ConsultationTimeSlotVO(String timeSlot, boolean available, Date consultationDate) {
        this.timeSlot = timeSlot;
        this.available = available;
        this.consultationDate = consultationDate;
    }
}