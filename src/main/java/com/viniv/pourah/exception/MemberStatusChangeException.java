package com.viniv.pourah.exception;

public class MemberStatusChangeException extends RuntimeException{
	
	public MemberStatusChangeException(String msg) {
		super(msg);
	}
	
	public MemberStatusChangeException(String msg, Throwable e) {
		super(msg, e);
	}

}
