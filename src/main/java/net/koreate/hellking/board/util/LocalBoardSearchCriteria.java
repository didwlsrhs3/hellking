package net.koreate.hellking.board.util;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class LocalBoardSearchCriteria extends BoardCriteria {

    // 검색 조건 (제목, 작성자 등)
    private String searchType;
    private String keyword;

    // 지역 카테고리 ID
    private Integer categoryId;

    public LocalBoardSearchCriteria() {
        super();
        this.searchType = null;
        this.keyword = null;
        this.categoryId = 0; // 기본값: 전체 지역
    }
}
