package com.viniv.pourah.model.pay.repository;

import java.util.List;

import com.viniv.pourah.model.domain.Asubcategory;
import com.viniv.pourah.model.domain.Cart;

public interface CartDAO {
	
public List selectAll();
	
	public Cart selectById(int cart_id);
	
	//중복여부 확인용
	public Cart selectByProductId(int product_id);
	
	public List selectByMemberId(int member_id);
	
	public void insert(Cart cart);
	
	public void updatePlus(int cart_id);
	
	public void updateMinus(int cart_id);
	
	public void deleteByCartId(int cart_id);
	
	public void deleteByMemberId(int member_id);

	
}
