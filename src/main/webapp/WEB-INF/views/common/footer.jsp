<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<<<<<<< HEAD
<footer class="bg-dark text-light py-5 mt-5">
    <div class="container">
        <div class="row">
            <div class="col-md-4 mb-4">
                <h5 class="fw-bold mb-3" style="color: #FF6A00;">HELLKING</h5>
                <p class="text-muted">전국 어디서나 자유롭게<br>하나의 패스권으로 모든 가맹점 이용</p>
                <div class="d-flex gap-3">
                    <a href="#" class="text-muted">Facebook</a>
                    <a href="#" class="text-muted">Instagram</a>
                    <a href="#" class="text-muted">YouTube</a>
                </div>
            </div>
            <div class="col-md-2 mb-4">
                <h6 class="fw-bold mb-3">서비스</h6>
                <ul class="list-unstyled">
                    <li><a href="${pageContext.request.contextPath}/pass/list" class="text-muted text-decoration-none">패스권</a></li>
                    <li><a href="${pageContext.request.contextPath}/qr/enter" class="text-muted text-decoration-none">QR 입장</a></li>
                    <li><a href="${pageContext.request.contextPath}/reviews" class="text-muted text-decoration-none">리뷰</a></li>
                </ul>
            </div>
            <div class="col-md-2 mb-4">
                <h6 class="fw-bold mb-3">고객지원</h6>
                <ul class="list-unstyled">
                    <li><a href="${pageContext.request.contextPath}/support/faq" class="text-muted text-decoration-none">FAQ</a></li>
                    <li><a href="${pageContext.request.contextPath}/support" class="text-muted text-decoration-none">문의하기</a></li>
                    <li><a href="${pageContext.request.contextPath}/notice" class="text-muted text-decoration-none">공지사항</a></li>
                </ul>
            </div>
            <div class="col-md-4 mb-4">
                <h6 class="fw-bold mb-3">고객센터</h6>
                <p class="text-muted mb-1">📞 1588-0000</p>
                <p class="text-muted mb-1">📧 support@hellking.co.kr</p>
                <p class="text-muted mb-3">⏰ 평일 09:00 - 18:00</p>
                <small class="text-muted">주말 및 공휴일 휴무</small>
            </div>
        </div>
        <hr class="my-4">
        <div class="row align-items-center">
            <div class="col-md-6">
                <small class="text-muted">
                    © 2024 HELLKING FITNESS. All rights reserved.
                </small>
            </div>
            <div class="col-md-6 text-md-end">
                <small class="text-muted">
                    <a href="#" class="text-muted text-decoration-none me-3">이용약관</a>
                    <a href="#" class="text-muted text-decoration-none">개인정보처리방침</a>
                </small>
=======

<style>
:root {
    --bg-cream: #F4ECDC;
    --brand: #FF6A00;
    --ink: #0F172A;
    --muted: #5B6170;
    --line: #E7E0D6;
    --hover: #FFF5EA;
    --radius: 14px;
    --footer-bg: #1a1d29;
    --footer-border: #2a2f3a;
}

.hk-footer {
    background: var(--footer-bg);
    color: #e2e8f0;
    padding: 60px 0 30px;
    margin-top: 80px;
    border-top: 1px solid var(--footer-border);
    position: relative;
}

.hk-footer::before {
    content: '';
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
    height: 1px;
    background: linear-gradient(90deg, transparent, var(--brand), transparent);
}

.footer-brand {
    font-size: 1.8rem;
    font-weight: 900;
    color: var(--brand);
    margin-bottom: 1rem;
    letter-spacing: -0.5px;
}

.footer-description {
    color: #94a3b8;
    line-height: 1.6;
    margin-bottom: 1.5rem;
    font-size: 0.95rem;
}

.footer-social {
    display: flex;
    gap: 1rem;
}

.social-link {
    width: 40px;
    height: 40px;
    background: rgba(255, 106, 0, 0.1);
    border: 1px solid rgba(255, 106, 0, 0.2);
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
    color: var(--brand);
    text-decoration: none;
    transition: all 0.3s ease;
    font-size: 0.9rem;
}

.social-link:hover {
    background: var(--brand);
    color: white;
    transform: translateY(-2px);
    box-shadow: 0 4px 12px rgba(255, 106, 0, 0.3);
}

.footer-section-title {
    font-size: 1.1rem;
    font-weight: 700;
    color: white;
    margin-bottom: 1.5rem;
    position: relative;
    padding-bottom: 0.5rem;
}

.footer-section-title::after {
    content: '';
    position: absolute;
    bottom: 0;
    left: 0;
    width: 30px;
    height: 2px;
    background: var(--brand);
    border-radius: 1px;
}

.footer-links {
    list-style: none;
    padding: 0;
    margin: 0;
}

.footer-links li {
    margin-bottom: 0.8rem;
}

.footer-link {
    color: #94a3b8;
    text-decoration: none;
    font-size: 0.9rem;
    transition: all 0.2s ease;
    display: flex;
    align-items: center;
}

.footer-link:hover {
    color: var(--brand);
    transform: translateX(4px);
}

.footer-link i {
    margin-right: 0.5rem;
    width: 14px;
    opacity: 0.7;
}

.contact-info {
    background: rgba(255, 255, 255, 0.03);
    border-radius: var(--radius);
    padding: 1.5rem;
    border: 1px solid rgba(255, 255, 255, 0.08);
}

.contact-item {
    display: flex;
    align-items: center;
    margin-bottom: 0.8rem;
    color: #94a3b8;
    font-size: 0.9rem;
}

.contact-item:last-child {
    margin-bottom: 0;
}

.contact-icon {
    width: 20px;
    height: 20px;
    background: rgba(255, 106, 0, 0.1);
    border-radius: 6px;
    display: flex;
    align-items: center;
    justify-content: center;
    margin-right: 0.8rem;
    color: var(--brand);
    font-size: 0.75rem;
    flex-shrink: 0;
}

.contact-text {
    font-weight: 500;
    color: #e2e8f0;
}

.footer-divider {
    height: 1px;
    background: var(--footer-border);
    margin: 2.5rem 0 1.5rem;
    border: none;
}

.footer-bottom {
    display: flex;
    justify-content: space-between;
    align-items: center;
    flex-wrap: wrap;
    gap: 1rem;
}

.footer-copyright {
    color: #64748b;
    font-size: 0.85rem;
    margin: 0;
}

.footer-legal {
    display: flex;
    gap: 1.5rem;
    flex-wrap: wrap;
}

.legal-link {
    color: #64748b;
    text-decoration: none;
    font-size: 0.85rem;
    transition: color 0.2s ease;
}

.legal-link:hover {
    color: var(--brand);
}

@media (max-width: 768px) {
    .hk-footer {
        padding: 40px 0 20px;
        margin-top: 60px;
    }
    
    .footer-bottom {
        flex-direction: column;
        text-align: center;
    }
    
    .footer-legal {
        justify-content: center;
    }
    
    .contact-info {
        margin-top: 1.5rem;
    }
}
</style>

<footer class="hk-footer">
    <div class="container">
        <div class="row">
            <!-- 브랜드 섹션 -->
            <div class="col-lg-4 col-md-6 mb-4">
                <div class="footer-brand">HELLKING</div>
                <p class="footer-description">
                    전국 어디서나 자유롭게<br>
                    하나의 패스권으로 모든 가맹점 이용
                </p>
                <div class="footer-social">
                    <a href="#" class="social-link" title="Facebook">
                        <i class="fab fa-facebook-f"></i>
                    </a>
                    <a href="#" class="social-link" title="Instagram">
                        <i class="fab fa-instagram"></i>
                    </a>
                    <a href="#" class="social-link" title="YouTube">
                        <i class="fab fa-youtube"></i>
                    </a>
                    <a href="#" class="social-link" title="카카오톡">
                        <i class="fab fa-twitter"></i>
                    </a>
                </div>
            </div>
            
            <!-- 서비스 섹션 -->
            <div class="col-lg-2 col-md-3 col-6 mb-4">
                <h6 class="footer-section-title">서비스</h6>
                <ul class="footer-links">
                    <li>
                        <a href="${pageContext.request.contextPath}/pass/list" class="footer-link">
                            <i class="fas fa-ticket-alt"></i>패스권 안내
                        </a>
                    </li>
                    <li>
                        <a href="${pageContext.request.contextPath}/chain/list" class="footer-link">
                            <i class="fas fa-map-marker-alt"></i>가맹점 찾기
                        </a>
                    </li>
                    <li>
                        <a href="${pageContext.request.contextPath}/reviews/list" class="footer-link">
                            <i class="fas fa-star"></i>고객리뷰
                        </a>
                    </li>
                </ul>
            </div>
            
            <!-- 고객지원 섹션 -->
            <div class="col-lg-2 col-md-3 col-6 mb-4">
                <h6 class="footer-section-title">고객지원</h6>
                <ul class="footer-links">
                    <li>
                        <a href="${pageContext.request.contextPath}/support/faq" class="footer-link">
                            <i class="fas fa-question-circle"></i>FAQ
                        </a>
                    </li>
                    <li>
                        <a href="${pageContext.request.contextPath}/support/" class="footer-link">
                            <i class="fas fa-comment-dots"></i>문의하기
                        </a>
                    </li>
                    <li>
                        <a href="${pageContext.request.contextPath}/fooddiary/" class="footer-link">
                            <i class="fas fa-apple-alt"></i>푸드다이어리
                        </a>
                    </li>
                    <li>
                        <a href="${pageContext.request.contextPath}/board/boardlist" class="footer-link">
                            <i class="fas fa-comments"></i>게시판
                        </a>
                    </li>
                </ul>
            </div>
            
            <!-- 고객센터 섹션 -->
            <div class="col-lg-4 col-md-12 mb-4">
                <h6 class="footer-section-title">고객센터</h6>
                <div class="contact-info">
                    <div class="contact-item">
                        <div class="contact-icon">
                            <i class="fas fa-phone"></i>
                        </div>
                        <div>
                            <div class="contact-text">1588-0000</div>
                        </div>
                    </div>
                    <div class="contact-item">
                        <div class="contact-icon">
                            <i class="fas fa-envelope"></i>
                        </div>
                        <div>
                            <div class="contact-text">support@hellking.co.kr</div>
                        </div>
                    </div>
                    <div class="contact-item">
                        <div class="contact-icon">
                            <i class="fas fa-clock"></i>
                        </div>
                        <div>
                            <div class="contact-text">평일 09:00 - 18:00</div>
                            <small style="color: #64748b; font-size: 0.8rem;">주말 및 공휴일 휴무</small>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        
        <hr class="footer-divider">
        
        <div class="footer-bottom">
            <p class="footer-copyright">
                © 2024 HELLKING FITNESS. All rights reserved.
            </p>
            <div class="footer-legal">
                <a href="#" class="legal-link">이용약관</a>
                <a href="#" class="legal-link">개인정보처리방침</a>
                <a href="#" class="legal-link">사업자정보</a>
>>>>>>> b65c320 (Initial commit)
            </div>
        </div>
    </div>
</footer>