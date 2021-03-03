package com.viniv.pourah.model.member.repository;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.viniv.pourah.exception.IDOverlapException;
import com.viniv.pourah.exception.MemberWrongLogginException;
import com.viniv.pourah.model.domain.Member;

@Repository
public class MybatisMemberDAO implements MemberDAO {
	
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	private static final Logger logger = LoggerFactory.getLogger(MybatisMemberDAO.class);

	@Override
	public List selectAll() {
		return sqlSessionTemplate.selectList("Member.selectAll");
	}

	@Override //로그인
	public Member select(Member member) throws MemberWrongLogginException {
		Member obj = sqlSessionTemplate.selectOne("Member.select", member);
		if(obj == null) {
			throw new MemberWrongLogginException("아이디 혹은 비밀번호가 틀렸습니다.");
		}
		return obj;
	}

	@Override //중복확인
	public Member selectByUserId(String user_id) throws IDOverlapException {
		Member obj = sqlSessionTemplate.selectOne("Member.selectByUserId",user_id);
		if(obj != null) {
			throw new IDOverlapException(" 이미 사용중인 ID 입니다.");
		}
		return obj;
	}

	@Override
	public void insert(Member member) throws MemberWrongLogginException {
		int result = sqlSessionTemplate.insert("Member.insert", member);
		if(result == 0) {
			throw new MemberWrongLogginException("회원 가입에 실패하였습니다.");
		}
	}

	@Override
	public void update(Member member) {
		sqlSessionTemplate.update("Member.update", member);
		
	}

	@Override
	public void delete(int member_id) {
		// TODO Auto-generated method stub
		
	}
	
	
	

}
