<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE html>
<html lang="zh-CN">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>SCT-后台系统</title>
<link href="${pageContext.request.contextPath}/assets/style/authority/main_css.css" rel="stylesheet" type="text/css" />
<link href="${pageContext.request.contextPath}/assets/style/authority/zTreeStyle.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="${pageContext.request.contextPath}/assets/scripts/jquery/jquery-1.7.1.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/assets/scripts/zTree/jquery.ztree.core-3.2.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/assets/scripts/authority/commonAll.js"></script>
<script type="text/javascript">
	/**退出系统**/
	function logout() {
		if (confirm("您确定要退出本系统吗？")) {
			window.location.href = "login.jsp";
		}
	}

	/**获得当前日期**/
	function getDate01() {
		var time = new Date();
		var myYear = time.getFullYear();
		var myMonth = time.getMonth() + 1;
		var myDay = time.getDate();
		if (myMonth < 10) {
			myMonth = "0" + myMonth;
		}
		document.getElementById("yue_fen").innerHTML = myYear + "." + myMonth;
		document.getElementById("day_day").innerHTML = myYear + "." + myMonth
				+ "." + myDay;
	}

	/**加入收藏夹**/
	function addfavorite() {
		var ua = navigator.userAgent.toLowerCase();
		if (ua.indexOf("360se") > -1) {
			art.dialog({
				icon : 'error',
				title : '友情提示',
				drag : false,
				resize : false,
				content : '由于360浏览器功能限制，加入收藏夹功能失效',
				ok : true,
			});
		} else if (ua.indexOf("msie 8") > -1) {
			window.external.AddToFavoritesBar(
					'${dynamicURL}/authority/loginInit.action',
					'西宁市公共租赁住房信息管理系统管理');//IE8
		} else if (document.all) {
			window.external.addFavorite(
					'${dynamicURL}/authority/loginInit.action',
					'西宁市公共租赁住房信息管理系统管理');
		} else {
			art.dialog({
				icon : 'error',
				title : '友情提示',
				drag : false,
				resize : false,
				content : '添加失败，请用ctrl+D进行添加',
				ok : true,
			});
		}
	}
</script>
<script type="text/javascript">
	/* zTree插件加载目录的处理  */
	var zTree;

	var setting = {
		view : {
			dblClickExpand : false,
			showLine : false,
			expandSpeed : ($.browser.msie && parseInt($.browser.version) <= 6) ? ""
					: "fast"
		},
		data : {
			key : {
				name : "resourceName"
			},
			simpleData : {
				enable : true,
				idKey : "resourceID",
				pIdKey : "parentID",
				rootPId : ""
			}
		},
		callback : {
			// 				beforeExpand: beforeExpand,
			// 				onExpand: onExpand,
			onClick : zTreeOnClick
		}
	};

	var curExpandNode = null;
	function beforeExpand(treeId, treeNode) {
		var pNode = curExpandNode ? curExpandNode.getParentNode() : null;
		var treeNodeP = treeNode.parentTId ? treeNode.getParentNode() : null;
		for (var i = 0, l = !treeNodeP ? 0 : treeNodeP.children.length; i < l; i++) {
			if (treeNode !== treeNodeP.children[i]) {
				zTree.expandNode(treeNodeP.children[i], false);
			}
		}
		while (pNode) {
			if (pNode === treeNode) {
				break;
			}
			pNode = pNode.getParentNode();
		}
		if (!pNode) {
			singlePath(treeNode);
		}

	}
	function singlePath(newNode) {
		if (newNode === curExpandNode)
			return;
		if (curExpandNode && curExpandNode.open == true) {
			if (newNode.parentTId === curExpandNode.parentTId) {
				zTree.expandNode(curExpandNode, false);
			} else {
				var newParents = [];
				while (newNode) {
					newNode = newNode.getParentNode();
					if (newNode === curExpandNode) {
						newParents = null;
						break;
					} else if (newNode) {
						newParents.push(newNode);
					}
				}
				if (newParents != null) {
					var oldNode = curExpandNode;
					var oldParents = [];
					while (oldNode) {
						oldNode = oldNode.getParentNode();
						if (oldNode) {
							oldParents.push(oldNode);
						}
					}
					if (newParents.length > 0) {
						for (var i = Math.min(newParents.length,
								oldParents.length) - 1; i >= 0; i--) {
							if (newParents[i] !== oldParents[i]) {
								zTree.expandNode(oldParents[i], false);
								break;
							}
						}
					} else {
						zTree.expandNode(oldParents[oldParents.length - 1],
								false);
					}
				}
			}
		}
		curExpandNode = newNode;
	}

	function onExpand(event, treeId, treeNode) {
		curExpandNode = treeNode;
	}

	/** 用于捕获节点被点击的事件回调函数  **/
	function zTreeOnClick(event, treeId, treeNode) {
		var zTree = $.fn.zTree.getZTreeObj("dleft_tab1");
		zTree.expandNode(treeNode, null, null, null, true);
		// 		zTree.expandNode(treeNode);
		// 规定：如果是父类节点，不允许单击操作
		if (treeNode.isParent) {
			// 			alert("父类节点无法点击哦...");
			return false;
		}
		// 如果节点路径为空或者为"#"，不允许单击操作
		if (treeNode.accessPath == "" || treeNode.accessPath == "#") {
			//alert("节点路径为空或者为'#'哦...");
			return false;
		}
		// 跳到该节点下对应的路径, 把当前资源ID(resourceID)传到后台，写进Session
		rightMain(treeNode.accessPath);

		if (treeNode.isParent) {
			$('#here_area').html(
					'当前位置：' + treeNode.getParentNode().resourceName
							+ '&nbsp;>&nbsp;<span style="color:#1A5CC6">'
							+ treeNode.resourceName + '</span>');
		} else {
			$('#here_area').html(
					'当前位置：系统&nbsp;>&nbsp;<span style="color:#1A5CC6">'
							+ treeNode.resourceName + '</span>');
		}
	};

	/* 上方菜单 */
	function switchTab(tabpage, tabid) {
		var oItem = document.getElementById(tabpage).getElementsByTagName("li");
		for (var i = 0; i < oItem.length; i++) {
			var x = oItem[i];
			x.className = "";
		}
		if ('left_tab1' == tabid) {
			$(document).ajaxStart(onStart).ajaxSuccess(onStop);
			// 异步加载"业务模块"下的菜单
			loadMenu('YEWUMOKUAI', 'dleft_tab1');
		} else if ('left_tab2' == tabid) {
			$(document).ajaxStart(onStart).ajaxSuccess(onStop);
			// 异步加载"系统管理"下的菜单
			loadMenu('XITONGMOKUAI', 'dleft_tab1');
		} else if ('left_tab3' == tabid) {
			$(document).ajaxStart(onStart).ajaxSuccess(onStop);
			// 异步加载"其他"下的菜单
			loadMenu('QITAMOKUAI', 'dleft_tab1');
		}
	}

	$(document).ready(function() {
		$(document).ajaxStart(onStart).ajaxSuccess(onStop);
		/** 默认异步加载"业务模块"目录  **/
		loadMenu('YEWUMOKUAI', "dleft_tab1");
		// 默认展开所有节点
		if (zTree) {
			// 默认展开所有节点
			zTree.expandAll(true);
		}
	});

	function loadMenu(resourceType, treeObj) {
		$.ajax({
			type : "POST",
			//url:"${dynamicURL}/authority/modelPart.action?resourceType=" + resourceType,
			url : "departmentservlet.java?resourceType=" + resourceType,
			dataType : "json",
			success : function(data) {
				// 如果返回数据不为空，加载"业务模块"目录
				if (data != null) {
					// 将返回的数据赋给zTree
					$.fn.zTree.init($("#" + treeObj), setting, data);
					alert(treeObj);
					zTree = $.fn.zTree.getZTreeObj(treeObj);
					if (zTree) {
						// 默认展开所有节点
						zTree.expandAll(true);
					}
				}
			}
		});

		//json表示法
		data = [ {
			"accessPath" : "",
			"checked" : false,
			"delFlag" : 0,
			"parentID" : 1,
			"resourceCode" : "",
			"resourceDesc" : "",
			"resourceGrade" : 2,
			"resourceID" : 3,
			"resourceName" : "公司架构",
			"resourceOrder" : 0,
			"resourceType" : ""
		}, {
			"accessPath" : "EmployeeServlet",
			"checked" : false,
			"delFlag" : 0,
			"parentID" : 3,
			"resourceCode" : "",
			"resourceDesc" : "",
			"resourceGrade" : 3,
			"resourceID" : 7,
			"resourceName" : "员工",
			"resourceOrder" : 0,
			"resourceType" : ""
		}, {
			"accessPath" : "stationservlet",
			"checked" : false,
			"delFlag" : 0,
			"parentID" : 3,
			"resourceCode" : "",
			"resourceDesc" : "",
			"resourceGrade" : 3,
			"resourceID" : 8,
			"resourceName" : "岗位",
			"resourceOrder" : 0,
			"resourceType" : ""
		}, {
			"accessPath" : "departmentservlet",
			"checked" : false,
			"delFlag" : 0,
			"parentID" : 3,
			"resourceCode" : "",
			"resourceDesc" : "",
			"resourceGrade" : 3,
			"resourceID" : 32,
			"resourceName" : "部门",
			"resourceOrder" : 0,
			"resourceType" : ""
		}, {
			"accessPath" : "",
			"checked" : false,
			"delFlag" : 0,
			"parentID" : 1,
			"resourceCode" : "",
			"resourceDesc" : "",
			"resourceGrade" : 2,
			"resourceID" : 77,
			"resourceName" : "考勤",
			"resourceOrder" : 0,
			"resourceType" : ""
		}, {
			"accessPath" : "PunchCardServlet",
			"checked" : false,
			"delFlag" : 0,
			"parentID" : 77,
			"resourceCode" : "",
			"resourceDesc" : "",
			"resourceGrade" : 3,
			"resourceID" : 79,
			"resourceName" : "打卡",
			"resourceOrder" : 0,
			"resourceType" : ""
		} , {
			"accessPath" : "bukalist.jsp",
			"checked" : false,
			"delFlag" : 0,
			"parentID" : 77,
			"resourceCode" : "",
			"resourceDesc" : "",
			"resourceGrade" : 3,
			"resourceID" : 78,
			"resourceName" : "补卡",
			"resourceOrder" : 0,
			"resourceType" : ""
		},{
			"accessPath" : "leaveservlet",
			"checked" : false,
			"delFlag" : 0,
			"parentID" : 77,
			"resourceCode" : "",
			"resourceDesc" : "",
			"resourceGrade" : 3,
			"resourceID" : 79,
			"resourceName" : "请假",
			"resourceOrder" : 0,
			"resourceType" : ""
		} , {
			"accessPath" : "",
			"checked" : false,
			"delFlag" : 0,
			"parentID" : 1,
			"resourceCode" : "",
			"resourceDesc" : "",
			"resourceGrade" : 2,
			"resourceID" : 7,
			"resourceName" : "统计",
			"resourceOrder" : 0,
			"resourceType" : ""
		}, {
			"accessPath" : "checkreportlist.jsp",
			"checked" : false,
			"delFlag" : 0,
			"parentID" : 7,
			"resourceCode" : "",
			"resourceDesc" : "",
			"resourceGrade" : 2,
			"resourceID" : 9,
			"resourceName" : "考勤数据",
			"resourceOrder" : 0,
			"resourceType" : ""
		}, {
			"accessPath" : "demon2.jsp",
			"checked" : false,
			"delFlag" : 0,
			"parentID" : 7,
			"resourceCode" : "",
			"resourceDesc" : "",
			"resourceGrade" : 2,
			"resourceID" : 12,
			"resourceName" : "考勤报表",
			"resourceOrder" : 0,
			"resourceType" : ""
		}, {
			"accessPath" : "PaySalaryServlet",
			"checked" : false,
			"delFlag" : 0,
			"parentID" : 7,
			"resourceCode" : "",
			"resourceDesc" : "",
			"resourceGrade" : 2,
			"resourceID" : 12,
			"resourceName" : "财务管理",
			"resourceOrder" : 0,
			"resourceType" : ""
		}];
		// 如果返回数据不为空，加载"业务模块"目录
		if (data != null) {
			// 将返回的数据赋给zTree
			$.fn.zTree.init($("#" + treeObj), setting, data);
			//              alert(treeObj);
			zTree = $.fn.zTree.getZTreeObj(treeObj);
			if (zTree) {
				// 默认展开所有节点
				zTree.expandAll(true);
			}
		}
	}

	//ajax start function
	function onStart() {
		$("#ajaxDialog").show();
	}

	//ajax stop function
	function onStop() {
		// 		$("#ajaxDialog").dialog("close");
		$("#ajaxDialog").hide();
	}
</script>
</head>


<body onload="getDate01()">
	<div id="top">
<%-- 		<div id="top_logo">
			<img alt="logo" src="${pageContext.request.contextPath}/assets/images/common/leftLogo.png" width="200" height="60" style="vertical-align: middle;">
		</div> --%>
		<div id="top_links">
			<div id="top_op">
				<ul>
					<li><img alt="当前用户" src="${pageContext.request.contextPath}/assets/images/common/user.jpg">： <span>admin</span></li>
					<li><img alt="事务月份" src="${pageContext.request.contextPath}/assets/images/common/month.jpg">： <span id="yue_fen"></span></li>
					<li><img alt="今天是" src="${pageContext.request.contextPath}/assets/images/common/date.jpg">： <span id="day_day"></span></li>
				</ul>
			</div>
			<div id="top_close">
				<a href="${pageContext.request.contextPath}/assets/javascript:void(0);" onclick="logout();" target="_parent"> <img alt="退出系统" title="退出系统" src="${pageContext.request.contextPath}/assets/images/common/close.jpg" style="position: relative; top: 10px; left: 25px;">
				</a>
			</div>
		</div>
	</div>

	<!-- side menu start -->
	<div id="side">
		<div id="left_menu">
			<div id="nav_show" style="position: absolute; bottom: 0px; padding: 10px;"></div>
		</div>

<!-- 侧边logo -->
		<div id="left_menu_cnt">
<!-- 			<div id="nav_module">
				<img src="assets/images/common/leftLogo.png" width="200" height="68" />
			</div> -->
			<div id="nav_resource">
				<ul id="dleft_tab1" class="ztree"></ul>
			</div>
		</div>
	</div>

	<!-- side menu start -->
	<div id="top_nav">
		<span id="here_area">当前位置：系统&nbsp;>&nbsp;系统介绍</span>
	</div>
	<div id="main">
		<iframe name="right" id="rightMain" src="introduce.jsp" frameborder="no" scrolling="auto" width="100%" height="100%" allowtransparency="true" />
	</div>

</body>
</html>

