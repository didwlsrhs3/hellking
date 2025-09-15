package net.koreate.hellking.common.exception;

/**
 * 헬킹 피트니스 시스템의 기본 예외 클래스
 * 모든 비즈니스 로직 관련 예외의 부모 클래스
 */
public class HellkingException extends RuntimeException {
    
    private static final long serialVersionUID = 1L;
    
    private String errorCode;
    private Object[] parameters;
    
    public HellkingException(String message) {
        super(message);
    }
    
    public HellkingException(String message, Throwable cause) {
        super(message, cause);
    }
    
    public HellkingException(String errorCode, String message) {
        super(message);
        this.errorCode = errorCode;
    }
    
    public HellkingException(String errorCode, String message, Object... parameters) {
        super(message);
        this.errorCode = errorCode;
        this.parameters = parameters;
    }
    
    public HellkingException(String errorCode, String message, Throwable cause) {
        super(message, cause);
        this.errorCode = errorCode;
    }
    
    public String getErrorCode() {
        return errorCode;
    }
    
    public Object[] getParameters() {
        return parameters;
    }
}
