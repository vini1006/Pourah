package com.viniv.pourah.controller.liquor.member;

import java.sql.DatabaseMetaData;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Repository;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.viniv.pourah.exception.IDOverlapException;
import com.viniv.pourah.exception.MemberWrongLogginException;
import com.viniv.pourah.model.annotation.NoLogging;
import com.viniv.pourah.model.domain.Member;
import com.viniv.pourah.model.domain.MessageData;
import com.viniv.pourah.model.domain.Receiver;
import com.viniv.pourah.model.member.service.MemberServiceImpl;
import com.viniv.pourah.model.member.service.ReceiverService;
import com.viniv.pourah.model.member.service.MemberService;

@Controller()
@RequestMapping("/async/pourah")
public class RestMemberController {
	
	Logger logger = LoggerFactory.getLogger(RestMemberController.class);
	
	@Autowired
	private MemberService memberService;
	
	@Autowired
	private ReceiverService receiverService;
	
	
	@NoLogging
	@RequestMapping("/overlapCheck")
	@ResponseBody
	public MessageData checkClientIDOverlap(String user_id) {
		MessageData messageData = new MessageData();
		memberService.overlapCheck(user_id);
		//익셉션 안맞났다면...
		 
		messageData.setMsg("사용 가능한 아이디 입니다.");
		messageData.setResultCode(1);
		
		return messageData;
	}
	
	@NoLogging
	@RequestMapping("/memberRegist")
	@ResponseBody
	public MessageData registMember(Member member) {
		MessageData messageData = new MessageData();
		
		logger.debug("알려줘잉"+member);
		memberService.registMember(member);
		messageData.setResultCode(1);
		messageData.setMsg("가입을 환영합니다. 부어라 마셔라 하세요^^");
		messageData.setUrl("/pourah/member/login_form");
		
		return messageData;
	}
	
	@NoLogging
	@RequestMapping("/memberLogin")
	@ResponseBody
	public MessageData memberLogin(Member member,HttpServletRequest request) {
		MessageData messageData = new MessageData();
		Member obj = memberService.Login(member);
		
		messageData.setMsg("환영합니다 부어라 마셔라 하세요 ^^");
		messageData.setResultCode(1);
		messageData.setUrl("/pourah");
		
		
		HttpSession session = request.getSession();
		session.setAttribute("member", obj);
		
		return messageData;
	}
	
	@RequestMapping("/member_update")
	@ResponseBody
	public MessageData memberUpdate(HttpServletRequest request,Member member) {
		MessageData messageData = new MessageData();
		logger.debug("member는? "+member);
		
		memberService.update(member);
		
		request.getSession().invalidate();
		
		messageData.setMsg("회원 수정 하였습니다^^ 다시 로그인 부탁드립니다.");
		messageData.setResultCode(1);
		messageData.setUrl("/pourah/member/login_form");
		
		
		return messageData;
	}
	
	
	
	/*---------------------------------------------
	 * 배송지 목록 
	 *-----------------------------------------*/
	
	
	//배송지 1개선택하면 폼에 채워넣기
	@RequestMapping("/getAreceiver")
	@ResponseBody
	public Receiver getAReceiver(HttpServletRequest request, int receiver_id) {
		Receiver receiver = receiverService.selectById(receiver_id);
		
		return receiver;
	}

	
	//선택된 배송지 삭제
	@RequestMapping("/deleteReceiver")
	@ResponseBody
	public MessageData deleteReceiver(HttpServletRequest request,int receiver_id) {
		MessageData messageData = new MessageData();
		receiverService.delete(receiver_id);
		logger.debug("receiver_id : "+receiver_id);
		messageData.setMsg("삭제 완료되었습니다 ^^");
		messageData.setResultCode(1);
		
		return messageData;
	}
	
	
	@RequestMapping("/insertReceiver")
	@ResponseBody
	public MessageData insertReceiver(HttpServletRequest request,Receiver receiver) {
		MessageData messageData = new MessageData();
		receiverService.insert(receiver);
		logger.debug("잘왔나?"+receiver);
		messageData.setMsg("등록 성공하였습니다 ^^");
		messageData.setResultCode(1);
		
		return messageData;
	}
	
	
	
	/*
	 * 핸들러-------------------------------------------
	 * --------------------------------------------
	 */
	
	
	@NoLogging
	@ExceptionHandler(IDOverlapException.class)
	@ResponseBody
	public MessageData handleException(IDOverlapException e) {
		MessageData messageData = new MessageData();
		
		messageData.setMsg(e.getMessage());
		messageData.setResultCode(0);
		
		return messageData;
	}
	
	@NoLogging
	@ExceptionHandler(MemberWrongLogginException.class)
	@ResponseBody
	public MessageData handleException(MemberWrongLogginException e) {
		MessageData messageData = new MessageData();
		
		messageData.setMsg(e.getMessage());
		messageData.setResultCode(0);
		
		return messageData;
	}

}
