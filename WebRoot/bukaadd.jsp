<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">

<title>My JSP 'bukalist.jsp' starting page</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

<script type="text/javascript" src="assets/scripts/jquery/jquery-1.7.1.js"></script>
<script type="text/javascript" src="assets/scripts/jquery/jquery-1.4.4.min.js"></script>

<script type="text/javascript" src="assets/scripts/jquery/jquery.alerts.js"></script>

<script src="https://cdn.bootcss.com/jquery.serializeJSON/2.9.0/jquery.serializejson.js"></script>

<script type="text/javascript">
	function add() {
		// 将id封装为JSON格式数据

		var rempid = $("#rempid").val();
		var rdate = $("#date").val();
		var rreson = $("#rreson").val();

		var id = rempid + "/" + rdate + "/" + rreson;
		//alert(id);

		/* var user = $("#add-user-form").serializeJSON();
		var userStr = JSON.stringify(user);
		 */

		$.ajax({
			type : "post",
			url : "bukaservlet?action=add&id=" + id,

			dataType : "json",
			success : function(data) {

				if (data.isSuccess) {

					alert("添加成功")
					//loadData()
					window.location.href = "bukalist.jsp";
				} else {

					alert("添加失败")
					//loadData()
				}

			},
			error : function() {
				console.log("ajax error");

			},
		});
		//return false;
	}

	function showTime() {
		var now = new Date();
		var year = now.getFullYear();
		var month = now.getMonth() + 1;
		var day = now.getDate();
		var hours = now.getHours();
		var minutes = now.getMinutes();
		var seconds = now.getSeconds();
		var time = year + "-" + month + "-" + day + " " + hours + ":" + minutes
				+ ":" + seconds;
		document.getElementById("date").value = time;
	}
</script>



</script>
</head>

<body>
	<!-- <div id="add-user-modal" title="添加用户" style="display:none;"> -->
	<form id="add-user-form">
		<table class="modal-tbl">
			<h>补卡表</h>
			<br>
			<tr>
				<td>补卡人</td>
				<td><input type="text" name="rempid" id="rempid"></td>
			</tr>
			<!-- <tr><td>补卡时间</td><td><input type="text" name="rdate" id="rdate"></td></tr> -->
			
			 补卡&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="date" name="rdate" id="date">

			<tr>
				<td>补卡负责人</td>
				<td><input type="text" name="rreson" id="rreson"></td>
			</tr>
		</table>
	</form>
	<!-- </div> -->
	<button onclick="add()">新增</button>
	<%-- <c:forEach items="${sessionScope.people}" var="peo">
		        <tr>
		           <td><input type="checkbox" name="IDCheck" value="${peo.id}" class="acb" /></td>
		           <td><c:out value="${peo.rid}"></c:out></td>
		           <td><c:out value="${peo.rempid}"></c:out></td>
		           <td><c:out value="${peo.rdate}"></c:out></td>
		           <td><c:out value="${peo.rreson}"></c:out></td>
		           <td>修改 删除</td>
		        </tr>
		    </c:forEach> --%>
	</tbody>
	</table>

</body>
</html>
