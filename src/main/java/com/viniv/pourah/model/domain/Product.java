package com.viniv.pourah.model.domain;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class Product {
	private int product_id;
	private int a_subcategory_id;
	private String product_name;
	private int price;
	private String brand;
	private String filename;
	private int capacity;
	private int alchole_rate;
	private String detail;
	private List<PImage> p_imageList;
	
	
	private Asubcategory asubcategory; //product Detil 부를시에 쓰일 어쏘시에이션
	private MultipartFile repImg;	//대표이미지 
	private MultipartFile[] p_image; //추가 이미지는 선택사항이며, 동시에 배열
}
