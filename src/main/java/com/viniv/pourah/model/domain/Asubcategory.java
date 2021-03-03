package com.viniv.pourah.model.domain;

import java.util.List;

import lombok.Data;

@Data
public class Asubcategory {
	private int a_subcategory_id;
	private int a_topcategory_id;
	private Atopcategory atopcategory;
	private String name;
	private int rank;
	private List<Product> productList;
}
