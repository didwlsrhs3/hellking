package net.koreate.hellking.board.service;

import java.util.List;

import net.koreate.hellking.board.vo.CommentVO;

public interface CommentService {
	
    void addComment(CommentVO vo) throws Exception;

    void addReply(CommentVO vo) throws Exception;

    void updateComment(CommentVO vo) throws Exception;

    void deleteComment(int cno) throws Exception;

    List<CommentVO> listComment(int bno) throws Exception;
}
