package com.viniv.pourah.model.product.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.viniv.pourah.model.product.repository.ReviewDAO;
import com.viniv.pourah.exception.NullListException;
import com.viniv.pourah.model.domain.Review;

@Service
public class ReviewServiceImpl implements ReviewService {
	
	@Autowired
	private ReviewDAO reviewDAO;
	
	@Override
	public void registReview(Review review) {
		if(review.getOrigin_id() == 0) { //원글
			reviewDAO.insert(review);
			reviewDAO.updateOrigin(review.getReview_id());
		}else { //리플
			reviewDAO.insert(review);
			int review_id = review.getReview_id();
			int origin_id = review.getOrigin_id();
			System.out.println(origin_id);
			System.out.println(review_id);
			reviewDAO.updateRank(origin_id, review_id);
		}
	}
	
	@Override
	public List getReviewList() {
		return reviewDAO.selectAll();
	}
	
	@Override
	public List getReviewListByProductId(int product_id) {
		return reviewDAO.selectByProductId(product_id);
	}
	
	@Override
	public List getReply(Review review) throws NullListException {
		return reviewDAO.selectReplyByProductId(review);
	}
	

}
