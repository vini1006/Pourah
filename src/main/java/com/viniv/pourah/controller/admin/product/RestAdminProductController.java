package com.viniv.pourah.controller.admin.product;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.viniv.pourah.exception.ProductStatusChangedException;
import com.viniv.pourah.model.annotation.NoAdminList;
import com.viniv.pourah.model.common.Pager;
import com.viniv.pourah.model.domain.Asubcategory;
import com.viniv.pourah.model.domain.Atopcategory;
import com.viniv.pourah.model.domain.MessageData;
import com.viniv.pourah.model.product.service.AsubcategoryService;
import com.viniv.pourah.model.product.service.AtopcategoryService;
import com.viniv.pourah.model.product.service.PImageService;
import com.viniv.pourah.model.product.service.ProductService;

@Controller
@RequestMapping("/async/product")
public class RestAdminProductController {
	
	@Autowired
	private AsubcategoryService asubcategoryService;
	
	@Autowired
	private AtopcategoryService atopcategoryService;
	
	@Autowired
	private ProductService productService;
	
	@Autowired
	private PImageService pImageService;
	
	@Autowired
	private Pager pager;
	
	
	@NoAdminList
	@RequestMapping(value="/Asublist", method=RequestMethod.GET)
	@ResponseBody
	public List getSubList(int a_topcategory_id,HttpServletRequest reuqest) {
		 
		List<Asubcategory> subList = asubcategoryService.selectByAtopId(a_topcategory_id);
				
		return subList;
	}
	
	@NoAdminList
	@RequestMapping(value="/categoryRegist", 
    method=RequestMethod.POST, 
    produces="application/text;charset=utf-8")
	@ResponseBody
	public String categoryRegist(Integer a_topcategory_id, String name, HttpServletRequest reuqest) {
		
		if(a_topcategory_id == null) {
			Atopcategory atopcategory = new Atopcategory();
			atopcategory.setName(name);
			atopcategoryService.insertMaxRank(atopcategory);
		}else {
			Asubcategory asubcategory = new Asubcategory();
			asubcategory.setA_topcategory_id(a_topcategory_id);
			asubcategory.setName(name);
			asubcategoryService.insertMaxRank(asubcategory);
		}
		
		return "등록완료 !!";
	}
	
	//product 선택 삭제
	@NoAdminList
	@PostMapping("/deleteProduct")
	@ResponseBody
	public String deleteProduct(int[] product_idArr, HttpServletRequest reuqest) {
		
		for(int product_id : product_idArr) {
			productService.delete(product_id);
		}
		
		//파일삭제도 추가해야함
		
		return "location.reload()";
	}
	
	//pImage 삭제
	@NoAdminList
	@GetMapping("/deletePImage")
	@ResponseBody
	public String deletePImage(int p_image_id, HttpServletRequest reuqest) {
		
		pImageService.delete(p_image_id);
		
		return "삭제 완료";
	}
	
	
	@ExceptionHandler(ProductStatusChangedException.class)
	@ResponseBody
	public MessageData hadnleException(ProductStatusChangedException e) {
		MessageData messageData = new MessageData();
		
		messageData.setMsg("상품 관리중 에러가 발생하였습니다.");
		messageData.setUrl("/admin/main");
		messageData.setResultCode(3);
		
		return messageData;
	}

}
