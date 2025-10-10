package net.koreate.hellking.board.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import lombok.RequiredArgsConstructor;
import net.koreate.hellking.board.vo.CommentVO;

@Repository
@RequiredArgsConstructor
public class CommentDAOImpl implements CommentDAO {

    private final SqlSession session;

    private static final String NS = "commentMapper";

    @Override
    public void addComment(CommentVO vo) throws Exception {
        session.insert(NS + ".addComment", vo);
    }

    @Override
    public void addReply(CommentVO vo) throws Exception {
        session.insert(NS + ".addReply", vo);
    }

    @Override
    public void updateComment(CommentVO vo) throws Exception {
        session.update(NS + ".updateComment", vo);
    }

    @Override
    public void deleteComment(int cno) throws Exception {
        session.delete(NS + ".deleteComment", cno);
    }

    @Override
    public List<CommentVO> listComment(int bno) throws Exception {
        return session.selectList(NS + ".listComment", bno);
    }
}
