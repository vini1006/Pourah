package com.viniv.pourah.model.pay.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.viniv.pourah.model.domain.Order_detail;
import com.viniv.pourah.model.pay.repository.Order_detailDAO;

@Service
public class Order_detailServiceImpl implements Order_detailService {
	
	@Autowired
	private Order_detailDAO order_detailDAO;

	@Override
	public Order_detail selectById(int order_detail_id) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List selectByOrder_summaryId(int member_id) {
		// TODO Auto-generated method stub
		return null;
	}


}
