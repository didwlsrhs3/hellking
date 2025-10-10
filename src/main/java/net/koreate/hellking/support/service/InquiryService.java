package net.koreate.hellking.support.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;
import lombok.extern.slf4j.Slf4j;
import net.koreate.hellking.support.dao.InquiryDAO;
import net.koreate.hellking.support.dao.InquiryAttachmentDAO;
import net.koreate.hellking.support.vo.InquiryVO;
import net.koreate.hellking.support.vo.InquiryAttachmentVO;
import net.koreate.hellking.support.vo.SupportSearchVO;
import net.koreate.hellking.common.utils.FileUtils;
import java.util.List;
import java.util.Map;
import java.util.HashMap;
import javax.servlet.ServletContext;
import java.io.File;

@Service
@Transactional
@Slf4j
public class InquiryService {
    
    @Autowired
    private InquiryDAO inquiryDAO;
    
    @Autowired
    private InquiryAttachmentDAO attachmentDAO;
    
    @Autowired
    private ServletContext servletContext;
    
    private String getUploadPath() {
        return servletContext.getRealPath("/upload/inquiry/");
    }
    
    /**
     * 문의사항 목록 조회 (페이징)
     */
    @Transactional(readOnly = true)
    public Map<String, Object> getInquiryList(SupportSearchVO searchVO) {
        Map<String, Object> result = new HashMap<>();
        
        try {
            // 검색 조건 유효성 검사
            if (searchVO != null) {
                searchVO.validate();
            }
            
            List<InquiryVO> inquiryList;
            int totalCount;
            
            if (searchVO.hasSearch() || (searchVO.getStatus() != null && !searchVO.getStatus().trim().isEmpty())) {
                inquiryList = inquiryDAO.selectInquirySearchList(searchVO);
                totalCount = inquiryDAO.selectInquirySearchTotalCount(searchVO);
            } else {
                inquiryList = inquiryDAO.selectInquiryListPaging(searchVO);
                totalCount = inquiryDAO.selectInquiryTotalCount();
            }
            
            // 각 문의사항에 답글 정보 추가
            for (InquiryVO inquiry : inquiryList) {
                List<InquiryVO> replies = inquiryDAO.selectInquiryReplies(inquiry.getInquiryNum());
                inquiry.setReplies(replies);
                
                // 첨부파일 정보 추가
                if (inquiry.hasAttachments()) {
                    List<InquiryAttachmentVO> attachments = attachmentDAO.selectAttachmentsByInquiryNum(inquiry.getInquiryNum());
                    inquiry.setAttachments(attachments);
                }
            }
            
            // 페이징 정보 계산
            int totalPages = (int) Math.ceil((double) totalCount / searchVO.getPageSize());
            
            result.put("inquiryList", inquiryList);
            result.put("totalCount", totalCount);
            result.put("totalPages", totalPages);
            result.put("currentPage", searchVO.getPage());
            result.put("pageSize", searchVO.getPageSize());
            result.put("hasNext", searchVO.getPage() < totalPages);
            result.put("hasPrev", searchVO.getPage() > 1);
            
            log.info("문의사항 목록 조회 완료: 총 {}건, 현재 페이지 {}/{}", totalCount, searchVO.getPage(), totalPages);
            
        } catch (Exception e) {
            log.error("문의사항 목록 조회 중 오류: {}", e.getMessage(), e);
            throw new RuntimeException("문의사항 목록 조회에 실패했습니다.");
        }
        
        return result;
    }
    
    /**
     * 문의사항 상세 조회
     */
    @Transactional
    public InquiryVO getInquiryDetail(Long inquiryNum, Long currentUserNum, boolean isAdmin) {
        try {
            InquiryVO inquiry = inquiryDAO.selectInquiryByNum(inquiryNum);
            if (inquiry == null) {
                throw new RuntimeException("존재하지 않는 문의사항입니다.");
            }
            
            // 비공개 문의사항 접근 권한 확인
            if (inquiry.isPrivateInquiry() && !isAdmin && !inquiry.getCreatedBy().equals(currentUserNum)) {
                throw new RuntimeException("접근 권한이 없습니다.");
            }
            
            // 답글 목록 조회
            List<InquiryVO> replies = inquiryDAO.selectInquiryReplies(inquiryNum);
            inquiry.setReplies(replies);
            
            // 첨부파일 목록 조회
            if (inquiry.hasAttachments()) {
                List<InquiryAttachmentVO> attachments = attachmentDAO.selectAttachmentsByInquiryNum(inquiryNum);
                inquiry.setAttachments(attachments);
            }
            
            // 조회수 증가 (원글만)
            if (inquiry.isOriginalPost()) {
                inquiryDAO.updateInquiryViewCount(inquiryNum);
            }
            
            log.info("문의사항 상세 조회 완료: inquiryNum={}, title={}", inquiryNum, inquiry.getTitle());
            return inquiry;
            
        } catch (Exception e) {
            log.error("문의사항 상세 조회 중 오류: inquiryNum={}, error={}", inquiryNum, e.getMessage(), e);
            throw new RuntimeException("문의사항 상세 정보를 불러올 수 없습니다: " + e.getMessage());
        }
    }
    
    /**
     * 문의사항 등록 (첨부파일 포함) - 기존 FileUtils와 호환
     */
    public boolean createInquiry(InquiryVO inquiry, List<MultipartFile> attachments) {
        try {
            // 입력값 검증
            if (inquiry.getTitle() == null || inquiry.getTitle().trim().isEmpty()) {
                throw new RuntimeException("문의사항 제목을 입력해주세요.");
            }
            if (inquiry.getContent() == null || inquiry.getContent().trim().isEmpty()) {
                throw new RuntimeException("문의사항 내용을 입력해주세요.");
            }
            if (inquiry.getCreatedBy() == null) {
                throw new RuntimeException("작성자 정보가 필요합니다.");
            }
            
            // 첨부파일 여부 설정
            boolean hasFiles = attachments != null && !attachments.isEmpty() && 
                             attachments.stream().anyMatch(file -> file != null && !file.isEmpty());
            inquiry.setHasAttachment(hasFiles ? "Y" : "N");
            
            // 문의사항 등록
            int result = inquiryDAO.insertInquiry(inquiry);
            
            if (result > 0) {
                // 첨부파일 처리
                if (hasFiles) {
                    processAttachments(inquiry.getInquiryNum(), attachments);
                }
                
                log.info("문의사항 등록 완료: inquiryNum={}, title={}", inquiry.getInquiryNum(), inquiry.getTitle());
                return true;
            }
            
            return false;
            
        } catch (Exception e) {
            log.error("문의사항 등록 중 오류: title={}, error={}", inquiry.getTitle(), e.getMessage(), e);
            throw new RuntimeException("문의사항 등록에 실패했습니다: " + e.getMessage());
        }
    }
    
    /**
     * 답글 등록
     */
    public boolean createReply(InquiryVO reply) {
        try {
            if (reply.getParentNum() == null) {
                throw new RuntimeException("원글 번호가 필요합니다.");
            }
            if (reply.getContent() == null || reply.getContent().trim().isEmpty()) {
                throw new RuntimeException("답글 내용을 입력해주세요.");
            }
            if (reply.getCreatedBy() == null) {
                throw new RuntimeException("작성자 정보가 필요합니다.");
            }
            
            // 원글 존재 확인
            InquiryVO originalInquiry = inquiryDAO.selectInquiryByNum(reply.getParentNum());
            if (originalInquiry == null) {
                throw new RuntimeException("존재하지 않는 원글입니다.");
            }
            
            // 답글 제목 자동 설정
            reply.setTitle("Re: " + originalInquiry.getTitle());
            reply.setIsPrivate("Y"); // 답글은 기본적으로 비공개
            reply.setHasAttachment("N");
            
            int result = inquiryDAO.insertInquiry(reply);
            
            if (result > 0) {
                log.info("답글 등록 완료: parentNum={}, inquiryNum={}", reply.getParentNum(), reply.getInquiryNum());
                return true;
            }
            
            return false;
            
        } catch (Exception e) {
            log.error("답글 등록 중 오류: parentNum={}, error={}", reply.getParentNum(), e.getMessage(), e);
            throw new RuntimeException("답글 등록에 실패했습니다: " + e.getMessage());
        }
    }
    
    /**
     * 문의사항 수정 (작성자 또는 관리자만)
     */
    public boolean updateInquiry(InquiryVO inquiry, Long currentUserNum, boolean isAdmin) {
        try {
            if (inquiry.getInquiryNum() == null) {
                throw new RuntimeException("문의사항 번호가 필요합니다.");
            }
            
            // 기존 문의사항 조회
            InquiryVO existingInquiry = inquiryDAO.selectInquiryByNum(inquiry.getInquiryNum());
            if (existingInquiry == null) {
                throw new RuntimeException("존재하지 않는 문의사항입니다.");
            }
            
            // 수정 권한 확인
            if (!isAdmin && !existingInquiry.getCreatedBy().equals(currentUserNum)) {
                throw new RuntimeException("수정 권한이 없습니다.");
            }
            
            if (inquiry.getTitle() == null || inquiry.getTitle().trim().isEmpty()) {
                throw new RuntimeException("문의사항 제목을 입력해주세요.");
            }
            if (inquiry.getContent() == null || inquiry.getContent().trim().isEmpty()) {
                throw new RuntimeException("문의사항 내용을 입력해주세요.");
            }
            
            int result = inquiryDAO.updateInquiry(inquiry);
            
            if (result > 0) {
                log.info("문의사항 수정 완료: inquiryNum={}, title={}", inquiry.getInquiryNum(), inquiry.getTitle());
                return true;
            }
            
            return false;
            
        } catch (Exception e) {
            log.error("문의사항 수정 중 오류: inquiryNum={}, error={}", inquiry.getInquiryNum(), e.getMessage(), e);
            throw new RuntimeException("문의사항 수정에 실패했습니다: " + e.getMessage());
        }
    }
    
    /**
     * 문의사항 삭제 (작성자 또는 관리자만)
     */
    public boolean deleteInquiry(Long inquiryNum, Long currentUserNum, boolean isAdmin) {
        try {
            if (inquiryNum == null) {
                throw new RuntimeException("문의사항 번호가 필요합니다.");
            }
            
            // 기존 문의사항 조회
            InquiryVO existingInquiry = inquiryDAO.selectInquiryByNum(inquiryNum);
            if (existingInquiry == null) {
                throw new RuntimeException("존재하지 않는 문의사항입니다.");
            }
            
            // 삭제 권한 확인
            if (!isAdmin && !existingInquiry.getCreatedBy().equals(currentUserNum)) {
                throw new RuntimeException("삭제 권한이 없습니다.");
            }
            
            int result = inquiryDAO.deleteInquiry(inquiryNum);
            
            if (result > 0) {
                log.info("문의사항 삭제 완료: inquiryNum={}, title={}", inquiryNum, existingInquiry.getTitle());
                return true;
            }
            
            return false;
            
        } catch (Exception e) {
            log.error("문의사항 삭제 중 오류: inquiryNum={}, error={}", inquiryNum, e.getMessage(), e);
            throw new RuntimeException("문의사항 삭제에 실패했습니다: " + e.getMessage());
        }
    }
    
    /**
     * 내 문의사항 목록 조회
     */
    @Transactional(readOnly = true)
    public Map<String, Object> getMyInquiryList(Long userNum, int page, int pageSize) {
        Map<String, Object> result = new HashMap<>();
        
        try {
            int offset = (page - 1) * pageSize;
            List<InquiryVO> myInquiryList = inquiryDAO.selectMyInquiryList(userNum, offset, pageSize);
            int totalCount = inquiryDAO.selectMyInquiryTotalCount(userNum);
            
            // 각 문의사항에 답글 정보 추가
            for (InquiryVO inquiry : myInquiryList) {
                List<InquiryVO> replies = inquiryDAO.selectInquiryReplies(inquiry.getInquiryNum());
                inquiry.setReplies(replies);
            }
            
            int totalPages = (int) Math.ceil((double) totalCount / pageSize);
            
            result.put("inquiryList", myInquiryList);
            result.put("totalCount", totalCount);
            result.put("totalPages", totalPages);
            result.put("currentPage", page);
            result.put("pageSize", pageSize);
            result.put("hasNext", page < totalPages);
            result.put("hasPrev", page > 1);
            
            log.info("내 문의사항 목록 조회 완료: userNum={}, 총 {}건", userNum, totalCount);
            
        } catch (Exception e) {
            log.error("내 문의사항 목록 조회 중 오류: userNum={}, error={}", userNum, e.getMessage(), e);
            throw new RuntimeException("내 문의사항 목록 조회에 실패했습니다.");
        }
        
        return result;
    }
    
    /**
     * 첨부파일 처리 - 기존 FileUtils 사용
     */
    private void processAttachments(Long inquiryNum, List<MultipartFile> attachments) {
        try {
            String uploadPath = getUploadPath();
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdirs();
            }
            
            for (MultipartFile file : attachments) {
                if (file != null && !file.isEmpty()) {
                    // 기존 FileUtils 사용하여 파일 업로드
                    String savedFileName = FileUtils.uploadFile(uploadPath, file);
                    
                    // 첨부파일 정보 저장
                    InquiryAttachmentVO attachment = new InquiryAttachmentVO();
                    attachment.setInquiryNum(inquiryNum);
                    attachment.setOriginalFilename(file.getOriginalFilename());
                    attachment.setSavedFilename(savedFileName);
                    attachment.setFileSize(file.getSize());
                    attachment.setFilePath(uploadPath);
                    
                    attachmentDAO.insertAttachment(attachment);
                    
                    log.info("첨부파일 업로드 완료: inquiryNum={}, filename={}", inquiryNum, file.getOriginalFilename());
                }
            }
            
        } catch (Exception e) {
            log.error("첨부파일 처리 중 오류: inquiryNum={}, error={}", inquiryNum, e.getMessage(), e);
            throw new RuntimeException("첨부파일 업로드에 실패했습니다: " + e.getMessage());
        }
    }
    
    /**
     * 첨부파일 다운로드 정보 조회
     */
    @Transactional(readOnly = true)
    public InquiryAttachmentVO getAttachmentInfo(Long attachmentNum, Long currentUserNum, boolean isAdmin) {
        try {
            InquiryAttachmentVO attachment = attachmentDAO.selectAttachmentByNum(attachmentNum);
            if (attachment == null) {
                throw new RuntimeException("존재하지 않는 첨부파일입니다.");
            }
            
            // 해당 문의사항 조회하여 권한 확인
            InquiryVO inquiry = inquiryDAO.selectInquiryByNum(attachment.getInquiryNum());
            if (inquiry != null && inquiry.isPrivateInquiry() && !isAdmin && !inquiry.getCreatedBy().equals(currentUserNum)) {
                throw new RuntimeException("다운로드 권한이 없습니다.");
            }
            
            return attachment;
            
        } catch (Exception e) {
            log.error("첨부파일 정보 조회 중 오류: attachmentNum={}, error={}", attachmentNum, e.getMessage(), e);
            throw new RuntimeException("첨부파일 정보를 불러올 수 없습니다: " + e.getMessage());
        }
    }
}