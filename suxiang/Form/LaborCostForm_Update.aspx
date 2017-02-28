<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="LaborCostForm_Update.aspx.cs" Inherits="suxiang.Form.LaborCostForm_Update" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="../content/css/style.css" rel="stylesheet" type="text/css" />
    <script src="../content/js/jquery-1.11.1.min.js" type="text/javascript"></script>
    <script src="../Content/js/jquery.validate.min.js" type="text/javascript"></script>
    <script src="../Content/js/My97/WdatePicker.js" type="text/javascript"></script>
    <script type="text/javascript">
        $(document)
            .ready(function() {
                $(".placeul").html("<li><a href='ToDo.aspx'>待处理</a></li><li><a>用工成本表</a></li>");
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
            </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <form class="formbody" id="lcform"> 
    <div id="usual1" class="usual">
        <input type="hidden" id="formId" value="-1" name="formId"/>
        <input type="hidden" value="doLaborCostUpdate" name="action" />
        <ul class="forminfo">
            <li>
                <label>地点</label>
                <input type="text" name='addr' id="addr" placeholder="地点" readonly="readonly" class="dfinput" />
                 </li>
            <li>
                <label>
                    开始日期
                </label>
                <input type="text" name="startdate" id="startdate" placeholder="开始日期" class="dfinput" onclick="WdatePicker()"/>
            </li>
            <li>
                <label>
                    结束日期
                </label>
                <input type="text" name="endate" id="endate" placeholder="结束日期" class="dfinput" onclick="WdatePicker()"/>
            </li>
            <li>
                <label>
                    工种/班组
                </label>            
                <input type="text" name="worktype" id="worktype" placeholder="工种" class="dfinput" style="width: 169px;" readonly="readonly"/>
                <input type="text" name="teamleader" id="teamleader" placeholder="班组" class="dfinput" style="width: 169px;" readonly="readonly"/>  
                <input type="hidden" name="teamleaderid" id="teamleaderid" value="-1"/>     
            </li>
            <li>
                <label>
                    工作内容
                </label>
                <input type="text" name="workcontent" id="workcontent" placeholder="工作内容" class="dfinput"/>
            </li>
            <li>
                <label>
                    单位
                </label>
                <input type="text" name='unit' id="unit" placeholder="单位" class="dfinput"/>
            </li>
            <li>
                <label>单价</label>
                <input type="text" class="dfinput" id="price"  name='price' placeholder="单价"/>
            </li>
            <li>
                <label>工作量</label>
                <input type="text" class="dfinput" id='number'  name='number' placeholder="工作量"/>
            </li>
            <li>
                <label>小计</label>
                <input type="text" name='totalprice' id='totalprice' placeholder="小计" class="dfinput" />
            </li>
            <li>
                <label>说明</label>
                <textarea class="textinput2" name="remarkbywork" id="remarkbywork" placeholder="说明"></textarea>
            </li>
            <li>
                <label>班组长备注</label>
                <textarea class="textinput2" name="comfirmremark" id="comfirmremark" placeholder="班组长备注" readonly="readonly"></textarea>
            </li>
            <li>
                <label>栋号长备注</label>
                <textarea class="textinput2" name="recomfirmremark" id="recomfirmremark" placeholder="栋号长备注" readonly="readonly"></textarea>
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
