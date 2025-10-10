package net.koreate.hellking.common.exception;

/**
 * 카카오 API 관련 예외 클래스
 */
public class KakaoApiException extends RuntimeException {
    
    private final String errorCode;
    private final int httpStatus;
    
    public KakaoApiException(String message) {
        super(message);
        this.errorCode = "UNKNOWN";
        this.httpStatus = 500;
    }
    
    public KakaoApiException(String message, String errorCode) {
        super(message);
        this.errorCode = errorCode;
        this.httpStatus = 500;
    }
    
    public KakaoApiException(String message, String errorCode, int httpStatus) {
        super(message);
        this.errorCode = errorCode;
        this.httpStatus = httpStatus;
    }
    
    public KakaoApiException(String message, Throwable cause) {
        super(message, cause);
        this.errorCode = "UNKNOWN";
        this.httpStatus = 500;
    }
    
    public String getErrorCode() {
        return errorCode;
    }
    
    public int getHttpStatus() {
        return httpStatus;
    }
    
    // 자주 사용되는 예외 팩토리 메서드들
    public static KakaoApiException apiKeyMissing() {
        return new KakaoApiException("카카오 API 키가 설정되지 않았습니다.", "API_KEY_MISSING", 500);
    }
    
    public static KakaoApiException rateLimitExceeded() {
        return new KakaoApiException("카카오 API 호출 한도를 초과했습니다.", "RATE_LIMIT_EXCEEDED", 429);
    }
    
    public static KakaoApiException invalidAddress(String address) {
        return new KakaoApiException("유효하지 않은 주소입니다: " + address, "INVALID_ADDRESS", 400);
    }
    
    public static KakaoApiException networkError(Throwable cause) {
        return new KakaoApiException("카카오 API 호출 중 네트워크 오류가 발생했습니다.", cause);
    }
    
    public static KakaoApiException coordinateNotFound(String address) {
        return new KakaoApiException("주소에 대한 좌표를 찾을 수 없습니다: " + address, "COORDINATE_NOT_FOUND", 404);
    }
}