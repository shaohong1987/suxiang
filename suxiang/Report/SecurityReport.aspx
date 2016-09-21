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
			        { label: '栋号', name: 'buildingno', width: '40' },
			        { label: '楼层/户型', name: 'levelno', width: '50' },
			        { label: '具体位置', name: 'location', width: '80' },
			        { label: '问题描述', name: 'problemdescription', width: '150' },
			        { label: '检查日期', name: 'checkdate', width: '80' },
			        { label: '施工人/班组', name: 'worker', width: '60' },
			        { label: '整改完成时间', name: 'finishdate', width: '80' },
			        { label: '整改人', name: 'rebuilder', width: '60' },
			        { label: '责任人', name: 'responsibleperson', width: '60' },
			        { label: '处理措施/结果', name: 'treatmentmeasures', width: '150' },
			        { label: '整改消耗工时', name: 'worktimecost', width: '70' },
			        { label: '整改消耗材料', name: 'materialcost', width: '70' },
			        { label: '复查人', name: 'rechecker', width: '60' }
		        ],
                viewrecords: true,
                rownumbers: true,
                footerrow: true,
                gridComplete: function () {
                    $("#jqGrid").closest(".ui-jqgrid-bdiv").css({ "overflow-x": "hidden" });
                    var rowNum = parseInt($(this).getGridParam('records'), 10);
                    if (rowNum > 0) {
                        $(".ui-jqgrid-sdiv").show();
                        var worktimecost = jQuery(this).getCol('worktimecost', false, 'sum');
                        var materialcost = jQuery(this).getCol('materialcost', false, 'sum');
                        $(this).footerData("set", {
                            name: "合计",
                            treatmentmeasures: '合计',
                            worktimecost: worktimecost,
                            materialcost: materialcost
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
    </div>
    <div style="margin-top: 15px;">
        <table id="jqGrid">
        </table>
        <div id="jqGridPager">
        </div>
    </div>
</asp:Content>
