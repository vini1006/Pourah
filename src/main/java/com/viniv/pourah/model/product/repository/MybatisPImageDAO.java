package com.viniv.pourah.model.product.repository;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.viniv.pourah.model.domain.PImage;

@Repository
public class MybatisPImageDAO implements PImageDAO{
	
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;

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
		return sqlSessionTemplate.selectList("PImage.selectByProductId", product_id);
	}

	@Override
	//ID 입력하는 selectKey 있음
	public void insert(PImage pImage) {
		sqlSessionTemplate.insert("PImage.insert", pImage);
	}

	@Override
	public void update(PImage pImage) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void delete(int p_image_id) {
		sqlSessionTemplate.delete("PImage.delete", p_image_id);
		
	}
	
	

}
