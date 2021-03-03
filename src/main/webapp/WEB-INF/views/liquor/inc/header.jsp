<%@page import="com.viniv.pourah.model.domain.Member"%>
<%@ page contentType="text/html;charset=utf-8"%>
<% 
	Member member = (Member) session.getAttribute("member");
 %>
	<header id="header"><!--header-->
		<div class="header_top"><!--header_top-->
			<div class="container">
				<div class="row">
					<div class="col-sm-6">
						<div class="contactinfo">
							<ul class="nav nav-pills">
								<li><a href="#"><i class="fa fa-github"></i> github.com/vini1006</a></li>
								<li><a href="#"><i class="fa fa-envelope"></i> viniyoon1006@gmail.com</a></li>
							</ul>
						</div>
					</div>
					<div class="col-sm-6">
						<div class="social-icons pull-right">
							<ul class="nav navbar-nav">
								<li><a href="#"><i class="fa fa-instagram"></i></a></li>
							</ul>
						</div>
					</div>
				</div>
			</div>
		</div><!--/header_top-->
		
		<div class="header-middle"><!--header-middle-->
			<div class="container">
				<div class="row">
					<div class="col-sm-4">
						<div class="logo pull-left">
							<a href="javascript:location.href='/pourah'"><img style="width:130px;height:90px;" src="/resources/liquor/images/home/vinilogo.png"  alt="" /></a>
						</div>
						<div class="btn-group pull-right">
						</div>
					</div>
					<div class="col-sm-8">
						<div class="shop-menu pull-right">
							<ul class="nav navbar-nav">
								<li><a href="/pourah/member/account"><i class="fa fa-user"></i> Account</a></li>
								<li><a href="/pourah/pay/order_list"><i class="fa fa-crosshairs"></i> Checkout</a></li>
								<li><a href="/pourah/pay/cart_list"><i class="fa fa-shopping-cart"></i> Cart</a></li>
								<%if(member == null){ %>
									<li><a href="/pourah/member/login_form"><i class="fa fa-lock"></i> Login</a></li>
								<%}else{ %>
									<li><a href="/pourah/member/logout"><i class="fa fa-unlock"></i> LogOut</a></li>
								<%} %>
							</ul>
						</div>
					</div>
				</div>
			</div>
		</div><!--/header-middle-->
	
		<div class="header-bottom"><!--header-bottom-->
			<div class="container">
				<div class="row">
					<div class="col-sm-9">
						<div class="navbar-header">
							<button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
								<span class="sr-only">Toggle navigation</span>
								<span class="icon-bar"></span>
								<span class="icon-bar"></span>
								<span class="icon-bar"></span>
							</button>
						</div>
						<div class="mainmenu pull-left">
							<ul class="nav navbar-nav collapse navbar-collapse">
								<li><a href="/pourah" class="active">Home</a></li>
								<li class="dropdown"><a href="#">Shop<i class="fa fa-angle-down"></i></a>
                                    <ul role="menu" class="sub-menu">
                                        <li><a href="javascript:location.href='/pourah/product/list'">Products</a></li>
										<li><a href="/pourah/pay/order_list">Checkout</a></li> 
										<li><a href="/pourah/pay/cart_list">Cart</a></li> 
										<li><a href="login.html">Login</a></li> 
                                    </ul>
                                </li> 
								<li><a href="contact-us.html">Wanna make Cocktail</a></li>
							</ul>
						</div>
					</div>
					<div class="col-sm-3">
						<div class="search_box pull-right">
						</div>
					</div>
				</div>
			</div>
		</div><!--/header-bottom-->
	</header><!--/header-->