package com.viniv.pourah.model.pay.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.viniv.pourah.exception.OrderFailException;
import com.viniv.pourah.model.domain.Order_detail;
import com.viniv.pourah.model.domain.Order_summary;
import com.viniv.pourah.model.pay.repository.CartDAO;
import com.viniv.pourah.model.pay.repository.Order_detailDAO;
import com.viniv.pourah.model.pay.repository.Order_summaryDAO;

//결제할때 오더썸머리 오더디테일 트랜잭션 하나로 묶기위한 서비스
@Service
public class OrderServiceImpl implements OrderService{
	
	@Autowired
	private Order_summaryDAO order_summaryDAO;
	
	@Autowired
	private Order_detailDAO order_detailDAO;
	
	@Autowired
	private CartDAO cartDAO;
	
	
	@Override
	public void registOrder(Order_summary order_summary, List<Order_detail> order_detailList, int member_id) throws OrderFailException {
		order_summaryDAO.insert(order_summary);
		int order_summary_id = order_summary.getOrder_summary_id();
		for(Order_detail order_detail : order_detailList) {
			order_detail.setOrder_summary_id(order_summary_id);
			order_detailDAO.insert(order_detail);
		}
		cartDAO.deleteByMemberId(member_id);
	}

}
