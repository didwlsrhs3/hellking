package net.koreate.hellking.support.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import lombok.extern.slf4j.Slf4j;
import net.koreate.hellking.support.dao.FAQDAO;
import net.koreate.hellking.support.vo.FAQVO;
import net.koreate.hellking.support.vo.SupportSearchVO;
import java.util.List;
import java.util.Map;
import java.util.HashMap;

@Service
@Transactional
@Slf4j
public class FAQService {
    
    @Autowired
    private FAQDAO faqDAO;
    
    /**
     * FAQ 목록 조회 (페이징)
     */
    @Transactional(readOnly = true)
    public Map<String, Object> getFAQList(SupportSearchVO searchVO) {
        Map<String, Object> result = new HashMap<>();
        
        try {
            List<FAQVO> faqList;
            int totalCount;
            
            if (searchVO.hasSearch()) {
                faqList = faqDAO.selectFAQSearchList(searchVO);
                totalCount = faqDAO.selectFAQSearchTotalCount(searchVO);
            } else {
                faqList = faqDAO.selectFAQListPaging(searchVO);
                totalCount = faqDAO.selectFAQTotalCount();
            }
            
            // 페이징 정보 계산
            int totalPages = (int) Math.ceil((double) totalCount / searchVO.getPageSize());
            
            result.put("faqList", faqList);
            result.put("totalCount", totalCount);
            result.put("totalPages", totalPages);
            result.put("currentPage", searchVO.getPage());
            result.put("pageSize", searchVO.getPageSize());
            result.put("hasNext", searchVO.getPage() < totalPages);
            result.put("hasPrev", searchVO.getPage() > 1);
            
            log.info("FAQ 목록 조회 완료: 총 {}건, 현재 페이지 {}/{}", totalCount, searchVO.getPage(), totalPages);
            
        } catch (Exception e) {
            log.error("FAQ 목록 조회 중 오류: {}", e.getMessage(), e);
            throw new RuntimeException("FAQ 목록 조회에 실패했습니다.");
        }
        
        return result;
    }
    
    /**
     * FAQ 상세 조회
     */
    @Transactional
    public FAQVO getFAQDetail(Long faqNum) {
        try {
            FAQVO faq = faqDAO.selectFAQByNum(faqNum);
            if (faq == null) {
                throw new RuntimeException("존재하지 않는 FAQ입니다.");
            }
            
            // 조회수 증가
            faqDAO.updateFAQViewCount(faqNum);
            
            log.info("FAQ 상세 조회 완료: faqNum={}, title={}", faqNum, faq.getTitle());
            return faq;
            
        } catch (Exception e) {
            log.error("FAQ 상세 조회 중 오류: faqNum={}, error={}", faqNum, e.getMessage(), e);
            throw new RuntimeException("FAQ 상세 정보를 불러올 수 없습니다.");
        }
    }
    
    /**
     * FAQ 등록 (관리자만)
     */
    public boolean createFAQ(FAQVO faq) {
        try {
            if (faq.getTitle() == null || faq.getTitle().trim().isEmpty()) {
                throw new RuntimeException("FAQ 제목을 입력해주세요.");
            }
            if (faq.getContent() == null || faq.getContent().trim().isEmpty()) {
                throw new RuntimeException("FAQ 내용을 입력해주세요.");
            }
            if (faq.getCreatedBy() == null) {
                throw new RuntimeException("작성자 정보가 필요합니다.");
            }
            
            int result = faqDAO.insertFAQ(faq);
            
            if (result > 0) {
                log.info("FAQ 등록 완료: faqNum={}, title={}", faq.getFaqNum(), faq.getTitle());
                return true;
            }
            
            return false;
            
        } catch (Exception e) {
            log.error("FAQ 등록 중 오류: title={}, error={}", faq.getTitle(), e.getMessage(), e);
            throw new RuntimeException("FAQ 등록에 실패했습니다: " + e.getMessage());
        }
    }
    
    /**
     * FAQ 수정 (관리자만)
     */
    public boolean updateFAQ(FAQVO faq) {
        try {
            if (faq.getFaqNum() == null) {
                throw new RuntimeException("FAQ 번호가 필요합니다.");
            }
            if (faq.getTitle() == null || faq.getTitle().trim().isEmpty()) {
                throw new RuntimeException("FAQ 제목을 입력해주세요.");
            }
            if (faq.getContent() == null || faq.getContent().trim().isEmpty()) {
                throw new RuntimeException("FAQ 내용을 입력해주세요.");
            }
            
            // 기존 FAQ 존재 확인
            FAQVO existingFAQ = faqDAO.selectFAQByNum(faq.getFaqNum());
            if (existingFAQ == null) {
                throw new RuntimeException("존재하지 않는 FAQ입니다.");
            }
            
            int result = faqDAO.updateFAQ(faq);
            
            if (result > 0) {
                log.info("FAQ 수정 완료: faqNum={}, title={}", faq.getFaqNum(), faq.getTitle());
                return true;
            }
            
            return false;
            
        } catch (Exception e) {
            log.error("FAQ 수정 중 오류: faqNum={}, error={}", faq.getFaqNum(), e.getMessage(), e);
            throw new RuntimeException("FAQ 수정에 실패했습니다: " + e.getMessage());
        }
    }
    
    /**
     * FAQ 삭제 (관리자만)
     */
    public boolean deleteFAQ(Long faqNum) {
        try {
            if (faqNum == null) {
                throw new RuntimeException("FAQ 번호가 필요합니다.");
            }
            
            // 기존 FAQ 존재 확인
            FAQVO existingFAQ = faqDAO.selectFAQByNum(faqNum);
            if (existingFAQ == null) {
                throw new RuntimeException("존재하지 않는 FAQ입니다.");
            }
            
            int result = faqDAO.deleteFAQ(faqNum);
            
            if (result > 0) {
                log.info("FAQ 삭제 완료: faqNum={}, title={}", faqNum, existingFAQ.getTitle());
                return true;
            }
            
            return false;
            
        } catch (Exception e) {
            log.error("FAQ 삭제 중 오류: faqNum={}, error={}", faqNum, e.getMessage(), e);
            throw new RuntimeException("FAQ 삭제에 실패했습니다: " + e.getMessage());
        }
    }
}