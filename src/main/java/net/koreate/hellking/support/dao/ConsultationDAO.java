package net.koreate.hellking.support.dao;

import java.util.Date;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Options;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import net.koreate.hellking.support.vo.ConsultationVO;

/**
 * 상담예약 DAO (어노테이션 방식)
 */
@Mapper
public interface ConsultationDAO {
    
    /**
     * 상담예약 등록
     */
    @Insert("INSERT INTO hk_consultation (consultation_num, user_num, consultation_date, consultation_time, " +
            "name, phone, email, content, status, created_at, updated_at) " +
            "VALUES (hk_consultation_seq.NEXTVAL, #{userNum}, #{consultationDate}, #{consultationTime}, " +
            "#{name}, #{phone}, #{email}, #{content}, NVL(#{status}, 'CONFIRMED'), CURRENT_TIMESTAMP, CURRENT_TIMESTAMP)")
    @Options(useGeneratedKeys = true, keyProperty = "consultationNum", keyColumn = "consultation_num")
    int insertConsultation(ConsultationVO consultation);
    
    /**
     * 상담예약 상세 조회
     */
    @Select("SELECT c.consultation_num, c.user_num, c.consultation_date, c.consultation_time, " +
            "c.name, c.phone, c.email, c.content, c.status, c.created_at, c.updated_at, " +
            "u.username, u.user_id " +
            "FROM hk_consultation c " +
            "LEFT JOIN hk_users u ON c.user_num = u.user_num " +
            "WHERE c.consultation_num = #{consultationNum}")
    ConsultationVO selectConsultationByNum(@Param("consultationNum") Long consultationNum);
    
    /**
     * 사용자별 상담예약 목록 조회
     */
    @Select("SELECT c.consultation_num, c.user_num, c.consultation_date, c.consultation_time, " +
            "c.name, c.phone, c.email, c.content, c.status, c.created_at, c.updated_at, " +
            "u.username, u.user_id " +
            "FROM hk_consultation c " +
            "LEFT JOIN hk_users u ON c.user_num = u.user_num " +
            "WHERE c.user_num = #{userNum} " +
            "ORDER BY c.consultation_date DESC, c.consultation_time DESC")
    List<ConsultationVO> selectConsultationsByUser(@Param("userNum") Long userNum);
    
    /**
     * 관리자용 상담예약 목록 조회 (페이징)
     */
    @Select("SELECT * FROM ( " +
            "SELECT c.consultation_num, c.user_num, c.consultation_date, c.consultation_time, " +
            "c.name, c.phone, c.email, c.content, c.status, c.created_at, c.updated_at, " +
            "u.username, u.user_id, ROWNUM rn " +
            "FROM hk_consultation c " +
            "LEFT JOIN hk_users u ON c.user_num = u.user_num " +
            "WHERE 1=1 " +
            "ORDER BY c.consultation_date DESC, c.consultation_time DESC " +
            ") WHERE rn BETWEEN #{startRow} AND #{endRow}")
    List<ConsultationVO> selectConsultationsForAdmin(Map<String, Object> params);
    
    /**
     * 관리자용 상담예약 총 개수
     */
    @Select("SELECT COUNT(*) FROM hk_consultation c " +
            "LEFT JOIN hk_users u ON c.user_num = u.user_num")
    int selectConsultationCountForAdmin(Map<String, Object> params);
    
    /**
     * 상담예약 상태 변경
     */
    @Update("UPDATE hk_consultation SET status = #{status}, updated_at = CURRENT_TIMESTAMP " +
            "WHERE consultation_num = #{consultationNum}")
    int updateConsultationStatus(@Param("consultationNum") Long consultationNum, 
                                @Param("status") String status);
    
    /**
     * 상담예약 정보 수정
     */
    @Update("UPDATE hk_consultation SET " +
            "consultation_date = #{consultationDate}, consultation_time = #{consultationTime}, " +
            "name = #{name}, phone = #{phone}, email = #{email}, content = #{content}, " +
            "updated_at = CURRENT_TIMESTAMP " +
            "WHERE consultation_num = #{consultationNum}")
    int updateConsultation(ConsultationVO consultation);
    
    /**
     * 특정 날짜/시간 예약 여부 확인
     */
    @Select("SELECT COUNT(*) FROM hk_consultation " +
            "WHERE consultation_date = #{consultationDate} " +
            "AND consultation_time = #{consultationTime} " +
            "AND status = 'CONFIRMED'")
    int checkTimeSlotAvailable(@Param("consultationDate") Date consultationDate, 
                              @Param("consultationTime") String consultationTime);
    
    /**
     * 예약된 시간 조회 (특정 날짜)
     */
    @Select("SELECT consultation_time FROM hk_consultation " +
            "WHERE consultation_date = #{consultationDate} " +
            "AND status = 'CONFIRMED' " +
            "ORDER BY consultation_time")
    List<String> selectBookedTimeSlots(@Param("consultationDate") Date consultationDate);
    
    /**
     * 공휴일 여부 확인
     */
    @Select("SELECT COUNT(*) FROM hk_holidays WHERE holiday_date = #{checkDate}")
    int checkHoliday(@Param("checkDate") Date checkDate);
    
    /**
     * 당일 상담예약 목록 조회 (이메일 발송용)
     */
    @Select("SELECT c.consultation_num, c.user_num, c.consultation_date, c.consultation_time, " +
            "c.name, c.phone, c.email, c.content, c.status, c.created_at, c.updated_at, " +
            "u.username, u.user_id " +
            "FROM hk_consultation c " +
            "LEFT JOIN hk_users u ON c.user_num = u.user_num " +
            "WHERE c.consultation_date = TRUNC(SYSDATE) " +
            "AND c.status = 'CONFIRMED' " +
            "ORDER BY c.consultation_time")
    List<ConsultationVO> selectTodayConsultations();
    
    /**
     * 내일 상담예약 목록 조회 (리마인드 이메일용)
     */
    @Select("SELECT c.consultation_num, c.user_num, c.consultation_date, c.consultation_time, " +
            "c.name, c.phone, c.email, c.content, c.status, c.created_at, c.updated_at, " +
            "u.username, u.user_id " +
            "FROM hk_consultation c " +
            "LEFT JOIN hk_users u ON c.user_num = u.user_num " +
            "WHERE c.consultation_date = TRUNC(SYSDATE) + 1 " +
            "AND c.status = 'CONFIRMED' " +
            "ORDER BY c.consultation_time")
    List<ConsultationVO> selectTomorrowConsultations();
    
    /**
     * 상담예약 삭제 (실제 삭제)
     */
    @Delete("DELETE FROM hk_consultation WHERE consultation_num = #{consultationNum}")
    int deleteConsultation(@Param("consultationNum") Long consultationNum);
    
    /**
     * 사용자의 최근 예약 정보 조회 (자동 입력용)
     */
    @Select("SELECT c.consultation_num, c.user_num, c.consultation_date, c.consultation_time, " +
            "c.name, c.phone, c.email, c.content, c.status, c.created_at, c.updated_at, " +
            "u.username, u.user_id " +
            "FROM hk_consultation c " +
            "LEFT JOIN hk_users u ON c.user_num = u.user_num " +
            "WHERE c.user_num = #{userNum} " +
            "ORDER BY c.created_at DESC " +
            "FETCH FIRST 1 ROWS ONLY")
    ConsultationVO selectRecentConsultationByUser(@Param("userNum") Long userNum);
}