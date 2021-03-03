
package com.viniv.pourah.model.domain;

import java.util.List;

import lombok.Data;

@Data
public class Atopcategory {
	private int a_topcategory_id;
	private String name;
	private int rank;
	private List<Asubcategory> a_subcategory;
}
