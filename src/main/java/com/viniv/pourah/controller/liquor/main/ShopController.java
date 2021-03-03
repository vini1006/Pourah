package com.viniv.pourah.controller.liquor.main;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.viniv.pourah.model.product.service.AtopcategoryService;
import com.viniv.pourah.model.product.service.ProductService;

@Controller
public class ShopController {
	
	@Autowired
	AtopcategoryService atopcategoryService;
	
	@Autowired
	ProductService productService;
	
	
	@RequestMapping("/pourah")
	public ModelAndView index() {
		ModelAndView mav = new ModelAndView("liquor/main/index");
		
		/*AOP로 대체할 예정 topList*/
		//atopList
		List atopList = atopcategoryService.selectEverything();
		
		//메인페이지에 상품띄우기
		List productList = productService.selectAll();
		
		mav.addObject("atopList", atopList);
		mav.addObject("productList", productList);
		
		return mav;
	}
	

}
