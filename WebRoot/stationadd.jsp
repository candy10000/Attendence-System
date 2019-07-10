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
    </head>
    <body >
        <form id="submitForm" name="submitForm" action="stationservlet?method=add" method="post" >
            <input type="hidden" name="fyID" value="14458625716623" id="fyID"/>
            <div id="container">
                <div id="nav_links">
                    当前位置：部门&nbsp;>&nbsp;<span style="color: #1A5CC6;">添加</span>
                    <div id="page_close">
                        <a href="javascript:parent.$.fancybox.close();">
                            <img src="${pageContext.request.contextPath}/assets/images/common/page_close.png" width="20" height="20" style="vertical-align: text-top;"/>
                        </a>
                    </div>
                </div>
                <div class="ui_content">
                    <table  cellspacing="2" cellpadding="2"   width="100%" align="left" border="0">
<!--                        <tr>
                            <td class="ui_text_rt" width="80">岗位ID：</td>
                            <td class="ui_text_lt">
                                <input type="text" name="stid"  class="ui_select01" />
                            </td>
                        </tr>-->
                        <tr>
                            <td class="ui_text_rt" width="80">岗位编码：</td>
                            <td class="ui_text_lt">
                                <input type="text" name="stcode"  class="ui_select01" />
                            </td>
                        </tr>
                        <tr>
                            <td class="ui_text_rt" width="80">岗位名称</td>
                            <td class="ui_text_lt">
                                <input type="text" name="stname"  class="ui_select01" />
                            </td>
                        </tr>
                        <tr>
                            <td class="ui_text_rt" width="80">所在部门</td>
                            <td class="ui_text_lt" >
                                <select name="stdepartment"  class="ui_select01">
                                    <option value="">--请选择--</option>
                                    <option value="CWB" selected="selected">CWB</option>
                                    <option value="SCB">SCB</option>
                                    <option value="JSB">JSB</option>
                                    <option value="AS">AS</option>
                                    <option value="yy">yy</option>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td class="ui_text_rt" width="50">直接上级</td>
                            <td class="ui_text_lt" >
                                <select name="stup"  class="ui_select01">
                                    <option value="">--请选择--</option>
                                    <option value="ZCS" selected="selected">ZCS</option>
                                    <option value="CEO">CEO</option>
									<option value="ZJL">ZJL</option>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td class="ui_text_rt" width="80">岗位类别</td>
                            <td class="ui_text_lt" >
                                <select name="stclass" id="fyFh" class="ui_select01 ">
                                    <option value="">--请选择--</option>
                                    <option value="管理类" selected="selected">管理类</option>
                                    <option value="技术类">技术类</option>
                                </select>
                            </td>
                        </tr>

                        <tr>
                            <td class="ui_text_rt" width="80">岗位职责</td>
                            <td class="ui_text_lt" >
                                <textarea name="stnote" id="fyZongMj" cols="45" rows="10" ></textarea>
                            </td>
                        </tr>

                        <tr>
                            <td>&nbsp;</td>
                            <td class="ui_text_lt">
                                &nbsp;<input type="submit" value="提交" id="submitbutton"  class="ui_input_btn01" />
                                <!--                                &nbsp;<input id="cancelbutton" type="button" value="取消" class="ui_input_btn01"/>-->
                            </td>
                        </tr>
                    </table>


                </div>
            </div>
        </form>

    </body>
</html>