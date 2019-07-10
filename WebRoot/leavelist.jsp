<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
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
            $(document).ready(function () {
                /** 新增   **/
                $("#addBtn").fancybox({
                    'href': 'leaveadd.jsp',
                    'width': 733,
                    'height': 530,
                    'type': 'iframe',
                    'hideOnOverlayClick': false,
                    'showCloseButton': false,
                    'onClosed': function () {
                        window.location.href = 'leaveservlet';
                    }
                });

                /**编辑   **/
                $("edit").fancybox({
                    'href': 'leaveedit.jsp',
                    'width': 733,
                    'height': 530,
                    'type': 'iframe',
                    'hideOnOverlayClick': false,
                    'showCloseButton': false,
                    'onClosed': function () {
                        window.location.href = 'leavelist.jsp';
                    }
                });
            });

            /** 用户角色   **/
            var userRole = '';

            /** 模糊查询  **/
            function search(Name) {
                if (Name == '')
                    return;
                /* var temp='fyID,del';
                 var temparray=temp.split(',');
                 */
                var name = $("#Name").val();
                var req = new XMLHttpRequest();
                req.open("post", "leaveservlet");
                req.send();
                $("#submitForm").attr("action", "${pageContext.request.contextPath}/leaveservlet?method=search&name=" + name).submit();

            }

            /** 新增   **/
            function add() {
                $("#submitForm").attr("action", "/xngzf/archives/luruFangyuan.action").submit();
            }

            /** Excel导出  **/
            function exportExcel() {
                if (confirm('您确定要导出吗？')) {
                    var fyXqCode = $("#fyXq").val();
                    var fyXqName = $('#fyXq option:selected').text();
//	 		alert(fyXqCode);
                    if (fyXqCode == "" || fyXqCode == null) {
                        $("#fyXqName").val("");
                    } else {
//	 			alert(fyXqCode);
                        $("#fyXqName").val(fyXqName);
                    }
                    $("#submitForm").attr("action", "/xngzf/archives/exportExcelFangyuan.action").submit();
                }
            }

            /** 删除 **/
            function del(fyID) {
                // 非空判断
                if (fyID == '')
                    return;
                /* var temp='fyID,del';
                 var temparray=temp.split(',');
                 */
                var req = new XMLHttpRequest();
                req.open("post", "leaveservlet");

                fyID = fyID + ",del";

                if (confirm("您确定要删除吗？")) {
                    req.send();
                    $("#submitForm").attr("action", "${pageContext.request.contextPath}/leaveservlet?method=del&id=" + fyID).submit();
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
                        $("#submitForm").attr("action", "leaveservlet?method=dels").submit();
                    }
                }

            }

            /** 普通跳转 **/
            function jumpNormalPage(page) {
                $("#submitForm").attr("action", "leaveservlet?page=" + page).submit();
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
                    $("#submitForm").attr("action", "leaveservlet?page=" + pageNum).submit();
                } else {
                    // “跳转页数”为空
                    art.dialog({icon: 'error', title: '友情提示', drag: false, resize: false, content: '请输入合适的页数，\n自动为您跳到首页', ok: true, });
                    $("#submitForm").attr("action", "leaveservlet?page=" + 1).submit();
                }
            }
        </script>
        <style>
            .alt td{ background:black !important;}
        </style>
    </head>
    <body>
        <form id="submitForm" name="submitForm" action="leaveservlet" method="post">
            <input type="hidden" name="allIDCheck" value="" id="allIDCheck"/>
            <input type="hidden" name="fangyuanEntity.fyXqName" value="" id="fyXqName"/>
            <div id="container">
                <div class="ui_content">
                    <div class="ui_content">
                        <div class="ui_text_indent">
                            <div id="box_border">
                                <div id="box_top">搜索</div>
                                <div id="box_center">

                                    <input type="text" id="Name" name="method" placeholder="员工姓名" class="ui_input_txt02"/>
                                    <input type="button" value="查询" class="ui_input_btn01" onclick="search();" /> 
                                </div>
                                <div id="box_bottom">
                                    <input type="button" value="新增" class="ui_input_btn01" id="addBtn" /> 
                                    <input type="button" value="删除" class="ui_input_btn01" onclick="batchDel();" /> 
                                    <!--                                    <input type="button" value="导入" class="ui_input_btn01" id="importBtn" />-->
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
                                    <th>ID</th>
                                    <th>员工姓名</th>
                                    <th>开始时间</th>
                                    <th>结束时间</th>
                                    <th></th>
                                </tr>
                                <c:forEach items="${leas}" var="lea">
                                    <tr>
                                        <td><input type="checkbox" name="IDCheck" value="${lea.lid}" class="acb" /></td>
                                        <td><c:out value="${lea.lid}"/></td>
                                        <td><c:out value="${lea.lname}"/></td>
                                        <td><c:out value="${lea.lstime}"/></td>
                                        <td><c:out value="${lea.letime}"/></td>
                                        <td>
                                            <a href="leaveedit.jsp?lid=${lea.lid}&lname=${lea.lname}&lstime=${lea.lstime}&letime=${lea.letime}&lnote=${lea.lnote}" class="edit">编辑</a> 
                                            <a href="leaveservlet?method=del&id=${lea.lid}" >删除</a>
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
                                <input type="button" class="ui_input_btn01" value="跳转" onclick="jumpInputPage(9);" />
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </form>

    </body>
</html>

