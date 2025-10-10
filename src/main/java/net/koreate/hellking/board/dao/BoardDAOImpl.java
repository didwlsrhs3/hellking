package net.koreate.hellking.board.dao;

<<<<<<< HEAD
import java.util.List;
=======
import java.util.HashMap;
import java.util.List;
import java.util.Map;
>>>>>>> b65c320 (Initial commit)

import org.apache.ibatis.session.SqlSession;
import org.springframework.context.annotation.Primary;
import org.springframework.stereotype.Repository;

import lombok.RequiredArgsConstructor;
<<<<<<< HEAD
import net.koreate.hellking.board.vo.BoardVO;
import net.koreate.hellking.common.util.Criteria;
=======
import net.koreate.hellking.board.util.BoardCriteria;
import net.koreate.hellking.board.util.BoardSearchCriteria;
import net.koreate.hellking.board.vo.BoardVO;
import net.koreate.hellking.board.vo.FileVO;
>>>>>>> b65c320 (Initial commit)

@Repository
@RequiredArgsConstructor
@Primary
public class BoardDAOImpl implements BoardDAO {

	private final SqlSession session;
	
	@Override
	public int create(BoardVO board) throws Exception {
		int result = session.insert("boardMapper.create", board);
		return result;
	}

	@Override
	public BoardVO read(int bno) throws Exception {
		return session.selectOne("boardMapper.read", bno);
	}

	@Override
	public int update(BoardVO board) throws Exception {
		return session.update("boardMapper.update", board);
	}

	@Override
	public int delete(int bno) throws Exception {
		return session.delete("boardMapper.delete", bno);
	}

	@Override
	public void updateCnt(int bno) throws Exception {
		session.update("boardMapper.updateCnt", bno);
	}

	@Override
	public int totalCount() throws Exception {
		return session.selectOne("boardMapper.totalCount");
	}

	@Override
<<<<<<< HEAD
	public List<BoardVO> listCriteria(Criteria cri) throws Exception {
=======
	public List<BoardVO> listCriteria(BoardCriteria cri) throws Exception {
>>>>>>> b65c320 (Initial commit)
		List<BoardVO> list = session.selectList("boardMapper.listCriteria", cri);
		return list;
	}
	
	@Override
	public List<BoardVO> getHotBoard(int HotAgree) throws Exception {
	    return session.selectList("boardMapper.getHotBoard", HotAgree);
	}

	@Override
	public void plusAgree(int bno) throws Exception {
		session.update("boardMapper.updateAgree", bno);
	}
<<<<<<< HEAD
=======
	
	@Override
	public void minusAgree(int bno) throws Exception {
		session.update("boardMapper.minusAgree", bno);	
	}
>>>>>>> b65c320 (Initial commit)

	@Override
	public int AgreeCount(int bno) throws Exception {
		return session.selectOne("boardMapper.viewAgree", bno);
	}

<<<<<<< HEAD
=======
	@Override
	public int getLastInsertedBno() {
	    return session.selectOne("boardMapper.getLastInsertedBno");
	}

	@Override
	public void insertFiles(List<FileVO> files) {
		session.insert("boardMapper.insertFiles", files);
	}

	@Override
	public List<FileVO> getFilesByBno(int bno, String boardType) {
		
	    Map<String, Object> param = new HashMap<>();
	    param.put("bno", bno);
	    param.put("boardType", boardType);

	    return session.selectList("boardMapper.getFilesByBno", param);
	}

	@Override
	public FileVO findFileByFno(int fno) throws Exception {
		return session.selectOne("boardMapper.findFileByFno", fno);
	}

	@Override
	public void deleteFile(int fno) throws Exception {
        session.delete("boardMapper.deleteFile", fno);
		
	}
	
    @Override
    public List<BoardVO> listSearch(BoardSearchCriteria cri) throws Exception {
        return session.selectList("boardMapper.listSearch", cri);
    }

    @Override
    public int countSearch(BoardSearchCriteria cri) throws Exception {
        return session.selectOne("boardMapper.countSearch", cri);
    }

	@Override
	public boolean existsUserAgree(int bno, String userId) {
	    Map<String, Object> param = new HashMap<>();
	    param.put("bno", bno);
	    param.put("userId", userId);
	    Integer count = session.selectOne("boardMapper.existsUserAgree", param);
	    return count != null && count > 0;
	}

	@Override
	public void insertUserAgree(int bno, String userId) {
	    Map<String, Object> param = new HashMap<>();
	    param.put("bno", bno);
	    param.put("userId", userId);
	    session.insert("boardMapper.insertUserAgree", param);
	}

	@Override
	public void deleteUserAgree(int bno, String userId) {
	    Map<String, Object> param = new HashMap<>();
	    param.put("bno", bno);
	    param.put("userId", userId);
	    session.delete("boardMapper.deleteUserAgree", param);
	}



>>>>>>> b65c320 (Initial commit)
	

}
