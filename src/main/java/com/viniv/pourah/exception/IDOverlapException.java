package com.viniv.pourah.exception;

public class IDOverlapException extends RuntimeException {
	
	public IDOverlapException(String msg) {
		super(msg);
	}
	
	public IDOverlapException(String msg, Throwable e) {
		super(msg, e);
	}

}
