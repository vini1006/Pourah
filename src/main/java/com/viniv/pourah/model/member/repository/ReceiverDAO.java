package com.viniv.pourah.model.member.repository;

import java.util.List;

import com.viniv.pourah.model.domain.Member;
import com.viniv.pourah.model.domain.Receiver;

public interface ReceiverDAO {
	
	public List selectAllByMemberId(int member_id);
	
	public Receiver selectById(int receiver_id);
	
	public void insert(Receiver receiver);
	
	public void delete(int receiver_id);
}
