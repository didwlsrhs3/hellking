<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
            </div>
        </div>
    </div>
</footer>