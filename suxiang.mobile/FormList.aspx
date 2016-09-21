<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="FormList.aspx.cs" Inherits="suxiang.mobile.Form.FormList" %>

<!DOCTYPE html>
<html>
<head>
    <title>后台管理系统</title>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link rel="stylesheet" href="Content/css/jquery.mobile-1.4.5.min.css" />
    <script src="Content/js/jquery.min.js" type="text/javascript"></script>
    <script src="Content/js/jquery.mobile-1.4.5.min.js" type="text/javascript"></script>
</head>
<body>
    <div data-role="page">
        <div data-role="header">
            <h1>
                各类表单</h1>
        </div>
        <div data-role="content">
            <ul data-role="listview" data-inset="true" data-divider-theme="a">
                <li data-role="list-divider">表单列表</li>
                <li><a href='Form/SecurityQuestionForm.aspx' target='_self'>安全问题表</a></li>
                <li><a href='Form/QualityQuestionForm.aspx' target='_self'>质量问题表</a></li>
                <li><a href='Form/LaborCostForm.aspx' target='_self'>用工成本表</a></li>
                <li><a href='Form/MaterialCostForm.aspx' target='_self'>材料成本表</a></li>
                <li><a href='Form/ManageCostForm.aspx' target='_self'>管理成本表</a></li>
            </ul>
        </div>
        <div data-role="footer" data-position="fixed">
            <div data-role="navbar">
                <ul>
                    <li><a href='#' data-icon='star' class="ui-btn-active">各类表单</a></li>
                    <li><a href="index.aspx" data-icon="grid" target='_self'>报表中心</a></li>
                    <li><a href="PersonalCenter.aspx" data-icon="gear" target='_self'>个人设置</a></li>
                </ul>
            </div>
        </div>
    </div>
</body>
</html>
