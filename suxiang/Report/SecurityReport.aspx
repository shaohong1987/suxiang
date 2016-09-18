<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="SecurityReport.aspx.cs" Inherits="suxiang.Report.SecurityReport" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="../Content/js/jquery-1.11.0.min.js" type="text/javascript"></script>
    <script src="../Content/js/grid.locale-cn.js" type="text/javascript"></script>
    <script src="../Content/js/jquery.jqGrid.min.js" type="text/javascript"></script>
    <link href="../Content/css/bootstrap.min.css" rel="stylesheet" />
    <link href="../Content/css/ui.jqgrid-bootstrap.css" rel="stylesheet" />
    <script src="../Content/js/bootstrap.min.js" type="text/javascript"></script>
    <script src="../Content/js/My97/WdatePicker.js" type="text/javascript"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            $.post("../Handler/Process.ashx", { action: "GetProjects" }, function (data) {
                var json = eval(data);
                if (json.State === true) {
                    $.each(json.Data, function (i, item) {
                        $("#project").append("<option value='" + item['Id'] + "'>" + item['Projectname'] + "</option>");
                    });
                }
            },
        "json");

            $("#BtnSearch").on("click",function() {
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
                $("#jqGrid").jqGrid({
                        url: "../Handler/Process.ashx?action=GetSercurityProblems",
                        postData: {
                            ProjectId: $("#project").val(),
                            month: $("#fmonth").val()
                        },
                        mtype: "GET",
                        styleUI: 'Bootstrap',
                        height: "auto",
                        datatype: "jsonp",
                        colModel: [
                            { label: '栋号', name: 'buildingno' },
                            { label: '楼层/户型', name: 'levelno' },
                            { label: '具体位置', name: 'location' },
                            { label: '问题描述', name: 'problemdescription' },
                            { label: '检查日期', name: 'checkdate' },
                            { label: '施工人/班组', name: 'worker' },
                            { label: '整改完成时间', name: 'finishdate' },
                            { label: '整改人', name: 'rebuilder' },
                            { label: '责任人', name: 'responsibleperson' },
                            { label: '处理措施/结果', name: 'treatmentmeasures' },
                            { label: '整改消耗工时', name: 'worktimecost' },
                            { label: '整改消耗材料', name: 'materialcost' },
                            { label: '复查人', name: 'rechecker' }
                        ],
                        viewrecords: true
                });

                    $(".placeul").html("<li><a>报表中心</a></li><li><a>安全问题报表</a></li>");
            });

        function selectMonth() {
            WdatePicker({ dateFmt: 'yyyy-MM', isShowToday: false, isShowClear: false });
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="form-inline">
        <div class="form-group">
            <label for="project">项目</label>
            <select class="form-control" id="project">
            </select>
        </div>
        <div class="form-group">
            <label for="fmonth">月份</label>
            <input id="fmonth" type="text" class="form-control" onclick="selectMonth()" />
        </div>
      
        <button id="BtnSearch" type="button" class="btn btn-default">查询</button>
    </div>
    <hr/>
    <div>
        <table id="jqGrid"></table>
        <div id="jqGridPager"></div>
    </div>

</asp:Content>
