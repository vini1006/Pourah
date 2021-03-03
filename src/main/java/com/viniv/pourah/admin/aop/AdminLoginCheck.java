package com.viniv.pourah.admin.aop;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.aspectj.lang.ProceedingJoinPoint;

import com.viniv.pourah.exception.AdminLoginRequired;

public class AdminLoginCheck {
	
	public Object adminLoggingCheck(ProceedingJoinPoint joinPoint) throws Throwable {
		
		Object target = joinPoint.getTarget(); //원래 호출하려고했덛클래스놈
		String methodName = joinPoint.getSignature().getName(); //원래 호출하려던 메서드
		Object[] args = joinPoint.getArgs(); //원래 호출하려던 메서드의 매개변수
				
		//이제세션찾으러 가보자
		HttpServletRequest request = null;
		
		for(Object arg : args) {
			if(arg instanceof HttpServletRequest) {
				request = (HttpServletRequest)arg;
			}
		}
		
		HttpSession session = null;
		session = request.getSession();
		Object result = null;
		
		//로그인 세션있고 없고로 나누자 없으면 exceptionHandler발동
		if(session.getAttribute("admin") == null) {
			throw new AdminLoginRequired("관리자 로그인이 필요합니다.");
		}else {
			//원래대로 가자잉
			result = joinPoint.proceed();
		}
		
		return result;
	}
	

}
