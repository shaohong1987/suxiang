<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="NewForm.aspx.cs" Inherits="suxiang.Form.NewForm" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="../Content/js/jquery-1.11.2.min.js"></script>
    <link href="../Content/css/bootstrap.min.css" rel="stylesheet" />
    <script type="text/javascript">
        $(document).ready(function() {
                $(".placeul").html("<li><a>各类表单</a></li>");
            });
        </script>
        </asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div style="font-size:18pt;">
        <ul>
            <li><cite></cite><a href="SecurityQuestionForm.aspx" target="rightFrame">安全问题表</a><i></i></li>
                <li><cite></cite><a href="QualityQuestionForm.aspx" target="rightFrame">质量问题表</a><i></i></li>
                <li><cite></cite><a href="LaborCostForm.aspx" target="rightFrame">栋号班组用工成本表</a><i></i></li>
                <li><cite></cite><a href="MaterialCostForm.aspx" target="rightFrame">栋号材料成本表</a><i></i></li>
                <li><cite></cite><a href="MaterialAuxiliaryCostForm.aspx" target="rightFrame">栋号工具辅材成本表</a><i></i></li>
                <li><cite></cite><a href="ManageCostForm.aspx" target="rightFrame">管理费用表</a><i></i></li>
        </ul>
</div>
</asp:Content>
