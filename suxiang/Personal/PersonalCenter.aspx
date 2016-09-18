<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.Master" CodeBehind="PersonalCenter.aspx.cs"
    Inherits="suxiang.Personal.PersonalCenter" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="../Content/css/style.css" rel="stylesheet" type="text/css" />
    <link href="../Content/css/select.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="../Content/js/jquery.js"></script>
    <script type="text/javascript" src="../Content/js/jquery.idTabs.min.js"></script>
    <script type="text/javascript" src="../Content/js/select-ui.min.js"></script>
    <script src="../Content/js/jquery.validate.min.js" type="text/javascript"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            $("#usual1 ul").idTabs();
            $('.tablelist tbody tr:odd').addClass('odd');

            $.post("../Handler/Auth.ashx", { action: "getuser" }, function(data) {
                var json = eval(data);
                    $("input[name=username]").val(json.EmployeeNo);
                    $("input[name=realname]").val(json.RealName);
                    $("input[name=email]").val(json.Email);
                    if (json.Group == "0") {
                        $("input[name=group]").val('总经理');
                    } else if (json.Group == "1") {
                        $("input[name=group]").val('管理员');
                    } else {
                        $("input[name=group]").val('普通员工');
                    }
                },
                "json");


            });

            function doCheck() {
                var op = $("input[name='oldpassword']").val();
                var np = $("input[name='newpassword']").val();
                var rnp = $("input[name='renewpassword']").val();
                if (op == null || op.length == 0) {
                    alert("请输入旧密码");
                    $("input[name='oldpassword']").focus();
                    return false;
                }
                if (np == null || np.length == 0) {
                    alert("请输入新密码");
                    $("input[name='newpassword']").focus();
                    return false;
                }
                if (rnp != np) {
                    alert("两次密码不一致");
                    $("input[name='renewpassword']").focus();
                    return false;
                }
                return true;
            }

            function doPost() {
                if (doCheck()) {
                    var op = $("input[name='oldpassword']").val();
                    var np = $("input[name='newpassword']").val();
                    $.ajax({
                        type: "POST",
                        url: "../Handler/Auth.ashx?action=updatepwd",
                        cache: false,
                        data: { oldpassword: op, newpassword: np },
                        success: function(data) {
                            var json = JSON.parse(data);
                            alert(json.Msg);
                            if (json.State === true) {
                                window.open("PersonalCenter.aspx", "_self");
                            }
                        },
                        error: function(data) {
                            var json = JSON.parse(data);
                            alert(json.Msg);
                        }
                    });
                }
            }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div id="usual1" class="usual">
        <div class="itab">
            <ul>
                <li><a href="#tab1" class="selected">个人信息</a></li>
                <li><a href="#tab2">修改密码</a></li>
            </ul>
        </div>
        <div id="tab1" class="tabson">
            <ul class="forminfo">
                <li>
                    <label>
                        员工号</label>
                    <input name="username" type="text" class="dfinput" value="" style="width: 518px;"
                        readonly="readonly" />
                </li>
                <li>
                    <label>
                        姓名</label>
                    <input name="realname" type="text" class="dfinput" value="" style="width: 518px;"
                        readonly="readonly" />
                </li>
                <li>
                    <label>
                        邮箱</label>
                    <input name="email" type="text" class="dfinput" value="" style="width: 518px;"
                        readonly="readonly" />
                </li>
                <li>
                    <label>
                        账户类型</label>
                    <input name="group" type="text" class="dfinput" value="" style="width: 518px;"
                        readonly="readonly" />
                </li>
            </ul>
        </div>
        <div id="tab2" class="tabson">
            <ul class="forminfo">
                <li>
                    <label>
                        旧密码<b>*</b></label>
                    <input name="oldpassword" type="password" class="dfinput" value="" style="width: 518px;" />
                </li>
                <li>
                    <label>
                        新密码<b>*</b></label>
                    <input name="newpassword" type="password" class="dfinput" value="" style="width: 518px;" />
                </li>
                <li>
                    <label>
                        重复新密码<b>*</b></label>
                    <input name="renewpassword" type="password" class="dfinput" value="" style="width: 518px;" />
                </li>
                <li>
                    <label>
                        &nbsp;</label><input name="" type="button" class="btn" value="修改"  onclick="javascript:doPost();"/></li>
            </ul>
        </div>
    </div>
</asp:Content>
