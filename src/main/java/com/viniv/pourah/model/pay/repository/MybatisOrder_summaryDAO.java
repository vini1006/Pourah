package com.viniv.pourah.model.pay.repository;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.viniv.pourah.exception.NullListException;
import com.viniv.pourah.exception.OrderFailException;
import com.viniv.pourah.model.domain.Order_summary;

@Repository
public class MybatisOrder_summaryDAO implements Order_summaryDAO{
	
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate; 

	@Override
	public Order_summary selectById(int order_summary_id) {
		return null;
	}
	
	@Override
	public List selectAll() {
		return sqlSessionTemplate.selectList("Order_summary.selectAll");
	}

	@Override
	public List selectByMemberId(int member_id) throws NullListException {
		List obj = sqlSessionTemplate.selectList("Order_summary.selectByMemberId", member_id) ;
		if(obj.size() == 0) {
			throw new NullListException("주문 목록이 비어져있습니다^^ 장바구니에 담으러 갑니다.");
		}
		return obj;
	}

	@Override
	public List selectByPaymethodId(int paymethod_id) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void insert(Order_summary order_summary) throws OrderFailException {
		int result = sqlSessionTemplate.insert("Order_summary.insert", order_summary);
		if(result == 0) {
			throw new OrderFailException("주문 자체 를 실패하였습니다. 관리자에게 문의 부탁드립니다.");
		}
	}
	

}
