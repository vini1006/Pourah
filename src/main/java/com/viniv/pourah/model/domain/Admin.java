package com.viniv.pourah.model.domain;

import lombok.Data;

@Data
public class Admin {
	private int admin_id;
	private String user_id;
	private String user_passwd;
	private String user_name;
	private String phone;
	private String email_id;
	private String email_addr;
	private String auth;

}
