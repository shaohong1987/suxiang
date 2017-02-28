<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
    CodeBehind="ProjectInfo.aspx.cs" Inherits="suxiang.Adm.ProjectInfo" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <meta charset="utf-8" />
    <link rel="stylesheet" href="../Content/css/jquery.mobile-1.4.5.min.css">
    <script src="../Content/js/jquery.min.js" type="text/javascript"></script>
    <script src="../Content/js/jquery.mobile-1.4.5.min.js" type="text/javascript"></script>
    <script type="text/javascript">
        var i = -1;
        $(document).ready(function () {
            $.ajax({
                type: "POST",
                url: "../Handler/Auth.ashx?action=GetUserWithOutAdmin",
                cache: false,
                success: function (data) {
                   
                    $.ajax({
                        type: "POST",
                        url: "../Handler/Process.ashx?action=getproject&projectid=<%=ProjectId %>",
                        cache: false,
                        success: function(data1) {
                            var json = JSON.parse(data1);
                            if (json.State == true) {
                                if (json.Data != null) {
                                    $("#projectname").val(json.Data[0].Projectname);
                                    var d = JSON.parse(data);
                                    $.each(d, function (i, item) {
                                        if (json.Data[0].Projectleaderid + "-" + json.Data[0].Projectleader == item['Id'] + "-" + item["realname"]) {
                                            $("#manage").append("<option selected='selected' value='" + item['Id'] + "-" + item["realname"] + "'>" + item['realname'] + "</option>");
                                        } else {
                                            $("#manage").append("<option value='" + item['Id'] + "-" + item["realname"] + "'>" + item['realname'] + "</option>");
                                        }
                                        
                                         if (json.Data[0].Productleaderid + "-" + json.Data[0].Productleader == item['Id'] + "-" + item["realname"]) {
                                            $("#productleader").append("<option selected='selected' value='" + item['Id'] + "-" + item["realname"] + "'>" + item['realname'] + "</option>");
                                        } else {
                                            $("#productleader").append("<option value='" + item['Id'] + "-" + item["realname"] + "'>" + item['realname'] + "</option>");
                                         }

                                         if (json.Data[0].Accountantid + "-" + json.Data[0].Accountant == item['Id'] + "-" + item["realname"]) {
                                            $("#accountant").append("<option selected='selected' value='" + item['Id'] + "-" + item["realname"] + "'>" + item['realname'] + "</option>");
                                        } else {
                                            $("#accountant").append("<option value='" + item['Id'] + "-" + item["realname"] + "'>" + item['realname'] + "</option>");
                                         }

                                         if (json.Data[0].Constructionleaderid + "-" + json.Data[0].Constructionleader == item['Id'] + "-" + item["realname"]) {
                                            $("#constructionleader").append("<option selected='selected' value='" + item['Id'] + "-" + item["realname"] + "'>" + item['realname'] + "</option>");
                                        } else {
                                            $("#constructionleader").append("<option value='" + item['Id'] + "-" + item["realname"] + "'>" + item['realname'] + "</option>");
                                         }

                                         if (json.Data[0].Qualityleaderid + "-" + json.Data[0].Qualityleader == item['Id'] + "-" + item["realname"]) {
                                            $("#qualityleader").append("<option selected='selected' value='" + item['Id'] + "-" + item["realname"] + "'>" + item['realname'] + "</option>");
                                        } else {
                                            $("#qualityleader").append("<option value='" + item['Id'] + "-" + item["realname"] + "'>" + item['realname'] + "</option>");
                                         }

                                         if (json.Data[0].Safetyleaderid + "-" + json.Data[0].Safetyleader == item['Id'] + "-" + item["realname"]) {
                                            $("#safetyleader").append("<option selected='selected' value='" + item['Id'] + "-" + item["realname"] + "'>" + item['realname'] + "</option>");
                                        } else {
                                            $("#safetyleader").append("<option value='" + item['Id'] + "-" + item["realname"] + "'>" + item['realname'] + "</option>");
                                         }

                                         if (json.Data[0].Storekeeperid + "-" + json.Data[0].Storekeeper == item['Id'] + "-" + item["realname"]) {
                                            $("#storekeeper").append("<option selected='selected' value='" + item['Id'] + "-" + item["realname"] + "'>" + item['realname'] + "</option>");
                                        } else {
                                            $("#storekeeper").append("<option value='" + item['Id'] + "-" + item["realname"] + "'>" + item['realname'] + "</option>");
                                         }

                                         $("#buildingleader").append("<option value='" + item['Id'] + "-" + item["realname"] + "'>" + item['realname'] + "</option>");
                                         $("#manage").selectmenu("refresh", true);
                                         $("#productleader").selectmenu("refresh", true);
                                         $("#accountant").selectmenu("refresh", true);
                                         $("#constructionleader").selectmenu("refresh", true);
                                         $("#qualityleader").selectmenu("refresh", true);
                                         $("#safetyleader").selectmenu("refresh", true);
                                         $("#storekeeper").selectmenu("refresh", true);
                                         

                                    });
                                }
                            }
                        },
                        error: function(data) {
                            var json = JSON.parse(data);
                            alert(json.Msg);
                        }
                    });

                },
                error: function (data) {
                    var json = JSON.parse(data);
                    alert(json.Msg);
                }
            });



            $.ajax({ type: "POST",
                url: "../Handler/Process.ashx?action=getprojectinfo&projectid=<%=ProjectId %>",
                cache: false,
                success: function (data) {
                    var json = JSON.parse(data);
                    if (json.State == true) {
                        if (json.Data != null) {
                            i = json.Data.length;
                            $.each(json.Data, function (j, item) {
                                var newRow = "<tr id='tr"+j+"'>";
                                newRow += "<td>" + item.Buildingid + "</td>";
                                newRow += "<td>" + item.BuildingLeaderId + "</td>";
                                newRow += "<td>" + item.BuildingLeader + "</td>";
                                newRow += "<td><a onclick='removeTr("+j+")'>删除</a></td>";
                                newRow += "</tr>";
                                $("#table-column-toggle tr:last").after(newRow);
                            });
                        } else {
                            var newRow = "<tr><td colspan='4' style='text-align: center;'>暂无项目数据</td></tr>";
                            $("#table-column-toggle tr:last").after(newRow);
                        }
                    } else {
                        var newRow = "<tr><td colspan='4' style='text-align: center;'>无法获取到项目信息</td></tr>";
                        $("#table-column-toggle tr:last").after(newRow);
                    }
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
                    buildingArr[j - 1][0] = $("#table-column-toggle tr:eq(" + j + ") td:eq(0)").text().replace('栋号', '');
                    buildingArr[j - 1][1] = $("#table-column-toggle tr:eq(" + j + ") td:eq(1)").text().replace('栋号长编号', '');
                    buildingArr[j - 1][2] = $("#table-column-toggle tr:eq(" + j + ") td:eq(2)").text().replace('栋号长', '');
                    buildingArr[j - 1][3] = $("#table-column-toggle tr:eq(" + j + ") td:eq(3)").text().replace('添加栋号信息', '');
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
                buildingArr.length < 1) {
                alert('请将数据填写完整后提交，谢谢！');
                return false;
            }
            else {
                $.ajax({
                    type: "POST",
                    url: "../Handler/Process.ashx",
                    cache: false,
                    data: {
                        action: "updateprojectform",
                        projectid: <%=ProjectId%>,
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
            var buildinglevel = $("#buildinglevel").val();
            if (buildingno != '' && buildingleader != '' && buildinglevel != '') {
                i++;
                if (i == 1) {
                    removeTr(i);
                }
                var newRow = "<tr id='tr" + i + "'><td>" + buildingno + "</td><td>" + bleader[0] + "</td><td>" + bleader[1] + "</td><td><a onclick='removeTr(" + i + ")'>删除</a></td></tr>";
                $("#table-column-toggle tr:last").after(newRow);
                $("#buildingno").val("");
                $("#buildingleader").val("");
                $("#buildinglevel").val("");

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
                onclick='doPost();'>
                保存</button>
        </div>
        <div data-role="content" style="margin-top: 30px;">
            <div id="addprojectform">
                <div data-role="fieldcontain">
                    <input type="text" name='projectid' id='projectid' placeholder="项目编号" readonly='true'
                        value="<%=ProjectId %>" />
                    <input type="text" name='projectname' id='projectname' placeholder="项目名称" value="" />
                    <select name="manage" id="manage">
                        <option value='-1'>请选择项目经理</option>
                    </select>
                    <select name="productleader" id="productleader">
                        <option value="-1">请选择生产经理</option>
                    </select>
                    <select name="accountant" id="accountant">
                        <option value="-1">请选择会计</option>
                    </select>
                    <select name="constructionleader" id="constructionleader">
                        <option value="-1">请选择施工员</option>
                    </select>
                    <select name="qualityleader" id="qualityleader">
                        <option value="-1">请选择质量员</option>
                    </select>
                    <select name="safetyleader" id="safetyleader">
                        <option value="-1">请选择安全员</option>
                    </select>
                    <select name="storekeeper" id="storekeeper">
                        <option value="-1">请选择保管员</option>
                    </select>
                    <table data-role="table" id="table-column-toggle" class="ui-responsive table-stroke"
                        style='float: right;'>
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
                                        添加栋号信息</a>
                                </th>
                            </tr>
                        </thead>
                        <tbody>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
        <div class="ui-corner-all" id="popupBuildingInfo" data-role="popup" data-theme="a">
            <div>
                <div style="padding: 10px 20px;">
                    <h3>
                        请添加栋号信息</h3>
                    <label class="ui-hidden-accessible" for="buildingno">
                        栋号</label>
                    <input name="buildingno" id="buildingno" type="text" placeholder="栋号" value="" data-theme="a">
                    <label class="ui-hidden-accessible" for="buildingleader">
                        栋号长:</label>
                    <select name="buildingleader" id="buildingleader">
                        <option value='-1'>请选择栋号长</option>
                    </select>
                    <button class="ui-btn ui-corner-all ui-shadow ui-btn-b ui-btn-icon-left ui-icon-check"
                        type="button" onclick='addBuilding()'>
                        添加</button>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
