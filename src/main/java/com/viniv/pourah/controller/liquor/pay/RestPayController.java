package com.viniv.pourah.controller.liquor.pay;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.viniv.pourah.admin.aop.MemberLoginExceptionHander;
import com.viniv.pourah.exception.CountZeroException;
import com.viniv.pourah.exception.CartOverlapException;
import com.viniv.pourah.exception.MemberLoginRequired;
import com.viniv.pourah.exception.NullListException;
import com.viniv.pourah.exception.OrderFailException;
import com.viniv.pourah.model.annotation.NoLogging;
import com.viniv.pourah.model.domain.Cart;
import com.viniv.pourah.model.domain.Member;
import com.viniv.pourah.model.domain.MessageData;
import com.viniv.pourah.model.domain.Order_detail;
import com.viniv.pourah.model.domain.Order_summary;
import com.viniv.pourah.model.pay.service.CartService;
import com.viniv.pourah.model.pay.service.OrderService;
import com.viniv.pourah.model.pay.service.Order_detailService;
import com.viniv.pourah.model.pay.service.Order_summaryService;

@Controller()
@RequestMapping("/async/pourah/pay")
public class RestPayController {
	private static final Logger logger = LoggerFactory.getLogger(RestPayController.class);
	
	@Autowired
	private CartService cartService;
	
	@Autowired
	private Order_summaryService order_summaryService;
	
	@Autowired
	private Order_detailService order_detailService;
	
	//트랜잭션 묶음용
	@Autowired 
	private OrderService orderService;
	
	
	@RequestMapping("/registCart")
	@ResponseBody
	public MessageData registCart(Cart cart, HttpServletRequest request) {
		MessageData messageData = new MessageData();
		logger.debug("카트확인 : "+cart);
		if(cart.getCart_id() == -1) {
			throw new MemberLoginRequired("로그인이 필요합니다 ^^");
		}else if(cart.getQuantity() == 0 ) {
			throw new CountZeroException("한개 이상 담겨야 합니다^^");
		}
		
		cartService.registCart(cart);
		
		logger.debug("카트내부의 프로덕트 확인 : "+cart.getProduct());
		
		
		
		messageData.setMsg("장바구니 등록 성공했습니다 ^^");
		messageData.setResultCode(1);
		messageData.setUrl("/pourah/pay/cart_list");
		
		return messageData;
	}
	
	@RequestMapping("/quantity_change")
	@ResponseBody
	public MessageData changeQuantity(int cart_id, String method, HttpServletRequest request) {
		cartService.changeQuantity(cart_id, method);
		
		MessageData messageData = new MessageData();
		messageData.setResultCode(1);
		return messageData;
	}
	
	@RequestMapping("/deleteAcart")
	@ResponseBody
	public MessageData deleteACart(int cart_id, HttpServletRequest request){
		MessageData messageData = new MessageData();
		cartService.deleteByCartId(cart_id);
		
		messageData.setMsg("카트 목록에서 삭제하였습니다.");
		messageData.setResultCode(1);
		
		return messageData;
	}
	
	//주문------------------------------------------------------------------
	
	@RequestMapping("/registOrder")
	@ResponseBody
	public MessageData registOrder(HttpServletRequest request,
			Order_summary order_summary,
			Integer[] product_id,
			Integer[] ori_price,
			Integer[] quantity) {
		
		Member member = (Member) request.getSession().getAttribute("member");
		int member_id = member.getMember_id();
		List<Order_detail> order_detail_list = new ArrayList<Order_detail>();
		
		//오더디테일 심기
		for(int i=0; i<product_id.length; i++) {
			Order_detail order_detail = new Order_detail();
			order_detail.setOrder_summary_id(order_summary.getOrder_summary_id());
			order_detail.setProduct_id(product_id[i]);
			order_detail.setQuantity(quantity[i]);
			order_detail.setOri_price(ori_price[i]);
			//리스트에담아서 트랜잭션은 서비스에서하자
			order_detail_list.add(order_detail);
		}
		
		orderService.registOrder(order_summary, order_detail_list, member_id);
		
		MessageData messageData = new MessageData();
		messageData.setMsg("주문 결제에 성공하였습니다. 주문 확인하러 가볼까요?");
		messageData.setResultCode(1);
		messageData.setUrl("/pourah/pay/order_list");
		
		return messageData;
	}
	
	
	/*
	 * 익셉션 핸들러 -------------------------------------------------------
	 */
	
	@NoLogging
	@ExceptionHandler(OrderFailException.class)
	@ResponseBody
	public MessageData handleException(OrderFailException e) {
		MessageData messageData = new MessageData();
		messageData.setMsg(e.getMessage());
		messageData.setResultCode(0);
		
		return messageData;
	}
	
	@NoLogging
	@ExceptionHandler(CountZeroException.class)
	@ResponseBody
	public MessageData handleException(CountZeroException e) {
		MessageData messageData = new MessageData();
		messageData.setMsg(e.getMessage());
		messageData.setResultCode(0);
		
		return messageData;
	}
	
	@NoLogging
	@ExceptionHandler(CartOverlapException.class)
	@ResponseBody
	public MessageData handleException(CartOverlapException e) {
		MessageData messageData = new MessageData();
		messageData.setMsg(e.getMessage());
		messageData.setResultCode(0);
		
		return messageData;
	}
	
	
	
}
