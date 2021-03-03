package com.viniv.pourah.model.member.repository;

import java.util.List;

import com.viniv.pourah.model.domain.Member;
import com.viniv.pourah.model.domain.Member;

public interface MemberDAO {
	
	public List selectAll();
	
	public Member select(Member member);
	
	public Member selectByUserId(String user_id);
	
	public void insert(Member member);
	
	public void update(Member member);
	
	public void delete(int member_id);
}
