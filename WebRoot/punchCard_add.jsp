
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html>
<head>
<title>信息管理系统</title>
<meta http-equiv="Content-Type" content="textml; charset=UTF-8" />
<script type="text/javascript" src="${pageContext.request.contextPath}/assets/scripts/jquery/jquery-1.7.1.js"></script>
<link href="${pageContext.request.contextPath}/assets/style/authority/basic_layout.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/assets/style/authority/common_style.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="${pageContext.request.contextPath}/assets/scripts/authority/commonAll.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/assets/scripts/jquery/jquery-1.4.4.min.js"></script>
<script src="" ${pageContext.request.contextPath}/assets/scripts/My97DatePicker/WdatePicker.js" type="text/javascript" defer="defer"></script>
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
	function turnDouble(time) {
		var newTime;
		if (time < 10) {
			newTime = "0" + time;
		} else {
			newTime = time;
		}
		return newTime;
	}
	function showTime() {
		var now = new Date();
		var year = now.getFullYear();
		var month = turnDouble(now.getMonth() + 1);
		var day = turnDouble(now.getDate());
		var hours = turnDouble(now.getHours());
		var minutes = turnDouble(now.getMinutes());
		var seconds = turnDouble(now.getSeconds());
		var time = year + "-" + month + "-" + day + " " + hours + ":" + minutes
				+ ":" + seconds;
		document.getElementById("date").value = time;
	}
</script>
</head>
<body>
	<form action="PunchCardServlet?method=store" method="post">
		<div id="nav_links">
			当前位置：班次&nbsp;>&nbsp;<span style="color: #1A5CC6;">新增</span>
			<div id="page_close">
				<a href="javascript:parent.$.fancybox.close();"> <img src="assets/images/common/page_close.png" width="20" height="20" style="vertical-align: text-top;" />
				</a>
			</div>
		</div>
		<div class="box" align="center" >
			<input type="hidden" name="page" value="${param.page}" />
			<p>
				<span style="display: inline-block; width: 80px; text-align: right;"> 打卡人编码</span>
				<input type="text" name="pclock" class="ui_input_txt02" />
			</p>
			<br>
			<p>
				<span style="display: inline-block; width: 80px; text-align: right;"> 打卡人</span>
				<input type="text" name="pnote" class="ui_input_txt02" />
			</p>
			<br>
			<p>
				<span style="display: inline-block; width: 80px; text-align: right;"> <input type="button" onclick="showTime()" value="打卡" /></span>
				<input type="text" id="date" name="ptime" class="ui_input_txt02" readonly="true"/>
			</p>
			<br>
			<p>
				<span style="display: inline-block; width: 10px; button-align: right;"><input type="submit" value="提交" id="submitbutton" class="ui_input_btn01" /></span>
				</p>
		</div>
	</form>
</body>
</html>
