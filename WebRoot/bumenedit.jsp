<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String dename=request.getParameter("dename");
dename=new String(dename.getBytes("iso-8859-1"));
String deres=request.getParameter("deres");
deres=new String(deres.getBytes("iso-8859-1"));
String deduty=request.getParameter("deduty");
deduty=new String(deduty.getBytes("iso-8859-1"));
String deup=request.getParameter("deup");
deup=new String(deup.getBytes("iso-8859-1")); 
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
<form id="submitForm" name="submitForm" action="departmentservlet?method=edit" method="post">
	<input type="hidden" name="fyID" value="${depart.id}" id="fyID"/>
	<div id="container">
		<div id="nav_links">
			当前位置：基础数据&nbsp;>&nbsp;<span style="color: #1A5CC6;">编辑</span>
			<div id="page_close">
                        <a href="javascript:parent.$.fancybox.close();">
                            <img src="${pageContext.request.contextPath}/assets/images/common/page_close.png" width="20" height="20" style="vertical-align: text-top;"/>
                        </a>
                    </div>
		</div>
		<div class="ui_content">
                    <table  cellspacing="0" cellpadding="0" width="100%" align="left" border="0">
                        <tr>
                            <td class="ui_text_rt" width="80">部门id&nbsp;&nbsp;</td>
                            <td class="ui_text_lt">
                                <input type="text" name="id" value="${param.fyid}"/>
                            </td>
                        </tr>
                        <tr>
                            <td class="ui_text_rt">部门&nbsp;&nbsp;编码</td>
                            <td class="ui_text_lt">
                                <input type="text" name="decode" value="${param.decode}"/>
                            </td>
                        </tr>
                        <tr>
                            <td class="ui_text_rt">部门&nbsp;&nbsp;名称</td>
                            <td class="ui_text_lt">
                                <input type="text" name="dename" value="<%=dename %>" />
                            </td>
                        </tr>
                        <tr>
                            <td class="ui_text_rt">部门&nbsp;负责人</td>
                            <td class="ui_text_lt">
                                <input type="text" name="deres" value="<%=deres %>"/>
                            </td>
                        </tr>
                        <tr>
                            <td class="ui_text_rt">部门&nbsp;&nbsp;职责</td>
                            <td class="ui_text_lt">
                                <input type="text" name="deduty" value="<%=deduty %>"/>
                            </td>
                        </tr>
                        <tr>
                            <td class="ui_text_rt">上级&nbsp;&nbsp;部门</td>
                            <td class="ui_text_lt">
                                <input type="text" name="deup" value="<%=deup %>"/>
                            </td>
                        </tr>
                        
                            <td>&nbsp;</td>
                            <td class="ui_text_lt">
                                &nbsp;<button id="submitbutton" type="submit"  class="ui_input_btn01" >修改</button>
<!--                                &nbsp;<input id="cancelbutton" type="button" value="取消" class="ui_input_btn01"/>-->
                            </td>
                        </tr>
                    </table>
                </div>
	
</form>

</body>
</html>