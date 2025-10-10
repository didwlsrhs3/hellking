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

<<<<<<< HEAD
import org.springframework.beans.factory.annotation.Autowired;
=======
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
>>>>>>> b65c320 (Initial commit)
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import net.koreate.hellking.pass.dao.PassDAO;
<<<<<<< HEAD
// import net.koreate.hellking.common.util.RefundCalculator; // RefundCalculator가 없다면 주석처리
import net.koreate.hellking.pass.vo.PassVO;
import net.koreate.hellking.pass.vo.RefundVO;
import net.koreate.hellking.pass.vo.UserPassVO;
=======
import net.koreate.hellking.pass.vo.PassVO;
import net.koreate.hellking.pass.vo.RefundVO;
import net.koreate.hellking.pass.vo.UserPassVO;
import net.koreate.hellking.common.service.SecurityService;
import net.koreate.hellking.common.utils.EncryptionUtil;
>>>>>>> b65c320 (Initial commit)

@Service
@Transactional
public class PassService {
    
    @Autowired
    private PassDAO passDAO;
    
    @Autowired
    private PaymentService paymentService; // 더미 PaymentService 사용
    
<<<<<<< HEAD
=======
    @Autowired
    private SecurityService securityService;
    
>>>>>>> b65c320 (Initial commit)
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
    
<<<<<<< HEAD
    // UserPassVO 데이터 처리 공통 메서드
=======
    // UserPassVO 데이터 처리 공통 메서드 (수정됨)
>>>>>>> b65c320 (Initial commit)
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
        
<<<<<<< HEAD
        // 상태 텍스트
=======
        // 상태 텍스트 (수정됨 - 새로운 상태들 추가)
>>>>>>> b65c320 (Initial commit)
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
<<<<<<< HEAD
=======
            case "REFUND_REQUESTED":
                userPass.setStatusText("환불 신청 중");
                break;
            case "REFUND_APPROVED":
                userPass.setStatusText("환불 승인됨");
                break;
>>>>>>> b65c320 (Initial commit)
            default:
                userPass.setStatusText("알 수 없음");
        }
        
        // 포맷된 가격
        if (userPass.getPrice() != null) {
            userPass.setFormattedPrice(priceFormat.format(userPass.getPrice()) + "원");
        }
    }
    
<<<<<<< HEAD
    // === 환불 관리 (더미 구현) ===
=======
    // === 환불 관리 ===
    
    /**
     * 기존 환불 신청 (계좌 정보 없이)
     */
>>>>>>> b65c320 (Initial commit)
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
        
<<<<<<< HEAD
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
        
=======
        // 환불 금액 계산
        Long refundAmount = userPass.getPrice(); // 간단히 전액 환불로 처리
        
>>>>>>> b65c320 (Initial commit)
        RefundVO refund = new RefundVO();
        refund.setUserPassNum(userPassNum);
        refund.setRefundAmount(refundAmount);
        refund.setReason(reason);
        refund.setStatus("REQUESTED");
        
<<<<<<< HEAD
        // 환불 신청 등록
        int result = passDAO.insertRefund(refund);
=======
        // 기존 방식으로 환불 신청 등록 (계좌 정보 없이)
        int result = passDAO.insertRefundWithAccount(refund);
>>>>>>> b65c320 (Initial commit)
        
        if (result > 0) {
            // 패스권 상태를 환불 대기로 변경
            passDAO.updateUserPassStatus(userPassNum, "REFUND_REQUESTED");
            return true;
        }
        
        return false;
    }
    
<<<<<<< HEAD
=======
    /**
     * 계좌 정보 포함 환불 신청 (새로운 버전)
     */
    public boolean requestRefundWithAccount(Long userPassNum, String reason, 
                                          String bankName, String accountNumber, String accountHolder) throws Exception {
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
        
        // 환불 금액 계산
        Long refundAmount = userPass.getPrice(); // 간단히 전액 환불로 처리
        
        RefundVO refund = new RefundVO();
        refund.setUserPassNum(userPassNum);
        refund.setRefundAmount(refundAmount);
        refund.setReason(reason);
        refund.setStatus("REQUESTED");
        
        // 계좌 정보 설정
        refund.setBankName(bankName);
        refund.setAccountNumber(accountNumber);
        refund.setAccountHolder(accountHolder);
        
        // 환불 신청 등록 (계좌 정보 포함) - DAO에서 암호화 처리
        int result = passDAO.insertRefundWithAccount(refund);
        
        if (result > 0) {
            // 패스권 상태를 환불 대기로 변경
            passDAO.updateUserPassStatus(userPassNum, "REFUND_REQUESTED");
            
            System.out.println("[개인정보보호] 환불 신청시 계좌정보 암호화 저장 완료");
            return true;
        }
        
        return false;
    }
    
>>>>>>> b65c320 (Initial commit)
    public List<RefundVO> getRefunds(Long userNum) {
        List<RefundVO> refunds = passDAO.selectRefundsByUserNum(userNum);
        
        // 표시용 데이터 추가
        for (RefundVO refund : refunds) {
<<<<<<< HEAD
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
=======
            processRefundDisplayData(refund);
>>>>>>> b65c320 (Initial commit)
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
    
<<<<<<< HEAD
    // === 관리자용 ===
    public List<RefundVO> getAllRefunds() {
        return passDAO.selectAllRefunds();
    }
    
    public boolean processRefund(Long refundNum, String status, String rejectReason) {
        return passDAO.updateRefundStatus(refundNum, status, rejectReason) > 0;
=======
    // === 관리자용 - 기본 버전 ===
    public List<RefundVO> getAllRefunds() {
        List<RefundVO> refunds = passDAO.selectAllRefundsWithAccount ();
        
        // 표시용 데이터 처리
        for (RefundVO refund : refunds) {
            processRefundDisplayData(refund);
        }
        
        return refunds;
    }
    
    public boolean processRefund(Long refundNum, String status, String rejectReason) {
        System.out.println("=== PassService.processRefund 시작 ===");
        System.out.println("refundNum: " + refundNum + ", status: " + status + ", rejectReason: " + rejectReason);
        
        try {
            // 1. 환불 정보 먼저 조회 (user_pass_num 필요)
            RefundVO refund = passDAO.selectRefundByNum(refundNum);
            if (refund == null) {
                System.out.println("환불 정보를 찾을 수 없음: refundNum=" + refundNum);
                return false;
            }
            
            System.out.println("조회된 환불 정보 - userPassNum: " + refund.getUserPassNum());
            
            // 2. 환불 테이블 업데이트
            int updateResult = passDAO.updateRefundStatus(refundNum, status, rejectReason);
            System.out.println("환불 테이블 업데이트 결과: " + updateResult);
            
            if (updateResult > 0) {
                // 3. 사용자 패스권 상태 업데이트
                String newPassStatus = getNewPassStatus(status);
                
                if (newPassStatus != null) {
                    System.out.println("패스권 상태 업데이트 시도: " + refund.getUserPassNum() + " -> " + newPassStatus);
                    int passUpdateResult = passDAO.updateUserPassStatus(refund.getUserPassNum(), newPassStatus);
                    System.out.println("패스권 상태 업데이트 결과: " + passUpdateResult);
                    
                    if (passUpdateResult > 0) {
                        System.out.println("환불 처리 완료 - 환불 테이블과 패스권 테이블 모두 업데이트됨");
                        return true;
                    } else {
                        System.out.println("패스권 상태 업데이트 실패");
                        return false;
                    }
                } else {
                    System.out.println("패스권 상태 업데이트 불필요");
                    return true;
                }
            }
            
            return false;
            
        } catch (Exception e) {
            System.out.println("processRefund 중 오류 발생: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
    
    // === 관리자용 - 보안 강화 버전 (SecurityService가 있을 때만 사용) ===
    
    /**
     * 관리자용 - 보안 강화된 환불 목록 조회
     */
    public List<RefundVO> getAllRefundsWithSecurity(HttpSession session, HttpServletRequest request) {
        // 관리자 권한 및 접근 로그 확인
        if (!securityService.checkAdminAccessWithLog(session, request, "환불목록조회", "전체")) {
            throw new SecurityException("관리자 권한이 필요합니다.");
        }
        
        List<RefundVO> refunds = passDAO.selectAllRefundsWithAccount();
        
        // 관리자 정보
        String adminId = (String) session.getAttribute("userId");
        String clientIp = getClientIpFromRequest(request);
        
        // 각 환불 건에 대해 처리
        for (RefundVO refund : refunds) {
            // 계좌 정보 복호화 (DB에서 암호화된 상태로 온 것)
            if (refund.getAccountNumber() != null && !refund.getAccountNumber().isEmpty()) {
                refund.setAccountNumber(EncryptionUtil.decrypt(refund.getAccountNumber()));
            }
            if (refund.getAccountHolder() != null && !refund.getAccountHolder().isEmpty()) {
                refund.setAccountHolder(EncryptionUtil.decrypt(refund.getAccountHolder()));
            }
            
            // 민감정보 접근 로그 기록
            if (refund.hasAccountInfo()) {
                securityService.logSensitiveDataAccess(adminId, "계좌정보조회", 
                    refund.getRefundNum(), clientIp, "계좌번호,예금주명");
            }
            
            // 상태 텍스트 및 포맷된 금액 설정
            processRefundDisplayData(refund);
        }
        
        return refunds;
    }

    /**
     * 환불 처리 (보안 강화)
     */
    public boolean processRefundWithSecurity(Long refundNum, String status, String rejectReason, 
                                           HttpSession session, HttpServletRequest request) {
        // 관리자 권한 및 접근 로그 확인
        String action = "환불" + getActionText(status);
        if (!securityService.checkAdminAccessWithLog(session, request, action, refundNum.toString())) {
            throw new SecurityException("관리자 권한이 필요합니다.");
        }
        
        try {
            // 기존 환불 처리 로직
            RefundVO refund = passDAO.selectRefundByNum(refundNum);
            if (refund == null) {
                System.out.println("환불 정보를 찾을 수 없음: refundNum=" + refundNum);
                return false;
            }
            
            // 환불 테이블 업데이트
            int updateResult = passDAO.updateRefundStatus(refundNum, status, rejectReason);
            
            if (updateResult > 0) {
                // 패스권 상태 업데이트
                String newPassStatus = getNewPassStatus(status);
                if (newPassStatus != null) {
                    passDAO.updateUserPassStatus(refund.getUserPassNum(), newPassStatus);
                }
                
                // 완료 처리시 개인정보 삭제 예약
                if ("COMPLETED".equals(status)) {
                    securityService.schedulePersonalDataDeletion(refundNum);
                }
                
                return true;
            }
            
            return false;
            
        } catch (Exception e) {
            System.out.println("processRefundWithSecurity 중 오류 발생: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    /**
     * 환불 완료 후 계좌 정보 즉시 삭제 (선택적)
     */
    public boolean deleteAccountInfoImmediately(Long refundNum, HttpSession session, HttpServletRequest request) {
        // 관리자 권한 확인
        if (!securityService.checkAdminAccessWithLog(session, request, "계좌정보삭제", refundNum.toString())) {
            throw new SecurityException("관리자 권한이 필요합니다.");
        }
        
        try {
            int result = passDAO.deleteAccountInfo(refundNum);
            if (result > 0) {
                String adminId = (String) session.getAttribute("userId");
                String clientIp = getClientIpFromRequest(request);
                
                System.out.println("[개인정보보호] 환불번호 " + refundNum + " 계좌정보 즉시 삭제 완료");
                securityService.logSensitiveDataAccess(adminId, "계좌정보삭제", refundNum, clientIp, "즉시삭제");
                
                return true;
            }
            return false;
        } catch (Exception e) {
            System.out.println("계좌 정보 삭제 중 오류: " + e.getMessage());
            return false;
        }
    }

    /**
     * 배치 작업: 완료된 환불의 만료된 계좌 정보 삭제
     */
    @Scheduled(cron = "0 0 2 * * *") // 매일 새벽 2시 실행
    public void batchDeleteExpiredAccountInfo() {
        try {
            // 삭제 대상 조회
            List<RefundVO> targetsToDelete = passDAO.selectAccountInfoToDelete();
            
            if (!targetsToDelete.isEmpty()) {
                System.out.println("[배치작업] 만료된 계좌정보 삭제 시작 - 대상: " + targetsToDelete.size() + "건");
                
                // 일괄 삭제 실행
                int deletedCount = passDAO.batchDeleteExpiredAccountInfo();
                
                System.out.println("[배치작업] 계좌정보 삭제 완료 - 삭제됨: " + deletedCount + "건");
                System.out.println("[개인정보보호] 개인정보 보호 정책에 따라 30일 경과 계좌정보가 삭제되었습니다.");
            }
        } catch (Exception e) {
            System.err.println("[배치오류] 계좌정보 삭제 배치 작업 실패: " + e.getMessage());
            e.printStackTrace();
        }
    }

    // === 헬퍼 메소드들 ===
    
    private String getActionText(String status) {
        switch (status) {
            case "APPROVED": return "승인";
            case "REJECTED": return "거절";
            case "COMPLETED": return "완료";
            default: return "처리";
        }
    }

    private String getNewPassStatus(String refundStatus) {
        switch (refundStatus) {
            case "APPROVED": return "REFUND_APPROVED";
            case "REJECTED": return "ACTIVE";
            case "COMPLETED": return "REFUNDED";
            default: return null;
        }
    }

    private void processRefundDisplayData(RefundVO refund) {
        // 상태 텍스트 설정
        switch (refund.getStatus()) {
            case "REQUESTED": refund.setStatusText("신청됨"); break;
            case "APPROVED": refund.setStatusText("승인됨"); break;
            case "REJECTED": refund.setStatusText("거절됨"); break;
            case "COMPLETED": refund.setStatusText("완료됨"); break;
            default: refund.setStatusText("알 수 없음");
        }
        
        // 포맷된 환불 금액
        if (refund.getRefundAmount() != null) {
            refund.setFormattedRefundAmount(String.format("%,d원", refund.getRefundAmount()));
        }
    }
    
    /**
     * 클라이언트 IP 주소 추출 (SecurityService가 없을 때 사용)
     */
    private String getClientIpFromRequest(HttpServletRequest request) {
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
>>>>>>> b65c320 (Initial commit)
    }
}