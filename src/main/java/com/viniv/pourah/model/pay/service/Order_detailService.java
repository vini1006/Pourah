package com.viniv.pourah.model.pay.service;

import java.util.List;

import com.viniv.pourah.model.domain.Order_detail;

public interface Order_detailService {
	
	public Order_detail selectById(int order_detail_id);
	
	public List selectByOrder_summaryId(int member_id);
	


}
