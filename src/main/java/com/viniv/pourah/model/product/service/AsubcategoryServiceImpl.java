package com.viniv.pourah.model.product.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.viniv.pourah.model.domain.Asubcategory;
import com.viniv.pourah.model.product.repository.AsubcategoryDAO;

@Service
public class AsubcategoryServiceImpl implements AsubcategoryService  {
	
	@Autowired
	private AsubcategoryDAO asubcategoryDAO;

	@Override
	public List selectAll() {
		return asubcategoryDAO.selectAll();
	}

	@Override
	public List selectByAtopId(int a_topcateogry_id) {
		return asubcategoryDAO.selectByAtopId(a_topcateogry_id);
	}

	@Override
	public void insertMaxRank(Asubcategory asubcategory) {
		asubcategoryDAO.insertMaxRank(asubcategory);
	}

	@Override
	public void update() {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void delete() {
		// TODO Auto-generated method stub
		
	}
	
	

}
