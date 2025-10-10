package net.koreate.hellking.support.service;

import java.text.SimpleDateFormat;
import java.util.*;

import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import lombok.extern.slf4j.Slf4j;
import net.koreate.hellking.support.dao.ConsultationDAO;
import net.koreate.hellking.support.vo.ConsultationVO;

/**
 * 상담예약 서비스
 */
@Service
@Slf4j
public class ConsultationService {
    
    @Autowired
    private ConsultationDAO consultationDAO;
    
    @Autowired
    private JavaMailSender mailSender;
    
    // 예약 가능 시간 (10-12시, 14-17시)
    private static final String[] AVAILABLE_TIMES = {
        "10:00", "11:00", "14:00", "15:00", "16:00"
    };
    
    /**
     * 상담예약 등록
     */
    @Transactional
    public boolean createConsultation(ConsultationVO consultation) throws Exception {
        // 1. 예약 가능 여부 확인
        if (!isValidConsultationDateTime(consultation.getConsultationDate(), consultation.getConsultationTime())) {
            throw new Exception("예약할 수 없는 날짜/시간입니다.");
        }
        
        // 2. 시간대 중복 확인
        int bookedCount = consultationDAO.checkTimeSlotAvailable(
            consultation.getConsultationDate(), consultation.getConsultationTime());
        
        if (bookedCount > 0) {
            throw new Exception("해당 시간은 이미 예약되었습니다.");
        }
        
        // 3. 예약 등록
        consultation.setStatus("CONFIRMED");
        int result = consultationDAO.insertConsultation(consultation);
        
        if (result > 0) {
            // 4. 예약 확인 이메일 발송
            sendConsultationConfirmEmail(consultation);
            log.info("상담예약 등록 완료: {}", consultation.getConsultationNum());
            return true;
        }
        
        return false;
    }
    
    /**
     * 상담예약 취소 (오버로드 - 기본)
     */
    @Transactional
    public boolean cancelConsultation(Long consultationNum, Long userNum) throws Exception {
        return cancelConsultation(consultationNum, userNum, false);
    }
    
    /**
     * 상담예약 취소 (관리자 권한 포함)
     */
    @Transactional
    public boolean cancelConsultation(Long consultationNum, Long userNum, boolean isAdmin) throws Exception {
        ConsultationVO consultation = consultationDAO.selectConsultationByNum(consultationNum);
        
        if (consultation == null) {
            throw new Exception("존재하지 않는 예약입니다.");
        }
        
        if (!consultation.getUserNum().equals(userNum)) {
            throw new Exception("본인의 예약만 취소할 수 있습니다.");
        }
        
        if (!"CONFIRMED".equals(consultation.getStatus())) {
            throw new Exception("이미 취소된 예약입니다.");
        }
        
        // 취소 가능 시간 확인 (1시간 전까지)
        if (!consultation.getCanCancel()) {
            throw new Exception("예약 1시간 전까지만 취소가 가능합니다.");
        }
        
        int result = consultationDAO.updateConsultationStatus(consultationNum, "CANCELLED");
        
        if (result > 0) {
            // 취소 안내 이메일 발송
            sendConsultationCancelEmail(consultation);
            log.info("상담예약 취소 완료: {}", consultationNum);
            return true;
        }
        
        return false;
    }
    
    /**
     * 예약 가능 날짜/시간 유효성 검증
     */
    public boolean isValidConsultationDateTime(Date consultationDate, String consultationTime) {
        try {
            Calendar cal = Calendar.getInstance();
            cal.setTime(consultationDate);
            
            // 1. 과거 날짜 체크
            Calendar today = Calendar.getInstance();
            today.set(Calendar.HOUR_OF_DAY, 0);
            today.set(Calendar.MINUTE, 0);
            today.set(Calendar.SECOND, 0);
            today.set(Calendar.MILLISECOND, 0);
            
            if (consultationDate.before(today.getTime())) {
                log.warn("과거 날짜 예약 시도: {}", consultationDate);
                return false;
            }
            
            // 2. 주말 체크 (토요일=7, 일요일=1)
            int dayOfWeek = cal.get(Calendar.DAY_OF_WEEK);
            if (dayOfWeek == Calendar.SATURDAY || dayOfWeek == Calendar.SUNDAY) {
                log.warn("주말 예약 시도: {}", consultationDate);
                return false;
            }
            
            // 3. 공휴일 체크
            int holidayCount = consultationDAO.checkHoliday(consultationDate);
            if (holidayCount > 0) {
                log.warn("공휴일 예약 시도: {}", consultationDate);
                return false;
            }
            
            // 4. 예약 가능 시간 체크
            boolean validTime = Arrays.asList(AVAILABLE_TIMES).contains(consultationTime);
            if (!validTime) {
                log.warn("잘못된 예약 시간: {}", consultationTime);
                return false;
            }
            
            return true;
            
        } catch (Exception e) {
            log.error("날짜/시간 유효성 검증 오류: {}", e.getMessage());
            return false;
        }
    }
    
    /**
     * 특정 날짜의 예약 가능한 시간 조회
     */
    public List<String> getAvailableTimeSlots(Date consultationDate) {
        List<String> availableSlots = new ArrayList<>();
        
        if (!isValidConsultationDate(consultationDate)) {
            return availableSlots; // 빈 리스트 반환
        }
        
        // 예약된 시간 조회
        List<String> bookedSlots = consultationDAO.selectBookedTimeSlots(consultationDate);
        
        // 예약 가능한 시간에서 예약된 시간 제외
        for (String time : AVAILABLE_TIMES) {
            if (!bookedSlots.contains(time)) {
                availableSlots.add(time);
            }
        }
        
        return availableSlots;
    }
    
    /**
     * 날짜만 유효성 검증 (시간 제외)
     */
    private boolean isValidConsultationDate(Date consultationDate) {
        try {
            Calendar cal = Calendar.getInstance();
            cal.setTime(consultationDate);
            
            // 과거 날짜 체크
            Calendar today = Calendar.getInstance();
            today.set(Calendar.HOUR_OF_DAY, 0);
            today.set(Calendar.MINUTE, 0);
            today.set(Calendar.SECOND, 0);
            today.set(Calendar.MILLISECOND, 0);
            
            if (consultationDate.before(today.getTime())) {
                return false;
            }
            
            // 주말 체크
            int dayOfWeek = cal.get(Calendar.DAY_OF_WEEK);
            if (dayOfWeek == Calendar.SATURDAY || dayOfWeek == Calendar.SUNDAY) {
                return false;
            }
            
            // 공휴일 체크
            int holidayCount = consultationDAO.checkHoliday(consultationDate);
            return holidayCount == 0;
            
        } catch (Exception e) {
            return false;
        }
    }
    
    /**
     * 사용자별 예약 목록 조회
     */
    public List<ConsultationVO> getUserConsultations(Long userNum) {
        return consultationDAO.selectConsultationsByUser(userNum);
    }
    
    /**
     * 예약 상세 조회
     */
    public ConsultationVO getConsultation(Long consultationNum) {
        return consultationDAO.selectConsultationByNum(consultationNum);
    }
    
    /**
     * 관리자용 예약 목록 조회
     */
    public Map<String, Object> getConsultationsForAdmin(Map<String, Object> params) {
        Map<String, Object> result = new HashMap<>();
        
        // 페이징 처리
        int page = params.get("page") != null ? (Integer) params.get("page") : 1;
        int pageSize = params.get("pageSize") != null ? (Integer) params.get("pageSize") : 10;
        
        int startRow = (page - 1) * pageSize + 1;
        int endRow = page * pageSize;
        
        params.put("startRow", startRow);
        params.put("endRow", endRow);
        
        // 데이터 조회
        List<ConsultationVO> consultations = consultationDAO.selectConsultationsForAdmin(params);
        int totalCount = consultationDAO.selectConsultationCountForAdmin(params);
        
        result.put("consultations", consultations);
        result.put("totalCount", totalCount);
        result.put("currentPage", page);
        result.put("pageSize", pageSize);
        result.put("totalPages", (int) Math.ceil((double) totalCount / pageSize));
        
        return result;
    }
    
    /**
     * 사용자 최근 예약 정보 조회 (자동 입력용)
     */
    public ConsultationVO getRecentConsultation(Long userNum) {
        return consultationDAO.selectRecentConsultationByUser(userNum);
    }
    
    /**
     * 예약 확인 이메일 발송
     */
    private void sendConsultationConfirmEmail(ConsultationVO consultation) {
        try {
            MimeMessage message = mailSender.createMimeMessage();
            MimeMessageHelper helper = new MimeMessageHelper(message, true, "UTF-8");
            
            helper.setFrom("ceskalee@gmail.com", "헬킹 피트니스");
            helper.setTo(consultation.getEmail());
            helper.setSubject("[헬킹] 상담예약이 확정되었습니다");
            
            String content = buildConsultationConfirmEmailContent(consultation);
            helper.setText(content, true);
            
            mailSender.send(message);
            log.info("예약 확인 이메일 발송 완료: {}", consultation.getEmail());
            
        } catch (Exception e) {
            log.error("예약 확인 이메일 발송 실패: {}", e.getMessage());
        }
    }
    
    /**
     * 예약 취소 이메일 발송
     */
    private void sendConsultationCancelEmail(ConsultationVO consultation) {
        try {
            MimeMessage message = mailSender.createMimeMessage();
            MimeMessageHelper helper = new MimeMessageHelper(message, true, "UTF-8");
            
            helper.setFrom("ceskalee@gmail.com", "헬킹 피트니스");
            helper.setTo(consultation.getEmail());
            helper.setSubject("[헬킹] 상담예약이 취소되었습니다");
            
            String content = buildConsultationCancelEmailContent(consultation);
            helper.setText(content, true);
            
            mailSender.send(message);
            log.info("예약 취소 이메일 발송 완료: {}", consultation.getEmail());
            
        } catch (Exception e) {
            log.error("예약 취소 이메일 발송 실패: {}", e.getMessage());
        }
    }
    
    /**
     * 당일 상담 안내 이메일 발송 (스케줄러)
     * 매일 오전 9시에 실행
     */
    @Scheduled(cron = "0 0 9 * * ?")
    public void sendTodayConsultationReminder() {
        try {
            List<ConsultationVO> todayConsultations = consultationDAO.selectTodayConsultations();
            
            for (ConsultationVO consultation : todayConsultations) {
                sendTodayReminderEmail(consultation);
            }
            
            log.info("당일 상담 안내 이메일 발송 완료: {} 건", todayConsultations.size());
            
        } catch (Exception e) {
            log.error("당일 상담 안내 이메일 발송 실패: {}", e.getMessage());
        }
    }
    
    /**
     * 당일 상담 안내 이메일 발송
     */
    private void sendTodayReminderEmail(ConsultationVO consultation) {
        try {
            MimeMessage message = mailSender.createMimeMessage();
            MimeMessageHelper helper = new MimeMessageHelper(message, true, "UTF-8");
            
            helper.setFrom("ceskalee@gmail.com", "헬킹 피트니스");
            helper.setTo(consultation.getEmail());
            helper.setSubject("[헬킹] 오늘 상담예약 안내");
            
            String content = buildTodayReminderEmailContent(consultation);
            helper.setText(content, true);
            
            mailSender.send(message);
            
        } catch (Exception e) {
            log.error("당일 안내 이메일 발송 실패: {}", e.getMessage());
        }
    }
    
    /**
     * 예약 확인 이메일 템플릿
     */
    private String buildConsultationConfirmEmailContent(ConsultationVO consultation) {
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy년 MM월 dd일 (E)");
        
        StringBuilder content = new StringBuilder();
        content.append("<div style='max-width: 600px; margin: 0 auto; font-family: Arial, sans-serif;'>");
        content.append("<div style='background: linear-gradient(135deg, #FF6A00, #ff8533); padding: 30px; text-align: center;'>");
        content.append("<h1 style='color: white; margin: 0; font-size: 24px;'>헬킹 피트니스</h1>");
        content.append("<p style='color: white; margin: 10px 0 0; font-size: 14px;'>상담예약이 확정되었습니다</p>");
        content.append("</div>");
        content.append("<div style='background: white; padding: 40px; border: 1px solid #E7E0D6;'>");
        content.append("<h2 style='color: #0F172A; text-align: center; margin-bottom: 30px;'>상담예약 확정 안내</h2>");
        content.append("<div style='background: #F4ECDC; padding: 20px; border-radius: 12px; margin: 30px 0;'>");
        content.append("<p style='margin: 0; font-size: 16px; color: #0F172A;'>");
        content.append("<strong>예약자명:</strong> ").append(consultation.getName()).append("<br>");
        content.append("<strong>상담일시:</strong> ").append(dateFormat.format(consultation.getConsultationDate()));
        content.append(" ").append(consultation.getConsultationTime()).append("<br>");
        content.append("<strong>연락처:</strong> ").append(consultation.getPhone()).append("<br>");
        if (consultation.getContent() != null && !consultation.getContent().trim().isEmpty()) {
            content.append("<strong>상담내용:</strong> ").append(consultation.getContent());
        }
        content.append("</p>");
        content.append("</div>");
        content.append("<p style='color: #5B6170; text-align: center; line-height: 1.6;'>");
        content.append("상담 1시간 전까지 취소가 가능합니다.<br>");
        content.append("문의사항이 있으시면 언제든 연락주세요.");
        content.append("</p>");
        content.append("</div>");
        content.append("</div>");
        
        return content.toString();
    }
    
    /**
     * 예약 취소 이메일 템플릿
     */
    private String buildConsultationCancelEmailContent(ConsultationVO consultation) {
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy년 MM월 dd일 (E)");
        
        StringBuilder content = new StringBuilder();
        content.append("<div style='max-width: 600px; margin: 0 auto; font-family: Arial, sans-serif;'>");
        content.append("<div style='background: linear-gradient(135deg, #6B7280, #9CA3AF); padding: 30px; text-align: center;'>");
        content.append("<h1 style='color: white; margin: 0; font-size: 24px;'>헬킹 피트니스</h1>");
        content.append("<p style='color: white; margin: 10px 0 0; font-size: 14px;'>상담예약이 취소되었습니다</p>");
        content.append("</div>");
        content.append("<div style='background: white; padding: 40px; border: 1px solid #E7E0D6;'>");
        content.append("<h2 style='color: #0F172A; text-align: center; margin-bottom: 30px;'>상담예약 취소 안내</h2>");
        content.append("<div style='background: #F3F4F6; padding: 20px; border-radius: 12px; margin: 30px 0;'>");
        content.append("<p style='margin: 0; font-size: 16px; color: #0F172A;'>");
        content.append("<strong>예약자명:</strong> ").append(consultation.getName()).append("<br>");
        content.append("<strong>취소된 상담일시:</strong> ").append(dateFormat.format(consultation.getConsultationDate()));
        content.append(" ").append(consultation.getConsultationTime());
        content.append("</p>");
        content.append("</div>");
        content.append("<p style='color: #5B6170; text-align: center; line-height: 1.6;'>");
        content.append("다시 상담을 원하시면 언제든 새로 예약해주세요.<br>");
        content.append("감사합니다.");
        content.append("</p>");
        content.append("</div>");
        content.append("</div>");
        
        return content.toString();
    }
    
    /**
     * 당일 상담 안내 이메일 템플릿
     */
    private String buildTodayReminderEmailContent(ConsultationVO consultation) {
        StringBuilder content = new StringBuilder();
        content.append("<div style='max-width: 600px; margin: 0 auto; font-family: Arial, sans-serif;'>");
        content.append("<div style='background: linear-gradient(135deg, #10B981, #34D399); padding: 30px; text-align: center;'>");
        content.append("<h1 style='color: white; margin: 0; font-size: 24px;'>헬킹 피트니스</h1>");
        content.append("<p style='color: white; margin: 10px 0 0; font-size: 14px;'>오늘 상담예약 안내</p>");
        content.append("</div>");
        content.append("<div style='background: white; padding: 40px; border: 1px solid #E7E0D6;'>");
        content.append("<h2 style='color: #0F172A; text-align: center; margin-bottom: 30px;'>오늘 상담 안내</h2>");
        content.append("<div style='background: #ECFDF5; padding: 20px; border-radius: 12px; margin: 30px 0;'>");
        content.append("<p style='margin: 0; font-size: 16px; color: #0F172A;'>");
        content.append("안녕하세요, ").append(consultation.getName()).append("님!<br><br>");
        content.append("오늘 <strong>").append(consultation.getConsultationTime()).append("</strong>에 ");
        content.append("상담 예약이 있습니다.<br><br>");
        content.append("시간에 맞춰 방문해주시기 바랍니다.");
        content.append("</p>");
        content.append("</div>");
        content.append("<p style='color: #5B6170; text-align: center; line-height: 1.6;'>");
        content.append("📞 문의: 1588-0000<br>");
        content.append("📧 이메일: support@hellking.co.kr");
        content.append("</p>");
        content.append("</div>");
        content.append("</div>");
        
        return content.toString();
    }
}