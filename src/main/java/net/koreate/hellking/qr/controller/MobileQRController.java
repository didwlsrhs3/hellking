package net.koreate.hellking.qr.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import net.koreate.hellking.qr.service.QRService;
import net.koreate.hellking.qr.vo.QRVisitVO;
import net.koreate.hellking.qr.vo.QRVisitResult;
import net.koreate.hellking.user.service.UserService;
import net.koreate.hellking.user.vo.UserVO;
import net.koreate.hellking.pass.vo.UserPassVO;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

/**
 * React Native 모바일 앱 전용 QR API Controller
 * 세션 대신 JWT 토큰 또는 Authorization 헤더 사용
 */
@RestController
@RequestMapping("/api/qr")
@CrossOrigin(origins = "*", maxAge = 3600)
public class MobileQRController {
    
    @Autowired
    private QRService qrService;
    
    @Autowired
    private UserService userService;
    
    /**
     * API 연결 테스트용
     */
    @GetMapping("/test")
    public Map<String, Object> testConnection() {
        Map<String, Object> result = new HashMap<>();
        result.put("success", true);
        result.put("message", "Mobile QR API 연결 성공!");
        result.put("timestamp", System.currentTimeMillis());
        return result;
    }
    
    /**
     * 로그인 API (모바일 전용)
     */
    @PostMapping("/login")
    public Map<String, Object> login(@RequestBody Map<String, String> loginData) {
        Map<String, Object> result = new HashMap<>();
        
        try {
            String userId = loginData.get("userId");
            String password = loginData.get("password");
            
            UserVO user = userService.authenticate(userId, password);
            
            if (user != null) {
                result.put("success", true);
                result.put("message", "로그인 성공");
                result.put("userNum", user.getUserNum());
                result.put("userId", user.getUserId());
                result.put("username", user.getUsername());
                // TODO: JWT 토큰 생성 및 반환
                // result.put("token", jwtUtil.generateToken(user));
            } else {
                result.put("success", false);
                result.put("message", "아이디 또는 비밀번호가 일치하지 않습니다.");
            }
            
        } catch (Exception e) {
            result.put("success", false);
            result.put("message", "로그인 처리 중 오류가 발생했습니다.");
        }
        
        return result;
    }
    
    /**
     * QR 코드 스캔 결과 처리 (체인 코드)
     */
 // MobileQRController.java의 scanChainCode 메서드를 임시로 이렇게 수정

    @PostMapping("scan-chain-code")
    @ResponseBody  
    public Map<String, Object> scanChainCode(@RequestBody Map<String, Object> request) {
        Map<String, Object> result = new HashMap<>();
        
        try {
            // Integer를 Long으로 안전하게 변환
            Object userNumObj = request.get("userNum");
            Long userNum = null;
            if (userNumObj instanceof Integer) {
                userNum = ((Integer) userNumObj).longValue();
            } else if (userNumObj instanceof Long) {
                userNum = (Long) userNumObj;
            } else if (userNumObj instanceof String) {
                userNum = Long.parseLong((String) userNumObj);
            }
            
            String chainCode = (String) request.get("chainCode");
            
            System.out.println("=== MobileQRController DEBUG ===");
            System.out.println("Request userNum: " + userNum + " (타입: " + (userNumObj != null ? userNumObj.getClass().getSimpleName() : "null") + ")");
            System.out.println("Request chainCode: " + chainCode);
            
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
            
            System.out.println("=== MobileQRController RESULT ===");
            System.out.println("Success: " + visitResult.isSuccess());
            System.out.println("Message: " + visitResult.getMessage());
            
        } catch (Exception e) {
            System.err.println("=== MobileQRController EXCEPTION ===");
            System.err.println("Exception: " + e.getMessage());
            e.printStackTrace();
            
            result.put("success", false);
            result.put("message", "처리 중 오류가 발생했습니다.");
            result.put("error", e.getMessage());
        }
        
        return result;
    }
    
    /**
     * QR 코드 스캔 결과 처리 (사용자 QR 코드)
     */
    @PostMapping("/scan-user-qr")
    public Map<String, Object> scanUserQR(@RequestBody Map<String, Object> scanData) {
        Map<String, Object> result = new HashMap<>();
        
        try {
            String qrData = scanData.get("qrData").toString();
            // QR 데이터 파싱: "HELLKING:userNum:data:timestamp"
            String[] parts = qrData.split(":");
            
            if (parts.length >= 4 && "HELLKING".equals(parts[0])) {
                Long userNum = Long.parseLong(parts[1]);
                String data = parts[2];
                Long timestamp = Long.parseLong(parts[3]);
                
                // QR 코드 유효성 검증 (예: 5분 이내 생성된 코드만 유효)
                if (System.currentTimeMillis() - timestamp > 300000) {
                    result.put("success", false);
                    result.put("message", "QR 코드가 만료되었습니다. 새로 생성해주세요.");
                    return result;
                }
                
                result.put("success", true);
                result.put("message", "QR 코드 인식 성공");
                result.put("userNum", userNum);
                result.put("data", data);
                
            } else {
                result.put("success", false);
                result.put("message", "올바르지 않은 QR 코드입니다.");
            }
            
        } catch (Exception e) {
            result.put("success", false);
            result.put("message", "QR 코드 파싱 중 오류가 발생했습니다.");
        }
        
        return result;
    }
    
    /**
     * 사용자 방문 기록 조회
     */
    @GetMapping("/visits/{userNum}")
    public Map<String, Object> getUserVisits(@PathVariable Long userNum) {
        Map<String, Object> result = new HashMap<>();
        
        try {
            List<QRVisitVO> visits = qrService.getUserVisits(userNum);
            Map<String, Object> stats = qrService.getUserVisitStats(userNum);
            
            result.put("success", true);
            result.put("visits", visits);
            result.put("stats", stats);
            
        } catch (Exception e) {
            result.put("success", false);
            result.put("message", "방문 기록 조회 중 오류가 발생했습니다.");
        }
        
        return result;
    }
    
    /**
     * 활성 패스권 조회
     */
    @GetMapping("/active-passes/{userNum}")
    public Map<String, Object> getActivePasses(@PathVariable Long userNum) {
        Map<String, Object> result = new HashMap<>();
        
        try {
            result.put("success", true);
            result.put("activePasses", qrService.getActivePasses(userNum));
            
        } catch (Exception e) {
            result.put("success", false);
            result.put("message", "패스권 조회 중 오류가 발생했습니다.");
        }
        
        return result;
    }
    
    /**
     * QR 코드 생성 (모바일용)
     */
    @PostMapping("/generate")
    public Map<String, Object> generateQR(@RequestBody Map<String, Object> requestData) {
        Map<String, Object> result = new HashMap<>();
        
        try {
            Long userNum = Long.parseLong(requestData.get("userNum").toString());
            String data = requestData.getOrDefault("data", "ENTRY").toString();
            
            // 활성 패스권 확인
            if (qrService.getActivePasses(userNum).isEmpty()) {
                result.put("success", false);
                result.put("message", "활성 패스권이 없습니다.");
                return result;
            }
            
            String qrCodeBase64 = qrService.generateQRCodeBase64(userNum, data);
            
            result.put("success", true);
            result.put("qrCode", qrCodeBase64);
            result.put("message", "QR 코드가 생성되었습니다.");
            
        } catch (Exception e) {
            result.put("success", false);
            result.put("message", "QR 코드 생성에 실패했습니다.");
        }
        
        return result;
    }
}