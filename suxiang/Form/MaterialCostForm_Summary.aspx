<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
    CodeBehind="MaterialCostForm_Summary.aspx.cs" Inherits="suxiang.Form.MaterialCostForm_Summary" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="../content/css/style.css" rel="stylesheet" type="text/css" />
    <script src="../content/js/jquery-1.11.1.min.js" type="text/javascript"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            $(".placeul").html("<li><a>各类表单</a></li><li><a>材料成本表</a></li>");
            $.ajax({
                type: "POST",
                url: "../Handler/Process.ashx?action=getdata&type=cost_material&formid=1",
                cache: false,
                success: function (data) {
                    var d = JSON.parse(data);
                    $("#formId").val(d[0].id);
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

        function doRemark() {
            var r = $("#remark").val();
            var t = $("#formtype").val();
            var fid = $("#formId").val();
            if (r.length > 0) {
                $.ajax({
                    type: "POST",
                    url: "../Handler/Process.ashx",
                    data: { action: 'doRemark', type: t, formid: fid, remark: r },
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

        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <form class="formbody" id="mcform">
   <input type="hidden" id="formId" value="-1"/>
        <input type="hidden" id="formtype" value="cost_material"/>
        <input type="hidden" value="doRemark" name="action" />
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
                <label>
                    备注 
                </label>
                <textarea class="textinput2" id="remark" placeholder="备注"></textarea>
            </li>
            <li>
                <button type="button" class="btn" onclick="doRemark();">
                    确认保存
                </button>
            </li>
        </ul>
    </div>
    </form>
</asp:Content>
