package net.koreate.hellking.qr.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import net.koreate.hellking.qr.dao.QRDAO;
import net.koreate.hellking.qr.vo.QRVisitVO;
import net.koreate.hellking.qr.vo.QRVisitResult;
import net.koreate.hellking.pass.vo.UserPassVO;
import net.koreate.hellking.chain.vo.ChainVO;
import net.koreate.hellking.common.util.QRCodeUtil;

import java.util.*;
import java.text.SimpleDateFormat;
import java.awt.image.BufferedImage;

@Service
@Transactional
public class QRService {
    
    @Autowired
    private QRDAO qrDAO;
    
    private SimpleDateFormat dateFormat = new SimpleDateFormat("MM/dd HH:mm");
    
    // === QR 입장 처리 ===
    public QRVisitResult processVisit(Long userNum, String chainCode) {
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
                recordFailedVisit(userNum, chain.getChainNum(), "활성 패스권이 없습니다.");
                return QRVisitResult.failure("활성 패스권이 없습니다. 패스권을 먼저 구매해주세요.");
            }
            
            // 3. 중복 입장 체크 (1시간 이내)
            int recentVisitCount = qrDAO.checkRecentVisit(userNum, chain.getChainNum());
            if (recentVisitCount > 0) {
                recordFailedVisit(userNum, chain.getChainNum(), "1시간 이내 중복 입장입니다.");
                return QRVisitResult.failure("1시간 이내에 이미 입장하셨습니다.");
            }
            
            // 4. 성공적인 입장 기록
            recordSuccessVisit(userNum, chain.getChainNum());
            
            return QRVisitResult.success(chain.getChainName(), chain.getAddress(), chain.getChainNum());
            
        } catch (Exception e) {
            return QRVisitResult.failure("처리 중 오류가 발생했습니다.");
        }
    }
    
    // === QR 코드 생성 ===
    public BufferedImage generateQRCode(Long userNum, String data) throws Exception {
        // QR 코드에 포함될 데이터 구성
        String qrData = String.format("HELLKING:%d:%s:%d", userNum, data, System.currentTimeMillis());
        
        return QRCodeUtil.generateQRCode(qrData, 200, 200);
    }
    
    public String generateQRCodeBase64(Long userNum, String data) throws Exception {
        BufferedImage qrImage = generateQRCode(userNum, data);
        return QRCodeUtil.bufferedImageToBase64(qrImage);
    }
    
    // === 방문 기록 관리 ===
    public List<QRVisitVO> getUserVisits(Long userNum) {
        List<QRVisitVO> visits = qrDAO.selectVisitsByUserNum(userNum);
        
        // 표시용 데이터 추가
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
        
        // 방문 시간 포맷
        if (visit.getVisitTime() != null) {
            visit.setVisitTimeText(dateFormat.format(visit.getVisitTime()));
        }
    }
}