<%@page import="com.viniv.pourah.model.domain.MessageData"%>
<%@ page contentType="text/html;charset=utf-8"%>
<%
MessageData messageData = (MessageData)request.getAttribute("messageData");
%>


<!DOCTYPE html>
<html>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script>
$(function(){
	alert(<%=messageData.getMsg()%>);
	location.href = <%=messageData.getUrl()%>;
})
</script>
<head>
<meta charset="utf-8">
<title></title>
</head>
<body>

</body>
</html>