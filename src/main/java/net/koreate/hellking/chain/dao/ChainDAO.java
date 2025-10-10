package net.koreate.hellking.chain.dao;

<<<<<<< HEAD
import org.apache.ibatis.annotations.*;
import net.koreate.hellking.chain.vo.ChainVO;
import java.util.List;
=======
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Options;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Result;
import org.apache.ibatis.annotations.Results;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import net.koreate.hellking.chain.vo.ChainVO;
>>>>>>> b65c320 (Initial commit)

@Mapper
public interface ChainDAO {
    
<<<<<<< HEAD
    // 검색 기능 - 수정된 버전
=======
    // ===== 인근 가맹점 검색용 메서드 (Oracle 함수 없는 버전) =====
    
    // 좌표가 있는 모든 가맹점 조회 (거리 계산은 Java에서 처리)
	@Results({
	    @Result(property = "chainNum", column = "chain_num"),
	    @Result(property = "chainName", column = "chain_name"),
	    @Result(property = "address", column = "address"),
	    @Result(property = "phone", column = "phone"),
	    @Result(property = "imagePath", column = "image_path"),
	    @Result(property = "latitude", column = "latitude"),
	    @Result(property = "longitude", column = "longitude"),
	    @Result(property = "chainCode", column = "chain_code"),
	    @Result(property = "avgRating", column = "avg_rating"),      // 추가
	    @Result(property = "reviewCount", column = "review_count"),  // 추가
	    @Result(property = "createdAt", column = "created_at")
	})
	@Select("SELECT c.chain_num, c.chain_name, c.address, c.phone, c.image_path, " +
	        "       c.latitude, c.longitude, cc.chain_code, c.created_at, " +
	        "       c.avg_rating, c.review_count " +  // 추가
	        "FROM hk_chains c " +
	        "JOIN hk_chain_codes cc ON c.chain_num = cc.chain_num " +
	        "WHERE c.latitude IS NOT NULL AND c.longitude IS NOT NULL " +
	        "  AND cc.is_active = 'Y' " +
	        "ORDER BY c.chain_name")
	List<ChainVO> findAllChainsWithCoordinates();
    
    // ===== 기본 CRUD 메서드들 =====
    
    // 검색 기능
>>>>>>> b65c320 (Initial commit)
    @Results({
        @Result(property = "chainNum", column = "chain_num"),
        @Result(property = "chainName", column = "chain_name"),
        @Result(property = "address", column = "address"),
        @Result(property = "phone", column = "phone"),
        @Result(property = "imagePath", column = "image_path"),
<<<<<<< HEAD
        @Result(property = "createdAt", column = "created_at")
    })
    @Select("SELECT * FROM (" +
            "  SELECT chain_num, chain_name, address, phone, image_path, created_at, " +
=======
        @Result(property = "latitude", column = "latitude"),
        @Result(property = "longitude", column = "longitude"),
        @Result(property = "createdAt", column = "created_at")
    })
    @Select("SELECT * FROM (" +
            "  SELECT chain_num, chain_name, address, phone, image_path, " +
            "         latitude, longitude, created_at, " +
>>>>>>> b65c320 (Initial commit)
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
    
<<<<<<< HEAD
    // 기본 CRUD - 명시적 매핑
=======
    // 전체 가맹점 조회
>>>>>>> b65c320 (Initial commit)
    @Results({
        @Result(property = "chainNum", column = "chain_num"),
        @Result(property = "chainName", column = "chain_name"),
        @Result(property = "address", column = "address"),
        @Result(property = "phone", column = "phone"),
        @Result(property = "description", column = "description"),
        @Result(property = "imagePath", column = "image_path"),
<<<<<<< HEAD
        @Result(property = "createdAt", column = "created_at")
    })
    @Select("SELECT * FROM hk_chains ORDER BY chain_name")
    List<ChainVO> selectAllChains();
    
=======
        @Result(property = "latitude", column = "latitude"),
        @Result(property = "longitude", column = "longitude"),
        @Result(property = "avgRating", column = "avg_rating"),      // 추가
        @Result(property = "reviewCount", column = "review_count"),  // 추가
        @Result(property = "createdAt", column = "created_at")
    })
    @Select("SELECT c.*, c.avg_rating, c.review_count FROM hk_chains c ORDER BY c.chain_name")
    List<ChainVO> selectAllChains();
    
    // 가맹점 번호로 조회
>>>>>>> b65c320 (Initial commit)
    @Results({
        @Result(property = "chainNum", column = "chain_num"),
        @Result(property = "chainName", column = "chain_name"),
        @Result(property = "address", column = "address"),
        @Result(property = "phone", column = "phone"),
        @Result(property = "description", column = "description"),
        @Result(property = "imagePath", column = "image_path"),
<<<<<<< HEAD
        @Result(property = "createdAt", column = "created_at")
    })
    @Select("SELECT * FROM hk_chains WHERE chain_num = #{chainNum}")
    ChainVO selectByChainNum(Long chainNum);
    
=======
        @Result(property = "latitude", column = "latitude"),
        @Result(property = "longitude", column = "longitude"),
        @Result(property = "avgRating", column = "avg_rating"),      // 추가
        @Result(property = "reviewCount", column = "review_count"),  // 추가
        @Result(property = "createdAt", column = "created_at")
    })
    @Select("SELECT c.*, c.avg_rating, c.review_count FROM hk_chains c WHERE c.chain_num = #{chainNum}")
    ChainVO selectByChainNum(Long chainNum);
    
    // 가맹점 코드로 조회
>>>>>>> b65c320 (Initial commit)
    @Results({
        @Result(property = "chainNum", column = "chain_num"),
        @Result(property = "chainName", column = "chain_name"),
        @Result(property = "address", column = "address"),
        @Result(property = "phone", column = "phone"),
        @Result(property = "description", column = "description"),
        @Result(property = "imagePath", column = "image_path"),
<<<<<<< HEAD
=======
        @Result(property = "latitude", column = "latitude"),
        @Result(property = "longitude", column = "longitude"),
>>>>>>> b65c320 (Initial commit)
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
<<<<<<< HEAD
=======
        @Result(property = "latitude", column = "latitude"),
        @Result(property = "longitude", column = "longitude"),
>>>>>>> b65c320 (Initial commit)
        @Result(property = "createdAt", column = "created_at")
    })
    @Select("SELECT * FROM hk_chains " +
            "WHERE address LIKE '%'||#{region}||'%' " +
            "ORDER BY chain_name")
    List<ChainVO> selectByRegion(String region);
    
<<<<<<< HEAD
    // 인기 가맹점
=======
    // 인기 가맹점 (리뷰 수 기준)
>>>>>>> b65c320 (Initial commit)
    @Results({
        @Result(property = "chainNum", column = "chain_num"),
        @Result(property = "chainName", column = "chain_name"),
        @Result(property = "address", column = "address"),
        @Result(property = "phone", column = "phone"),
        @Result(property = "imagePath", column = "image_path"),
<<<<<<< HEAD
        @Result(property = "createdAt", column = "created_at"),
        @Result(property = "reviewCount", column = "review_count")
    })
    @Select("SELECT * FROM (" +
            "  SELECT c.chain_num, c.chain_name, c.address, c.phone, c.image_path, c.created_at, " +
            "         COUNT(r.review_num) as review_count " +
            "  FROM hk_chains c " +
            "  LEFT JOIN hk_reviews r ON c.chain_num = r.chain_num " +
            "  GROUP BY c.chain_num, c.chain_name, c.address, c.phone, c.image_path, c.created_at " +
=======
        @Result(property = "latitude", column = "latitude"),
        @Result(property = "longitude", column = "longitude"),
        @Result(property = "createdAt", column = "created_at"),
        @Result(property = "reviewCount", column = "review_count"),
        @Result(property = "avgRating", column = "avg_rating")  // 추가
    })
    @Select("SELECT * FROM (" +
            "  SELECT c.chain_num, c.chain_name, c.address, c.phone, c.image_path, " +
            "         c.latitude, c.longitude, c.created_at, c.avg_rating, " +  // 추가
            "         COUNT(r.review_num) as review_count " +
            "  FROM hk_chains c " +
            "  LEFT JOIN hk_reviews r ON c.chain_num = r.chain_num " +
            "  GROUP BY c.chain_num, c.chain_name, c.address, c.phone, c.image_path, " +
            "           c.latitude, c.longitude, c.created_at, c.avg_rating " +  // 추가
>>>>>>> b65c320 (Initial commit)
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
<<<<<<< HEAD
=======
        @Result(property = "latitude", column = "latitude"),
        @Result(property = "longitude", column = "longitude"),
>>>>>>> b65c320 (Initial commit)
        @Result(property = "createdAt", column = "created_at"),
        @Result(property = "avgRating", column = "avg_rating"),
        @Result(property = "reviewCount", column = "review_count")
    })
    @Select("SELECT * FROM (" +
<<<<<<< HEAD
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
=======
            "  SELECT c.chain_num, c.chain_name, c.address, c.phone, c.image_path, " +
            "         c.latitude, c.longitude, c.created_at, " +
            "         c.avg_rating, c.review_count " +  // DB의 기존 컬럼 사용
            "  FROM hk_chains c " +
            "  WHERE c.review_count > 0 " +  // 리뷰가 있는 가맹점만
            "  ORDER BY c.avg_rating DESC" +
            ") WHERE ROWNUM <= #{limit}")
    List<ChainVO> selectTopRatedChains(int limit);
    
    // ===== 관리자용 CRUD =====
    
    // 가맹점 등록
    @Insert("INSERT INTO hk_chains (chain_name, address, phone, description, image_path, latitude, longitude) " +
            "VALUES (#{chainName}, #{address}, #{phone}, #{description}, #{imagePath}, #{latitude}, #{longitude})")
    @Options(useGeneratedKeys = true, keyProperty = "chainNum", keyColumn = "chain_num")
    int insertChain(ChainVO chain);
    
    // 가맹점 코드 등록
    @Insert("INSERT INTO hk_chain_codes (chain_num, chain_code) VALUES (#{chainNum}, #{chainCode})")
    int insertChainCode(@Param("chainNum") Long chainNum, @Param("chainCode") String chainCode);
    
    // 가맹점 수정
    @Update("UPDATE hk_chains SET chain_name = #{chainName}, address = #{address}, " +
            "phone = #{phone}, description = #{description}, image_path = #{imagePath}, " +
            "latitude = #{latitude}, longitude = #{longitude} " +
            "WHERE chain_num = #{chainNum}")
    int updateChain(ChainVO chain);
    
    // 좌표 업데이트
    @Update("UPDATE hk_chains SET latitude = #{latitude}, longitude = #{longitude} " +
            "WHERE chain_num = #{chainNum}")
    int updateCoordinates(@Param("chainNum") Long chainNum, 
                         @Param("latitude") Double latitude, 
                         @Param("longitude") Double longitude);
    
    // 좌표 정보가 없는 가맹점 조회
    @Results({
        @Result(property = "chainNum", column = "chain_num"),
        @Result(property = "chainName", column = "chain_name"),
        @Result(property = "address", column = "address")
    })
    @Select("SELECT chain_num, chain_name, address FROM hk_chains " +
            "WHERE latitude IS NULL OR longitude IS NULL")
    List<ChainVO> selectChainsWithoutCoordinates();
    
    // 가맹점 코드 삭제
    @Delete("DELETE FROM hk_chain_codes WHERE chain_num = #{chainNum}")
    int deleteChainCode(Long chainNum);
    
    // 가맹점 삭제
    @Delete("DELETE FROM hk_chains WHERE chain_num = #{chainNum}")
    int deleteChain(Long chainNum);
    
    // ===== 통계 =====
    
    // 전체 가맹점 수
    @Select("SELECT COUNT(*) FROM hk_chains")
    int getTotalChainCount();
    
    // 전체 지역 수
    @Select("SELECT COUNT(DISTINCT SUBSTR(address, 1, 10)) FROM hk_chains")
    int getTotalRegionCount();
    
    // 좌표 정보가 있는 가맹점 수
    @Select("SELECT COUNT(*) FROM hk_chains WHERE latitude IS NOT NULL AND longitude IS NOT NULL")
    int getChainsWithCoordinatesCount();
    
 // 평점별 가맹점 순위 조회
    @Select("SELECT c.*, RANK() OVER (ORDER BY c.avg_rating DESC) as rating_rank " +
            "FROM hk_chains c WHERE c.review_count >= 3 ORDER BY c.avg_rating DESC")
    List<ChainVO> selectChainsByRatingRank();

    // 평점 변화 추적 (일별/주별)
    @Select("SELECT DATE(created_at) as date, AVG(rating) as daily_avg " +
            "FROM hk_reviews WHERE chain_num = #{chainNum} " +
            "AND created_at >= SYSDATE - 30 GROUP BY DATE(created_at)")
    List<Map<String, Object>> getChainRatingTrend(@Param("chainNum") Long chainNum);	
    
    @Results({
        @Result(property = "chainNum", column = "chain_num"),
        @Result(property = "chainName", column = "chain_name"),
        @Result(property = "address", column = "address"),
        @Result(property = "phone", column = "phone"),
        @Result(property = "description", column = "description"),
        @Result(property = "imagePath", column = "image_path"),
        @Result(property = "latitude", column = "latitude"),
        @Result(property = "longitude", column = "longitude"),
        @Result(property = "avgRating", column = "avg_rating"),
        @Result(property = "reviewCount", column = "review_count"),
        @Result(property = "createdAt", column = "created_at")
    })
    @Select("SELECT * FROM (" +
            "  SELECT c.*, ROW_NUMBER() OVER (" +
            "    ORDER BY " +
            "    CASE WHEN #{sortBy} = 'rating_desc' THEN c.avg_rating END DESC NULLS LAST, " +
            "    CASE WHEN #{sortBy} = 'rating_asc' THEN c.avg_rating END ASC NULLS LAST, " +
            "    CASE WHEN #{sortBy} = 'review_desc' THEN c.review_count END DESC NULLS LAST, " +
            "    CASE WHEN #{sortBy} = 'review_asc' THEN c.review_count END ASC NULLS LAST, " +
            "    CASE WHEN #{sortBy} = 'name' THEN c.chain_name END ASC NULLS LAST, " +
            "    CASE WHEN #{sortBy} = 'latest' THEN c.created_at END DESC NULLS LAST, " +
            "    c.chain_name ASC" +  // 기본 정렬
            "  ) as rn " +
            "  FROM hk_chains c" +
            ") WHERE rn > #{offset} AND rn <= #{offset} + #{size}")
    List<ChainVO> selectChainsByRatingWithPaging(@Param("sortBy") String sortBy,
                                               @Param("offset") int offset,
                                               @Param("size") int size);

    // 총 가맹점 수 조회 (필터링 없는 전체)
    @Select("SELECT COUNT(*) FROM hk_chains")
    int getTotalChainsCount();

    // 평점이 있는 가맹점 수만 조회
    @Select("SELECT COUNT(*) FROM hk_chains WHERE avg_rating IS NOT NULL AND avg_rating > 0")
    int getTotalChainsWithRatingCount();

    // 검색어 + 평점순 정렬 + 페이징
    @Results({
        @Result(property = "chainNum", column = "chain_num"),
        @Result(property = "chainName", column = "chain_name"),
        @Result(property = "address", column = "address"),
        @Result(property = "phone", column = "phone"),
        @Result(property = "description", column = "description"),
        @Result(property = "imagePath", column = "image_path"),
        @Result(property = "latitude", column = "latitude"),
        @Result(property = "longitude", column = "longitude"),
        @Result(property = "avgRating", column = "avg_rating"),
        @Result(property = "reviewCount", column = "review_count"),
        @Result(property = "createdAt", column = "created_at")
    })
    @Select("SELECT * FROM (" +
            "  SELECT c.*, ROW_NUMBER() OVER (" +
            "    ORDER BY " +
            "    CASE WHEN #{sortBy} = 'rating_desc' THEN c.avg_rating END DESC NULLS LAST, " +
            "    CASE WHEN #{sortBy} = 'rating_asc' THEN c.avg_rating END ASC NULLS LAST, " +
            "    CASE WHEN #{sortBy} = 'review_desc' THEN c.review_count END DESC NULLS LAST, " +
            "    CASE WHEN #{sortBy} = 'review_asc' THEN c.review_count END ASC NULLS LAST, " +
            "    CASE WHEN #{sortBy} = 'name' THEN c.chain_name END ASC NULLS LAST, " +
            "    CASE WHEN #{sortBy} = 'latest' THEN c.created_at END DESC NULLS LAST, " +
            "    c.chain_name ASC" +
            "  ) as rn " +
            "  FROM hk_chains c " +
            "  WHERE (#{keyword} IS NULL OR c.chain_name LIKE '%'||#{keyword}||'%' " +
            "     OR c.address LIKE '%'||#{keyword}||'%')" +
            ") WHERE rn > #{offset} AND rn <= #{offset} + #{size}")
    List<ChainVO> searchChainsWithRatingSort(@Param("keyword") String keyword,
                                           @Param("sortBy") String sortBy,
                                           @Param("offset") int offset,
                                           @Param("size") int size);

    // 검색 결과 총 개수 (정렬과 무관)
    @Select("SELECT COUNT(*) FROM hk_chains " +
            "WHERE (#{keyword} IS NULL OR chain_name LIKE '%'||#{keyword}||'%' " +
            "   OR address LIKE '%'||#{keyword}||'%')")
    int countSearchChainsTotal(@Param("keyword") String keyword);
>>>>>>> b65c320 (Initial commit)
}