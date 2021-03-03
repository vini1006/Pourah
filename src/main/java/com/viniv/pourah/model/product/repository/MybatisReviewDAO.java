package com.viniv.pourah.model.product.repository;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.viniv.pourah.exception.NullListException;
import com.viniv.pourah.model.domain.Review;

@Repository
public class MybatisReviewDAO implements ReviewDAO {
	Logger logger = LoggerFactory.getLogger(MybatisReviewDAO.class);
	
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;

	@Override
	public void insert(Review review) {
		sqlSessionTemplate.insert("Review.insert", review);
	}
	
	@Override
	public void updateOrigin(int origin_id) {
		sqlSessionTemplate.update("Review.updateOrigin", origin_id);
	}
	
	@Override
	public void updateRank(int origin_id, int review_id) {
		Review review = new Review();
		review.setReview_id(review_id);
		review.setOrigin_id(origin_id);
		sqlSessionTemplate.update("Review.updateRank", review);
		
	}
	
	@Override
	public List selectByProductId(int product_id) {
		return sqlSessionTemplate.selectList("Review.selectByProductId", product_id);
	}
	
	@Override
	public List selectReplyByProductId(Review review) throws NullListException {
		logger.debug("넘어온거"+review);
		List obj = sqlSessionTemplate.selectList("Review.selectReplyByProductId", review);
		if(obj.size() == 0) {
			throw new NullListException("대댓글이 없네요 ㅠㅠ");
		}
		return obj;
	}
	
	@Override
	public List selectAll() {
		return sqlSessionTemplate.selectList("Review.selectAll");
	}

}
