package net.koreate.hellking.chain.dao;

import org.apache.ibatis.annotations.*;
import net.koreate.hellking.chain.vo.ChainVO;
import java.util.List;

@Mapper
public interface ChainDAO {
    
    // 검색 기능 - 수정된 버전
    @Results({
        @Result(property = "chainNum", column = "chain_num"),
        @Result(property = "chainName", column = "chain_name"),
        @Result(property = "address", column = "address"),
        @Result(property = "phone", column = "phone"),
        @Result(property = "imagePath", column = "image_path"),
        @Result(property = "createdAt", column = "created_at")
    })
    @Select("SELECT * FROM (" +
            "  SELECT chain_num, chain_name, address, phone, image_path, created_at, " +
            "         ROW_NUMBER() OVER (ORDER BY chain_name) as rn " +
            "  FROM hk_chains " +
            "  WHERE chain_name LIKE '%'||#{keyword}||'%' " +
            "     OR address LIKE '%'||#{keyword}||'%'" +
            ") WHERE rn > #{offset} AND rn <= #{offset} + #{size}")
    List<ChainVO> searchChains(@Param("keyword") String keyword, 
                              @Param("offset") int offset, 
                              @Param("size") int size);
    
    // 검색 결과 총 개수
    @Select("SELECT COUNT(*) FROM hk_chains " +
            "WHERE chain_name LIKE '%'||#{keyword}||'%' " +
            "   OR address LIKE '%'||#{keyword}||'%'")
    int countSearchResults(String keyword);
    
    // 기본 CRUD - 명시적 매핑
    @Results({
        @Result(property = "chainNum", column = "chain_num"),
        @Result(property = "chainName", column = "chain_name"),
        @Result(property = "address", column = "address"),
        @Result(property = "phone", column = "phone"),
        @Result(property = "description", column = "description"),
        @Result(property = "imagePath", column = "image_path"),
        @Result(property = "createdAt", column = "created_at")
    })
    @Select("SELECT * FROM hk_chains ORDER BY chain_name")
    List<ChainVO> selectAllChains();
    
    @Results({
        @Result(property = "chainNum", column = "chain_num"),
        @Result(property = "chainName", column = "chain_name"),
        @Result(property = "address", column = "address"),
        @Result(property = "phone", column = "phone"),
        @Result(property = "description", column = "description"),
        @Result(property = "imagePath", column = "image_path"),
        @Result(property = "createdAt", column = "created_at")
    })
    @Select("SELECT * FROM hk_chains WHERE chain_num = #{chainNum}")
    ChainVO selectByChainNum(Long chainNum);
    
    @Results({
        @Result(property = "chainNum", column = "chain_num"),
        @Result(property = "chainName", column = "chain_name"),
        @Result(property = "address", column = "address"),
        @Result(property = "phone", column = "phone"),
        @Result(property = "description", column = "description"),
        @Result(property = "imagePath", column = "image_path"),
        @Result(property = "createdAt", column = "created_at"),
        @Result(property = "chainCode", column = "chain_code"),
        @Result(property = "isActive", column = "is_active")
    })
    @Select("SELECT c.*, cc.chain_code, cc.is_active " +
            "FROM hk_chains c " +
            "JOIN hk_chain_codes cc ON c.chain_num = cc.chain_num " +
            "WHERE cc.chain_code = #{chainCode} AND cc.is_active = 'Y'")
    ChainVO selectByChainCode(String chainCode);
    
    // 지역별 가맹점
    @Results({
        @Result(property = "chainNum", column = "chain_num"),
        @Result(property = "chainName", column = "chain_name"),
        @Result(property = "address", column = "address"),
        @Result(property = "phone", column = "phone"),
        @Result(property = "imagePath", column = "image_path"),
        @Result(property = "createdAt", column = "created_at")
    })
    @Select("SELECT * FROM hk_chains " +
            "WHERE address LIKE '%'||#{region}||'%' " +
            "ORDER BY chain_name")
    List<ChainVO> selectByRegion(String region);
    
    // 인기 가맹점
    @Results({
        @Result(property = "chainNum", column = "chain_num"),
        @Result(property = "chainName", column = "chain_name"),
        @Result(property = "address", column = "address"),
        @Result(property = "phone", column = "phone"),
        @Result(property = "imagePath", column = "image_path"),
        @Result(property = "createdAt", column = "created_at"),
        @Result(property = "reviewCount", column = "review_count")
    })
    @Select("SELECT * FROM (" +
            "  SELECT c.chain_num, c.chain_name, c.address, c.phone, c.image_path, c.created_at, " +
            "         COUNT(r.review_num) as review_count " +
            "  FROM hk_chains c " +
            "  LEFT JOIN hk_reviews r ON c.chain_num = r.chain_num " +
            "  GROUP BY c.chain_num, c.chain_name, c.address, c.phone, c.image_path, c.created_at " +
            "  ORDER BY COUNT(r.review_num) DESC" +
            ") WHERE ROWNUM <= #{limit}")
    List<ChainVO> selectPopularChains(int limit);
    
    // 최고 평점 가맹점
    @Results({
        @Result(property = "chainNum", column = "chain_num"),
        @Result(property = "chainName", column = "chain_name"),
        @Result(property = "address", column = "address"),
        @Result(property = "phone", column = "phone"),
        @Result(property = "imagePath", column = "image_path"),
        @Result(property = "createdAt", column = "created_at"),
        @Result(property = "avgRating", column = "avg_rating"),
        @Result(property = "reviewCount", column = "review_count")
    })
    @Select("SELECT * FROM (" +
            "  SELECT c.chain_num, c.chain_name, c.address, c.phone, c.image_path, c.created_at, " +
            "         AVG(r.rating) as avg_rating, COUNT(r.review_num) as review_count " +
            "  FROM hk_chains c " +
            "  LEFT JOIN hk_reviews r ON c.chain_num = r.chain_num " +
            "  WHERE r.rating IS NOT NULL " +
            "  GROUP BY c.chain_num, c.chain_name, c.address, c.phone, c.image_path, c.created_at " +
            "  ORDER BY AVG(r.rating) DESC" +
            ") WHERE ROWNUM <= #{limit}")
    List<ChainVO> selectTopRatedChains(int limit);
    
    // 관리자용 CRUD
    @Insert("INSERT INTO hk_chains (chain_name, address, phone, description, image_path) " +
            "VALUES (#{chainName}, #{address}, #{phone}, #{description}, #{imagePath})")
    @Options(useGeneratedKeys = true, keyProperty = "chainNum", keyColumn = "chain_num")
    int insertChain(ChainVO chain);
    
    @Insert("INSERT INTO hk_chain_codes (chain_num, chain_code) VALUES (#{chainNum}, #{chainCode})")
    int insertChainCode(@Param("chainNum") Long chainNum, @Param("chainCode") String chainCode);
    
    @Update("UPDATE hk_chains SET chain_name = #{chainName}, address = #{address}, " +
            "phone = #{phone}, description = #{description}, image_path = #{imagePath} " +
            "WHERE chain_num = #{chainNum}")
    int updateChain(ChainVO chain);
    
    @Delete("DELETE FROM hk_chain_codes WHERE chain_num = #{chainNum}")
    int deleteChainCode(Long chainNum);
    
    @Delete("DELETE FROM hk_chains WHERE chain_num = #{chainNum}")
    int deleteChain(Long chainNum);
    
    // 통계
    @Select("SELECT COUNT(*) FROM hk_chains")
    int getTotalChainCount();
    
    @Select("SELECT COUNT(DISTINCT SUBSTR(address, 1, 10)) FROM hk_chains")
    int getTotalRegionCount();
}