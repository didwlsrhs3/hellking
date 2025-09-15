package net.koreate.hellking.board.secretboard.service;

import java.util.List;

import org.springframework.stereotype.Service;

import lombok.RequiredArgsConstructor;
import net.koreate.hellking.board.secretboard.dao.SecretBoardDAO;
import net.koreate.hellking.board.secretboard.vo.SecretBoardVO;
import net.koreate.hellking.common.util.Criteria;
import net.koreate.hellking.common.util.PageMaker;

@Service
@RequiredArgsConstructor
public class SecretBoardServiceImpl implements SecretBoardService{

	private final SecretBoardDAO dao;

	@Override
	public String regist(SecretBoardVO board) throws Exception {
		int result = dao.create(board);
		String message = (result != 0) ? "게시글 등록 성공" : "게시글 등록 실패";
		return message;
	}

	@Override
	public void updateCnt(int bno) throws Exception {
		dao.updateCnt(bno);
	}

	@Override
	public SecretBoardVO read(int bno) throws Exception {
		return dao.read(bno);
	}

	@Override
	public String modify(SecretBoardVO board) throws Exception {
		return dao.update(board) != 0 ? "게시글 수정 성공" : "게시글 수정 실패";
	}

	@Override
	public String remove(int bno) throws Exception {
		return dao.delete(bno) == 1 ? "게시글 삭제 성공" : "게시글 삭제 실패";
	}

	@Override
	public List<SecretBoardVO> listCriteria(Criteria cri) throws Exception {
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
	public void plusAgree(int bno) throws Exception {
		dao.plusAgree(bno);
		
	}

	@Override
	public int AgreeCount(int bno) throws Exception {
		return dao.AgreeCount(bno);
	}

}
