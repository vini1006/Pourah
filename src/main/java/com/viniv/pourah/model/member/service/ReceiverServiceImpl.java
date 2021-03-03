package com.viniv.pourah.model.member.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.viniv.pourah.model.domain.Receiver;
import com.viniv.pourah.model.member.repository.ReceiverDAO;

@Service
public class ReceiverServiceImpl implements ReceiverService {
	
	@Autowired
	private ReceiverDAO receiverDAO;

	@Override
	public List selectAllByMemberId(int member_id) {
		return receiverDAO.selectAllByMemberId(member_id);
	}

	@Override
	public Receiver selectById(int receiver_id) {
		return receiverDAO.selectById(receiver_id);
	}

	@Override
	public void insert(Receiver receiver) {
		receiverDAO.insert(receiver);
	}

	@Override
	public void delete(int receiver_id) {
		receiverDAO.delete(receiver_id);
	}
	
	

}
