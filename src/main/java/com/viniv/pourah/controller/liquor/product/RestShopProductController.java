package com.viniv.pourah.controller.liquor.product;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.viniv.pourah.exception.NullListException;
import com.viniv.pourah.model.domain.Member;
import com.viniv.pourah.model.domain.MessageData;
import com.viniv.pourah.model.domain.News;
import com.viniv.pourah.model.domain.Review;
import com.viniv.pourah.model.news.repository.NewsDAO;
import com.viniv.pourah.model.news.service.NewsService;
import com.viniv.pourah.model.product.service.ReviewService;

@Controller
@RequestMapping("/async/pourah/product")
public class RestShopProductController {
	
	Logger logger = LoggerFactory.getLogger(RestShopProductController.class);
	
	@Autowired
	private ReviewService reviewService;
	
	@Autowired
	private NewsService newsService;
	
	//리뷰 등록 
	@RequestMapping("/registReview")
	@ResponseBody
	public MessageData registReview(HttpServletRequest request,Review review) {
		MessageData messageData = new MessageData();
		//넘어오는건 디테일과 스코어, 프로덕트 아이디만 넘어옴.
		//member_id 채워주고, 셀렉트키로 review_id origin_id도 채워넣기 (rank는 default 0)
		
		//logger.debug("넘어온 review"+review);
		
		Member member = (Member)request.getSession().getAttribute("member");
		int member_id = member.getMember_id();
		
		review.setMember_id(member_id);
		//리뷰 등록하기
		reviewService.registReview(review);
		
		//리뷰 등록후 관리자에게 소식보내기
		
		SimpleDateFormat format2 = new SimpleDateFormat ( "yyyy년 MM월dd일 HH시mm분");
		Date time = new Date();
		String time2 = format2.format(time);
				
		News news = new News();
		news.setRegdate(time2);
		news.setWriter(""+member_id);
		news.setTitle("상품 상세 게시판");
		news.setUrl("/pourah/product/detail?product_id="+review.getProduct_id());
		newsService.insert(news);
		
		
		messageData.setMsg("소중한 의견 감사합니다.");
		messageData.setResultCode(1);
		
		return messageData;
	}
	
	//리뷰 대댓 작성
	@RequestMapping("/registReply")
	@ResponseBody
	public MessageData registReply(HttpServletRequest request, Review review) {
		MessageData messageData = new MessageData();
		
		logger.debug("dd"+review);
		reviewService.registReview(review);
		
		messageData.setMsg("대댓글 등록 성공^^");
		messageData.setResultCode(1);
		
		return messageData;
	}
	
	//리뷰 대댓 요청
	@RequestMapping("/getRegistReply")
	@ResponseBody
	public List<Review> getReply(HttpServletRequest request, Review review) {
		//product_id 랑 origin_id 만 오면됨
		List replyList = reviewService.getReply(review);
		
		
		return replyList;
	}
	
	
	
	@ExceptionHandler(NullListException.class)
	@ResponseBody
	public MessageData handleException(NullListException e) {
		MessageData messageData = new MessageData();
		
		messageData.setMsg(e.getMessage());
		messageData.setResultCode(0);
		
		
		return messageData;
	}
	


}
