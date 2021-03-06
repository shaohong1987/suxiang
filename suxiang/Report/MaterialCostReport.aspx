﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
    CodeBehind="MaterialCostReport.aspx.cs" Inherits="suxiang.Report.MaterialCostReport" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="../Content/js/jquery-1.11.0.min.js" type="text/javascript"></script>
    <script src="../Content/js/grid.locale-cn.js" type="text/javascript"></script>
    <script src="../Content/js/jquery.jqGrid.min.js" type="text/javascript"></script>
    <link href="../Content/css/bootstrap.min.css" rel="stylesheet" />
    <link href="../Content/css/ui.jqgrid-bootstrap.css" rel="stylesheet" />
    <script src="../Content/js/bootstrap.min.js" type="text/javascript"></script>
    <script src="../Content/js/My97/WdatePicker.js" type="text/javascript"></script>
    <style type="text/css">
        .ui-jqgrid tr.jqgrow td
        {
            white-space: normal !important;
            height: auto;
            vertical-align: text-top;
            padding-top: 2px;
        }
        th.ui-th-column div
        {
            /* jqGrid columns name wrap  */
            white-space: normal !important;
            height: auto !important;
            padding: 0px;
        }
    </style>
    <script type="text/javascript">
        var date = new Date;
        var year = date.getFullYear();
        var month = date.getMonth() + 1;
        month = (month < 10 ? "0" + month : month);
        var mydate = (year.toString() + '-' + month.toString());
        $(document).ready(function () {
            $("#fmonth").val(mydate);
            $.post("../Handler/Process.ashx", { action: "GetProjects" }, function (data) {
                var json = eval(data);
                if (json.State === true) {
                    $("#project").append("<option value='-1'>全部</option>");
                    $.each(json.Data, function (i, item) {
                        $("#project").append("<option value='" + item['Id'] + "'>" + item['Projectname'] + "</option>");
                    });
                    getdata();
                }
            },
        "json");

            $("#BtnSearch").on("click", function () {
                jQuery("#jqGrid")
                            .jqGrid('setGridParam',
                            {
                                url: "../Handler/Process.ashx?action=GetMaterialCosts",
                                postData: {
                                    ProjectId: $("#project").val(),
                                    month: $("#fmonth").val()
                                }
                            })
                            .trigger("reloadGrid");
            });

            $("#BtnExport").on("click",
function () {
    window.location
        .href = "../Handler/Process.ashx?action=ExportProjects&projectId=" + $("#project").val() + "&month=" + $("#fmonth").val() + "&type=cost_material";
});

            $("#BtnClear").on("click",
                function () {
                    $.post("../Handler/Process.ashx",
                        {
                            action: "ClearProjects",
                            projectId: $("#project").val(),
                            month: $("#fmonth").val(),
                            type: "cost_material"
                        },
                        function (data) {
                            var json = eval(data);
                            if (json.State === true) {

                            }
                        },
                        "json");
                });

            $(".placeul").html("<li><a>报表中心</a></li><li><a>材料成本报表</a></li>");
        });

        function getdata() {
            $("#jqGrid").jqGrid({
                url: "../Handler/Process.ashx?action=GetMaterialCosts",
                postData: {
                    ProjectId: $("#project").val(),
                    month: $("#fmonth").val()
                },
                mtype: "GET",
                styleUI: 'Bootstrap',
                height: "auto",
                datatype: "json",
                colModel: [
                            { label: '具体位置', name: 'addr', width: '120' },
                            { label: '日期', name: 'curdate', width: '80' },
                            { label: '班组', name: 'teamleader' },
                            { label: '材料名称', name: 'materialname' },
                            { label: '单位', name: 'unit', width: '70' },
                            { label: '单价', name: 'price', width: '70' },
                            { label: '数量', name: 'number', width: '70' },
                            { label: '小计', name: 'totalprice', width: '70' },
                            { label: '填表人', name: 'poster', width: '70' },
                            { label: '确认人1', name: 'comfirmname', width: '70' },
                            { label: '确认人2', name: 'recomfirmname', width: '70' },
                            { label: '备注', name: 'remarkbyworker', width: '70' }
                        ],
                viewrecords: true,
                rownumbers: true,
                footerrow: true,
                gridComplete: function () {
                    $("#jqGrid").closest(".ui-jqgrid-bdiv").css({ "overflow-x": "hidden" });
                    var rowNum = parseInt($(this).getGridParam('records'), 10);
                    if (rowNum > 0) {
                        $(".ui-jqgrid-sdiv").show();
                        var totalprice = jQuery(this).getCol('totalprice', false, 'sum');
                        $(this).footerData("set", {
                            number: '合计',
                            totalprice: totalprice
                        });
                    } else {
                        $(".ui-jqgrid-sdiv").hide();
                    }
                }
            });
        }

        function selectMonth() {
            WdatePicker({ dateFmt: 'yyyy-MM', isShowToday: false, isShowClear: false });
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="form-inline">
        <div class="form-group">
            <label for="project">
                项目</label>
            <select class="form-control" id="project">
            </select>
        </div>
        <div class="form-group">
            <label for="fmonth">
                月份</label>
            <input id="fmonth" type="text" class="form-control" onclick="selectMonth()" />
        </div>
        <button id="BtnSearch" type="button" class="btn btn-default">
            查询</button>
                 <button id="BtnExport" type="button" class="btn btn-default">
            导出</button>
        <button id="BtnClear" type="button" class="btn btn-default">
            清理</button>
    </div>
    <hr />
    <div>
        <table id="jqGrid">
        </table>
        <div id="jqGridPager">
        </div>
    </div>
</asp:Content>
