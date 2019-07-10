<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
String name=request.getParameter("name");
name=new String(name.getBytes("iso-8859-1"));

String sex=request.getParameter("sex");
sex=new String(sex.getBytes("iso-8859-1"));

String nation=request.getParameter("nation");
nation=new String(nation.getBytes("iso-8859-1"));

String cardID=request.getParameter("cardID");
cardID=new String(cardID.getBytes("iso-8859-1"));

String salary=request.getParameter("salary");
salary=new String(salary.getBytes("iso-8859-1"));

String tel=request.getParameter("tel");
tel=new String(tel.getBytes("iso-8859-1"));

String sation_ID=request.getParameter("sation_ID");
sation_ID=new String(sation_ID.getBytes("iso-8859-1"));

String detail=request.getParameter("detail");
detail=new String(detail.getBytes("iso-8859-1"));
%>
<!DOCTYPE html>
<html>
<head>
<title>信息管理系统</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
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
</head>
<body>
	<form id="submitForm" name="submitForm" action="EmployeeServlet?method=store" method="post">
		<input type="hidden" name="fyID" value="14458625716623" id="fyID" />
		<div id="container">
			<div id="nav_links">
				当前位置：员工&nbsp;>&nbsp;<span style="color: #1A5CC6;">编辑</span>
				<div id="page_close">
					<a href="javascript:parent.$.fancybox.close();"> <img src="assets/images/common/page_close.png" width="20" height="20" style="vertical-align: text-top;" />
					</a>
				</div>
			</div>
			<div class="ui_content" style="text-align: center">
				<table cellspacing="0" cellpadding="0" width="100%" align="left" border="0">
					<input type="hidden" name="page" value="${param.page}" />
					<tr>
						<td class="ui_text_rt" width="80">员工编码&nbsp;&nbsp;</td>
						<td class="ui_text_lt"><input type="text" name="id" value="${param.id}" class="ui_input_txt02"/></td>
					</tr>
					<tr>
						<td class="ui_text_rt">姓名&nbsp;&nbsp;</td>
						<td class="ui_text_lt"><input type="text" name="name" value="<%=name %>" class="ui_input_txt02"/></td>
					</tr>
					<tr>
						<td class="ui_text_rt">性别&nbsp;&nbsp;</td>
						<td class="ui_text_lt"><input type="text" name="sex" value="<%=sex %>" class="ui_input_txt02"/></td>
					</tr>
					<tr>
						<td class="ui_text_rt">年龄&nbsp;&nbsp;</td>
						<td class="ui_text_lt"><input type="text" name="age" value="${param.age}" class="ui_input_txt02"/></td>
					</tr>
					<tr>
						<td class="ui_text_rt">民族&nbsp;&nbsp;</td>
						<td class="ui_text_lt"><input type="text" name="nation" value="<%=nation %>" class="ui_input_txt02"/></td>
					</tr>
					<tr>
						<td class="ui_text_rt">身份证&nbsp;&nbsp;</td>
						<td class="ui_text_lt"><input type="text" name="cardID" value="<%=cardID %>" class="ui_input_txt02"/></td>
					</tr>
					<tr>
						<td class="ui_text_rt">薪水&nbsp;&nbsp;</td>
						<td class="ui_text_lt"><input type="text" name="salary" value="<%=salary %>" class="ui_input_txt02"/></td>
					</tr>
					<tr>
						<td class="ui_text_rt">联系电话&nbsp;&nbsp;</td>
						<td class="ui_text_lt"><input type="text" name="tel" value="<%=tel %>" class="ui_input_txt02"/></td>
					</tr>
					<tr>
						<td class="ui_text_rt">岗位</td>
						<td class="ui_text_lt"><select name="sation_ID" id="submitForm_fangyuanEntity_fyHxCode" class="ui_select01">
								<option value="<%=sation_ID %>"  selected="selected"  ></option>
								<option selected="selected"  value="总经理">总经理</option>
								<option value="财务">财务</option>
								<option value="前台">前台</option>
								<option value="副经理">副经理</option>
					</tr>
					<tr>
						<td class="ui_text_rt" align="right" valign="top">个人描述&nbsp;&nbsp;</td>
						<td class="ui_text_lt"><input type="text" name="detail" value="<%=detail %>" style="width: 200px; height: 50px;" class="ui_input_txt02"/></td>
					</tr>
					<tr>
						<td>&nbsp;</td>
						<td class="ui_text_lt">&nbsp;<input type="submit" value="提交" id="submitbutton" class="ui_input_btn01" /> <!--                                &nbsp;<input id="cancelbutton" type="button" value="取消" class="ui_input_btn01"/>-->
						</td>
					</tr>
				</table>
			</div>
		</div>
	</form>

</body>
</html>