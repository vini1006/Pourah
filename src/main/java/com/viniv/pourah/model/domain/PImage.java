package com.viniv.pourah.model.domain;

import lombok.Data;

@Data
public class PImage {
	private int p_image_id;
	private int product_id;
	private String filename; //확장자명

}
