package net.koreate.hellking.pass.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import net.koreate.hellking.pass.service.PassService;
import net.koreate.hellking.pass.vo.RefundVO;
import net.koreate.hellking.user.service.UserService;
import net.koreate.hellking.common.service.SecurityService;

@Controller
@RequestMapping("/pass/admin/refund/")
public class AdminRefundController {
    
    @Autowired
    private PassService passService;
    
    @Autowired
    private UserService userService;
    
    @Autowired
    private SecurityService securityService;
    
    /**
     * 환불 신청 목록 조회 (보안 강화)
     */
    @GetMapping("list")
    public String refundList(Model model, HttpSession session, HttpServletRequest request) {
        System.out.println("=== AdminRefundController.refundList() 시작 ===");
        
        try {
            // 관리자 권한 및 보안 로그 체크
            if (!securityService.checkAdminAccessWithLog(session, request, "환불관리페이지접근", "목록조회")) {
                System.out.println("관리자 권한 없음 - 메인으로 리다이렉트");
                model.addAttribute("error", "관리자 권한이 필요합니다.");
                return "redirect:/";
            }
            
            // 보안이 강화된 환불 목록 조회 (계좌 정보 포함)
            List<RefundVO> refunds = passService.getAllRefundsWithSecurity(session, request);
            System.out.println("조회된 환불 신청 수: " + (refunds != null ? refunds.size() : 0));
            
            // 상태별 통계 계산
            long requestedCount = 0, approvedCount = 0, rejectedCount = 0, completedCount = 0;
            
            if (refunds != null) {
                for (RefundVO refund : refunds) {
                    switch (refund.getStatus()) {
                        case "REQUESTED": requestedCount++; break;
                        case "APPROVED": approvedCount++; break;
                        case "REJECTED": rejectedCount++; break;
                        case "COMPLETED": completedCount++; break;
                    }
                }
            }
            
            // 모델에 데이터 추가
            model.addAttribute("refunds", refunds);
            model.addAttribute("requestedCount", requestedCount);
            model.addAttribute("approvedCount", approvedCount);
            model.addAttribute("rejectedCount", rejectedCount);
            model.addAttribute("completedCount", completedCount);
            
            return "pass/admin_refund_list";
            
        } catch (SecurityException e) {
            System.out.println("보안 오류: " + e.getMessage());
            model.addAttribute("error", "접근이 거부되었습니다.");
            return "redirect:/";
            
        } catch (Exception e) {
            System.out.println("환불 목록 조회 중 오류 발생: " + e.getMessage());
            e.printStackTrace();
            
            model.addAttribute("error", "환불 목록을 불러오는 중 오류가 발생했습니다.");
            model.addAttribute("refunds", null);
            model.addAttribute("requestedCount", 0);
            model.addAttribute("approvedCount", 0);
            model.addAttribute("rejectedCount", 0);
            model.addAttribute("completedCount", 0);
            
            return "pass/admin_refund_list";
        }
    }
    
    /**
     * 환불 승인 (보안 강화)
     */
    @PostMapping("approve")
    @ResponseBody
    public Map<String, Object> approveRefund(@RequestParam Long refundNum, 
                                           HttpSession session, HttpServletRequest request) {
        Map<String, Object> result = new HashMap<>();
        
        System.out.println("=== 환불 승인 처리 시작 ===");
        System.out.println("처리할 refundNum: " + refundNum);
        
        try {
            // 보안 강화된 환불 처리
            boolean success = passService.processRefundWithSecurity(refundNum, "APPROVED", null, session, request);
            
            if (success) {
                result.put("success", true);
                result.put("message", "환불이 승인되었습니다. 실제 환불 처리를 진행해주세요.");
                System.out.println("[보안로그] 환불 승인 완료: refundNum=" + refundNum);
            } else {
                result.put("success", false);
                result.put("message", "환불 승인에 실패했습니다.");
            }
            
        } catch (SecurityException e) {
            result.put("success", false);
            result.put("message", "관리자 권한이 필요합니다.");
            System.out.println("[보안경고] 환불 승인 권한 오류: " + e.getMessage());
            
        } catch (Exception e) {
            System.out.println("환불 승인 중 오류 발생: " + e.getMessage());
            e.printStackTrace();
            result.put("success", false);
            result.put("message", "오류가 발생했습니다: " + e.getMessage());
        }
        
        return result;
    }
    
    /**
     * 환불 거절 (보안 강화)
     */
    @PostMapping("reject")
    @ResponseBody
    public Map<String, Object> rejectRefund(@RequestParam Long refundNum, 
                                          @RequestParam String rejectReason,
                                          HttpSession session, HttpServletRequest request) {
        Map<String, Object> result = new HashMap<>();
        
        System.out.println("=== 환불 거절 처리 시작 ===");
        System.out.println("처리할 refundNum: " + refundNum);
        
        try {
            // 입력값 검증
            if (rejectReason == null || rejectReason.trim().length() < 10) {
                result.put("success", false);
                result.put("message", "거절 사유를 10글자 이상 입력해주세요.");
                return result;
            }
            
            // 보안 강화된 환불 처리
            boolean success = passService.processRefundWithSecurity(refundNum, "REJECTED", rejectReason.trim(), session, request);
            
            if (success) {
                result.put("success", true);
                result.put("message", "환불이 거절되었습니다.");
                System.out.println("[보안로그] 환불 거절 완료: refundNum=" + refundNum);
            } else {
                result.put("success", false);
                result.put("message", "환불 거절 처리에 실패했습니다.");
            }
            
        } catch (SecurityException e) {
            result.put("success", false);
            result.put("message", "관리자 권한이 필요합니다.");
            System.out.println("[보안경고] 환불 거절 권한 오류: " + e.getMessage());
            
        } catch (Exception e) {
            System.out.println("환불 거절 중 오류 발생: " + e.getMessage());
            e.printStackTrace();
            result.put("success", false);
            result.put("message", "오류가 발생했습니다: " + e.getMessage());
        }
        
        return result;
    }
    
    /**
     * 환불 완료 처리 (보안 강화)
     */
    @PostMapping("complete")
    @ResponseBody
    public Map<String, Object> completeRefund(@RequestParam Long refundNum, 
                                            HttpSession session, HttpServletRequest request) {
        Map<String, Object> result = new HashMap<>();
        
        System.out.println("=== 환불 완료 처리 시작 ===");
        System.out.println("처리할 refundNum: " + refundNum);
        
        try {
            // 보안 강화된 환불 처리
            boolean success = passService.processRefundWithSecurity(refundNum, "COMPLETED", null, session, request);
            
            if (success) {
                result.put("success", true);
                result.put("message", "환불이 완료 처리되었습니다. 개인정보 보호를 위해 계좌 정보는 30일 후 자동 삭제됩니다.");
                System.out.println("[보안로그] 환불 완료 처리 성공: refundNum=" + refundNum);
                System.out.println("[개인정보보호] 계좌정보 삭제 예약됨");
            } else {
                result.put("success", false);
                result.put("message", "환불 완료 처리에 실패했습니다.");
            }
            
        } catch (SecurityException e) {
            result.put("success", false);
            result.put("message", "관리자 권한이 필요합니다.");
            System.out.println("[보안경고] 환불 완료 권한 오류: " + e.getMessage());
            
        } catch (Exception e) {
            System.out.println("환불 완료 처리 중 오류 발생: " + e.getMessage());
            e.printStackTrace();
            result.put("success", false);
            result.put("message", "오류가 발생했습니다: " + e.getMessage());
        }
        
        return result;
    }
    
    /**
     * 계좌 정보 즉시 삭제 (추가 기능)
     */
    @PostMapping("deleteAccount")
    @ResponseBody
    public Map<String, Object> deleteAccountInfo(@RequestParam Long refundNum,
                                                HttpSession session, HttpServletRequest request) {
        Map<String, Object> result = new HashMap<>();
        
        try {
            boolean success = passService.deleteAccountInfoImmediately(refundNum, session, request);
            
            if (success) {
                result.put("success", true);
                result.put("message", "계좌 정보가 즉시 삭제되었습니다.");
                System.out.println("[개인정보보호] 계좌정보 즉시 삭제 완료: refundNum=" + refundNum);
            } else {
                result.put("success", false);
                result.put("message", "계좌 정보 삭제에 실패했습니다.");
            }
            
        } catch (SecurityException e) {
            result.put("success", false);
            result.put("message", "관리자 권한이 필요합니다.");
            
        } catch (Exception e) {
            System.out.println("계좌 정보 삭제 중 오류: " + e.getMessage());
            result.put("success", false);
            result.put("message", "오류가 발생했습니다.");
        }
        
        return result;
    }
}