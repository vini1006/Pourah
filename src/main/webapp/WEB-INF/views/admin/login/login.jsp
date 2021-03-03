<%@ page contentType="text/html;charset=utf-8"%>
<!DOCTYPE html>
<html lang="en">
    
<head>
<title>관리자 로그인</title><meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />

<%@ include file="../logininc/head.jsp" %>

<script type="text/javascript">
	function login(){
		var formData = $("#loginform").serialize();
		
		$.ajax({
			url : "/async/admin/login",
			type : "post",
			data : formData,
			success : function(response){
				if(response.resultCode == 0){
					alert(response.msg);
					return
				}else if(response.resultCode == 1){
					alert(response.msg);
					location.href = response.url;
				}
			}
		});
		
	}
	
	function goToRegist(){
		location.href="/admin/admin_registForm"
	}
	
	function sendPasswd(){
		$.ajax({
			url : "/async/admin//forgot_passwd",
			type : "post",
			data : {
				"user_id" : $("#emailInput").val()
			},
			success : function(response){
				if(response.resultCode == 1){
					alert(response.msg);
				}else{
					alert(response.msg);
				}
				 
			}
		});	
	}
</script>
</head>
    <body>
        <div id="loginbox">            
            <form id="loginform">
				 <div class="control-group normal_text"> <h3><img src="/resources/admin/img/logo.png" alt="Logo" /></h3></div>
                <div class="control-group">
                    <div class="controls">
                        <div class="main_input_box">
                            <span class="add-on bg_lg"><i class="icon-user"> </i></span><input type="text" name="user_id" placeholder="Username" />
                        </div>
                    </div>
                </div>
                <div class="control-group">
                    <div class="controls">
                        <div class="main_input_box">
                            <span class="add-on bg_ly"><i class="icon-lock"></i></span><input type="password" name="user_passwd" placeholder="Password" />
                        </div>
                    </div>
                </div>
                <div class="form-actions">
                    <span class="pull-left"><a href="#" class="flip-link btn btn-info" id="to-recover">Lost password? </a></span>
                    <span class="pull-left"><a onClick="goToRegist()" class="btn btn-info"/>관리자 신규 등록</a></span>
                    <span class="pull-right"><a onClick="login()" class="btn btn-success" /> Login</a></span>
                </div>
            </form>
            <form id="recoverform" action="#" class="form-vertical">
				<p class="normal_text">아이디를 입력해주시면 관리자 정보와 일치하는<br>이메일로 새로운 비밀번호를<br> 전송해드리겠습니다.</p>
				
                    <div class="controls">
                        <div class="main_input_box">
                            <span class="add-on bg_lo"><i class="icon-envelope"></i></span><input id="emailInput" type="text" placeholder="Admin Account" />
                        </div>
                    </div>
               
                <div class="form-actions">
                    <span class="pull-left"><a href="#" class="flip-link btn btn-success" id="to-login">&laquo; Back to login</a></span>
                    
                    <span class="pull-right"><button class="btn btn-info" onClick="sendPasswd()"/>보내기</button></span>
                </div>
            </form>
        </div>
        
        <script src="/resources/admin/js/jquery.min.js"></script>  
        <script src="/resources/admin/js/matrix.login.js"></script> 
    </body>

</html>
