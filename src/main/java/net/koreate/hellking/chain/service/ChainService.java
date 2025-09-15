package net.koreate.hellking.chain.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import net.koreate.hellking.chain.dao.ChainDAO;
import net.koreate.hellking.chain.vo.ChainVO;
import net.koreate.hellking.chain.vo.ChainSearchVO;
import net.koreate.hellking.common.exception.HellkingException;
import java.util.List;
import java.util.HashMap;
import java.util.Map;

@Service
@Transactional
public class ChainService {
    
    @Autowired
    private ChainDAO chainDAO;
    
    // 전체 가맹점 목록
    public List<ChainVO> getAllChains() {
        return chainDAO.selectAllChains();
    }
    
    // 가맹점 상세 정보
    public ChainVO getChainDetail(Long chainNum) {
        ChainVO chain = chainDAO.selectByChainNum(chainNum);
        if (chain == null) {
            throw new HellkingException("존재하지 않는 가맹점입니다.");
        }
        return chain;
    }
    
    // 가맹점 코드로 조회
    public ChainVO getChainByCode(String chainCode) {
        ChainVO chain = chainDAO.selectByChainCode(chainCode);
        if (chain == null) {
            throw new HellkingException("존재하지 않는 가맹점 코드입니다: " + chainCode);
        }
        return chain;
    }
    
    // 가맹점 검색 - 수정된 버전
    public Map<String, Object> searchChains(ChainSearchVO searchVO) {
        searchVO.setDefaults();
        
        // DAO 호출 시 3개 파라미터만 전달
        List<ChainVO> chains = chainDAO.searchChains(
            searchVO.getKeyword(), 
            searchVO.getOffset(), 
            searchVO.getSize()
        );
        
        int totalCount = chainDAO.countSearchResults(searchVO.getKeyword());
        int totalPages = (int) Math.ceil((double) totalCount / searchVO.getSize());
        
        Map<String, Object> result = new HashMap<>();
        result.put("chains", chains);
        result.put("currentPage", searchVO.getPage());
        result.put("totalPages", totalPages);
        result.put("totalCount", totalCount);
        result.put("hasNext", searchVO.getPage() < totalPages);
        result.put("hasPrev", searchVO.getPage() > 1);
        
        System.out.println("=== ChainService.searchChains 결과 ===");
        System.out.println("검색어: " + searchVO.getKeyword());
        System.out.println("검색 결과 수: " + chains.size());
        System.out.println("총 개수: " + totalCount);
        if (!chains.isEmpty()) {
            System.out.println("첫 번째 결과: " + chains.get(0).getChainName());
        }
        System.out.println("=====================================");
        
        return result;
    }
    
    // 지역별 가맹점
    public List<ChainVO> getChainsByRegion(String region) {
        return chainDAO.selectByRegion(region);
    }
    
    // 인기 가맹점
    public List<ChainVO> getPopularChains(int limit) {
        return chainDAO.selectPopularChains(limit);
    }
    
    // 최고 평점 가맹점
    public List<ChainVO> getTopRatedChains(int limit) {
        return chainDAO.selectTopRatedChains(limit);
    }
    
    // 메인 페이지용 추천 가맹점
    public Map<String, Object> getRecommendedChains() {
        Map<String, Object> result = new HashMap<>();
        result.put("popular", getPopularChains(6));
        result.put("topRated", getTopRatedChains(6));
        return result;
    }
    
    // 가맹점 등록 (관리자용)
    public boolean registerChain(ChainVO chain, String chainCode) {
        try {
            int result = chainDAO.insertChain(chain);
            if (result > 0 && chain.getChainNum() != null) {
                chainDAO.insertChainCode(chain.getChainNum(), chainCode);
                return true;
            }
            return false;
        } catch (Exception e) {
            throw new HellkingException("가맹점 등록 중 오류가 발생했습니다: " + e.getMessage());
        }
    }
    
    // 가맹점 수정 (관리자용)
    public boolean updateChain(ChainVO chain) {
        try {
            return chainDAO.updateChain(chain) > 0;
        } catch (Exception e) {
            throw new HellkingException("가맹점 정보 수정 중 오류가 발생했습니다: " + e.getMessage());
        }
    }
    
    // 가맹점 삭제 (관리자용)
    @Transactional
    public boolean deleteChain(Long chainNum) {
        try {
            chainDAO.deleteChainCode(chainNum);
            return chainDAO.deleteChain(chainNum) > 0;
        } catch (Exception e) {
            throw new HellkingException("가맹점 삭제 중 오류가 발생했습니다: " + e.getMessage());
        }
    }
    
    // 통계 정보
    public Map<String, Object> getStatistics() {
        Map<String, Object> stats = new HashMap<>();
        stats.put("totalChains", chainDAO.getTotalChainCount());
        stats.put("totalRegions", chainDAO.getTotalRegionCount());
        return stats;
    }
    
    // 가맹점 코드 유효성 검사
    public boolean isValidChainCode(String chainCode) {
        if (chainCode == null || chainCode.length() != 4) {
            return false;
        }
        try {
            ChainVO chain = chainDAO.selectByChainCode(chainCode);
            return chain != null;
        } catch (Exception e) {
            return false;
        }
    }
}