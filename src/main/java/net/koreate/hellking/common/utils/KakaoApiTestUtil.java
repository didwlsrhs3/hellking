package net.koreate.hellking.common.utils;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import net.koreate.hellking.common.service.KakaoMapService;
import net.koreate.hellking.chain.service.ChainService;
import javax.annotation.PostConstruct;
import java.util.Map;

/**
 * 카카오 API 테스트 및 유틸리티 클래스
 * 개발/운영 환경에서 API 상태를 확인하고 테스트하는데 사용
 */
@Component
public class KakaoApiTestUtil {
    
    @Autowired
    private KakaoMapService kakaoMapService;
    
    @Autowired
    private ChainService chainService;
    
    /**
     * 애플리케이션 시작 시 카카오 API 연결 테스트
     */
    @PostConstruct
    public void initTest() {
        System.out.println("=== 카카오 API 초기화 테스트 ===");
        
        // 간단한 주소 변환 테스트
        testGeocoding();
        
        // 거리 계산 테스트
        testDistanceCalculation();
        
        System.out.println("==============================");
    }
    
    /**
     * 주소 → 좌표 변환 테스트
     */
    public void testGeocoding() {
        try {
            String testAddress = "서울특별시 중구 세종대로 110"; // 서울시청
            Map<String, Double> coordinates = kakaoMapService.addressToCoordinates(testAddress);
            
            if (coordinates != null) {
                System.out.println("✅ 지오코딩 테스트 성공");
                System.out.println("   주소: " + testAddress);
                System.out.println("   좌표: " + coordinates.get("latitude") + ", " + coordinates.get("longitude"));
            } else {
                System.out.println("❌ 지오코딩 테스트 실패: 좌표 변환 결과 없음");
            }
        } catch (Exception e) {
            System.out.println("❌ 지오코딩 테스트 오류: " + e.getMessage());
        }
    }
    
    /**
     * 거리 계산 테스트
     */
    public void testDistanceCalculation() {
        try {
            // 서울시청 → 강남역 거리 (약 7.5km)
            double distance = kakaoMapService.calculateDistance(
                37.5665, 126.9780,  // 서울시청
                37.4979, 127.0276   // 강남역
            );
            
            System.out.println("✅ 거리 계산 테스트 성공");
            System.out.println("   서울시청 ↔ 강남역: " + kakaoMapService.formatDistance(distance));
            
        } catch (Exception e) {
            System.out.println("❌ 거리 계산 테스트 오류: " + e.getMessage());
        }
    }
    
    /**
     * 인근 가맹점 검색 테스트 (관리자 기능)
     */
    public Map<String, Object> testNearbySearch(double latitude, double longitude, int radius) {
        System.out.println("=== 인근 가맹점 검색 테스트 ===");
        System.out.println("위치: " + latitude + ", " + longitude);
        System.out.println("반경: " + radius + "km");
        
        try {
            Map<String, Object> result = chainService.searchNearbyChains(latitude, longitude, radius, "distance");
            
            System.out.println("검색 결과: " + result);
            System.out.println("=============================");
            
            return result;
        } catch (Exception e) {
            System.out.println("❌ 검색 테스트 오류: " + e.getMessage());
            return Map.of("success", false, "message", e.getMessage());
        }
    }
    
    /**
     * API 응답 시간 측정
     */
    public long measureApiResponseTime(String address) {
        long startTime = System.currentTimeMillis();
        
        try {
            kakaoMapService.addressToCoordinates(address);
        } catch (Exception e) {
            System.out.println("API 호출 오류: " + e.getMessage());
        }
        
        long endTime = System.currentTimeMillis();
        long responseTime = endTime - startTime;
        
        System.out.println("API 응답 시간: " + responseTime + "ms");
        return responseTime;
    }
    
    /**
     * 여러 주소에 대한 배치 테스트
     */
    public void batchGeocodingTest() {
        String[] testAddresses = {
            "서울특별시 강남구 테헤란로 123",
            "서울특별시 마포구 홍익로 456", 
            "서울특별시 송파구 잠실동 789",
            "부산광역시 해운대구 해운대로 321",
            "대구광역시 수성구 범어동 654"
        };
        
        System.out.println("=== 배치 지오코딩 테스트 ===");
        
        for (String address : testAddresses) {
            try {
                Map<String, Double> coordinates = kakaoMapService.addressToCoordinates(address);
                if (coordinates != null) {
                    System.out.println("✅ " + address + " → " + 
                        coordinates.get("latitude") + ", " + coordinates.get("longitude"));
                } else {
                    System.out.println("❌ " + address + " → 변환 실패");
                }
                
                // API 호출 제한을 피하기 위한 지연
                Thread.sleep(100);
                
            } catch (Exception e) {
                System.out.println("❌ " + address + " → 오류: " + e.getMessage());
            }
        }
        
        System.out.println("===========================");
    }
    
    /**
     * 설정 값 검증
     */
    public boolean validateConfiguration() {
        // API 키 설정 확인
        try {
            Map<String, Double> testResult = kakaoMapService.addressToCoordinates("서울시청");
            return testResult != null;
        } catch (Exception e) {
            System.err.println("카카오 API 설정 오류: " + e.getMessage());
            return false;
        }
    }
}