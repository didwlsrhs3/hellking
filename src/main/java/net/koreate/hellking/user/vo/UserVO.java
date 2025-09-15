package net.koreate.hellking.user.vo;

import lombok.Data;
import java.util.Date;
import org.springframework.format.annotation.DateTimeFormat;

@Data
public class UserVO {
    private Long userNum;        
    private String userId;       
    private String username;
    private String email;
    private String phone;
    private String password;
    private String profileImage;
    
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date birthDate;      // 이 부분에 어노테이션 추가
    
    private String gender;
    private Date joinDate;
    private String status;
    
    // 조인용 추가 필드
    private String passName;     
    private Date passEndDate;    
    private String passStatus;   
}