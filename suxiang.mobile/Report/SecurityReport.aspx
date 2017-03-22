<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SecurityReport.aspx.cs" Inherits="suxiang.mobile.Report.SecurityReport" %>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <title>安全问题表</title>
    <link rel="stylesheet" href="../Content/css/jquery.mobile-1.4.5.min.css">
    <link href="../Content/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" href="../Content/css/jquery.mobile.datepicker.css">
   
</head>
<body>
    <div data-role="page">
        <div data-role="header" data-position="fixed">
            <a href="../index.aspx" target="_self" data-rel="back" class="ui-btn ui-btn-left ui-alt-icon ui-nodisc-icon ui-corner-all ui-btn-icon-notext ui-icon-carat-l">
                Back</a>
            <h1>
                <label id="lid">
                    安全问题表</label></h1>
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
                            问题等级
                        </th>
                        <th>
                            具体部位
                        </th>
                        <th>
                            检查日期
                        </th>
                        <th>
                            完成时间
                        </th>
                        <th>
                            问题说明
                        </th>
                        <th>
                            原因分析
                        </th>
                        <th>
                            班组/施工人
                        </th>
                        <th>
                            管理责任人
                        </th>
                        <th>
                            整改方案
                        </th>
                        <th>
                            整改人
                        </th>
                        <th>
                            处理结果
                        </th>
                        <th>
                            花费工时
                        </th>
                         <th>
                            消耗材料
                        </th>
                        <th>
                            复查人
                        </th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td colspan="15">
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
                    质量问题查询</h3>
                <form id="laborcostForm">
                <div data-role="fieldcontain">
                    <select name="projectid" id="projectid" onchange="changepro(this.value)">
                        <option value='-1'>请选择项目</option>
                    </select>
                    <input type="text" name='fmonths' id="fmonths" data-role="date" placeholder="月份" />
                    <button data-theme="b" data-rel="close" type="button" onclick='doPost(-1)'>
                        确认</button>
						<button data-theme="b" data-rel="close" type="button" onclick='doPost(1)'>
                        上月</button>
                </div>
                </form>
            </div>
        </div>
		 <script src="../Content/js/jquery.min.js"></script>
    <script src="../Content/js/jquery.mobile-1.4.5.min.js"></script>
    <script src="../Content/js/jquery.ui.datepicker.js"></script>
    <script src="../Content/js/jquery.mobile.datepicker.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            var nowdays = new Date();
            var year = nowdays.getFullYear();
            var month = nowdays.getMonth()+1;
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
				doPost(-1);
        });

        function doPost(i) {
            var projectid = $("#projectid").val();
            var startdate = $("#fmonths").val();
			if (i =="1") {
                var date = new Date();			
                var ndate = new Date(date.setMonth(date.getMonth() - 1));
                startdate = ndate.getFullYear() + "-" + (ndate.getMonth() + 1);
				$("#fmonths").val(startdate);
            }
            $.post("../Handler/Process.ashx", { action: "GetSercurityProblems", ProjectId: projectid, month: startdate }, function (data) {
                var json = eval(data);
                $("table tbody").html('');
                if (json.length == 0) {
                    $("table tbody").html("<tr><td colspan='15'>暂无数据</td></tr>");
                } else {
                    var newRow;
                    $.each(json, function (i, item) {
                        if (i == 0) {
                            $("#lid").html(item["projectname"]);
                        }
                        var style = "style='background-color:yellow;'";
                        if (item["levelno"] == "3级") {
                            style = "style='background-color:red;'";
                        } 
                        newRow += "<tr " + style + "><td>" + (i + 1) + "</td>" +
                            "<td>" + item["levelno"] + "</td" +
                            "><td>" + item["addr"] + "</td>" +
                            "<td>" + item["checkdate"] + "</td>" +
                            "<td>" + item["finishdate"] + "</td>" +
                            "<td>" + item["problemdescription"] + "</td>" +
                            "<td>" + item["causation"] + "</td>" +
                            "<td>" + item["worker"] + "</td>" +
                            "<td>" + item["manager"] + "</td>" +
                            "<td>" + item["rebuildsolution"] + "</td>" +
                            "<td>" + item["rebuilder"] + "</td>" +
                            "<td>" + item["worktimecost"] + "</td>" +
                            "<td>" + item["materialcost"] + "</td>" +
                            "</tr>";
                        $("table tbody tr:last").after(newRow);
                    });
                    $("table tbody").html(newRow);
                }
            },
                "json");
            return false;
        }
    </script>
    </div>
</body>
</html>
