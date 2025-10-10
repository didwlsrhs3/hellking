package net.koreate.hellking.designbody.dao;

import org.apache.ibatis.annotations.*;
import net.koreate.hellking.designbody.vo.ChainProgramVO;
import net.koreate.hellking.designbody.vo.DesignBodyEnrollVO;
import java.util.List;

/**
 * 체인점 프로그램 관련 DAO
 */
@Mapper
public interface ChainProgramDAO {
    
    // ===== 체인점별 프로그램 조회 =====
    
    /**
     * 모든 체인점 프로그램 조회 (v_chain_programs 뷰 사용)
     */
    @Results({
        @Result(property = "programNum", column = "program_num"),
        @Result(property = "programName", column = "program_name"),
        @Result(property = "programType", column = "program_type"),
        @Result(property = "difficulty", column = "difficulty"),
        @Result(property = "duration", column = "duration"),
        @Result(property = "description", column = "description"),
        @Result(property = "instructor", column = "instructor"),
        @Result(property = "price", column = "final_price"),
        @Result(property = "targetAudience", column = "target_audience"),
        @Result(property = "equipment", column = "equipment"),
        @Result(property = "schedule", column = "schedule"),
        @Result(property = "chainNum", column = "chain_num"),
        @Result(property = "chainName", column = "chain_name"),
        @Result(property = "chainAddress", column = "chain_address"),
        @Result(property = "chainPhone", column = "chain_phone"),
        @Result(property = "programRoom", column = "program_room"),
        @Result(property = "operatingDays", column = "operating_days"),
        @Result(property = "operatingTime", column = "operating_time"),
        @Result(property = "holidayInfo", column = "holiday_info"),
        @Result(property = "maxCapacity", column = "max_capacity"),
        @Result(property = "currentEnrollment", column = "current_enrollment"),
        @Result(property = "availableSpots", column = "available_spots"),
        @Result(property = "enrollmentStatus", column = "enrollment_status"),
        @Result(property = "chainPrice", column = "final_price"),
        @Result(property = "isActive", column = "is_active"),
        @Result(property = "createdAt", column = "created_at")
    })
    @Select("SELECT * FROM v_chain_programs ORDER BY chain_name, program_type, program_name")
    List<ChainProgramVO> selectAllChainPrograms();
    
    /**
     * 특정 체인점의 프로그램 조회
     */
    @Results({
        @Result(property = "programNum", column = "program_num"),
        @Result(property = "programName", column = "program_name"),
        @Result(property = "programType", column = "program_type"),
        @Result(property = "difficulty", column = "difficulty"),
        @Result(property = "duration", column = "duration"),
        @Result(property = "description", column = "description"),
        @Result(property = "instructor", column = "instructor"),
        @Result(property = "price", column = "final_price"),
        @Result(property = "targetAudience", column = "target_audience"),
        @Result(property = "equipment", column = "equipment"),
        @Result(property = "schedule", column = "schedule"),
        @Result(property = "chainNum", column = "chain_num"),
        @Result(property = "chainName", column = "chain_name"),
        @Result(property = "chainAddress", column = "chain_address"),
        @Result(property = "chainPhone", column = "chain_phone"),
        @Result(property = "programRoom", column = "program_room"),
        @Result(property = "operatingDays", column = "operating_days"),
        @Result(property = "operatingTime", column = "operating_time"),
        @Result(property = "holidayInfo", column = "holiday_info"),
        @Result(property = "maxCapacity", column = "max_capacity"),
        @Result(property = "currentEnrollment", column = "current_enrollment"),
        @Result(property = "availableSpots", column = "available_spots"),
        @Result(property = "enrollmentStatus", column = "enrollment_status"),
        @Result(property = "chainPrice", column = "final_price")
    })
    @Select("SELECT * FROM v_chain_programs WHERE chain_num = #{chainNum} ORDER BY program_type, program_name")
    List<ChainProgramVO> selectProgramsByChain(Long chainNum);
    
    /**
     * 프로그램 타입별 체인점 프로그램 조회
     */
    @Results({
        @Result(property = "programNum", column = "program_num"),
        @Result(property = "programName", column = "program_name"),
        @Result(property = "programType", column = "program_type"),
        @Result(property = "difficulty", column = "difficulty"),
        @Result(property = "duration", column = "duration"),
        @Result(property = "description", column = "description"),
        @Result(property = "instructor", column = "instructor"),
        @Result(property = "price", column = "final_price"),
        @Result(property = "targetAudience", column = "target_audience"),
        @Result(property = "equipment", column = "equipment"),
        @Result(property = "schedule", column = "schedule"),
        @Result(property = "chainNum", column = "chain_num"),
        @Result(property = "chainName", column = "chain_name"),
        @Result(property = "chainAddress", column = "chain_address"),
        @Result(property = "chainPhone", column = "chain_phone"),
        @Result(property = "programRoom", column = "program_room"),
        @Result(property = "operatingDays", column = "operating_days"),
        @Result(property = "operatingTime", column = "operating_time"),
        @Result(property = "holidayInfo", column = "holiday_info"),
        @Result(property = "maxCapacity", column = "max_capacity"),
        @Result(property = "currentEnrollment", column = "current_enrollment"),
        @Result(property = "availableSpots", column = "available_spots"),
        @Result(property = "enrollmentStatus", column = "enrollment_status"),
        @Result(property = "chainPrice", column = "final_price")
    })
    @Select("SELECT * FROM v_chain_programs WHERE program_type = #{programType} ORDER BY chain_name, program_name")
    List<ChainProgramVO> selectProgramsByType(String programType);
    
    /**
     * 특정 체인점 프로그램 상세 조회
     */
    @Results({
        @Result(property = "programNum", column = "program_num"),
        @Result(property = "programName", column = "program_name"),
        @Result(property = "programType", column = "program_type"),
        @Result(property = "difficulty", column = "difficulty"),
        @Result(property = "duration", column = "duration"),
        @Result(property = "description", column = "description"),
        @Result(property = "instructor", column = "instructor"),
        @Result(property = "price", column = "final_price"),
        @Result(property = "targetAudience", column = "target_audience"),
        @Result(property = "equipment", column = "equipment"),
        @Result(property = "schedule", column = "schedule"),
        @Result(property = "chainNum", column = "chain_num"),
        @Result(property = "chainName", column = "chain_name"),
        @Result(property = "chainAddress", column = "chain_address"),
        @Result(property = "chainPhone", column = "chain_phone"),
        @Result(property = "programRoom", column = "program_room"),
        @Result(property = "operatingDays", column = "operating_days"),
        @Result(property = "operatingTime", column = "operating_time"),
        @Result(property = "holidayInfo", column = "holiday_info"),
        @Result(property = "maxCapacity", column = "max_capacity"),
        @Result(property = "currentEnrollment", column = "current_enrollment"),
        @Result(property = "availableSpots", column = "available_spots"),
        @Result(property = "enrollmentStatus", column = "enrollment_status"),
        @Result(property = "chainPrice", column = "final_price"),
        @Result(property = "imagePath", column = "image_path")
    })
    @Select("SELECT * FROM v_chain_programs WHERE program_num = #{programNum}")
    ChainProgramVO selectChainProgramDetail(Long programNum);
    
    /**
     * 등록 가능한 프로그램만 조회
     */
    @Results({
        @Result(property = "programNum", column = "program_num"),
        @Result(property = "programName", column = "program_name"),
        @Result(property = "programType", column = "program_type"),
        @Result(property = "difficulty", column = "difficulty"),
        @Result(property = "chainNum", column = "chain_num"),
        @Result(property = "chainName", column = "chain_name"),
        @Result(property = "chainAddress", column = "chain_address"),
        @Result(property = "programRoom", column = "program_room"),
        @Result(property = "operatingDays", column = "operating_days"),
        @Result(property = "operatingTime", column = "operating_time"),
        @Result(property = "maxCapacity", column = "max_capacity"),
        @Result(property = "currentEnrollment", column = "current_enrollment"),
        @Result(property = "availableSpots", column = "available_spots"),
        @Result(property = "enrollmentStatus", column = "enrollment_status"),
        @Result(property = "chainPrice", column = "final_price")
    })
    @Select("SELECT * FROM v_chain_programs WHERE enrollment_status IN ('AVAILABLE', 'ALMOST_FULL') ORDER BY chain_name")
    List<ChainProgramVO> selectAvailablePrograms();
    
    /**
     * 인기 체인점 프로그램 조회 (등록자 수 기준)
     */
    @Results({
        @Result(property = "programNum", column = "program_num"),
        @Result(property = "programName", column = "program_name"),
        @Result(property = "programType", column = "program_type"),
        @Result(property = "difficulty", column = "difficulty"),
        @Result(property = "chainNum", column = "chain_num"),
        @Result(property = "chainName", column = "chain_name"),
        @Result(property = "chainAddress", column = "chain_address"),
        @Result(property = "currentEnrollment", column = "current_enrollment"),
        @Result(property = "chainPrice", column = "final_price")
    })
    @Select("SELECT * FROM v_chain_programs ORDER BY current_enrollment DESC FETCH FIRST #{limit} ROWS ONLY")
    List<ChainProgramVO> selectPopularChainPrograms(int limit);
    
    // ===== 프로그램 등록 관련 =====
    
    /**
     * 체인점 프로그램 신청 (기존 테이블 확장 사용)
     */
    @Insert("INSERT INTO hk_design_body_enrollments (user_num, program_num, chain_num, start_date, end_date, payment_id) " +
            "VALUES (#{userNum}, #{programNum}, #{chainNum}, #{startDate}, #{endDate}, #{paymentId})")
    int insertChainProgramEnrollment(DesignBodyEnrollVO enrollment);
    
    /**
     * 프로그램 등록자 수 증가
     */
    @Update("UPDATE hk_design_body_programs SET current_enrollment = current_enrollment + 1 " +
            "WHERE program_num = #{programNum}")
    int incrementEnrollment(Long programNum);
    
    /**
     * 프로그램 등록자 수 감소
     */
    @Update("UPDATE hk_design_body_programs SET current_enrollment = current_enrollment - 1 " +
            "WHERE program_num = #{programNum} AND current_enrollment > 0")
    int decrementEnrollment(Long programNum);
    
    /**
     * 중복 등록 체크 (체인점 포함)
     */
    @Select("SELECT COUNT(*) FROM hk_design_body_enrollments " +
            "WHERE user_num = #{userNum} AND program_num = #{programNum} " +
            "AND chain_num = #{chainNum} AND status = 'ACTIVE' AND end_date >= SYSDATE")
    int checkDuplicateChainEnrollment(@Param("userNum") Long userNum, 
                                     @Param("programNum") Long programNum,
                                     @Param("chainNum") Long chainNum);
    
    /**
     * 사용자의 체인점 프로그램 등록 내역 조회
     */
    @Results({
        @Result(property = "enrollNum", column = "enroll_num"),
        @Result(property = "userNum", column = "user_num"),
        @Result(property = "programNum", column = "program_num"),
        @Result(property = "chainNum", column = "chain_num"),
        @Result(property = "startDate", column = "start_date"),
        @Result(property = "endDate", column = "end_date"),
        @Result(property = "status", column = "status"),
        @Result(property = "paymentId", column = "payment_id"),
        @Result(property = "enrollDate", column = "enroll_date"),
        @Result(property = "username", column = "username"),
        @Result(property = "programName", column = "program_name"),
        @Result(property = "programType", column = "program_type"),
        @Result(property = "instructor", column = "instructor"),
        @Result(property = "price", column = "price")
    })
    @Select("SELECT e.enroll_num, e.user_num, e.program_num, e.chain_num, " +
            "e.start_date, e.end_date, e.status, e.payment_id, e.enroll_date, " +
            "u.username, p.program_name, p.program_type, p.instructor, " +
            "NVL(p.chain_price, p.price) as price, " +
            "c.chain_name, c.address as chain_address " +
            "FROM hk_design_body_enrollments e " +
            "JOIN hk_users u ON e.user_num = u.user_num " +
            "JOIN hk_design_body_programs p ON e.program_num = p.program_num " +
            "JOIN hk_chains c ON e.chain_num = c.chain_num " +
            "WHERE e.user_num = #{userNum} ORDER BY e.enroll_date DESC")
    List<DesignBodyEnrollVO> selectUserChainEnrollments(Long userNum);
    
    // ===== 체인점별 통계 =====
    
    /**
     * 체인점별 프로그램 통계
     */
    @Select("SELECT * FROM v_chain_program_stats ORDER BY chain_name")
    List<java.util.Map<String, Object>> selectChainProgramStats();
    
    /**
     * 체인점의 총 등록자 수
     */
    @Select("SELECT SUM(current_enrollment) FROM hk_design_body_programs WHERE chain_num = #{chainNum} AND is_active = 'Y'")
    Integer getTotalEnrollmentByChain(Long chainNum);
    
    /**
     * 체인점의 평균 등록률
     */
    @Select("SELECT ROUND(AVG(current_enrollment * 100.0 / max_capacity), 2) " +
            "FROM hk_design_body_programs WHERE chain_num = #{chainNum} AND is_active = 'Y' AND max_capacity > 0")
    Double getAverageEnrollmentRateByChain(Long chainNum);
    
    // ===== 검색 및 필터링 =====
    
    /**
     * 키워드로 체인점 프로그램 검색
     */
    @Results({
        @Result(property = "programNum", column = "program_num"),
        @Result(property = "programName", column = "program_name"),
        @Result(property = "programType", column = "program_type"),
        @Result(property = "difficulty", column = "difficulty"),
        @Result(property = "chainNum", column = "chain_num"),
        @Result(property = "chainName", column = "chain_name"),
        @Result(property = "chainAddress", column = "chain_address"),
        @Result(property = "instructor", column = "instructor"),
        @Result(property = "chainPrice", column = "final_price"),
        @Result(property = "description", column = "description")
    })
    @Select("SELECT * FROM v_chain_programs " +
            "WHERE program_name LIKE '%'||#{keyword}||'%' " +
            "   OR chain_name LIKE '%'||#{keyword}||'%' " +
            "   OR instructor LIKE '%'||#{keyword}||'%' " +
            "   OR description LIKE '%'||#{keyword}||'%' " +
            "ORDER BY chain_name, program_name")
    List<ChainProgramVO> searchChainPrograms(String keyword);
    
    /**
     * 지역별 프로그램 검색
     */
    @Results({
        @Result(property = "programNum", column = "program_num"),
        @Result(property = "programName", column = "program_name"),
        @Result(property = "programType", column = "program_type"),
        @Result(property = "chainNum", column = "chain_num"),
        @Result(property = "chainName", column = "chain_name"),
        @Result(property = "chainAddress", column = "chain_address"),
        @Result(property = "chainPrice", column = "final_price")
    })
    @Select("SELECT * FROM v_chain_programs " +
            "WHERE chain_address LIKE '%'||#{region}||'%' " +
            "ORDER BY chain_name")
    List<ChainProgramVO> selectProgramsByRegion(String region);
    
    // ===== 좌표 기반 검색 (기존 ChainDAO와 연계) =====
    
    /**
     * 좌표 정보가 있는 체인점 프로그램 조회 (거리 계산용)
     */
    @Results({
        @Result(property = "programNum", column = "program_num"),
        @Result(property = "programName", column = "program_name"),
        @Result(property = "programType", column = "program_type"),
        @Result(property = "chainNum", column = "chain_num"),
        @Result(property = "chainName", column = "chain_name"),
        @Result(property = "chainAddress", column = "chain_address"),
        @Result(property = "chainLatitude", column = "latitude"),
        @Result(property = "chainLongitude", column = "longitude"),
        @Result(property = "chainPrice", column = "final_price"),
        @Result(property = "enrollmentStatus", column = "enrollment_status"),
        @Result(property = "chainPhone", column = "chain_phone")
    })
    @Select("SELECT p.program_num, p.program_name, p.program_type, " +
            "       p.chain_num, p.chain_name, p.chain_address, " +
            "       c.latitude, c.longitude, p.final_price, p.enrollment_status " +
            "FROM v_chain_programs p " +
            "JOIN hk_chains c ON p.chain_num = c.chain_num " +
            "WHERE c.latitude IS NOT NULL AND c.longitude IS NOT NULL")
    List<ChainProgramVO> selectProgramsWithCoordinates();
    
    
}