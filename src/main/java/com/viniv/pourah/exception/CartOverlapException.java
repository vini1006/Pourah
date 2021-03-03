package com.viniv.pourah.exception;

public class CartOverlapException extends RuntimeException{
	
	public CartOverlapException(String msg) {
		super(msg);
	}
	
	public CartOverlapException(String msg, Throwable e) {
		super(msg, e);
	}
}
