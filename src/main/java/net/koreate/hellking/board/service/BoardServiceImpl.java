package net.koreate.hellking.board.service;

import java.util.List;

import org.springframework.stereotype.Service;

import lombok.RequiredArgsConstructor;
import net.koreate.hellking.board.dao.BoardDAO;
import net.koreate.hellking.board.vo.BoardVO;
import net.koreate.hellking.common.util.Criteria;
import net.koreate.hellking.common.util.PageMaker;

@Service
@RequiredArgsConstructor
public class BoardServiceImpl implements BoardService {
	
	private final BoardDAO dao;

	@Override
	public String regist(BoardVO board) throws Exception {
		int result = dao.create(board);
		String message = (result != 0) ? "게시글 등록 성공" : "게시글 등록 실패";
		return message;
	}

	@Override
	public void updateCnt(int bno) throws Exception {
		dao.updateCnt(bno);
	}

	@Override
	public BoardVO read(int bno) throws Exception {
		return dao.read(bno);
	}

	@Override
	public String modify(BoardVO board) throws Exception {
		return dao.update(board) != 0 ? "게시글 수정 성공" : "게시글 수정 실패";
	}

	@Override
	public String remove(int bno) throws Exception {
		return dao.delete(bno) == 1 ? "게시글 삭제 성공" : "게시글 삭제 실패";
	}

	@Override
	public List<BoardVO> listCriteria(Criteria cri) throws Exception {
		return dao.listCriteria(cri);
	}

	@Override
	public PageMaker getPageMaker(Criteria cri) throws Exception {
		// totalCount, Criteria, displayPageNum
		PageMaker pm = new PageMaker();
		int totalCount = dao.totalCount();
		pm.setCri(cri);
		pm.setTotalCount(totalCount);
		pm.setDisplayPageNum(10);
		return pm;
	}

	@Override
	public List<BoardVO> getHotBoard(int HotAgree) throws Exception{
	    return dao.getHotBoard(HotAgree);
	}

	@Override
	public void plusAgree(int bno) throws Exception {
		dao.plusAgree(bno);
		
	}

	@Override
	public int AgreeCount(int bno) throws Exception {
		return dao.AgreeCount(bno);
	}

}
