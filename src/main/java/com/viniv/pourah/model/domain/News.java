package com.viniv.pourah.model.domain;

import lombok.Data;

@Data
public class News {
	
	private int news_id;
	private String writer;
	private String title;
	private String url;
	private String isCheck;
	private String regdate;

}
