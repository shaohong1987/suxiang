<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="LaborCostReport.aspx.cs"
    Inherits="suxiang.mobile.Report.LaborCostReport" %>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <title>用工成本</title>
    <link rel="stylesheet" href="../Content/css/jquery.mobile-1.4.5.min.css">
    <link href="../Content/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" href="../Content/css/jquery.mobile.datepicker.css">
    <script src="../Content/js/jquery.min.js"></script>
    <script src="../Content/js/jquery.mobile-1.4.5.min.js"></script>
    <script src="../Content/js/jquery.ui.datepicker.js"></script>
    <script src="../Content/js/jquery.mobile.datepicker.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {

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
            $("#fmonths").val(year + "-" + month + "-" + "01");
            var myDate = new Date(year, month, 0);
            $("#fmonthe").val(year + "-" + month + "-" + myDate.getDate());

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
            var startdate = $("#fmonths").val();
            var enddate = $("#fmonthe").val();
            return false;
        }
    </script>
</head>
<body>
    <div data-role="page">
        <div data-role="header" data-position="fixed">
            <a href="../FormList.aspx" target="_self" data-rel="back" class="ui-btn ui-btn-left ui-alt-icon ui-nodisc-icon ui-corner-all ui-btn-icon-notext ui-icon-carat-l">
                Back</a>
            <h1>
                用工成本表</h1>
            <a href="#searchpanel" class="ui-btn-right ui-btn ui-btn-inline ui-mini ui-corner-all  ui-btn-icon-right ui-icon-search"
                style="padding-top: 0.4em;">查询 </a>
        </div>
        <div style="margin-top: 5px;">
            <table class="table table-bordered">
                <tr>
                    <th>
                        序号
                    </th>
                    <th>
                        开始日期
                    </th>
                    <th>
                        结束日期
                    </th>
                    <th>
                        栋号
                    </th>
                    <th>
                        工种
                    </th>
                    <th>
                        工作内容
                    </th>
                    <th>
                        单位
                    </th>
                    <th>
                        工作量
                    </th>
                    <th>
                        单价
                    </th>
                    <th>
                        小计
                    </th>
                </tr>
                <tr>
                    <td colspan="10">
                        请点击右上角的查询，选择项目和时间段查询
                    </td>
                </tr>
            </table>
        </div>
        <div data-role="panel" id="searchpanel" data-position="right" data-display="push"
            data-theme="a">
            <div data-role="content">
                <h3>
                    查询</h3>
                <form id="laborcostForm">
                <div data-role="fieldcontain">
                    <select name="projectid" id="projectid" onchange="changepro(this.value)">
                        <option value='-1'>请选择项目</option>
                    </select>
                    <input type="text" name='fmonths' id="fmonths" data-role="date" placeholder="开始日期" />
                    <input type="text" name='fmonthe' id="fmonthe" data-role="date" placeholder="截止日期" />
                    <button data-theme="b" data-rel="close" type="button" onclick='doPost()'>
                        确认</button>
                </div>
                </form>
            </div>
        </div>
    </div>
</body>
</html>
