package com.viniv.pourah.model.member.service;

import java.util.List;

import com.viniv.pourah.model.domain.Member;

public interface MemberService {
	
public List selectAll();
	
	public Member Login(Member member); 
	
	public Member overlapCheck(String user_id);
	
	public Member selectById(String user_id);
	
	public void registMember(Member member);
	
	public void update(Member member);
	
	public void delete(int member_id);

}
