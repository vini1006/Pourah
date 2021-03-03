package com.viniv.pourah.controller.liquor.pay;

import java.net.http.HttpRequest;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.viniv.pourah.exception.NullListException;
import com.viniv.pourah.model.annotation.NoLogging;
import com.viniv.pourah.model.domain.Cart;
import com.viniv.pourah.model.domain.Member;
import com.viniv.pourah.model.domain.MessageData;
import com.viniv.pourah.model.domain.Order_summary;
import com.viniv.pourah.model.domain.Receiver;
import com.viniv.pourah.model.member.service.ReceiverService;
import com.viniv.pourah.model.pay.service.CartService;
import com.viniv.pourah.model.pay.service.Order_summaryService;
import com.viniv.pourah.model.pay.service.PaymethodService;
import com.viniv.pourah.model.product.service.ProductService;

@Controller
public class PayController {
	
	@Autowired
	private ReceiverService receiverService;
	
	@Autowired
	private CartService cartService;
	
	@Autowired
	private PaymethodService paymethodService;
	
	@Autowired
	private Order_summaryService order_summaryService;
	
	private static final Logger logger = LoggerFactory.getLogger(PayController.class);
			
	//카트리스트 보기
	@RequestMapping("/pourah/pay/cart_list")
	public ModelAndView getCartList(HttpServletRequest request) {
		//멤버아이디 뽑아서 배송지리스트 만들고, 카트리스트 > 프로덕트 리스트도 줘야함
		//페이메소드
		ModelAndView mav = new ModelAndView();
		
		
		//배송지리스트뽑기
		HttpSession session =  request.getSession();
		Member member = (Member) session.getAttribute("member");
		int member_id = member.getMember_id();
		List<Receiver> receiverList = receiverService.selectAllByMemberId(member_id);
		//!배송지리스트뽑기
		
		//카트뽑아서 넘기기 (product안에 담겨있음) //null 일경우 exception
		List cartList = cartService.selectByMemberId(member_id);
		
		//페이메소드 넘겨주기
		List paymethodList = paymethodService.selectAll();
		
		
		mav.addObject("paymethodList",paymethodList);
		mav.addObject("cartList",cartList);
		mav.addObject("receiverList",receiverList);
		mav.setViewName("liquor/pay/member_cart");
		
		return mav;
	}
	
	
	
	//결제관련 ------------
	@RequestMapping("/pourah/pay/order_list")
	public ModelAndView getOrder_list(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		
		//멤버아이디 뺴오기
		HttpSession session = request.getSession();
		Member member = (Member) session.getAttribute("member");
		int member_id = member.getMember_id();
		
		//멤버아이디로 주문조회 컬렉션으로 오더섬머리, 디테일, 프로덕트 다가지고있음
		List orderList = order_summaryService.selectByMemberId(member_id);
		mav.addObject("orderList", orderList);
		
		
		mav.setViewName("liquor/pay/order_list");
		return mav; 
	}
	
	@NoLogging
	@ExceptionHandler(NullListException.class)
	@ResponseBody
	public ModelAndView handleException(NullListException e) {
		ModelAndView mav = new ModelAndView("liquor/message/messageShow");
		MessageData messageData = new MessageData();
		
		messageData.setMsg(e.getMessage());
		messageData.setResultCode(0);
		messageData.setUrl("/pourah/product/list");
		
		mav.addObject(messageData);
			
		
		return mav;
	}
	
	
	
	
	

}
