<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ToDo.aspx.cs" Inherits="suxiang.Form.ToDo" %>
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
            padding: 0;
        }
    </style>
    <script type="text/javascript">
        $(document).ready(function () {
            $(".placeul").html("<li><a>工作台</a></li><li><a>待处理表单</a></li>");
        });
        $(document)
            .ready(function() {
                $("#jqGrid")
                    .jqGrid({
                        url: "../Handler/Process.ashx?action=GetToDoForm",
                        postData: {
                            ProjectId: $("#project").val(),
                            month: $("#fmonth").val()
                        },
                        mtype: "GET",
                        styleUI: 'Bootstrap',
                        height: "auto",
                        datatype: "json",
                        colModel: [
                            { label: '月份', name: 'dmonth', width: '100' },
                            { label: '项目', name: 'projectname', width: '120' },
                            { label: '单据类型', name: 'dtype', width: '150' },
                            { label: '填表人', name: 'poster', width: '80' },
                            { label: '提交时间', name: 'posttime', width: '150' },
                            { label: '状态', name: 'status', width: '180' },
                            { label: '操作', name: 'url', width: '100', formatter: customFmatter }
                        ],
                        viewrecords: true,
                        rownumbers: true
                    });
            });

        function customFmatter(cellvalue) {
            if (cellvalue.indexOf('View') > 0) {
                return '<a href="' + cellvalue + '">查看<a>';
            } else {
                return '<a href="' + cellvalue + '">处理<a>';
            }
        }

        function selectMonth() {
            WdatePicker({ dateFmt: 'yyyy-MM', isShowToday: false, isShowClear: false });
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div style="margin-top: 15px;">
        <table id="jqGrid">
        </table>
        <div id="jqGridPager">
        </div>
    </div>
</asp:Content>

