<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="suxiang.Login" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>登录--南京苏翔劳务有限公司</title>
    <link href="Content/css/style.css" rel="stylesheet" type="text/css" />
    <script src="Content/js/jquery-1.11.1.min.js" type="text/javascript"></script>
    <script src="Content/js/cloud.js" type="text/javascript"></script>
    <script src="Content/js/jquery.md5.js" type="text/javascript"></script>
    <script language="javascript" type="text/javascript">
        $(function () {
            $('.loginbox').css({ 'position': 'absolute', 'left': ($(window).width() - 692) / 2 });
            $(window).resize(function () {
                $('.loginbox').css({ 'position': 'absolute', 'left': ($(window).width() - 692) / 2 });
            });
        });

        function Login() {
            $.post("Handler/Auth.ashx?action=Login", { usercode: $("#usercode").val(), userpass: $.md5($("#userpass").val()) },
                function (data, status) {
                    var json = eval(data);
                    if (json.State === true) {
                        window.location.href = "Index.aspx";
                    } else {
                        $("#tip").html(json.Msg);
                    }
                }, "json");
        }
    </script>
</head>
<body style="background-color: #1c77ac; background-image: url(Content/images/light.png);
    background-repeat: no-repeat; background-position: center top; overflow: hidden;">
    <form id="form1" runat="server">
    <div id="mainBody">
        <div id="cloud1" class="cloud">
        </div>
        <div id="cloud2" class="cloud">
        </div>
    </div>
    <div class="logintop">
        <div>
            &nbsp;</div>
    </div>
    <div class="loginbody">
        <span class="systemlogo"></span>
        <div class="loginbox">
            <ul>
                <li>
                    <input id="usercode" runat="server" name="" type="text" class="loginuser" value="用户名"
                        onclick="javascript: this.value = '';" /></li>
                <li>
                    <input id="userpass" runat="server" name="" type="password" class="loginpwd" value="密码"
                        onclick="javascript: this.value = '';" /></li>
                <li>
                    <input type="button" value="登录" class="loginbtn" onclick="javascript:Login();" />
                    <label id="tip" style="color: red;">
                    </label>
                </li>
            </ul>
        </div>
    </div>
    <div class="loginbm">
        <asp:Label runat="server" ID="lblauth"></asp:Label>
    </div>
    </form>
</body>
</html>
