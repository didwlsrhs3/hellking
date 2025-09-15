package net.koreate.hellking.user.vo;

import lombok.Data;
import java.util.Date;

@Data
public class UserAuthVO {
    private Long authNum;
    private Long userNum;
    private String authType;     // SMS, EMAIL
    private String authCode;
    private Date expireTime;
    private String isVerified;
}