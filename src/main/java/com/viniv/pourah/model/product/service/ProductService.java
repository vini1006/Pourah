package com.viniv.pourah.model.product.service;

import java.util.List;

import com.viniv.pourah.model.common.FileManager;
import com.viniv.pourah.model.domain.Product;

public interface ProductService {
	
	public List selectAll();
	
	public List selectByASubId(int a_subcategory_id);
	
	public List selectByASubId(List<Integer> a_subcategory_Id);
	
	public Product selectById(int product_id);
	
	public void regist(Product product, FileManager fileManager);
	
	public void update(Product product, FileManager fileManager);
	
	public void delete(int product_id);

}
