package net.koreate.hellking.board.vo;

import java.util.Date;
<<<<<<< HEAD
=======
import java.util.List;
>>>>>>> b65c320 (Initial commit)

import lombok.Data;

@Data
public class BoardVO {
	
	private	int bno; 		// 글번호
	private	String title; 	// 제목
	private String content; // 내용
	private String nickname; // 작성자
	private Date regdate; 	// 작성일(등록시간)
	private int viewcnt; 	// 조회수 
	private int agree;		// 추천수
	private int disagree;	// 비추천수 
	private int HotAgree = 20;   // 추천수 20이상의 글
<<<<<<< HEAD
=======
	private List<FileVO> files;
	private String board_type; // 글 작성 시 세팅 필요
	private String userId;
	
	public String getBoardType() {
	    return board_type;
	}

	public void setBoardType(String boardType) {
	    this.board_type = boardType;
	}


>>>>>>> b65c320 (Initial commit)
}
