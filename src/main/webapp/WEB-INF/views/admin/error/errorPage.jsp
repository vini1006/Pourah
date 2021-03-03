<%@page import="com.viniv.pourah.model.domain.MessageData"%>
<%@ page contentType="text/html;charset=utf-8"%>
<%
	MessageData messageData = (MessageData) request.getAttribute("messageData");
%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>Admin Error occured!</title>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />

</head>
<body>
<%@ include file="../inc/head.jsp" %>
<!--Header-part-->
<div id="header">
  <h1><a href="dashboard.html">Matrix Admin</a></h1>
</div>
<!--close-Header-part--> 

<!--top-Header-menu-->

<!--start-top-serch-->
<!--close-top-serch--> 
<!--sidebar-menu-->
<div id="content">
  <div id="content-header">
    <div id="breadcrumb"> <a href="#" title="Go to Home" class="tip-bottom"><i class="icon-home"></i> Home</a> <a href="#">Sample pages</a> <a href="#" class="current">Error</a> </div>
    <h1><%=messageData.getResultCode()%> 번 에러 발생!</h1>
  </div>
  <div class="container-fluid">
    <div class="row-fluid">
      <div class="span12">
        <div class="widget-box">
          <div class="widget-title"> <span class="icon"> <i class="icon-info-sign"></i> </span>
            <h5>Error</h5>
          </div>
          <div class="widget-content">
            <div class="error_ex">
              <h1>Error</h1>
              <h3><%=messageData.getMsg() %></h3>
              <a class="btn btn-warning btn-big"  href="<%=messageData.getUrl()%>">Go Back</a> </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>
<!--Footer-part-->
<div class="row-fluid">
  <div id="footer" class="span12"> 2013 &copy; Matrix Admin. Brought to you by <a href="http://themedesigner.in">Themedesigner.in</a> </div>
</div>
<!--end-Footer-part-->
<script src="js/jquery.min.js"></script> 
<script src="js/jquery.ui.custom.js"></script> 
<script src="js/bootstrap.min.js"></script> 
<script src="js/maruti.js"></script>
</body>
</html>
