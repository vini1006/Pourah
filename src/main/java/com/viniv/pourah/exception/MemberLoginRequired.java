package com.viniv.pourah.exception;

public class MemberLoginRequired extends RuntimeException {
	
	public MemberLoginRequired(String msg) {
		super(msg);
	}
	
	public MemberLoginRequired(String msg, Throwable e) {
		super(msg, e);
	}

}
