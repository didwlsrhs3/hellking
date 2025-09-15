package net.koreate.hellking.review.vo;

import lombok.Data;

@Data
public class ReviewLikeVO {
    private Long likeNum;
    private Long reviewNum;
    private Long userNum;
    private String likeType; // 'LIKE', 'DISLIKE'
}