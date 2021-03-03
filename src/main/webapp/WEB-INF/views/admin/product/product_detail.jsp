<%@page import="com.viniv.pourah.model.common.FileManager"%>
<%@page import="com.viniv.pourah.model.domain.PImage"%>
<%@page import="com.viniv.pourah.model.domain.Product"%>
<%@page import="com.viniv.pourah.model.domain.Atopcategory"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html;charset=utf-8"%>
<%
	List<Atopcategory> atopList = (List) request.getAttribute("atopList");
	Product product = (Product) request.getAttribute("product");
	List<PImage> pImageList = (List) request.getAttribute("pImageList");
%>

<!DOCTYPE html>
<html lang="en">
<head>
<title>상품 상세 페이지</title>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />

<%@ include file="../inc/head.jsp"%>
<style>

#dragArea{
	width:100%;
	height:300px;
	overflow:scroll;
	border:1px solid #ccc;
}

.dragBorder{
	background:#ffffff;
}

.box{
	width:100px;
	float:left;
	padding:5px;
}
.box > img{
	width:100%; 
}

#p_image {display:none;}

</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script>

var uploadFiles=[]; //미리보기 이미지 목록 
var repImg = [];
var addImags = [];


function handleRepImgsFileSelect(e){
	var files = e.target.files;
	var filesArr = Array.prototype.slice.call(files);
	var inputForm = e.currentTarget;
	$(inputForm).attr("name", "repImg");
	
	filesArr.forEach(function(f){
		if(!f.type.match("image.*")){
			alert("이미지만 업로드 가능합니다 ^^");
			return;
		}
		
		var reader = new FileReader();
		reader.onload = function(e){
			$("#repImg_container").attr("src", e.target.result);
		}
		reader.readAsDataURL(f);
	});
}





$(function(){
		$("#input_repImg").on("change", handleRepImgsFileSelect);
		/* CKEDITOR.replace("detail"); */	
		
		/*-----------------------------------------------------*/
		/*드래그 관련 이벤트 */
		$("#dragArea").on("dragenter", function(e){ //드래그로 영역에 진입했을때...
			$(this).addClass("dragBorder");
		});
		/*-----------------------------------------------------*/
		$("#dragArea").on("dragover", function(e){ //드래그영역 위에 있는 동안...
			//$(this).append("dragover<br>");
			e.preventDefault();
		});
		/*-----------------------------------------------------*/
		$("#dragArea").on("dragleave", function(e){ //드래그 영역에서 빠져나가면
			$(this).removeClass("dragBorder");
		});
		/*-----------------------------------------------------*/
		//이미지 삭제 이벤트 처리 
		$("#dragArea").on("click", ".close", function(e){
			console.log(e);
			
			//대상 요소 배열에서 삭제
			//삭제전에 uploadFiles 라는 배열에 들어있는 file의 index를 구하자!!
			var f = uploadFiles[e.target.id];
			console.log("f : "+f);
			var index = uploadFiles.indexOf(f); //파일 객체가 몇번째 들어있는지 추출
			console.log("index : "+index);
			//alert(e.target.id+"클릭햇어?");
			uploadFiles.splice(index ,1);
			
			//대상 요소 삭제 (시각적으로 삭제)
			$(e.target).parent().remove();
		});
		/*-----------------------------------------------------*/
		$("#topcategory-select li > a[id='select']").on('click', function() {
		    // 버튼에 선택된 항목 텍스트 넣기 
		    $('#topCategory').text($(this).text());
		    $('#a_top').val($(this).attr("value"));
		    getSubList(this);
		});
		
		$("#dragArea").on("drop", function(e) {
		    e.preventDefault();
		    var fileList = e.originalEvent.dataTransfer.files; //드래그한 파일들에 대한 배열 얻기!!
			//배열안에 들어있는 이미지들에 대한 미리보기처리...
			for(var i=0;i<fileList.length;i++){
				uploadFiles.push(fileList[i]); //fileList안의 요소들을 일반배열에 옮겨심기 
				//왜 심었나? 배열이 지원하는 여러 메서드들을 활용하기 위해...(ex : indexOf..)
				preview(uploadFiles[i], i); //파일 요소 하나를 넘기기
			}
		}).on("drop", function(e) {
		    $("#p_image")
		        .prop("files", e.originalEvent.dataTransfer.files)
		        .attr("name", "p_image")
		        .closest("form")
		});
});



function getSubList(obj){
	//alert($(obj).val());
	
	$.ajax({
		url:"/async/product/Asublist", 
		type:"get",
		data:{
			a_topcategory_id:$(obj).attr('value')	
		},
		success:function(response){
			console.log(response);
			
			$("#subcategory-select").empty();
			for(var i=0;i<response.length;i++){
				var a_subcategory = response[i]; 
				var newItemli = $('<li></li>');
				var newItema = $("<a href='#' id=\"select\" value=\""+a_subcategory.a_subcategory_id+"\">"+a_subcategory.name+"</a>");
				newItemli.append(newItema);
				$("#subcategory-select").append(newItemli);
			}
			$("#subcategory-select").append("<li class='divider'></li>");
			$("#subcategory-select").append("<li><a href='#' data-target=\"#sub-add-modal\" data-toggle=\"modal\">카테고리 추가</a></li>");
			
			$("#subcategory-select li > a[id='select']").on('click', function() {
			    $('#subCategory').text($(this).text());
			    $('#a_sub').attr("value", $(this).attr("value"));
			});
            
		}
	});
}

	
function preview(file, index){
	var reader = new FileReader(); //아직은 읽을 대상 파일이 결정되지 않음..
	//파일일 읽어들이면, 이벤트 발생시킴 
	reader.onload = function(e){
		console.log(e.currentTarget.result);
		
		var tag="<div class=\"box\">";
		tag+="<div class=\"close\" id=\""+index+"\">X</div>";
		tag+="<img src=\""+e.currentTarget.result+"\">";
		tag+="<i class='icon-camera'></i>"+file.name+"<div class=\"close\" id=\""+index+"\">　　X</div>";
		tag+="</div>";
		
		$("#dragArea").append(tag);
		
	};
	reader.readAsDataURL(file); //지정한 파일을 읽는다(매개변수로는 파일이 와야함)
}


function regist_topCategory(){
	console.log($("#t_name").val());
	
	$.ajax({
		url:"/async/product/categoryRegist", 
		type:"post",
		data:{
			"name" : $("#t_name").val() 
		},
		success:function(response){
            alert(response);
		}
	});
	
}

function regist_subCategory(){
	console.log($("#a_top").val());
	
	$.ajax({
		url:"/async/product/categoryRegist", 
		type:"post",
		data:{
			a_topcategory_id:$("#a_top").val(),
			name : $("#s_name").val()
		},
		success:function(response){
			alert(response);
		}
	});
}

function refresh(){
	location.reload();
}


function deletePImage(pImage_id){
	$.ajax({
		url:"/async/product//deletePImage", 
		type:"get",
		data:{
			"p_image_id" : pImage_id 	
		},
		success:function(response){
			alert(response);
			refresh();	
		}
		
	});
	
}

function edit(){
	
	$("#realForm").attr({
		action:"/admin/product/edit",
		method:"post",
		enctype:"multipart/form-data"
	});	
	$("#realForm").submit();
	
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
  <div class="span10">
  	<div class="widget-box">
        <div class="widget-title"> 
          <h5>상품 상세보기</h5>
        </div>
        <div class="widget-content nopadding">
          <form id="realForm" enctype='multipart/form-data' class="form-horizontal">
          
		<input id="a_sub" name="a_subcategory_id" value="<%=product.getAsubcategory().getA_subcategory_id() %>" type="hidden">
		<input id="a_top" name="a_topcategory_id" value="<%=product.getAsubcategory().getAtopcategory().getA_topcategory_id() %>" type="hidden">
		<input id="product_id_container" name="product_id" type="hidden" value="<%=product.getProduct_id()%>">
		<input id="product_filename_container" name="filename" type="hidden" value="<%=product.getFilename()%>">
		
          <div class="control-group">
           <div class=btn-group>
              <button data-toggle="dropdown" class="btn dropdown-toggle">상위 카테고리<span class="caret"></span></button>
              <ul id="topcategory-select" class="dropdown-menu">
              	<%for(Atopcategory atopcategory : atopList){ %>
                <li><a id="select" href="#" value="<%=atopcategory.getA_topcategory_id()%>"><%=atopcategory.getName() %></a></li>
                <%} %>
                <li class="divider"></li>
                <li><a href="#" data-target="#top-add-modal" data-toggle="modal">카테고리 추가</a></li>
              </ul>
            </div>
           <div class="btn-group">
              <button data-toggle="dropdown" class="btn dropdown-toggle">하위 카테고리<span class="caret"></span></button>
              <ul id="subcategory-select" class="dropdown-menu">
              </ul>
            </div>
           </div>
           
           <!-- Modal -->
			<div class="modal fade" id="top-add-modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" style="width:250px">
			  <div class="modal-dialog" role="document">
			    <div class="modal-content">
			      <div class="modal-header">
			        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
			        <h4 class="modal-title" id="myModalLabel">탑카테고리 추가</h4>
			      </div>
			      <div class="modal-body">
			      	<label for="t_name"> 이름 </label>
			        <input id="t_name" type="text" placeholder="이름을 적어주세요"/>
			        <input value="추가" type="button" onClick="regist_topCategory()">
			      </div>
			      <div class="modal-footer">
			        <button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
			      </div>
			    </div>
			  </div>
			 </div>
			 
			 <div class="modal fade" id="sub-add-modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" style="width:250px">
			  <div class="modal-dialog" role="document">
			    <div class="modal-content">
			      <div class="modal-header">
			        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
			        <h4 class="modal-title" id="myModalLabel">하위 카테고리 추가</h4>
			      </div>
			      <div class="modal-body">
		        	<label for="s_name"> 이름 </label>
			        <input id="s_name" type="text" placeholder="이름을 적어주세요"/>
			        <input value="추가" type="button" onClick="regist_subCategory()">
			      </div>
			      <div class="modal-footer">
			        <button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
			      </div>
			    </div>
			  </div>
			 </div>
			 
			 <!-- model end -->
			 <div class="control-group">
			 
			 <!-- 대표 이미지 -->
			 <div class="widget-content">
				<ul class="thumbnails">
					<li class="span4">
					 <a > <img id="repImg_container" src="/resources/data/basic/<%=product.getProduct_id()+"."+product.getFilename()%>"> </a>
					</li>
					</ul>
					<input id="input_repImg"  type="file">
				</div>
            </div>
            
            <!-- 서브 이미지 -->
			<div class="widget-content">
				<ul class="thumbnails">
            <%if(pImageList != null){ %>
            	<%for(PImage pImage : pImageList){ %>
					<li class="span2"> <a> <img src="/resources/data/addon/<%=pImage.getP_image_id()+"."+pImage.getFilename()%>" > </a>
						<div class="actions"> <a href="javascript:deletePImage(<%=pImage.getP_image_id()%>)"><i class="icon-arrow-left"></i></a> </i></a> </div>
					</li>
				<%} %>      
			<%} %>
				</ul>
			</div>      
            
          
           
           
            <div class="control-group">
              <div class="controls">
              <span id="topCategory"> <%=product.getAsubcategory().getName() %> </span> > <span id="subCategory"> <%=product.getAsubcategory().getAtopcategory().getName()%> </span>
              </div>
            </div>
            <div class="control-group">
              <label class="control-label">상품명 </label>
              <div class="controls">
                <input type="text" class="span11" name="product_name" value="<%=product.getProduct_name() %>" />
              </div>
            </div>
            <div class="control-group">
              <label class="control-label">브랜드</label>
              <div class="controls">
                <input type="text" class="span11" name="brand" value="<%=product.getBrand() %>" />
              </div>
            </div>
            <div class="control-group">
              <label class="control-label">가격</label>
              <div class="controls">
                <input type="text"  class="span11" name="price" value="<%=product.getPrice() %>"  />
              </div>
            </div>
            <div class="control-group">
              <label class="control-label">용량</label>
              <div class="controls">
                <input type="text" class="span11" name="capacity" value="<%=product.getCapacity() %>" />
              </div>
            </div>
            <div class="control-group">
              <label class="control-label">도수</label>
              <div class="controls">
                <input type="text" class="span11" name="alchole_rate" value="<%=product.getAlchole_rate()%>"/>
              </div>
            </div>
            
            <div class="control-group">
              <label class="control-label">상세 사항</label>
              <div class="controls">
                <textarea name="detail" class="span11" ><%=product.getDetail()%></textarea>
              </div>
            </div>
            <div class="widget-title"> 
          <h5>추가 이미지(드래그 & 드롭)</h5>
        </div>
        <div id="imageContainer" class="widget-content nopadding">
          	<div id="dragArea"></div>
        </div>
        <input type="file" id="p_image">
      </div>
            <div class="form-actions">
              <button type="button" onClick="edit()" class="btn btn-success">Edit</button>
            </div>
          </form>
        </div>
      </div>
  </div>
  
  </div>
</div>

<!--end-main-container-part-->

<!--Footer-part-->
<!--end-Footer-part-->
<%@ include file="../inc/foot.jsp" %>


</body>
</html>
