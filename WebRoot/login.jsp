<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>SCT-后台系统</title>
<link
	href="${pageContext.request.contextPath}/assets/style/authority/login_css.css"
	rel="stylesheet" type="text/css" />
	
	<style type="text/css">
 .error { clear:both;display:block;color: red; padding-left: 90px; padding-bottom:5px;height:20px;float: left; font-size:12px;line-height: 20px;}


.add{  width: 128px;
       height: 44px;   
       cursor: pointer; 
         }
        
.phoKey{
 letter-spacing: 3px; 
  
  font-size:18px;}

.phoKey { background: #012246; line-height: 44px; color: #fff; border-radius: 3px;}

#login_box{

-moz-border-radius: 10px;
-webkit-border-radius: 10px;
border-radius: 10px;
}


</style>
	
<script type="text/javascript"
	src="${pageContext.request.contextPath}/assets/scripts/jquery/jquery-1.7.1.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		$("#login_sub").click(function(){
			$("#submitForm").attr("action", "loginservlet").submit();
		});
	});
	
	/*回车事件*/
	function EnterPress(e){ //传入 event 
		var e = e || window.event; 
		if(e.keyCode == 13){ 
			$("#submitForm").attr("action", "loginservlet").submit();
		} 
	} 
	
	$(document).ready(function(e){
	 	    
	    $(function(){
	        setInterval(changeImg, timeInterval);
	    });
	     
	var curIndex = 0;
	var timeInterval = 4000;
	var arr =["${pageContext.request.contextPath}/assets/images/login/login.jpg","${pageContext.request.contextPath}/assets/images/login/timg.jpg","${pageContext.request.contextPath}/assets/images/login/timg2.jpg"];
    
    
    function changeImg(){
    
    if (curIndex == arr.length - 1) {
        curIndex = 0;
    } else {
        curIndex += 1;
    }
    //设置d1的背景图片
 
      document.body.style.backgroundImage= "url("+arr[curIndex]+")";   
	     //alert(curIndex);
	  //document.body.style.backgroundImage= "url('${pageContext.request.contextPath}/assets/images/login/timg.jpg')";  
    
    
	  }
	  });
	 
	 	
	
    
</script>
<script type="text/javascript">

$(function () {
	  create_code();
	  
	  $("#code").blur(function() {
		  
		  var inputtext = $("#code").val().toLowerCase();
		  var  spantext = $("#pict").text().toLowerCase();
		  
		  if(inputtext != spantext ){
         	  alert("验证码错误");
		  }
	});
	  
	  
})

function create_code() {
	
	$(function () {
		 show_code();
	})
    function shuffle() {
        var arr = ['1', 'r', 'Q', '4', 'S', '6', 'w', 'u', 'D', 'I', 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p',
            'q', '2', 's', 't', '8', 'v', '7', 'x', 'y', 'z', 'A', 'B', 'C', '9', 'E', 'F', 'G', 'H', '0', 'J', 'K', 'L', 'M', 'N', 'O', 'P', '3', 'R',
            '5', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z'];
        return arr.sort(function () {
            return (Math.random() - .5);
        });
    };
    shuffle();
    function show_code() {
        var ar1 = '';
        var code = shuffle();
        for (var i = 0; i < 6; i++) {
            ar1 += code[i];
        }
        ;
        //var ar=ar1.join('');
      
        $("#pict").text(ar1);
        
    };
   
    $(".phoKey").click(function () {
        show_code();
    });
}

</script>
</head>
<body id="hh">
	<div id="login_center">
		<div id="login_area">
			<div id="login_box">
				<div id="login_form">
					<form id="submitForm" action="loginservlet" method="post">
						<div id="login_tip">
							<span id="login_err" class="sty_txt2"></span>
						</div>
						<div>
							用户名：<input type="text" name="username" class="username" id="name">
						</div>
						<div>
							密&nbsp;&nbsp;&nbsp;&nbsp;码：<input type="password" name="password"
								class="pwd" id="pwd" onkeypress="EnterPress(event)"
								onkeydown="EnterPress()">
						</div>
						
						<div>
						        验证码：<input type="text" id="code" class="hh"/> <span  class="add phoKey" id="pict"></span>
						</div>
						
						<div id="btn_area">
							<input type="button" class="login_btn" id="login_sub"
								value="登  录"> <input type="reset" class="login_btn"
								id="login_ret" value="重 置">
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>

</body>
</html>