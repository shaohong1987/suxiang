<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Complete.aspx.cs" Inherits="suxiang.mobile.Form.Complete" %>

<!DOCTYPE html>
<html>
<head>
    <title>后台管理系统</title>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link rel="stylesheet" href="../Content/css/jquery.mobile-1.4.5.min.css">
    <link href="../Content/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
    <script src="../Content/js/jquery.min.js" type="text/javascript"></script>
    <script src="../Content/js/jquery.mobile-1.4.5.min.js" type="text/javascript"></script>
    <script type="text/javascript">
        $(document).ready(function() {
            var nowdays = new Date();
            var year = nowdays.getFullYear();
            var month = nowdays.getMonth();
            if (month == 0) {
                month = 12;
                year = year - 1;
            }
            if (month < 10) {
                month = "0" + month;
            }
            $("#fmonths").val(year + "-" + month);
            $.post("../Handler/Process.ashx", { action: "GetProjects" }, function (data) {
                var json = eval(data);
                if (json.State === true) {
                    $.each(json.Data, function (i, item) {
                        $("#projectid").append("<option value='" + item['Id'] + "'>" + item['Projectname'] + "</option>");
                    });
                }
            },
                "json");
        });

        function doPost() {
            var projectid = $("#projectid").val();
            var fdate = $("#fmonths").val();
            if (projectid == '-1' || fdate.length == 0) {
                alert('请补全搜索条件.');
                return false;
            }
            $.post("../Handler/Process.ashx?action=GetCompleteForm", { ProjectId: projectid, month: fdate },
                       function (data) {
                           var json = eval(data);
                           $("table tbody").html('');
                           if (json.length == 0) {
                               $("table tbody").html("<tr><td colspan='7'>暂无数据</td></tr>");
                           } else {
                               var sum = 0;
                               var newRow;
                               $.each(json,
                                   function (i, item) {
                                       if (i == 0) {
                                           $("#lid").html(item["projectname"]);
                                       }
                                       sum += parseFloat(item["totalprice"]);
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
                                           "</td>"; 
                                       if (item["url"].indexOf("View") > 0) {
                                           newRow += "<td><a href='" + item["url"] + "' target='_self'>查看</a></td></tr>";
                                       } else {
                                           newRow += "<td><a href='" + item["url"] + "' target='_self'>处理</a></td></tr>";
                                       }
                                       $("table tbody tr:last").after(newRow);
                                   });
                               $("table tbody").html(newRow);
                           }
                       },
                       "json");
            return false;
        }

       
    </script>
</head>
<body>
    <div data-role="page">
        <div data-role="header" data-position="fixed">
            <a href="../index.aspx" target="_self"  class="ui-btn ui-btn-left ui-alt-icon ui-nodisc-icon ui-corner-all ui-btn-icon-notext ui-icon-carat-l">
                Back</a>
            <h1>
                <label id="lid">
                    已完成</label></h1>
            <a href="#searchpanel" class="ui-btn-right ui-btn ui-btn-inline ui-mini ui-corner-all  ui-btn-icon-right ui-icon-search"
                style="padding-top: 0.4em;">查询 </a>
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
                            操作
                        </th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td colspan="7">
                            请点击右上角查询按钮进行数据检索。
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
           <div data-role="panel" id="searchpanel" data-position="right" data-display="push"
            data-theme="a">
            <div data-role="content">
                <h3>
                    已处理单据查询</h3>
                <form id="laborcostForm">
                <div data-role="fieldcontain">
                    <select name="projectid" id="projectid" onchange="changepro(this.value)">
                        <option value='-1'>请选择项目</option>
                    </select>
                    <input type="text" name='fmonths' id="fmonths" data-role="date" placeholder="月份" />
                    <button data-theme="b" data-rel="close" type="button" onclick='doPost()'>
                        确认</button>
                </div>
                </form>
            </div>
        </div>
        <div data-role="footer" data-position="fixed">
            <div data-role="navbar">
                <ul>
                    <li><a href="NewForm.aspx" data-icon="gear" target='_self'>新表单</a></li>
                    <li><a href='Todo.aspx' data-icon='star'>待处理</a></li>
                    <li><a href="#" data-icon="grid" class="ui-btn-active" target='_self'>已完成</a></li>
                </ul>
            </div>
        </div>
    </div>
</body>
</html>