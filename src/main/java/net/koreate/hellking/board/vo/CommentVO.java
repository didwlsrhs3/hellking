package net.koreate.hellking.board.vo;

import java.util.Date;

import lombok.Data;

@Data
public class CommentVO {
    private int cno;
    private int bno;
    private String content;
    private String username;
    private Date regdate;
    private Date updatedate;
    private Integer parentCno; // 부모 댓글 번호 (없으면 null)
    private int depth;         // 계층 (1=부모, 2=답글...)
}
