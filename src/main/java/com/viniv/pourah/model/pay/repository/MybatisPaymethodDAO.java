package com.viniv.pourah.model.pay.repository;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.viniv.pourah.model.domain.Paymethod;

@Repository
public class MybatisPaymethodDAO implements PaymethodDAO {
	
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;

	@Override
	public List selectAll() {
		return sqlSessionTemplate.selectList("Paymethod.selectAll");
	}

	@Override
	public Paymethod selectById(int paymethod_id) {
		return sqlSessionTemplate.selectOne("Paymethod.selectById",paymethod_id);
	}
}
