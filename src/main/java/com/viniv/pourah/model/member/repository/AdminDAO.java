package com.viniv.pourah.model.member.repository;

import java.util.List;

import com.viniv.pourah.model.domain.Admin;

public interface AdminDAO {
	
	public List selectAll();
	
	public Admin select(Admin admin);
	
	public Admin selectByUserId(String user_id);
	
	public void insert(Admin admin);
	
	public void update(Admin admin);
	
	public void delete(int admin_id);

}
