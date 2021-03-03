package com.viniv.pourah.exception;

public class NullListException extends RuntimeException {
	
	public NullListException(String msg) {
		super(msg);
	}
	
	public NullListException(String msg, Throwable e) {
		super(msg, e);
	}


}
