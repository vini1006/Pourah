<%@page import="com.viniv.pourah.model.domain.Asubcategory"%>
<%@page import="com.viniv.pourah.model.common.Pager"%>
<%@page import="com.viniv.pourah.model.domain.Product"%>
<%@page import="com.viniv.pourah.model.domain.Atopcategory"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html;charset=utf-8"%>
<%
List<Atopcategory> atopList = (List) request.getAttribute("atopList");
List<Asubcategory> asubList = (List) request.getAttribute("asubList");

List<Product> productList = (List) request.getAttribute("productList");
Pager pager = (Pager) request.getAttribute("pager");



String topCategory_name = (String) request.getAttribute("topCategory_name");
String subCategory_name = (String) request.getAttribute("subCategory_name");
Integer a_topcategory_id = (Integer) request.getAttribute("a_topcategory_id");
Integer a_subcategory_id = (Integer) request.getAttribute("a_subcategory_id");

%>

<!DOCTYPE html>
<html lang="en">
<head>
<title>상품 리스트</title>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />

<%@ include file="../inc/head.jsp"%>
<style>
td{
 text-align:center;
}
</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script>
var checkboxArr = [];


$(function(){
	$('#topcategory-select li > a').on('click', function() {
	    // 버튼에 선택된 항목 텍스트 넣기 
	    $('#topButton').text($(this).text());
	    $('#topIdContainer').attr("value", $(this).attr("value"));
	    var topName = $('#topButton').text();
	    $('#topCategory_name').val(topName);
	    topChangeCategory();
	});
	
	$('#subcategory-select li > a').on('click', function() {
	    // 버튼에 선택된 항목 텍스트 넣기 
	    $('#subButton').text($(this).text());
	    $('#subIdContainer').attr("value", $(this).attr("value"));
	    $('#subCategory_name').attr("value", $(this).text());
	    var subName = $('#subButton').text();
	    console.log(subName);
	    $('#subCategory_name').val(subName);
	    subChangeCategory();
	});
	
	  $("#check-all").click(function(){
	        var chk = $(this).is(":checked");//.attr('checked');
	        if(chk){
	        	$(".check-product").attr('checked', true);
	        	$(this).attr('checked', true);
	        }else{
	        	$(".check-product").attr('checked', false);
	        	$(this).attr('checked', false);
	        }
    });
});

function refresh(){
	location.reload();
}

function deleteProduct(){
	if(confirm("선택된 상품을 삭제하시겠습니까?")){
		$("input:.check-product:checked").each(function(){
			checkboxArr.push($(this).val());
		});
		
		var data = new FormData(); 
		data.append("product_idArr", checkboxArr);
		
		 $.ajax({
	         url: '/async/product/deleteProduct',
	         type: 'POST',
	         //async: true,
	         //cache: false,
	         contentType: false,
	         processData: false,
	         data: data,
	         success: function (response) {
	        	 alert("삭제 되었습니다.");
	         }
	     });
	 refresh();
	}
	
	
	
}



function topChangeCategory(){
	$("form").attr({
		action : "/admin/product/top_filter",
		method : "post"
	});
	$("form").submit();
}

function subChangeCategory(){
	$("form").attr({
		action : "/admin/product/sub_filter",
		method : "post"
	});
	$("form").submit();
}


</script>
</head>
<body>

<!--Header-part-->
<%@ include file="../inc/header.jsp" %>

<!--sidebar-menu-->

<%@ include file="../inc/sidebar.jsp" %>

<!--sidebar-menu-->

<div id="content">
<div class="row-fluid">
	 <p><button class="btn btn-success btn-large">엑셀로 저장하기</button></p>
	<div class="control-group">
           <div class=btn-group>
           	<form id="top-sub">
           		<input type="hidden" id="topIdContainer" name="a_topcategory_id" <%if(a_topcategory_id != null){ %>value=<%=a_topcategory_id %>><%} %> >
           		<input type="hidden" id="topCategory_name" name="topCategory_name" <%if( topCategory_name != null){ %>value=<%=topCategory_name %> <%} %>>
           		<input type="hidden" id="subIdContainer" name="a_subcategory_id" <%if(a_subcategory_id != null){ %>value=<%=a_subcategory_id %>><%} %>>
           		<input type="hidden" id="subCategory_name" name="subCategory_name" <%if( subCategory_name != null){ %>value=<%=subCategory_name %> <%} %> >
           	</form>
           	<%if(topCategory_name == null){ %>
              <button id="topButton" data-toggle="dropdown" class="btn dropdown-toggle">상위 카테고리<span class="caret"></span></button>
           	<%}else{ %>
           	  <button id="topButton" data-toggle="dropdown" class="btn dropdown-toggle"><%=topCategory_name %><span class="caret"></span></button>
           	<%} %>
              <ul id="topcategory-select" class="dropdown-menu">
              <%for(Atopcategory atopcategory : atopList){ %>
                <li><a href="#" value="<%=atopcategory.getA_topcategory_id()%>"><%=atopcategory.getName() %></a></li>
                <%} %>
                <li class="divider"></li>
                <li><a href="/admin/product/list">전체</a></li>
              </ul>
            </div>
           <div class="btn-group">
           <%if(subCategory_name == null){ %>
              <button id="subButton" data-toggle="dropdown" class="btn dropdown-toggle">하위 카테고리<span class="caret"></span></button>
           <%}else{ %>
              <button id="subButton" data-toggle="dropdown" class="btn dropdown-toggle"><%= subCategory_name %><span class="caret"></span></button>
           <%} %>
              <ul id="subcategory-select" class="dropdown-menu">
              <%if(asubList == null){ %>
              	<li><a href="#" value=""></a></li>
              <%}else{ %>
               <%for(Asubcategory asubCateogry : asubList){ %>
                <li><a href="#" value="<%=asubCateogry.getA_subcategory_id()%>"><%=asubCateogry.getName() %></a></li>
                <%} %>
               <%} %>
              </ul>
            </div>
           </div>
        </div>



	<div class="widget-box">
          <div class="widget-title"> 
            <h5>상품 목록</h5>
          </div>
          <div class="widget-content nopadding">
            <table class="table table-bordered data-table">
              <thead>
                <tr>
                  <th align="center" width="50"><input id="check-all" type="checkbox"></th>
                  <th align="center" width="50">no</th>
                  <th width="170">Image</th>
                  <th>상품 이름</th>
                  <th width="100">브랜드</th>
                  <th width="50">용량</th>
                  <th width="50">도수</th>
                </tr>
              </thead>
              <tbody>
              <%for(int i=0; i< pager.getPageSize(); i++){ %>
              <%if(pager.getNum() <= 0)break; %>
              <%Product product = productList.get(pager.getCurPos()); %>
              <%pager.setCurPos(pager.getCurPos()+1); %>
                <tr class="gradeX">
                  <th align=center><input value="<%=product.getProduct_id()%>" id="testest" class="check-product" type="checkbox"></td>
                  <td align=center><%=pager.getNum() %></td><%pager.setNum(pager.getNum()-1); %>
                  <td align=center><img style="width:60px;" src="/resources/data/basic/<%=product.getProduct_id()+"."+product.getFilename()%>"></td>
                  <td align=center><a href="/admin/product/detail_form?product_id=<%=product.getProduct_id()%>"><%=product.getProduct_name() %></a></td>
                  <td align=center><%=product.getBrand() %></td>
                  <td align=center><%=product.getCapacity() %></td>
                  <td align=center><%=product.getAlchole_rate() %></td>
                </tr>
               <%}%>
              </tbody>
            </table>
              <div class="pagination">
              <ul>
              	<%if(pager.getFirstPage() > 1){ %>
                <li><a href="/admin/product/list?currentPage=<%=pager.getFirstPage()-1%>">Prev</a></li>
                <%}else if(pager.getFirstPage() == 1) { %>
                <li><a href="javascript:alert('첫번째 페이지 입니다')">Prev</a></li>
                <%} %>
                <%for(int i=pager.getFirstPage(); i<= pager.getLastPage(); i++){ %>
                <%if( i > pager.getTotalPage()) break; %>
                <li <%if( i == pager.getCurrentPage()) {%>class="active" <%} %>>
                <a href="/admin/product/list?currentPage=<%out.print(i);%>"><%out.print(i);%></a></li>
                <%} %>
                <%if(pager.getNum() > 0){ %>
                <li><a href="/admin/product/list?currentPage=<%=pager.getLastPage()+1%>">Next</a></li>
                <%}else if(pager.getLastPage() >= pager.getTotalPage()){ %>
                <li><a href="javascript:alert('마지막 페이지 입니다')">Next</a></li>
                <%} %>
		            <li>선택된 상품 <input type="button" id="delete" value="삭제하기" onClick="deleteProduct()"><li>
              </ul>
            </div>
          </div>
        </div>
</div>

<!--end-main-container-part-->

<!--Footer-part-->
<!--end-Footer-part-->
<%@ include file="../inc/foot.jsp" %>
<script src="/resources/admin/js/jquery.dataTables.min.js"></script> 
<!--end-Footer-part-->

</body>
</html>
