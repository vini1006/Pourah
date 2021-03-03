package com.viniv.pourah.controller.liquor.member;

import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.viniv.pourah.model.annotation.NoLogging;
import com.viniv.pourah.model.domain.Member;
import com.viniv.pourah.model.domain.MessageData;
import com.viniv.pourah.model.member.service.MemberService;

@Controller
public class MemberContrller {
	
	@Autowired
	private MemberService memberService; 
	
	//로그인 폼 요청
	@NoLogging
	@RequestMapping("/pourah/member/login_form")
	public String memberLoginForm() {
		
		return"liquor/member/login_signup";
	}
	
	
	@RequestMapping("/pourah/member/logout")
	public ModelAndView memberLogOut(HttpServletRequest request) {
		
		ModelAndView mav = new ModelAndView();
		HttpSession session = request.getSession();
		session.invalidate();
		
		MessageData messageData = new MessageData();
		messageData.setMsg("로그아웃 되었습니다 ~");
		messageData.setUrl("/pourah");
		
		mav.addObject("messageData",messageData);
		mav.setViewName("liquor/message/messageShow");
		
		return mav;
	}
	
	
	@RequestMapping("/pourah/member/account")
	public ModelAndView account(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView("liquor/member/account");  
				
		return mav;
	}
}
