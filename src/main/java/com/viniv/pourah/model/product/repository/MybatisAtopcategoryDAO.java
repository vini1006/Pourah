package com.viniv.pourah.model.product.repository;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.viniv.pourah.model.domain.Atopcategory;

@Repository
public class MybatisAtopcategoryDAO implements AtopcategoryDAO{
	
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate; 

	@Override
	public List selectAll() {
		return sqlSessionTemplate.selectList("Atopcategory.selectAll");
	}
	
	@Override
	public List selectEverything() {
		return sqlSessionTemplate.selectList("Atopcategory.selectEverything");
	}

	@Override
	public Atopcategory selectById(int a_topcategory_id) {
		return sqlSessionTemplate.selectOne("Atopcategory.selectById", a_topcategory_id);
	}

	@Override
	public void insertMaxRank(Atopcategory atopcategory) {
		sqlSessionTemplate.insert("Atopcategory.insertMaxRank", atopcategory);
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
