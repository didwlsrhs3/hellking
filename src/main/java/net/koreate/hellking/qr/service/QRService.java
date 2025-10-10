package net.koreate.hellking.qr.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import net.koreate.hellking.qr.dao.QRDAO;
import net.koreate.hellking.qr.vo.QRVisitVO;
import net.koreate.hellking.qr.vo.QRVisitResult;
import net.koreate.hellking.pass.vo.UserPassVO;
import net.koreate.hellking.chain.vo.ChainVO;
<<<<<<< HEAD
import net.koreate.hellking.common.util.QRCodeUtil;
=======
import net.koreate.hellking.common.utils.QRCodeUtil;
>>>>>>> b65c320 (Initial commit)

import java.util.*;
import java.text.SimpleDateFormat;
import java.awt.image.BufferedImage;
<<<<<<< HEAD
=======
import java.util.stream.Collectors;
>>>>>>> b65c320 (Initial commit)

@Service
@Transactional
public class QRService {
    
    @Autowired
    private QRDAO qrDAO;
    
    private SimpleDateFormat dateFormat = new SimpleDateFormat("MM/dd HH:mm");
    
    // === QR 입장 처리 ===
    public QRVisitResult processVisit(Long userNum, String chainCode) {
<<<<<<< HEAD
        try {
            // 1. 가맹점 코드 검증
            ChainVO chain = qrDAO.selectChainByCode(chainCode);
            if (chain == null) {
                recordFailedVisit(userNum, null, "존재하지 않는 가맹점 코드입니다.");
                return QRVisitResult.failure("존재하지 않는 가맹점 코드입니다.");
            }
            
            // 2. 활성 패스권 확인
            List<UserPassVO> activePasses = qrDAO.selectActivePassesByUserNum(userNum);
            if (activePasses.isEmpty()) {
=======
        System.out.println("=== QRService processVisit 시작 ===");
        System.out.println("userNum: " + userNum + ", chainCode: " + chainCode);
        
        try {
            // 1. 가맹점 코드 검증
            System.out.println("1단계: 가맹점 코드 검증 시작");
            ChainVO chain = qrDAO.selectChainByCode(chainCode);
            System.out.println("가맹점 조회 결과: " + (chain != null ? chain.getChainName() + " (ID:" + chain.getChainNum() + ")" : "null"));

            // 디버깅: chain 객체의 모든 필드 출력
            if (chain != null) {
                System.out.println("체인 객체 상세:");
                System.out.println("  chainNum: " + chain.getChainNum());
                System.out.println("  chainName: " + chain.getChainName());
                System.out.println("  address: " + chain.getAddress());
                System.out.println("  chainCode: " + chain.getChainCode());
            }

            if (chain == null) {
                System.out.println("가맹점 null - 실패 기록 시작");
                recordFailedVisit(userNum, null, "존재하지 않는 가맹점 코드입니다.");
                return QRVisitResult.failure("존재하지 않는 가맹점 코드입니다.");
            }

            // chainNum이 null인 경우 임시 처리
            if (chain.getChainNum() == null) {
                System.out.println("경고: chainNum이 null입니다. 임시로 1L로 설정");
                chain.setChainNum(1L); // 임시 해결책
            }
            
            // 2. 활성 패스권 확인
            System.out.println("2단계: 활성 패스권 확인 시작");
            List<UserPassVO> activePasses = qrDAO.selectActivePassesByUserNum(userNum);
            System.out.println("활성 패스권 개수: " + (activePasses != null ? activePasses.size() : "null"));
            
            if (activePasses == null || activePasses.isEmpty()) {
                System.out.println("활성 패스권 없음 - 실패 기록 시작");
>>>>>>> b65c320 (Initial commit)
                recordFailedVisit(userNum, chain.getChainNum(), "활성 패스권이 없습니다.");
                return QRVisitResult.failure("활성 패스권이 없습니다. 패스권을 먼저 구매해주세요.");
            }
            
            // 3. 중복 입장 체크 (1시간 이내)
<<<<<<< HEAD
            int recentVisitCount = qrDAO.checkRecentVisit(userNum, chain.getChainNum());
            if (recentVisitCount > 0) {
=======
            System.out.println("3단계: 중복 입장 체크 시작");
            int recentVisitCount = qrDAO.checkRecentVisit(userNum, chain.getChainNum());
            System.out.println("최근 방문 횟수: " + recentVisitCount);
            
            if (recentVisitCount > 0) {
                System.out.println("중복 입장 감지 - 실패 기록 시작");
>>>>>>> b65c320 (Initial commit)
                recordFailedVisit(userNum, chain.getChainNum(), "1시간 이내 중복 입장입니다.");
                return QRVisitResult.failure("1시간 이내에 이미 입장하셨습니다.");
            }
            
            // 4. 성공적인 입장 기록
<<<<<<< HEAD
            recordSuccessVisit(userNum, chain.getChainNum());
=======
            System.out.println("4단계: 성공 입장 기록 시작");
            recordSuccessVisit(userNum, chain.getChainNum());
            System.out.println("=== QRService processVisit 성공 완료 ===");
>>>>>>> b65c320 (Initial commit)
            
            return QRVisitResult.success(chain.getChainName(), chain.getAddress(), chain.getChainNum());
            
        } catch (Exception e) {
<<<<<<< HEAD
=======
            System.err.println("=== QRService processVisit 예외 발생 ===");
            System.err.println("예외 타입: " + e.getClass().getSimpleName());
            System.err.println("예외 메시지: " + e.getMessage());
            System.err.println("스택 트레이스:");
            e.printStackTrace();
            
>>>>>>> b65c320 (Initial commit)
            return QRVisitResult.failure("처리 중 오류가 발생했습니다.");
        }
    }
    
    // === QR 코드 생성 ===
    public BufferedImage generateQRCode(Long userNum, String data) throws Exception {
<<<<<<< HEAD
        // QR 코드에 포함될 데이터 구성
        String qrData = String.format("HELLKING:%d:%s:%d", userNum, data, System.currentTimeMillis());
        
=======
        String qrData = String.format("HELLKING:%d:%s:%d", userNum, data, System.currentTimeMillis());
>>>>>>> b65c320 (Initial commit)
        return QRCodeUtil.generateQRCode(qrData, 200, 200);
    }
    
    public String generateQRCodeBase64(Long userNum, String data) throws Exception {
        BufferedImage qrImage = generateQRCode(userNum, data);
        return QRCodeUtil.bufferedImageToBase64(qrImage);
    }
    
    // === 방문 기록 관리 ===
    public List<QRVisitVO> getUserVisits(Long userNum) {
        List<QRVisitVO> visits = qrDAO.selectVisitsByUserNum(userNum);
        
<<<<<<< HEAD
        // 표시용 데이터 추가
=======
>>>>>>> b65c320 (Initial commit)
        for (QRVisitVO visit : visits) {
            processVisitData(visit);
        }
        
        return visits;
    }
    
    public List<QRVisitVO> getRecentVisits(Long userNum, int limit) {
        List<QRVisitVO> visits = qrDAO.getRecentSuccessVisits(userNum, limit);
        
        for (QRVisitVO visit : visits) {
            processVisitData(visit);
        }
        
        return visits;
    }
    
    // === 활성 패스권 조회 ===
    public List<UserPassVO> getActivePasses(Long userNum) {
        return qrDAO.selectActivePassesByUserNum(userNum);
    }
    
    // === 통계 ===
    public Map<String, Object> getUserVisitStats(Long userNum) {
        Map<String, Object> stats = new HashMap<>();
        
        stats.put("totalVisits", qrDAO.getTotalVisitCount(userNum));
        stats.put("successVisits", qrDAO.getTotalSuccessVisitCount(userNum));
        stats.put("visitedChains", qrDAO.getVisitedChainCount(userNum));
        stats.put("topChains", qrDAO.getTopVisitedChains(userNum));
        
        return stats;
    }
    
    // === 관리자용 ===
    public Map<String, Object> getTodayStats() {
        Map<String, Object> stats = new HashMap<>();
        
        stats.put("totalVisits", qrDAO.getTodayTotalVisits());
        stats.put("successVisits", qrDAO.getTodaySuccessVisits());
        stats.put("popularChains", qrDAO.getTodayPopularChains());
        
        return stats;
    }
    
    public List<QRVisitVO> getTodayAllVisits() {
        return qrDAO.selectTodayVisits();
    }
    
    // === Private Methods ===
    private void recordSuccessVisit(Long userNum, Long chainNum) {
<<<<<<< HEAD
        QRVisitVO visit = new QRVisitVO();
        visit.setUserNum(userNum);
        visit.setChainNum(chainNum);
        visit.setResult("SUCCESS");
        visit.setVisitTime(new Date());
        
        qrDAO.insertVisit(visit);
    }
    
    private void recordFailedVisit(Long userNum, Long chainNum, String reason) {
        QRVisitVO visit = new QRVisitVO();
        visit.setUserNum(userNum);
        visit.setChainNum(chainNum);
        visit.setResult("FAILED");
        visit.setFailureReason(reason);
        visit.setVisitTime(new Date());
        
        qrDAO.insertVisit(visit);
    }
    
    private void processVisitData(QRVisitVO visit) {
        // 결과 텍스트
        visit.setResultText("SUCCESS".equals(visit.getResult()) ? "성공" : "실패");
=======
        System.out.println("=== recordSuccessVisit 시작 ===");
        System.out.println("userNum: " + userNum + ", chainNum: " + chainNum);
        
        try {
            QRVisitVO visit = new QRVisitVO();
            visit.setUserNum(userNum);
            visit.setChainNum(chainNum);
            visit.setResult("SUCCESS");
            visit.setVisitTime(new Date());
            
            System.out.println("QRVisitVO 생성 완료, DAO.insertVisit 호출");
            int result = qrDAO.insertVisit(visit);
            System.out.println("insertVisit 결과: " + result + ", visitNum=" + visit.getVisitNum());
            System.out.println("=== recordSuccessVisit 완료 ===");
            
        } catch (Exception e) {
            System.err.println("=== recordSuccessVisit 예외 ===");
            System.err.println("예외: " + e.getMessage());
            e.printStackTrace();
            throw e;
        }
    }
    
    private void recordFailedVisit(Long userNum, Long chainNum, String reason) {
        System.out.println("=== recordFailedVisit 시작 ===");
        System.out.println("userNum: " + userNum + ", chainNum: " + chainNum + ", reason: " + reason);
        
        try {
            QRVisitVO visit = new QRVisitVO();
            visit.setUserNum(userNum);
            visit.setChainNum(chainNum);
            visit.setResult("FAILED");
            visit.setFailureReason(reason);
            visit.setVisitTime(new Date());
            
            System.out.println("실패 QRVisitVO 생성 완료, DAO.insertVisit 호출");
            int result = qrDAO.insertVisit(visit);
            System.out.println("실패 insertVisit 결과: " + result);
            System.out.println("=== recordFailedVisit 완료 ===");
            
        } catch (Exception e) {
            System.err.println("=== recordFailedVisit 예외 ===");
            System.err.println("예외: " + e.getMessage());
            e.printStackTrace();
            // 실패 기록 오류는 전파하지 않음
        }
    }
    
    private void processVisitData(QRVisitVO visit) {
        // 결과 텍스트 - 한글 직접 하드코딩
        if ("SUCCESS".equals(visit.getResult())) {
            visit.setResultText("성공");
        } else {
            visit.setResultText("실패");
        }
>>>>>>> b65c320 (Initial commit)
        
        // 방문 시간 포맷
        if (visit.getVisitTime() != null) {
            visit.setVisitTimeText(dateFormat.format(visit.getVisitTime()));
        }
    }
<<<<<<< HEAD
=======
    
    // === 기타 유틸리티 메서드들 ===
    public Map<String, Object> parseQRCode(String qrData) {
        Map<String, Object> result = new HashMap<>();
        
        try {
            String[] parts = qrData.split(":");
            
            if (parts.length >= 4 && "HELLKING".equals(parts[0])) {
                Long userNum = Long.parseLong(parts[1]);
                String data = parts[2];
                Long timestamp = Long.parseLong(parts[3]);
                
                long currentTime = System.currentTimeMillis();
                if (currentTime - timestamp > 300000) {
                    result.put("valid", false);
                    result.put("reason", "QR 코드가 만료되었습니다.");
                    return result;
                }
                
                if (!isValidUser(userNum)) {
                    result.put("valid", false);
                    result.put("reason", "유효하지 않은 사용자입니다.");
                    return result;
                }
                
                result.put("valid", true);
                result.put("userNum", userNum);
                result.put("data", data);
                result.put("timestamp", timestamp);
                
            } else {
                result.put("valid", false);
                result.put("reason", "올바르지 않은 QR 코드 형식입니다.");
            }
            
        } catch (Exception e) {
            result.put("valid", false);
            result.put("reason", "QR 코드 파싱 중 오류가 발생했습니다.");
        }
        
        return result;
    }

    public boolean isValidChainCode(String chainCode) {
        if (chainCode == null || chainCode.trim().length() != 4) {
            return false;
        }
        
        ChainVO chain = qrDAO.selectChainByCode(chainCode.trim().toUpperCase());
        return chain != null;
    }

    private boolean isValidUser(Long userNum) {
        try {
            List<UserPassVO> activePasses = qrDAO.selectActivePassesByUserNum(userNum);
            return !activePasses.isEmpty();
        } catch (Exception e) {
            return false;
        }
    }

    public Map<String, Object> getMobileVisitHistory(Long userNum, int page, int size) {
        Map<String, Object> result = new HashMap<>();
        
        try {
            int offset = (page - 1) * size;
            List<QRVisitVO> visits = qrDAO.getRecentSuccessVisits(userNum, size);
            
            List<Map<String, Object>> simplifiedVisits = visits.stream()
                .map(visit -> {
                    Map<String, Object> item = new HashMap<>();
                    item.put("chainName", visit.getChainName());
                    item.put("visitTime", visit.getVisitTime());
                    item.put("result", visit.getResult());
                    return item;
                })
                .collect(Collectors.toList());
            
            result.put("visits", simplifiedVisits);
            result.put("hasMore", visits.size() == size);
            
        } catch (Exception e) {
            result.put("error", "방문 기록 조회 중 오류가 발생했습니다.");
        }
        
        return result;
    }    
    
    /**
     * 가맹점 QR 코드 생성 (체인 코드를 QR로 변환)
     */
    public BufferedImage generateChainQRCode(String chainCode, int width, int height) throws Exception {
        return QRCodeUtil.generateQRCode(chainCode, width, height);
    }

    /**
     * 가맹점 QR 코드 Base64 생성
     */
    public String generateChainQRCodeBase64(String chainCode) throws Exception {
        BufferedImage qrImage = generateChainQRCode(chainCode, 200, 200);
        return QRCodeUtil.bufferedImageToBase64(qrImage);
    }
>>>>>>> b65c320 (Initial commit)
}