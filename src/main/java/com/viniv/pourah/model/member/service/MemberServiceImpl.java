package com.viniv.pourah.model.member.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.viniv.pourah.exception.IDOverlapException;
import com.viniv.pourah.exception.MemberStatusChangeException;
import com.viniv.pourah.exception.MemberWrongLogginException;
import com.viniv.pourah.model.common.SecureManager;
import com.viniv.pourah.model.domain.Member;
import com.viniv.pourah.model.member.repository.MemberDAO;

@Service
public class MemberServiceImpl implements MemberService{
	
	@Autowired
	private MemberDAO memberDAO;
	
	@Autowired
	private SecureManager secureManager; 

	@Override
	public List selectAll() {
		return memberDAO.selectAll();
	}

	@Override
	public Member Login(Member member) throws MemberWrongLogginException {
		//보안처리후 진행
		String hash = secureManager.getSecureData(member.getUser_passwd());
		member.setUser_passwd(hash);
		return memberDAO.select(member);
	}

	@Override
	public Member overlapCheck(String user_id) throws IDOverlapException {
		Member obj = memberDAO.selectByUserId(user_id);
		return obj;
	}

	@Override
	public Member selectById(String user_id) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void registMember(Member member) throws MemberStatusChangeException {
		member.setUser_passwd(secureManager.getSecureData(member.getUser_passwd()));
		memberDAO.insert(member);
		
		//이메일 인증 진행예정
		
	}

	@Override
	public void update(Member member) {
		memberDAO.update(member);
	}

	@Override
	public void delete(int member_id) {
		// TODO Auto-generated method stub
		
	}
	
	

}
