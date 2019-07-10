
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
            $(document).ready(function () {
                /** 新增   **/
                $("#addBtn").fancybox({
                	'href': 'employee_add.jsp?page='+${pageBean.totalPage},
                    'width': 733,
                    'height': 530,
                    'type': 'iframe',
                    'hideOnOverlayClick': false,
                    'showCloseButton': false,
                    'onClosed': function () {
                        window.location.href = 'employee_list.jsp';
                    }
                });

                /**编辑   **/
                $("a.edit").fancybox({
                    'width': 733,
                    'height': 530,
                    'type': 'iframe',
                    'hideOnOverlayClick': false,
                    'showCloseButton': false,
                    'onClosed': function () {
                        window.location.href = 'employee_list.jsp';
                    }
                });
            });
            /** 用户角色   **/
            var userRole = '';

            /** 模糊查询用户  **/
            function search() {
                var name; 
                name = document.getElementById("inputValue");
                	$("#submitForm").attr("action", "EmployeeServlet?method=search&name="+ name.value).submit();
            }

            /** 导出 **/
            function exportExcel(){
            	if( confirm('您确定要导出吗？') ){
            		$("#submitForm").attr("action", "ExportServlet?object=employee").submit();
            	}
            }
            
            /** 批量删除 **/
            function batchDel() {
                if ($("input[name='IDCheck']:checked").size() <= 0) {
                    art.dialog({icon: 'error', title: '友情提示', drag: false, resize: false, content: '至少选择一条', ok: true, });
                    return;
                }
                // 1）取出用户选中的checkbox放入字符串传给后台,form提交
                var allIDCheck = "";
                $("input[name='IDCheck']:checked").each(function (index, domEle) {
                    bjText = $(domEle).parent("td").parent("tr").last().children("td").last().prev().text();
                    // 			alert(bjText);
                    // 用户选择的checkbox, 过滤掉“已审核”的，记住哦
                    if ($.trim(bjText) == "已审核") {
                        // 				$(domEle).removeAttr("checked");
                        $(domEle).parent("td").parent("tr").css({color: "red"});
                        $("#resultInfo").html("已审核的是不允许您删除的，请联系管理员删除！！！");
                        // 				return;
                    } else {
                        allIDCheck += $(domEle).val() + ",";
                    }
                });
                // 截掉最后一个","
                if (allIDCheck.length > 0) {
                    allIDCheck = allIDCheck.substring(0, allIDCheck.length - 1);
                    // 赋给隐藏域
                    $("#allIDCheck").val(allIDCheck);
                    if (confirm("您确定要批量删除这些记录吗？")) {
                        // 提交form
                        $("#submitForm").attr("action", "EmployeeServlet?method=deleteAll&page="+${pageBean.currentPage}).submit();
                    }
                }

            }

            /** 普通跳转 **/
            function jumpNormalPage(page) {
                $("#submitForm").attr("action", "EmployeeServlet?page=" + page).submit();
            } 

            /** 输入页跳转 **/
            function jumpInputPage(totalPage) {
                // 如果“跳转页数”不为空
                if ($("#jumpNumTxt").val() != '') {
                    var pageNum = parseInt($("#jumpNumTxt").val());
                    // 如果跳转页数在不合理范围内，则置为1
                    if (pageNum < 1 | pageNum > totalPage) {
                        art.dialog({icon: 'error', title: '友情提示', drag: false, resize: false, content: '请输入合适的页数，\n自动为您跳到首页', ok: true, });
                        pageNum = 1;
                    }
                    $("#submitForm").attr("action", "EmployeeServlet?page=" + pageNum).submit();
                } else {
                    // “跳转页数”为空
                    art.dialog({icon: 'error', title: '友情提示', drag: false, resize: false, content: '请输入合适的页数，\n自动为您跳到首页', ok: true, });
                    $("#submitForm").attr("action", "EmployeeServlet?page=" + 1).submit();
                }
            }
        </script>
<style>
.alt td {
	background: black !important;
}
</style>
</head>
<body>
	<form id="submitForm" name="submitForm" action="EmployeeServlet" method="post">
		<input type="hidden" name="allIDCheck" value="" id="allIDCheck" />
		<input type="hidden" name="fangyuanEntity.fyXqName" value="" id="fyXqName" />
		<div id="container">
			<div class="ui_content">
				<div class="ui_text_indent">
					<div id="box_border">
						<div id="box_top">搜索</div>
						<div id="box_center">
							<input type="text" id="inputValue" name="employee"  placeholder="员工姓名"  class="ui_input_txt02"/>
							<input type="button" value="查询" class="ui_input_btn01"   onclick="search();" />
						</div>
						<div id="box_bottom">
							<input type="button" value="新增" class="ui_input_btn01" id="addBtn" />
							<input type="button" value="批量删除" class="ui_input_btn01" onclick="batchDel()" />
							<input type="button" value="导出" class="ui_input_btn01" id="export" onclick="exportExcel()" />
						</div>
					</div>
				</div>
			</div>
			<div class="ui_content">
				<div class="ui_tb">
					<table class="table" cellspacing="0" cellpadding="0" width="100%" align="center" border="0">
						<tr>
							<th width="30"><input type="checkbox" id="all" onclick="selectOrClearAllCheckbox(this);" /></th>
							<th>ID</th>
							<th>员工编码</th>
							<th>姓名</th>
							<th>性别</th>
							<th>年龄</th>
							<th>民族</th>
							<th>岗位</th>
							<th>操作</th>
						</tr>
						<c:forEach items="${list}" var="user">

							<tr>
								<td><input type="checkbox" name="IDCheck" value="${user.id}" class="acb" /></td>
								<td><c:out value="${user.emp_id}" /></td>
								<td><c:out value="${user.id}" /></td>
								<td><c:out value="${user.name}" /></td>
								<td><c:out value="${user.sex}" /></td>
								<td><c:out value="${user.age}" /></td>
								<td><c:out value="${user.nation}" /></td>
								<td><c:out value="${user.sation_ID}" /></td>
								<td><a href="employee_edit.jsp?emp_id=${user.emp_id}&id=${user.id}&name=${user.name}&sex=${user.sex}&age=${user.age}&nation=${user.nation}&sation_ID=${user.sation_ID}
								&page=${pageBean.currentPage}&cardID=${user.cardID}&salary=${user.salary}&tel=${user.tel}&detail=${user.detail}" class="edit" id="addBtn">编辑</a> <a
										href="EmployeeServlet?method=delete&id=${user.id}&page=${pageBean.currentPage}">删除</a></td>
							</tr>
						</c:forEach>
					</table>
				</div>
				<div class="ui_tb_h30">
					<div class="ui_flt" style="height: 30px; line-height: 30px;">
						共有 <span class="ui_txt_bold04">${pageBean.totalCount}</span> 条记录，当前第 <span class="ui_txt_bold04">${pageBean.currentPage} / ${pageBean.totalPage}</span> 页
					</div>
					<div class="ui_frt">
						<!--    如果是第一页，则只显示下一页、尾页 -->
						<c:if test="${pageBean.currentPage > 1}">
							<input type="button" value="首页" class="ui_input_btn01" onclick="jumpNormalPage(1);" />
							<input type="button" value="上一页" class="ui_input_btn01" onclick="jumpNormalPage('${pageBean.currentPage-1}');" />
						</c:if>
						<!--     如果是最后一页，则只显示首页、上一页 -->
						<c:if test="${pageBean.currentPage != pageBean.totalPage}">
							<input type="button" value="下一页" class="ui_input_btn01" onclick="jumpNormalPage('${pageBean.currentPage+1}');" />
							<input type="button" value="尾页" class="ui_input_btn01" onclick="jumpNormalPage('${pageBean.totalPage}');" />
						</c:if>

						转到第
						<input type="text" id="jumpNumTxt" class="ui_input_txt01" />
						页
						<input type="button" class="ui_input_btn01" value="跳转" onclick="jumpInputPage('${pageBean.totalPage}');" />
					</div>
				</div>
			</div>
		</div>
	</form>

</body>
</html>

