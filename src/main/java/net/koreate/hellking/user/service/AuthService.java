package net.koreate.hellking.user.service;

public interface AuthService {
    boolean sendVerification(String contact, String type); // SMS 또는 EMAIL
    boolean verifyCode(String contact, String code);
    boolean sendVerificationToUser(Long userNum, String contact, String type);
    boolean verifyCodeForUser(Long userNum, String code);
}
