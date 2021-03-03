package com.viniv.pourah.model.pay.repository;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.viniv.pourah.exception.OrderFailException;
import com.viniv.pourah.model.domain.Order_detail;
import com.viniv.pourah.model.domain.Order_summary;

@Repository
public class MybatisOrder_detailDAO implements Order_detailDAO {
	
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;

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


	@Override
	public void insert(Order_detail order_detail) throws OrderFailException {
		int result = sqlSessionTemplate.insert("Order_detail.insert",order_detail);
		if(result == 0) {
			throw new OrderFailException("주문에 실패하였습니다. 관리자에게 문의 부탁드립니다.");
		}
	}
	
	

}
