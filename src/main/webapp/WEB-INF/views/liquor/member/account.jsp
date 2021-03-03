<%@ page contentType="text/html;charset=utf-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">
    <title>Pour up! 계정관리</title>
    <%@ include file="../inc/head.jsp" %>
    
<!-- Daum finding address api -->
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script> 
<script type="text/javascript">

var element_layer;
var zip;
var ad1;






$(function(){
	document.getElementById('user_passwd').value = "";
	element_layer = document.getElementById('layer');
	
	$("#passwdCheck").click(function(){
		if($(this).is(":checked") == true){
			$("#user_passwd").attr("disabled",false);
		}else{
			$("#user_passwd").attr("disabled",true);
		}
	});
		
	   
	$("#emailSelect").change(function(e){
		$("#m_emailaddr").val($("#emailSelect option:selected").text()); 
	});
	
});	


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

function updateAccount(){
	if($("#user_passwd").val() == "" && $("#passwdCheck").is(':checked') == true){
		alert("비밀번호 를 적어주시거나 체크를 해제하여 주세요");
		return;
	}
	
	var data = $("#updateForm").serialize(); 
	
	$.ajax({
		url:"/async/pourah/member_update",
		type : "post",
		data : data,
		success : function(response){
			if(response.resultCode == 1){
				alert(response.msg);
				location.href=response.url;
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
	<!-- Daum Zip finder -->
	<div id="layer" style="display:none;position:fixed;overflow:hidden;z-index:1;-webkit-overflow-scrolling:touch;">
	<img src="//t1.daumcdn.net/postcode/resource/images/close.png" id="btnCloseLayer" style="cursor:pointer;position:absolute;right:-3px;top:-3px;z-index:1" onclick="closeDaumPostcode()" alt="닫기 버튼">
	</div>
	<!-- Daum Zip finder -->
	
	<section id="form"><!--form-->
		<div class="container">
			<div class="row">
				<div class="col-lg-12">
					<div class="signup-form"><!--sign up form-->
						<div class="col-sm-15">
						<h2>계정 관리!</h2>
						<form id="updateForm">
							<div class="form-one">
								<input type="text" id="user_id" name="user_id" readonly value="<%=member.getUser_id()%>" placeholder="아이디 입력.."/>
									<div class="form-one">
									</div>
								<input type="password" id="user_passwd" name="user_passwd" disabled placeholder="비밀번호 입력.."/>
								<ul>
									<li>비밀번호 수정을 원하시면 클릭해주세요.<input style="width:20px;" id="passwdCheck" type="checkbox"> </li>
								</ul>
								<input type="text" name="m_name" readonly value="<%=member.getM_name() %>" placeholder="이름입력"/>
								<input type="text" name="m_birthdate" readonly value="<%=member.getM_birthdate()%>"/>
								<input type="text" name="m_phone" value="<%=member.getM_phone()%>"/>
								
							</div>
							<div class="form-two">
								<input type="text" name="m_email" value="<%=member.getM_email()%>"/>
								<input style="margin-top:10px;" id="m_emailaddr" type="text" name="m_emailaddr" value="<%=member.getM_emailaddr()%>"/>
								<select id="emailSelect">
									<option>직접입력</option>
									<option>gmail.com</option>
									<option>naver.com</option>
									<option>daum.com</option>
								</select>
								<p style="margin-top:10px;"><label> 주소 입력</label></p>
								<div class='form-one'>
									<input type="text" id="zipcode" name="zipcode" readonly value="<%=member.getZipcode()%>">
								</div>
								<div class="form-two">
									<button value="주소검색" type="button" onClick="searchZip()">주소검색</button>
								</div>
								<input type="text" id="addr1" name="addr1" readonly value="<%=member.getAddr1() %>" placeholder="기본주소">
								<input type="text" id="addr2" name="addr2" value="<%=member.getAddr2()%>">
								<button class="com-sm-6" id="registButton" type="button" onClick="updateAccount()" class="btn btn-default">계정 수정</button>
							</div>
						</form>
						</div>
					</div><!--/sign up form-->
				</div>
			</div>
		</div>
	</section><!--/form-->
	
	
	<!--Footer-->
	<%@ include file="../inc/footer.jsp" %>
	<!--/Footer-->
	
	<%@ include file="../inc/foot.jsp" %>
  
</body>
</html>