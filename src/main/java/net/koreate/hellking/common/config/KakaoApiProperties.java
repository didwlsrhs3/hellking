package net.koreate.hellking.common.config;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;
import lombok.Data;

/**
 * 카카오 API 관련 설정을 관리하는 클래스 (Spring Framework용)
 */
@Component
@Data
public class KakaoApiProperties {
    
    @Value("${kakao.map.api-key:}")
    private String apiKey;           // JavaScript용 API 키
    
    @Value("${kakao.map.rest-api-key:}")
    private String restApiKey;       // REST API 키
    
    @Value("${kakao.map.admin-key:}")
    private String adminKey;         // Admin 키 (필요시)
    
    // 기본 지도 설정
    @Value("${map.default.latitude:37.5665}")
    private Double defaultLatitude;
    
    @Value("${map.default.longitude:126.9780}")
    private Double defaultLongitude;
    
    @Value("${map.default.zoom:3}")
    private Integer defaultZoom;
    
    // API 호출 제한 설정
    @Value("${kakao.map.request-timeout:5000}")
    private Integer requestTimeout;
    
    @Value("${kakao.map.max-retry-attempts:3}")
    private Integer maxRetryAttempts;
    
    @Value("${kakao.map.retry-delay:1000}")
    private Long retryDelay;
    
    // 거리 계산 설정
    @Value("${kakao.map.max-search-radius:50}")
    private Integer maxSearchRadius;  // 최대 검색 반경 (km)
    
    @Value("${kakao.map.default-radius:10}")
    private Integer defaultRadius;    // 기본 검색 반경 (km)
    
    public boolean isConfigured() {
        return apiKey != null && !apiKey.trim().isEmpty() &&
               restApiKey != null && !restApiKey.trim().isEmpty();
    }
}