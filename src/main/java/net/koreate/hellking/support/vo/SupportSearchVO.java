package net.koreate.hellking.support.vo;

import lombok.Data;

@Data
public class SupportSearchVO {
    private String searchType;   // "title", "content", "all", "author" 등
    private String searchKeyword;
    private String status;       // 상태 필터
    private String dateFrom;     // 시작일
    private String dateTo;       // 종료일
    private int page = 1;        // 현재 페이지
    private int pageSize = 10;   // 페이지 크기
    private String sortBy = "created_at"; // 정렬 기준
    private String sortOrder = "DESC";    // 정렬 순서
    
    // 페이징 계산용
    public int getOffset() {
        return (page - 1) * pageSize;
    }
    
    public boolean hasSearch() {
        return searchKeyword != null && !searchKeyword.trim().isEmpty();
    }
    
    public boolean hasDateRange() {
        return (dateFrom != null && !dateFrom.trim().isEmpty()) ||
               (dateTo != null && !dateTo.trim().isEmpty());
    }
    
    // 유효성 검사 메서드들 추가
    public boolean isValidSearchType() {
        if (searchType == null) return true;
        
        return "title".equals(searchType) || 
               "content".equals(searchType) || 
               "author".equals(searchType) || 
               "all".equals(searchType);
    }
    
    public boolean isValidStatus() {
        if (status == null || status.trim().isEmpty()) return true;
        
        return "ACTIVE".equals(status) || 
               "COMPLETED".equals(status) || 
               "DELETED".equals(status);
    }
    
    // 페이지 번호 유효성 검사
    public void validatePage() {
        if (page < 1) {
            page = 1;
        }
    }
    
    // 페이지 크기 유효성 검사
    public void validatePageSize() {
        if (pageSize < 1) {
            pageSize = 10;
        }
        if (pageSize > 100) {
            pageSize = 100;
        }
    }
    
    // 검색어 정리
    public void trimSearchKeyword() {
        if (searchKeyword != null) {
            searchKeyword = searchKeyword.trim();
            if (searchKeyword.isEmpty()) {
                searchKeyword = null;
            }
        }
    }
    
    // 전체 유효성 검사 수행
    public void validate() {
        validatePage();
        validatePageSize();
        trimSearchKeyword();
    }
}