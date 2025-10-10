package net.koreate.hellking.board.util;

import lombok.Getter;
import lombok.ToString;

@Getter
@ToString
public class BoardCriteria {

    private Integer page;        // 요청 페이지 번호
    private Integer perPageNum;  // 한 페이지에 출력할 게시글 수

    public BoardCriteria() {
        this.page = 1;
        this.perPageNum = 10;
    }

    public void setPage(Integer page) {
        if (page == null || page <= 0) {
            this.page = 1;
        } else {
            this.page = page;
        }
    }

    public void setPerPageNum(Integer perPageNum) {
        if (perPageNum == null || perPageNum <= 0 || perPageNum > 100) {
            this.perPageNum = 10;
        } else {
            this.perPageNum = perPageNum;
        }
    }

    /**
     * @return 테이블 검색 시작 인덱스
     */
    public int getStartRow() {
        return (this.page - 1) * this.perPageNum;
    }
}
