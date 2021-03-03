package com.viniv.pourah.model.domain;

import org.springframework.web.servlet.ModelAndView;

import lombok.Data;

@Data
public class MessageContainer {
	
	ModelAndView mav;
	MessageData messageData;

}
