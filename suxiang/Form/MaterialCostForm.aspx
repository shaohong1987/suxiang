<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
    CodeBehind="MaterialCostForm.aspx.cs" Inherits="suxiang.Form.MaterialCostForm" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="../content/css/style.css" rel="stylesheet" type="text/css" />
    <link href="../Content/css/select.css" rel="stylesheet" type="text/css" />
    <script src="../content/js/jquery-1.11.1.min.js" type="text/javascript"></script>
    <script src="../Content/js/select-ui.min.js" type="text/javascript"></script>
    <script src="../Content/js/My97/WdatePicker.js" type="text/javascript"></script>
    <script src="../Content/js/jquery.validate.min.js" type="text/javascript"></script>
    <script type="text/javascript">
        
        var arr = new Array();
        $(document).ready(function () {
            $(".placeul").html("<li><a  href='NewForm.aspx'>各类表单</a></li><li><a>材料成本表</a></li>");
            $(".select1").uedSelect({
                width: 345
            });
            $(".select2").uedSelect({
                width: 167
            });
            $(".select3").uedSelect({
                width: 80
            });
            $(".select7").uedSelect({
                width: 347
            });
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
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <form class="formbody" id="mcform">
    <input type="hidden" value="MaterialCostForm" name="action" />
    <div id="usual1" class="usual">
        <ul class="forminfo">
            <li>
                <label>
                    地点
                </label>
                <div class="vocation">
                    <select name="projectid" id="projectid" onchange="changepro(this.value)" class="select2">
                        <option value="-1">请选择项目</option>
                    </select>
                    <input type="hidden" id="projectname" name="projectname" />
                </div>
                <div class="vocation" style="margin-left: 12px;">
                    <select name="buildingno" id="buildingno" class="select2">
                         <option value="-1">栋号</option>
                    </select>
                </div>
                 </li>
            <li>
                <label>
                    日期<b>*</b>
                </label>
                <input type="text" name="curdate" id="curdate" placeholder="日期" class="dfinput"
                    onclick="WdatePicker()" />
            </li>
            <li>
                <label>
                    班组<b>*</b>
                </label>
                <div class="vocation">
                    <select name="teamleader" id="teamleader" class="select7">
                        <option value="-1">请选择班组</option>
                    </select>
                </div>
            </li>
            <li>
                <label>
                    材料名称<b>*</b>
                </label>
                <input type="text" name="materialname" placeholder="材料名称" class="dfinput" />
            </li>
            <li>
                <label>
                    单位<b>*</b>
                </label>
                <input type="text" name='unit' id='unit' placeholder="单位" class="dfinput" />
            </li>
            <li>
                <label>
                    单价<b>*</b>
                </label>
                <input type="text" class="dfinput" name='price' id='price' placeholder="单价" onblur="check(this)"
                    onkeyup="this.value=this.value.replace(/[^0-9.]/g,'')" />
            </li>
            <li>
                <label>
                    数量<b>*</b>
                </label>
                <input type="text" class="dfinput" name='number' id='number' placeholder="数量" onblur="check(this)"
                    onkeyup="this.value=this.value.replace(/[^0-9.]/g,'')" />
            </li>
            <li>
                <label>
                    小计<b>*</b>
                </label>
                <input type="text" name='totalprice' id='totalprice' placeholder="小计" readonly="readonly"
                    class="dfinput" />
            </li>
            <li>
                <label>
                    备注<b>*</b>
                </label>
                <textarea class="textinput2" name="remarkbyworker" placeholder="备注"></textarea>
            </li>
            <li>
                <button type="submit" class="btn">
                    确认保存
                </button>
            </li>
        </ul>
    </div>
    </form>
</asp:Content>
