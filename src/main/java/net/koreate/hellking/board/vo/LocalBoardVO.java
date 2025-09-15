package net.koreate.hellking.board.vo;

import java.util.Date;

import lombok.Data;

@Data
public class LocalBoardVO {
	
	    private int bno;
	    private String title;
	    private String content;
	    private String nickname;
	    private Date regdate;
	    private int viewcnt;
	    private int agree;
	    private int disagree;
	    private int categoryId;

	}
