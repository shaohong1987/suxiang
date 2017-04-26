<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MaterialCostForm.aspx.cs" Inherits="suxiang.mobile.Form.MaterialCostForm" %>

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
    <script src="../Content/js/jquery.validate.min.js"></script>
    <script type="text/javascript">
        var arr = new Array();
        $(document).ready(function () {
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
            $.ajax({
                type: "POST",
                url: "../Handler/Auth.ashx?action=GetUserWithOutAdmin",
                cache: false,
                success: function (data) {
                    var d = JSON.parse(data);
                    $.each(d, function (i, item) {
                        $("#teamleader").append("<option value='" + item['Id'] + "-" + item["realname"] + "'>" + item['realname'] + "</option>");
                    });
                },
                error: function (data) {
                    var json = JSON.parse(data);
                    alert(json.Msg);
                }
            });

            $.post("../Handler/Process.ashx", { action: "GetProjects" }, function (data) {
                    var json = eval(data);
                    if (json.State === true) {
                        $.each(json.Data, function (i, item) {
                            $("#projectid").append("<option value='" + item['Id'] + "'>" + item['Projectname'] + "</option>");
                        });
                    }
                },
                "json");

            $("#mcform").validate({
                focusInvalid: false,
                onkeyup: false,
                submitHandler: function () {
                    if ($("#projectid").val() != -1 && $("#buildingno").val() != '') {
                        var formData = $("#mcform").serialize();
                        $.ajax({
                            type: "POST",
                            url: "../Handler/Process.ashx",
                            cache: false,
                            data: formData,
                            success: function (data) {
                                var json = JSON.parse(data);
	                            alert(json.Msg);
                                if (json.State === true) {
                                    window.open("MaterialCostForm.aspx", "_self");
                                }
                            },
                            error: function (data) {
                                var json = JSON.parse(data);
                                alert(json.Msg);
                            }
                        });
                    } else {
                        alert("请补充必要的数据!");
                    }

                },
                rules: {
                    curdate: "required",
                    workteam: "required",
                    content: "required",
                    unit: "required",
                    price: "required",
                    number: "required"
                },
                messages: {
                    curdate: "请选择日期",
                    workteam: "请输入班组",
                    content: "请输入材料名称",
                    unit: "请输入单位",
                    price: "请输入单价",
                    number: "请输入数量/重量"
                },
                errorElement: "em",
                errorPlacement: function (error, element) {
                    if (element.prop("type") === "checkbox") {
                        error.insertAfter(element.parent("label"));
                    } else {
                        error.insertAfter(element);
                    }
                }
            });
        });

        function changepro(proid) {
            $("#projectname").val($('#projectid').find("option:selected").text());
            $("#buildingno").empty();
            $("#buildingno").append($("<option>").val(-1).text('栋号'));
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
    <div>
        <div data-role="header" data-position="fixed">
            <a href="NewForm.aspx" target="_self"  class="ui-btn ui-btn-left ui-alt-icon ui-nodisc-icon ui-corner-all ui-btn-icon-notext ui-icon-carat-l">Back</a>
            <h1>填写——材料成本记录</h1>
        </div>
        <div>
            <form id="mcform" method="POST">
                <input type="hidden" value="MaterialCostForm" name="action" />
                <div data-role="fieldcontain">
                    <input type='hidden' name='projectname' id='projectname' />
                    <label for="projectid">项目：</label>
                    <select name="projectid" id="projectid" onchange="changepro(this.value)">
                        <option value='-1'>请选择项目</option>
                    </select>
                    <label for="buildingno">栋号：</label>
                    <select name="buildingno" id="buildingno">
                        <option value="-1">请选择栋号</option>
                    </select>
                    <label for="curdate">日期：</label>
                    <input type="text" name='curdate' id="curdate" data-role="date" />
                    <label for="teamleader">班组：</label>
                    <select name="teamleader" id="teamleader">
                        <option value="-1">请选择班组</option>
                    </select>
                    <label for="materialname">材料名称：</label>
                    <input type="text" name='materialname' id='materialname' placeholder="材料名称" />
                    <label for="unit">单位：</label>
                    <input type="text" name='unit' id='unit' placeholder="单位" />
                    <label for="price">单价：</label>
                    <input type="text" name='price' id='price' placeholder="单价" onblur="check(this)" onkeyup="this.value=this.value.replace(/[^0-9.]/g,'')" />
                    <label for="number">数量：</label>
                    <input type="text" name='number' id='number' placeholder="数量" onblur="check(this)" onkeyup="this.value=this.value.replace(/[^0-9.]/g,'')" />
                    <label for="totalprice">小计：</label>
                    <input type="text" name='totalprice' id='totalprice' placeholder="小计" readonly="readonly" />
                    <label for="remarkbyworker">备注：</label>
                    <textarea cols="40" rows="18" id="remarkbyworker" name="remarkbyworker" placeholder="备注"></textarea>
                     <label id="piclabel">附件</label>
                    <input type="file" name="pic" id="pic"  />
                    <h3 id="notification"></h3>
                    <button data-theme="b" type="submit">提交报告</button>
                </div>
            </form>
        </div>
    </div>
</body>
</html>
