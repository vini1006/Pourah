package com.viniv.pourah.controller.liquor.product;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.viniv.pourah.model.common.ProductPager;
import com.viniv.pourah.model.domain.Product;
import com.viniv.pourah.model.domain.Review;
import com.viniv.pourah.model.product.service.AtopcategoryService;
import com.viniv.pourah.model.product.service.PImageService;
import com.viniv.pourah.model.product.service.ProductServiceImpl;
import com.viniv.pourah.model.product.service.ReviewService;

@Controller
public class ShopProductController {
	
	private static final Logger logger = LoggerFactory.getLogger(ShopProductController.class);
	
	@Autowired
	private ProductServiceImpl productServiceImpl;
	
	@Autowired
	private AtopcategoryService atopcategoryService;
	
	@Autowired
	private PImageService pImageService;
	
	@Autowired
	private ReviewService reviewService;
	
	@Autowired
	private ProductPager productPager;
	
	
	//상품 리스트
	@RequestMapping(value="/pourah/product/list")
	public ModelAndView getProductList(HttpServletRequest request, Integer currentPage, Integer a_subcategory_id) {
		ModelAndView mav = new ModelAndView("liquor/product/list");
		
		/*AOP로 대체할 예정 topList 사이드바용*/
		//atopList
		List atopList = atopcategoryService.selectEverything();
		mav.addObject("atopList", atopList);
		//-------------------------------------------
		List productList = null;
		
		
		if(a_subcategory_id == null) {
			productList =  productServiceImpl.selectAll();
		}else {
			productList = productServiceImpl.selectByASubId(a_subcategory_id);
		}
		
		if(currentPage != null) {
			mav.addObject("currentPage",currentPage);
		}
		
		productPager.setCurrentPage(1);
		productPager.init(request, productList);
		
		mav.addObject("productList",productList);
		mav.addObject("pager", productPager);
		
		return mav;
	}
	
	//상품상세보기
	@GetMapping("/pourah/product/detail")
	public ModelAndView getProductDetail(Integer product_id) {
		ModelAndView mav = new ModelAndView("liquor/product/detail");
		
		/*AOP로 대체할 예정 topList 사이드바용*/
		//atopList
		List atopList = atopcategoryService.selectEverything();
		mav.addObject("atopList", atopList);
		//-------------------------------------------
		//리뷰 목록 가져오기
		
		List<Review> reviewList = reviewService.getReviewListByProductId(product_id);
		
		//별점용 리뷰 가져오기
		
		
		//--------------------------------------------
		List pImageList = pImageService.selectByProductId(product_id);
		Product product = productServiceImpl.selectById(product_id);
		
		mav.addObject("reviewList", reviewList);
		mav.addObject("product", product);
		mav.addObject("pImageList", pImageList);
		
		return mav;
	}
	

}
