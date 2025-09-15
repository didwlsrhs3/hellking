package net.koreate.hellking.pass.service;

import java.text.DecimalFormat;
import java.time.LocalDate;
import java.time.ZoneId;
import java.time.temporal.ChronoUnit;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import net.koreate.hellking.pass.dao.PassDAO;
// import net.koreate.hellking.common.util.RefundCalculator; // RefundCalculator가 없다면 주석처리
import net.koreate.hellking.pass.vo.PassVO;
import net.koreate.hellking.pass.vo.RefundVO;
import net.koreate.hellking.pass.vo.UserPassVO;

@Service
@Transactional
public class PassService {
    
    @Autowired
    private PassDAO passDAO;
    
    @Autowired
    private PaymentService paymentService; // 더미 PaymentService 사용
    
    private DecimalFormat priceFormat = new DecimalFormat("#,###");
    
    // === 패스권 상품 관리 ===
    public List<PassVO> getAllPasses() {
        List<PassVO> passes = passDAO.selectAllPasses();
        
        // 각 패스권에 대해 포맷팅 처리
        for (PassVO pass : passes) {
            // 가격 포맷팅
            if (pass.getPrice() != null) {
                String formattedPrice = String.format("%,d원", pass.getPrice());
                pass.setFormattedPrice(formattedPrice);
            }
            
            // 기간 텍스트는 이미 getDurationText()에서 처리됨
        }
        
        return passes;
    }
    
    public PassVO getPassByNum(Long passNum) {
        PassVO pass = passDAO.selectByPassNum(passNum);
        if (pass != null) {
            pass.setFormattedPrice(priceFormat.format(pass.getPrice()) + "원");
            pass.setDurationText(pass.getDurationDays() + "일권");
        }
        return pass;
    }
    
    // === 패스권 구매 관리 (더미 결제 연동) ===
    public String createPaymentOrder(Long userNum, Long passNum) throws Exception {
        // 더미 PaymentService 사용 - 실제 결제 없이 테스트용
        return paymentService.createPayment(userNum, passNum);
    }
    
    public boolean purchasePass(Long userNum, Long passNum, String paymentId) throws Exception {
        // 더미 결제 검증 - 개발용으로 항상 성공
        boolean paymentVerified = paymentService.verifyPayment(paymentId);
        if (!paymentVerified) {
            throw new Exception("결제 검증에 실패했습니다.");
        }
        
        PassVO pass = passDAO.selectByPassNum(passNum);
        if (pass == null) {
            throw new Exception("패스권 정보를 찾을 수 없습니다.");
        }
        
        // 기존 활성 패스권 만료 처리
        List<UserPassVO> activePasses = passDAO.selectActivePasses(userNum);
        for (UserPassVO activePass : activePasses) {
            passDAO.updateUserPassStatus(activePass.getUserPassNum(), "CANCELLED");
        }
        
        // 새 패스권 생성
        UserPassVO userPass = new UserPassVO();
        userPass.setUserNum(userNum);
        userPass.setPassNum(passNum);
        userPass.setStartDate(new Date());
        
        // 종료일 계산
        Calendar cal = Calendar.getInstance();
        cal.add(Calendar.DAY_OF_MONTH, pass.getDurationDays());
        userPass.setEndDate(cal.getTime());
        
        userPass.setPaymentId(paymentId);
        userPass.setStatus("ACTIVE");
        
        return passDAO.insertUserPass(userPass) > 0;
    }
    
    // === 내 패스권 관리 ===
    public List<UserPassVO> getUserPasses(Long userNum) {
        List<UserPassVO> userPasses = passDAO.selectUserPasses(userNum);
        
        // 표시용 데이터 계산
        for (UserPassVO userPass : userPasses) {
            processUserPassData(userPass);
        }
        
        return userPasses;
    }
    
    public List<UserPassVO> getActivePasses(Long userNum) {
        List<UserPassVO> activePasses = passDAO.selectActivePasses(userNum);
        
        for (UserPassVO userPass : activePasses) {
            processUserPassData(userPass);
        }
        
        return activePasses;
    }
    
    public UserPassVO getUserPassByNum(Long userPassNum) {
        UserPassVO userPass = passDAO.selectUserPassByNum(userPassNum);
        if (userPass != null) {
            processUserPassData(userPass);
        }
        return userPass;
    }
    
    // UserPassVO 데이터 처리 공통 메서드
    private void processUserPassData(UserPassVO userPass) {
        Date now = new Date();
        
        // 남은 일수 계산
        if (userPass.getEndDate().after(now)) {
            LocalDate endDate = userPass.getEndDate().toInstant().atZone(ZoneId.systemDefault()).toLocalDate();
            LocalDate nowDate = now.toInstant().atZone(ZoneId.systemDefault()).toLocalDate();
            userPass.setRemainingDays((int) ChronoUnit.DAYS.between(nowDate, endDate));
        } else {
            userPass.setRemainingDays(0);
        }
        
        // 만료 여부
        userPass.setIsExpired(userPass.getEndDate().before(now));
        
        // 환불 가능 여부 (구매 후 7일 이내, 활성 상태)
        Calendar purchaseLimit = Calendar.getInstance();
        purchaseLimit.setTime(userPass.getPurchaseDate());
        purchaseLimit.add(Calendar.DAY_OF_MONTH, 7);
        
        userPass.setCanRefund("ACTIVE".equals(userPass.getStatus()) && 
                             now.before(purchaseLimit.getTime()));
        
        // 상태 텍스트
        switch (userPass.getStatus()) {
            case "ACTIVE":
                userPass.setStatusText(userPass.getIsExpired() ? "만료됨" : "사용중");
                break;
            case "EXPIRED":
                userPass.setStatusText("만료됨");
                break;
            case "CANCELLED":
                userPass.setStatusText("취소됨");
                break;
            case "REFUNDED":
                userPass.setStatusText("환불됨");
                break;
            default:
                userPass.setStatusText("알 수 없음");
        }
        
        // 포맷된 가격
        if (userPass.getPrice() != null) {
            userPass.setFormattedPrice(priceFormat.format(userPass.getPrice()) + "원");
        }
    }
    
    // === 환불 관리 (더미 구현) ===
    public boolean requestRefund(Long userPassNum, String reason) throws Exception {
        UserPassVO userPass = passDAO.selectUserPassByNum(userPassNum);
        if (userPass == null) {
            throw new Exception("패스권 정보를 찾을 수 없습니다.");
        }
        
        if (!"ACTIVE".equals(userPass.getStatus())) {
            throw new Exception("활성 상태의 패스권만 환불 가능합니다.");
        }
        
        // 환불 가능 기간 체크 (구매 후 7일)
        Calendar purchaseLimit = Calendar.getInstance();
        purchaseLimit.setTime(userPass.getPurchaseDate());
        purchaseLimit.add(Calendar.DAY_OF_MONTH, 7);
        
        if (new Date().after(purchaseLimit.getTime())) {
            throw new Exception("환불 가능 기간이 지났습니다. (구매 후 7일 이내)");
        }
        
        // 환불 금액 계산 (RefundCalculator가 없다면 단순 계산)
        Long refundAmount = userPass.getPrice(); // 간단히 전액 환불로 처리
        
        /* RefundCalculator가 있다면 이 코드 사용:
        Long refundAmount = RefundCalculator.calculateRefundAmount(
            userPass.getPrice(), 
            userPass.getStartDate(), 
            userPass.getEndDate(), 
            new Date()
        );
        */
        
        RefundVO refund = new RefundVO();
        refund.setUserPassNum(userPassNum);
        refund.setRefundAmount(refundAmount);
        refund.setReason(reason);
        refund.setStatus("REQUESTED");
        
        // 환불 신청 등록
        int result = passDAO.insertRefund(refund);
        
        if (result > 0) {
            // 패스권 상태를 환불 대기로 변경
            passDAO.updateUserPassStatus(userPassNum, "REFUND_REQUESTED");
            return true;
        }
        
        return false;
    }
    
    public List<RefundVO> getRefunds(Long userNum) {
        List<RefundVO> refunds = passDAO.selectRefundsByUserNum(userNum);
        
        // 표시용 데이터 추가
        for (RefundVO refund : refunds) {
            // 상태 텍스트
            switch (refund.getStatus()) {
                case "REQUESTED":
                    refund.setStatusText("신청됨");
                    break;
                case "APPROVED":
                    refund.setStatusText("승인됨");
                    break;
                case "REJECTED":
                    refund.setStatusText("거절됨");
                    break;
                case "COMPLETED":
                    refund.setStatusText("완료됨");
                    break;
                default:
                    refund.setStatusText("알 수 없음");
            }
            
            // 포맷된 환불 금액
            refund.setFormattedRefundAmount(priceFormat.format(refund.getRefundAmount()) + "원");
        }
        
        return refunds;
    }
    
    // === 만료 처리 ===
    public void processExpiredPasses() {
        passDAO.updateExpiredPasses();
    }
    
    // === 통계 ===
    public Map<String, Object> getUserPassStats(Long userNum) {
        Map<String, Object> stats = new HashMap<>();
        
        stats.put("totalCount", passDAO.getTotalPassCount(userNum));
        stats.put("activeCount", passDAO.getActivePassCount(userNum));
        stats.put("totalSpent", passDAO.getTotalSpentAmount(userNum));
        
        return stats;
    }
    
    // === 관리자용 ===
    public List<RefundVO> getAllRefunds() {
        return passDAO.selectAllRefunds();
    }
    
    public boolean processRefund(Long refundNum, String status, String rejectReason) {
        return passDAO.updateRefundStatus(refundNum, status, rejectReason) > 0;
    }
}