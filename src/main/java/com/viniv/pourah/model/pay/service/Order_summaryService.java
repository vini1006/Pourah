package com.viniv.pourah.model.pay.service;

import java.util.List;

import com.viniv.pourah.model.domain.Order_summary;

public interface Order_summaryService {
	
	public Order_summary selectById(int order_summary_id);
	
	public List selectByMemberId(int member_id);
	
	public List selectByPaymethodId(int paymethod_id);
	
	public List selectAll();
	

}
