package com.viniv.pourah.exception;

public class MemberWrongLogginException extends RuntimeException{
	
	public MemberWrongLogginException(String msg) {
		super(msg);
	}
	
	public MemberWrongLogginException(String msg, Throwable e) {
		super(msg, e);
	}
	

}
