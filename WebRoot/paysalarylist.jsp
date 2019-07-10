<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/assets/scripts/jquery/jquery-1.7.1.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/assets/scripts/jquery/jquery-1.4.4.min.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/assets/scripts/jquery/jquery.alerts.js"></script>

<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
table {
	border-collapse: collapse;
	margin: 0 auto;
	text-align: center;
	width: 1250px;
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

#searchid {
	width: 200px;
	height: 30px;
	line-height: 30px;
	margin-top: 20px;
	outline: 0;
	padding: 5px;
	border: 1px solid;
	border-color: #C0C0C0 #D9D9D9 #D9D9D9;
	border-radius: 2px;
	background: #FFF;
	box-shadow: inset 0 1px 2px rgba(0, 0, 0, 0.1), 0 1px 0
		rgba(255, 255, 255, 0.2);
	-webkit-transition: box-shadow, border-color .5s ease-in-out;
	-moz-transition: box-shadow, border-color .5s ease-in-out;
	-o-transition: box-shadow, border-color .5s ease-in-out;
}

#searchbu {
	width: 40px;
	height: 40px;
	line-height: 30px;
	text-align: center;
	border-style: none;
	cursor: pointer;
	font-family: "Microsoft YaHei", "微软雅黑", "sans-serif";
	background: url('assets/images/search.png') no-repeat center;
	background-size: 100% 100%;
}

.b { /* 按钮美化 */
	width: 150px; /* 宽度 */
	height: 30px; /* 高度 */
	border-width: 0px; /* 边框宽度 */
	border-radius: 3px; /* 边框半径 */
	background: #CCCCCC; /* 背景颜色 */
	cursor: pointer; /* 鼠标移入按钮范围时出现手势 */
	outline: none; /* 不显示轮廓线 */
	font-family: Microsoft YaHei; /* 设置字体 */
	color: white; /* 字体颜色 */
	font-size: 17px; /* 字体大小 */
}

.b:hover { /* 鼠标移入按钮范围时改变颜色 */
	background: #5599FF;
}
</style>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/paysalary.js"></script>
<script type="text/javascript">
	var currentpage = 1;
	var totalpage = 4;
	var flag = 0;
	//分页按钮判断执行响应的函数
	$(function() {
		$(".button").click(
				function() {
					var name = $(this).val();

					totalpage = $("#total").val();
					flag = $("#flag").val();
					currentpage = $("#courrentpage").val();

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
						listall(currentpage);
					} else if (flag == "1") {
						search(currentpage);
					}

				});
	});

	//查询全部内容	
	function listall(id) {
		flag = 0;
		window.location.href = "PaySalaryServlet?action=findall&id=" + id;
	};

	//添加
	function add() {
		currentpage = $("#courrentpage").val();

		window.location.href = "paysalaryadd.jsp?id=" + currentpage;
	}

	//删除
	function del(id, eid) {
		currentpage = $("#courrentpage").val();
		window.location.href = "PaySalaryServlet?action=del&eid=" + id
				+ "&idd=" + eid + "&id=" + currentpage;
	}

	//搜索
	function search(id) {
		flag = 1;

		var msg = $("#searchid").val();
		if (msg == "") {
			msg = $("#msg").val();

		}

		window.location.href = "PaySalaryServlet?action=search&msg=" + msg
				+ "&id=" + id;
	}
	//批量删除
	function pdelete() {

		currentpage = $("#courrentpage").val();
		var pList = "";
		$("[name='ckemp']").each(function() {
			if ($(this).is(':checked')) {
				pList += $(this).val() + ":";
			}
		});
		if (pList == "") {
			alert("请选择要删除的记录");
		} else {
			window.location.href = "PaySalaryServlet?action=pdel&plist="
					+ pList + "&id=" + currentpage;
		}

	}
</script>


</head>

<body>

	<input type="text" id="searchid" placeholder="请输入员工编号" />
	<input type="button" id="searchbu" onclick="search(1)" value="" />
	<br>
	<br>
	<input type="button" class="b" onclick="pdelete()" value="批量删除" />
	<input type="button" class="b" onclick="add()" value="添加" />
	<input type="button" class="b" onclick="listall(1)" value="全部" />

	<table border="1">
		<thead>
			<tr>
				<th>复选框</th>
				<th>ID</th>
				<th>员工编号</th>
				<th>姓名</th>
				<th>薪水</th>
				<th>计算的开始时间</th>
				<th>计算的结束时间</th>
				<th>操作</th>
			</tr>
		</thead>
		</tbody>

		<c:forEach var="emp" items="${tt}">
			<tr>
				<td><input type="checkbox" name="ckemp"
					value="${emp.psid},${emp.psempid}" /></td>
				<td>${emp.psid}</td>
				<td>${emp.psempid}</td>
				<td>${emp.name}</td>
				<td>${emp.pssalary}</td>
				<td>${emp.psstime}</td>
				<td>${emp.psetime}</td>
				<td><span> <a href="#"
						onclick="del('${emp.psempid}','${emp.psid}');"><img
							src="assets/images/del.png" width="30px" height="40px" alt="删除"
							title="删除" /></a>
				</span></td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div>
		<input id="first" type="button" class="button" value="首页" onclick="">
		<input id="up" type="button" class="button" value="上一页" onclick="">
		<input id="down" type="button" class="button" value="下一页" onclick="">
		<input id="end" type="button" class="button" value="尾页"> <input
			type="hidden" value="${totalpage}" id="total" /> <input type="hidden"
			value="${courrentpage}" id="courrentpage" /> <input type="hidden"
			value="${flag}" id="flag" /> <input type="hidden" value="${msg}"
			id="msg" /> <a>当前页码: <span id="showCurrentPage">${courrentpage}</span></a>
		<a>总页码: <span id="showCurrentPage">${totalpage}</span></a> <a>总数据:
			<span id="showCurrentPage">${total}</span>
		</a>

	</div>

</body>
</html>