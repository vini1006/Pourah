package com.viniv.pourah.model.pay.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.viniv.pourah.exception.CountZeroException;
import com.viniv.pourah.exception.NullListException;
import com.viniv.pourah.model.domain.Order_summary;
import com.viniv.pourah.model.pay.repository.Order_summaryDAO;


@Service
public class Order_summaryServiceImpl implements Order_summaryService {

	@Autowired
	private Order_summaryDAO order_summaryDAO;
	
	@Override
	public Order_summary selectById(int order_summary_id) {
		// TODO Auto-generated method stub
		return null;
	}
	
	@Override
	public List selectAll() {
		return order_summaryDAO.selectAll();
	}

	@Override
	public List selectByMemberId(int member_id) throws NullListException {
		return order_summaryDAO.selectByMemberId(member_id);
	}

	@Override
	public List selectByPaymethodId(int paymethod_id) {
		// TODO Auto-generated method stub
		return null;
	}


}
