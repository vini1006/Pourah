package com.viniv.pourah.exception;

public class ProductStatusChangedException extends RuntimeException {
	
	public ProductStatusChangedException(String msg) {
		super(msg);
	}
	
	public ProductStatusChangedException(String msg, Throwable e) {
		super(msg, e);
	}

}
