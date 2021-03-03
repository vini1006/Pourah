package com.viniv.pourah.model.pay.repository;

import java.util.List;

import com.viniv.pourah.model.domain.Cart;
import com.viniv.pourah.model.domain.Paymethod;

public interface PaymethodDAO {
	
	public List selectAll();
	
	public Paymethod selectById(int paymethod_id);

}
