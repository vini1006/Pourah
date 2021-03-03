package com.viniv.pourah.model.product.service;

import java.util.List;

import com.viniv.pourah.model.domain.Asubcategory;

public interface AsubcategoryService {
	public List selectAll();
	
	public List selectByAtopId(int a_topcateogry_id);
	
	public void insertMaxRank(Asubcategory asubcategory);
	
	public void update();
	
	public void delete();
	

}
