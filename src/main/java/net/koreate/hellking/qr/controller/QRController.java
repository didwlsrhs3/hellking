package net.koreate.hellking.qr.controller;

import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import net.koreate.hellking.qr.service.QRService;
import net.koreate.hellking.qr.vo.QRVisitVO;
import net.koreate.hellking.qr.vo.QRVisitResult;
import net.koreate.hellking.pass.vo.UserPassVO;
import net.koreate.hellking.user.service.UserService;

import java.awt.image.BufferedImage;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.io.IOException;
import javax.imageio.ImageIO;

@Controller
@RequestMapping("/qr/")
public class QRController {
    
    @Autowired
    private QRService qrService;
    
    @Autowired
    private UserService userService;
    
    // === QR 입장 페이지 ===
    @GetMapping("enter")
    public String enter(HttpSession session, Model model) {
        if (!userService.isLoggedIn(session)) {
            return "redirect:/user/login";
        }
        
        Long userNum = userService.getCurrentUserNum(session);
        
        // 활성 패스권 확인
        List<UserPassVO> activePasses = qrService.getActivePasses(userNum);
        
        // 최근 방문 기록
        List<QRVisitVO> recentVisits = qrService.getRecentVisits(userNum, 5);
        
        // 통계
        Map<String, Object> stats = qrService.getUserVisitStats(userNum);
        
        model.addAttribute("activePasses", activePasses);
        model.addAttribute("recentVisits", recentVisits);
        model.addAttribute("stats", stats);
        
        return "qr/enter";
    }
    
    // === 코드 입력 처리 ===
    @PostMapping("processEnter")
    @ResponseBody
    public Map<String, Object> processEnter(String chainCode, HttpSession session) {
        Map<String, Object> result = new HashMap<>();
        
        try {
            Long userNum = userService.getCurrentUserNum(session);
            if (userNum == null) {
                result.put("success", false);
                result.put("message", "로그인이 필요합니다.");
                return result;
            }
            
            if (chainCode == null || chainCode.trim().isEmpty()) {
                result.put("success", false);
                result.put("message", "가맹점 코드를 입력해주세요.");
                return result;
            }
            
            QRVisitResult visitResult = qrService.processVisit(userNum, chainCode.trim().toUpperCase());
            
            result.put("success", visitResult.isSuccess());
            result.put("message", visitResult.getMessage());
            
            if (visitResult.isSuccess()) {
                result.put("chainName", visitResult.getChainName());
                result.put("chainAddress", visitResult.getChainAddress());
            } else {
                result.put("failureReason", visitResult.getFailureReason());
            }
            
        } catch (Exception e) {
            result.put("success", false);
            result.put("message", "처리 중 오류가 발생했습니다.");
        }
        
        return result;
    }
    
    // === QR 코드 생성 ===
    @PostMapping("generateQR")
    @ResponseBody
    public Map<String, Object> generateQR(String data, HttpSession session) {
        Map<String, Object> result = new HashMap<>();
        
        try {
            Long userNum = userService.getCurrentUserNum(session);
            if (userNum == null) {
                result.put("success", false);
                result.put("message", "로그인이 필요합니다.");
                return result;
            }
            
            // 활성 패스권 확인
            List<UserPassVO> activePasses = qrService.getActivePasses(userNum);
            if (activePasses.isEmpty()) {
                result.put("success", false);
                result.put("message", "활성 패스권이 없습니다.");
                return result;
            }
            
            String qrCodeBase64 = qrService.generateQRCodeBase64(userNum, data != null ? data : "ENTRY");
            
            result.put("success", true);
            result.put("qrCode", qrCodeBase64);
            result.put("message", "QR 코드가 생성되었습니다.");
            
        } catch (Exception e) {
            result.put("success", false);
            result.put("message", "QR 코드 생성에 실패했습니다.");
        }
        
        return result;
    }
    
    // === QR 코드 이미지 다운로드 ===
    @GetMapping("downloadQR")
    public void downloadQR(String data, HttpSession session, HttpServletResponse response) throws IOException {
        try {
            Long userNum = userService.getCurrentUserNum(session);
            if (userNum == null) {
                response.sendError(HttpServletResponse.SC_UNAUTHORIZED);
                return;
            }
            
            BufferedImage qrImage = qrService.generateQRCode(userNum, data != null ? data : "ENTRY");
            
            response.setContentType("image/png");
            response.setHeader("Content-Disposition", "attachment; filename=hellking_qr.png");
            
            ImageIO.write(qrImage, "PNG", response.getOutputStream());
            response.getOutputStream().flush();
            
        } catch (Exception e) {
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }
    
    // === 방문 기록 ===
    @GetMapping("history")
    public String history(HttpSession session, Model model) {
        if (!userService.isLoggedIn(session)) {
            return "redirect:/user/login";
        }
        
        Long userNum = userService.getCurrentUserNum(session);
        
        List<QRVisitVO> visits = qrService.getUserVisits(userNum);
        Map<String, Object> stats = qrService.getUserVisitStats(userNum);
        
        model.addAttribute("visits", visits);
        model.addAttribute("stats", stats);
        
        return "qr/history";
    }
    
    // === 방문 통계 API ===
    @GetMapping("getStats")
    @ResponseBody
    public Map<String, Object> getStats(HttpSession session) {
        Long userNum = userService.getCurrentUserNum(session);
        if (userNum == null) {
            return new HashMap<>();
        }
        
        return qrService.getUserVisitStats(userNum);
    }
    
    // === 최근 방문 기록 API ===
    @GetMapping("getRecentVisits")
    @ResponseBody
    public List<QRVisitVO> getRecentVisits(@RequestParam(defaultValue = "10") int limit, HttpSession session) {
        Long userNum = userService.getCurrentUserNum(session);
        if (userNum == null) {
            return null;
        }
        
        return qrService.getRecentVisits(userNum, limit);
    }
    
    // === 관리자용 (추후 구현) ===
    @GetMapping("admin/dashboard")
    public String adminDashboard(Model model) {
        Map<String, Object> todayStats = qrService.getTodayStats();
        List<QRVisitVO> todayVisits = qrService.getTodayAllVisits();
        
        model.addAttribute("todayStats", todayStats);
        model.addAttribute("todayVisits", todayVisits);
        
        return "qr/admin/dashboard";
    }
}