package com.viniv.pourah.admin.aop;

import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.servlet.ModelAndView;

import com.viniv.pourah.exception.AdminLoginRequired;
import com.viniv.pourah.exception.MemberLoginRequired;
import com.viniv.pourah.model.domain.MessageContainer;
import com.viniv.pourah.model.domain.MessageData;

@ControllerAdvice
public class RestMemberLoginExceptionHander {
	
	@ExceptionHandler(MemberLoginRequired.class)
	public MessageData handleException(MemberLoginRequired e) {
		
		MessageData messageData = new MessageData();
		messageData.setResultCode(0);
		messageData.setMsg(e.getMessage());
		messageData.setUrl("/pourah/member/login_form");
		
		return messageData;
	}

}
