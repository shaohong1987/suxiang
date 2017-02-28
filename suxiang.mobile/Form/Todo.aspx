<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ToDo.aspx.cs" Inherits="suxiang.mobile.Form.Todo" %>
<!DOCTYPE html>
<html>
<head>
    <title>后台管理系统</title>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />   
</head>
<body>
    <div data-role="page">
      <link rel="stylesheet" href="../Content/css/jquery.mobile-1.4.5.min.css">   
      <link href="../Content/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
     
        <div data-role="header" data-position="fixed">
            <a href="../index.aspx" target="_self" class="ui-btn ui-btn-left ui-alt-icon ui-nodisc-icon ui-corner-all ui-btn-icon-notext ui-icon-carat-l">
                Back</a>
            <h1>
                <label id="lid">
                    待处理</label></h1>
            <a href="javascript:doRefresh();" class="ui-btn-right ui-btn ui-btn-inline ui-mini ui-corner-all  ui-btn-icon-right ui-icon-search"
                style="padding-top: 0.4em;">刷新 </a>
        </div>
        <div style="margin-top: 5px;">
            <table class="table table-bordered scrolltable">
                <thead>
                    <tr>
                         <th>
                            序号
                        </th>
                        <th>
                            月份
                        </th>
                        <th>
                            项目
                        </th>
                        <th>
                            单据类型
                        </th>
                        <th>
                            填表人
                        </th>
                        <th>
                            提交时间
                        </th>
                        <th>
                            状态
                        </th>
                        <th>
                            操作
                        </th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td colspan="8">
                            暂无数据
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
        <div data-role="footer" data-position="fixed">
            <div data-role="navbar">
                <ul>
                    <li><a href="NewForm.aspx" data-icon="gear" target='_self'>新表单</a></li>
                    <li><a href='#' data-icon='star' class="ui-btn-active">待处理</a></li>
                    <li><a href="Complete.aspx" data-icon="grid" target='_self'>已完成</a></li>
                </ul>
            </div>
        </div>
         <script src="../Content/js/jquery.min.js" type="text/javascript"></script>
      <script src="../Content/js/jquery.mobile-1.4.5.min.js" type="text/javascript"></script>
      <script type="text/javascript">
        function doRefresh() {
            $.post("../Handler/Process.ashx?action=GetToDoForm",
                   {},
                   function (data) {
                       var json = eval(data);
                       $("table tbody").html('');
                       if (json.length == 0) {
                           $("table tbody").html("<tr><td colspan='8'>暂无数据</td></tr>");
                       } else {
                           var newRow;
                           $.each(json,
                               function (i, item) {
                                   if (i == 0) {
                                       $("#lid").html(item["projectname"]);
                                   }
                                   newRow += "<tr>" +
                                       "<td>" +
                                       (i + 1) +
                                       "</td>" +
                                       "<td>" +
                                       item["dmonth"] +
                                       "</td>" +
                                       "<td>" +
                                       item["projectname"] +
                                       "</td>" +
                                       "<td>" +
                                       item["dtype"] +
                                       "</td>" +
                                       "<td>" +
                                       item["poster"] +
                                       "</td>" +
                                       "<td>" +
                                       item["posttime"] +
                                       "</td>" +
                                       "<td>" +
                                       item["status"] +
                                       "</td>";
                                   if (item["url"].indexOf("View") > 0) {
                                       newRow += "<td><a href='" + item["url"] + "' target='_self'>查看</a></td></tr>";
                                   } else {
                                       newRow += "<td><a href='" + item["url"] + "' target='_self'>处理</a></td></tr>";
                                   }
                                   $("table tbody tr:last").after(newRow).table("refresh");
                               });
                           $("table tbody").html(newRow).table("refresh");
                       }
                   },
                   "json");
        }

        doRefresh();
    </script>
    </div>
</body>
</html>

