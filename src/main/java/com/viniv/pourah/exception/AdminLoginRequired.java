package com.viniv.pourah.exception;

public class AdminLoginRequired extends RuntimeException{
	
	public AdminLoginRequired(String msg) {
		super(msg);
	}
	
	public AdminLoginRequired(String msg, Throwable e) {
		super(msg, e);
	}

}
