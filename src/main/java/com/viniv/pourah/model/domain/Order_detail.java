package com.viniv.pourah.model.domain;

import lombok.Data;

@Data
public class Order_detail {
	private int order_detail_id;
	private int order_summary_id;
	private int product_id;
	private Product product;
	private int order_state_id;
	private Order_state order_state;
	private int ori_price;
	private int quantity;
}
