package com.viniv.pourah.model.pay.service;

import java.util.List;

import org.apache.commons.io.input.NullInputStream;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.viniv.pourah.exception.CountZeroException;
import com.viniv.pourah.exception.NullListException;
import com.viniv.pourah.exception.CartOverlapException;
import com.viniv.pourah.model.domain.Cart;
import com.viniv.pourah.model.pay.repository.CartDAO;

@Service
public class CartServiceImpl implements CartService {
	
	@Autowired
	private CartDAO cartDAO;

	@Override
	public List selectAll() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List selectById(int cart_id) {
		// TODO Auto-generated method stub
		return null;
	}
	

	@Override //카트리스트조회 
	public List selectByMemberId(int member_id) throws NullListException {
		return cartDAO.selectByMemberId(member_id);
	}

	@Override
	public void registCart(Cart cart) throws CartOverlapException {
		
		//먼저 카트내 상품이 중복되는지 확인하고 (throw 걸어놓음) 
		cartDAO.selectByProductId(cart.getProduct().getProduct_id());
		cartDAO.insert(cart);
	}
	
	@Override
	public void changeQuantity(int cart_id, String method) throws CountZeroException {
		Cart cart = cartDAO.selectById(cart_id);
		if(method.equals("plus")) {
			cartDAO.updatePlus(cart_id);
		}else if(method.equals("minus")) {
			if(cart.getQuantity() <= 1) {
				throw new CountZeroException("더 줄일수가 없어용~^^~");
			}
			cartDAO.updateMinus(cart_id);
		}
	}
	
	@Override
	public void deleteByCartId(int cart_id) {
		cartDAO.deleteByCartId(cart_id);
	}
}
