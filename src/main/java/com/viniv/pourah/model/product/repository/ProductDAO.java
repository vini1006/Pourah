package com.viniv.pourah.model.product.repository;

import java.util.List;

import com.viniv.pourah.model.domain.Product;

public interface ProductDAO {
	
	public List selectAll();
	
	public List selectByASubId(int a_subcategory_id);
	
	public List selectByASubId(List<Integer> a_subcategory_id);
	
	public Product selectById(int product_id);
	
	public void insert(Product product);
	
	public void update(Product product);
	
	public void delete(int product_id);
}
