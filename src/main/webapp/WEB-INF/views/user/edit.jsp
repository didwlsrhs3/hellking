<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>회원정보 수정 - 헬킹 피트니스</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        :root {
            --bg-cream: #F4ECDC;
            --brand: #FF6A00;
        }
        body { background: var(--bg-cream); }
        .edit-container {
            max-width: 500px;
            margin: 50px auto;
            background: white;
            padding: 40px;
            border-radius: 20px;
            box-shadow: 0 10px 30px rgba(15,23,42,0.1);
        }
        .profile-img {
            width: 100px;
            height: 100px;
            border-radius: 50%;
            object-fit: cover;
            border: 3px solid var(--brand);
        }
        .btn-primary {
            background: var(--brand);
            border: none;
            font-weight: 700;
            padding: 12px;
            border-radius: 12px;
        }
        .form-control {
            border-radius: 12px;
            padding: 12px 16px;
            border: 2px solid #E7E0D6;
        }
        .form-control:focus {
            border-color: var(--brand);
            box-shadow: 0 0 0 0.2rem rgba(255,106,0,0.1);
        }
    </style>
</head>
<body>
    <jsp:include page="../common/header.jsp" />
    
    <div class="edit-container">
        <h2 class="text-center mb-4" style="color: var(--brand);">회원정보 수정</h2>
        
        <c:if test="${not empty message}">
            <div class="alert alert-info" role="alert">${message}</div>
        </c:if>
        
        <!-- 프로필 이미지 -->
        <div class="text-center mb-4">
            <img src="${pageContext.request.contextPath}/resources/images/profiles/${user.profileImage}" 
                 alt="프로필" class="profile-img mb-2">
            <div>
                <button type="button" class="btn btn-sm btn-outline-secondary">프로필 변경</button>
            </div>
        </div>
        
        <form action="${pageContext.request.contextPath}/user/editPost" method="post" enctype="multipart/form-data">
            <!-- 아이디 (수정 불가) -->
            <div class="mb-3">
                <label for="userId" class="form-label">아이디</label>
                <input type="text" class="form-control" id="userId" value="${user.userId}" readonly>
            </div>
            
            <!-- 이름 -->
            <div class="mb-3">
                <label for="username" class="form-label">이름 <span class="text-danger">*</span></label>
                <input type="text" class="form-control" id="username" name="username" 
                       value="${user.username}" required>
            </div>
            
            <!-- 이메일 -->
            <div class="mb-3">
                <label for="email" class="form-label">이메일 <span class="text-danger">*</span></label>
                <input type="email" class="form-control" id="email" name="email" 
                       value="${user.email}" required>
            </div>
            
            <!-- 전화번호 -->
            <div class="mb-3">
                <label for="phone" class="form-label">전화번호 <span class="text-danger">*</span></label>
                <input type="tel" class="form-control" id="phone" name="phone" 
                       value="${user.phone}" required>
            </div>
            
            <!-- 생년월일 -->
            <div class="mb-3">
                <label for="birthDate" class="form-label">생년월일</label>
                <input type="date" class="form-control" id="birthDate" name="birthDate" 
                       value="<fmt:formatDate value='${user.birthDate}' pattern='yyyy-MM-dd'/>">
            </div>
            
            <!-- 성별 -->
            <div class="mb-3">
                <label class="form-label">성별</label>
                <div class="d-flex gap-3">
                    <div class="form-check">
                        <input class="form-check-input" type="radio" name="gender" value="M" id="genderM"
                               ${user.gender == 'M' ? 'checked' : ''}>
                        <label class="form-check-label" for="genderM">남성</label>
                    </div>
                    <div class="form-check">
                        <input class="form-check-input" type="radio" name="gender" value="F" id="genderF"
                               ${user.gender == 'F' ? 'checked' : ''}>
                        <label class="form-check-label" for="genderF">여성</label>
                    </div>
                </div>
            </div>
            
            <!-- 프로필 이미지 업로드 (숨김) -->
            <input type="file" name="profileImageFile" id="profileImageFile" 
                   accept="image/*" style="display: none;">
            
            <div class="d-grid gap-2">
                <button type="submit" class="btn btn-primary">정보 수정</button>
                <a href="${pageContext.request.contextPath}/user/mypage" 
                   class="btn btn-outline-secondary">취소</a>
            </div>
        </form>
        
        <hr class="my-4">
        
        <!-- 추가 메뉴 -->
        <div class="text-center">
            <a href="${pageContext.request.contextPath}/user/changePassword" 
               class="text-decoration-none me-3">비밀번호 변경</a>
            <a href="${pageContext.request.contextPath}/user/withdraw" 
               class="text-decoration-none text-danger">회원탈퇴</a>
        </div>
    </div>
    
    <script>
        // 프로필 이미지 변경
        document.querySelector('.btn-outline-secondary').addEventListener('click', function() {
            document.getElementById('profileImageFile').click();
        });
        
        // 이미지 파일 선택 시 미리보기
        document.getElementById('profileImageFile').addEventListener('change', function(e) {
            const file = e.target.files[0];
            if (file) {
                const reader = new FileReader();
                reader.onload = function(e) {
                    document.querySelector('.profile-img').src = e.target.result;
                };
                reader.readAsDataURL(file);
            }
        });
    </script>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>