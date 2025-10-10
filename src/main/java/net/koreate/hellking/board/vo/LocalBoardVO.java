package net.koreate.hellking.board.vo;

import java.util.Date;
<<<<<<< HEAD
=======
import java.util.List;
>>>>>>> b65c320 (Initial commit)

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
<<<<<<< HEAD
	    private int categoryId;
=======
	    private int category_id;
		private int HotAgree = 20;
		private List<FileVO> files;
		private String boardType; 
>>>>>>> b65c320 (Initial commit)

	}
