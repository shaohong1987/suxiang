<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="NewForm.aspx.cs" Inherits="suxiang.Form.NewForm" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
     <script type="text/javascript">
        var arr = new Array();
        $(document).ready(function () {
            $(".placeul").html("<li><a>各类表单</a></li>");
        });
         </script>
    <style type="text/css">
        .f {
            font-size: 14pt;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div>
        <ul>
            <li><a class="f" href="SecurityQuestionForm.aspx" target="rightFrame">安全问题表</a><i></i></li>
                <li><a class="f" href="QualityQuestionForm.aspx" target="rightFrame">质量问题表</a><i></i></li>
                <li><a class="f" href="LaborCostForm.aspx" target="rightFrame">栋号班组用工成本表</a><i></i></li>
                <li><a class="f" href="MaterialCostForm.aspx" target="rightFrame">栋号材料成本表</a><i></i></li>
                <li><a class="f" href="MaterialAuxiliaryCostForm.aspx" target="rightFrame">栋号工具辅材成本表</a><i></i></li>
                <li><a class="f" href="ManageCostForm.aspx" target="rightFrame">管理费用表</a><i></i></li>
        </ul>
</div>
</asp:Content>
