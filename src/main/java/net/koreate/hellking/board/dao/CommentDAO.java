package net.koreate.hellking.board.dao;

import java.util.List;

import net.koreate.hellking.board.vo.CommentVO;

public interface CommentDAO {

    // 댓글 등록
    void addComment(CommentVO vo) throws Exception;

    // 답글 등록
    void addReply(CommentVO vo) throws Exception;

    // 댓글 수정
    void updateComment(CommentVO vo) throws Exception;

    // 댓글 삭제
    void deleteComment(int cno) throws Exception;

    // 댓글 목록
    List<CommentVO> listComment(int bno) throws Exception;
}