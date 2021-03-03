<%@page import="com.viniv.pourah.model.domain.Review"%>
<%@page import="com.viniv.pourah.model.domain.PImage"%>
<%@page import="com.viniv.pourah.model.common.Formatter"%>
<%@ page contentType="text/html;charset=utf-8"%>

<%
	Product product = (Product) request.getAttribute("product");
	List<PImage> pImageList = (List) request.getAttribute("pImageList");
	List<Review> reviewList = (List) request.getAttribute("reviewList");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">
    <title>Pour ah! 상품 정보</title>
    <%@ include file="../inc/head.jsp" %>
    <link href="/resources/liquor/css/star-rating.css" type="text/css" rel="stylesheet">
    <script src="/resources/liquor/js/star-rating.js"></script>
<script>

function registCart(){
	if($("#goCart").val() == 0){
		alert("1개 이상 담아주세요 !");
		return;
	}
	
	var data = $("#cartForm").serialize();
	
	
	$.ajax({
		url : "/async/pourah/pay/registCart",
		type : "post",
		data : data,
		success : function(response){
			if(response.resultCode == 1){
				if(confirm("장바구니 등록에 성공하였습니다. 장바구니로 갈까요?")){
					location.href=response.url;
				}
			}else if(response.resultCode == 0){
				alert(response.msg);
			}else{
				alert("로그인 후 이용 가능합니다.");
			}
		}
	});
}

//--------------------------review--------------------------

//리플등록
$(function(){
	$(".replyRegistBtn").click(function(){
		var origin_id = $(this).attr("origin_id");
		var review_id = $(this).attr("review_id");
		var parentDiv = $(this).parent(".media-body");
		var textArea = $(parentDiv).children(".reply_detail");
		console.log(parentDiv);
		console.log(textArea);
		registReply(origin_id, textArea, $("#plz"),review_id, origin_id, textArea);
		//showReply($("#plz"),review_id, origin_id);
	});
	
//리플조회	
	$(".getReplyBtn").click(function(){
		var parentDiv = $(this).closest("#plz");
		var review_id = $(this).attr("review_id");
		var origin_id = $(this).attr("origin_id");
		
		showReply(parentDiv, review_id, origin_id);
	})
});


function registReview(){
	//폼데이터
	var data = $("#reviewForm").serialize();
	
	//평점
	var st = $("input:radio[name='star-input']:checked").val();
	
	if(st == null){
		st = 1;
	}
	
	//데이터 합치기
	data+= "&score="+st;
	
	//ajax 송출
	$.ajax({
		url: "/async/pourah/product/registReview",
		type:"post",
		data : data,
		success : function(response){
			if(response.resultCode == 1 ){
				alert(response.msg);
				location.reload();
			}
		}
	});
}

function registReply(origin_id, textArea, parentDiv, review_id, origin_id, textArea){
	
	review_id = 1*review_id;
	origin_id = 1 * origin_id;
	
	var member_id = $("#member_id").val();
	member_id = member_id * 1;
	var product_id = $("#product_id").val(); 
	product_id = product_id * 1;
	var detail = $(textArea).val(); 
	
	origin_id = origin_id * 1;
	var data;
	data += "&member_id="+member_id+"&product_id="+product_id+"&detail="+detail+"&origin_id="+origin_id;
	
	$.ajax({
		url : "/async/pourah/product/registReply",
		type : "post",
		data : data,
		success : function(response){
			if(response.resultCode == 1 ){
				alert(response.msg);
				//location.reload();
				$(textArea).text("");
				showReply(parentDiv,review_id, origin_id);
			}else{
				alert(response.msg);
			}
		}
	});
	
	
}

function showReply(parentDiv, review_id, origin_id){
	
	var data = "";
	var product_id = $("#product_id").val();
	product_id = product_id * 1;
	review_id = review_id * 1;
	origin_id = origin_id * 1;
	data += "&product_id="+product_id+"&review_id="+review_id+"&origin_id="+origin_id;
	
	$.ajax({
		url:"/async/pourah/product/getRegistReply",
		type:"post",
		data : data,
		success : function(response){
			console.log(response);
			console.log(response.length);
			if(response.resultCode == 0){
				alert(response.msg)
				return;
			}
				$(parentDiv).html("");
			 for(var i=0 ; i < response.length; i++){
				var tag = "<ul>"
				tag += "<li><a href=\"\"><i class=\"fa fa-user\"></i>"+response[i].member.user_id+"</a></li>";
				tag += "<li><a href=\"\"><i class=\"fa fa-calendar-o\"></i>"+response[i].regdate+"</a></li>";
				tag += "</ul>";
				tag += "<textarea disabled style=\"height:50px; margin:0px; background-color:rgba(255,255,128,.5)\">®"+response[i].detail+"</textarea>";
				//
				$(parentDiv).append(tag);
				} 
			}
	});
}
	

	
	
	
	
	
</script>
    
</head><!--/head-->

<body>
	<!--header-->
	<%@ include file="../inc/header.jsp" %>
	<!--/header-->
	
	<section>
		<div class="container">
			<div class="row">
				<div class="col-sm-3">
				<!-- left side bar -->
				<%@ include file = "../inc/leftsidebar.jsp" %>
				</div>
				
				<div class="col-sm-9 padding-right">
					<div class="product-details"><!--product-details-->
						<div class="col-sm-5">
							<div class="view-product">
								<img src="/resources/data/basic/<%=product.getProduct_id()+"."+product.getFilename() %>" alt="" />
								<buttn onClick="checkRadio()">Zoom</buttn>
								
							</div>
							<div id="similar-product" class="carousel slide" data-ride="carousel">
								
								  <!-- Wrapper for slides -->
								    <div class="carousel-inner">
										<div class="item active">
										<%for(PImage pImage : pImageList){ %>
										  <a href=""><img src="/resources/data/addon/<%=pImage.getP_image_id()+"."+pImage.getFilename() %>" alt=""></a>
										  <%} %>
										</div>
									</div>

								  <!-- Controls -->
								  <a class="left item-control" href="#similar-product" data-slide="prev">
									<i class="fa fa-angle-left"></i>
								  </a>
								  <a class="right item-control" href="#similar-product" data-slide="next">
									<i class="fa fa-angle-right"></i>
								  </a>
							</div>

						</div>
						<div class="col-sm-7">
						<form id="cartForm">
							<div class="product-information"><!--/product-information-->
								<img src="/resources/liquor/images/product-details/new.jpg" class="newarrival" alt="" />
								<h2><%=product.getProduct_name() %></h2>
								<p>상품 번호 : <%=product.getProduct_id() %></p>
								<br>
								<p>용량 : <%=product.getCapacity() %></p>
								<br>
								<p>도수 : <%=product.getAlchole_rate() %></p>
								<input type="hidden" id="product_id" name="product.product_id" value="<%=product.getProduct_id() %>">
								<input type="hidden" id="member_id" name="member_id" value="<%if(member!=null){ out.print(member.getMember_id());}else{out.print(-1);} %>">
								<%//리뷰 평점구하기
								int avg = 0;
								if(reviewList.size() != 0){
									for(int i=0 ; i< reviewList.size();i++ ){
										Review review = reviewList.get(i);
										avg += review.getScore();
									}
									avg = (int)(avg /reviewList.size());
								}
								%>
								<p><%="평점 : "+avg+"0%" %></p>
								<span>
									<span><%= Formatter.getCurrency(product.getPrice()) %></span>
									<label>수량:</label>
									<input type="text" id="goCart" name="quantity"/>
									<button type="button" onClick="registCart()"  class="btn btn-fefault cart">
										<i class="fa fa-shopping-cart"></i>
										장바구니 담기
									</button>
								</span>
								<p><b>Condition:</b> New</p>
								<p><b>Brand:</b> <%=product.getBrand()%></p>
								<a href=""><img src="/resources/liquor/images/product-details/share.png" class="share img-responsive"  alt="" /></a>
							</div><!--/product-information-->
							</form>
						</div>
					</div><!--/product-details-->
					
					<div class="category-tab shop-details-tab"><!--category-tab-->
						<div class="col-sm-12">
							<ul class="nav nav-tabs">
								<li><a href="#cocktail-recipe" data-toggle="tab">추천 레시피!</a></li>
								<li><a href="#tag" data-toggle="tab">관련 상품!</a></li>
								<li class="active"><a href="#reviews" data-toggle="tab">Reviews (5)</a></li>
							</ul>
						</div>
						<div class="tab-content">
							
							
							<div class="tab-pane fade active in" id="reviews" >
								<div class="col-sm-12">
									<form id="reviewForm">
										<label> 리뷰 및 문의 남기기 </label>
										<textarea name="detail" style="height:100px;" <%if(member == null){ %> disabled <%} %> ></textarea>
										<b>Rating: </b> 
										<button type="button" onClick="registReview()" <%if(member == null){ %> disabled <%}%> class="btn btn-default pull-right">
											등록
										</button>
										<input type="hidden" name="product_id" value="<%=product.getProduct_id() %>">
										<!-- 별점주기 -->
										<span class="star-input">
										  <span class="input">
										    <input type="radio" name="star-input" id="p1" value="1"><label for="p1">1</label>
										    <input type="radio" name="star-input" id="p2" value="2"><label for="p2">2</label>
										    <input type="radio" name="star-input" id="p3" value="3"><label for="p3">3</label>
										    <input type="radio" name="star-input" id="p4" value="4"><label for="p4">4</label>
										    <input type="radio" name="star-input" id="p5" value="5"><label for="p5">5</label>
										    <input type="radio" name="star-input" id="p6" value="6"><label for="p6">6</label>
										    <input type="radio" name="star-input" id="p7" value="7"><label for="p7">7</label>
										    <input type="radio" name="star-input" id="p8" value="8"><label for="p8">8</label>
										    <input type="radio" name="star-input" id="p9" value="9"><label for="p9">9</label>
										    <input type="radio" name="star-input" id="p10" value="10"><label for="p10">10</label>
										  </span>
										</span>
										<!-- !별점주기 -->
									</form>
									
									<%if(reviewList != null) {%>
									<%out.print(reviewList.size()); %>
										<%for(int i=0; i<reviewList.size();i++){ %>
										<%Review review = reviewList.get(i); %>
										<%Member obj = review.getMember(); %>
										<!-- 리뷰 란 -->
										<div class="media-body">
											<ul>
												<li><a href=""><i class="fa fa-user"></i><%=obj.getUser_id() %></a></li>
												<li><a href=""><i class="fa fa-calendar-o"></i><%=review.getRegdate() %></a></li>
											</ul>
										    <textarea disabled style="height:50px; margin:0px;" name="" ><%=review.getDetail() %></textarea>
										    <p>&nbsp;</p>
										    
										    <div id="plz" class="media-body">
										    <!--
										    <ul>
												<li><a href=""><i class="fa fa-user"></i>obj.getUser_id() %></a></li>
												<li><a href=""><i class="fa fa-calendar-o"></i>%=review.getRegdate() %></a></li>
											</ul>
										    <textarea disabled style="height:50px; margin:0px;" name="" >%=review.getDetail() %></textarea>
										      -->
										    <button review_id=<%=review.getReview_id() %> origin_id="<%=review.getOrigin_id()%>" class="getReplyBtn"> 펼치기 </button>
										    </div>
										    
										    <!--글남기기영역  -->
										    
										    <%if(member != null){ %>
											    <%if(member.getMember_id() == obj.getMember_id() || member.getAuthstate().equals("1")){ %>
											    <textarea name="reply_detail" class="reply_detail" style="height:50px; margin:0px;" ></textarea>
										            <button class="replyRegistBtn" review_id="<%=review.getReview_id() %>" origin_id="<%=review.getOrigin_id()%>"><i id="sendReply" class="fa fa-reply"></i></button><!-- 관리자랑 동일 유저만 보이게 -->
										            
										            <p> &nbsp; </p>
									            <%} %>
								            <%} %>
								             <!--글남기기영역  -->
										</div>
										<%} %>
									<%} %>									
									<!-- 리뷰 란 -->								
								</div>
								</div>								
							</div>
						</div>
					</div><!--/category-tab-->
				</div>
			</div>
		</div>
	</section>
	
	<!--Footer-->
	<%@ include file="../inc/footer.jsp" %>
	
	<!--/Footer-->
	

  
   <%@ include file="../inc/foot.jsp" %>
</body>
</html>