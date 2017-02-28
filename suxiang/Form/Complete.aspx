<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Complete.aspx.cs" Inherits="suxiang.Form.Complete" %>
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
                                url: "../Handler/Process.ashx?action=GetCompleteForm",
                                postData: {
                                    ProjectId: $("#project").val(),
                                    month: $("#fmonth").val()
                                }
                            })
                            .trigger("reloadGrid");
            });


            $(".placeul").html("<li><a>工作台</a></li><li><a>已处理表单</a></li>");
        });
        function getdata() {
            $("#jqGrid").jqGrid({
                url: "../Handler/Process.ashx?action=GetCompleteForm",
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
			        { label: '查看', name: 'url', width: '80', formatter: customFmatter }
		        ],
                viewrecords: true,
                rownumbers: true
            });
        }

        function customFmatter(cellvalue) {
            return '<a href="' + cellvalue + '">查看<a>';
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
    </div>
    <div style="margin-top: 15px;">
        <table id="jqGrid">
        </table>
        <div id="jqGridPager">
        </div>
    </div>
</asp:Content>
