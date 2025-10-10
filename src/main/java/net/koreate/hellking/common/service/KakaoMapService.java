package net.koreate.hellking.common.service;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import java.util.HashMap;
import java.util.Map;

@Service
public class KakaoMapService {
    
    @Value("${kakao.map.rest-api-key}")
    private String restApiKey;
    
    private final RestTemplate restTemplate = new RestTemplate();
    private final ObjectMapper objectMapper = new ObjectMapper();
    
    /**
     * 주소를 좌표로 변환 (Geocoding)
     */
    public Map<String, Double> addressToCoordinates(String address) {
        try {
            String url = "https://dapi.kakao.com/v2/local/search/address.json?query=" + 
                        java.net.URLEncoder.encode(address, "UTF-8");
            
            HttpHeaders headers = new HttpHeaders();
            headers.set("Authorization", "KakaoAK " + restApiKey);
            
            HttpEntity<String> entity = new HttpEntity<>(headers);
            ResponseEntity<String> response = restTemplate.exchange(url, HttpMethod.GET, entity, String.class);
            
            JsonNode root = objectMapper.readTree(response.getBody());
            JsonNode documents = root.path("documents");
            
            if (documents.isArray() && documents.size() > 0) {
                JsonNode firstResult = documents.get(0);
                double latitude = firstResult.path("y").asDouble();
                double longitude = firstResult.path("x").asDouble();
                
                Map<String, Double> coordinates = new HashMap<>();
                coordinates.put("latitude", latitude);
                coordinates.put("longitude", longitude);
                return coordinates;
            }
            
        } catch (Exception e) {
            System.err.println("주소 변환 오류: " + e.getMessage());
        }
        
        return null;
    }
    
    /**
     * 좌표를 주소로 변환 (Reverse Geocoding)
     */
    public String coordinatesToAddress(double latitude, double longitude) {
        try {
            String url = String.format("https://dapi.kakao.com/v2/local/geo/coord2address.json?x=%f&y=%f", 
                                     longitude, latitude);
            
            HttpHeaders headers = new HttpHeaders();
            headers.set("Authorization", "KakaoAK " + restApiKey);
            
            HttpEntity<String> entity = new HttpEntity<>(headers);
            ResponseEntity<String> response = restTemplate.exchange(url, HttpMethod.GET, entity, String.class);
            
            JsonNode root = objectMapper.readTree(response.getBody());
            JsonNode documents = root.path("documents");
            
            if (documents.isArray() && documents.size() > 0) {
                JsonNode address = documents.get(0).path("address");
                return address.path("address_name").asText();
            }
            
        } catch (Exception e) {
            System.err.println("좌표 변환 오류: " + e.getMessage());
        }
        
        return "주소 정보 없음";
    }
    
    /**
     * 두 좌표 간의 거리 계산 (Haversine formula, km 단위)
     */
    public double calculateDistance(double lat1, double lng1, double lat2, double lng2) {
        final double EARTH_RADIUS = 6371.0; // 지구 반지름 (km)
        
        double dLat = Math.toRadians(lat2 - lat1);
        double dLng = Math.toRadians(lng2 - lng1);
        
        double a = Math.sin(dLat/2) * Math.sin(dLat/2) +
                   Math.cos(Math.toRadians(lat1)) * Math.cos(Math.toRadians(lat2)) *
                   Math.sin(dLng/2) * Math.sin(dLng/2);
        
        double c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1-a));
        
        return EARTH_RADIUS * c;
    }
    
    /**
     * 거리 텍스트 포맷팅
     */
    public String formatDistance(double distance) {
        if (distance < 1) {
            return String.format("%.0fm", distance * 1000);
        } else {
            return String.format("%.1fkm", distance);
        }
    }
    
    /**
     * 키워드로 장소 검색
     */
    public Map<String, Object> searchPlaces(String keyword, double latitude, double longitude, int radius) {
        try {
            String url = String.format("https://dapi.kakao.com/v2/local/search/keyword.json?query=%s&x=%f&y=%f&radius=%d", 
                                     java.net.URLEncoder.encode(keyword, "UTF-8"), longitude, latitude, radius * 1000);
            
            HttpHeaders headers = new HttpHeaders();
            headers.set("Authorization", "KakaoAK " + restApiKey);
            
            HttpEntity<String> entity = new HttpEntity<>(headers);
            ResponseEntity<String> response = restTemplate.exchange(url, HttpMethod.GET, entity, String.class);
            
            JsonNode root = objectMapper.readTree(response.getBody());
            
            Map<String, Object> result = new HashMap<>();
            result.put("success", true);
            result.put("documents", root.path("documents"));
            result.put("meta", root.path("meta"));
            
            return result;
            
        } catch (Exception e) {
            System.err.println("장소 검색 오류: " + e.getMessage());
            Map<String, Object> result = new HashMap<>();
            result.put("success", false);
            result.put("message", "장소 검색 중 오류가 발생했습니다.");
            return result;
        }    
    }
}