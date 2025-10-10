package net.koreate.hellking.board.service;

import java.util.List;
<<<<<<< HEAD

import net.koreate.hellking.board.vo.BoardVO;
import net.koreate.hellking.common.util.Criteria;
import net.koreate.hellking.common.util.PageMaker;
=======
import java.util.Map;

import org.springframework.web.multipart.MultipartFile;

import net.koreate.hellking.board.util.BoardCriteria;
import net.koreate.hellking.board.util.BoardPageMaker;
import net.koreate.hellking.board.util.BoardSearchCriteria;
import net.koreate.hellking.board.vo.BoardVO;
>>>>>>> b65c320 (Initial commit)

public interface BoardService {
	
	/**
	 * 게시글 등록 요청 처리 - 성공 여부에 따라 메세지 전달
	 * @param board - 게시글 등록에 필요한 정보
	 * @return 게시글 등록 성공 여부 메세지
	 * @throws Exception - 처리 중 발생한 예외
	 */
<<<<<<< HEAD
	String regist(BoardVO board) throws Exception;
=======
	String regist(BoardVO board, MultipartFile[] uploadFile) throws Exception;
>>>>>>> b65c320 (Initial commit)
	
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
<<<<<<< HEAD
	 * @param board - 게시글 수정 데이터(bno,title,content,writer)
	 * @return - 게시글 수정 완료 여부 메세지 
	 */
	String modify(BoardVO board) throws Exception;
=======
	 * @param board - 게시글 수정 데이터(bno,title,content,nickname..)
	 * @return - 게시글 수정 완료 여부 메세지 
	 * 첨부파일까지 수정 및 삭제할수있게 수정페이지에 기능까지추가
	 */
	String modify(BoardVO board, List<Integer> delFiles, MultipartFile[] uploadFiles) throws Exception;
>>>>>>> b65c320 (Initial commit)

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
<<<<<<< HEAD
	List<BoardVO> listCriteria(Criteria cri) throws Exception;
=======
	List<BoardVO> listCriteria(BoardCriteria cri) throws Exception;
>>>>>>> b65c320 (Initial commit)
	
	/**
	 * 페이징 블럭 정보
	 * @param cri - 페이징 블럭 계산에 필요한 정보
	 * @return 페이징 번호 출력을 위한 계산된 정보를 저장하고 있는 PageMaker 반환
	 */
<<<<<<< HEAD
	PageMaker getPageMaker(Criteria cri) throws Exception;
=======
	BoardPageMaker getPageMaker(BoardCriteria cri) throws Exception;
>>>>>>> b65c320 (Initial commit)
	
	/**
	 * 추천수가 일정 기준 이상인 인기 게시글 목록을 조회합니다.
	 *
	 * @return 추천수 20 이상인 게시글 리스트 (최신순 정렬)
	 */
	List<BoardVO> getHotBoard(int HotAgree) throws Exception;
	
	/**
<<<<<<< HEAD
=======
	 * 추천 토글(반전) 형식으로 누르면 올랐다 다시누르면 또 내렸다
	 */
	Map<String, Object> toggleAgree(int bno, String userId) throws Exception;
	
	/**
>>>>>>> b65c320 (Initial commit)
	 * 추천 수 증가 
	 * @param bno
	 * @throws Exception
	 */
	void plusAgree(int bno) throws Exception;
	
	/**
<<<<<<< HEAD
=======
	 * 증가가 있으면 감소가 있는법, 공정과 정의가 살아숨쉬는 세상에도 불공정함과 불의가 있는법이다. 
	 */
	void minusAgree(int bno) throws Exception;
	
	/**
>>>>>>> b65c320 (Initial commit)
	 * 추천 수 증가 실시간 조회
	 */
	int AgreeCount(int bno) throws Exception;
	
<<<<<<< HEAD
=======
	List<BoardVO> listSearch(BoardSearchCriteria cri) throws Exception;
	  
	BoardPageMaker getPageMaker(BoardSearchCriteria cri) throws Exception;
	
>>>>>>> b65c320 (Initial commit)
	
}
