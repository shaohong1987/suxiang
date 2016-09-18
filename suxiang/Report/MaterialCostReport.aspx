<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="MaterialCostReport.aspx.cs" Inherits="suxiang.Report.MaterialCostReport" %>
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
                                url: "../Handler/Process.ashx?action=GetMaterialCosts",
                                postData: {
                                    ProjectId: $("#project").val(),
                                    month: $("#fmonth").val()
                                }
                            })
                            .trigger("reloadGrid");
                    });
                $("#jqGrid").jqGrid({
                    url: "../Handler/Process.ashx?action=GetMaterialCosts",
                        postData: {
                            ProjectId: $("#project").val(),
                            month: $("#fmonth").val()
                        },
                        mtype: "GET",
                        styleUI: 'Bootstrap',
                        height: "auto",
                        datatype: "jsonp",
                        colModel: [	
                            { label: '日期', name: 'curdate' },
                            { label: '班组', name: 'workteam' },
                            { label: '材料名称', name: 'materialname' },
                            { label: '单位', name: 'unit' },
                            { label: '数量', name: 'number' },
                            { label: '单价', name: 'price' },
                            { label: '小计', name: 'totalprice' }
                        ],
                        viewrecords: true
                });

                    $(".placeul").html("<li><a>报表中心</a></li><li><a>材料成本报表</a></li>");
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


