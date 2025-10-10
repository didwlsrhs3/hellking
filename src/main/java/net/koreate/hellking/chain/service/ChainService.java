package net.koreate.hellking.chain.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import net.koreate.hellking.chain.dao.ChainDAO;
import net.koreate.hellking.chain.vo.ChainVO;
import net.koreate.hellking.chain.vo.ChainSearchVO;
<<<<<<< HEAD
=======
import net.koreate.hellking.common.service.KakaoMapService;
>>>>>>> b65c320 (Initial commit)
import net.koreate.hellking.common.exception.HellkingException;
import java.util.List;
import java.util.HashMap;
import java.util.Map;
<<<<<<< HEAD
=======
import java.util.stream.Collectors;
import java.util.Comparator;
>>>>>>> b65c320 (Initial commit)

@Service
@Transactional
public class ChainService {
    
    @Autowired
    private ChainDAO chainDAO;
    
<<<<<<< HEAD
    // 전체 가맹점 목록
=======
    @Autowired
    private KakaoMapService kakaoMapService;
    
    // ===== 인근 가맹점 검색 (Java 거리 계산 방식) =====
    
    /**
     * 위치 기반 인근 가맹점 검색 (Oracle 함수 없이 Java에서 거리 계산)
     * @param latitude 검색 기준 위도
     * @param longitude 검색 기준 경도
     * @param radius 검색 반경 (km)
     * @param sortBy 정렬 기준 (distance, rating, name)
     * @return 검색 결과 Map
     */
    public Map<String, Object> searchNearbyChains(double latitude, double longitude, int radius, String sortBy) {
        Map<String, Object> result = new HashMap<>();
        
        try {
            System.out.println("=== 인근 가맹점 검색 시작 (Java 거리 계산) ===");
            System.out.println("검색 위치: " + latitude + ", " + longitude);
            System.out.println("검색 반경: " + radius + "km");
            System.out.println("정렬 기준: " + sortBy);
            
            // DB에서 좌표 정보가 있는 모든 가맹점 조회
            List<ChainVO> allChains = chainDAO.findAllChainsWithCoordinates();
            System.out.println("DB 조회 완료: " + allChains.size() + "개 가맹점");
            
            if (allChains.isEmpty()) {
                result.put("success", true);
                result.put("chains", List.of());
                result.put("totalCount", 0);
                result.put("message", "등록된 가맹점이 없습니다.");
                return result;
            }
            
            // Java에서 거리 계산 및 필터링
            List<ChainVO> nearbyChains = allChains.stream()
                .filter(chain -> {
                    try {
                        // Null 체크
                        if (chain.getLatitude() == null || chain.getLongitude() == null) {
                            System.out.println("좌표 없음: " + chain.getChainName());
                            return false;
                        }
                        
                        // 거리 계산
                        double distance = kakaoMapService.calculateDistance(
                            latitude, longitude, 
                            chain.getLatitude(), chain.getLongitude()
                        );
                        
                        // 거리 정보 설정
                        chain.setDistance(distance);
                        chain.setDistanceText(kakaoMapService.formatDistance(distance));
                        
                        // 반경 내 가맹점만 필터링
                        boolean inRange = distance <= radius;
                        
                        if (inRange) {
                            System.out.println("범위 내 가맹점: " + chain.getChainName() + 
                                             " (" + String.format("%.2f", distance) + "km)");
                        }
                        
                        return inRange;
                        
                    } catch (Exception e) {
                        System.err.println("거리 계산 오류: " + chain.getChainName() + " - " + e.getMessage());
                        return false;
                    }
                })
                .collect(Collectors.toList());
            
            System.out.println("거리 필터링 완료: " + nearbyChains.size() + "개 가맹점");
            
            // 정렬 처리
            nearbyChains = sortChains(nearbyChains, sortBy);
            
            result.put("success", true);
            result.put("chains", nearbyChains);
            result.put("totalCount", nearbyChains.size());
            result.put("message", nearbyChains.size() + "개의 주변 가맹점을 찾았습니다.");
            
            System.out.println("검색 완료: " + nearbyChains.size() + "개 가맹점 반환");
            System.out.println("=======================================");
            
        } catch (Exception e) {
            System.err.println("인근 가맹점 검색 오류: " + e.getMessage());
            e.printStackTrace();
            
            result.put("success", false);
            result.put("chains", List.of());
            result.put("totalCount", 0);
            result.put("message", "검색 중 오류가 발생했습니다: " + e.getMessage());
        }
        
        return result;
    }
    
    /**
     * 가맹점 목록 정렬
     */
    private List<ChainVO> sortChains(List<ChainVO> chains, String sortBy) {
        if ("rating".equals(sortBy)) {
            return chains.stream()
                .sorted(Comparator.comparing(ChainVO::getAvgRating, 
                    Comparator.nullsLast(Comparator.reverseOrder())))
                .collect(Collectors.toList());
        } else if ("name".equals(sortBy)) {
            return chains.stream()
                .sorted(Comparator.comparing(ChainVO::getChainName))
                .collect(Collectors.toList());
        } else {
            // 거리순 정렬 (기본)
            return chains.stream()
                .sorted(Comparator.comparing(ChainVO::getDistance, 
                    Comparator.nullsLast(Comparator.naturalOrder())))
                .collect(Collectors.toList());
        }
    }
    
    // ===== 기본 가맹점 관리 기능들 =====
    
    /**
     * 전체 가맹점 목록
     */
>>>>>>> b65c320 (Initial commit)
    public List<ChainVO> getAllChains() {
        return chainDAO.selectAllChains();
    }
    
<<<<<<< HEAD
    // 가맹점 상세 정보
=======
    /**
     * 가맹점 상세 정보
     */
>>>>>>> b65c320 (Initial commit)
    public ChainVO getChainDetail(Long chainNum) {
        ChainVO chain = chainDAO.selectByChainNum(chainNum);
        if (chain == null) {
            throw new HellkingException("존재하지 않는 가맹점입니다.");
        }
        return chain;
    }
    
<<<<<<< HEAD
    // 가맹점 코드로 조회
=======
    /**
     * 가맹점 코드로 조회
     */
>>>>>>> b65c320 (Initial commit)
    public ChainVO getChainByCode(String chainCode) {
        ChainVO chain = chainDAO.selectByChainCode(chainCode);
        if (chain == null) {
            throw new HellkingException("존재하지 않는 가맹점 코드입니다: " + chainCode);
        }
        return chain;
    }
    
<<<<<<< HEAD
    // 가맹점 검색 - 수정된 버전
    public Map<String, Object> searchChains(ChainSearchVO searchVO) {
        searchVO.setDefaults();
        
        // DAO 호출 시 3개 파라미터만 전달
=======
    /**
     * 가맹점 검색
     */
    public Map<String, Object> searchChains(ChainSearchVO searchVO) {
        searchVO.setDefaults();
        
>>>>>>> b65c320 (Initial commit)
        List<ChainVO> chains = chainDAO.searchChains(
            searchVO.getKeyword(), 
            searchVO.getOffset(), 
            searchVO.getSize()
        );
        
        int totalCount = chainDAO.countSearchResults(searchVO.getKeyword());
        int totalPages = (int) Math.ceil((double) totalCount / searchVO.getSize());
        
        Map<String, Object> result = new HashMap<>();
        result.put("chains", chains);
        result.put("currentPage", searchVO.getPage());
        result.put("totalPages", totalPages);
        result.put("totalCount", totalCount);
        result.put("hasNext", searchVO.getPage() < totalPages);
        result.put("hasPrev", searchVO.getPage() > 1);
        
<<<<<<< HEAD
        System.out.println("=== ChainService.searchChains 결과 ===");
        System.out.println("검색어: " + searchVO.getKeyword());
        System.out.println("검색 결과 수: " + chains.size());
        System.out.println("총 개수: " + totalCount);
        if (!chains.isEmpty()) {
            System.out.println("첫 번째 결과: " + chains.get(0).getChainName());
        }
        System.out.println("=====================================");
        
        return result;
    }
    
    // 지역별 가맹점
=======
        return result;
    }
    
    /**
     * 지역별 가맹점
     */
>>>>>>> b65c320 (Initial commit)
    public List<ChainVO> getChainsByRegion(String region) {
        return chainDAO.selectByRegion(region);
    }
    
<<<<<<< HEAD
    // 인기 가맹점
=======
    /**
     * 인기 가맹점 (리뷰 수 기준)
     */
>>>>>>> b65c320 (Initial commit)
    public List<ChainVO> getPopularChains(int limit) {
        return chainDAO.selectPopularChains(limit);
    }
    
<<<<<<< HEAD
    // 최고 평점 가맹점
=======
    /**
     * 최고 평점 가맹점
     */
>>>>>>> b65c320 (Initial commit)
    public List<ChainVO> getTopRatedChains(int limit) {
        return chainDAO.selectTopRatedChains(limit);
    }
    
<<<<<<< HEAD
    // 메인 페이지용 추천 가맹점
=======
    /**
     * 메인 페이지용 추천 가맹점
     */
>>>>>>> b65c320 (Initial commit)
    public Map<String, Object> getRecommendedChains() {
        Map<String, Object> result = new HashMap<>();
        result.put("popular", getPopularChains(6));
        result.put("topRated", getTopRatedChains(6));
        return result;
    }
    
<<<<<<< HEAD
    // 가맹점 등록 (관리자용)
    public boolean registerChain(ChainVO chain, String chainCode) {
        try {
=======
    /**
     * 특정 위치 근처의 추천 가맹점 (평점과 거리를 고려한 점수 기반)
     */
    public List<ChainVO> getRecommendedNearbyChains(double latitude, double longitude, int limit) {
        try {
            List<ChainVO> allChains = chainDAO.findAllChainsWithCoordinates();
            
            return allChains.stream()
                .filter(chain -> chain.hasCoordinates())
                .map(chain -> {
                    // 거리 계산
                    double distance = kakaoMapService.calculateDistance(
                        latitude, longitude, 
                        chain.getLatitude(), chain.getLongitude()
                    );
                    chain.setDistance(distance);
                    
                    // 추천 점수 계산 (평점 높고, 거리 가까울수록 높은 점수)
                    double rating = chain.getAvgRating() != null ? chain.getAvgRating() : 3.0;
                    double score = (rating * 2) - (distance * 0.3);
                    chain.setDistance(score); // 임시로 distance 필드에 점수 저장
                    
                    return chain;
                })
                .filter(chain -> chain.getDistance() > 0) // 점수가 양수인 것만
                .sorted(Comparator.comparing(ChainVO::getDistance, Comparator.reverseOrder()))
                .limit(limit)
                .collect(Collectors.toList());
                
        } catch (Exception e) {
            System.err.println("추천 가맹점 조회 오류: " + e.getMessage());
            return List.of();
        }
    }
    
    // ===== 관리자 기능들 =====
    
    /**
     * 가맹점 등록 (좌표 자동 변환 포함)
     */
    @Transactional
    public boolean registerChain(ChainVO chain, String chainCode) {
        try {
            // 주소가 있고 좌표가 없는 경우 자동 변환 시도
            if (chain.getAddress() != null && !chain.hasCoordinates()) {
                try {
                    Map<String, Double> coordinates = kakaoMapService.addressToCoordinates(chain.getAddress());
                    if (coordinates != null) {
                        chain.setLatitude(coordinates.get("latitude"));
                        chain.setLongitude(coordinates.get("longitude"));
                        System.out.println("주소 자동 변환: " + chain.getAddress() + 
                                         " -> " + chain.getLatitude() + ", " + chain.getLongitude());
                    }
                } catch (Exception e) {
                    System.err.println("주소 변환 실패: " + e.getMessage());
                }
            }
            
>>>>>>> b65c320 (Initial commit)
            int result = chainDAO.insertChain(chain);
            if (result > 0 && chain.getChainNum() != null) {
                chainDAO.insertChainCode(chain.getChainNum(), chainCode);
                return true;
            }
            return false;
        } catch (Exception e) {
            throw new HellkingException("가맹점 등록 중 오류가 발생했습니다: " + e.getMessage());
        }
    }
    
<<<<<<< HEAD
    // 가맹점 수정 (관리자용)
    public boolean updateChain(ChainVO chain) {
        try {
=======
    /**
     * 가맹점 수정
     */
    @Transactional
    public boolean updateChain(ChainVO chain) {
        try {
            // 주소가 변경되고 좌표가 없는 경우 자동 변환 시도
            if (chain.getAddress() != null && !chain.hasCoordinates()) {
                try {
                    Map<String, Double> coordinates = kakaoMapService.addressToCoordinates(chain.getAddress());
                    if (coordinates != null) {
                        chain.setLatitude(coordinates.get("latitude"));
                        chain.setLongitude(coordinates.get("longitude"));
                        System.out.println("주소 자동 변환: " + chain.getAddress());
                    }
                } catch (Exception e) {
                    System.err.println("주소 변환 실패: " + e.getMessage());
                }
            }
            
>>>>>>> b65c320 (Initial commit)
            return chainDAO.updateChain(chain) > 0;
        } catch (Exception e) {
            throw new HellkingException("가맹점 정보 수정 중 오류가 발생했습니다: " + e.getMessage());
        }
    }
    
<<<<<<< HEAD
    // 가맹점 삭제 (관리자용)
=======
    /**
     * 가맹점 삭제
     */
>>>>>>> b65c320 (Initial commit)
    @Transactional
    public boolean deleteChain(Long chainNum) {
        try {
            chainDAO.deleteChainCode(chainNum);
            return chainDAO.deleteChain(chainNum) > 0;
        } catch (Exception e) {
            throw new HellkingException("가맹점 삭제 중 오류가 발생했습니다: " + e.getMessage());
        }
    }
    
<<<<<<< HEAD
    // 통계 정보
=======
    /**
     * 좌표 정보 일괄 업데이트 (관리자용 배치 작업)
     */
    @Transactional
    public Map<String, Object> updateAllCoordinates() {
        List<ChainVO> chainsWithoutCoords = chainDAO.selectChainsWithoutCoordinates();
        int successCount = 0;
        int failCount = 0;
        
        for (ChainVO chain : chainsWithoutCoords) {
            try {
                Map<String, Double> coordinates = kakaoMapService.addressToCoordinates(chain.getAddress());
                if (coordinates != null) {
                    chainDAO.updateCoordinates(
                        chain.getChainNum(), 
                        coordinates.get("latitude"), 
                        coordinates.get("longitude")
                    );
                    successCount++;
                    System.out.println("좌표 업데이트 성공: " + chain.getChainName());
                } else {
                    failCount++;
                    System.out.println("좌표 변환 실패: " + chain.getChainName() + " - " + chain.getAddress());
                }
                
                // API 호출 제한 방지를 위한 지연
                Thread.sleep(100);
                
            } catch (Exception e) {
                failCount++;
                System.err.println("좌표 업데이트 오류: " + chain.getChainName() + " - " + e.getMessage());
            }
        }
        
        Map<String, Object> result = new HashMap<>();
        result.put("totalProcessed", chainsWithoutCoords.size());
        result.put("successCount", successCount);
        result.put("failCount", failCount);
        result.put("message", String.format("총 %d개 가맹점 중 %d개 성공, %d개 실패", 
                                           chainsWithoutCoords.size(), successCount, failCount));
        
        return result;
    }
    
    /**
     * 통계 정보
     */
>>>>>>> b65c320 (Initial commit)
    public Map<String, Object> getStatistics() {
        Map<String, Object> stats = new HashMap<>();
        stats.put("totalChains", chainDAO.getTotalChainCount());
        stats.put("totalRegions", chainDAO.getTotalRegionCount());
<<<<<<< HEAD
        return stats;
    }
    
    // 가맹점 코드 유효성 검사
=======
        stats.put("chainsWithCoordinates", chainDAO.getChainsWithCoordinatesCount());
        return stats;
    }
    
    /**
     * 가맹점 코드 유효성 검사
     */
>>>>>>> b65c320 (Initial commit)
    public boolean isValidChainCode(String chainCode) {
        if (chainCode == null || chainCode.length() != 4) {
            return false;
        }
        try {
            ChainVO chain = chainDAO.selectByChainCode(chainCode);
            return chain != null;
        } catch (Exception e) {
            return false;
        }
    }
<<<<<<< HEAD
=======
    
    /**
     * 평점순 정렬과 페이징이 적용된 가맹점 목록 조회
     * @param sortBy 정렬 기준 (rating_desc, rating_asc, review_desc, review_asc, name, latest)
     * @param page 페이지 번호 (1부터 시작)
     * @param size 페이지당 가맹점 수
     * @return 페이징 정보가 포함된 결과 Map
     */
    public Map<String, Object> getChainsWithRatingSort(String sortBy, int page, int size) {
        // 기본값 설정
        if (sortBy == null || sortBy.trim().isEmpty()) {
            sortBy = "rating_desc"; // 기본: 평점 높은 순
        }
        if (page < 1) page = 1;
        if (size < 1 || size > 50) size = 6; // 기본값 6개, 최대 50개
        
        int offset = (page - 1) * size;
        
        // 가맹점 목록 조회
        List<ChainVO> chains = chainDAO.selectChainsByRatingWithPaging(sortBy, offset, size);
        
        // 총 개수 조회 (정렬 기준에 따라 다르게)
        int totalCount;
        if ("rating_desc".equals(sortBy) || "rating_asc".equals(sortBy)) {
            // 평점순 정렬시 평점이 있는 가맹점만 카운트
            totalCount = chainDAO.getTotalChainsWithRatingCount();
        } else {
            // 나머지는 전체 가맹점 수
            totalCount = chainDAO.getTotalChainsCount();
        }
        
        // 페이징 정보 계산
        int totalPages = (int) Math.ceil((double) totalCount / size);
        boolean hasNext = page < totalPages;
        boolean hasPrev = page > 1;
        
        // 결과 Map 구성
        Map<String, Object> result = new HashMap<>();
        result.put("chains", chains);
        result.put("currentPage", page);
        result.put("totalPages", totalPages);
        result.put("totalCount", totalCount);
        result.put("pageSize", size);
        result.put("hasNext", hasNext);
        result.put("hasPrev", hasPrev);
        result.put("sortBy", sortBy);
        
        return result;
    }

    /**
     * 검색어와 평점순 정렬이 적용된 가맹점 검색
     * @param keyword 검색어
     * @param sortBy 정렬 기준
     * @param page 페이지 번호
     * @param size 페이지당 가맹점 수
     * @return 검색 결과와 페이징 정보
     */
    public Map<String, Object> searchChainsWithSort(String keyword, String sortBy, int page, int size) {
        // 기본값 설정
        if (sortBy == null || sortBy.trim().isEmpty()) {
            sortBy = "rating_desc";
        }
        if (page < 1) page = 1;
        if (size < 1 || size > 50) size = 6;
        
        int offset = (page - 1) * size;
        
        // 검색어가 비어있으면 null로 처리 (SQL에서 조건 무시)
        String searchKeyword = (keyword != null && !keyword.trim().isEmpty()) ? keyword.trim() : null;
        
        // 검색 결과 조회
        List<ChainVO> chains = chainDAO.searchChainsWithRatingSort(searchKeyword, sortBy, offset, size);
        
        // 검색 결과 총 개수
        int totalCount = chainDAO.countSearchChainsTotal(searchKeyword);
        
        // 페이징 정보 계산
        int totalPages = (int) Math.ceil((double) totalCount / size);
        
        Map<String, Object> result = new HashMap<>();
        result.put("chains", chains);
        result.put("currentPage", page);
        result.put("totalPages", totalPages);
        result.put("totalCount", totalCount);
        result.put("pageSize", size);
        result.put("hasNext", page < totalPages);
        result.put("hasPrev", page > 1);
        result.put("sortBy", sortBy);
        result.put("keyword", searchKeyword);
        
        return result;
    }

    /**
     * 페이지 네비게이션 정보 생성
     * @param currentPage 현재 페이지
     * @param totalPages 전체 페이지 수
     * @param displayPageNum 표시할 페이지 번호 개수 (기본 5개)
     * @return 페이지 네비게이션 정보
     */
    public Map<String, Object> createPageNavigation(int currentPage, int totalPages, int displayPageNum) {
        if (displayPageNum < 1) displayPageNum = 5;
        
        // 시작 페이지와 끝 페이지 계산
        int startPage = ((currentPage - 1) / displayPageNum) * displayPageNum + 1;
        int endPage = Math.min(startPage + displayPageNum - 1, totalPages);
        
        Map<String, Object> navigation = new HashMap<>();
        navigation.put("startPage", startPage);
        navigation.put("endPage", endPage);
        navigation.put("currentPage", currentPage);
        navigation.put("totalPages", totalPages);
        navigation.put("hasPrevBlock", startPage > 1);
        navigation.put("hasNextBlock", endPage < totalPages);
        navigation.put("prevBlockStart", Math.max(startPage - displayPageNum, 1));
        navigation.put("nextBlockStart", Math.min(endPage + 1, totalPages));
        
        return navigation;
    }

    /**
     * 정렬 옵션 검증 및 기본값 처리
     * @param sortBy 요청된 정렬 기준
     * @return 유효한 정렬 기준
     */
    public String validateSortBy(String sortBy) {
        if (sortBy == null || sortBy.trim().isEmpty()) {
            return "rating_desc";
        }
        
        // 허용된 정렬 기준들
        String[] validSortOptions = {
            "rating_desc", "rating_asc", 
            "review_desc", "review_asc", 
            "name", "latest"
        };
        
        String trimmed = sortBy.trim().toLowerCase();
        for (String valid : validSortOptions) {
            if (valid.equals(trimmed)) {
                return trimmed;
            }
        }
        
        // 유효하지 않은 경우 기본값 반환
        return "rating_desc";
    }

    /**
     * 정렬 기준에 대한 한글 설명 반환
     * @param sortBy 정렬 기준
     * @return 한글 설명
     */
    public String getSortByDescription(String sortBy) {
        switch (sortBy) {
            case "rating_desc": return "평점 높은순";
            case "rating_asc": return "평점 낮은순";
            case "review_desc": return "리뷰 많은순";
            case "review_asc": return "리뷰 적은순";
            case "name": return "가맹점명순";
            case "latest": return "최신 등록순";
            default: return "평점 높은순";
        }
    }
>>>>>>> b65c320 (Initial commit)
}