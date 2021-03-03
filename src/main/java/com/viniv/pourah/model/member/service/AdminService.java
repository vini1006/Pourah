package com.viniv.pourah.model.member.service;

import java.util.List;

import com.viniv.pourah.model.domain.Admin;

public interface AdminService {

	public List selectAll();
	
	public Admin Login(Admin admin); 
	
	public Admin overlapCheck(String user_id);
	
	public Admin selectById(String user_id);
	
	public void registAdmin(Admin admin);
	
	public void update(Admin admin);
	
	public void delete(int admin_id);
	
	public void forgotPasswd(String user_id);

}
