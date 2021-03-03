package com.viniv.pourah.model.member.repository;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.viniv.pourah.model.domain.Receiver;

@Repository
public class MybatisReceiverDAO implements ReceiverDAO {
	
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;

	@Override
	public List selectAllByMemberId(int member_id) {
		return sqlSessionTemplate.selectList("Receiver.selectAllByMemberId", member_id);
	}

	@Override
	public Receiver selectById(int receiver_id) {
		return sqlSessionTemplate.selectOne("Receiver.selectById", receiver_id);
	}

	@Override
	public void insert(Receiver receiver) {
		sqlSessionTemplate.insert("Receiver.insert", receiver);
		
	}

	@Override
	public void delete(int receiver_id) {
		sqlSessionTemplate.delete("Receiver.deleteById",receiver_id);
	}
	
}
