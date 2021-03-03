<%@page import="com.viniv.pourah.model.domain.Product"%>
<%@page import="com.viniv.pourah.model.domain.Order_detail"%>
<%@page import="com.viniv.pourah.model.domain.Order_summary"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html;charset=utf-8"%>
<% 
	List<Order_summary> orderList = (List) request.getAttribute("orderList");

%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">
    <title>pourah! 주문 리스트</title>
    <%@ include file="../inc/head.jsp" %>
</head><!--/head-->

<body>
	<%@ include file="../inc/header.jsp" %>
	<section id="cart_items">
		<div class="container">
			<div class="step-one">
				<h2 class="heading">Step1</h2>
			</div>
			<div class="checkout-options">
				<h3>New User</h3>
				<p>Checkout options</p>
				<ul class="nav">
					<li>
						<label><input type="checkbox"> Register Account</label>
					</li>
					<li>
						<label><input type="checkbox"> Guest Checkout</label>
					</li>
					<li>
						<a href=""><i class="fa fa-times"></i>Cancel</a>
					</li>
				</ul>
			</div><!--/checkout-options-->

			<div class="register-req">
				<p>Please use Register And Checkout to easily get access to your order history, or use Checkout as Guest</p>
			</div><!--/register-req-->
			<div class="review-payment">
				<h2>주문 목록</h2>
			</div>
			<%for(int i=0; i<orderList.size();i++){ %>
			<%Order_summary order_summary = orderList.get(i); %>			
			<% int totalPrice = 0; %>
			<div class="table-responsive cart_info">
				<table class="table table-condensed">
					<thead>
						<tr class="cart_menu">
							<td class="image">상품</td>
							<td class="description"></td>
							<td class="price">가격</td>
							<td class="quantity">수량</td>
							<td class="total">합계</td>
							<td class="total"><%=order_summary.getOrder_date()%></td>
						</tr>
					</thead>
					<tbody>
						<%for(int j=0; j<order_summary.getOrder_detail().size();j++){ %>
						<%Order_detail order_detail = order_summary.getOrder_detail().get(j); %>
						<%Product product = order_detail.getProduct(); %>
						<tr>
							<td class="cart_product">
								<a href=""><img style="width:80px" src="/resources/data/basic/<%=product.getProduct_id()+"."+product.getFilename() %>" alt=""></a>
							</td>
							<td class="cart_description">
								<h4><a href=""><%=product.getProduct_name() %></a></h4>
								<p>Web ID: <%=product.getProduct_id() %></p>
							</td>
							<td class="cart_price">
								<p>₩<%=order_detail.getOri_price() %></p>
							</td>
							<td class="cart_quantity">
									<input class="cart_quantity_input" readonly type="text" name="quantity" value="<%=order_detail.getQuantity()%>" autocomplete="off" size="2">
							</td>
							<td class="cart_total" >
								<p class="cart_total_price">₩<%=order_detail.getQuantity() * order_detail.getOri_price() %></p>
								<%totalPrice += (order_detail.getQuantity() * order_detail.getOri_price());  %>
							</td>
							<td>
								<%=order_detail.getOrder_state().getState()%>
							</td>
						</tr>
						<%} %><!-- 내부for문  -->
						<tr>
							<td colspan="4">&nbsp;</td>
							<td colspan="2">
								<table class="table table-condensed total-result">
									<tr>
										<td>장바구니 합계</td>
										<td>₩<%=totalPrice %></td>
									</tr>
									<tr class="shipping-cost">
										<td>Shipping Cost</td>
										<td>Free</td>										
									</tr>
									<tr>
										<td>계산금액</td>
										<td><span>₩<%=totalPrice %></span></td>
									</tr>
									<tr>
										<td>결제방법</td>
										<td><span><%=order_summary.getPaymethod().getMethod() %></span></td>
									</tr>
								</table>
							</td>
						</tr>
					</tbody>
				</table>
			</div>
			<%} %><!-- 바깥for문 -->
			<div class="payment-options">
					<span>
						<label><input type="checkbox"> Direct Bank Transfer</label>
					</span>
					<span>
						<label><input type="checkbox"> Check Payment</label>
					</span>
					<span>
						<label><input type="checkbox"> Paypal</label>
					</span>
				</div>
		</div>
	</section> <!--/#cart_items-->

	

	<%@ include file="../inc/footer.jsp" %>
	<%@ include file="../inc/foot.jsp" %>	


</body>
</html>