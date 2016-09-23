﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MaterialCostReport.aspx.cs"
    Inherits="suxiang.mobile.Report.MaterialCostReport" %>

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
            if (projectid == '-1' || startdate.length == 0 || enddate.length == 0) {
                alert('请补全搜索条件.');
                return false;
            }
            $.post("../Handler/Process.ashx", { action: "GetMaterialCosts", pid: projectid, sdate: startdate, edate: enddate }, function (data) {
                var json = eval(data);
                $("table tbody").html('');
                if (json.length == 0) {
                    $("table tbody").html("<tr><td colspan='8'>暂无数据</td></tr>");
                } else {
                    var sum = 0;
                    var newRow;
                    $.each(json, function (i, item) {
                        if (i == 0) {
                            $("#lid").html(item["projectname"]);
                        }
                        sum += parseFloat(item["totalprice"]);
                        newRow += "<tr><td>" + (i + 1) + "</td><td>" + item["curdate"] + "</td><td>" + item["workteam"] + "</td><td>" + item["materialname"] + "</td><td>" + item["unit"] + "</td><td>" + item["number"] + "</td><td>" + item["price"] + "</td><td>" + item["totalprice"] + "</td></tr>";
                        $("table tbody tr:last").after(newRow);
                    });
                    newRow += "<tr><td></td><td></td><td></td><td></td><td></td><td></td><td>合计：</td><td>" + sum + "</td></tr>";
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
            <a href="../FormList.aspx" target="_self" data-rel="back" class="ui-btn ui-btn-left ui-alt-icon ui-nodisc-icon ui-corner-all ui-btn-icon-notext ui-icon-carat-l">
                Back</a>
            <h1>
                <label id="lid">
                    材料成本表</label></h1>
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
                            日期
                        </th>
                        <th>
                            班组
                        </th>
                        <th>
                            材料名称
                        </th>
                        <th>
                            单位
                        </th>
                        <th>
                            数量
                        </th>
                        <th>
                            单价
                        </th>
                        <th>
                            小计
                        </th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td colspan="8">
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
                    材料成本查询</h3>
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
