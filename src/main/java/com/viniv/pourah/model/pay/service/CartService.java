package com.viniv.pourah.model.pay.service;

import java.util.List;

import com.viniv.pourah.model.domain.Cart;

public interface CartService {
	
	public List selectAll();
	
	public List selectById(int cart_id);
	
	public List selectByMemberId(int member_id);
	
	public void registCart(Cart cart);
	
	public void changeQuantity(int cart_id, String method);
	
	public void deleteByCartId(int cart_id);

}
