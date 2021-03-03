package com.viniv.pourah.exception;

public class AdminWrongLogginException extends RuntimeException{
	
	public AdminWrongLogginException(String msg) {
		super(msg);
	}
	
	public AdminWrongLogginException(String msg, Throwable e) {
		super(msg, e);
	}
	

}
