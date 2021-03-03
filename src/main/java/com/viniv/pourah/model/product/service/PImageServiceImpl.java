package com.viniv.pourah.model.product.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.viniv.pourah.model.domain.PImage;
import com.viniv.pourah.model.product.repository.PImageDAO;

@Service
public class PImageServiceImpl implements PImageService {

	@Autowired
	private PImageDAO pImageDAO; 
	
	@Override
	public List selectAll() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public PImage selectById(int p_image_id) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List selectByProductId(int product_id) {
		return pImageDAO.selectByProductId(product_id);
	}

	@Override
	public void insert(PImage pImage) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void update(PImage pImage) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void delete(int p_image_id) {
		pImageDAO.delete(p_image_id);
		
		//파일 지우기도 구현해야함
	}
	
	

}
