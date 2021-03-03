package com.viniv.pourah.exception;

public class CountZeroException extends RuntimeException{
	
	public CountZeroException(String msg) {
		super(msg);
	}
	
	public CountZeroException(String msg, Throwable e) {
		super(msg, e);
	}


}
