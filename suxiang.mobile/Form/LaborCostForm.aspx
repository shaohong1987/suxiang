<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="LaborCostForm.aspx.cs" Inherits="suxiang.mobile.Form.LaborCostForm" %>

<!DOCTYPE html>
<html>
<head>
    <title>网上办公</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="../Content/css/jquery.mobile-1.4.5.min.css">
    <link rel="stylesheet" href="../Content/css/jquery.mobile.datepicker.css">
    <script src="../Content/js/jquery.min.js"></script>
    <script src="../Content/js/jquery.mobile-1.4.5.min.js"></script>
    <script src="../Content/js/jquery.ui.datepicker.js"></script>
    <script src="../Content/js/jquery.mobile.datepicker.js"></script>
    <script type="text/javascript">
        var arr = new Array();
        $(document).ready(function() {
            $.post("../Handler/Process.ashx", { action: "GetBuildings" }, function (data) {
                    var json = eval(data);
                    if (json.State === true) {
                        $.each(json.Data, function (i, item) {
                            arr[i] = new Array();
                            arr[i][0] = item['Projectid'];
                            arr[i][1] = item['Buildingid'];
                        });
                    }
                },
                "json");

            $.post("../Handler/Process.ashx", { action: "GetProjects" }, function (data) {
                    var json = eval(data);
                    if (json.State === true) {
                        $.each(json.Data, function (i, item) {
                            $("#projectid").append("<option value='" + item['Id'] + "'>" + item['Projectname'] + "</option>");
                        });
                    }
                },
                "json");
        });

        function doPost() {
            if ($("#projectname").val() == '' || $("#projectname").val() == '' || $("#buildingno").val() == '' || $("#buildingno").val() == '-1' || $("#startdate").val() == '' || $("#enddate").val() == ''
                || $("#content").val() == '' || $("#workcontent").val() == '' || $("#unit").val() == '' || $("#worktime").val() == '' || $("#price").val() == '') {
                alert('请将数据填写完整,谢谢!');
                return false;
            }

            var v1 = parseFloat($("#number").val());
            var v2 = parseFloat($("#price").val());
            $("#totalprice").val(v1 * v2);
            var formData = $("#laborcostForm").serialize();
            $.ajax({
                type: "POST",
                url: "../Handler/process.ashx?action=LaborCostForm",
                cache: false,
                data: formData,
                success: function(data) {
                    var json = JSON.parse(data);
                    alert(json.Msg);
                    if (json.State === true) {
                        window.open("LaborCostForm.aspx", "_self");
                    }
                },
                error: function(data) {
                    var json = JSON.parse(data);
                    alert(json.Msg);
                }
            });

            return false;
        }

        function changepro(proid) {
            $("#projectname").val($('#projectid').find("option:selected").text());
            $("#buildingno").empty();
            $("#buildingno").append($("<option>").val(-1).text('请选择栋号'));
            for (var i = 0; i < arr.length; i++) {
                if (arr[i][0] == proid) {
                    $("#buildingno").append($("<option>").val(arr[i][1]).text(arr[i][1]));
                }
            }
        }

        function check(e) {
            var re = /^\d+(?=\.{0,1}\d+$|$)/;
            if (e.value != "") {
                if (!re.test(e.value)) {
                    alert("请输入正确的数字");
                    e.value = "";
                    e.focus();
                }
            }
            var v1 = parseFloat($("#number").val());
            var v2 = parseFloat($("#price").val());
            $("#totalprice").val(v1 * v2);
        }
    </script>
</head>
<body>
    <div data-role="page">
        <div data-role="header" data-position="fixed">
            <a href="../FormList.aspx" target="_self" data-rel="back" class="ui-btn ui-btn-left ui-alt-icon ui-nodisc-icon ui-corner-all ui-btn-icon-notext ui-icon-carat-l">Back</a>
            <h1>填写——用工成本记录</h1>
        </div>
        <div data-role="content">
            <form id="laborcostForm">
                <div data-role="fieldcontain">
                    <input type='hidden' name='projectname' id='projectname' />
                    <label for="projectid">项目：</label>
                    <select name="projectid" id="projectid" onchange="changepro(this.value)">
                        <option value='-1'>请选择项目</option>
                    </select>
                    <label for="buildingno">栋号：</label>
                    <select name="buildingno" id="buildingno">
                        <option value='-1'>请选择栋号</option>
                    </select>
                    <label for="startdate">开始日期：</label>
                    <input type="text" name='startdate' id="startdate" data-role="date" />
                    <label for="enddate">结束日期：</label>
                    <input type="text" name='enddate' id="enddate" data-role="date" />
                    <label for="content">工种：</label>
                    <input type="text" name='content' id='content' placeholder="工种" />
                    <label for="workcontent">工作内容：</label>
                    <input type="text" name='workcontent' id='workcontent' placeholder="工作内容" />
                    <label for="unit">单位：</label>
                    <input type="text" name='unit' id='unit' placeholder="单位" />
                    <label for="number">工作量：</label>
                    <input type="text" name='number' id='number' placeholder="工作量" onblur="check(this)" onkeyup="this.value=this.value.replace(/[^0-9.]/g,'')" />
                    <label for="price">单价：</label>
                    <input type="text" name='price' id="price" placeholder="单价" onblur="check(this)" onkeyup="this.value=this.value.replace(/[^0-9.]/g,'')" />
                    <label for="totalprice">小计：</label>
                    <input type="text" name='totalprice' id="totalprice" placeholder="小计" readonly="true" />
                    <label for="remark">备注：</label>
                    <textarea cols="40" id="remark" rows="8" name="remark" placeholder="备注"></textarea>
                    <h3 id="notification"></h3>
                    <button data-theme="b" type="button" onclick='doPost()'>提交报告</button>
                </div>
            </form>
        </div>
    </div>
</body>
</html>
