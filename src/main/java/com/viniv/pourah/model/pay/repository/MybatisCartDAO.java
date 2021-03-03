package com.viniv.pourah.model.pay.repository;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.viniv.pourah.exception.CartOverlapException;
import com.viniv.pourah.exception.NullListException;
import com.viniv.pourah.model.domain.Cart;

@Repository
public class MybatisCartDAO implements CartDAO {
	
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	@Override
	public List selectAll() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Cart selectById(int cart_id) {
		return sqlSessionTemplate.selectOne("Cart.selectById", cart_id);
	}
	
	@Override
	public Cart selectByProductId(int product_id) throws CartOverlapException {
		Cart obj = sqlSessionTemplate.selectOne("Cart.selectByProductId", product_id);
		if(obj != null) {
			throw new CartOverlapException("이미 담겨져 있는 상품입니다.");
		}
		
		return obj;
	}
	

	@Override
	public List selectByMemberId(int member_id) throws NullListException {
		List obj = sqlSessionTemplate.selectList("Cart.selectByMemberId", member_id);
		if(obj.size() == 0) {
			throw new NullListException("담아놓으신 상품이 없네요 ^^ 상품리스트로 돌아갑니다.");
		}
		return obj;
	}

	@Override
	public void insert(Cart cart) {
		sqlSessionTemplate.insert("Cart.insert", cart);
	}

	@Override
	public void updatePlus(int cart_id) {
		sqlSessionTemplate.update("Cart.updatePlus", cart_id);
	}
	
	@Override
	public void updateMinus(int cart_id) {
		sqlSessionTemplate.update("Cart.updateMinus", cart_id);
	}
	

	@Override
	public void deleteByCartId(int cart_id) {
		sqlSessionTemplate.delete("Cart.deleteByCartId", cart_id);
	}
	
	@Override
	public void deleteByMemberId(int member_id) {
		sqlSessionTemplate.delete("Cart.deleteByMemberId", member_id);
		
	}
	
	

}
