package net.koreate.hellking.board.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import lombok.RequiredArgsConstructor;
import net.koreate.hellking.board.dao.CommentDAO;
import net.koreate.hellking.board.vo.CommentVO;

@Service
@RequiredArgsConstructor
public class CommentServiceImpl implements CommentService {

    private final CommentDAO dao;

    @Override
    public void addComment(CommentVO vo) throws Exception {
        dao.addComment(vo);
    }

    @Override
    @Transactional
    public void addReply(CommentVO vo) throws Exception {
        // 트랜잭션으로 처리하면 좋음 (추가 + depth/step 업데이트 같은 작업 가능)
        dao.addReply(vo);
    }

    @Override
    public void updateComment(CommentVO vo) throws Exception {
        dao.updateComment(vo);
    }

    @Override
    public void deleteComment(int cno) throws Exception {
        dao.deleteComment(cno);
    }

    @Override
    public List<CommentVO> listComment(int bno) throws Exception {
        return dao.listComment(bno);
    }
}
