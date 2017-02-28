<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="NewForm.aspx.cs" Inherits="suxiang.mobile.Form.NewForm" %>

<!DOCTYPE html>
<html>
<head>
    <title>后台管理系统</title>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link rel="stylesheet" href="../Content/css/jquery.mobile-1.4.5.min.css" />
    <script src="../Content/js/jquery.min.js" type="text/javascript"></script>
    <script src="../Content/js/jquery.mobile-1.4.5.min.js" type="text/javascript"></script>
</head>
<body>
    <div data-role="page">
        <div data-role="header" data-position="fixed">
            <a href="../index.aspx" target="_self" class="ui-btn ui-btn-left ui-alt-icon ui-nodisc-icon ui-corner-all ui-btn-icon-notext ui-icon-carat-l">
                Back</a>
            <h1>
                <label id="lid">
                    新表单</label></h1>
        </div>
        <div data-role="content">
            <ul data-role="listview" data-inset="true" data-divider-theme="a">
                <li data-role="list-divider">新表单</li>
                <li><a href='../Form/SecurityQuestionForm.aspx' target='_self'>安全问题表</a></li>
                <li><a href='../Form/QualityQuestionForm.aspx' target='_self'>质量问题表</a></li>
                <li><a href='../Form/LaborCostForm.aspx' target='_self'>用工成本表</a></li>
                <li><a href='../Form/MaterialCostForm.aspx' target='_self'>材料成本表</a></li>
                <li><a href='../Form/MaterialAuxiliaryCostForm.aspx' target='_self'>辅材工具表</a></li>
                <li><a href='../Form/ManageCostForm.aspx' target='_self'>管理成本表</a></li>
            </ul> 
        </div>
        <div data-role="footer" data-position="fixed">
            <div data-role="navbar">
                <ul>
                    <li><a href="#" data-icon="gear" class="ui-btn-active" target='_self'>新表单</a></li>
                    <li><a href='Todo.aspx' data-icon='star'>待处理</a></li>
                    <li><a href="Complete.aspx" data-icon="grid" target='_self'>已完成</a></li>
                </ul>
            </div>
        </div>
    </div>
</body>
</html>

