
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
String pnote=request.getParameter("pnote");
pnote=new String(pnote.getBytes("iso-8859-1")); 
%>
<html>
<head>
<title>信息管理系统</title>
<meta http-equiv="Content-Type" content="textml; charset=UTF-8" />
        <script type="text/javascript" src="${pageContext.request.contextPath}/assets/scripts/jquery/jquery-1.7.1.js"></script>
        <link href="${pageContext.request.contextPath}/assets/style/authority/basic_layout.css" rel="stylesheet" type="text/css">
        <link href="${pageContext.request.contextPath}/assets/style/authority/common_style.css" rel="stylesheet" type="text/css">
        <script type="text/javascript" src="${pageContext.request.contextPath}/assets/scripts/authority/commonAll.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/assets/scripts/jquery/jquery-1.4.4.min.js"></script>
        <script src="${pageContext.request.contextPath}/assets/scripts/My97DatePicker/WdatePicker.js" type="text/javascript" defer="defer"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/assets/scripts/artDialog/artDialog.js?skin=default"></script>
<script type="text/javascript">
	$(document).ready(function() {
		/*
		 * 取消
		 */
		$("#submitbutton").click(function() {
			/**  关闭弹出iframe  **/
			window.parent.$.fancybox.close();
		});
	});
</script>
<script language="javascript" type="text/javascript">
	function showTime() {
		var now = new Date();
		var year = now.getFullYear();
		var month = now.getMonth() + 1;
		var day = now.getDate();
		var hours = now.getHours();
		var minutes = now.getMinutes();
		var seconds = now.getSeconds();
		if (month < 10) {
			month = "0" + month;
		}
		var time = year + "-" + month + "-" + day + " " + hours + ":" + minutes
				+ ":" + seconds;
		document.getElementById("date").value = time;
	}
</script>
</head>
<body>
	<form action="PunchCardServlet?method=store" method="post">
		<div id="nav_links">
			当前位置：班次&nbsp;>&nbsp;<span style="color: #1A5CC6;">编辑</span>
			<div id="page_close">
				<a href="javascript:parent.$.fancybox.close();">
					<img src="assets/images/common/page_close.png" width="20" height="20" style="vertical-align: text-top;" />
				</a>
			</div>
		</div>
		<div style="text-align: center">
			<input type="hidden" name="page" value="${param.page}" />
			<input type="hidden" name="pclock" value="${param.pclock}" />
			<input type="hidden" name="pnote" value="${param.pnote}" />
			打卡人编码&nbsp;:&nbsp;
			<c:out value="${param.pclock}" />
			<br>
			<br>
			打卡人姓名&nbsp;:&nbsp;
			<c:out value="<%=pnote %>" />
			<br>
			<br>
			<input type="button" onclick="showTime()" value="打卡" />
			<input type="text" id="date" name="ptime" value="${param.ptime}" class="ui_input_txt02"/>
			<br>
			<br>
			<input type="submit" value="提交" id="submitbutton" class="ui_input_btn01"/>
		</div>
	</form>
</body>
</html>
