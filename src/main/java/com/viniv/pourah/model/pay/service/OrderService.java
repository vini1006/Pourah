package com.viniv.pourah.model.pay.service;

import java.util.List;

import com.viniv.pourah.model.domain.Order_detail;
import com.viniv.pourah.model.domain.Order_summary;

//오더 등록할때 트랜잭션으로 묶기위한 하나의 service
public interface OrderService {
	
	public void registOrder(Order_summary order_summary, List<Order_detail> order_detailList, int member_id);
}
