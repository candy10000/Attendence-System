<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.util.Date"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
             function onblus() {
            var startTime = new Date($("#Leave_Start_Time").val()).getTime();
            var endTime = new Date($("#Leave_End_Time").val()).getTime();
            var space = (endTime - startTime) / 1000 / 60;
            if (isNaN(startTime)) {
                alert("请输入开始时间！");
            } else {
                if (space >= 0) {
                    if (space % 30 !== 0) {
                        alert("请假的时长必须是半个小时的整数倍！");
                    }
                } else {
                    alert("请假的结束时间必须晚于开始时间！");
                }

            }
        }
            
        </script>
    </head>
    <body>
        <form id="submitForm" name="submitForm" action="leaveservlet?method=add" method="post">
            <div id="container">
                <div id="nav_links">
                    当前位置：部门&nbsp;>&nbsp;<span style="color: #1A5CC6;">添加</span>
                    <div id="page_close">
                        <a href="javascript:parent.$.fancybox.close();">
                            <img src="images/common/page_close.png" width="20" height="20" style="vertical-align: text-top;"/>
                        </a>
                    </div>
                </div>
                <div class="ui_content">
                    <table  cellspacing="2" cellpadding="2"   width="100%" align="left" border="0">
<!--                        <tr>
                            <td class="ui_text_rt" width="80">ID：</td>
                            <td class="ui_text_lt">

                                <input type="text" name="lid"  />
                            </td>
                        </tr>-->
                        <tr>
                            <td class="ui_text_rt" width="80">请假人：</td>
                            <td class="ui_text_lt">
                                <input type="text" name="lname"   value="${lname}" />
                            </td>
                        </tr>
                        <tr>
                            <%
                                DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
                                String dateStr = df.format(new Date());
                                dateStr += " ";
                                DateFormat df1 = new SimpleDateFormat("HH:mm");
                                dateStr += df1.format(new Date());

                            %>
                            <td class="ui_text_rt" width="80">请假时间：</td>
                            <td class="ui_text_lt">

<!--                                <input type="datetime-local" name="lstime"  class="ui_select01" value="${lstime}" />-->
                                <input type="datetime-local" name="lstime"  id="Leave_Start_Time"  value="<%=dateStr%>" />
                            </td>
                        </tr>
                        <tr>
                            <td class="ui_text_rt" width="80"></td>
                            <td class="ui_text_lt" >
                                <%
                                    String dateEnd = df.format(new Date());
                                    dateEnd += " ";
                                    long curren = System.currentTimeMillis();
                                    curren += 30 * 60 * 1000;
                                    DateFormat df2 = new SimpleDateFormat("HH:mm");
                                    dateEnd += df2.format(new Date(curren));
                                %>
                                <input  type="datetime-local" name="letime" onblur='onblus()' id="Leave_End_Time"  value="<%=dateEnd%>">                            
                            </td>
                        </tr>

                        <tr>
                            <td class="ui_text_rt" width="80">请假原因：</td>
                            <td class="ui_text_lt" >

                                <textarea name="lnote" id="fyZongMj" cols="45" rows="10" >${lnote}</textarea>
                            </td>
                        </tr>

                        <tr>
                            <td>&nbsp;</td>
                            <td class="ui_text_lt">
                                &nbsp;<input id="submitbutton" type="submit" value="提交" class="ui_input_btn01"/>
                                <!-- &nbsp;<input id="cancelbutton" type="button" value="取消" class="ui_input_btn01"/>-->
                            </td>
                        </tr>
                    </table>


                </div>
            </div>
        </form>

    </body>
</html>