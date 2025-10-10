package net.koreate.hellking.board.service;

import java.util.List;

import org.springframework.stereotype.Service;

import lombok.RequiredArgsConstructor;
import net.koreate.hellking.board.dao.LocalBoardDAO;
<<<<<<< HEAD
import net.koreate.hellking.board.dao.SecretBoardDAO;
import net.koreate.hellking.board.vo.LocalBoardVO;
import net.koreate.hellking.common.util.Criteria;
import net.koreate.hellking.common.util.PageMaker;

@Service
@RequiredArgsConstructor
public class LocalBoardServiceImpl implements LocalBoardService{
	
	private final LocalBoardDAO dao;

	@Override
	public String regist(LocalBoardVO board) throws Exception {
		int result = dao.create(board);
		String message = (result != 0) ? "게시글 등록 성공" : "게시글 등록 실패";
		return message;
	}

	@Override
	public void updateCnt(int bno) throws Exception {
		dao.updateCnt(bno);
	}

	@Override
	public LocalBoardVO read(int bno) throws Exception {
		return dao.read(bno);
	}
	
	@Override
	public List<LocalBoardVO> findCategory(int categoryId) throws Exception {
		return dao.findCategory(categoryId);
	}

	@Override
	public String modify(LocalBoardVO board) throws Exception {
		return dao.update(board) != 0 ? "게시글 수정 성공" : "게시글 수정 실패";
	}

	@Override
	public String remove(int bno) throws Exception {
		return dao.delete(bno) == 1 ? "게시글 삭제 성공" : "게시글 삭제 실패";
	}

	@Override
	public List<LocalBoardVO> listCriteria(Criteria cri) throws Exception {
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

=======
import net.koreate.hellking.board.util.BoardCriteria;
import net.koreate.hellking.board.util.LocalBoardSearchCriteria;
import net.koreate.hellking.board.vo.LocalBoardVO;

@Service
@RequiredArgsConstructor
public class LocalBoardServiceImpl implements LocalBoardService {

    private final LocalBoardDAO dao;

    @Override
    public String regist(LocalBoardVO vo) throws Exception {
        dao.create(vo);
        return "등록 성공";
    }

    @Override
    public List<LocalBoardVO> listSearch(LocalBoardSearchCriteria cri) throws Exception {
        return dao.listSearch(cri);
    }

    @Override
    public int countSearch(LocalBoardSearchCriteria cri) throws Exception {
        return dao.countSearch(cri);
    }
    
    @Override
    public List<LocalBoardVO> listCriteria(BoardCriteria cri) throws Exception {
        return dao.listCriteria(cri);
    }

    @Override
    public LocalBoardVO read(int bno) throws Exception {
        return dao.read(bno);
    }

    @Override
    public void updateCnt(int bno) throws Exception {
        dao.updateCnt(bno);
    }

    @Override
    public String modify(LocalBoardVO vo) throws Exception {
        dao.update(vo);
        return "수정 성공";
    }

    @Override
    public String remove(int bno) throws Exception {
        dao.delete(bno);
        return "삭제 성공";
    }

    @Override
    public void plusAgree(int bno) throws Exception {
        dao.updateAgree(bno);
    }

    @Override
    public int AgreeCount(int bno) throws Exception {
        return dao.viewAgree(bno);
    }

    @Override
    public List<LocalBoardVO> getAllLocalPosts() throws Exception {
        return dao.selectAllLocalPosts();
    }

    @Override
    public List<LocalBoardVO> getLocalPostsByCategory(int categoryId) throws Exception {
        return dao.selectLocalPostsByCategory(categoryId);
    }
>>>>>>> b65c320 (Initial commit)
}
