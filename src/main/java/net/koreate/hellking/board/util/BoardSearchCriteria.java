package net.koreate.hellking.board.util;

import lombok.Data;
import lombok.ToString;

@Data
@ToString
public class BoardSearchCriteria extends BoardCriteria {
    
    private String searchType;  // 검색 카테고리 (bno, title, nickname, regdate)
    private String keyword;     // 검색어
    
}
