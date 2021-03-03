<%@page import="java.util.List"%>
<%@page import="com.viniv.pourah.model.domain.Admin"%>
<%@ page contentType="text/html;charset=utf-8"%>
<%
	String authString = (String) session.getAttribute("auth");
	Integer auth = Integer.parseInt(authString);
	Admin admin = (Admin) session.getAttribute("admin");
	List<Admin> adminList = (List) request.getAttribute("adminList");
%>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script>
	var admin_idArr = [];
	

	$(function(){
		
		$("#pwCheck").change(function(){
			if($("#pwCheck").is(":checked")){
				$("#passwd").removeAttr("readonly");
				$("#passwd").attr("name", "user_passwd");
			}else{
				$("#passwd").val("");
				$("#passwd").attr("readonly", true);
				$("#passwd").removeAttr("name");
			}
		});
	});

	function editProfile(){
		var formData = $("#editFrom").serialize();
		
		$.ajax({
	      url:"/async/admin/editAccount", 
		  type:"POST",
	      data: {
	    	  "user_name" : $("#user_name").val(),
	    	  "user_id" : $("#user_id").val(),
	    	  "user_passwd" : $("input[name='user_passwd']").val(),
	    	  "phone" : $("#phone").val(),
	    	  "email_id" : $("#email_id").val(),
	    	  "email_addr" : $("#email_addr").val(),
	    	  "admin_id" : $("#admin_id").val()
	      },
	      success: function (response) {
	    	  if(response.resultCode == 1){
	    		  alert(response.msg);
	    		  location.href = response.url;
	    	  }else{
	    		  alert(response.msg);
	    	  }
	      }
		});
	}
	function refresh(){
		location.reload();
	}
	
	function delAccount(){
		
		if(confirm("선택된 상품을 삭제하시겠습니까?")){
			$("#admin_id_container:checked").each(function(){
				admin_idArr.push($(this).val());
			});
			
			var data = new FormData(); 
			data.append("admin_idArr", admin_idArr);
			
			if(admin_idArr.length == 0){
				alert("선택된 관리자 계정이 없습니다.");
			}
				
			$.ajax({
					url : "/async/admin/delete",
					type : "post",
					contentType: false,
			        processData: false,
					data : data,
					success : function(result){
						alert(result.msg);
					}
			});
			refresh();
			}
		}
		
		

</script>
<div class="modal fade" id="indivisual-modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
	style="width:800px">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div id="form-container" class="row-fluid">
				<h2>관리자 수정</h2>
				<div class="span10">
					<div class="widget-box">
						<div class="widget-content nopadding">
							<form id="editForm" class="form-horizontal">
								<div class="form-actions">
									<button type="button" class="btn btn-success" onClick="editProfile()">!수정!</button>
									<button type="button" class="btn btn-success" data-dismiss="modal">닫기</button>
								</div>
								<input type="hidden" id="admin_id" name="admin_id" value="<%=admin.getAdmin_id()%>">
								<div class="control-group">
									<label class="control-label">이름 :</label>
									<div class="controls">
										<input type="text" id="user_name" name="user_name" class="span6" readonly
											value="<%= admin.getUser_name() %>" />
									</div>
								</div>
								<div class="control-group">
									<label class="control-label">관리자 ID:</label>
									<div class="controls">
										<input type="text" id="user_id" name="user_id" class="span6" readonly required
											value="<%=admin.getUser_id() %>" />
										<span id="id_check_sucess" style="display: none;"> 사용 가능! </span>
									</div>
								</div>
								<div class="control-group">
									<label class="control-label">관리자 PASSWORD</label>
									<div class="controls">
										<input type="password" id="passwd" class="span6" readonly
											placeholder=" 변경할 비밀번호" />
										<input id="pwCheck" type="checkbox"><span> 변경을 원하신다면 체크</span>
									</div>
								</div>
								<div class="control-group">
									<label class="control-label">핸드폰 번호:</label>
									<div class="controls">
										<input type="text" id="phone" name="phone" class="span8"
											value="<%=admin.getPhone() %>" />
									</div>
								</div>
								<div class="control-group">
									<label class="control-label">이메일:</label>
									<div class="controls">
										<input type="text" id="email_id" name="email_id" class="span5"
											value="<%=admin.getEmail_id() %>" /><span> @ </span>
										<input type="text" id="email_addr" name="email_addr" class="span5"
											value="<%=admin.getEmail_addr()%>" />
										<span class="help-block">비밀번호 분실시 이메일 발송해드릴 주소입니다.</span>
									</div>
								</div>
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

<!-- second model for admin account -->
<div class="modal fade" id="account-modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
	style="width:800px">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
			</div>
			<div class="modal-body" style="overflow:auto;">
				<div class="widget-box">
					<div class="widget-title"> <span class="icon">
							<input type="checkbox" id="title-checkbox" name="title-checkbox" />
						</span>
						<h5>관리자 계정 관리</h5>
					</div>
					<div class="widget-content nopadding">
						<table class="table table-bordered table-striped with-check">
							<thead>
								<tr>
									<th><i class="icon-resize-vertical"></i></th>
									<th> ID</th>
									<th>이름</th>
									<th>연락처</th>
									<th>이메일</th>
								</tr>
							</thead>
							<tbody>
								<%for(int i=1; i<adminList.size();i++){ %>
									<%Admin obj=adminList.get(i); %>
										<tr>
											<td><input id="admin_id_container" type="checkbox"
													value="<%=obj.getAdmin_id()%>" /></td>
											<td>
												<%=obj.getUser_id() %>
											</td>
											<td>
												<%=obj.getUser_name() %>
											</td>
											<td>
												<%=obj.getPhone() %>
											</td>
											<td class="center">
												<%=obj.getEmail_id()+"."+obj.getEmail_addr() %>
											</td>
										</tr>
										<%} %>
							</tbody>
						</table>
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
				<button type="button" class="btn btn-default" onClick="delAccount()">선택 계정 삭제</button>
			</div>
		</div>
	</div>
</div>



<div id="header">
  <h1><a href="dashboard.html">Matrix </a></h1>
</div>
<!--top-Header-menu-->

<div id="user-nav" class="navbar navbar-inverse">
  <ul class="nav">
    <li  class="dropdown" id="profile-messages" ><a title="" href="#" data-toggle="dropdown" data-target="#profile-messages" class="dropdown-toggle"><i class="icon icon-user"></i>  <span class="text">Welcome User</span><b class="caret"></b></a>
      <ul class="dropdown-menu">
        <li><a href="#"  data-target="#indivisual-modal" data-toggle="modal"><i class="icon-user"></i> My Profile</a></li>
        
        <%if(auth != null && auth == 1){ %>
        
        <li class="divider"></li>
        <li><a href="#" data-target="#account-modal" data-toggle="modal"><i class="icon-check"></i> Admin List</a></li>
        
        <%} %>
        
        <li class="divider"></li>
        <li><a href="/admin/logOut"><i class="icon-key"></i> Log Out</a></li>
      </ul>
    </li>
    <li class=""><a title="" href="/admin/logOut"><i class="icon icon-share-alt"></i> <span class="text">Logout</span></a></li>
  </ul>
</div>


			 
			 
			 
<!--close-top-Header-menu-->



