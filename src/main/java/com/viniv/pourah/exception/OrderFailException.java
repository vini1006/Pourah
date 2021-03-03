package com.viniv.pourah.exception;

public class OrderFailException extends RuntimeException {
	
	public OrderFailException(String msg) {
		super(msg);
	}
	
	public OrderFailException(String msg, Throwable e) {
		super(msg, e);
	}

}
