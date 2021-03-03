package com.viniv.pourah.controller.admin.main;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.viniv.pourah.model.domain.Member;
import com.viniv.pourah.model.domain.News;
import com.viniv.pourah.model.domain.Order_summary;
import com.viniv.pourah.model.member.service.MemberService;
import com.viniv.pourah.model.news.service.NewsService;
import com.viniv.pourah.model.pay.service.Order_summaryService;

@Controller
public class AdminController {
	
	@Autowired
	private NewsService newsService;
	
	@Autowired
	private MemberService memberService;
	
	@Autowired
	private Order_summaryService order_summaryService;

	
	//메인페이지 들어가기
	@RequestMapping("/admin/main")
	public ModelAndView index(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView("admin/main/index");
		
		List<News> newsList = newsService.selectAll();
		List<Member> memberList = memberService.selectAll();
		List<Order_summary> orderList = order_summaryService.selectAll();
 		mav.addObject("newsList1",newsList);
		mav.addObject("memberList", memberList);
		mav.addObject("orderList",orderList);
		return mav;
	}
	
}
