package com.viniv.pourah.model.domain;

import lombok.Data;

@Data
public class Member {
	
	private int member_id;
	private String user_id;
	private String user_passwd;
	private String m_name;
	private String m_birthdate;
	private String m_email;
	private String m_emailaddr;
	private String m_phone;
	private int zipcode;
	private String addr1;
	private String addr2;
	private String regdate;
	private String authstate;

}
