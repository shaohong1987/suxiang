<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
    CodeBehind="SecurityReport.aspx.cs" Inherits="suxiang.Report.SecurityReport" %>

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
        .r{
            background-color:red;
            }
        .y{
            background-color:yellow;
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
                                url: "../Handler/Process.ashx?action=GetSercurityProblems",
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
                        .href = "../Handler/Process.ashx?action=ExportProjects&projectId="+ $("#project").val()+"&month="+$("#fmonth").val()+"&type=problem_sercurity";
                });

            $("#BtnClear").on("click",
                function() {
                    $.post("../Handler/Process.ashx",
                        {
                            action: "ClearProjects",
                            projectId: $("#project").val(),
                            month: $("#fmonth").val(),
                            type: "problem_sercurity"
                        },
                        function(data) {
                            var json = eval(data);
                            if (json.State === true) {

                            }
                        },
                        "json");
                });

            $(".placeul").html("<li><a>报表中心</a></li><li><a>安全问题报表</a></li>");
        });
        function getdata() {
            $("#jqGrid").jqGrid({
                url: "../Handler/Process.ashx?action=GetSercurityProblems",
                postData: {
                    ProjectId: $("#project").val(),
                    month: $("#fmonth").val()
                },
                mtype: "GET",
                styleUI: 'Bootstrap',
                height: "auto",
                datatype: "json",
                colModel: [
			        { label: '安全等级', name: 'levelno', width: '80' },
			        { label: '具体部位', name: 'addr', width: '120' },
			        { label: '检查日期', name: 'checkdate', width: '80' },
                    { label: '完成日期', name: 'finishdate', width: '80' },
			        { label: '问题说明', name: 'problemdescription', width: '150' },
			        { label: '原因分析', name: 'causation', width: '150' },
			        { label: '班组/施工人', name: 'worker', width: '100' },
			        { label: '管理责任人', name: 'manager', width: '100' },
                    { label: '整改方案', name: 'rebuildsolution', width: '150' },
			        { label: '整改人', name: 'rebuilder', width: '60' },
			        { label: '处理结果', name: 'treatmentmeasures', width: '80', formatter: customFmatter },
			        { label: '花费工时', name: 'worktimecost', width: '120' },
			        { label: '消耗材料', name: 'materialcost', width: '80' },
			        { label: '复查人', name: 'rechecker', width: '60' }
		        ],
                viewrecords: true,
                rownumbers: true,
                gridComplete: function () {
                    var ids = $("#jqGrid").getDataIDs();
                    for (var i = 0; i < ids.length; i++) {
                        var rowData = $("#jqGrid").getRowData(ids[i]);
                        if (rowData.levelno == '3级') { //如果天数等于0，则背景色置灰显示
                            $('#' + ids[i]).find("td").addClass("r");
                        } else {
                            $('#' + ids[i]).find("td").addClass("y");
                        }
                    }
                }
            });
        }

        function customFmatter(cellvalue) {
            if (cellvalue == '-1') {
                return '未完成';
            }
            if (cellvalue == '0') {
                return '进行中';
            }
            if (cellvalue == '1') {
                return '已完成';
            }
        };
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
    <div style="margin-top: 15px;">
        <table id="jqGrid">
        </table>
        <div id="jqGridPager">
        </div>
    </div>
</asp:Content>
