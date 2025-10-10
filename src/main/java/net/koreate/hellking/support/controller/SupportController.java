package net.koreate.hellking.support.controller;

import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.Resource;
import org.springframework.core.io.FileSystemResource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import lombok.extern.slf4j.Slf4j;
import net.koreate.hellking.user.service.UserService;
import net.koreate.hellking.support.service.FAQService;
import net.koreate.hellking.support.service.InquiryService;
import net.koreate.hellking.support.vo.FAQVO;
import net.koreate.hellking.support.vo.InquiryVO;
import net.koreate.hellking.support.vo.InquiryAttachmentVO;
import net.koreate.hellking.support.vo.SupportSearchVO;

import java.io.File;
import java.net.URLEncoder;
import java.util.Map;
import java.util.List;

/**
 * 헬킹 피트니스 고객지원 컨트롤러
 * - FAQ 관리
 * - 문의사항 게시판 (답글 기능 포함)
 * - 첨부파일 다운로드
 */
@Controller
@RequestMapping("/support/")
@Slf4j
public class SupportController {
    
    @Autowired
    private UserService userService;
    
    @Autowired
    private FAQService faqService;
    
    @Autowired
    private InquiryService inquiryService;
    
    // === 공통 유틸리티 메서드 ===
    
    private boolean isAdmin(HttpSession session) {
        if (!userService.isLoggedIn(session)) {
            return false;
        }
        return userService.isAdmin(session);
    }
    
    private Long getCurrentUserNum(HttpSession session) {
        return userService.getCurrentUserNum(session);
    }
    
    // ============================================================================
    // 고객지원 메인 페이지
    // ============================================================================
    
    /**
     * 고객지원 메인 대시보드
     */
    @GetMapping("")
    public String supportMain(Model model, HttpSession session) {
        boolean isLoggedIn = userService.isLoggedIn(session);
        boolean isAdminUser = isAdmin(session);
        
        model.addAttribute("isLoggedIn", isLoggedIn);
        model.addAttribute("isAdmin", isAdminUser);
        
        return "support/main";
    }
    
    // ============================================================================
    // FAQ 관련 컨트롤러
    // ============================================================================
    
    /**
     * FAQ 목록 페이지
     */
    @GetMapping("faq")
    public String faqList(@RequestParam(defaultValue = "1") int page,
                         @RequestParam(defaultValue = "10") int pageSize,
                         @RequestParam(required = false) String searchType,
                         @RequestParam(required = false) String searchKeyword,
                         Model model, HttpSession session) {
        
        try {
            SupportSearchVO searchVO = new SupportSearchVO();
            searchVO.setPage(page);
            searchVO.setPageSize(pageSize);
            searchVO.setSearchType(searchType);
            searchVO.setSearchKeyword(searchKeyword);
            
            Map<String, Object> result = faqService.getFAQList(searchVO);
            
            model.addAttribute("isAdmin", isAdmin(session));
            model.addAllAttributes(result);
            
            return "support/faq/list";
            
        } catch (Exception e) {
            log.error("FAQ 목록 조회 실패: {}", e.getMessage(), e);
            model.addAttribute("errorMessage", "FAQ 목록을 불러올 수 없습니다.");
            return "support/faq/list";
        }
    }
    
    /**
     * FAQ 상세 보기
     */
    @GetMapping("faq/detail")
    public String faqDetail(@RequestParam Long faqNum, Model model, HttpSession session) {
        try {
            FAQVO faq = faqService.getFAQDetail(faqNum);
            
            model.addAttribute("isAdmin", isAdmin(session));
            model.addAttribute("faq", faq);
            
            return "support/faq/detail";
            
        } catch (Exception e) {
            log.error("FAQ 상세 조회 실패: faqNum={}, error={}", faqNum, e.getMessage());
            model.addAttribute("errorMessage", e.getMessage());
            return "redirect:/support/faq";
        }
    }
    
    /**
     * FAQ 등록 폼 (관리자만)
     */
    @GetMapping("faq/create")
    public String faqCreateForm(HttpSession session) {
        if (!isAdmin(session)) {
            return "redirect:/support/faq";
        }
        
        return "support/faq/create";
    }
    
    /**
     * FAQ 등록 처리 (관리자만)
     */
    @PostMapping("faq/create")
    public String faqCreate(@ModelAttribute FAQVO faq, 
                           HttpSession session, 
                           RedirectAttributes redirectAttributes) {
        try {
            if (!isAdmin(session)) {
                redirectAttributes.addFlashAttribute("errorMessage", "권한이 없습니다.");
                return "redirect:/support/faq";
            }
            
            Long currentUserNum = getCurrentUserNum(session);
            faq.setCreatedBy(currentUserNum);
            
            boolean success = faqService.createFAQ(faq);
            
            if (success) {
                redirectAttributes.addFlashAttribute("successMessage", "FAQ가 성공적으로 등록되었습니다.");
                return "redirect:/support/faq/detail?faqNum=" + faq.getFaqNum();
            } else {
                redirectAttributes.addFlashAttribute("errorMessage", "FAQ 등록에 실패했습니다.");
                return "redirect:/support/faq/create";
            }
            
        } catch (Exception e) {
            log.error("FAQ 등록 실패: {}", e.getMessage(), e);
            redirectAttributes.addFlashAttribute("errorMessage", e.getMessage());
            return "redirect:/support/faq/create";
        }
    }
    
    /**
     * FAQ 수정 폼 (관리자만)
     */
    @GetMapping("faq/edit")
    public String faqEditForm(@RequestParam Long faqNum, Model model, HttpSession session) {
        try {
            if (!isAdmin(session)) {
                return "redirect:/support/faq";
            }
            
            FAQVO faq = faqService.getFAQDetail(faqNum);
            model.addAttribute("faq", faq);
            
            return "support/faq/edit";
            
        } catch (Exception e) {
            log.error("FAQ 수정 폼 조회 실패: faqNum={}, error={}", faqNum, e.getMessage());
            return "redirect:/support/faq/detail?faqNum=" + faqNum;
        }
    }
    
    /**
     * FAQ 수정 처리 (관리자만)
     */
    @PostMapping("faq/edit")
    public String faqUpdate(@ModelAttribute FAQVO faq, 
                           HttpSession session, 
                           RedirectAttributes redirectAttributes) {
        try {
            if (!isAdmin(session)) {
                redirectAttributes.addFlashAttribute("errorMessage", "권한이 없습니다.");
                return "redirect:/support/faq";
            }
            
            boolean success = faqService.updateFAQ(faq);
            
            if (success) {
                redirectAttributes.addFlashAttribute("successMessage", "FAQ가 성공적으로 수정되었습니다.");
                return "redirect:/support/faq/detail?faqNum=" + faq.getFaqNum();
            } else {
                redirectAttributes.addFlashAttribute("errorMessage", "FAQ 수정에 실패했습니다.");
                return "redirect:/support/faq/edit?faqNum=" + faq.getFaqNum();
            }
            
        } catch (Exception e) {
            log.error("FAQ 수정 실패: {}", e.getMessage(), e);
            redirectAttributes.addFlashAttribute("errorMessage", e.getMessage());
            return "redirect:/support/faq/edit?faqNum=" + faq.getFaqNum();
        }
    }
    
    /**
     * FAQ 삭제 처리 (관리자만)
     */
    @PostMapping("faq/delete")
    public String faqDelete(@RequestParam Long faqNum, 
                           HttpSession session, 
                           RedirectAttributes redirectAttributes) {
        try {
            if (!isAdmin(session)) {
                redirectAttributes.addFlashAttribute("errorMessage", "권한이 없습니다.");
                return "redirect:/support/faq";
            }
            
            boolean success = faqService.deleteFAQ(faqNum);
            
            if (success) {
                redirectAttributes.addFlashAttribute("successMessage", "FAQ가 성공적으로 삭제되었습니다.");
            } else {
                redirectAttributes.addFlashAttribute("errorMessage", "FAQ 삭제에 실패했습니다.");
            }
            
            return "redirect:/support/faq";
            
        } catch (Exception e) {
            log.error("FAQ 삭제 실패: {}", e.getMessage(), e);
            redirectAttributes.addFlashAttribute("errorMessage", e.getMessage());
            return "redirect:/support/faq/detail?faqNum=" + faqNum;
        }
    }
    
    // ============================================================================
    // 문의사항 관련 컨트롤러 - 수정된 버전
    // ============================================================================
    
    /**
     * 문의사항 목록 페이지
     */
    @GetMapping("inquiry")
    public String inquiryList(@RequestParam(defaultValue = "1") int page,
                             @RequestParam(defaultValue = "10") int pageSize,
                             @RequestParam(required = false) String searchType,
                             @RequestParam(required = false) String searchKeyword,
                             @RequestParam(required = false) String status,
                             Model model, HttpSession session) {
        
        if (!userService.isLoggedIn(session)) {
            return "redirect:/user/login";
        }
        
        try {
            SupportSearchVO searchVO = new SupportSearchVO();
            searchVO.setPage(page);
            searchVO.setPageSize(pageSize);
            searchVO.setSearchType(searchType);
            searchVO.setSearchKeyword(searchKeyword);
            searchVO.setStatus(status);
            
            Map<String, Object> result = inquiryService.getInquiryList(searchVO);
            
            model.addAttribute("isAdmin", isAdmin(session));
            model.addAttribute("currentUserNum", getCurrentUserNum(session));
            model.addAllAttributes(result);
            
        } catch (Exception e) {
            log.error("문의사항 목록 조회 실패: {}", e.getMessage(), e);
            model.addAttribute("errorMessage", "문의사항 목록을 불러올 수 없습니다.");
        }
        
        return "support/inquiry/list";
    }
    
    /**
     * 문의사항 상세 보기 - 기존 URL 구조 유지
     */
    @GetMapping("inquiry/detail")
    public String inquiryDetailOld(@RequestParam Long inquiryNum, Model model, HttpSession session) {
        // 새로운 URL로 리다이렉트
        return "redirect:/support/inquiry/" + inquiryNum;
    }
    
    /**
     * 문의사항 상세 보기 - 권한 체크 추가
     */
    @GetMapping("inquiry/{inquiryNum}")
    public String inquiryDetail(@PathVariable Long inquiryNum, Model model, HttpSession session) {
        try {
            if (!userService.isLoggedIn(session)) {
                return "redirect:/user/login";
            }
            
            Long currentUserNum = getCurrentUserNum(session);
            boolean isAdminUser = isAdmin(session);
            
            InquiryVO inquiry = inquiryService.getInquiryDetail(inquiryNum, currentUserNum, isAdminUser);
            
            // 권한 체크
            boolean canEdit = isAdminUser || inquiry.getCreatedBy().equals(currentUserNum);
            boolean canReply = userService.isLoggedIn(session); // 로그인한 사용자는 누구나 답글 가능
            
            model.addAttribute("isAdmin", isAdminUser);
            model.addAttribute("currentUserNum", currentUserNum);
            model.addAttribute("inquiry", inquiry);
            model.addAttribute("canEdit", canEdit);
            model.addAttribute("canReply", canReply);
            
            return "support/inquiry/detail";
            
        } catch (Exception e) {
            log.error("문의사항 상세 조회 실패: inquiryNum={}, error={}", inquiryNum, e.getMessage());
            model.addAttribute("errorMessage", e.getMessage());
            return "redirect:/support/inquiry";
        }
    }
    
    /**
     * 답글 등록 처리 - 새로 추가된 메서드
     */
    @PostMapping("inquiry/{inquiryNum}/reply")
    public String inquiryReply(@PathVariable Long inquiryNum,
                              @RequestParam String content,
                              HttpSession session,
                              RedirectAttributes redirectAttributes) {
        try {
            if (!userService.isLoggedIn(session)) {
                redirectAttributes.addFlashAttribute("errorMessage", "로그인이 필요합니다.");
                return "redirect:/user/login";
            }
            
            if (content == null || content.trim().isEmpty()) {
                redirectAttributes.addFlashAttribute("errorMessage", "답글 내용을 입력해주세요.");
                return "redirect:/support/inquiry/" + inquiryNum;
            }
            
            Long currentUserNum = getCurrentUserNum(session);
            
            // 답글 객체 생성
            InquiryVO reply = new InquiryVO();
            reply.setParentNum(inquiryNum);
            reply.setContent(content.trim());
            reply.setCreatedBy(currentUserNum);
            
            boolean success = inquiryService.createReply(reply);
            
            if (success) {
                redirectAttributes.addFlashAttribute("message", "답글이 성공적으로 등록되었습니다.");
            } else {
                redirectAttributes.addFlashAttribute("errorMessage", "답글 등록에 실패했습니다.");
            }
            
            return "redirect:/support/inquiry/" + inquiryNum + "#replies";
            
        } catch (Exception e) {
            log.error("답글 등록 실패: parentNum={}, error={}", inquiryNum, e.getMessage(), e);
            redirectAttributes.addFlashAttribute("errorMessage", "답글 등록 중 오류가 발생했습니다: " + e.getMessage());
            return "redirect:/support/inquiry/" + inquiryNum;
        }
    }
    
    /**
     * 문의사항 등록 폼
     */
    @GetMapping("inquiry/create")
    public String inquiryCreateForm(HttpSession session) {
        if (!userService.isLoggedIn(session)) {
            return "redirect:/user/login";
        }
        
        return "support/inquiry/create";
    }
    
    /**
     * 문의사항 등록 처리
     */
    @PostMapping("inquiry/create")
    public String inquiryCreate(@ModelAttribute InquiryVO inquiry,
                               @RequestParam(value = "attachments", required = false) List<MultipartFile> attachments,
                               HttpSession session,
                               RedirectAttributes redirectAttributes) {
        try {
            if (!userService.isLoggedIn(session)) {
                redirectAttributes.addFlashAttribute("errorMessage", "로그인이 필요합니다.");
                return "redirect:/user/login";
            }
            
            Long currentUserNum = getCurrentUserNum(session);
            inquiry.setCreatedBy(currentUserNum);
            
            boolean success = inquiryService.createInquiry(inquiry, attachments);
            
            if (success) {
                redirectAttributes.addFlashAttribute("message", "문의사항이 성공적으로 등록되었습니다.");
                return "redirect:/support/inquiry/" + inquiry.getInquiryNum();
            } else {
                redirectAttributes.addFlashAttribute("errorMessage", "문의사항 등록에 실패했습니다.");
                return "redirect:/support/inquiry/create";
            }
            
        } catch (Exception e) {
            log.error("문의사항 등록 실패: {}", e.getMessage(), e);
            redirectAttributes.addFlashAttribute("errorMessage", e.getMessage());
            return "redirect:/support/inquiry/create";
        }
    }
    
    /**
     * 문의사항 수정 폼 - 기존 URL 지원
     */
    @GetMapping("inquiry/edit")
    public String inquiryEditFormOld(@RequestParam Long inquiryNum, HttpSession session) {
        return "redirect:/support/inquiry/" + inquiryNum + "/edit";
    }
    
    /**
     * 문의사항 수정 폼 - 권한 체크 강화 (본인만 수정 가능)
     */
    @GetMapping("inquiry/{inquiryNum}/edit")
    public String inquiryEditForm(@PathVariable Long inquiryNum, Model model, HttpSession session) {
        try {
            if (!userService.isLoggedIn(session)) {
                return "redirect:/user/login";
            }
            
            Long currentUserNum = getCurrentUserNum(session);
            boolean isAdminUser = isAdmin(session);
            
            InquiryVO inquiry = inquiryService.getInquiryDetail(inquiryNum, currentUserNum, isAdminUser);
            
            // 수정은 작성자 본인만 가능 (관리자도 본인 글만)
            if (!inquiry.getCreatedBy().equals(currentUserNum)) {
                model.addAttribute("errorMessage", "본인이 작성한 글만 수정할 수 있습니다.");
                return "redirect:/support/inquiry/" + inquiryNum;
            }
            
            model.addAttribute("inquiry", inquiry);
            model.addAttribute("isAdmin", isAdminUser);
            model.addAttribute("currentUserNum", currentUserNum);
            
            return "support/inquiry/edit";
            
        } catch (Exception e) {
            log.error("문의사항 수정 폼 조회 실패: inquiryNum={}, error={}", inquiryNum, e.getMessage());
            return "redirect:/support/inquiry/" + inquiryNum;
        }
    }
    
    /**
     * 문의사항 수정 처리 - 기존 URL 지원
     */
    @PostMapping("inquiry/edit")
    public String inquiryUpdateOld(@RequestParam Long inquiryNum,
                                  @ModelAttribute InquiryVO inquiry,
                                  HttpSession session,
                                  RedirectAttributes redirectAttributes) {
        inquiry.setInquiryNum(inquiryNum);
        return inquiryUpdate(inquiryNum, inquiry, session, redirectAttributes);
    }
    
    /**
     * 문의사항 삭제 처리 - 기존 URL 지원
     */
    @PostMapping("inquiry/delete")
    public String inquiryDeleteOld(@RequestParam Long inquiryNum,
                                  HttpSession session,
                                  RedirectAttributes redirectAttributes) {
        return inquiryDelete(inquiryNum, session, redirectAttributes);
    }
    
    /**
     * 문의사항 수정 처리 - 권한 체크 강화
     */
    @PostMapping("inquiry/{inquiryNum}/edit")
    public String inquiryUpdate(@PathVariable Long inquiryNum,
                               @ModelAttribute InquiryVO inquiry,
                               HttpSession session,
                               RedirectAttributes redirectAttributes) {
        try {
            if (!userService.isLoggedIn(session)) {
                redirectAttributes.addFlashAttribute("errorMessage", "로그인이 필요합니다.");
                return "redirect:/user/login";
            }
            
            inquiry.setInquiryNum(inquiryNum);
            Long currentUserNum = getCurrentUserNum(session);
            boolean isAdminUser = isAdmin(session);
            
            boolean success = inquiryService.updateInquiry(inquiry, currentUserNum, isAdminUser);
            
            if (success) {
                redirectAttributes.addFlashAttribute("message", "문의사항이 성공적으로 수정되었습니다.");
                return "redirect:/support/inquiry/" + inquiryNum;
            } else {
                redirectAttributes.addFlashAttribute("errorMessage", "문의사항 수정에 실패했습니다.");
                return "redirect:/support/inquiry/" + inquiryNum + "/edit";
            }
            
        } catch (Exception e) {
            log.error("문의사항 수정 실패: {}", e.getMessage(), e);
            redirectAttributes.addFlashAttribute("errorMessage", e.getMessage());
            return "redirect:/support/inquiry/" + inquiryNum + "/edit";
        }
    }
    
    /**
     * 문의사항 삭제 처리 - 권한 체크 강화
     */
    @PostMapping("inquiry/{inquiryNum}/delete")
    public String inquiryDelete(@PathVariable Long inquiryNum,
                               HttpSession session,
                               RedirectAttributes redirectAttributes) {
        try {
            if (!userService.isLoggedIn(session)) {
                redirectAttributes.addFlashAttribute("errorMessage", "로그인이 필요합니다.");
                return "redirect:/user/login";
            }
            
            Long currentUserNum = getCurrentUserNum(session);
            boolean isAdminUser = isAdmin(session);
            
            boolean success = inquiryService.deleteInquiry(inquiryNum, currentUserNum, isAdminUser);
            
            if (success) {
                redirectAttributes.addFlashAttribute("message", "문의사항이 성공적으로 삭제되었습니다.");
            } else {
                redirectAttributes.addFlashAttribute("errorMessage", "문의사항 삭제에 실패했습니다.");
            }
            
            return "redirect:/support/inquiry";
            
        } catch (Exception e) {
            log.error("문의사항 삭제 실패: {}", e.getMessage(), e);
            redirectAttributes.addFlashAttribute("errorMessage", e.getMessage());
            return "redirect:/support/inquiry/" + inquiryNum;
        }
    }
    
    /**
     * 첨부파일 다운로드 - 새로 추가된 메서드
     */
    @GetMapping("inquiry/download/{attachmentNum}")
    public ResponseEntity<Resource> downloadAttachment(@PathVariable Long attachmentNum, 
                                                      HttpSession session) {
        try {
            if (!userService.isLoggedIn(session)) {
                return ResponseEntity.status(401).build();
            }
            
            Long currentUserNum = getCurrentUserNum(session);
            boolean isAdminUser = isAdmin(session);
            
            InquiryAttachmentVO attachment = inquiryService.getAttachmentInfo(attachmentNum, currentUserNum, isAdminUser);
            
            File file = new File(attachment.getFilePath(), attachment.getSavedFilename());
            if (!file.exists()) {
                log.error("첨부파일이 존재하지 않음: {}", file.getAbsolutePath());
                return ResponseEntity.notFound().build();
            }
            
            Resource resource = new FileSystemResource(file);
            String encodedFileName = URLEncoder.encode(attachment.getOriginalFilename(), "UTF-8")
                                               .replaceAll("\\+", "%20");
            
            return ResponseEntity.ok()
                    .contentType(MediaType.APPLICATION_OCTET_STREAM)
                    .header(HttpHeaders.CONTENT_DISPOSITION, 
                           "attachment; filename*=UTF-8''" + encodedFileName)
                    .body(resource);
            
        } catch (Exception e) {
            log.error("첨부파일 다운로드 실패: attachmentNum={}, error={}", attachmentNum, e.getMessage(), e);
            return ResponseEntity.status(500).build();
        }
    }
    
    /**
     * 내 문의사항 목록
     */
    @GetMapping("inquiry/my")
    public String myInquiryList(@RequestParam(defaultValue = "1") int page,
                               @RequestParam(defaultValue = "10") int pageSize,
                               Model model, HttpSession session) {
        if (!userService.isLoggedIn(session)) {
            return "redirect:/user/login";
        }
        
        try {
            Long currentUserNum = getCurrentUserNum(session);
            Map<String, Object> result = inquiryService.getMyInquiryList(currentUserNum, page, pageSize);
            
            model.addAttribute("currentUserNum", currentUserNum);
            model.addAllAttributes(result);
            
        } catch (Exception e) {
            log.error("내 문의사항 목록 조회 실패: {}", e.getMessage(), e);
            model.addAttribute("errorMessage", "내 문의사항 목록을 불러올 수 없습니다.");
        }
        
        return "support/inquiry/my-list";
    }
    
    // ============================================================================
    // 검색 통합 페이지
    // ============================================================================
    
    /**
     * 검색 통합 페이지
     */
    /**
     * 검색 통합 페이지 - 수정된 버전
     */
    /**
     * 검색 통합 페이지 - 최종 수정 버전
     * 문제: SupportSearchVO 설정이 faqList 메서드와 다름
     */
    @GetMapping("search")
    public String searchMain(@RequestParam(required = false) String q,
                            @RequestParam(defaultValue = "all") String type,
                            @RequestParam(defaultValue = "1") int page,
                            Model model, HttpSession session) {
        
        // 검색어 정리
        String cleanKeyword = (q != null) ? q.trim() : "";
        
        model.addAttribute("searchKeyword", cleanKeyword);
        model.addAttribute("searchType", type);
        model.addAttribute("currentPage", page);
        
        try {
            log.info("검색 시작: keyword='{}', type='{}'", cleanKeyword, type);
            
            // FAQ 검색 - faqList 메서드와 동일한 방식으로 SupportSearchVO 생성
            if ("all".equals(type) || "faq".equals(type)) {
                SupportSearchVO faqSearchVO = new SupportSearchVO();
                faqSearchVO.setPage(page);
                faqSearchVO.setPageSize(5);
                
                // 검색어가 있을 때만 설정 (faqList 메서드와 동일)
                if (!cleanKeyword.isEmpty()) {
                    faqSearchVO.setSearchType(type.equals("all") ? null : type);
                    faqSearchVO.setSearchKeyword(cleanKeyword);
                }
                // 검색어가 없으면 searchType과 searchKeyword를 null로 유지
                
                log.info("FAQ 검색 실행: searchType={}, searchKeyword={}, hasSearch()={}", 
                         faqSearchVO.getSearchType(), faqSearchVO.getSearchKeyword(), faqSearchVO.hasSearch());
                
                Map<String, Object> faqResult = faqService.getFAQList(faqSearchVO);
                model.addAttribute("faqResult", faqResult);
                log.info("FAQ 검색 완료: {}건", faqResult.get("totalCount"));
            }
            
            // 문의사항 검색 - 로그인된 사용자만
            if (userService.isLoggedIn(session) && ("all".equals(type) || "inquiry".equals(type))) {
                SupportSearchVO inquirySearchVO = new SupportSearchVO();
                inquirySearchVO.setPage(page);
                inquirySearchVO.setPageSize(5);
                
                // 검색어가 있을 때만 설정
                if (!cleanKeyword.isEmpty()) {
                    inquirySearchVO.setSearchType(type.equals("all") ? null : type);
                    inquirySearchVO.setSearchKeyword(cleanKeyword);
                }
                
                Map<String, Object> inquiryResult = inquiryService.getInquiryList(inquirySearchVO);
                model.addAttribute("inquiryResult", inquiryResult);
                log.info("문의사항 검색 완료: {}건", inquiryResult.get("totalCount"));
            }
            
            // 로그인 상태 정보 추가
            model.addAttribute("isLoggedIn", userService.isLoggedIn(session));
            model.addAttribute("currentUserNum", getCurrentUserNum(session));
            model.addAttribute("isAdmin", isAdmin(session));
            
        } catch (Exception e) {
            log.error("통합 검색 실패: keyword={}, error={}", cleanKeyword, e.getMessage(), e);
            model.addAttribute("errorMessage", "검색 중 오류가 발생했습니다: " + e.getMessage());
        }
        
        return "support/search";
    }
}