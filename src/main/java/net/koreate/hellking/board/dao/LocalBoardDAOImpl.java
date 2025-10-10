package net.koreate.hellking.board.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
<<<<<<< HEAD
import org.springframework.context.annotation.Primary;
import org.springframework.stereotype.Repository;

import lombok.RequiredArgsConstructor;
import net.koreate.hellking.board.vo.LocalBoardVO;
import net.koreate.hellking.common.util.Criteria;

@Repository
@RequiredArgsConstructor
@Primary
public class LocalBoardDAOImpl implements LocalBoardDAO{
	
	private final SqlSession session;
	
	@Override
	public int create(LocalBoardVO board) throws Exception {
		int result = session.insert("localMapper.create", board);
		return result;
	}

	@Override
	public LocalBoardVO read(int bno) throws Exception {
		return session.selectOne("localMapper.read", bno);
	}
	
	@Override
	public List<LocalBoardVO> findCategory(int categoryId) throws Exception {
		return session.selectList("localMapper.findCategory", categoryId);
	}

	@Override
	public int update(LocalBoardVO board) throws Exception {
		return session.update("localMapper.update", board);
	}

	@Override
	public int delete(int bno) throws Exception {
		return session.delete("localMapper.delete", bno);
	}

	@Override
	public void updateCnt(int bno) throws Exception {
		session.update("localMapper.updateCnt", bno);
	}

	@Override
	public int totalCount() throws Exception {
		return session.selectOne("localMapper.totalCount");
	}

	@Override
	public List<LocalBoardVO> listCriteria(Criteria cri) throws Exception {
		List<LocalBoardVO> list = session.selectList("localMapper.listCriteria", cri);
		return list;
	}

	@Override
	public void plusAgree(int bno) throws Exception {
		session.update("localMapper.updateAgree", bno);
	}

	@Override
	public int AgreeCount(int bno) throws Exception {
		return session.selectOne("localMapper.viewAgree", bno);
	}


	

=======
import org.springframework.stereotype.Repository;

import lombok.RequiredArgsConstructor;
import net.koreate.hellking.board.util.BoardCriteria;
import net.koreate.hellking.board.util.LocalBoardSearchCriteria;
import net.koreate.hellking.board.vo.LocalBoardVO;

@Repository
@RequiredArgsConstructor
public class LocalBoardDAOImpl implements LocalBoardDAO {

    private final SqlSession session;
    private static final String NS = "localMapper";

    @Override
    public void create(LocalBoardVO vo) throws Exception {
        session.insert(NS + ".create", vo);
    }

    @Override
    public List<LocalBoardVO> listSearch(LocalBoardSearchCriteria cri) throws Exception {
        return session.selectList(NS + ".listSearch", cri);
    }
    
    @Override
    public List<LocalBoardVO> listCriteria(BoardCriteria cri) {
        return session.selectList(NS + ".listCriteria", cri);
    }

    @Override
    public int countSearch(LocalBoardSearchCriteria cri) throws Exception {
        return session.selectOne(NS + ".countSearch", cri);
    }

    @Override
    public LocalBoardVO read(int bno) throws Exception {
        return session.selectOne(NS + ".read", bno);
    }

    @Override
    public void updateCnt(int bno) throws Exception {
        session.update(NS + ".updateCnt", bno);
    }

    @Override
    public void update(LocalBoardVO vo) throws Exception {
        session.update(NS + ".update", vo);
    }

    @Override
    public void delete(int bno) throws Exception {
        session.delete(NS + ".delete", bno);
    }

    @Override
    public void updateAgree(int bno) throws Exception {
        session.update(NS + ".updateAgree", bno);
    }

    @Override
    public int viewAgree(int bno) throws Exception {
        return session.selectOne(NS + ".viewAgree", bno);
    }

    @Override
    public List<LocalBoardVO> selectAllLocalPosts() throws Exception {
        return session.selectList(NS + ".selectAllLocalPosts");
    }

    @Override
    public List<LocalBoardVO> selectLocalPostsByCategory(int categoryId) throws Exception {
        return session.selectList(NS + ".selectLocalPostsByCategory", categoryId);
    }
>>>>>>> b65c320 (Initial commit)
}
