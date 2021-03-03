package com.viniv.pourah.model.product.repository;

import java.util.List;

import com.viniv.pourah.model.domain.Asubcategory;

public interface AsubcategoryDAO {
	
	public List selectAll();
	
	public List selectByAtopId(int a_topcateogry_id);
	
	public void insertMaxRank(Asubcategory asubcategory);
	
	public void update();
	
	public void delete();

}
