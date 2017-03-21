<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="PersonMgr.aspx.cs" Inherits="suxiang.Adm.PersonMgr" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="../Content/css/ui.jqgrid.css" rel="stylesheet" type="text/css"/>
    <link href="../Content/js/jquery-ui-1.11.0.custom/jquery-ui.min.css" rel="stylesheet"
          type="text/css"/>
    <link href="../Content/css/formCss.css" rel="stylesheet" type="text/css"/>
    <link href="../Content/js/style.css" rel="stylesheet" type="text/css"/>
    <link href="../Content/js/prettify.css" rel="stylesheet" type="text/css"/>
    <script src="../Content/js/jquery-1.11.2.min.js" type="text/javascript"></script>
    <script src="../Content/js/jquery-ui-1.11.0.custom/jquery-ui.min.js" type="text/javascript"></script>
    <script src="../content/js/grid.locale-cn.js" type="text/javascript"></script>
    <script src="../content/js/jquery.jqGrid.js" type="text/javascript"></script>
    <script src="../Content/js/jquery.validate.min.js" type="text/javascript"></script>
    <script type="text/javascript">
        $(document).ready(function() {
                $("#BtnSearch").on("click",function() {jQuery("#grid").jqGrid('setGridParam',{
                                    url: "../Handler/Auth.ashx?action=GetUserByUserName",
                                    postData: { UserName: $("#txtuserName").val() }
                                }).trigger("reloadGrid");
                        });
             
                $('#grid').jqGrid({
                        height: "auto",
                        autowidth: true,
                        multiboxonly: true,
                        altRows: true,
                        hoverrows: true,
                        viewrecords: true,
                        jsonReader: {
                            repeatitems: false
                        },
                        gridview: true,
                        url: "../Handler/Auth.ashx?action=GetUserByUserName",
                        postData: {
                            UserName: $("#txtuserName").val()
                        },
                        shrinkToFit: false,
                        datatype: "json",
                        colNames: ['员工号', '姓名', '邮箱', '角色', '状态'],
                        colModel: [
                            { "name": "username" }, { "name": "realname" }, { "name": "email", width: "400px" }, {
                                name: 'group',
                                formatter: function(cellValue) {
                                    if (cellValue == 0) {
                                        return "总经理";
                                    } else if (cellValue == 1) {
                                        return "财务";
                                    } else {
                                        return "普通员工";
                                    }
                                }
                            },
                            {
                                name: 'state',
                                formatter: function(cellValue) {
                                    return cellValue == 0 ? "禁用" : "正常";
                                }
                            }
                        ]
                    });

                $(".placeul").html("<li><a>管理中心</a></li><li><a>用户管理</a></li>");
                $(".cancel").click(function() {
                        closeWin();
                });
                $(".sure").click(function() {
                    if (doCheck()) {
                        var formData = $("#uform").serialize();
                        $.ajax({
                            type: "POST",
                            url: "../Handler/Auth.ashx?action="+type,
                            cache: false,
                            data: formData,
                            success: function (data) {
                                var json = JSON.parse(data);
                                alert(json.Msg);
                                if (json.State === true) {
                                    closeWin();
                                    $("#BtnSearch").click();
                                }
                            },
                            error: function (data) {
                                var json = JSON.parse(data);
                                alert(json.Msg);
                            }
                        });
                    }
                });
            });

        var type = "adduser";

        function doCheck() {
            var username = $("input[name='username']").val();
            var password = $("input[name='password']").val();
            var repassword = $("input[name='repassword']").val();
            var realname = $("input[name='realname']").val();

            if (username == null || username.length == 0) {
                alert("请输入员工号");
                $("input[name='username']").focus();
                return false;
            }
            if (type == "adduser") {
                $.ajax({
                    type: "POST",
                    url: "../Handler/Auth.ashx?action=checkusername",
                    cache: false,
                    data: { uname: username },
                    success: function (data) {
                        var json = JSON.parse(data);
                        if (json.State != false) {
                            alert("该员工号已存在");
                            $("input[name='username']").val('').focus();
                            return false;
                        }
                    },
                    error: function (data) {
                        var json = JSON.parse(data);
                        alert(json.Msg);
                        return false;
                    }
                });

                if (password == null || password.length == 0) {
                    alert("请输入密码");
                    $("input[name='password']").focus();
                    return false;
                }
                if (password != repassword) {
                    alert("两次密码不一致");
                    $("input[name='repassword']").val('').focus();
                    return false;
                }
            }
            if (type == "updateuser") {
                if (password != repassword) {
                    alert("两次密码不一致");
                    $("input[name='repassword']").val('').focus();
                    return false;
                }
            }

            if (realname == null || realname.length == 0) {
                alert("请输入真实姓名");
                $("input[name='realname']").focus();
                return false;
            }
          
            return true;
        }

        function doAdd() {
            type = "adduser";
            $("input[name='username']").val("").removeAttr("readonly");
            $("input[name='realname']").val("");
            $("input[name='email']").val("");
            $("input[name='password']").val("");
            $("input[name='repassword']").val("");
            $("#r普通员工").attr("checked", 'checked');
            $("#r正常").attr("checked", 'checked');
            $(".tip").fadeOut(100);
            $(".tip").fadeIn(200);
        }

        function doUpdate() {
            type = "updateuser";
             $("input[name='password']").val("");
             $("input[name='repassword']").val("");
            var rowid = $("#grid").getGridParam("selrow");
            if (rowid) {
                var rowData = $("#grid").getRowData(rowid);
                $("input[name='username']").val(rowData["username"]).attr("readonly", "readonly");
                $("input[name='realname']").val(rowData["realname"]);
                $("input[name='email']").val(rowData["email"]);
                $("#r" + rowData["group"]).attr("checked", 'checked');
                $("#r" + rowData["state"]).attr("checked", 'checked');
                $(".tip").fadeOut(100);
                $(".tip").fadeIn(200);
            } else {
                alert("请先选中一个用户!");
            }
        }

        function doDel() {
            type = "updateuser";
            var rowid = $("#grid").getGridParam("selrow");
            if (rowid) {
                var rowData = $("#grid").getRowData(rowid);
                var un = rowData["username"];
                $.ajax({
                    type: "POST",
                    url: "../Handler/Auth.ashx?action=deluser",
                    cache: false,
                    data: { uname: un },
                    success: function (data) {
                        var json = JSON.parse(data);
                        if (json.State != false) {
                            alert("删除成功");
                            $("#BtnSearch").click();
                        }
                    },
                    error: function (data) {
                        var json = JSON.parse(data);
                        alert(json.Msg);
                        return false;
                    }
                });
            } else {
                alert("请先选中一个用户!");
            }
        }

        function closeWin() {
            $(".tip").fadeOut(100);
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="tools">
        <div class="toolbar forminfo">
            <label>姓名:</label>
            <input type="text" id="txtuserName" class="dfinput"/>
            <label>
                <button id="BtnSearch" type="button" name="BtnSearch" class="btn">查找</button>
            </label>
        </div>
        <ul class="toolbar1">
            <li class="click" onclick="javascript:doAdd();"><span><img src="../Content/images/t01.png" /></span>添加</li>
            <li class="click" onclick="javascript:doUpdate();"><span><img src="../Content/images/t02.png" /></span>修改</li>
            <li class="click" onclick="javascript:doDel();"><span><img src="../Content/images/t03.png" /></span>删除</li>
        </ul>
    </div>
    <div id="grid_div">
        <table id="grid">
        </table>
        <div id="pager">
        </div>
    </div>
    <div class="tip">
        <div class="tiptop">
            <span>用户信息</span><a href="javascript:closeWin();"></a>
        </div>
        <br/>
        <form id="uform">
            <div class="usual">
                <ul class="forminfo">
                    <li>
                        <label>
                            员工号<b>*</b>
                        </label>
                        <input type="text" name="username" placeholder="员工号" class="dfinput"/>
                    </li>
                    <li>
                        <label>
                            姓名<b>*</b>
                        </label>
                        <input type="text" name="realname" placeholder="姓名" class="dfinput"/>
                    </li>
                    <li>
                        <label>
                            密码<b>*</b>
                        </label>
                        <input type="password" name="password" placeholder="密码" class="dfinput"/>
                    </li>
                    <li>
                        <label>
                            确认密码<b>*</b>
                        </label>
                        <input type="password" class="dfinput" name="repassword" id="price" placeholder="请再次输入密码"/>
                    </li>
                    <li>
                        <label>
                            邮箱<b>*</b>
                        </label>
                        <input type="text" class="dfinput" name="email" placeholder="邮箱"/>
                    </li>
                    <li>
                        <label>
                            角色<b>*</b>
                        </label><cite>
                            <input type="radio" name="group" value="100" id="r普通员工"/>普通员工&nbsp;&nbsp;&nbsp;&nbsp;
                            <input type="radio" name="group" value="0" id="r总经理"/>总经理&nbsp;&nbsp;&nbsp;&nbsp;
                            <input type="radio" name="group" value="1" id="r财务"/>财务
                        </cite>
                    </li>
                    <li>
                        <label>
                            状态<b>*</b>
                        </label><cite>
                            <input type="radio" value="1" name="state" id="r正常"/>正常&nbsp;&nbsp;&nbsp;&nbsp;
                            <input type="radio" value="0" name="state" id="r禁用"/>禁用
                        </cite>
                    </li>
                </ul>
            </div>
            <div class="tipbtn">
                <input type="button" class="sure" value="确定"/>&nbsp;
                <input type="reset" class="cancel" value="取消"/>
            </div>
        </form>
    </div>
</asp:Content>