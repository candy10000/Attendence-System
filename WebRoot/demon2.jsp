<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>ECharts</title>
<!-- 引入 echarts.js -->
<script
	src="https://cdn.bootcss.com/echarts/4.2.1-rc1/echarts-en.common.js"></script>
<!-- <script src="echarts.min.js"></script> -->
<script type="text/javascript"
	src="${pageContext.request.contextPath}/assets/scripts/jquery/jquery-1.7.1.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/assets/scripts/jquery/jquery-1.4.4.min.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/assets/scripts/jquery/jquery.alerts.js"></script>

<script>   
        var atten=0.75;
        var unatten=0.25;
        function count() {
    	    
    		  var id =  document.getElementById("id").value;
    	      var date =  document.getElementById("month").value;   

    		  $.ajax({
    			    type: "GET",
    			    url: "CountServlet?action=count",
    			    data: {"id":id,"date":date},
    			    dataType: "json",
    			    async:true,
    			    success: function(data) {
    			    	atten = Math.round(data.atten*100)/100 ;
    			    	unatten =Math.round(data.unatten*100)/100 ; 
    			    	init();
    			      },
    			      error: function() {
    			        console.log("ajax error");
    			      }
    			    }
    		  );
		}
 
            //绘制饼图  
            function drawCircle(canvasId, data_arr, color_arr, text_arr)  
            {  
            	 
                var c = document.getElementById(canvasId);  
                var ctx = c.getContext("2d");  
               
                var radius = c.height / 2 - 20; //半径  
                var ox = radius + 20, oy = radius + 20; //圆心  
                  var width = 30, height = 10; //图例宽和高  
                var posX = ox * 2 + 20, posY = 30;   //  
                var textX = posX + width + 5, textY = posY + 10;  
                ctx.fillText(" ", textX, textY + 20 * i);  
                var startAngle = 0; //起始弧度  
                var endAngle = 0;   //结束弧度  
                for (var i = 0; i < data_arr.length; i++)  
                {  
                    //绘制饼图  
                    endAngle = endAngle + data_arr[i] * Math.PI * 2; //结束弧度  
                    ctx.fillStyle = color_arr[i];  
                    ctx.beginPath();  
                    ctx.moveTo(ox, oy); //移动到到圆心  
                    ctx.arc(ox, oy, radius, startAngle, endAngle, false);  
                    ctx.closePath();  
                    ctx.fill();  
                    startAngle = endAngle; //设置起始弧度  
  
                    //绘制比例图及文字  
                    ctx.fillStyle = color_arr[i];  
                    ctx.fillRect(posX, posY + 20 * i, width, height);  
                    ctx.moveTo(posX, posY + 20 * i);  
                    ctx.font = 'bold 12px 微软雅黑';    //斜体 30像素 微软雅黑字体  
                    ctx.fillStyle = color_arr[i]; //"#000000";  
                    var percent = text_arr[i] + "：" + 100 * data_arr[i] + "%";  
                 
                    ctx.fillText(percent, textX, textY + 20 * i);  
                }  
            }  
  
            function init() {  
                //绘制饼图  
                //比例数据和颜色  
                
                  
                var data_arr = [atten, unatten];  
                var color_arr = [ "#FFAA00", "#00AABB"];  
                var text_arr = [ "出勤", "缺勤"];  
  
                drawCircle("canvas_circle", data_arr, color_arr, text_arr);  
            }  
  
            //页面加载时执行init()函数  
            window.onload = init;  
        </script>

</head>
<body>
	<!-- 为ECharts准备一个具备大小（宽高）的Dom -->

	人员&nbsp;&nbsp;
	<input type="text"  placeholder="请输入员工编号" id="find" name="find" class="ui_input_txt02" />
	<input type="button" value="查询" class="ui_input_btn01" onclick="add();" />

	<div id="main" style="width: 600px; height: 400px;"></div>

	<input type="text"  placeholder="请输入员工编号" id="id" />
	<input type="date" value="" id="month" />
	<button onclick="count()">查看</button>
	<h3>考勤人数统计</h3>
	<p>
		<canvas id="canvas_circle" width="500" height="300"
			style="border: 2px solid #0026ff;">  
                浏览器不支持canvas  
            </canvas>
	</p>


	<script type="text/javascript">
	
    
        // 基于准备好的dom，初始化echarts实例
        var myChart = echarts.init(document.getElementById('main'));
        var arr = [];
        
            
 
   function add(){
      myChart.setOption({

			title : {
				text : '人员出勤情况'
			},
			tooltip : {},

			legend : {

				data : [ '出勤' ]
			},
			xAxis : {
				data : ["正常打卡","异常打卡"]
			},
			yAxis : {},
			series : [ {
				name : '销售量',
				type : 'bar',
				data : []
			} ]
		});

        
        //loadDATA();
        
        // 使用刚指定的配置项和数据显示图表。
        //myChart.setOption(option);
                
        var nums = []; 
        var idd =$("#find").val();
        //alert(idd);
               $.ajax({
			type : "post",
			async : true, //异步请求（同步请求将会锁住浏览器，其他操作须等请求完成才可执行）
			url : "echartservlet", //请求发送到TestServlet
			data : {"id":idd},
			dataType : "json", //返回数据形式为json

			//7.请求成功后接收数据name+num两组数据
			success : function(result) {
				//result为服务器返回的json对象
				if (result) {
					//8.取出数据存入数组
					
					var a = result.json;
                    //var b=JSON.parse(a)
					//alert(a);
					for (var i = 0; i < a.length; i++) {
						nums.push(a[i]); //迭代取出销量并填入销量数组
					}
					
					//alert(nums);

					myChart.hideLoading(); //隐藏加载动画
                    myChart.setOption({
						series : [ {
							// 根据名字对应到相应的数据
							name : '销售量',
							data : nums
						} ]
					});

				}

			},
			error : function(errorMsg) {
				//请求失败时执行该函数
				alert("图表请求数据失败!");
				myChart.hideLoading();
			}
		})
		}

     </script>


</body>