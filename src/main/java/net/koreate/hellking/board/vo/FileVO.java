package net.koreate.hellking.board.vo;

import lombok.Data;

@Data
public class FileVO {

	  private int fno;
	  private int bno;
	  private String board_type; // 'free', 'secret', 'local' 3가지를 이걸로 구분
	  private String originalName;
	  private String savedName;
	  private String uploadPath;
	  private long fileSize;

}
