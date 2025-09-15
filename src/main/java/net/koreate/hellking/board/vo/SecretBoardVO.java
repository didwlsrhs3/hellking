package net.koreate.hellking.board.vo;

import java.util.Date;

import lombok.Data;

@Data
public class SecretBoardVO {

	private	int bno; 		 // 글번호
	private	String title; 	 // 제목
	private String content;  // 내용
	private String nickname; // 닉네임 
	private String password; // 글 비밀번호
	private Date regdate; 	 // 작성일(등록시간)
	private int viewcnt; 	 // 조회수 
	private int agree;		 // 추천수
	private int disagree;	 // 비추천수 
	private int HotAgree = 20;   // 추천수 20이상의 글

}
