package com.viniv.pourah.model.product.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.viniv.pourah.model.domain.Atopcategory;
import com.viniv.pourah.model.product.repository.MybatisAtopcategoryDAO;

@Service
public class AtopcategoryserviceImpl implements AtopcategoryService {
	
	@Autowired
	private MybatisAtopcategoryDAO mybatisAtopcategoryDAO; 
	
	@Override
	public List selectAll() {
		return mybatisAtopcategoryDAO.selectAll();
	}
	
	@Override
	public List selectEverything() {
		return mybatisAtopcategoryDAO.selectEverything();
	}

	@Override
	public Atopcategory selectById(int a_topcategory_id) {
		return mybatisAtopcategoryDAO.selectById(a_topcategory_id);
	}
	
	@Override
	public void insertMaxRank(Atopcategory atopcategory) {
		mybatisAtopcategoryDAO.insertMaxRank(atopcategory);
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
