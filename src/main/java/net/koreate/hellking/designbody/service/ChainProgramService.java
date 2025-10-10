package net.koreate.hellking.designbody.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import net.koreate.hellking.designbody.dao.ChainProgramDAO;
import net.koreate.hellking.designbody.vo.ChainProgramVO;
import net.koreate.hellking.designbody.vo.DesignBodyEnrollVO;
import net.koreate.hellking.common.service.KakaoMapService;
import net.koreate.hellking.common.exception.HellkingException;

import java.util.*;
import java.util.stream.Collectors;

/**
 * 체인점 프로그램 관리 서비스
 */
@Service
@Transactional
public class ChainProgramService {
    
    @Autowired
    private ChainProgramDAO chainProgramDAO;
    
    @Autowired
    private KakaoMapService kakaoMapService;
    
    // ===== 기본 프로그램 조회 =====
    
    /**
     * 전체 체인점 프로그램 조회
     */
    public List<ChainProgramVO> getAllChainPrograms() {
        return chainProgramDAO.selectAllChainPrograms();
    }
    
    /**
     * 특정 체인점의 프로그램 조회
     */
    public List<ChainProgramVO> getProgramsByChain(Long chainNum) {
        if (chainNum == null) {
            throw new HellkingException("체인점 번호가 필요합니다.");
        }
        return chainProgramDAO.selectProgramsByChain(chainNum);
    }
    
    /**
     * 프로그램 타입별 조회
     */
    public List<ChainProgramVO> getProgramsByType(String programType) {
        if (programType == null || programType.trim().isEmpty()) {
            return getAllChainPrograms();
        }
        return chainProgramDAO.selectProgramsByType(programType.toUpperCase());
    }
    
    /**
     * 체인점 프로그램 상세 정보 조회
     */
    public ChainProgramVO getChainProgramDetail(Long programNum) {
        if (programNum == null) {
            throw new HellkingException("프로그램 번호가 필요합니다.");
        }
        
        ChainProgramVO program = chainProgramDAO.selectChainProgramDetail(programNum);
        if (program == null) {
            throw new HellkingException("존재하지 않는 프로그램입니다.");
        }
        return program;
    }
    
    /**
     * 등록 가능한 프로그램만 조회
     */
    public List<ChainProgramVO> getAvailablePrograms() {
        return chainProgramDAO.selectAvailablePrograms();
    }
    
    /**
     * 인기 체인점 프로그램 조회
     */
    public List<ChainProgramVO> getPopularChainPrograms(int limit) {
        return chainProgramDAO.selectPopularChainPrograms(limit);
    }
    
    // ===== 위치 기반 프로그램 검색 =====
    
    /**
     * 근처 체인점 프로그램 검색
     */
    public Map<String, Object> searchNearbyPrograms(double latitude, double longitude, 
                                                   int radius, String programType, String sortBy) {
        Map<String, Object> result = new HashMap<>();
        
        try {
            System.out.println("=== 근처 체인점 프로그램 검색 시작 ===");
            System.out.println("위치: " + latitude + ", " + longitude);
            System.out.println("반경: " + radius + "km, 타입: " + programType + ", 정렬: " + sortBy);
            
            // 좌표 정보가 있는 모든 프로그램 조회
            List<ChainProgramVO> allPrograms = chainProgramDAO.selectProgramsWithCoordinates();
            
            if (allPrograms.isEmpty()) {
                result.put("success", true);
                result.put("programs", List.of());
                result.put("totalCount", 0);
                result.put("message", "등록된 프로그램이 없습니다.");
                return result;
            }
            
            // 거리 계산 및 필터링
            List<ChainProgramVO> nearbyPrograms = allPrograms.stream()
                .filter(program -> {
                    try {
                        // 좌표 유효성 검사
                        if (program.getChainLatitude() == null || program.getChainLongitude() == null) {
                            return false;
                        }
                        
                        // 거리 계산
                        double distance = kakaoMapService.calculateDistance(
                            latitude, longitude,
                            program.getChainLatitude(), program.getChainLongitude()
                        );
                        program.setDistance(distance);
                        
                        // 반경 내 프로그램만 필터링
                        return distance <= radius;
                        
                    } catch (Exception e) {
                        System.err.println("거리 계산 오류: " + program.getChainName() + " - " + e.getMessage());
                        return false;
                    }
                })
                .collect(Collectors.toList());
            
            // 프로그램 타입 필터링
            if (programType != null && !programType.trim().isEmpty() && !"ALL".equalsIgnoreCase(programType)) {
                nearbyPrograms = nearbyPrograms.stream()
                    .filter(program -> programType.equalsIgnoreCase(program.getProgramType()))
                    .collect(Collectors.toList());
            }
            
            // 정렬
            nearbyPrograms = sortPrograms(nearbyPrograms, sortBy);
            
            result.put("success", true);
            result.put("programs", nearbyPrograms);
            result.put("totalCount", nearbyPrograms.size());
            result.put("message", nearbyPrograms.size() + "개의 프로그램을 찾았습니다.");
            
            System.out.println("검색 완료: " + nearbyPrograms.size() + "개 프로그램 반환");
            
        } catch (Exception e) {
            System.err.println("근처 프로그램 검색 오류: " + e.getMessage());
            e.printStackTrace();
            
            result.put("success", false);
            result.put("programs", List.of());
            result.put("totalCount", 0);
            result.put("message", "검색 중 오류가 발생했습니다: " + e.getMessage());
        }
        
        return result;
    }
    
    /**
     * 프로그램 목록 정렬
     */
    private List<ChainProgramVO> sortPrograms(List<ChainProgramVO> programs, String sortBy) {
        if (sortBy == null) sortBy = "distance";
        
        switch (sortBy.toLowerCase()) {
            case "price_low":
                return programs.stream()
                    .sorted(Comparator.comparing(ChainProgramVO::getFinalPrice, Comparator.nullsLast(Comparator.naturalOrder())))
                    .collect(Collectors.toList());
            case "price_high":
                return programs.stream()
                    .sorted(Comparator.comparing(ChainProgramVO::getFinalPrice, Comparator.nullsFirst(Comparator.reverseOrder())))
                    .collect(Collectors.toList());
            case "popular":
                return programs.stream()
                    .sorted(Comparator.comparing(ChainProgramVO::getCurrentEnrollment, Comparator.nullsLast(Comparator.reverseOrder())))
                    .collect(Collectors.toList());
            case "capacity":
                return programs.stream()
                    .sorted(Comparator.comparing(ChainProgramVO::getAvailableSpots, Comparator.nullsLast(Comparator.reverseOrder())))
                    .collect(Collectors.toList());
            case "distance":
            default:
                return programs.stream()
                    .sorted(Comparator.comparing(ChainProgramVO::getDistance, Comparator.nullsLast(Comparator.naturalOrder())))
                    .collect(Collectors.toList());
        }
    }
    
    // ===== 프로그램 신청 관련 =====
    
    /**
     * 체인점 프로그램 신청
     */
    @Transactional
    public boolean enrollChainProgram(Long userNum, Long programNum, Long chainNum, String paymentId) {
        // 기본 유효성 검사
        if (userNum == null || programNum == null || chainNum == null) {
            throw new HellkingException("필수 정보가 누락되었습니다.");
        }
        
        // 프로그램 존재 여부 및 등록 가능 여부 확인
        ChainProgramVO program = chainProgramDAO.selectChainProgramDetail(programNum);
        if (program == null) {
            throw new HellkingException("존재하지 않는 프로그램입니다.");
        }
        
        if (!program.getChainNum().equals(chainNum)) {
            throw new HellkingException("해당 체인점에서 운영하지 않는 프로그램입니다.");
        }
        
        if (program.isFull()) {
            throw new HellkingException("정원이 마감된 프로그램입니다.");
        }
        
        // 중복 신청 체크
        if (chainProgramDAO.checkDuplicateChainEnrollment(userNum, programNum, chainNum) > 0) {
            throw new HellkingException("이미 신청한 프로그램입니다.");
        }
        
        try {
            // 등록 정보 생성
            DesignBodyEnrollVO enrollment = new DesignBodyEnrollVO();
            enrollment.setUserNum(userNum);
            enrollment.setProgramNum(programNum);
            enrollment.setChainNum(chainNum);
            enrollment.setStartDate(new Date());
            
            // 종료일 계산
            Calendar cal = Calendar.getInstance();
            cal.add(Calendar.DAY_OF_MONTH, program.getDuration());
            enrollment.setEndDate(cal.getTime());
            
            enrollment.setPaymentId(paymentId);
            enrollment.setStatus("ACTIVE");
            
            // 등록 처리
            int enrollResult = chainProgramDAO.insertChainProgramEnrollment(enrollment);
            if (enrollResult <= 0) {
                throw new HellkingException("프로그램 등록에 실패했습니다.");
            }
            
            // 등록자 수 증가
            int updateResult = chainProgramDAO.incrementEnrollment(programNum);
            if (updateResult <= 0) {
                throw new HellkingException("등록자 수 업데이트에 실패했습니다.");
            }
            
            System.out.println("체인점 프로그램 등록 완료: userNum=" + userNum + 
                             ", programNum=" + programNum + ", chainNum=" + chainNum);
            return true;
            
        } catch (Exception e) {
            System.err.println("프로그램 등록 실패: " + e.getMessage());
            throw new HellkingException("프로그램 신청 중 오류가 발생했습니다: " + e.getMessage());
        }
    }
    
    /**
     * 사용자의 체인점 프로그램 등록 내역
     */
    public List<DesignBodyEnrollVO> getUserChainEnrollments(Long userNum) {
        if (userNum == null) {
            throw new HellkingException("사용자 번호가 필요합니다.");
        }
        
        List<DesignBodyEnrollVO> enrollments = chainProgramDAO.selectUserChainEnrollments(userNum);
        
        // 진행률 계산 추가
        Date now = new Date();
        for (DesignBodyEnrollVO enrollment : enrollments) {
            if ("ACTIVE".equals(enrollment.getStatus()) && enrollment.getStartDate() != null && enrollment.getEndDate() != null) {
                long totalDuration = enrollment.getEndDate().getTime() - enrollment.getStartDate().getTime();
                long elapsed = now.getTime() - enrollment.getStartDate().getTime();
                
                if (elapsed > 0 && totalDuration > 0) {
                    int progress = (int) Math.min(100, Math.max(0, (elapsed * 100) / totalDuration));
                    enrollment.setProgressPercent(progress);
                } else {
                    enrollment.setProgressPercent(0);
                }
            }
        }
        
        return enrollments;
    }
    
    // ===== 검색 및 필터링 =====
    
    /**
     * 키워드로 체인점 프로그램 검색
     */
    public List<ChainProgramVO> searchPrograms(String keyword) {
        if (keyword == null || keyword.trim().isEmpty()) {
            return getAllChainPrograms();
        }
        return chainProgramDAO.searchChainPrograms(keyword.trim());
    }
    
    /**
     * 지역별 프로그램 검색
     */
    public List<ChainProgramVO> getProgramsByRegion(String region) {
        if (region == null || region.trim().isEmpty()) {
            return getAllChainPrograms();
        }
        return chainProgramDAO.selectProgramsByRegion(region.trim());
    }
    
    /**
     * 복합 필터 검색
     */
    public Map<String, Object> searchProgramsWithFilters(String keyword, String programType, 
                                                        String region, String difficulty,
                                                        Long minPrice, Long maxPrice,
                                                        String sortBy) {
        try {
            List<ChainProgramVO> programs = getAllChainPrograms();
            
            // 키워드 필터
            if (keyword != null && !keyword.trim().isEmpty()) {
                String lowerKeyword = keyword.toLowerCase();
                programs = programs.stream()
                    .filter(p -> p.getProgramName().toLowerCase().contains(lowerKeyword) ||
                               p.getChainName().toLowerCase().contains(lowerKeyword) ||
                               p.getInstructor().toLowerCase().contains(lowerKeyword) ||
                               (p.getDescription() != null && p.getDescription().toLowerCase().contains(lowerKeyword)))
                    .collect(Collectors.toList());
            }
            
            // 프로그램 타입 필터
            if (programType != null && !programType.trim().isEmpty() && !"ALL".equalsIgnoreCase(programType)) {
                programs = programs.stream()
                    .filter(p -> programType.equalsIgnoreCase(p.getProgramType()))
                    .collect(Collectors.toList());
            }
            
            // 지역 필터
            if (region != null && !region.trim().isEmpty()) {
                programs = programs.stream()
                    .filter(p -> p.getChainAddress() != null && p.getChainAddress().contains(region))
                    .collect(Collectors.toList());
            }
            
            // 난이도 필터
            if (difficulty != null && !difficulty.trim().isEmpty()) {
                programs = programs.stream()
                    .filter(p -> difficulty.equalsIgnoreCase(p.getDifficulty()))
                    .collect(Collectors.toList());
            }
            
            // 가격 필터
            if (minPrice != null || maxPrice != null) {
                programs = programs.stream()
                    .filter(p -> {
                        Long price = p.getFinalPrice();
                        if (price == null) price = 0L;
                        
                        boolean minOk = minPrice == null || price >= minPrice;
                        boolean maxOk = maxPrice == null || price <= maxPrice;
                        return minOk && maxOk;
                    })
                    .collect(Collectors.toList());
            }
            
            // 정렬
            programs = sortPrograms(programs, sortBy);
            
            Map<String, Object> result = new HashMap<>();
            result.put("programs", programs);
            result.put("totalCount", programs.size());
            result.put("success", true);
            result.put("message", programs.size() + "개의 프로그램을 찾았습니다.");
            
            return result;
            
        } catch (Exception e) {
            System.err.println("프로그램 필터 검색 오류: " + e.getMessage());
            
            Map<String, Object> result = new HashMap<>();
            result.put("programs", List.of());
            result.put("totalCount", 0);
            result.put("success", false);
            result.put("message", "검색 중 오류가 발생했습니다.");
            return result;
        }
    }
    
    // ===== 통계 및 분석 =====
    
    /**
     * 체인점별 프로그램 통계
     */
    public List<Map<String, Object>> getChainProgramStatistics() {
        return chainProgramDAO.selectChainProgramStats();
    }
    
    /**
     * 특정 체인점의 통계 정보
     */
    public Map<String, Object> getChainStatistics(Long chainNum) {
        Map<String, Object> stats = new HashMap<>();
        
        try {
            List<ChainProgramVO> programs = getProgramsByChain(chainNum);
            
            stats.put("totalPrograms", programs.size());
            stats.put("totalEnrollment", chainProgramDAO.getTotalEnrollmentByChain(chainNum));
            stats.put("averageEnrollmentRate", chainProgramDAO.getAverageEnrollmentRateByChain(chainNum));
            
            // 프로그램 타입별 개수
            Map<String, Long> typeCount = programs.stream()
                .collect(Collectors.groupingBy(
                    ChainProgramVO::getProgramType, 
                    Collectors.counting()
                ));
            stats.put("programTypeStats", typeCount);
            
            // 등록 상태별 개수
            Map<String, Long> statusCount = programs.stream()
                .collect(Collectors.groupingBy(
                    ChainProgramVO::getEnrollmentStatus,
                    Collectors.counting()
                ));
            stats.put("enrollmentStatusStats", statusCount);
            
            // 평균 가격
            double avgPrice = programs.stream()
                .mapToLong(p -> p.getFinalPrice() != null ? p.getFinalPrice() : 0L)
                .average()
                .orElse(0.0);
            stats.put("averagePrice", Math.round(avgPrice));
            
        } catch (Exception e) {
            System.err.println("체인점 통계 조회 오류: " + e.getMessage());
        }
        
        return stats;
    }
    
    /**
     * 메인 페이지용 추천 프로그램
     */
    public Map<String, Object> getRecommendedChainPrograms() {
        Map<String, Object> result = new HashMap<>();
        
        try {
            // 인기 프로그램
            result.put("popular", getPopularChainPrograms(6));
            
            // 등록 가능한 프로그램
            List<ChainProgramVO> available = getAvailablePrograms();
            if (available.size() > 6) {
                available = available.subList(0, 6);
            }
            result.put("available", available);
            
            // 타입별 추천 (각 타입에서 1개씩)
            List<ChainProgramVO> allPrograms = getAllChainPrograms();
            result.put("diet", allPrograms.stream()
                .filter(p -> "DIET".equals(p.getProgramType()))
                .findFirst().orElse(null));
            result.put("muscle", allPrograms.stream()
                .filter(p -> "MUSCLE".equals(p.getProgramType()))
                .findFirst().orElse(null));
            result.put("cardio", allPrograms.stream()
                .filter(p -> "CARDIO".equals(p.getProgramType()))
                .findFirst().orElse(null));
            result.put("rehab", allPrograms.stream()
                .filter(p -> "REHAB".equals(p.getProgramType()))
                .findFirst().orElse(null));
            
        } catch (Exception e) {
            System.err.println("추천 프로그램 조회 오류: " + e.getMessage());
        }
        
        return result;
    }
}