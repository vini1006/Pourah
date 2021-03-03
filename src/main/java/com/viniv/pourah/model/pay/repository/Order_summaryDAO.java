package com.viniv.pourah.model.pay.repository;

import java.util.List;
import com.viniv.pourah.model.domain.Order_summary;

public interface Order_summaryDAO {
	

	public Order_summary selectById(int order_summary_id);
	
	public List selectByMemberId(int member_id);
	
	public List selectByPaymethodId(int paymethod_id);
	
	public void insert(Order_summary order_summary);
	
	public List selectAll();
	

}
