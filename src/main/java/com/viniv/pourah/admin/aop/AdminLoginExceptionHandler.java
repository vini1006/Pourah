package com.viniv.pourah.admin.aop;

import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.servlet.ModelAndView;

import com.viniv.pourah.exception.AdminLoginRequired;
import com.viniv.pourah.model.domain.MessageData;

@ControllerAdvice
public class AdminLoginExceptionHandler {
	
	@ExceptionHandler(AdminLoginRequired.class)
	public ModelAndView handleException(AdminLoginRequired e) {
		ModelAndView mav = new ModelAndView("admin/error/errorPage");
		
		MessageData messageData = new MessageData();
		messageData.setResultCode(0);
		messageData.setMsg(e.getMessage());
		messageData.setUrl("/admin/login_form");
		mav.addObject("messageData", messageData);
		
		return mav;
	}

}
