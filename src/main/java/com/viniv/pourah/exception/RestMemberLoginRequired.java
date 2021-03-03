package com.viniv.pourah.exception;

public class RestMemberLoginRequired extends RuntimeException {
	
	public RestMemberLoginRequired(String msg) {
		super(msg);
	}
	
	public RestMemberLoginRequired(String msg, Throwable e) {
		super(msg, e);
	}

}
