package com.viniv.pourah.controller.admin.product;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.context.ServletContextAware;
import org.springframework.web.servlet.ModelAndView;

import com.viniv.pourah.exception.ProductStatusChangedException;
import com.viniv.pourah.model.annotation.NoAdminList;
import com.viniv.pourah.model.annotation.NoLogging;
import com.viniv.pourah.model.common.FileManager;
import com.viniv.pourah.model.common.Pager;
import com.viniv.pourah.model.domain.Asubcategory;
import com.viniv.pourah.model.domain.MessageData;
import com.viniv.pourah.model.domain.PImage;
import com.viniv.pourah.model.domain.Product;
import com.viniv.pourah.model.product.service.AsubcategoryService;
import com.viniv.pourah.model.product.service.AtopcategoryService;
import com.viniv.pourah.model.product.service.PImageService;
import com.viniv.pourah.model.product.service.ProductService;

@Controller
public class AdminProductController implements ServletContextAware {
	
	@Autowired
	private AtopcategoryService atopcategoryService;
	
	@Autowired
	private AsubcategoryService asubcategoryService;
	
	@Autowired
	private ProductService productService;
	
	@Autowired
	private PImageService pImageService;
	
	@Autowired
	private Pager pager;
	
	//서블릿 콘텍스트 getRealPath() 사용하려고!!!
	private ServletContext servletContext;
	
	
	@Autowired
	private FileManager fileManager;
	
	@NoLogging
	public void setServletContext(ServletContext servletContext) {
		this.servletContext = servletContext;
		//이 타이밍을 놓치지말고, 실제 물리적 경로를 FileManager 에 대입해놓자!!!
		fileManager.setSaveBasicDir(servletContext.getRealPath(fileManager.getSaveBasicDir()));
		fileManager.setSaveAddonDir(servletContext.getRealPath(fileManager.getSaveAddonDir()));
	}
	
	//등록폼 요청
	@RequestMapping("/admin/product/regist_form")
	public ModelAndView getRegistForm(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView("admin/product/product_regist");
		List atopList =  atopcategoryService.selectAll();
		
		mav.addObject("atopList", atopList);
		
		return mav;
	}
		
	
	//상세 폼 및 수정 폼 요청
	@RequestMapping("/admin/product/detail_form")
	public ModelAndView getEditForm(Integer product_id, HttpServletRequest request) {
		ModelAndView mav = new ModelAndView("admin/product/product_detail");
		List atopList =  atopcategoryService.selectAll();
		Product product = productService.selectById(product_id); //asup 담아져있고, asub안에 atop담겨져있음 (마이바티스 어쏘시에이션 이용)
		List<PImage> pImageList = pImageService.selectByProductId(product_id);
		
		
		mav.addObject("atopList", atopList);
		mav.addObject("product",product);
		mav.addObject("pImageList",pImageList);
		
		return mav;
	}
	 
	//목록
	@RequestMapping("/admin/product/list")
	public ModelAndView getProductList(HttpServletRequest request, Integer currentPage) {
		ModelAndView mav = new ModelAndView("admin/product/product_list");
		List atopList =  atopcategoryService.selectAll();
		List productList = productService.selectAll();
		if(currentPage != null) {
			pager.setCurrentPage(currentPage);
		}
		pager.init(request, productList);
		mav.addObject("productList", productList);
		mav.addObject("atopList", atopList);
		mav.addObject("pager", pager);
		
		return mav;
	}
	
	//등록
	@NoAdminList
	@RequestMapping(value="/admin/product/regist", method=RequestMethod.POST)
	public String registProduct(Product product, HttpServletRequest request) {
		productService.regist(product, fileManager);
		
		return "redirect:/admin/product/list";
	}
	
	
	//수정
	@RequestMapping("/admin/product/edit")
	public ModelAndView editProduct(Product product, HttpServletRequest request) {
		ModelAndView mav = new  ModelAndView("redirect:/admin/product/list");
		
		productService.update(product, fileManager);
		
		return mav;
	}
	
	
	
	/*----------------------목록조회 검색관련------------------------------*/
	@RequestMapping("/admin/product/top_filter")
	public ModelAndView listFilterByTop(HttpServletRequest request,
			Integer a_topcategory_id,
			Integer a_subcategory_id,
			String topCategory_name,
			String subCategory_name
			) {
		ModelAndView mav = new ModelAndView("admin/product/product_list");
		List atopList =  atopcategoryService.selectAll();
		List<Asubcategory> asubList = asubcategoryService.selectByAtopId(a_topcategory_id);
		List<Product> productList = new ArrayList<Product>();
		
		for(Asubcategory asubcategory : asubList) {
			for(Product product : asubcategory.getProductList()) {
				productList.add(product);
			}
		}
		pager.init(request, productList);
		
		mav.addObject("a_topcategory_id", a_topcategory_id);
		mav.addObject("atopList", atopList);
		mav.addObject("asubList", asubList);
		mav.addObject("productList", productList);
		mav.addObject("pager", pager);
		mav.addObject("a_topcategory_id", a_topcategory_id);
		mav.addObject("a_subcategory_id", a_subcategory_id);
		mav.addObject("topCategory_name", topCategory_name);
		subCategory_name = "하위 카테고리";
		mav.addObject("subCategory_name", subCategory_name);
		return mav;
	}
	
	@RequestMapping("/admin/product/sub_filter")
	public ModelAndView listFilterBySub(HttpServletRequest request,
			Integer a_topcategory_id,
			Integer a_subcategory_id,
			String topCategory_name,
			String subCategory_name
			) {
		ModelAndView mav = new ModelAndView("admin/product/product_list");
		List atopList =  atopcategoryService.selectAll();
		List<Asubcategory> asubList = asubcategoryService.selectByAtopId(a_topcategory_id);
		List productList = productService.selectByASubId(a_subcategory_id);
		
		
		pager.init(request, productList);
		mav.addObject("pager", pager);
		mav.addObject("atopList", atopList);
		mav.addObject("asubList", asubList);
		mav.addObject("productList", productList);
		mav.addObject("a_topcategory_id", a_topcategory_id);
		mav.addObject("a_subcategory_id", a_subcategory_id);
		mav.addObject("topCategory_name", topCategory_name);
		mav.addObject("subCategory_name", subCategory_name);
		
		return mav;
	}
	
	@ExceptionHandler(ProductStatusChangedException.class)
	public ModelAndView hadnleException(ProductStatusChangedException e) {
		ModelAndView mav = new ModelAndView("admin/error/errorPage");
		MessageData messageData = new MessageData();
		
		messageData.setMsg("상품 관리중 에러가 발생하였습니다.");
		messageData.setUrl("/admin/main");
		messageData.setResultCode(3);
		
		return mav;
	}
}
