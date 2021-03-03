package com.viniv.pourah.model.member.service;

import java.util.List;

import com.viniv.pourah.model.domain.Receiver;

public interface ReceiverService {
	
	public List selectAllByMemberId(int member_id);
	
	public Receiver selectById(int receiver_id);
	
	public void insert(Receiver receiver);
	
	public void delete(int receiver_id);

}
