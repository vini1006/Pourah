package com.viniv.pourah.model.product.repository;

import java.util.List;

import com.viniv.pourah.model.domain.PImage;

public interface PImageDAO {
	
	public List selectAll();
	
	public PImage selectById(int p_image_id);
	
	public List selectByProductId(int product_id);
	
	public void insert(PImage pImage);
	
	public void update(PImage pImage);
	
	public void delete(int p_image_id);

}
