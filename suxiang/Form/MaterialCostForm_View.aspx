<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
    CodeBehind="MaterialCostForm_View.aspx.cs" Inherits="suxiang.Form.MaterialCostForm_View" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="../content/css/style.css" rel="stylesheet" type="text/css" />
    <script src="../content/js/jquery-1.11.1.min.js" type="text/javascript"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            $(".placeul").html("<li><a href='Complete.aspx'>已处理</a></li><li><a>材料成本表</a></li>");
            var formid = GetQueryString('formId');
            $("#formId").val(formid);
            $.ajax({
                type: "POST",
                url: "../Handler/Process.ashx?action=getdata&type=cost_material&formid=" + formid,
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
                    $("#remark").val(d[0].remark);
                    $("#comfirmremark").val(d[0].comfirmremark);
                    $("#recomfirmremark").val(d[0].recomfirmremark);
                    $("#summary").val(d[0].summary);
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
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <form class="formbody" id="mcform">
   <input type="hidden" id="formId" value="-1"/>
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
                <label>班组长备注</label>
                <textarea class="textinput2" id="comfirmremark" placeholder="班组长备注" readonly="readonly"></textarea>
            </li>
            <li>
                <label>栋号长备注</label>
                <textarea class="textinput2" id="recomfirmremark" placeholder="栋号长备注" readonly="readonly"></textarea>
            </li>
             <li>
                <label>
                    备注 
                </label>
                <textarea class="textinput2" id="remark" placeholder="备注" readonly="readonly"></textarea>
            </li>
            <li>
                <label>总结</label>
                <textarea class="textinput2" id="summary" placeholder="总结" readonly="readonly"></textarea>
            </li>
        </ul>
    </div>
    </form>
</asp:Content>
