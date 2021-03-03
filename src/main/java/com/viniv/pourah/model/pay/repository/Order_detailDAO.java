package com.viniv.pourah.model.pay.repository;

import java.util.List;

import com.viniv.pourah.model.domain.Order_detail;
import com.viniv.pourah.model.domain.Order_summary;

public interface Order_detailDAO {
	
	public Order_detail selectById(int order_detail_id);
	
	public List selectByOrder_summaryId(int member_id);
	
	
	public void insert(Order_detail order_detail);

}
