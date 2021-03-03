package com.viniv.pourah.model.domain;

import lombok.Data;

@Data
public class Review {
	
	private int review_id;
	private int product_id;
	private Member member;
	private int member_id;
	private String detail;
	private int score;
	private String regdate;
	private int rank;
	private int origin_id;

}
