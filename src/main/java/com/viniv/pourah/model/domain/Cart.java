package com.viniv.pourah.model.domain;

import lombok.Data;

@Data
public class Cart {
	private int cart_id;
	private Product product;
	private int member_id;
	private int quantity;
}
