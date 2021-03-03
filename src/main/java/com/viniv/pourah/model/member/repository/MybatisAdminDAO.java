package com.viniv.pourah.model.member.repository;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.viniv.pourah.exception.IDOverlapException;
import com.viniv.pourah.exception.MemberStatusChangeException;
import com.viniv.pourah.exception.AdminWrongLogginException;
import com.viniv.pourah.model.domain.Admin;

@Repository
public class MybatisAdminDAO implements AdminDAO{
	
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	@Override
	public List selectAll() {
		return sqlSessionTemplate.selectList("Admin.selectAll");
	}

	@Override
	public Admin select(Admin admin) {
		Admin obj = sqlSessionTemplate.selectOne("Admin.select", admin);
		if(obj == null) {
			throw new AdminWrongLogginException("아이디 혹은 비밀번호가 틀렸습니다.");
		}
		return obj;
	}
	
	@Override
	public Admin selectByUserId(String user_id) throws IDOverlapException{
		Admin obj = sqlSessionTemplate.selectOne("Admin.selectByUserId",user_id);
		return obj;
	}

	@Override
	public void insert(Admin admin) throws MemberStatusChangeException {
		int result = sqlSessionTemplate.insert("Admin.insert", admin);
		if(result == 0) {
			throw new MemberStatusChangeException("계정 등록에 실패하였습니다.");
		}
	}

	@Override
	public void update(Admin admin) throws MemberStatusChangeException {
		int result = sqlSessionTemplate.update("Admin.update", admin);
		if(result == 0) {
			throw new MemberStatusChangeException("계정 수정에 실패하였습니다.");
		}
	}

	@Override
	public void delete(int admin_id) throws MemberStatusChangeException {
		int result = sqlSessionTemplate.delete("Admin.delete", admin_id);
		if(result == 0) {
			throw new MemberStatusChangeException("계정 삭제에 실패하였습니다.");
		}
	}

	
	

}
