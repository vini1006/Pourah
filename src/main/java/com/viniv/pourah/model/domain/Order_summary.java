package com.viniv.pourah.model.domain;

import java.util.List;

import lombok.Data;

@Data
public class Order_summary {
	private int order_summary_id;
	private int member_id;
	private int paymethod_id;
	private Paymethod paymethod;
	private int total_price;
	private String order_date;
	private int zipcode;
	private String addr1;
	private String addr2;
	private String r_name;
	private String r_phone;
	private List<Order_detail> order_detail;
}
