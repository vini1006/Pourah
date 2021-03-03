package com.viniv.pourah.model.product.service;

import java.util.List;

import com.viniv.pourah.model.domain.Review;

public interface ReviewService {
	
	public void registReview(Review review);
	
	public List getReviewList();
	
	public List getReviewListByProductId(int product_id);
	
	public List getReply(Review review);
	
}
