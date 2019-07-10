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
        <form id="submitForm" name="submitForm" action="leaveservlet?method=edit" method="post">
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
                                                    <td class="ui_text_rt" width="80">岗位ID：</td>
                                                    <td class="ui_text_lt">
                                                        
                                                        <input type="text" name="stid"  class="ui_select01" value="${stid}"/>
                                                    </td>
                                                </tr>-->
                        <tr>
                            <td class="ui_text_rt" width="80">请假人：</td>
                            <td class="ui_text_lt" >
                                <%
                                    try {
                                        String stid1 = null;
                                        stid1 = request.getParameter("lid");
                                        int lid = Integer.parseInt(stid1);
                                        session.setAttribute("lid", lid);
                                    } catch (Exception e) {
                                        e.printStackTrace();
                                    }

                                %> 
                                <input type="hidden" name="lid"   value="${lid}" width="200"/>
                                <%                                    
                                    try {
                                        String lname = request.getParameter("lname");
                                        session.setAttribute("lname", lname);
                                    } catch (Exception e) {
                                        e.printStackTrace();
                                    }

                                %>
                                <input type="text" name="lname"   value="${lname}"  />
                            </td>
                        </tr>
                        <tr>
                            <td class="ui_text_rt" width="80">请假时间：</td>
                            <td class="ui_text_lt">
                                <%                                    
                                    String ls = null;
                                    try {
                                        String lstime = request.getParameter("lstime");
                                        String[] lstime1 = lstime.split(" ");
                                        ls = lstime1[0] + " " + lstime1[1];
                                        session.setAttribute("ls", ls);

                                    } catch (Exception e) {
                                        e.printStackTrace();
                                    }
                                    String ls1 = null;
                                    if (ls != null) {
                                        ls1 = ls;
                                    }
                                %>
<!--                                <input type="datetime-local" name="lstime"  class="ui_select01" value="${lstime}" />-->
                                <input type="datetime-local" name="lstime"  id="Leave_Start_Time"  value="<%=ls1%>" />
                            </td>
                        </tr>
                        <tr>
                            <td class="ui_text_rt" width="80"></td>
                            <td class="ui_text_lt" >
                                <%
                                    String le = null;
                                    try {
                                        String letime = request.getParameter("letime");
                                        String[] letime1 = letime.split(" ");
                                        le = letime1[0] + " " + letime1[1];
                                        session.setAttribute("le", le);
                                    } catch (Exception e) {
                                        e.printStackTrace();
                                    }
                                    String le1 = null;
                                    if (le != null) {
                                        le1 = le;
                                    }
                                %>

                                <input  type="datetime-local" name="letime"  onblur='onblus()' id="Leave_End_Time"  value="<%=le1%>">                            
                            </td>
                        </tr>

                        <tr>
                            <td class="ui_text_rt" width="80">请假原因：</td>
                            <td class="ui_text_lt" >
                                <%
                                    try {
                                        String lnote = request.getParameter("lnote");
                                        session.setAttribute("lnote", lnote);
                                    } catch (Exception e) {
                                        e.printStackTrace();
                                    }

                                %>
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