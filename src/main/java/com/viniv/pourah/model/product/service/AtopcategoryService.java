package com.viniv.pourah.model.product.service;

import java.util.List;

import com.viniv.pourah.model.domain.Atopcategory;

public interface AtopcategoryService {
	
	public List selectAll();
	
	public List selectEverything();
	
	public Atopcategory selectById(int a_topcategory_id);
	
	public void insertMaxRank(Atopcategory atopcategory);
	
	public void update();
	
	public void delete();


}
