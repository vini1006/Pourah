package com.viniv.pourah.model.product.service;

import java.io.File;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.viniv.pourah.exception.ProductStatusChangedException;
import com.viniv.pourah.model.common.FileManager;
import com.viniv.pourah.model.domain.PImage;
import com.viniv.pourah.model.domain.Product;
import com.viniv.pourah.model.product.repository.PImageDAO;
import com.viniv.pourah.model.product.repository.ProductDAO;

@Service
public class ProductServiceImpl implements ProductService {
	
	@Autowired
	private ProductDAO productDAO;
	
	@Autowired
	private PImageDAO pImageDAO;
	

	@Override
	public List selectAll() {
		return productDAO.selectAll();
	}

	@Override
	public List selectByASubId(int a_subcategory_id) {
		return productDAO.selectByASubId(a_subcategory_id);
	}
	
	@Override
	public List selectByASubId(List<Integer> a_subcategory_Id) {
		return productDAO.selectByASubId(a_subcategory_Id);
	}

	@Override
	public Product selectById(int product_id) {
		return productDAO.selectById(product_id);
	}

	@Override
	public void regist(Product product, FileManager fileManager) throws ProductStatusChangedException {
		String basicDir = fileManager.getSaveBasicDir();
		String addonDir = fileManager.getSaveAddonDir();
		
		//대표이미지 처리
		 MultipartFile repImg =  product.getRepImg();
		 String repImgExt = fileManager.getExtend(repImg.getOriginalFilename());
		 
		 product.setFilename(repImgExt); //확장자명을 filename, 파일명은 product_id
		 productDAO.insert(product);
		 
		 String basicfilename = product.getProduct_id()+"."+repImgExt;
		 fileManager.saveFile(basicDir+File.separator+basicfilename, repImg);
		 
		 //부가이미지 처리
		 if(product.getP_image() != null) {
			 MultipartFile[] p_image = product.getP_image();
			 for(MultipartFile file : p_image) {
				 String addImgExt = fileManager.getExtend(file.getOriginalFilename());
				 PImage pImage = new PImage();
				 pImage.setFilename(addImgExt);
				 pImage.setProduct_id(product.getProduct_id());
				 pImageDAO.insert(pImage);
				 
				 String addonFilename = pImage.getP_image_id()+"."+pImage.getFilename();
				 fileManager.saveFile(addonDir+File.separator+addonFilename, file);
			 }
		 }
	}

	@Override
	public void update(Product product, FileManager fileManager) throws ProductStatusChangedException {
		productDAO.update(product);
		String basicDir = fileManager.getSaveBasicDir();
		String addonDir = fileManager.getSaveAddonDir();
		String repImgExt = "";
		
		//대표이미지 처리
		if(product.getRepImg() != null) {
			 MultipartFile repImg =  product.getRepImg();
			 repImgExt = fileManager.getExtend(repImg.getOriginalFilename());
			 product.setFilename(repImgExt); //확장자명을 filename, 파일명은 product_id
			 
			 productDAO.update(product);
			 
			 String basicfilename = product.getProduct_id()+"."+repImgExt;
			 fileManager.saveFile(basicDir+File.separator+basicfilename, repImg);
			 System.out.println("ㅋㅋ놀랐지? 내가발동함");
		}else {
			productDAO.update(product);
			System.out.println(product.getFilename());
		}
		
		//p_image처리
		
		if(product.getP_image() != null) {
			MultipartFile[] p_image = product.getP_image();
			for(MultipartFile file : p_image) {
				String addImgExt = fileManager.getExtend(file.getOriginalFilename());
				PImage pImage = new PImage();
				pImage.setFilename(addImgExt);
				pImage.setProduct_id(product.getProduct_id());
				pImageDAO.insert(pImage);
				
				String addonFilename = pImage.getP_image_id()+"."+addImgExt;
				fileManager.saveFile(addonDir+File.separator+addonFilename, file);
			}
		}
	}

	@Override
	public void delete(int product_id) throws ProductStatusChangedException {
		productDAO.delete(product_id);
	}
	
	

}
