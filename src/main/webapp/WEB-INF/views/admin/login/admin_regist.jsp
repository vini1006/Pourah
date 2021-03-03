<%@ page contentType="text/html;charset=utf-8"%>
<!DOCTYPE html>
<html lang="en">
<link rel="stylesheet" href="/resources/admin/css/bootstrap.min.css" />
<link rel="stylesheet" href="/resources/admin/css/bootstrap-responsive.min.css" />
<link rel="stylesheet" href="/resources/admin/css/colorpicker.css" />
<link rel="stylesheet" href="/resources/admin/css/datepicker.css" />
<link rel="stylesheet" href="/resources/admin/css/uniform.css" />
<link rel="stylesheet" href="/resources/admin/css/select2.css" />
<link rel="stylesheet" href="/resources/admin/css/matrix-style.css" />
<link rel="stylesheet" href="/resources/admin/css/matrix-media.css" />
<link rel="stylesheet" href="/resources/admin/css/bootstrap-wysihtml5.css" />
<link href="/resources/admin/font-awesome/css/font-awesome.css" rel="stylesheet" />
<link href='http://fonts.googleapis.com/css?family=Open+Sans:400,700,800' rel='stylesheet' type='text/css'>
<head>
<title>관리자 신규등록</title><meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />

<style>

#form-container{
position: absolute;
   left: 300px;
   top: 50px;
}
</style>

<script type="text/javascript">

$(function(){
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
});
	


function id_overlap_check() {
    if ($('#user_id').val() == '') {
      alert('아이디를 입력해주세요.')
      return;
    }

    var id_overlap_input = document.querySelector('input[name="user_id"]');

    $.ajax({
      url:"/async/admin/overlapCheck", 
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


function registAdmin(){
	
 if ($('.username_input').attr("check_result") == "fail"){
    alert("아이디 중복체크를 해주시기 바랍니다.");
    $('.username_input').focus();
    return false;
 }
	
	$("form").attr({
		action : "/admin/admin_regist",
		method : "post"
	});
	
	$("form").submit();
}

	
</script>
</head>
    <body>
  		<div id="form-container" class="row-fluid">
    	<h2>관리자 등록</h2>
    	<div class="span8">
    	<div class="widget-box">
        <div class="widget-content nopadding">
          <form class="form-horizontal">
            <div class="control-group">
              <label class="control-label">이름 :</label>
              <div class="controls">
                <input type="text" name="user_name" class="span6" placeholder="이름" />
              </div>
            </div>
            <div class="control-group">
              <label class="control-label">관리자 ID:</label>
              <div class="controls">
                <input type="text" id="user_id" name="user_id" class="span6" check_result="fail" required placeholder="아이디" />
                <button type="button" class="btn btn-primary" id="id_overlap_button" onclick="id_overlap_check()">중복검사</button>
                <span id="id_check_sucess" style="display: none;" > 사용 가능! </span>
              </div>
            </div>
            <div class="control-group">
              <label class="control-label">관리자 PASSWORD</label>
              <div class="controls">
                <input type="password" name="user_passwd" class="span6" placeholder="비밀번호"  />
              </div>
            </div>
            <div class="control-group">
              <label class="control-label">핸드폰 번호:</label>
              <div class="controls">
                <input type="text" name="phone" class="span8" placeholder="핸드폰 번호" />
              </div>
            </div>
            <div class="control-group">
              <label class="control-label">이메일:</label>
              <div class="controls">
                <input type="text" name="email_id" class="span5" placeholder="이메일 아이디" /><span> @ </span>
                <input type="text" name="email_addr" class="span5" placeholder="이메일 주소"/>
                <span class="help-block">비밀번호 분실시 이메일 발송해드릴 주소입니다.</span> </div>
            </div>
            <div class="form-actions">
              <button type="button" class="btn btn-success" onClick="registAdmin()">등록</button>
            </div>
          </form>
        </div>
      </div>
      </div>
      </div>
    </body>

<script src="/resources/admin/js/jquery.min.js"></script> 
<script src="/resources/admin/js/jquery.ui.custom.js"></script> 
<script src="/resources/admin/js/bootstrap.min.js"></script> 
<script src="/resources/admin/js/bootstrap-colorpicker.js"></script> 
<script src="/resources/admin/js/bootstrap-datepicker.js"></script> 
<script src="/resources/admin/js/jquery.toggle.buttons.js"></script> 
<script src="/resources/admin/js/masked.js"></script> 
<script src="/resources/admin/js/jquery.uniform.js"></script> 
<script src="/resources/admin/js/select2.min.js"></script> 
<script src="/resources/admin/js/matrix.js"></script> 
<script src="/resources/admin/js/matrix.form_common.js"></script> 
<script src="/resources/admin/js/wysihtml5-0.3.0.js"></script> 
<script src="/resources/admin/js/jquery.peity.min.js"></script> 
<script src="/resources/admin/js/bootstrap-wysihtml5.js"></script> 
<script>
	$('.textarea_editor').wysihtml5();
</script>

</html>

