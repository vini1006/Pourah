package com.viniv.pourah.model.pay.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.viniv.pourah.model.domain.Paymethod;
import com.viniv.pourah.model.pay.repository.PaymethodDAO;

@Service
public class PaymethodServiceImple implements PaymethodService{
	
	@Autowired
	private PaymethodDAO paymethodDAO;

	@Override
	public List selectAll() {
		return paymethodDAO.selectAll();
	}

	@Override
	public Paymethod selectById(int paymethod_id) {
		return paymethodDAO.selectById(paymethod_id);
	}
	
	

}
