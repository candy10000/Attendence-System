<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
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

.inputtext {
	width: 130px;
	height: 23px;
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

body {
	margin: 0;
	font: normal 15px "Microsoft YaHei";
	color: #0C0C0C;
	font-size: 14px;
	line-height: 20px;
}
</style>


<script type="text/javascript" src="${pageContext.request.contextPath}/assets/scripts/jquery/jquery-1.7.1.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/assets/scripts/jquery/jquery-1.4.4.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/assets/scripts/jquery/jquery.alerts.js"></script>

<script type="text/javascript">
    var currentpage = 1;
    var totalpage = 4;
    var flag=0;
      loadData(1); 
      //导出全部数据
      function exportallexcel() {
    		if (flag == 1) {
    			var id =  document.getElementById("clockid").value;
        	    var bday =  document.getElementById("bday").value;
        	    var eday =  document.getElementById("eday").value;
        	     json = id+":"+bday+":"+eday;
    			  $.ajax({
      			    type: "GET",
      			    url: "UserServlet?action=sexportallexcel&currentId=" + currentpage,
      			    data: {"detail":json},
      			    dataType: "json",
      			    async:true,
      			    success: function() {
      			    	alert("全部导出成功");
      			      },
      			      error: function() {
      			    	alert("导出失败");
      			      }
      			    }
      		  );	
    		}else if(flag == 0){	
    		
    			 $.ajax({
                     url: "UserServlet?action=pexportallexcel&currentId=" + currentpage,
                     type: "get",
                     dataType: 'json',
                     success: function (res) {
                    	 alert("全部导出成功，文件保存在F:/");
                     }, error: function (res) {
                    	 alert("导出失败");
                     }
                 });
    		}
	}
      //导出当前页面数据
      function exportexcel() {
		if (flag == 1) {
			var id =  document.getElementById("clockid").value;
    	    var bday =  document.getElementById("bday").value;
    	    var eday =  document.getElementById("eday").value;
    	     json = id+":"+bday+":"+eday;
			  $.ajax({
  			    type: "GET",
  			    url: "UserServlet?action=exportexcel&currentId=" + currentpage,
  			    data: {"detail":json},
  			    dataType: "json",
  			    async:true,
  			    success: function() {
  			    	alert("当前页面导出成功");
  			      },
  			      error: function() {
  			    	alert("导出失败");
  			      }
  			    }
  		  );	
		}else if(flag == 0){	
			
			 $.ajax({
                 url: "UserServlet?action=exportexcel1&currentId=" + currentpage,
                 type: "get",
                 dataType: 'json',
                 success: function (res) {
                	 alert("当前页面导出成功，文件保存在F:/");
                 }, error: function (res) {
                	 alert("导出失败");
                 }
             });
		}
	}
      
      //精确搜索数据
      function search(currentId) {
    	     flag=1;
    	    
    		var id =  document.getElementById("clockid").value;
    	    var bday =  document.getElementById("bday").value;
    	    var eday =  document.getElementById("eday").value;
    	     json = id+":"+bday+":"+eday;
    		 
    		  $.ajax({
    			    type: "GET",
    			    url: "UserServlet?action=search&currentId=" + currentId,
    			    data: {"detail":json},
    			    dataType: "json",
    			    async:true,
    			    success: function(data) {
    			    	totalpage = data.total;
                        paginatFactory(data, currentId);
    			      },
    			      error: function() {
    			        console.log("ajax error");
    			      }
    			    }
    		  );	  	  
    	}
      
      //分页按钮判断执行响应的函数
      $(function () {	  
    	  $(".button").click(function () {
			var name = $(this).val();
			
			 if(name =="首页"){
	     		 currentpage = 1;
	     	 }else if (name == "上一页") {
	     		 currentpage = --currentpage>1 ?currentpage:1;
	 		}else if (name == "下一页") {
	 			 currentpage = ++currentpage> totalpage ? totalpage:currentpage;
	 		}else if (name == "尾页") {
	 			currentpage = totalpage;
	 		}
			 
			 if (flag == "0") {
				 loadData(currentpage);
			}else if (flag == "1") {
			     search(currentpage);
			}
	     	
		});
	});
      
    
     
          //查询全部数据
         function loadData(currentId) {
        	  flag = 0;
        	
             $.ajax({
                 url: "UserServlet?action=page&currentId=" + currentId,
                 type: "get",
                 dataType: 'json',
                 success: function (res) {
                	 totalpage = res.total;
                     paginatFactory(res, currentId);
                 }, error: function (res) {
                     console.log(res);
                 }
             });
         }
         
   //数据展现
   function paginatFactory(res, currentId) { 
       var html = "";   
           $("#articlelist tbody").empty();      
           var users = res.users;
           var html = currentId+" 总的有: "+totalpage+"页"+"  共有数据"+res.utotal+"条";
           $("#showCurrentPage")[0].innerHTML=html;
	       
	        for (var i in users) {  
	          var user = users[i];
	          var userStr = JSON.stringify(user);
	          console.log(userStr);
	          $("#articlelist tbody").append('<tr><td>' + user.cclock + '</td>'
	            + '<td>' + user.name + '</td>'
	            + '<td>' + user.bdate + '</td>'
	            + '<td>' + user.edate+ '</td>'
	            + '<td>' + user.state+ '</td></tr>'
	          );
	   }
   } 
   
</script>
</head>
<body>
	<input type="text"  placeholder="请输入员工编号"  id="clockid" class="inputtext" />
	<input type="date" value="" id="bday" class="inputtext"  />
	<input type="date" value="" id="eday" class="inputtext"  />
	<button onclick="search('1')">搜索</button>
	<button onclick="loadData('1')">全部</button>
	<button onclick="exportexcel()">导出</button>
	<button onclick="exportallexcel()">全部导出</button>
	<table border="1" id="articlelist">
		<thead>
			<tr>
				<th>编号</th>
				<th>姓名</th>
				<th>上午</th>
				<th>下午</th>
				<th>类型</th>
			</tr>
		</thead>
		<tbody>
		</tbody>
	</table>
	<div>
		<input type="button" class="button" value="首页"> <input
			type="button" class="button" value="上一页"> <input
			type="button" class="button" value="下一页"> <input
			type="button" class="button" value="尾页"> <a>当前页码: <span
			id="showCurrentPage">1</span></a>
	</div>
</body>
</html>