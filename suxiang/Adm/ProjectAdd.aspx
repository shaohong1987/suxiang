<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
    CodeBehind="ProjectAdd.aspx.cs" Inherits="suxiang.Adm.ProjectAdd" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <meta charset="utf8" />
    <link rel="stylesheet" href="../Content/css/jquery.mobile-1.4.5.min.css" />
    <script src="../Content/js/jquery.min.js" type="text/javascript"></script>
    <script src="../Content/js/jquery.mobile-1.4.5.min.js" type="text/javascript"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            $.ajax({
                type: "POST",
                url: "../Handler/Auth.ashx?action=GetUserWithOutAdmin",
                cache: false,
                success: function (data) {
                    var d = JSON.parse(data);
                    $.each(d, function (i, item) {
                        $("#manage").append("<option value='" + item['Id'] + "-" + item["realname"] + "'>" + item['realname'] + "</option>");
                        $("#productleader").append("<option value='" + item['Id'] + "-" + item["realname"] + "'>" + item['realname'] + "</option>");
                        $("#accountant").append("<option value='" + item['Id'] + "-" + item["realname"] + "'>" + item['realname'] + "</option>");
                        $("#constructionleader").append("<option value='" + item['Id'] + "-" + item["realname"] + "'>" + item['realname'] + "</option>");
                        $("#qualityleader").append("<option value='" + item['Id'] + "-" + item["realname"] + "'>" + item['realname'] + "</option>");
                        $("#safetyleader").append("<option value='" + item['Id'] + "-" + item["realname"] + "'>" + item['realname'] + "</option>");
                        $("#storekeeper").append("<option value='" + item['Id'] + "-" + item["realname"] + "'>" + item['realname'] + "</option>");
                        $("#buildingleader").append("<option value='" + item['Id'] + "-" + item["realname"] + "'>" + item['realname'] + "</option>");
                    });
                },
                error: function (data) {
                    var json = JSON.parse(data);
                    alert(json.Msg);
                }
            });
        });

        function doPost() {
            var buildingArr = new Array();
            var v = $("#table-column-toggle tr:eq(1) td:eq(1)").text();
            if (v != '') {
                var tlength = $("#table-column-toggle tr").length;
                for (var j = 1; j < tlength; j++) {
                    buildingArr[j - 1] = new Array();
                    buildingArr[j - 1][0] = $("#table-column-toggle tr:eq(" + j + ") td:eq(0)").text();
                    buildingArr[j - 1][1] = $("#table-column-toggle tr:eq(" + j + ") td:eq(1)").text();
                    buildingArr[j - 1][2] = $("#table-column-toggle tr:eq(" + j + ") td:eq(2)").text();
                    buildingArr[j - 1][3] = $("#table-column-toggle tr:eq(" + j + ") td:eq(3)").text();
                }
            }
            if ($("#projectname").val() == '' ||
					$("#manage").val() == '-1' ||
					$("#productleader").val() == '-1' ||
                    $("#accountant").val() == '-1' ||
                    $("#constructionleader").val() == '-1' ||
                    $("#qualityleader").val() == '-1' ||
                    $("#safetyleader").val() == '-1' ||
                    $("#storekeeper").val() == '-1' ||
					buildingArr.length < 1
			) {
                alert('请将数据填写完整后提交，谢谢！');
                return false;
            } else {
                $.ajax({
                    type: "POST",
                    url: "../Handler/Process.ashx",
                    cache: false,
                    data: {
                        action: "addprojectform",
                        projectname: $("#projectname").val(),
                        manage: $("#manage").val(),
                        productleader: $("#productleader").val(),
                        accountant: $("#accountant").val(),
                        constructionleader: $("#constructionleader").val(),
                        qualityleader: $("#qualityleader").val(),
                        safetyleader: $("#safetyleader").val(),
                        storekeeper: $("#storekeeper").val(),
                        bArr: buildingArr
                    },
                    success: function (data) {
                        var json = JSON.parse(data);
                        alert(json.Msg);
                        if (json.State === true) {
                            window.open("ProjectMgr.aspx", "_self");
                        } else {
                            alert(json.Msg);
                        }
                    },
                    error: function () {
                        var json = eval(data);
                        alert(json.Msg);
                    }
                });
            }
            return false;
        }

        var i = 0;

        function addBuilding() {
            var buildingno = $("#buildingno").val();
            var buildingleader = $("#buildingleader").val();
            var bleader = buildingleader.split('-');
            if (buildingno != '' && buildingleader != '') {
                i++;
                if (i == 1) {
                    removeTr(i);
                }
                var newRow = "<tr id='tr" + i + "'><td>" + buildingno + "</td><td>" + bleader[0] + "</td><td>" + bleader[1] + "</td><td><a onclick='removeTr(" + i + ")'>删除</a></td></tr>";
                $("#table-column-toggle tr:last").after(newRow);
                $("#buildingno").val("");
                $("#buildingleader").val("");
            }
        }

        function removeTr(i) {
            $("#tr" + i).remove();
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div data-role="page" style="margin-top: 50px;">
        <div>
            <button class="ui-btn-right ui-btn ui-btn-b ui-btn-inline ui-mini ui-corner-all ui-btn-icon-right ui-icon-check"
                onclick="doPost();">
                保存
            </button>
        </div>
        <div data-role="content" style="margin-top: 30px;">
            <div id="addprojectform">
                <div data-role="fieldcontain">
                    <input type="text" name="projectname" id="projectname" placeholder="项目名称" />
                    <select name="manage" id="manage">
                        <option value="-1">请选择项目负责人</option>
                    </select>
                    <select name="productleader" id="Select1">
                        <option value="-1">请选择生产经理</option>
                    </select>
                    <select name="accountant" id="Select2">
                        <option value="-1">请选择会计</option>
                    </select>
                    <select name="constructionleader" id="Select3">
                        <option value="-1">请选择施工员</option>
                    </select>
                    <select name="qualityleader" id="Select4">
                        <option value="-1">请选择质量员</option>
                    </select>
                    <select name="safetyleader" id="Select5">
                        <option value="-1">请选择安全员</option>
                    </select>
                    <select name="storekeeper" id="Select6">
                        <option value="-1">请选择保管员</option>
                    </select>
                    <table data-role="table" id="table-column-toggle" class="ui-responsive table-stroke"
                        style="float: right;">
                        <thead>
                            <tr>
                                <th data-priority="1">
                                    栋号
                                </th>
                                <th data-priority="1">
                                    栋号长编号
                                </th>
                                <th data-priority="1">
                                    栋号长
                                </th>
                                <th data-priority="1">
                                    <a href="#popupBuildingInfo" data-transition="pop" data-rel="popup" data-position-to="window">
                                        添加栋号信息 </a>
                                </th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr id="tr1">
                                <td colspan="4">
                                    暂无数据
                                </td>
                            </tr>
                        </tbody>
                    </table>
                    <h3 id="notification">
                    </h3>
                </div>
            </div>
        </div>
        <div class="ui-corner-all" id="popupBuildingInfo" data-role="popup" data-theme="a">
            <div>
                <div style="padding: 10px 20px;">
                    <h3>
                        请添加栋号信息
                    </h3>
                    <label class="ui-hidden-accessible" for="buildingno">
                        栋号
                    </label>
                    <input name="buildingno" id="buildingno" type="text" placeholder="栋号" value="" data-theme="a">
                    <label class="ui-hidden-accessible" for="buildingleader">
                        栋号长:
                    </label>
                    <select name="buildingleader" id="buildingleader">
                        <option value="-1">请选择栋号长</option>
                    </select>
                    <button class="ui-btn ui-corner-all ui-shadow ui-btn-b ui-btn-icon-left ui-icon-check"
                        type="button" onclick="addBuilding()">
                        添加
                    </button>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
