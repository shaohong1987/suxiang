<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="LaborCostForm_Update.aspx.cs" Inherits="suxiang.mobile.Form.LaborCostForm_Update" %>

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
        $(document).ready(function() {
                var formid = GetQueryString('formId');
                $("#formId").val(formid);
                $.ajax({
                    type: "POST",
                    url: "../Handler/Process.ashx?action=getdata&type=cost_labor&formid=" + formid,
                    cache: false,
                    success: function (data) {
                        var d = JSON.parse(data);
                        $("#formId").val(d[0].id);
                        $("#addr").val(d[0].projectname + d[0].buildingno+'栋');
                        $("#startdate").val(jsonDateFormat(d[0].startdate));
                        $("#endate").val(jsonDateFormat(d[0].endate));
                        $("#worktype").val(d[0].worktype);
                        $("#teamleader").val(d[0].teamleader);
                        $("#teamleaderid").val(d[0].teamleaderid);
                        $("#workcontent").val(d[0].workcontent);
                        $("#unit").val(d[0].unit);
                        $("#price").val(d[0].price);
                        $("#number").val(d[0].worktime);
                        $("#totalprice").val(d[0].totalprice);
                        $("#remarkbywork").val(d[0].remarkbywork);
                        $("#remark").val(d[0].remark);
                        $("#comfirmremark").val(d[0].comfirmremark);
                        $("#recomfirmremark").val(d[0].recomfirmremark);
                        if (d[0].attachment.length > 0) {
                            $("#pic").attr("src", "../uploads/" + d[0].attachment);
                        } else {
                            $("#pic").remove();
                        }
                    },
                    error: function(data) {
                        var json = JSON.parse(data);
                        alert(json.Msg);
                    }
                });

                $("#lcform").validate({
                    focusInvalid: false,
                    onkeyup: false,
                    submitHandler: function () {
                        var formData = $("#lcform").serialize();
                        $.ajax({
                            type: "POST",
                            url: "../Handler/Process.ashx",
                            cache: false,
                            data: formData,
                            success: function (data) {
                                var json = JSON.parse(data);
                                alert(json.Msg);
                                if (json.State === true) {
                                    window.open("ToDo.aspx", "_self");
                                }
                            },
                            error: function (data) {
                                var json = JSON.parse(data);
                                alert(json.Msg);
                            }
                        });
                    },
                    rules: {
                        startdate: "required",
                        endate: "required",
                        workteam: "required",
                        workcontent: "required",
                        unit: "required",
                        price: "required",
                        number: "required"
                    },
                    messages: {
                        startdate: "请选择开始日期",
                        endate: "请选择结束日期",
                        workteam: "请输入班组",
                        workcontent: "请输入材料名称",
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
        function GetQueryString(name) {
            var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)");
            var r = window.location.search.substr(1).match(reg);
            if (r != null) return unescape(r[2]); return null;
        }
        function jsonDateFormat(jsonDate) {
            try {
                var date = new Date(parseInt(jsonDate.replace("/Date(", "").replace(")/", ""), 10));
                var month = date.getMonth() + 1 < 10 ? "0" + (date.getMonth() + 1) : date.getMonth() + 1;
                var day = date.getDate() < 10 ? "0" + date.getDate() : date.getDate();
                return date.getFullYear() + "-" + month + "-" + day + " ";
            } catch (ex) {
                return "";
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
            <a href="ToDo.aspx" target="_self" class="ui-btn ui-btn-left ui-alt-icon ui-nodisc-icon ui-corner-all ui-btn-icon-notext ui-icon-carat-l">Back</a>
            <h1>更新——用工成本记录</h1>
        </div>
        <div data-role="content">
            <form id="lcform">
                <div data-role="fieldcontain">
                    <input type="hidden" id="formId" value="-1" name="formId"/>
                    <input type="hidden" value="doLaborCostUpdate" name="action" />
                    <label for="addr">地点：</label>
                    <input type="text" name='addr' id="addr" placeholder="地点" readonly="readonly" class="dfinput" />
                    <label for="startdate">开始日期：</label>
                    <input type="text" name='startdate' id="startdate" data-role="date" />
                    <label for="endate">结束日期：</label>
                    <input type="text" name='endate' id="endate" data-role="date" />
                    <label for="worktype">工种：</label>
                    <input type="text" name='worktype' id='worktype' placeholder="工种" />
                    <label for="teamleader">班组：</label>
                    <input type="text" name="teamleader" id="teamleader" placeholder="班组" readonly="readonly"/>  
                    <input type="hidden" name="teamleaderid" id="teamleaderid" value="-1"/>  
                    <label for="workcontent">工作内容：</label>
                    <input type="text" name='workcontent' id='workcontent' placeholder="工作内容" />
                    <label for="unit">单位：</label>
                    <input type="text" name='unit' id='unit' placeholder="单位" />
                    <label for="number">工作量：</label>
                    <input type="text" name='number' id='number' placeholder="工作量" onblur="check(this)" onkeyup="this.value=this.value.replace(/[^0-9.]/g,'')" />
                    <label for="price">单价：</label>
                    <input type="text" name='price' id="price" placeholder="单价" onblur="check(this)" onkeyup="this.value=this.value.replace(/[^0-9.]/g,'')" />
                    <label for="totalprice">小计：</label>
                    <input type="text" name='totalprice' id="totalprice" placeholder="小计" readonly="readonly" />
                    <label for="remarkbywork">说明：</label>
                    <textarea cols="40" id="remarkbywork" rows="18" name="remarkbywork" placeholder="说明" readonly="readonly"></textarea>
                    <label for="comfirmremark">班组备注：</label>
                    <textarea cols="40" id="comfirmremark" rows="18" name="comfirmremark" placeholder="班组备注" readonly="readonly"></textarea>
                    <label for="recomfirmremark">栋号长备注：</label>
                    <textarea cols="40" id="recomfirmremark" rows="18" name="recomfirmremark" placeholder="栋号长备注" readonly="readonly"></textarea>
                    <img  id="pic" width="98%"/>
                    <h3 id="notification"></h3>
                    <button data-theme="b" type="submit">更新</button>
                </div>
            </form>
        </div>
    </div>
</body>
</html>
