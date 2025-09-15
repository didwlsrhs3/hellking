package net.koreate.hellking.designbody.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import net.koreate.hellking.designbody.dao.DesignBodyDAO;
import net.koreate.hellking.designbody.vo.*;
import net.koreate.hellking.common.exception.HellkingException;
import java.util.*;

@Service
@Transactional
public class DesignBodyService {
    
    @Autowired
    private DesignBodyDAO designBodyDAO;
    
    // 전체 프로그램 목록
    public List<DesignBodyVO> getAllPrograms() {
        return designBodyDAO.selectAllPrograms();
    }
    
    // 프로그램 상세 정보
    public DesignBodyVO getProgramDetail(Long programNum) {
        DesignBodyVO program = designBodyDAO.selectByProgramNum(programNum);
        if (program == null) {
            throw new HellkingException("존재하지 않는 프로그램입니다.");
        }
        return program;
    }
    
    // 타입별 프로그램
    public List<DesignBodyVO> getProgramsByType(String programType) {
        return designBodyDAO.selectByType(programType);
    }
    
    // 난이도별 프로그램
    public List<DesignBodyVO> getProgramsByDifficulty(String difficulty) {
        return designBodyDAO.selectByDifficulty(difficulty);
    }
    
    // 인기 프로그램
    public List<DesignBodyVO> getPopularPrograms(int limit) {
        return designBodyDAO.selectPopularPrograms(limit);
    }
    
    // 추천 프로그램 (메인 페이지용)
    public Map<String, Object> getRecommendedPrograms() {
        Map<String, Object> result = new HashMap<>();
        
        // 타입별로 하나씩
        result.put("diet", designBodyDAO.selectByType("DIET").stream().findFirst().orElse(null));
        result.put("muscle", designBodyDAO.selectByType("MUSCLE").stream().findFirst().orElse(null));
        result.put("cardio", designBodyDAO.selectByType("CARDIO").stream().findFirst().orElse(null));
        result.put("popular", getPopularPrograms(3));
        
        return result;
    }
    
    // 프로그램 신청
    @Transactional
    public boolean enrollProgram(Long userNum, Long programNum, String paymentId) {
        // 중복 신청 체크
        if (designBodyDAO.checkDuplicateEnrollment(userNum, programNum) > 0) {
            throw new HellkingException("이미 신청한 프로그램입니다.");
        }
        
        DesignBodyVO program = designBodyDAO.selectByProgramNum(programNum);
        if (program == null) {
            throw new HellkingException("존재하지 않는 프로그램입니다.");
        }
        
        DesignBodyEnrollVO enrollment = new DesignBodyEnrollVO();
        enrollment.setUserNum(userNum);
        enrollment.setProgramNum(programNum);
        enrollment.setStartDate(new Date());
        
        // 종료일 계산
        Calendar cal = Calendar.getInstance();
        cal.add(Calendar.DAY_OF_MONTH, program.getDuration());
        enrollment.setEndDate(cal.getTime());
        
        enrollment.setPaymentId(paymentId);
        enrollment.setStatus("ACTIVE");
        
        try {
            return designBodyDAO.insertEnrollment(enrollment) > 0;
        } catch (Exception e) {
            throw new HellkingException("프로그램 신청 중 오류가 발생했습니다: " + e.getMessage());
        }
    }
    
    // 내 신청 프로그램 목록
    public List<DesignBodyEnrollVO> getUserEnrollments(Long userNum) {
        List<DesignBodyEnrollVO> enrollments = designBodyDAO.selectUserEnrollments(userNum);
        
        // 진행률 계산
        Date now = new Date();
        for (DesignBodyEnrollVO enrollment : enrollments) {
            if ("ACTIVE".equals(enrollment.getStatus())) {
                long totalDuration = enrollment.getEndDate().getTime() - enrollment.getStartDate().getTime();
                long elapsed = now.getTime() - enrollment.getStartDate().getTime();
                
                if (elapsed > 0 && totalDuration > 0) {
                    int progress = (int) Math.min(100, (elapsed * 100) / totalDuration);
                    enrollment.setProgressPercent(progress);
                } else {
                    enrollment.setProgressPercent(0);
                }
            }
        }
        
        return enrollments;
    }
    
    // 진행중인 프로그램
    public List<DesignBodyEnrollVO> getActiveEnrollments(Long userNum) {
        return designBodyDAO.selectActiveEnrollments(userNum);
    }
    
    // 사용자 프로그램 통계
    public Map<String, Object> getUserProgramStats(Long userNum) {
        List<DesignBodyEnrollVO> enrollments = designBodyDAO.selectUserEnrollments(userNum);
        
        Map<String, Object> stats = new HashMap<>();
        stats.put("totalCount", enrollments.size());
        
        long activeCount = enrollments.stream()
            .filter(e -> "ACTIVE".equals(e.getStatus()))
            .count();
        stats.put("activeCount", activeCount);
        
        long completedCount = enrollments.stream()
            .filter(e -> "COMPLETED".equals(e.getStatus()))
            .count();
        stats.put("completedCount", completedCount);
        
        return stats;
    }
    
    // 관리자용 - 프로그램 등록
    public boolean registerProgram(DesignBodyVO program) {
        try {
            return designBodyDAO.insertProgram(program) > 0;
        } catch (Exception e) {
            throw new HellkingException("프로그램 등록 중 오류가 발생했습니다: " + e.getMessage());
        }
    }
    
    // 전체 통계
    public Map<String, Object> getStatistics() {
        Map<String, Object> stats = new HashMap<>();
        stats.put("totalPrograms", designBodyDAO.getTotalProgramCount());
        stats.put("activeEnrollments", designBodyDAO.getActiveEnrollmentCount());
        return stats;
    }
}