package net.koreate.hellking.board.service;

import java.util.List;

import net.koreate.hellking.board.vo.BoardVO;
import net.koreate.hellking.common.util.Criteria;
import net.koreate.hellking.common.util.PageMaker;

public interface BoardService {
	
	/**
	 * 게시글 등록 요청 처리 - 성공 여부에 따라 메세지 전달
	 * @param board - 게시글 등록에 필요한 정보
	 * @return 게시글 등록 성공 여부 메세지
	 * @throws Exception - 처리 중 발생한 예외
	 */
	String regist(BoardVO board) throws Exception;
	
	/**
	 * 게시글 상세보기 시 조회 수 증가
	 * @param bno - 상세보기 요청 게시글 번호
	 */
	void updateCnt(int bno) throws Exception;
	
	
	/**
	 * 게시글 상세 보기 요청 시
	 * @param bno - 상세보기 페이지에서 출력할 게시글 번호
	 * @return 상세보기 요청한 게시글 상세 정보
	 */
	BoardVO read(int bno) throws Exception;
	
	/**
	 * 게시글 수정 요청처리
	 * @param board - 게시글 수정 데이터(bno,title,content,writer)
	 * @return - 게시글 수정 완료 여부 메세지 
	 */
	String modify(BoardVO board) throws Exception;

	/**
	 * 게시글 삭제 요청 처리
	 * @param bno - 삭제 요청 게시글 번호
	 * @return - 삭제요청 처리 완료 여부 메세지
	 */
	String remove(int bno) throws Exception;
	
	/**
	 * 페이징 처리된 게시글 목록  
	 * @param cri - 페이징된 게시글 행정보를 검색하기 위한 기준 데이터
	 * @return - 페이지 처리된 게시글 행정보를 저장하는 List
	 */
	List<BoardVO> listCriteria(Criteria cri) throws Exception;
	
	/**
	 * 페이징 블럭 정보
	 * @param cri - 페이징 블럭 계산에 필요한 정보
	 * @return 페이징 번호 출력을 위한 계산된 정보를 저장하고 있는 PageMaker 반환
	 */
	PageMaker getPageMaker(Criteria cri) throws Exception;
	
	/**
	 * 추천수가 일정 기준 이상인 인기 게시글 목록을 조회합니다.
	 *
	 * @return 추천수 20 이상인 게시글 리스트 (최신순 정렬)
	 */
	List<BoardVO> getHotBoard(int HotAgree) throws Exception;
	
	/**
	 * 추천 수 증가 
	 * @param bno
	 * @throws Exception
	 */
	void plusAgree(int bno) throws Exception;
	
	/**
	 * 추천 수 증가 실시간 조회
	 */
	int AgreeCount(int bno) throws Exception;
	
	
}
