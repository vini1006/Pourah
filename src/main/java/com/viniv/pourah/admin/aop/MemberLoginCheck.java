package com.viniv.pourah.admin.aop;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.aspectj.lang.ProceedingJoinPoint;

import com.viniv.pourah.exception.MemberLoginRequired;

public class MemberLoginCheck {
	
	public Object memberLoggingCheck(ProceedingJoinPoint joinPoint) throws Throwable {
			
		/*
			Object target = joinPoint.getTarget(); //원래 호출하려고했덛클래스놈
			String methodName = joinPoint.getSignature().getName(); //원래 호출하려던 메서드
			*/
			Object[] args = joinPoint.getArgs(); //원래 호출하려던 메서드의 매개변수
					
			HttpServletRequest request = null;
			
			for(Object arg : args) {
				if(arg instanceof HttpServletRequest) {
					request = (HttpServletRequest)arg;
				}
			}
			
			HttpSession session = null;
			session = request.getSession();
			Object result = null;
			
			if(session.getAttribute("member") == null) {
				throw new MemberLoginRequired("로그인 후 진행 가능합니다^^ 로그인 페이지로 이동합니다.");
			}else {
				result = joinPoint.proceed();
			}
			
			return result;
		}

}
