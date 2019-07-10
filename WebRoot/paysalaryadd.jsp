<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<% String id = request.getParameter("id"); %>
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
.basic-grey {
	margin-left: auto;
	margin-right: auto;
	max-width: 500px;
	background: # D2E9FF;
	padding: 20px 20px 20px 20px;
	font: 12px Arial, Helvetica, sans-serif;
	color: # 666;
}

.basic-grey h1 {
	font: 24px "Trebuchet MS", Arial, Helvetica, sans-serif;
	padding: 50px 50px 10px 200px;
	display: block;
	background: # C0E1FF;
	border-bottom: 1px solid# B8DDFF;
	margin: -20px -20px 15px;
}

.basic-grey h1>span {
	display: block;
	font-size: 11px;
}

.basic-grey label>span {
	float: left;
	margin-top: 10px;
	color: # 5E5E5E;
}

.basic-grey label {
	display: block;
	margin: 0px 0px 5px;
}

.basic-grey label>span {
	float: left;
	width: 20%;
	text-align: right;
	padding-right: 15px;
	margin-top: 10px;
	font-weight: bold;
}

.basic-grey input[type="text"], .basic-grey input[type="date"] {
	color: # 888;
	width: 70%;
	padding: 0px 0px 0px 5px;
	border: 1px solid# C5E2FF;
	background: # FBFBFB;
	outline: 0;
	-webkit-box-shadow: inset 0px 1px 6px# ECF3F5;
	box-shadow: inset 0px 1px 6px# ECF3F5;
	font: 200 12px/25px Arial, Helvetica, sans-serif;
	height: 30px;
	line-height: 15px;
	margin: 2px 6px 16px 0px;
}

.basic-grey .button {
	padding: 10px 30px 10px 30px;
	width: 120px;
	height: 40px;
	background: # 66C1E4;
	border: none;
	color: # FFF;
	box-shadow: 1px 1px 1px# 4C6E91;
	-webkit-box-shadow: 1px 1px 1px# 4C6E91;
	-moz-box-shadow: 1px 1px 1px# 4C6E91;
	text-shadow: 1px 1px 1px# 5079A3;
}

.basic-grey .button:hover {
	background: # 3EB1DD;
}
</style>


<script type="text/javascript">

//判断员工是否存在
$(function () {
	$("#psempid").blur(function () {
	      var id =  $("#psempid").val();
	   	$.ajax({
	   		url:"PaySalaryServlet?action=checkid&id="+id,
	   		type:"get",
	   		dataType: 'json',
	   		success: function (res) {
				if (res.str == "0") {
					
					alert("不存在此员工,请重新输入");
				}
			},
			error: function (res) {
				alert("ajax error");
			}
	   		
	   	});
		
	});
});
//计算薪水
function countMoney() {
	var id = $("#psempid").val();
	var bdate = $("#stime").val();
	var edate = $("#etime").val();
	
   	$.ajax({
   		url:"PaySalaryServlet?action=countMoney",
   		type:"get",
   		data: {"id":id,"bdate":bdate,"edate":edate},
   		dataType: 'json',
   		success: function (res) {
   			
   			var m = res.money.toFixed(2);
			$("#money").val(m);
		},
		error: function (res) {
			alert("ajax error");
		}
   		
   	});
}
//保存数据
function save() {
	var id = $("#psempid").val();
	var bdate = $("#stime").val();
	var edate = $("#etime").val();
	var money = $("#money").val();
	var msg = id +":"+ bdate +":"+ edate +":"+ money;
	var id = $("#cid").val();
	window.location.href = "PaySalaryServlet?action=save&msg="+msg+"&id="+id;
	
}

</script>

</head>
<body>
	<form action="" method="post" class="basic-grey">
		<h1>
			添加员工薪水 <span>按照员工编号添加</span>
		</h1>
		<label> <span>员工 编码 :</span> <input type="text" id="psempid" />
		</label> <label> <span>计算开始时间:</span> <input type="date" id="stime" />
		</label> <label> <span>计算结束时间:</span> <input type="date" id="etime" />
		</label> <label> <span>薪 &nbsp;&nbsp;
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;水:</span> <input type="text" id="money" /> <input
			type="hidden" id="cid" value="<%=id %>" />

		</label> <label> <span>&nbsp;</span> &nbsp;&nbsp;
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <input type="button"
			onclick="countMoney()" value="计算薪水" class="button" /> &nbsp;&nbsp;
			&nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;
			&nbsp;&nbsp; <input type="button" onclick="save()" value="保存"
			class="button" />
		</label>
	</form>

</body>
</html>