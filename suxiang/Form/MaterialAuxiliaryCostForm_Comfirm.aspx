<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="MaterialAuxiliaryCostForm_Comfirm.aspx.cs" Inherits="suxiang.Form.MaterialAuxiliaryCostForm_Comfirm" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="../content/css/style.css" rel="stylesheet" type="text/css" />
    <script src="../content/js/jquery-1.11.1.min.js" type="text/javascript"></script>
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
                    $("#ids").val(d[0].projectid + "-" + d[0].buildingno);
                    $("#addr").val(d[0].projectname + d[0].buildingno + '栋');
                    $("#curdate").val(jsonDateFormat(d[0].curdate));
                    $("#teamleader").val(d[0].teamleader);
                    $("#materialname").val(d[0].materialname);
                    $("#unit").val(d[0].unit);
                    $("#price").val(d[0].price);
                    $("#number").val(d[0].number);
                    $("#totalprice").val(d[0].totalprice);
                    $("#remarkbyworker").val(d[0].remarkbyworker);
                },
                error: function (data) {
                    var json = JSON.parse(data);
                    alert(json.Msg);
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

        function doComfirm(i) {
            var t = $("#formtype").val();
            var fid = $("#formId").val();
            var ids = $("#ids").val();
            var r = $("#comfirmremark").val();
            var ct = $("#comfirmType").val();
            $.ajax({
                type: "POST",
                url: "../Handler/Process.ashx",
                data: { action: 'doComfirm', comfirmType: ct, type: t, formid: fid, remark: r, ids: ids, cp: i },
                cache: false,
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
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <form class="formbody" id="mcform">
        <input type="hidden" id="formId" value="-1"/>
        <input type="hidden" id="formtype" value="cost_materialauxiliary"/>
        <input type="hidden" value="doComfirm" id="action" />
        <input type="hidden" value="comfirm" id="comfirmType" /> 
        <input type="hidden" value="-1" id="ids" />
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
                    日期<b>*</b>
                </label>
                <input type="text" name="curdate" id="curdate" placeholder="日期" class="dfinput" readonly="readonly"/>
            </li>
            <li>
                <label>
                    班组<b>*</b>
                </label>
                 <input type="text" name="teamleader" id="teamleader" placeholder="班组" class="dfinput" readonly="readonly"/>
            </li>
            <li>
                <label>
                    材料名称
                </label>
                <input type="text" id="materialname" placeholder="材料名称" class="dfinput" readonly="readonly"/>
            </li>
            <li>
                <label>
                    单位 
                </label>
                <input type="text" name='unit' id='unit' placeholder="单位" class="dfinput" readonly="readonly"/>
            </li>
            <li>
                <label>
                    单价 
                </label>
                <input type="text" class="dfinput" name='price' id='price' placeholder="单价"readonly="readonly"/>
            </li>
            <li>
                <label>
                    数量 
                </label>
                <input type="text" class="dfinput" name='number' id='number' placeholder="数量" readonly="readonly"/>
            </li>
            <li>
                <label>
                    小计 
                </label>
                <input type="text" name='totalprice' id='totalprice' placeholder="小计" readonly="readonly"
                    class="dfinput" />
            </li>
            <li>
                <label>
                    说明 
                </label>
                <textarea class="textinput2" id="remarkbyworker" placeholder="说明" readonly="readonly"></textarea>
            </li>
            <li>
                <label>确认备注</label>
                <textarea class="textinput2" id="comfirmremark" placeholder="选填，如退回请填写退回原因"></textarea>
            </li>
            <li>
                <button type="button" class="btn" onclick="doComfirm(1);">
                    确认
                </button>
                <button type="button" class="btn" onclick="doComfirm(0);">
                    退回
                </button>
            </li>
        </ul>
    </div>
    </form>
</asp:Content>
