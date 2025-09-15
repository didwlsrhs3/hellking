package net.koreate.hellking.chain.vo;

import lombok.Data;

@Data
public class ChainSearchVO {
    private String keyword;      // 검색어
    private String region;       // 지역 필터
    private String sortBy;       // 정렬 기준 (distance, rating, name)
    private Double latitude;     // 현재 위치 위도
    private Double longitude;    // 현재 위치 경도
    private Integer radius;      // 검색 반경 (km)
    
    // 페이징
    private int page = 1;
    private int size = 12;
    private int offset;
    
    public int getOffset() {
        return (page - 1) * size;
    }
    
    public void setDefaults() {
        if (sortBy == null) sortBy = "name";
        if (radius == null) radius = 10;
    }
}