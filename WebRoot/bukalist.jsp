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

<style type="text/css">
table {
	border-collapse: collapse;
	margin: 0 auto;
	text-align: center;
	width: 1300px;
}

table td, table th {
	border: 1px solid #cad9ea;
	color: #666;
	height: 30px;
}

table thead th {
	height: 30px;
	line-height: 30px;
	text-align: center;
	background: #044599;
	color: #FFF;
	margin-bottom: 10px;
	font-size: 16px;
}

.button {
	background: #F5FAFA;
	border: 0px;
	height: 30px;
	width: 50px;
}

body {
	margin: 0;
	font: normal 15px "Microsoft YaHei";
	color: #0C0C0C;
	font-size: 14px;
	line-height: 20px;
}
</style>


<script type="text/javascript" src="assets/scripts/jquery/jquery-1.7.1.js"></script>
<script type="text/javascript" src="assets/scripts/jquery/jquery-1.4.4.min.js"></script>
<script type="text/javascript" src="assets/scripts/jquery/jquery.alerts.js"></script>

<!-- <script
	src="https://cdn.bootcss.com/jquery.serializeJSON/2.9.0/jquery.serializejson.js"></script> -->

<script type="text/javascript">
	var currentpage = 1;
	var totalpage = 4;
	var flag = 0;
	loadData(1);

	function loadData(currentId) {
		flag = 0;

		$.ajax({
			url : "bukaservlet?currentId=" + currentId,
			type : "post",
			dataType : 'json',
			success : function(res) {
				totalpage = res.total;
				paginatFactory(res, currentId);
			},
			error : function(res) {
				console.log(res);
			}
		/*      url: "bukaservlet",
		     type: "post",
		     dataType: 'json',
		     success: function (res) {
		    	 $("#articlelist tbody").empty(); */// 每次载入前先清空显示区域，防止数据重复显示
		/*  var users = res.people;
		  for (var i in users) {
		       var user = users[i];
		       var userStr = JSON.stringify(user);
		       $("#articlelist tbody").append('<tr><td>' + user.rid + '</td>'
		       + '<td>' + user.rempid + '</td>'
		       + '<td>' + user.rdate + '</td>'
		       + '<td>' + user.rreson + '</td>'
		       + '<td><button onclick=\'showUpdateUserModal(' + userStr + ')\'>更新</button>&nbsp;'
		       + '<button onclick="deleteUser(' + user.rid + ')">删除</button></td></tr>'); */

		/*  }
		        }, error: function (res) {
		            console.log(res);
		        }
		 */
		});
	}

	//数据展现
	function paginatFactory(res, currentId) {
		var html = "";
		$("#articlelist tbody").empty();
		var users = res.users;
		var html = currentId + " 总的有: " + totalpage + "页" + "  共有数据"
				+ res.utotal + "条";
		$("#showCurrentPage")[0].innerHTML = html;

		//var users = res.people;
		for ( var i in users) {
			var user = users[i];
			var userStr = JSON.stringify(user);
			$("#articlelist tbody").append(
					'<tr><th>' + user.rid + '</th>' + '<th>' + user.rempid
							+ '</th>' + '<th>' + user.rdate + '</th>' + '<th>'
							+ user.rreson + '</th>'

							+ '<th><button onclick="deleteUser(' + user.rid
							+ ')">删除</button></th></tr>');
		}
	}

	function deleteUser(id) {
		// 将id封装为JSON格式数据
		var data = {};
		data.id = id;
		var dataStr = JSON.stringify(data);
		// 显示删除用户模态框

		$.ajax({
			type : "post",
			url : "bukaservlet?action=del&rid=" + id,
			//data: dataStr,
			dataType : "json",
			success : function(data) {
				if (data.isSuccess) {

					alert("删除成功")
					loadData(currentpage)
				} else {
					alert("删除失败")
					loadData(currentpage)
				}
			},
			error : function() {
				console.log("ajax error");
			},
		});
	}

	$(function() {
		$(".button").click(
				function() {
					var name = $(this).val();

					if (name == "首页") {
						currentpage = 1;
					} else if (name == "上一页") {
						currentpage = --currentpage > 1 ? currentpage : 1;
					} else if (name == "下一页") {
						currentpage = ++currentpage > totalpage ? totalpage
								: currentpage;
					} else if (name == "尾页") {
						currentpage = totalpage;
					}

					if (flag == "0") {
						loadData(currentpage);
					} else if (flag == "1") {
						search(currentpage);
					}

				});
	});

	function add() {
		// 将id封装为JSON格式数据

		var user = $("#add-user-form").serializeJSON();
		var userStr = JSON.stringify(user);

		$.ajax({
			type : "post",
			url : "bukaservlet?action=add",
			data : userStr,
			dataType : "json",
			success : function(data) {
				if (data.isSuccess) {
					$("#add-user-modal").dialog("close");
					alert("添加成功")
					loadData(currentpage)
				} else {
					$("#add-user-modal").dialog("close");
					alert("添加失败")
					loadData(currentpage)
				}
			},
			error : function() {
				console.log("ajax error");
			},
		});
	}
</script>
</head>

<body>
	<div id="add-user-modal" title="添加用户" style="display: none;">
		<form id="add-user-form">
			<table class="modal-tbl">
				<tr>
					<td>补卡人</td>
					<td><input type="text" name="rempid"></td>
				</tr>
				<tr>
					<td>补卡时间</td>
					<td><input type="text" name="rdate"></td>
				</tr>

				<tr>
					<td>补卡信息</td>
					<td><input type="text" name="rreson"></td>
				</tr>
			</table>
		</form>
	</div>
	<a href="bukaadd.jsp">添加</a>
	<table border="1" id="articlelist">
		<thead>
			<tr>
				<th>id</th>
				<th>补卡人</th>
				<th>补卡时间</th>
				<th>负责人</th>
				<th>操作</th>
			</tr>
		</thead>
		<tbody>
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

	<div>
		<input type="button" class="button" value="首页">
		<input type="button" class="button" value="上一页">
		<input type="button" class="button" value="下一页">
		<input type="button" class="button" value="尾页">
		<a>当前页码: <span id="showCurrentPage">1</span></a>
	</div>

</body>
</html>
