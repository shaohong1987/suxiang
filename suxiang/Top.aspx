<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Top.aspx.cs" Inherits="suxiang.Top" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <link href="Content/css/style.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="Content/js/jquery.js"></script>
    <script type="text/javascript">
        $(function () {
            //顶部导航切换
            $(".nav li a").click(function () {
                $(".nav li a.selected").removeClass("selected");
                $(this).addClass("selected");
            });
        })	
    </script>
</head>
<body style="background: url(Content/images/topbg.gif) repeat-x;">
    <form id="form1" runat="server">
    <div class="topleft">
        <a href="Index.aspx" target="_parent">
            <img src="Content/images/logo.png" title="系统首页" alt="Home" /></a>
    </div>
    <div class="topright">
        <ul>
            <li><span>
                <img src="Content/images/help.png" alt="Help" title="帮助" class="helpimg" /></span><a
                    href="#">帮助</a></li>
            <li><a href="#">关于</a></li>
            <li>
                <asp:LinkButton ID="lbLogOut" AutoPostBack="true" runat="server" OnClick="lbLogOut_Click">退出</asp:LinkButton>
            </li>
        </ul>
        <div class="user">
            <span>
                <%=UserName %></span>
        </div>
    </div>
    </form>
</body>
</html>
