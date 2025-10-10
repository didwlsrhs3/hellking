package net.koreate.hellking.user.vo;

import java.util.Date;

import lombok.Data;

@Data
public class BanIPVO {

	private String ip; // 반복 요청이 들어온 IP
	private int cnt; // 로그인 실패 횟수
	private Date bandate; // 로그인 실패 최종 시간

}
