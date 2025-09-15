package net.koreate.hellking.board.localboard.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.context.annotation.Primary;
import org.springframework.stereotype.Repository;

import lombok.RequiredArgsConstructor;
import net.koreate.hellking.board.localboard.vo.LocalBoardVO;
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


	

}
