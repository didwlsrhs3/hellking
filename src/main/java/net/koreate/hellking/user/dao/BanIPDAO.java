package net.koreate.hellking.user.dao;

import net.koreate.hellking.user.vo.BanIPVO;

public interface BanIPDAO {

	// ip로 등록된 ban_ip 검색
	BanIPVO getBanIPVO(String ip) throws Exception;

	// ban_ip 등록
	void signInFail(String ip) throws Exception;

	// 반복 실패 카운트 증가
	void updateBanIPCnt(String ip) throws Exception;

	// 로그인 성공 시 ban_ip 삭제
	void removeBanIP(String ip) throws Exception;

}
