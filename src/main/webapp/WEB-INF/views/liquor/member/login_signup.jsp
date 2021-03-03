<%@ page contentType="text/html;charset=utf-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">
    <title>Pour up! 로그인 및 회원가입</title>
    <%@ include file="../inc/head.jsp" %>
    
<!-- Daum finding address api -->
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script> 
<script type="text/javascript">
var element_layer;
var zip;
var ad1;




function closeDaumPostcode() {
    // iframe을 넣은 element를 안보이게 한다.
    element_layer.style.display = 'none';
}


$(function(){
	element_layer = document.getElementById('layer');
	
	 $('#user_id').change(function () {
	      $('#id_check_sucess').hide();
	      $('#id_overlap_button').show();
	      $('#user_id').attr("check_result", "fail");
	    });
	    
   $("#user_id").on("keyup", function() {
   	  $('#id_check_sucess').hide();
	      $('#id_overlap_button').show();
	      $('#user_id').attr("check_result", "fail");
   });
   
   $("#emailSelect").change(function(e){
	  $("#m_emailaddr").val($("#emailSelect option:selected").text()); 
   });
   
});
	


function id_overlap_check() {
	var userIdCheck = RegExp(/^[A-Za-z0-9_\-]{5,20}$/);
	var passwdCheck = RegExp(/^(?=.*[a-z])(?=.*[!@#$%^*()\-_=+\\\|\[\]{};:\'\",.<>\/?]).{8,50}$/);

	
	
	if(!userIdCheck.test($("#user_id").val())){
		alert("영어, 숫자로만 이루어진 5자 이상의 ID를 작성하여 주세요.");
		return;
	}
	
	
   if ($('#user_id').val() == '') {
     alert('아이디를 입력해주세요.')
     return;
   }

   var id_overlap_input = document.querySelector('input[name="user_id"]');
   

   $.ajax({
     url:"/async/pourah/overlapCheck", 
	 type:"POST",
     data: {
       'user_id': id_overlap_input.value
     },
     success: function (response) {
	   	var resultCode = response.resultCode;
	   	var msg = response.msg;
	   	
       if (resultCode == 0) {
         alert(msg);
         id_overlap_input.focus();
         return;
       } else if(resultCode == 1) {
         alert(msg);
         $('#user_id').attr("check_result", "success");
         $('#id_check_sucess').show();
         $('#id_overlap_button').hide();
         return;
      }
    }
  });
}


function registMember(){
	var userIdCheck = RegExp(/^[A-Za-z0-9_\-]{5,20}$/);
	var passwdCheck = RegExp(/^(?=.*[a-z])(?=.*[!@#$%^*()\-_=+\\\|\[\]{};:\'",.<>\/?]).{8,50}$/);
	
	var user_id = $("#user_id").val();
	var user_passwd = $("#user_passwd").val();
	
	
	if(!passwdCheck.test(user_passwd)){
		alert("비밀번호는특수문자 하나 이상 포함하고, 8자리 이상이여야 합니다.");
		return;
	}
	
	
	if($("#user_id").attr("check_result") == "fail"){
		alert("중복검사를 완료해 주세요");		
	}else{
		var data = $("#registForm").serialize();
		data += "&zipcode="+zip+"&addr1="+ad1;
		
		$.ajax({
			url : "/async/pourah/memberRegist",
			type : "post",
			data :data ,
			success : function(response){
				alert(response.msg);
				location.href=response.url;
			}
		});
	}
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


/*--------------------------------------------------------------RegistMember End*/


function memberLogin(){
	
	$.ajax({
		url : "/async/pourah/memberLogin",
		type : "post",
		data : {
			"user_id" : $("#login_user_id").val(),
			"user_passwd" : $("#login_user_passwd").val()
		},
		success : function(response){
			if(response.resultCode == 0){
				alert(response.msg);
			}else if(response.resultCode == 1 ){
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
				<div class="col-lg-2 col-sm-offset-1">
					<div class="login-form"><!--login form-->
						<h2>로그인 하기</h2>
						<form id="signInForm">
							<input  id="login_user_id" type="text" placeholder="아이디 입력" />
							<input id="login_user_passwd" type="password" placeholder="비밀번호 입력" />
							<span>
							</span>
							<button type="button" class="btn btn-default" onClick="memberLogin()">Login</button>
						</form>
					</div><!--/login form-->
				</div>
				
				
				
				
				
				<div class="col-sm-1">
					<h2 class="or">OR</h2>
				</div>
				<div class="col-lg-6">
					<div class="signup-form"><!--sign up form-->
						<div class="col-sm-15">
						<h2>회원가입 하기!</h2>
						<form id="registForm">
							<div class="form-one">
								<input type="text" id="user_id" name="user_id" check_result="fail" placeholder="아이디 입력.."/>
									<div class="form-one">
										<button class="com-sm-6" id="id_overlap_button" type="button" onClick="id_overlap_check()" class="btn btn-default">중복체크</button>
									</div>
									<div class="form-two">
										<span id="id_check_sucess" style="display: none;" > 사용 가능! </span>
									</div>
								<input type="password" id="user_passwd" name="user_passwd" placeholder="비밀번호 입력.."/>
								<input type="text" name="m_name" placeholder="이름입력"/>
								<input type="text" name="m_birthdate" placeholder="생년월일 ex) 931006"/>
								<input type="text" name="m_phone" placeholder="연락처 ex)01012341234"/>
								
							</div>
							<div class="form-two">
								<input type="text" name="m_email" placeholder="이메일 아이디 입력.."/>
								<input style="margin-top:10px;" id="m_emailaddr" type="text" name="m_emailaddr" placeholder="이메일 주소"/>
								<select id="emailSelect">
									<option>직접입력</option>
									<option>gmail.com</option>
									<option>naver.com</option>
									<option>daum.com</option>
								</select>
								<p style="margin-top:10px;"><label> 주소 입력</label></p>
								<div class='form-one'>
									<input type="text" id="zipcode" name="zipcode" disabled placeholder="우편번호 조회">
								</div>
								<div class="form-two">
									<button value="주소검색" type="button" onClick="searchZip()">주소검색</button>
								</div>
								<input type="text" id="addr1" name="addr1" disabled placeholder="기본주소">
								<input type="text" id="addr2" name="addr2" placeholder="상세주소">
								<button class="com-sm-6" id="registButton" type="button" onClick="registMember()" class="btn btn-default">회원가입</button>
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