package com.viniv.pourah.controller.admin.member;

import java.util.List;

import javax.mail.Message;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.viniv.pourah.exception.IDOverlapException;
import com.viniv.pourah.exception.MemberStatusChangeException;
import com.viniv.pourah.exception.AdminWrongLogginException;
import com.viniv.pourah.model.annotation.NoAdminList;
import com.viniv.pourah.model.annotation.NoLogging;
import com.viniv.pourah.model.common.SecureManager;
import com.viniv.pourah.model.domain.Admin;
import com.viniv.pourah.model.domain.MessageData;
import com.viniv.pourah.model.member.repository.AdminDAO;
import com.viniv.pourah.model.member.service.AdminService;
import com.viniv.pourah.model.member.service.MemberServiceImpl;

/*

______             _     ___       _             _         _____                _                 _  _             
| ___ \           | |   / _ \     | |           (_)       /  __ \              | |               | || |            
| |_/ /  ___  ___ | |_ / /_\ \  __| | _ __ ___   _  _ __  | /  \/  ___   _ __  | |_  _ __   ___  | || |  ___  _ __ 
|    /  / _ \/ __|| __||  _  | / _` || '_ ` _ \ | || '_ \ | |     / _ \ | '_ \ | __|| '__| / _ \ | || | / _ \| '__|
| |\ \ |  __/\__ \| |_ | | | || (_| || | | | | || || | | || \__/\| (_) || | | || |_ | |   | (_) || || ||  __/| |   
\_| \_| \___||___/ \__|\_| |_/ \__,_||_| |_| |_||_||_| |_| \____/ \___/ |_| |_| \__||_|    \___/ |_||_| \___||_|   
                                                                                                                   
                                                                                                                   

*/

@Controller
@RequestMapping("/async/admin")
public class RestAdminMemberController {

	private static final Logger logger = LoggerFactory.getLogger(RestAdminMemberController.class);

	@Autowired
	private AdminService adminService;

	@Autowired
	private SecureManager secureManager;
	
	@NoLogging
	@RequestMapping("/overlapCheck")
	@ResponseBody
	public MessageData checkIdOverlapped(String user_id) {
		adminService.overlapCheck(user_id);

		MessageData messageData = new MessageData();
		messageData.setResultCode(1);
		messageData.setMsg("사용 가능한 ID 입니다.");

		return messageData;
	}

	// 로그인처리
	@NoLogging
	@RequestMapping(value = "/login", method = RequestMethod.POST)
	@ResponseBody
	public MessageData login(Admin admin, HttpServletRequest request) {
		MessageData messageData = new MessageData();
		adminService.Login(admin);

		messageData.setResultCode(1);
		messageData.setMsg(admin.getUser_id() + "님 로그인");
		messageData.setUrl("/admin/main");

		admin = adminService.selectById(admin.getUser_id());

		HttpSession session = request.getSession();
		session.setAttribute("admin", admin);
		session.setAttribute("auth", admin.getAuth());

		return messageData;
	}

	@RequestMapping(value = "/editAccount", method = RequestMethod.POST)
	@ResponseBody
	public MessageData adminEdit(Admin admin, HttpServletRequest request) {
		MessageData messageData = new MessageData();

		adminService.update(admin);

		HttpSession session = request.getSession();
		session.invalidate();

		messageData.setResultCode(1);
		messageData.setMsg("수정성공 다시 로그인 해주시기 바랍니다.");
		messageData.setUrl("/admin/login_form");
		return messageData;
	}
	
	@NoAdminList
	@RequestMapping("/delete")
	@ResponseBody
	public MessageData deleteAdmin(int[] admin_idArr,HttpServletRequest request) {
		MessageData messageData = new MessageData();
		
		adminService.delete(3); 
		messageData.setResultCode(1);
		messageData.setMsg("선택한 계정의 삭제가 완료되었습니다.");
		
		return messageData;
	}
	
	
	@NoLogging
	@NoAdminList
	@RequestMapping("/forgot_passwd")
	@ResponseBody
	public MessageData forgotPassword(String user_id) {
		MessageData messageData = new MessageData();
		adminService.forgotPasswd(user_id);
		
		messageData.setMsg("메일 발송이 완료되었습니다^^");
		messageData.setResultCode(1);
		
		return messageData;
	}
	
	
	/*
	 * 핸들러 영역
	 */
	@NoLogging
	@ExceptionHandler(IDOverlapException.class)
	@ResponseBody
	public MessageData handleException(IDOverlapException e) {
		MessageData messageData = new MessageData();

		messageData.setResultCode(0);
		messageData.setMsg(e.getMessage());

		return messageData;
	}

	@NoLogging
	@ExceptionHandler(AdminWrongLogginException.class)
	@ResponseBody
	public MessageData handleException(AdminWrongLogginException e) {
		MessageData messageData = new MessageData();

		messageData.setResultCode(0);
		messageData.setMsg(e.getMessage());

		return messageData;
	}
	
	@NoLogging
	@ExceptionHandler(MemberStatusChangeException.class)
	@ResponseBody
	public MessageData hadnleException(MemberStatusChangeException e) {
		MessageData messageData = new MessageData();
		
		messageData.setMsg("계정 관리중 에러가 발생하였습니다.");
		messageData.setResultCode(0);
		
		return messageData;
	}
	
}
