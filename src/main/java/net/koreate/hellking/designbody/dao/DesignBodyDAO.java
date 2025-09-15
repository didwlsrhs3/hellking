package net.koreate.hellking.designbody.dao;

import org.apache.ibatis.annotations.*;
import net.koreate.hellking.designbody.vo.*;
import java.util.List;

@Mapper
public interface DesignBodyDAO {
    
    // 프로그램 기본 CRUD - 컬럼명 명시적 매핑
    @Select("SELECT program_num as programNum, program_name as programName, " +
            "program_type as programType, difficulty, duration, description, " +
            "instructor, image_path as imagePath, price, target_audience as targetAudience, " +
            "equipment, schedule, is_active as isActive, created_at as createdAt " +
            "FROM hk_design_body_programs " +
            "WHERE is_active = 'Y' " +
            "ORDER BY created_at DESC")
    List<DesignBodyVO> selectAllPrograms();
    
    @Select("SELECT program_num as programNum, program_name as programName, " +
            "program_type as programType, difficulty, duration, description, " +
            "instructor, image_path as imagePath, price, target_audience as targetAudience, " +
            "equipment, schedule, is_active as isActive, created_at as createdAt " +
            "FROM hk_design_body_programs WHERE program_num = #{programNum}")
    DesignBodyVO selectByProgramNum(Long programNum);
    
    // 타입별 프로그램
    @Select("SELECT program_num as programNum, program_name as programName, " +
            "program_type as programType, difficulty, duration, description, " +
            "instructor, image_path as imagePath, price, target_audience as targetAudience, " +
            "equipment, schedule, is_active as isActive, created_at as createdAt " +
            "FROM hk_design_body_programs " +
            "WHERE program_type = #{programType} AND is_active = 'Y' " +
            "ORDER BY created_at DESC")
    List<DesignBodyVO> selectByType(String programType);
    
    // 난이도별 프로그램
    @Select("SELECT program_num as programNum, program_name as programName, " +
            "program_type as programType, difficulty, duration, description, " +
            "instructor, image_path as imagePath, price, target_audience as targetAudience, " +
            "equipment, schedule, is_active as isActive, created_at as createdAt " +
            "FROM hk_design_body_programs " +
            "WHERE difficulty = #{difficulty} AND is_active = 'Y' " +
            "ORDER BY created_at DESC")
    List<DesignBodyVO> selectByDifficulty(String difficulty);
    
    // 인기 프로그램 (신청자 많은 순) - 간소화
    @Select("SELECT program_num as programNum, program_name as programName, " +
            "program_type as programType, difficulty, duration, description, " +
            "instructor, image_path as imagePath, price, target_audience as targetAudience, " +
            "equipment, schedule, is_active as isActive, created_at as createdAt " +
            "FROM hk_design_body_programs " +
            "WHERE is_active = 'Y' " +
            "ORDER BY created_at DESC " +
            "FETCH FIRST #{limit} ROWS ONLY")
    List<DesignBodyVO> selectPopularPrograms(int limit);
    
    // 신청 관련
    @Insert("INSERT INTO hk_design_body_enrollments (user_num, program_num, start_date, end_date, payment_id) " +
            "VALUES (#{userNum}, #{programNum}, #{startDate}, #{endDate}, #{paymentId})")
    int insertEnrollment(DesignBodyEnrollVO enrollment);
    
    @Select("SELECT e.enroll_num as enrollNum, e.user_num as userNum, e.program_num as programNum, " +
            "e.start_date as startDate, e.end_date as endDate, e.status, e.payment_id as paymentId, " +
            "e.enroll_date as enrollDate, u.username, p.program_name as programName, " +
            "p.program_type as programType, p.instructor, p.price " +
            "FROM hk_design_body_enrollments e " +
            "JOIN hk_users u ON e.user_num = u.user_num " +
            "JOIN hk_design_body_programs p ON e.program_num = p.program_num " +
            "WHERE e.user_num = #{userNum} " +
            "ORDER BY e.enroll_date DESC")
    List<DesignBodyEnrollVO> selectUserEnrollments(Long userNum);
    
    @Select("SELECT e.enroll_num as enrollNum, e.user_num as userNum, e.program_num as programNum, " +
            "e.start_date as startDate, e.end_date as endDate, e.status, e.payment_id as paymentId, " +
            "e.enroll_date as enrollDate, u.username, p.program_name as programName " +
            "FROM hk_design_body_enrollments e " +
            "JOIN hk_users u ON e.user_num = u.user_num " +
            "JOIN hk_design_body_programs p ON e.program_num = p.program_num " +
            "WHERE e.user_num = #{userNum} AND e.status = 'ACTIVE' " +
            "AND e.end_date >= SYSDATE")
    List<DesignBodyEnrollVO> selectActiveEnrollments(Long userNum);
    
    // 중복 신청 체크
    @Select("SELECT COUNT(*) FROM hk_design_body_enrollments " +
            "WHERE user_num = #{userNum} AND program_num = #{programNum} " +
            "AND status = 'ACTIVE' AND end_date >= SYSDATE")
    int checkDuplicateEnrollment(@Param("userNum") Long userNum, @Param("programNum") Long programNum);
    
    // 관리자용
    @Insert("INSERT INTO hk_design_body_programs (program_name, program_type, difficulty, duration, " +
            "description, instructor, image_path, price, target_audience, equipment, schedule) " +
            "VALUES (#{programName}, #{programType}, #{difficulty}, #{duration}, #{description}, " +
            "#{instructor}, #{imagePath}, #{price}, #{targetAudience}, #{equipment}, #{schedule})")
    int insertProgram(DesignBodyVO program);
    
    @Update("UPDATE hk_design_body_programs SET program_name = #{programName}, " +
            "program_type = #{programType}, difficulty = #{difficulty}, duration = #{duration}, " +
            "description = #{description}, instructor = #{instructor}, image_path = #{imagePath}, " +
            "price = #{price}, target_audience = #{targetAudience}, equipment = #{equipment}, " +
            "schedule = #{schedule} WHERE program_num = #{programNum}")
    int updateProgram(DesignBodyVO program);
    
    @Update("UPDATE hk_design_body_programs SET is_active = 'N' WHERE program_num = #{programNum}")
    int deleteProgram(Long programNum);
    
    // 통계
    @Select("SELECT COUNT(*) FROM hk_design_body_programs WHERE is_active = 'Y'")
    int getTotalProgramCount();
    
    @Select("SELECT COUNT(*) FROM hk_design_body_enrollments WHERE status = 'ACTIVE'")
    int getActiveEnrollmentCount();
}