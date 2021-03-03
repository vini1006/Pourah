<%@page import="com.viniv.pourah.model.domain.Order_summary"%>
<%@page import="com.viniv.pourah.model.domain.Member"%>
<%@page import="com.viniv.pourah.model.domain.News"%>
<%@ page contentType="text/html;charset=utf-8"%>
<%

	List<News> newsList = (List) request.getAttribute("newsList1");
	List<Member> memberList = (List) request.getAttribute("memberList");
	List<Order_summary> orderList = (List) request.getAttribute("orderList");
%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>관리자 페이지</title>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />

<%@ include file="../inc/head.jsp"%>

</head>
<body>

<!--Header-part-->
<%@ include file="../inc/header.jsp" %>


<!--sidebar-menu-->
<%@ include file="../inc/sidebar.jsp" %>
<!--sidebar-menu-->

<!--main-container-part-->
<div id="content">

<!--Action boxes-->
  <div class="container-fluid">
<!--End-Action boxes-->    

<!--Chart-box-->    
    <div class="row-fluid">
      <div class="widget-box">
        <div class="widget-title bg_lg"><span class="icon"><i class="icon-signal"></i></span>
          <h5>Site Analytics</h5>
        </div>
        <div class="widget-content" >
          <div class="row-fluid">
            <div class="span9">
              <div class="chart"></div>
            </div>
            <div class="span3">
              <ul class="site-stats">
                <li class="bg_lh"><i class="icon-user"></i> <strong><%if(memberList != null ){out.print(memberList.size());}else{out.print(0);} %></strong> <small>Total Users</small></li>
                <li class="bg_lh"><i class="icon-shopping-cart"></i> <strong>656</strong> <small>Total Shop</small></li>
                <li class="bg_lh"><i class="icon-tag"></i> <strong><%if(orderList != null ){out.print(orderList.size());}else{out.print(0);} %></strong> <small>Total Orders</small></li>
              </ul>
            </div>
          </div>
        </div>
      </div>
    </div>
<!--End-Chart-box--> 
    <hr/>
    <div class="row-fluid">
      <div class="span6">
        <div class="widget-box">
          <div class="widget-title bg_ly" data-toggle="collapse" href="#collapseG2"><span class="icon"><i class="icon-chevron-down"></i></span>
            <h5>Latest Posts</h5>
          </div>
          <div class="widget-content nopadding collapse in" id="collapseG2">
          	<%if(newsList != null){ %>
	          	<%for(int i=0;i<newsList.size();i++){ %>
	          	<%News news = newsList.get(i); %>
	            <ul class="recent-posts">
	              <li>
	                <div class="user-thumb"> <img width="40" height="40" alt="User" src="/resources/admin/img/demo/av1.jpg"> </div>
	                <div class="article-post"> <span class="user-info"> By: <%=news.getWriter() %> / Date: <%= news.getRegdate() %> </span>
	                  <p><a href="<%=news.getUrl()%>"><%=news.getTitle()%> 에 글이 새로 생겼습니다!</a> </p>
	                </div>
	              </li>
	            </ul>
	            <%} %>
            <%} %>
          </div>
        </div>
      </div>
      <div class="span6">
      <!-- news 업데이트넣어보기 -->
       <div class="widget-box">
          <div class="widget-title bg_lo"  data-toggle="collapse" href="#collapseG3" > <span class="icon"> <i class="icon-chevron-down"></i> </span>
            <h5>News updates</h5>
          </div>
          <div class="widget-content nopadding updates collapse in" id="collapseG3">
            <div class="new-update clearfix"><i class="icon-ok-sign"></i>
              <div class="update-done"><a title="" href="#"><strong>Lorem ipsum dolor sit amet, consectetur adipiscing elit.</strong></a> <span>dolor sit amet, consectetur adipiscing eli</span> </div>
              <div class="update-date"><span class="update-day">20</span>jan</div>
            </div>
            <div class="new-update clearfix"> <i class="icon-gift"></i> <span class="update-notice"> <a title="" href="#"><strong>Congratulation Maruti, Happy Birthday </strong></a> <span>many many happy returns of the day</span> </span> <span class="update-date"><span class="update-day">11</span>jan</span> </div>
            <div class="new-update clearfix"> <i class="icon-move"></i> <span class="update-alert"> <a title="" href="#"><strong>Maruti is a Responsive Admin theme</strong></a> <span>But already everything was solved. It will ...</span> </span> <span class="update-date"><span class="update-day">07</span>Jan</span> </div>
            <div class="new-update clearfix"> <i class="icon-leaf"></i> <span class="update-done"> <a title="" href="#"><strong>Envato approved Maruti Admin template</strong></a> <span>i am very happy to approved by TF</span> </span> <span class="update-date"><span class="update-day">05</span>jan</span> </div>
            <div class="new-update clearfix"> <i class="icon-question-sign"></i> <span class="update-notice"> <a title="" href="#"><strong>I am alwayse here if you have any question</strong></a> <span>we glad that you choose our template</span> </span> <span class="update-date"><span class="update-day">01</span>jan</span> </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>

<!--end-main-container-part-->

<!--Footer-part-->
<!--end-Footer-part-->
<%@ include file="../inc/foot.jsp" %>

<script type="text/javascript">
  // This function is called from the pop-up menus to transfer to
  // a different page. Ignore if the value returned is a null string:
  function goPage (newURL) {

      // if url is empty, skip the menu dividers and reset the menu selection to default
      if (newURL != "") {
      
          // if url is "-", it is this page -- reset the menu:
          if (newURL == "-" ) {
              resetMenu();            
          } 
          // else, send page to designated URL            
          else {  
            document.location.href = newURL;
          }
      }
  }

// resets the menu selection upon entry to this page:
function resetMenu() {
   document.gomenu.selector.selectedIndex = 2;
}
</script>

</body>
</html>
