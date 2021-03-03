package com.viniv.pourah.model.product.repository;

import java.util.List;

import com.viniv.pourah.model.domain.Review;

public interface ReviewDAO {
	
	public void insert(Review review);
	
	public void updateOrigin(int origin_id);
	
	public void updateRank(int origin_id, int review_id);
	
	public List selectByProductId(int product_id);
	
	public List selectReplyByProductId(Review review);
	
	public List selectAll();

}
