<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
    CodeBehind="ProjectMgr.aspx.cs" Inherits="suxiang.Adm.ProjectMgr" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="../Content/js/style.css" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" href="../Content/css/jquery.mobile-1.4.5.min.css">
    <script src="../Content/js/jquery.min.js" type="text/javascript"></script>
    <script src="../Content/js/jquery.mobile-1.4.5.min.js" type="text/javascript"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            $.ajax({ type: "POST",
                url: "../Handler/Process.ashx?action=getallprojects",
                cache: false,
                success: function (data) {
                    var json = JSON.parse(data);
                    if (json.State == true) {
                        if (json.Data != null) {
                            $.each(json.Data, function (i, item) {
                                var newRow = "<tr>";
                                newRow += "<td>" + item.Projectname + "</td>";
                                newRow += "<td>" + item.Projectleader + "</td>";
                                newRow += "<td>" + item.Productleader + "</td>";
                                newRow += "<td>" + item.Accountant + "</td>";
                                newRow += "<td>" + item.Constructionleader + "</td>";
                                newRow += "<td>" + item.Safetyleader + "</td>";
                                newRow += "<td>" + item.Qualityleader + "</td>";
                                newRow += "<td>" + item.Storekeeper + "</td>";
                                newRow += "<td>" + item.BuildingTotal + "</td>";
                                newRow += "<td>" + (item.State ? "进行中" : "已结束") + "</td>";
                                newRow += "<td>" + (item.State ? "<a onclick='changeState(" + item.Id + ",0);' style='cursor:pointer;'>结束项目</a>" : "<a onclick='changeState(" + item.Id + ",1);' style='cursor:pointer;'>启用项目</a>") + "</td>";
                                newRow += "<td><a href=ProjectInfo.aspx?u=" + item.Id + " target='_self'>编辑信息</a></td>";
                                newRow += "<td><a onclick='delProject(" + item.Id + ");' style='cursor:pointer;'>删除项目</a></td></tr>"; 
                                $("#table-column-toggle tr:last").after(newRow);
                            });
                        } else {
                            var newRow = "<tr><td colspan='7' style='text-align: center;'>暂无项目数据</td></tr>";
                            $("#table-column-toggle tr:last").after(newRow);
                        }
                    } else {
                        var newRow = "<tr><td colspan='7' style='text-align: center;'>无法获取到项目信息</td></tr>";
                        $("#table-column-toggle tr:last").after(newRow);
                    }
                },
                error: function (data) {
                    var json = JSON.parse(data);
                    alert(json.Msg);
                }
            });

            $(".placeul").html("<li><a>管理中心</a></li><li><a>项目管理</a></li>");
        });

        function onSuccess(data, status) {
            window.open("ProjectMgr.aspx", "_self");
        }

        function onError(data, status) {
            window.open("ProjectMgr.aspx", "_self");
        }

        function changeState(uid, s) {
            $.ajax({
                type: "POST",
                url: "../Handler/Process.ashx",
                cache: false,
                data: { action: 'changeProjectState', id: uid, state: s },
                success: onSuccess,
                error: onError
            });
        }
        
        function delProject(uid) {
            $.ajax({
                type: "POST",
                url: "../Handler/Process.ashx",
                cache: false,
                data: { action: 'delProject', id: uid},
                success: onSuccess,
                error: onError
            });
        }

        function doAdd() {
            window.open("ProjectAdd.aspx", "_self");
        }

    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div data-role="page" style="margin-top: 50px;">
        <div class="tools">
            <ul class="toolbar1">
                <li class="click" onclick="javascript:doAdd();"><span>
                    <img src="../Content/images/t01.png" /></span>添加</li>
            </ul>
        </div>
        <div data-role="content">
            <form>
            <input id="filterTable-input" data-type="search">
            </form>
            <table data-role="table" id="table-column-toggle" data-filter="true" data-input="#filterTable-input"
                class="ui-responsive table-stroke">
                <thead>
                    <tr>
                        <th data-priority="1">
                            项目名称
                        </th>
                        <th data-priority="1">
                            项目负责人
                        </th>
                        <th data-priority="1">
                            生产经理
                        </th>
                        <th data-priority="1">
                            会计
                        </th>
                        <th data-priority="1">
                            施工员
                        </th>
                        <th data-priority="1">
                            安全员
                        </th>
                        <th data-priority="1">
                            质量员
                        </th>
                        <th data-priority="1">
                            保管员
                        </th>
                        <th data-priority="1">
                            总栋数
                        </th>
                        <th data-priority="1">
                            状态
                        </th>
                        <th data-priority="1">
                        </th>
                        <th data-priority="1">
                        </th>
                    </tr>
                </thead>
                <tbody>
                </tbody>
            </table>
        </div>
    </div>
</asp:Content>
