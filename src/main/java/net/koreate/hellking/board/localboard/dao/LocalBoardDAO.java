package net.koreate.hellking.board.localboard.dao;

import java.util.List;

import net.koreate.hellking.board.localboard.vo.LocalBoardVO;
import net.koreate.hellking.common.util.Criteria;

public interface LocalBoardDAO {
	
	/**
	 * @param board - 게시글 등록에 필요한 정보
	 * @return - 테이블에 삽입된 행의 개수
	 */
	int create(LocalBoardVO board) throws Exception;
	
	/**
	 * @param bno - 조회할 게시글 번호
	 * @return - PK로 조회된 1개의 게시글 정보 반환
	 */
	LocalBoardVO read(int bno) throws Exception;
	
	/**
	 * 지역별 게시글로 나눠서 게시글을 조회
	 */
    List<LocalBoardVO> findCategory(int categoryId) throws Exception;
	
	
	/**
	 * @param board - 수정할 게시글 정보
	 * @return - 수정된 행의 개수
	 */
	int update(LocalBoardVO board) throws Exception;
	
	/**
	 * @param bno - 삭제할 게시글 번호
	 * @return - 처리후 삭제된 행의 개수 반환
	 */
	int delete(int bno) throws Exception;
	
	/**
	 * @param bno - 조회수 증가 할 게시글 번호
	 * 일치하는 게시글 번호를 가진 행의 viewcnt(조회수)컬럼의 데이터를 1증가
	 */
	void updateCnt(int bno) throws Exception;
	
	/**
	 * @return - 등록된 전체 게시글(행) 개수
	 */
	int totalCount() throws Exception;
	
	/**
	 * @param cri - 검색 기준
	 * @return - 검색 기준에 따라 조회된 게시글 목록
	 */
	List<LocalBoardVO> listCriteria(Criteria cri) throws Exception;
	
	
	/**
	 * @param bno - 추천수 증가 할 게시글 번호
	 * 일치하는 게시글 번호를 가진 행의 agree(추천수)의 데이터를 1증가
	 */
	void plusAgree(int bno) throws Exception;
	
	/**
	 * 추천 수 증가 실시간 조회 ajax이용
	 */
	int AgreeCount(int bno) throws Exception; 
	

	

	
	
	

}
