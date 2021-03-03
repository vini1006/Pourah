package com.viniv.pourah.model.product.repository;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.viniv.pourah.model.domain.Asubcategory;


@Repository
public class MybatisAsubcategoryDAO implements AsubcategoryDAO {
	
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;

	@Override
	public List selectAll() {
		return sqlSessionTemplate.selectList("Asubcategory.selectAll");
	}

	@Override//a_subcategory VO에 포함된 product도 같이 반환
	public List selectByAtopId(int a_topcateogry_id) {
		return sqlSessionTemplate.selectList("Asubcategory.selectByAtopId", a_topcateogry_id);
	}

	@Override
	public void insertMaxRank(Asubcategory asubcategory) {
		sqlSessionTemplate.insert("Asubcategory.insertMaxRank", asubcategory);
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
