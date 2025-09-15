package net.koreate.hellking.common.util;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.ToString;

/**
 * 요청 페이지에 따라 table에서 행 정보를 
 * 검색할 기준 정보를 저장하는 class
 */
@AllArgsConstructor
@ToString
@Getter
public class Criteria {
	
	private int page;				// 요청 페이지 번호
	private int perPageNum;			// 한페이지에 출력할 게시글(행) 수

	public Criteria() {
		this(1, 10);
	}
	
	
	public void setPage(int page) {
		if(page <= 0) {
			this.page = 1;
			return;
		}
		this.page = page;
	}
	
	public void setPerPageNum(int perPageNum) {
		if(perPageNum <= 0 || perPageNum > 100) {
			this.perPageNum = 10;
			return;
		}
		this.perPageNum = perPageNum;
	}
	
	/**
	 * @return - 테이블 검색 시작 인덱스 번호(요청 페이지에 따라 반환)
	 */
	public int getStartRow() {
		return (this.page - 1) * this.perPageNum;
	}
	
}
