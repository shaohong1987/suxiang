<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PersonalCenter.aspx.cs"
    Inherits="suxiang.mobile.PersonalCenter" %>

<!DOCTYPE html>
<html>
<head>
    <title>后台管理系统</title>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link rel="stylesheet" href="Content/css/jquery.mobile-1.4.5.min.css" />
    <script src="Content/js/jquery.min.js" type="text/javascript"></script> 
    <script src="Content/js/jquery.mobile-1.4.5.min.js" type="text/javascript"></script>
    <script src="Content/js/jquery.md5.js" type="text/javascript"></script>
    <script type="text/javascript">
        function doPost() {
            var oldpass = $("#oldpass").val();
            var pass = $("#pass").val();
            var pass2 = $("#pass2").val();
            if (oldpass == '' || pass == '' || pass2 == '' || (pass != pass2)) {
                $("#notification").text("请填写完整数据,并保两次输入的新密码一致.");
                return false;
            }
            $.post("Handler/process.ashx?action=updatepwdaction",
			    {
			        oldpass: $.md5($("#oldpass").val()),
			        newpass: $.md5($("#pass").val())
			    },
			    function (data) {
			        var json = eval(data);
			        if (json.State === true) {
			            window.location.href = "login.htm";
			        } else {
			            $("#notification").html(json.Msg);
			        }
			    }, "json");
        }
    </script>
</head>
<body>
    <div data-role="page">
        <div data-role="header">
            <h1>
                个人中心</h1>
            <button class="ui-btn-right ui-btn ui-btn-b ui-btn-inline ui-mini ui-corner-all ui-btn-icon-right ui-icon-check"
                onclick='doPost();'>
                保存</button>
        </div>
        <div data-role="content">
            <form id="updatepwdForm">
            <div data-role="fieldcontain">
                <label for="oldpass">
                    旧密码</label>
                <input type="password" name='oldpass' placeholder="旧密码" id="oldpass" />
                <label for="pass">
                    新密码</label>
                <input type="password" name='pass' placeholder="新密码" id="pass" />
                <label for="pass2">
                    确认密码</label>
                <input type="password" name='pass2' placeholder="再次输入新密码" id="pass2" />
                <h3 id="notification">
                </h3>
                <input type="hidden" name="action" value="updatepwdForm" />
            </div>
            </form>
        </div>
        <div data-role="footer" data-position="fixed">
            <div data-role="navbar">
                <ul>
                    <li><a href='FormList.aspx' data-icon='star' target='_self'>各类表单</a></li>
                    <li><a href="index.aspx" data-icon="grid" target="_self">报表中心</a></li>
                    <li><a href="#" data-icon="gear" class="ui-btn-active">个人设置</a></li>
                </ul>
            </div>
        </div>
    </div>
</body>
</html>
