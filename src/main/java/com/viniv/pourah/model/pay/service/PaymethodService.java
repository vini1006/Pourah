package com.viniv.pourah.model.pay.service;

import java.util.List;

import com.viniv.pourah.model.domain.Paymethod;

public interface PaymethodService {
	
	public List selectAll();
	
	public Paymethod selectById(int paymethod_id);
	

}
