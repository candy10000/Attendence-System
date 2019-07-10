<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>SCT-后台系统</title>
<link href="${pageContext.request.contextPath}/assets/style/authority/basic_layout.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/assets/style/authority/common_style.css" rel="stylesheet" type="text/css">
</head>
<body>
	<div id="container">
		<table class="table" cellspacing="0" cellpadding="0" width="100%" align="center"  border="0">
		    <tr>
		      <th colspan="2">系统版本</th>
		    </tr>
		    <tr>
		      <td width="100" height="30">当前版本<span class="TableRow2"></span></td>
		      <td style="text-align:left">考勤后台管理系统3.1</td>
		    </tr>
		</table>
		<table class="table" cellspacing="0" cellpadding="0" width="100%" align="center" border="0">
		    <tr>
		      <th colspan="2">系统开发 </th>
		    </tr>
		    <tr>
		      <td width="100" height="30">程序制作</td>
		      <td style="text-align:left"> 无名组</td>
		    </tr>
		    <tr>
		      <td width="100" height="30">联系方式</td>
		      <td style="text-align:left">
		      	<a href="mailto:sitename@126.com">****</a>
		      </td>
		    </tr>
		</table>
	</div>

</body>
</html>

