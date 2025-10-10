package net.koreate.hellking.support.dao;

import java.util.Map;

import org.apache.ibatis.jdbc.SQL;

/**
 * 상담예약 동적 SQL Provider
 */
public class ConsultationSqlProvider {
    
    /**
     * 관리자용 상담예약 목록 조회 (페이징)
     */
    public String selectConsultationsForAdmin(Map<String, Object> params) {
        return new SQL() {{
            SELECT("c.consultation_num, c.user_num, c.consultation_date, c.consultation_time");
            SELECT("c.name, c.phone, c.email, c.content, c.status, c.created_at, c.updated_at");
            SELECT("u.username, u.user_id, ROWNUM rn");
            FROM("(SELECT c.*, u.username, u.user_id FROM hk_consultation c " +
                 "LEFT JOIN hk_users u ON c.user_num = u.user_num");
            
            WHERE("1=1");
            
            if (params.get("status") != null && !params.get("status").toString().isEmpty()) {
                WHERE("c.status = #{status}");
            }
            
            if (params.get("searchType") != null && params.get("searchKeyword") != null) {
                String searchType = params.get("searchType").toString();
                if (!searchType.isEmpty() && !params.get("searchKeyword").toString().isEmpty()) {
                    switch (searchType) {
                        case "name":
                            WHERE("c.name LIKE '%' || #{searchKeyword} || '%'");
                            break;
                        case "phone":
                            WHERE("c.phone LIKE '%' || #{searchKeyword} || '%'");
                            break;
                        case "email":
                            WHERE("c.email LIKE '%' || #{searchKeyword} || '%'");
                            break;
                        case "userId":
                            WHERE("u.user_id LIKE '%' || #{searchKeyword} || '%'");
                            break;
                    }
                }
            }
            
            if (params.get("startDate") != null) {
                WHERE("c.consultation_date >= #{startDate}");
            }
            
            if (params.get("endDate") != null) {
                WHERE("c.consultation_date <= #{endDate}");
            }
            
            ORDER_BY("c.consultation_date DESC, c.consultation_time DESC) a");
            WHERE("ROWNUM <= #{endRow}");
        }}.toString() + " WHERE rn >= #{startRow}";
    }
    
    /**
     * 관리자용 상담예약 총 개수
     */
    public String selectConsultationCountForAdmin(Map<String, Object> params) {
        return new SQL() {{
            SELECT("COUNT(*)");
            FROM("hk_consultation c");
            LEFT_OUTER_JOIN("hk_users u ON c.user_num = u.user_num");
            
            WHERE("1=1");
            
            if (params.get("status") != null && !params.get("status").toString().isEmpty()) {
                WHERE("c.status = #{status}");
            }
            
            if (params.get("searchType") != null && params.get("searchKeyword") != null) {
                String searchType = params.get("searchType").toString();
                if (!searchType.isEmpty() && !params.get("searchKeyword").toString().isEmpty()) {
                    switch (searchType) {
                        case "name":
                            WHERE("c.name LIKE '%' || #{searchKeyword} || '%'");
                            break;
                        case "phone":
                            WHERE("c.phone LIKE '%' || #{searchKeyword} || '%'");
                            break;
                        case "email":
                            WHERE("c.email LIKE '%' || #{searchKeyword} || '%'");
                            break;
                        case "userId":
                            WHERE("u.user_id LIKE '%' || #{searchKeyword} || '%'");
                            break;
                    }
                }
            }
            
            if (params.get("startDate") != null) {
                WHERE("c.consultation_date >= #{startDate}");
            }
            
            if (params.get("endDate") != null) {
                WHERE("c.consultation_date <= #{endDate}");
            }
        }}.toString();
    }
}