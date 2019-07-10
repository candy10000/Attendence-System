<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<script type="text/javascript" src="${pageContext.request.contextPath}/assets/scripts/jquery/jquery-1.7.1.js"></script>
<link href="${pageContext.request.contextPath}/assets/style/authority/basic_layout.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/assets/style/authority/common_style.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="${pageContext.request.contextPath}/assets/scripts/authority/commonAll.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/assets/scripts/fancybox/jquery.fancybox-1.3.4.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/assets/scripts/fancybox/jquery.fancybox-1.3.4.pack.js"></script>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/style/authority/jquery.fancybox-1.3.4.css" media="screen"></link>
<script type="text/javascript" src="${pageContext.request.contextPath}/assets/scripts/artDialog/artDialog.js?skin=default"></script>
<title>信息管理系统</title>
<script type="text/javascript">
	$(document).ready(function(){
		/** 新增   **/
	    $("#addBtn").fancybox({
	    	'href'  : 'departmentadd.jsp',
	    	'width' : 733,
	        'height' : 530,
	        'type' : 'iframe',
	        'hideOnOverlayClick' : false,
	        'showCloseButton' : false,
	        'onClosed' : function() { 
	        	window.location.href = 'departmentservlet';
	        }
	    });
		
	    /** 导入  **/
	    $("#importBtn").fancybox({
	    	'href'  : '/xngzf/archives/importFangyuan.action',
	    	'width' : 633,
	        'height' : 260,
	        'type' : 'iframe',
	        'hideOnOverlayClick' : false,
	        'showCloseButton' : false,
	        'onClosed' : function() { 
	        	window.location.href = 'bumenlist.html';
	        }
	    });
		
	    /**编辑   **/
	    $("a.edit").fancybox({
	    	'width' : 733,
	        'height' : 530,
	        'type' : 'iframe',
	        'hideOnOverlayClick' : false,
	        'showCloseButton' : false,
	        'onClosed' : function() { 
	        	window.location.href = 'departmentservlet';
	        }
	    });
	});
	/** 用户角色   **/
	var userRole = '';

	/** 模糊查询来电用户  **/
	function search(){
		$("#submitForm").attr("action", "departmentservlet?method=search").submit();
	}

	/** 新增   **/
	function add(){
		$("#submitForm").attr("action", "/xngzf/archives/luruFangyuan.action").submit();	
	}
	 
	/** Excel导出  **/
	function exportExcel(){
		if( confirm('您确定要导出吗？') ){
			var fyXqCode = $("#fyXq").val();
			var fyXqName = $('#fyXq option:selected').text();
//	 		alert(fyXqCode);
			if(fyXqCode=="" || fyXqCode==null){
				$("#fyXqName").val("");
			}else{
//	 			alert(fyXqCode);
				$("#fyXqName").val(fyXqName);
			}
			$("#submitForm").attr("action", "deoutservlet").submit();	
		}
	}
	
	/** 删除 **/
	function del(fyID){
		// 非空判断
		if(fyID == '') return;
		/* var temp='fyID,del';
		var temparray=temp.split(',');
 */		
      var req = new XMLHttpRequest();
      req.open("post", "departmentservlet");
      
      fyID=fyID+",del";
      
      if(confirm("您确定要删除吗？")){
           req.send();
			$("#submitForm").attr("action", "${pageContext.request.contextPath}/departmentservlet?method=del&id=" + fyID).submit();			
		}
	}
	
	/** 批量删除 **/
	function batchDel(){
		if($("input[name='IDCheck']:checked").size()<=0){
			art.dialog({icon:'error', title:'友情提示', drag:false, resize:false, content:'至少选择一条', ok:true,});
			return;
		}
		// 1）取出用户选中的checkbox放入字符串传给后台,form提交
		var allIDCheck = "";
		$("input[name='IDCheck']:checked").each(function(index, domEle){
			bjText = $(domEle).parent("td").parent("tr").last().children("td").last().prev().text();
			//bjText=
// 			alert(bjText);
			// 用户选择的checkbox, 过滤掉“已审核”的，记住哦
			if($.trim(bjText)=="已审核"){
// 				$(domEle).removeAttr("checked");
				$(domEle).parent("td").parent("tr").css({color:"red"});
				$("#resultInfo").html("已审核的是不允许您删除的，请联系管理员删除！！！");
// 				return;
			}else{
				allIDCheck += $(domEle).val() + ",";
			}
		});
		// 截掉最后一个","
		if(allIDCheck.length>0) {
			allIDCheck = allIDCheck.substring(0, allIDCheck.length-1);
			// 赋给隐藏域
			$("#allIDCheck").val(allIDCheck);
			if(confirm("您确定要批量删除这些记录吗？")){
				// 提交form
				$("#submitForm").attr("action", "departmentservlet?method=dels&page="+page).submit();
			}
		}
	}

	/** 普通跳转 **/
	function jumpNormalPage(page){
		$("#submitForm").attr("action", "departmentservlet?page=" + page).submit();
	}
	
	/** 输入页跳转 **/
	function jumpInputPage(totalPage){
		// 如果“跳转页数”不为空
		if($("#jumpNumTxt").val() != ''){
			var pageNum = parseInt($("#jumpNumTxt").val());
			// 如果跳转页数在不合理范围内，则置为1
			if(pageNum<1 | pageNum>totalPage){
				art.dialog({icon:'error', title:'友情提示', drag:false, resize:false, content:'请输入合适的页数，\n自动为您跳到首页', ok:true,});
				pageNum = 1;
			}
			$("#submitForm").attr("action", "departmentservlet?page=" + pageNum).submit();
		}else{
			// “跳转页数”为空
			art.dialog({icon:'error', title:'友情提示', drag:false, resize:false, content:'请输入合适的页数，\n自动为您跳到首页', ok:true,});
			$("#submitForm").attr("action", "departmentservlet?page=" + 1).submit();
		}
	}
	
	
	
</script>
<style>
	.alt td{ background:black !important;}
</style>
</head>
<body>
	<form id="submitForm" name="submitForm" action="departmentservlet" method="post">
		<input type="hidden" name="allIDCheck" value="" id="allIDCheck"/>
		<input type="hidden" name="fangyuanEntity.fyXqName" value="" id="fyXqName"/>
		<div id="container">
			<div class="ui_content">
				<div class="ui_text_indent">
					<div id="box_border">
						<div id="box_top">搜索</div>
						<div id="box_center">
							

							<input type="text" id="findcode" name="findcode" class="ui_input_txt02" placeholder="部门编码"/>
							<input type="button" value="查询" class="ui_input_btn01" onclick="search();" /> 
						</div>
						<div id="box_bottom">
							
							<input type="button" value="新增" class="ui_input_btn01" id="addBtn" /> 
							<input type="button" value="批量删除" class="ui_input_btn01" onclick="batchDel();" /> 
							
							<input type="button" value="导出" class="ui_input_btn01" onclick="exportExcel();" />
						</div>
					</div>
				</div>
			</div>
			<div class="ui_content">
				<div class="ui_tb">
				
					<table class="table" cellspacing="0" cellpadding="0" width="100%" align="center" border="0">
						<tr>
							<th width="30"><input type="checkbox" id="all" onclick="selectOrClearAllCheckbox(this);" />
							</th>
							<th>部门</th>
							<th>部门编码</th>
							<th>部门名称</th>
							<th>部门负责人</th>
							<th>部门职责</th>
							<th>上级部门</th>
							<th>操作</th>
						</tr>
						<c:forEach items="${requestScope.departs}" var="depart">
							<tr>
								<td><input type="checkbox" name="IDCheck" value="${depart.id}" class="acb" /></td>
								<td><c:out value="${depart.id}"/></td>
								<td><c:out value="${depart.decode}"/></td>
								<td><c:out value="${depart.dename}"/></td>
								<td><c:out value="${depart.deres}"/></td>
								<td><c:out value="${depart.deduty}"/></td>
								<td><c:out value="${depart.deup}"/></td>
								<td>
									<a href="bumenedit.jsp?fyid=${depart.id}&decode=${depart.decode}&dename=${depart.dename}&deres=${depart.deres}&deduty=${depart.deduty}&deup=${depart.deup}" class="edit">编辑</a> 
									<%-- <a href="departmentservlet?id='${depart.id}'&method=delete">删除</a> --%>
									<%-- <a href="javascripe:void(0)?method=del" onclick="del('${depart.id}')">删除</a> --%>
									<a href="departmentservlet?method=del&id=${depart.id}&page=${requestScope.pageBean.currentPage}" >删除</a>
								</td>
							</tr>
					</c:forEach> 
												
					</table>
				
				
	
				</div>
				<div class="ui_tb_h30">
					<div class="ui_flt" style="height: 30px; line-height: 30px;">
						共有
						<span class="ui_txt_bold04">${requestScope.pageBean.totalCount}</span>
						条记录，当前第
						<span class="ui_txt_bold04">${requestScope.pageBean.currentPage}
						/
						${requestScope.pageBean.totalPage}</span>
						页
					</div>
					<div class="ui_frt">
						<!--    如果是第一页，则只显示下一页、尾页 -->
						
							<input type="button" value="首页" class="ui_input_btn01" 
							onclick="jumpNormalPage(1);"/>
							<input type="button" value="上一页" class="ui_input_btn01" 
							onclick="jumpNormalPage('${requestScope.pageBean.currentPage-1}');" />
							<input type="button" value="下一页" class="ui_input_btn01"
								onclick="jumpNormalPage('${requestScope.pageBean.currentPage+1}');" />
							<input type="button" value="尾页" class="ui_input_btn01"
								onclick="jumpNormalPage('${requestScope.pageBean.totalPage}');" />
						
						
						
						<!--     如果是最后一页，则只显示首页、上一页 -->
						
						转到第<input type="text" id="jumpNumTxt" class="ui_input_txt01" />页
							 <input type="button" class="ui_input_btn01" value="跳转" onclick="jumpInputPage(${requestScope.pageBean.totalPage});" />
					</div>
				</div>
			</div>
		</div>
	</form>

</body>
</html>

