package net.koreate.hellking.board.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
<<<<<<< HEAD
import org.springframework.context.annotation.Primary;
import org.springframework.stereotype.Repository;

import lombok.RequiredArgsConstructor;
import net.koreate.hellking.board.vo.SecretBoardVO;
import net.koreate.hellking.common.util.Criteria;

@Repository
@RequiredArgsConstructor
@Primary
public class SecretBoardDAOImpl implements SecretBoardDAO{
	
	private final SqlSession session;
		
	@Override
	public int create(SecretBoardVO board) throws Exception {
		int result = session.insert("secretMapper.create", board);
		return result;
	}

	@Override
	public SecretBoardVO read(int bno) throws Exception {
		return session.selectOne("secretMapper.read", bno);
	}

	@Override
	public int update(SecretBoardVO board) throws Exception {
		return session.update("secretMapper.update", board);
	}

	@Override
	public int delete(int bno) throws Exception {
		return session.delete("secretMapper.delete", bno);
	}

	@Override
	public void updateCnt(int bno) throws Exception {
		session.update("secretMapper.updateCnt", bno);
	}

	@Override
	public int totalCount() throws Exception {
		return session.selectOne("secretMapper.totalCount");
	}

	@Override
	public List<SecretBoardVO> listCriteria(Criteria cri) throws Exception {
		List<SecretBoardVO> list = session.selectList("secretMapper.listCriteria", cri);
		return list;
	}

	@Override
	public void plusAgree(int bno) throws Exception {
		session.update("secretMapper.updateAgree", bno);
	}

	@Override
	public int AgreeCount(int bno) throws Exception {
		return session.selectOne("secretMapper.viewAgree", bno);
	}

	

=======
import org.springframework.stereotype.Repository;

import lombok.RequiredArgsConstructor;
import net.koreate.hellking.board.util.BoardCriteria;
import net.koreate.hellking.board.vo.SecretBoardVO;

@Repository
@RequiredArgsConstructor
public class SecretBoardDAOImpl implements SecretBoardDAO {

    private final SqlSession session;
    private static final String NS = "secretMapper";

    @Override
    public void create(SecretBoardVO board) throws Exception {
        session.insert(NS + ".create", board);
    }

    @Override
    public List<SecretBoardVO> listCriteria(BoardCriteria cri) throws Exception {
        return session.selectList(NS + ".listCriteria", cri);
    }

    @Override
    public int totalCount() throws Exception {
        return session.selectOne(NS + ".totalCount");
    }

    @Override
    public SecretBoardVO read(int bno) throws Exception {
        return session.selectOne(NS + ".read", bno);
    }

    @Override
    public void updateCnt(int bno) throws Exception {
        session.update(NS + ".updateCnt", bno);
    }

    @Override
    public void update(SecretBoardVO board) throws Exception {
        session.update(NS + ".update", board);
    }

    @Override
    public void delete(int bno) throws Exception {
        session.delete(NS + ".delete", bno);
    }

    @Override
    public String getPassword(int bno) throws Exception {
        return session.selectOne(NS + ".getPassword", bno);
    }

    @Override
    public void updateAgree(int bno) throws Exception {
        session.update(NS + ".updateAgree", bno);
    }

    @Override
    public int viewAgree(int bno) throws Exception {
        return session.selectOne(NS + ".viewAgree", bno);
    }
>>>>>>> b65c320 (Initial commit)
}
