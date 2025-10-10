package net.koreate.hellking.board.util;

import lombok.Getter;
import lombok.ToString;

@Getter
@ToString	
public class BoardPageMaker {
	
	private int totalCount;		// 전체 게시물 개수
	private BoardCriteria cri;		// 요청 정보를 저장하는 class
	private int displayPageNum;	// 한 페이지 블럭에 출력할 페이지 번호 개수
	
	// 계산된 결과를 저장할 필드
	private int startPage;			// 출력 시작 페이지 번호
	private int endPage;			// 출력 마지막 페이지 번호
	private int maxPage;			// 이동 가능한 최대 페이지 번호
	
	// 페이지 블럭 이동 가능 여부를 저장할 변수
	private boolean first, last, prev, next;
	
	public void calc() {
		if(cri == null) cri = new BoardCriteria();
		// 페이지 번호 출력에 필요한 정보를 가지고 연산된 결과를 도출할 메서드
		
		endPage = (int)(Math.ceil(cri.getPage() / (double)displayPageNum) * displayPageNum);
		
		startPage = (endPage - displayPageNum) + 1;
		
		maxPage = (int)Math.ceil(totalCount / (double)cri.getPerPageNum());
		
		if(endPage > maxPage){
			endPage = maxPage;
		}
		
		first = (cri.getPage() != 1) ? true : false;
		last = (cri.getPage() != maxPage) ? true : false;
		prev = cri.getPage() > 1;
		next = cri.getPage() < maxPage;

		
	} // end calc()

	public void setTotalCount(int totalCount) {
		this.totalCount = totalCount;
		calc();
	}


	public void setCri(BoardCriteria cri2) {
		this.cri = cri2;
		calc();
	}


	public void setDisplayPageNum(int displayPageNum) {
		this.displayPageNum = displayPageNum;
		calc();
	}
	
}
