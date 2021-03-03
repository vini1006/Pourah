package com.viniv.pourah.controller.admin.member;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.viniv.pourah.exception.IDOverlapException;
import com.viniv.pourah.exception.MemberStatusChangeException;
import com.viniv.pourah.exception.ProductStatusChangedException;
import com.viniv.pourah.exception.AdminWrongLogginException;
import com.viniv.pourah.model.annotation.NoAdminList;
import com.viniv.pourah.model.annotation.NoLogging;
import com.viniv.pourah.model.common.SecureManager;
import com.viniv.pourah.model.domain.Admin;
import com.viniv.pourah.model.domain.MessageData;
import com.viniv.pourah.model.member.service.AdminService;


/*

  ___       _             _        ___  ___                  _                  _____                _                 _  _             
 / _ \     | |           (_)       |  \/  |                 | |                /  __ \              | |               | || |            
/ /_\ \  __| | _ __ ___   _  _ __  | .  . |  ___  _ __ ___  | |__    ___  _ __ | /  \/  ___   _ __  | |_  _ __   ___  | || |  ___  _ __ 
|  _  | / _` || '_ ` _ \ | || '_ \ | |\/| | / _ \| '_ ` _ \ | '_ \  / _ \| '__|| |     / _ \ | '_ \ | __|| '__| / _ \ | || | / _ \| '__|
| | | || (_| || | | | | || || | | || |  | ||  __/| | | | | || |_) ||  __/| |   | \__/\| (_) || | | || |_ | |   | (_) || || ||  __/| |   
\_| |_/ \__,_||_| |_| |_||_||_| |_|\_|  |_/ \___||_| |_| |_||_.__/  \___||_|    \____/ \___/ |_| |_| \__||_|    \___/ |_||_| \___||_|   
                                                                                                                                        
                                                                                                                                        

                                                                                            
*/
 


@Controller
public class AdminMemberController {
	
	@Autowired
	private AdminService adminService;
	
	
	@NoLogging
	@RequestMapping("/admin/login_form")
	public String getLoginForm() {
		
		return "admin/login/login";
	}
	
	//어드민 신규추가 폼
	
	@NoLogging
	@RequestMapping("/admin/admin_registForm")
	public ModelAndView getAdminRegisterForm() {
		ModelAndView mav = new ModelAndView("admin/login/admin_regist");
		
		return mav;
	}
	
	//어드민 등록
	@NoLogging
	@RequestMapping("/admin/admin_regist")
	public ModelAndView registAdmin(Admin admin) {
		ModelAndView mav = new ModelAndView("redirect:/admin/login_form");
		
		adminService.registAdmin(admin);
		
		return mav;
		
	}
	
	
	//로그인 //async방식으로 대체됨
	@NoLogging
	@RequestMapping(value="/deprecated", method=RequestMethod.POST)
	public ModelAndView login(Admin admin, HttpServletRequest request) {
		ModelAndView mav = new ModelAndView("admin/main/index");
		
		HttpSession session =  request.getSession();
		session.setAttribute("admin", admin);
		
		return mav;
	}
	
	@NoAdminList
	@RequestMapping("/admin/logOut")
	public String logOut(HttpServletRequest request) {
		HttpSession session = request.getSession();
		session.invalidate();
		

		return "redirect:/admin/login_form";
	}
	
	
	@NoLogging
	@ExceptionHandler(IDOverlapException.class)
	@ResponseBody
	public MessageData handleException(IDOverlapException e) {
		MessageData messageData = new MessageData();
		
		messageData.setResultCode(0);
		messageData.setMsg(e.getMessage());
		
		return messageData;
	}
	
	@NoLogging
	@ExceptionHandler(AdminWrongLogginException.class)
	public MessageData handleException(AdminWrongLogginException e) {
		MessageData messageData = new MessageData();
		
		messageData.setResultCode(0);
		messageData.setMsg(e.getMessage());
		
		return messageData;
	}
	
	@ExceptionHandler(MemberStatusChangeException.class)
	public ModelAndView hadnleException(MemberStatusChangeException e) {
		ModelAndView mav = new ModelAndView("admin/error/errorPage");
		MessageData messageData = new MessageData();
		
		messageData.setMsg("계정 관리중 에러가 발생하였습니다.");
		messageData.setUrl("/admin/main");
		messageData.setResultCode(3);
		
		return mav;
	}

}
