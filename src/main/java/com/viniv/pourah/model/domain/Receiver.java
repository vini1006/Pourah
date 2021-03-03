package com.viniv.pourah.model.domain;

import lombok.Data;

@Data
public class Receiver {
	private int receiver_id;
	private int member_id;
	private String r_name;
	private String r_phone;
	private int zipcode;
	private String addr1;
	private String addr2;
	private String receiver_name;
	
}
