<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
    CodeBehind="PersonMgr.aspx.cs" Inherits="suxiang.Adm.PersonMgr" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="../Content/js/style.css" rel="stylesheet" type="text/css" />
    <script src="../Content/js/jquery-1.11.2.min.js" type="text/javascript"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            $(".click").click(function () {
                $(".tip").fadeIn(200);
            });

            $(".tiptop a").click(function () {
                $(".tip").fadeOut(200);
            });

            $(".sure").click(function () {
                $(".tip").fadeOut(100);
            });

            $(".cancel").click(function () {
                $(".tip").fadeOut(100);
            });

            $('.tablelist tbody tr:odd').addClass('odd');
        });

        function loadData() {

        }

    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="tools">
        <ul class="toolbar">
            <li class="click"><span>
                <img src="../Content/images/t01.png" /></span>添加</li>
        </ul>
    </div>
    <table class="tablelist">
        <thead>
            <tr>
                <th>
                    编号
                </th>
                <th>
                    员工号
                </th>
                <th>
                    姓名
                </th>
                <th>
                    邮箱
                </th>
                <th>
                    角色
                </th>
                <th>
                    状态
                </th>
                <th>
                    操作
                </th>
            </tr>
        </thead>
    </table>
    <div class="pagin">
        <div class="message">
            共<i class="blue">2</i>条记录，当前显示第&nbsp;<i class="blue">2</i>&nbsp;页</div>
        <ul class="paginList">
            <li class="paginItem"><a href="javascript:;"><span class="pagepre"></span></a></li>
            <li class="paginItem  current"><a href="javascript:;">1</a></li>
            <li class="paginItem"><a href="javascript:;"><span class="pagenxt"></span></a></li>
        </ul>
    </div>
    <div class="tip">
        <div class="tiptop">
            <span>新增用户</span><a></a></div>
        <div class="tipinfo">
            <span>
                <img src="../Content/images/ticon.png" /></span>
            <div class="tipright">
                <p>
                    是否确认对信息的修改 ？</p>
                <cite>如果是请点击确定按钮 ，否则请点取消。</cite>
            </div>
        </div>
        <div class="tipbtn">
            <input name="" type="button" class="sure" value="确定" />&nbsp;
            <input name="" type="button" class="cancel" value="取消" />
        </div>
    </div>
</asp:Content>
