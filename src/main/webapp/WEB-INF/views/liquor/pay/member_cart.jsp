<%@page import="com.viniv.pourah.model.domain.Paymethod"%>
<%@page import="java.text.Normalizer.Form"%>
<%@page import="com.viniv.pourah.model.common.Formatter"%>
<%@page import="com.viniv.pourah.model.domain.Cart"%>
<%@page import="com.viniv.pourah.model.domain.Receiver"%>
<%@page import="javax.mail.search.ReceivedDateTerm"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html;charset=utf-8"%>
<%
	List<Receiver> receiverList = (List) request.getAttribute("receiverList");
	List<Cart> cartList = (List) request.getAttribute("cartList");
	List<Paymethod> paymethodList = (List) request.getAttribute("paymethodList");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">
    <title>Pour ah ! 장바구니 </title>
    <%@ include file="../inc/head.jsp" %>
</head><!--/head-->
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript">
var element_layer;
var zip;
var ad1;

//--------------------daum 주소찾기
function initLayerPosition(){
    var width = 300; //우편번호서비스가 들어갈 element의 width
    var height = 400; //우편번호서비스가 들어갈 element의 height
    var borderWidth = 5; //샘플에서 사용하는 border의 두께

    // 위에서 선언한 값들을 실제 element에 넣는다.
    element_layer.style.width = width + 'px';
    element_layer.style.height = height + 'px';
    element_layer.style.border = borderWidth + 'px solid';
    // 실행되는 순간의 화면 너비와 높이 값을 가져와서 중앙에 뜰 수 있도록 위치를 계산한다.
    element_layer.style.left = (((window.innerWidth || document.documentElement.clientWidth) - width)/2 - borderWidth) + 'px';
    element_layer.style.top = (((window.innerHeight || document.documentElement.clientHeight) - height)/2 - borderWidth) + 'px';
}

function closeDaumPostcode() {
    // iframe을 넣은 element를 안보이게 한다.
    element_layer.style.display = 'none';
}

function searchZip(){
	daum.postcode.load(function(){
		new daum.Postcode({
			oncomplete: function(data){
				//팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분
				
				//각주소의 노출 규칙에 따라 주소를 조합
				//내려오는 변수가 값이 없을땐 공백을 가지므로 참고하여 분기
				var addr = ""; //주소변수
				
				if(data.userSelectedtype == data.R){
					addr = data.roadAddress;
				}else{
					addr = data.jibunAddress;
				}
				
				ad1 = addr;
				zip = data.zonecode;
				$("#zipcode").val(data.zonecode);
				$("#addr1").val(addr);
				$("#addr2").focus();
				
				element_layer.style.display = 'none';
			},
			 width : '100%',
            height : '100%',
            maxSuggestItems : 6
		}).embed(element_layer);
		
        // iframe을 넣은 element를 보이게 한다.
        element_layer.style.display = 'block';

        // iframe을 넣은 element의 위치를 화면의 가운데로 이동시킨다.
        initLayerPosition();
	});
}

//--------------------daum 주소찾기 끝!


function getTotal(){
	
	var num = 0;
	
	$(".cart_total_price").each(function(index, item){
		var num1 = 1 * $(item).text();
		num = num + num1;
	});
	$("#wholePrice").text(num);
	
	
}

//온로드!!-------------------------
$(function(){
	
	//paymethod check
	$(".paymethodChecked").click(function(){
		var paymethod_id = $(this).val();
		$(".paymethodChecked").each(function(){
			if(paymethod_id != $(this).val()){
				$(this).attr("checked",false);
			}
		});
	});
	
	//!paymethod check
	
	//deleting Cart
	$('.cart_quantity_delete').each(function(index,item){
		$(item).on("click", function(e){
			cart_id = $(this).attr("cart_id");
			
			$.ajax({
	    		url : "/async/pourah/pay/deleteAcart",
	    		type : "post",
	    		data : {
	    			"cart_id" : cart_id
	    		},
	    		success : function(response){
	    			if(response.resultCode == 1 ){
	    				alert(response.msg);
	    				refresh();
	    			}else{
	    				alert(response.msg);
	    			}
	    		}
	    	});
		});
	});
	
	$('.cart_quantity_up').each(function (index, item) {
	     $(item).on("click", function(e){
			cart_id = $(this).attr("cart_id");
	    	var parent = $(this).parent(".cart_quantity_button");
	    	var tdParent = $(parent).parent(".cart_quantity");
	    	var trParent = $(tdParent).parent(".trParent");
	    	var tdParent = $(trParent).children(".cart_price");
	    	var totalTdParent = $(trParent).children(".cart_total");
	    	var thePrice = $(tdParent).children(".cart_price_baby");
	    	var theTotal = $(totalTdParent).children(".cart_total_price")
	    	var theInput = $(parent).children(".cart_quantity_input")
	    	
	    	$.ajax({
	    		url : "/async/pourah/pay/quantity_change",
	    		type : "post",
	    		data : {
	    			"method" : "plus",
	    			"cart_id" : cart_id
	    		},
	    		success : function(response){
	    			if(response.resultCode == 1 ){
	    				var oriCnt ="";
	    				var oriCnt = $(theInput).val();
	    				console.log("원래 oriCnt"+oriCnt);
	    				var string= $(thePrice).text();
	    	    		var no = string.replace(/[^0-9]/g,'');
	    				oriCnt = Number(oriCnt);
	    				$(theInput).val(oriCnt+1);
	    				$(theTotal).text($(theInput).val() * no);
	    				getTotal();
	    			}else{
	    				alert(response.msg);
	    			}
	    		}
	    	});
	     });
	});	
	
	$('.cart_quantity_down').each(function (index, item) {
	     $(item).on("click", function(e){
			cart_id = $(this).attr("cart_id");
			var parent = $(this).parent(".cart_quantity_button");
	    	var tdParent = $(parent).parent(".cart_quantity");
	    	var trParent = $(tdParent).parent(".trParent");
	    	var tdParent = $(trParent).children(".cart_price");
	    	var totalTdParent = $(trParent).children(".cart_total");
	    	var thePrice = $(tdParent).children(".cart_price_baby");
	    	var theTotal = $(totalTdParent).children(".cart_total_price")
	    	var theInput = $(parent).children(".cart_quantity_input")
	    	
	    	$.ajax({
	    		url : "/async/pourah/pay/quantity_change",
	    		type : "post",
	    		data : {
	    			"method" : "minus",
	    			"cart_id" : cart_id
	    		},
	    		success : function(response){
	    			if(response.resultCode == 1 ){
	    				var oriCnt ="";
	    				var oriCnt = $(theInput).val();
	    				console.log("원래 oriCnt"+oriCnt);
	    				var string= $(thePrice).text();
	    	    		var no = string.replace(/[^0-9]/g,'');
	    				oriCnt = Number(oriCnt);
	    				$(theInput).val(oriCnt-1);
	    				$(theTotal).text($(theInput).val() * no);
	    			}else{
	    				alert(response.msg);
	    			}
	    		}
	    	});
	     });
	});	
	
	
	element_layer = document.getElementById('layer');
	
	/* selecter*/
	$("#select_receiver").change(function(){
		$("#daumZip").val("");
		$("#receiver_name").val("");
		$("#zipcode").val("");
		$("#addr1").val("");
		$("#addr2").val("");
		$("#r_name").val("");
		$("#r_phone").val("");
		$("#deletereceiver").hide();
		
		
		if($("#select_receiver option:selected").val() == -1){
			$("#receiver_name").attr("readonly", false);
			$("#daumZip").attr("disabled", false);
			$("#addr2").attr("readonly", false);
			$("#r_name").attr("readonly", false);
			$("#r_phone").attr("readonly", false);
			$("#addreceiver").show();
			$("#deletereceiver").hide();
		}else if($("#select_receiver option:selected").val() != -2 && $("#select_receiver option:selected").val() != -1) {
			$("#receiver_name").attr("readonly", true);
			$("#daumZip").attr("disabled", true);
			$("#addr2").attr("readonly", true);
			$("#r_name").attr("readonly", true);
			$("#r_phone").attr("readonly", true);
			$("#addreceiver").hide();
			$("#deletereceiver").show();
			getReceiver($("#select_receiver option:selected").val());
		}else if($("#select_receiver option:selected").val() != -2){
			$("#receiver_name").attr("readonly", true);
			$("#daumZip").attr("disabled", true);
			$("#addr2").attr("readonly", true);
			$("#r_name").attr("readonly", true);
			$("#r_phone").attr("readonly", true);
			$("#addreceiver").hide();
		}
		
	});
});
	/* !selecter*/
	

/*-------------------*/

function getReceiver(receiver_id){
	
	$.ajax({
		url: "/async/pourah/getAreceiver",
		type : "get",
		data : {
			"receiver_id" : receiver_id
		},
		success : function(response){
			console.log(response);
			$("#receiver_name").val(response.receiver_name);
			$("#zipcode").val(response.zipcode);
			$("#addr1").val(response.addr1);
			$("#addr2").val(response.addr2);
			$("#r_name").val(response.r_name);
			$("#r_phone").val(response.r_phone);
			$("#receiver_id").val(response.receiver_id);
		}
	});
}

/*-------------------*/

function insertReceiver(){
	var data = $("#receiver_form").serialize();
	data += "&zipcode="+zip+"&addr1="+ad1;
	$.ajax({
		url:"/async/pourah/insertReceiver",
		type:"post",
		data : data,
		success : function(response){
			alert(response.msg);
			refresh();
		}
	});
}



function deleteReceiver(){
	$.ajax({
		url:"/async/pourah/deleteReceiver",
		type:"get",
		data :{
			"receiver_id" : $("#receiver_id").val()
		},
		success : function(response){
			if(response.resultCode == 1){
				alert(response.msg);
				refresh();
			}
		}
	});
}

function refresh(){
	location.replace("/pourah/pay/cart_list");
}

function reload(){
	$('.table-responsive cart_info').load(document.URL+' .table-responsive cart_info');
}

/*            cart part                   */

function upQuantity(cart_id){
	
	$.ajax({
		url : "/async/pourah/pay/quantity_change",
		type : "post",
		data : {
			"method" : "plus",
			"cart_id" : cart_id
		},
		success : function(response){
			if(response.resultCode == 1 ){
				var oriCnt ="";
				var oriCnt = $("#quantityContainer").val();
				console.log("원래 oriCnt"+oriCnt);
				oriCnt = Number(oriCnt);
				$("#quantityContainer").val(oriCnt+1);
			}else{
				alert(response.msg);
			}
		}
	});
	
}
function thisTest(){
	console.log(this);
}

function downQuantity(cart_id){
	
	$.ajax({
		url : "/async/pourah/pay/quantity_change",
		type : "post",
		data : {
			"method" : "minus",
			"cart_id" : cart_id
		},
		success : function(response){
			if(response.resultCode == 1 ){
				var oriCnt ="";
				var oriCnt = $("#quantityContainer").val();
				oriCnt = Number(oriCnt);
				$("#quantityContainer").val(oriCnt-1);
			}else{
				alert(response.msg);
			}
		}
	});
}

function registOrder(){
	//오더썸머리
	
	var data = $("#receiver_form").serialize();
	var paymethod_id = $(".paymethodChecked:checked").val();
	var totalPrice = $("#wholePrice").text();
	totalPrice = 1*totalPrice;
	var r_zip = $("#zipcode").val();
	var add1 = $("#addr1").val();
	
	//오더디테일
	
	var product_idarr = [];
	var ori_pricearr = [];
	var quantityarr = []
	var length = $(".product_id").length;
	
	for(var i=0 ; i<length;i++){
		product_id = $($(".product_id")[i]).val();
		ori_price = $($(".ori_price")[i]).val();
		quantity = $($(".cart_quantity_input")[i]).val();
		product_idarr.push(product_id);
		ori_pricearr.push(ori_price);
		quantityarr.push(quantity);
	}
	
	console.log(product_idarr);
	console.log(ori_pricearr);
	console.log(quantityarr);
	
	
	
	data += "&zipcode="+r_zip+"&addr1="+add1+"&total_price="+totalPrice+"&paymethod_id="+paymethod_id;
	data += "&product_id="+product_idarr+"&ori_price="+ori_pricearr+"&quantity="+quantityarr;
	
	 $.ajax({
		url:"/async/pourah/pay/registOrder",
		type:"post",
		data : data,
		success : function(response){
			if(response.resultCode == 1){
				if(confirm(response.msg)){
					location.href=response.url;					
				}				
			}else if(resultCode == 0){
				alert("주문이 실패하였습니다 ㅠ.. 관리자에게 문의해주세요");
				location.href="/pourah";
			}
			
		} 
	});	 
}



</script>

<body>
	<!--header-->
	<%@ include file="../inc/header.jsp" %>
	<!--/header-->
	<input id="receiver_id" type="hidden"> 
	
	<!-- Daum Zip finder -->
	<div id="layer" style="display:none;position:fixed;overflow:hidden;z-index:1;-webkit-overflow-scrolling:touch;">
	<img src="//t1.daumcdn.net/postcode/resource/images/close.png" id="btnCloseLayer" style="cursor:pointer;position:absolute;right:-3px;top:-3px;z-index:1" onclick="closeDaumPostcode()" alt="닫기 버튼">
	</div>
	<!-- Daum Zip finder -->
	
	<section id="cart_items">
		<div class="container">
			<div class="breadcrumbs">
				<ol class="breadcrumb">
				  <li><a href="#">Home</a></li>
				  <li class="active">Shopping Cart</li>
				</ol>
			</div>
			<div class="table-responsive cart_info">
			<form id="orderDetailForm">
				<table class="table table-condensed">
					<thead>
						<tr class="cart_menu">
							<td class="image">Item</td>
							<td class="description"></td>
							<td class="price">가격</td>
							<td class="quantity">수량</td>
							<td class="total">총합</td>
							<td></td>
						</tr>
					</thead>
					<tbody>
						<%int total = 0; %>
						<%for(Cart cart : cartList){ %>
						<%
						int sum =( cart.getQuantity()*cart.getProduct().getPrice());
						total += sum;
						%>
						<tr class="trParent">
							<input type="hidden" class="product_id" value="<%=cart.getProduct().getProduct_id() %>">
							<input type="hidden" class="ori_price" value="<%=cart.getProduct().getPrice() %>">
							<!-- quantity = class cart_quantity_input /  -->
							<td class="cart_product">
								<a href="/pourah/product/detail?product_id=<%=cart.getProduct().getProduct_id()%>"><img style="width:80px" src="/resources/data/basic/<%=cart.getProduct().getProduct_id()+"."+cart.getProduct().getFilename()%>" alt=""></a>
							</td>
							<td class="cart_description">
								<h4><a href=""><%=cart.getProduct().getProduct_name()%></a></h4>
								<p>상품 번호: <%=cart.getProduct().getProduct_id() %></p>
							</td>
							<td class="cart_price">
								<p class="cart_price_baby"><%=Formatter.getCurrency(cart.getProduct().getPrice()) %></p>
							</td>
							<td class="cart_quantity">
								<div class="cart_quantity_button">
									<button cart_id="<%=cart.getCart_id()%>" class="cart_quantity_up"> + </button>
									<input  class="cart_quantity_input" readonly id="quantityContainer" value="<%=cart.getQuantity() %>" type="text" name="quantity" value="1" autocomplete="off" size="2">
									<input id="wow" type="hidden" value="<%=cart.getCart_id() %>"> 
									<button cart_id="<%=cart.getCart_id()%>" class="cart_quantity_down"> - </button>
								</div>
							</td>
							<td class="cart_total">
								<p class="cart_total_price"><% out.print(sum); %></p>
							</td>
							<td class="cart_delete">
								<button cart_id="<%=cart.getCart_id() %>" class="cart_quantity_delete"><i class="fa fa-times"></i></button>
							</td>
						</tr>
						<%} %>
					</tbody>
				</table>
				</form>
			</div>
		</div>
	</section> <!--/#cart_items-->


	<section id="do_action">
			<form id="receiver_form">
		<div class="container">
			<div class="heading">
				<h3>배송지 선택</h3>
			</div>
			<div class="row">
				<div class="col-sm-6">
					<div class="chose_area">
						<ul class="user_option">
						</ul>
						<ul class="user_info">
							<li class="single_field">
								<label>배송지 선택:</label>
								<select id="select_receiver">
									<option value="-2">배송지 선택</option>
									<%if(receiverList != null){ %>
										<%for(int i=0; i<receiverList.size();i++){ %>
										<%Receiver receiver = receiverList.get(i); %>
										<option value="<%=receiver.getReceiver_id()%>"><%= receiver.getReceiver_name() %>
										</option>
										<%} %>
									<%} %>
									<option value="-1">직접 입력</option>
								</select>
							</li>
							<li class="col-sm-8" >
							<h3> -------------------------------------</h3>
							</li>
							<li class="col-sm-5">
								<label>Zip Code:</label>
								<input readonly id="zipcode" style="background-color: #e2e2e2;" type="text">
								----------------------------
								<button disabled id="daumZip" onClick="searchZip()" type="button">주소 검색</button>
							</li>
							<li class="col-sm-8" >
								<label>주소 별칭:</label>
								<input id="receiver_name" name="receiver_name" readonly type="text">
							</li>
							<li class="col-sm-8" >
								<label>기본 주소:</label>
								<input id="addr1" readonly  style="background-color: #e2e2e2;"  type="text">
							</li>
							<li class="col-sm-8" >
								<label>상세 주소:</label>
								<input id="addr2" name="addr2" readonly type="text">
							</li>
							<li class="col-sm-8">
								<label>수령인 :</label>
								<input id="r_name" name="r_name" readonly type="text">
							</li>
							<li class="col-sm-8">
								<label>연락처 :</label>
								<input id="r_phone" name="r_phone" readonly type="text">
							</li>
							<input type="hidden" name="member_id" value="<%=member.getMember_id()%>">
						</ul>
						<a class="btn btn-default update" id="addreceiver" onClick="insertReceiver()"  style="display: none;" href="">현재 배송지 추가하기</a>
						<a class="btn btn-default check_out" id="deletereceiver" onClick="deleteReceiver()" style="display: none;" href="">현재 배송지 삭제하기</a>
					</div>
				</div>
				<div class="col-sm-6">
					<div class="total_area">
						<ul>
							<li>합계 <span id="wholePrice"><%=total %></span></li>
							<li>배송비 <span>무료</span></li>
							</div>
						</ul>
							<div class="payment-options">
								<span>
									<%for(Paymethod paymethod : paymethodList) {%>
									<label><input class="paymethodChecked" type="radio" value=<%=paymethod.getPaymethod_id() %>> <%=paymethod.getMethod() %></label>
									<%} %>
								</span>
							</div>
							<button class="btn btn-default check_out" type="button" onClick="registOrder()" >상품 결제하기</button>
					</div>
				</div>
			</div>
		</div>
			</form>
	</section><!--/#do_action-->

	<!--Footer-->
	<%@ include file="../inc/footer.jsp" %>
	<!--Footer-->
	<%@ include file="../inc/foot.jsp" %>


    
</body>
</html>