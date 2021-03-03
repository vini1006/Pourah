package com.viniv.pourah.model.member.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.viniv.pourah.exception.IDOverlapException;
import com.viniv.pourah.exception.MemberStatusChangeException;
import com.viniv.pourah.exception.AdminWrongLogginException;
import com.viniv.pourah.model.common.MailSender;
import com.viniv.pourah.model.common.SecureManager;
import com.viniv.pourah.model.domain.Admin;
import com.viniv.pourah.model.member.repository.AdminDAO;

@Service
public class AdminServiceImpl implements AdminService {
	
	@Autowired
	private SecureManager secureManager;

	@Autowired
	private AdminDAO adminDAO;
	
	@Autowired
	private MailSender mailSender;
	
	@Override
	public List selectAll() {
		return adminDAO.selectAll();
	}
	
	@Override
	public Admin overlapCheck(String user_id) throws IDOverlapException{
		Admin obj = adminDAO.selectByUserId(user_id);
		if(obj != null) {
			throw new IDOverlapException("이미 존재하는 아이디입니다.");
		}
		return obj;
	}
	
	@Override
	public Admin selectById(String user_id) {
		Admin admin = adminDAO.selectByUserId(user_id);
		return admin;
	}
	

	@Override
	public Admin Login(Admin admin) throws AdminWrongLogginException {
		admin.setUser_passwd(secureManager.getSecureData(admin.getUser_passwd()));
		return adminDAO.select(admin);
	}

	@Override
	public void registAdmin(Admin admin) throws MemberStatusChangeException {
		admin.setUser_passwd(secureManager.getSecureData(admin.getUser_passwd()));
		adminDAO.insert(admin);
	}

	@Override
	public void update(Admin admin) throws MemberStatusChangeException {
		if(admin.getUser_passwd() != null) {
			admin.setUser_passwd(secureManager.getSecureData(admin.getUser_passwd()));
		}
		adminDAO.update(admin);
	}
	
	@Override
	public void forgotPasswd(String user_id) throws AdminWrongLogginException  {
		Admin admin = adminDAO.selectByUserId(user_id);
		if(admin == null) {
			throw new AdminWrongLogginException("일치하는 아이디가 존재하지 않습니다.");
		}
		String emailAddr = admin.getEmail_id()+"@"+admin.getEmail_addr();
		String newCode = secureManager.getRandomPassword(6);
		String hash = secureManager.getSecureData(newCode);
		admin.setUser_passwd(hash);
		adminDAO.update(admin);
		mailSender.send(emailAddr, "부어라 마셔라 입니다 ~ 새로운 비밀번호 보내드립니다.", "임시 비밀번호입니다. 변경 부탁드립니다."+newCode);
	}
	
	
	@Override
	public void delete(int admin_id) throws MemberStatusChangeException {
		adminDAO.delete(admin_id);
	}
	

}
