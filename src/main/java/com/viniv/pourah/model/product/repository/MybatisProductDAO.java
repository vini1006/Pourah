package com.viniv.pourah.model.product.repository;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.viniv.pourah.exception.ProductStatusChangedException;
import com.viniv.pourah.model.domain.Product;

@Repository
public class MybatisProductDAO implements ProductDAO {
	
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;

	@Override
	public List selectAll() {
		return sqlSessionTemplate.selectList("Product.selectAll");
	}

	@Override
	public List selectByASubId(int a_subcategory_id) {
		return sqlSessionTemplate.selectList("Product.selectByASubId", a_subcategory_id);
	}
	
	@Override
	public List selectByASubId(List<Integer> a_subcategory_id) {
		return sqlSessionTemplate.selectList("Product.selectByASubId", a_subcategory_id);
	}

	@Override
	public Product selectById(int product_id) {
		return sqlSessionTemplate.selectOne("Product.selectById", product_id);
	}

	@Override
	public void insert(Product product) throws ProductStatusChangedException {
		int result = sqlSessionTemplate.insert("Product.insert", product);
		if(result == 0) {
			throw new ProductStatusChangedException("등록에 실패하였습니다.");
		}
	}

	@Override
	public void update(Product product) throws ProductStatusChangedException {
		int result = sqlSessionTemplate.update("Product.update", product);
		if(result == 0) {
			throw new ProductStatusChangedException("상품 수정에 실패하였습니다.");
		}
	}

	@Override
	public void delete(int product_id) throws ProductStatusChangedException{
		int result = sqlSessionTemplate.delete("Product.delete", product_id);
		if(result == 0) {
			throw new ProductStatusChangedException("상품 삭제에 실패하였습니다.");
		}
	}
	

}
