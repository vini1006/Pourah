<%@page import="com.viniv.pourah.model.domain.Product"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.viniv.pourah.model.domain.Asubcategory"%>
<%@page import="java.util.List"%>
<%@page import="com.viniv.pourah.model.domain.Atopcategory"%>
<%@ page contentType="text/html;charset=utf-8"%>
<% 
	List<Atopcategory> atopList = (List) request.getAttribute("atopList");
	// 카테고리별 갯수()괄호로 표현하기	


	//인기레시피글 가져오기 7건
%>
<div class="left-sidebar">
	<h2>Category</h2>
	<div class="panel-group category-products" id="accordian"><!--category-productsr-->
	
	
	
		<%for(int i=0 ;i<atopList.size();i++){ %>
		<%Atopcategory atopcategory = atopList.get(i); %>
		<div class="panel panel-default">
			<div class="panel-heading">
				<h4 class="panel-title">
					<a data-toggle="collapse" data-parent="#accordian" href="#<%=atopcategory.getName()%>">
						<span class="badge pull-right"><i class="fa fa-plus"></i></span>
						<%=atopcategory.getName() %>
					</a>
				</h4>
			</div>
			<div id="<%=atopcategory.getName() %>" class="panel-collapse collapse">
				<div class="panel-body">
					<ul>
						<%for(int j=0; j<atopcategory.getA_subcategory().size();j++){ %>
						<%Asubcategory asubcategory =  atopcategory.getA_subcategory().get(j); %>
						<li><a href="/pourah/product/list?a_subcategory_id=<%=asubcategory.getA_subcategory_id()%>"><span class="pull-right">(<%=asubcategory.getProductList().size() %>)</span><%=asubcategory.getName() %></a></li>
						<%} %>
					</ul>
				</div>
			</div>
		</div>
		<%} %>
		
		
	</div><!--/category-products-->

	<div class="brands_products"><!--brands_products-->
		<h2>Cocktail HOT</h2>
		<div class="brands-name">
			<ul class="nav nav-pills nav-stacked">
				<li><a href="#"> <span class="pull-right">(50)</span>인기글 올 예정</a></li>
			</ul>
		</div>
	</div><!--/brands_products-->
	
	<div class="price-range"><!--price-range-->
		<h2>Price Range</h2>
		<div class="well text-center">
			 <input type="text" class="span2" value="" data-slider-min="0" data-slider-max="50" data-slider-step="1" data-slider-value="[250,450]" id="sl2" ><br />
			 <b class="pull-left">₩ 0</b> <b class="pull-right">₩ 5만원</b> <!-- 제일비싼 금액넣기 -->
		</div>
	</div><!--/price-range-->
	
	<div class="shipping text-center"><!--shipping-->
		<img src="/resources/liquor/images/home/vinilogo.jpg" alt="" />
	</div><!--/shipping-->

</div>