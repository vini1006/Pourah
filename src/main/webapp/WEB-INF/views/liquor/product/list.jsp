<%@page import="com.viniv.pourah.model.domain.Product"%>
<%@page import="com.viniv.pourah.model.common.ProductPager"%>
<%@page import="com.viniv.pourah.model.common.Pager"%>
<%@ page contentType="text/html;charset=utf-8"%>
<%
List<Product> productList = (List) request.getAttribute("productList");	
ProductPager pager = (ProductPager) request.getAttribute("pager");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">
    <title>Pour ah! 상품목록</title>
    <%@ include file="../inc/head.jsp" %>
<style>
	a{
	color:black;
	 text-decoration:none;}
</style>
<script>
function getDetail(product_id){
	location.href="/pourah/product/detail?product_id="+product_id;
}

</script>
</head><!--/head-->

<body>
	<%@ include file="../inc/header.jsp" %>	
	<section id="advertisement">
		<div class="container">
			<img src="/resources/liquor/images/shop/gwango.jpg" alt="" />
		</div>
	</section>
	
	<section>
		<div class="container">
			<div class="row">
				<div class="col-sm-3">
					<!-- left side bar -->
					<%@ include file="../inc/leftsidebar.jsp" %>
				</div>
				<div class="col-sm-9 padding-right">
					<div class="features_items"><!--features_items-->
						<h2 class="title text-center">Hot!</h2>
						
						<%for(int i=0; i<pager.getPageSize();i++){ %>		
						<%
							if(pager.getCurPos() > pager.getTotalRecord()-1) break;
							Product product = productList.get(pager.getCurPos());
							pager.setCurPos(pager.getCurPos()+1);
						%>
						<div class="col-sm-4">
							<div class="product-image-wrapper">
								<div class="single-products">
									<div class="productinfo text-center">
										<img id="repImg" src="/resources/data/basic/<%=product.getProduct_id()+"."+product.getFilename() %>" onClick="getDetail(<%=product.getProduct_id() %>)" style="cursor:pointer" alt="" />
										<h2>₩<%=product.getPrice() %></h2>
										<p><a href="/pourah/product/detail?product_id=<%=product.getProduct_id()%>"><%=product.getProduct_name() %></a></p>
										<a href="#" class="btn btn-default add-to-cart"><i class="fa fa-shopping-cart"></i>Add to cart</a>
									</div>
								</div>
								<div class="choose">
									<ul class="nav nav-pills nav-justified">
										<li><a href=""><i class="fa fa-plus-square"></i>Add to wishlist</a></li>
										<li><a href=""><i class="fa fa-plus-square"></i>Add to compare</a></li>
									</ul>
								</div>
							</div>
						</div>
						<%} %>
						
						<ul class="pagination">
							<%if(pager.getFirstPage() == 1){ %>
							<li><a href="javascript:alert('첫번째 페이지 입니다.')">&laquo;</a></li>
							<%}else{ %>
							<li><a href="/pourah/product/list?currentPage=<%=pager.getFirstPage()-1%>">&laquo;</a></li>
							<%} %>
							
							<%for(int i = pager.getFirstPage(); i <= pager.getLastPage();i++ ){ %>
							<%if(i > pager.getTotalPage()) break; %>
							<li<%if(i == pager.getCurrentPage()){ %> class = "active"<%} %>><a href="/pourah/product/list?currentPage=<%=i %>"><%= i %></a></li>
							<%} %>
							
							<%if(pager.getLastPage() >= pager.getTotalPage()){ %>
							<li><a href="javascript:alert('마지막 페이지 입니다.')">&raquo;</a></li>
							<%}else{ %>
							<li><a href="/pourah/product/list?currentPage=<%=pager.getLastPage()+1%>">&raquo;</a></li>
							<%} %>
						</ul>
					</div><!--features_items-->
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