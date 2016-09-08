﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Left.aspx.cs" Inherits="suxiang.Left" %>

<%@ Import Namespace="suxiang.Model" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>信息管理系统</title>
    <link href="content/css/style.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="content/js/jquery.js"></script>
    <script type="text/javascript">
        $(function () {
            $(".menuson li").click(function () {
                $(".menuson li.active").removeClass("active");
                $(this).addClass("active");
            });

            $('.title').click(function () {
                var $ul = $(this).next('ul');
                $('dd').find('ul').slideUp();
                if ($ul.is(':visible')) {
                    $(this).next('ul').slideUp();
                } else {
                    $(this).next('ul').slideDown();
                }
            });
        })	
    </script>
</head>
<body style="background: #f0f9fd;">
    <form runat="server">
    <div class="lefttop">
        <span></span>菜单</div>
    <dl class="leftmenu">
        <dd>
            <div class="title">
                <span>
                    <img src="Content/images/leftico01.png" alt="报表中心" /></span>报表中心
            </div>
            <ul class="menuson">
                <li class="active"><cite></cite><a href="Main.aspx" target="rightFrame">报表总览</a><i></i></li>
                <li><cite></cite><a href="Report/SecurityReport.aspx" target="rightFrame">安全问题报表</a><i></i></li>
                <li><cite></cite><a href="imgtable.html" target="rightFrame">质量问题报表</a><i></i></li>
                <li><cite></cite><a href="form.html" target="rightFrame">用工费用报表</a><i></i></li>
                <li><cite></cite><a href="imglist.html" target="rightFrame">材料费用报表</a><i></i></li>
                <li><cite></cite><a href="imglist1.html" target="rightFrame">管理费用报表</a><i></i></li>
            </ul>
        </dd>
        <dd>
            <div class="title">
                <span>
                    <img src="Content/images/leftico02.png" alt="各类表单" /></span>各类表单
            </div>
            <ul class="menuson">
                <li><cite></cite><a href="#">安全问题表</a><i></i></li>
                <li><cite></cite><a href="#">质量问题表</a><i></i></li>
                <li><cite></cite><a href="#">用工费用表</a><i></i></li>
                <li><cite></cite><a href="#">材料费用表</a><i></i></li>
                <li><cite></cite><a href="#">管理费用表</a><i></i></li>
            </ul>
        </dd>
        <dd>
            <div class="title">
                <span>
                    <img src="Content/images/leftico03.png" alt="个人中心" /></span>个人中心</div>
            <ul class="menuson">
                <li><cite></cite><a href="#">个人资料设置</a><i></i></li>
            </ul>
        </dd>
        <%
            var u = Session["user"];
            if (u != null)
            {
                var user = (UsersModel)u;
                if (user.Group < 10)
                {
        %>
        <dd>
            <div class="title">
                <span>
                    <img src="Content/images/leftico04.png" alt="系统管理" /></span>系统管理</div>
            <ul class="menuson">
                <li><cite></cite><a href="#">员工管理</a><i></i></li>
                <li><cite></cite><a href="#">项目管理</a><i></i></li>
            </ul>
        </dd>
        <%
                }
            }
            else
            {
                Response.Redirect("Login.aspx");
            }
        %>
    </dl>
    </form>
</body>
</html>