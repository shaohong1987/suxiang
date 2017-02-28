<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="MaterialAuxiliaryCostForm_Update.aspx.cs" Inherits="suxiang.Form.MaterialAuxiliaryCostForm_Update" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="../content/css/style.css" rel="stylesheet" type="text/css" />
    <script src="../content/js/jquery-1.11.1.min.js" type="text/javascript"></script>
    <script src="../Content/js/My97/WdatePicker.js" type="text/javascript"></script>
    <script src="../Content/js/jquery.validate.min.js" type="text/javascript"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            $(".placeul").html("<li><a href='ToDo.aspx'>待处理</a></li><li><a>材料成本表</a></li>");
            var formid = GetQueryString('formId');
            $("#formId").val(formid);
            $.ajax({
                type: "POST",
                url: "../Handler/Process.ashx?action=getdata&type=cost_materialauxiliary&formid=" + formid,
                cache: false,
                success: function (data) {
                    var d = JSON.parse(data);
                    $("#formId").val(d[0].id);
                    $("#addr").val(d[0].projectname + d[0].buildingno + '栋');
                    $("#curdate").val(jsonDateFormat(d[0].curdate));
                    $("#teamleader").val(d[0].teamleader);
                    $("#teamleaderid").val(d[0].teamleaderid);
                    $("#materialname").val(d[0].materialname);
                    $("#unit").val(d[0].unit);
                    $("#price").val(d[0].price);
                    $("#number").val(d[0].number);
                    $("#totalprice").val(d[0].totalprice);
                    $("#remarkbyworker").val(d[0].remarkbyworker);
                    $("#remark").val(d[0].remark);
                    $("#comfirmremark").val(d[0].comfirmremark);
                    $("#recomfirmremark").val(d[0].recomfirmremark);
                },
                error: function (data) {
                    var json = JSON.parse(data);
                    alert(json.Msg);
                }
            });


            $("#mcform").validate({
                focusInvalid: false,
                onkeyup: false,
                submitHandler: function () {
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
                    curdate: "required",
                    materialname: "required",
                    unit: "required",
                    price: "required",
                    number: "required"
                },
                messages: {
                    curdate: "请选择日期",
                    materialname: "请输入材料名称",
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
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <form class="formbody" id="mcform">
    <input type="hidden" id="formId" value="-1" name="formId"/>
    <input type="hidden" id="formtype" value="cost_materialauxiliary"/>
    <input type="hidden" value="doMaterialAuxiliaryCostUpdate" name="action" />
    <div id="usual1" class="usual">
        <ul class="forminfo">
            <li>
                <label>
                    地点
                </label>
                 <input type="text" name="addr" id="addr" placeholder="班组" class="dfinput" readonly="readonly"/>
                 </li>
            <li>
                <label>
                    日期 
                </label>
                <input type="text" name="curdate" id="curdate" placeholder="日期" class="dfinput" onclick="WdatePicker()"/>
            </li>
            <li>
                <label>
                    班组 
                </label>
                 <input type="text" name="teamleader" id="teamleader" placeholder="班组" class="dfinput"/>
                 <input type="hidden" id="teamleaderid" name="teamleaderid" value="-1"/>
            </li>
            <li>
                <label>
                    材料名称
                </label>
                <input type="text" id="materialname" name="materialname" placeholder="材料名称" class="dfinput"/>
            </li>
            <li>
                <label>
                    单位 
                </label>
                <input type="text" name='unit' id='unit' placeholder="单位" class="dfinput"/>
            </li>
            <li>
                <label>
                    单价 
                </label>
                <input type="text" class="dfinput" name='price' id='price' placeholder="单价"/>
            </li>
            <li>
                <label>
                    数量 
                </label>
                <input type="text" class="dfinput" name='number' id='number' placeholder="数量"/>
            </li>
            <li>
                <label>
                    小计 
                </label>
                <input type="text" name='totalprice' id='totalprice' placeholder="小计" class="dfinput" />
            </li>
            <li>
                <label>
                    说明 
                </label>
                <textarea class="textinput2" id="remarkbyworker" name="remarkbyworker" placeholder="说明"></textarea>
            </li>
             <li>
                <label>班组长备注</label>
                <textarea class="textinput2" id="comfirmremark" placeholder="班组长备注" readonly="readonly"></textarea>
            </li>
            <li>
                <label>栋号长备注</label>
                <textarea class="textinput2" id="recomfirmremark" placeholder="栋号长备注" readonly="readonly"></textarea>
            </li>
            <li>
                <button type="submit" class="btn">
                    更新
                </button>
            </li>
        </ul>
    </div>
    </form>
</asp:Content>
