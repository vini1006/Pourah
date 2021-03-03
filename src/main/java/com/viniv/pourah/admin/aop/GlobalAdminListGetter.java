package com.viniv.pourah.admin.aop;

import java.util.List;

import org.aopalliance.intercept.Joinpoint;
import org.aspectj.lang.ProceedingJoinPoint;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.servlet.ModelAndView;

import com.viniv.pourah.model.member.service.AdminServiceImpl;


public class GlobalAdminListGetter   {
	
		@Autowired
		private AdminServiceImpl adminServiceImpl;  
		
		public Object globalAdminList(ProceedingJoinPoint joinPoint) throws Throwable {
			Object result = null;
			List adminList = adminServiceImpl.selectAll();
			
				
			Object returnObj = joinPoint.proceed();
			ModelAndView mav = null;
			if(returnObj instanceof ModelAndView) {
				mav = (ModelAndView)returnObj;
				mav.addObject("adminList", adminList);
				result = mav;
			}
		
			return result;
		
		}
}
