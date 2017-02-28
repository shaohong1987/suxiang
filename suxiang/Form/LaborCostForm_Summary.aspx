<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="LaborCostForm_Summary.aspx.cs" Inherits="suxiang.Form.LaborCostForm_Summary" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="../content/css/style.css" rel="stylesheet" type="text/css" />
    <script src="../content/js/jquery-1.11.1.min.js" type="text/javascript"></script>
    <script src="../Content/js/jquery.validate.min.js" type="text/javascript"></script>
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

        function doSummary() {
            var r = $("#summary").val(); 
            var t = $("#formtype").val();
            var fid = $("#formId").val();
            if (r.length > 0) {
                $.ajax({
                    type: "POST",
                    url: "../Handler/Process.ashx",
                    data: { action: 'doSummary', type: t, formid: fid, summary: r },
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
    <form class="formbody" id="lcform">
    <div id="usual1" class="usual">
        <input type="hidden" id="formId" value="-1"/>
        <input type="hidden" id="formtype" value="cost_labor"/>
        <input type="hidden" value="doSummary" name="action" />
        <ul class="forminfo">
            <li>
                <label>地点</label>
                <input type="text" id='addr' placeholder="地点" readonly="readonly" class="dfinput" />
                 </li>
            <li>
                <label>
                    开始日期
                </label>
                <input type="text" id="startdate" placeholder="开始日期" class="dfinput"
                    readonly="readonly"  />
            </li>
            <li>
                <label>
                    结束日期
                </label>
                <input type="text" id="endate" placeholder="结束日期" class="dfinput"
                    readonly="readonly"  />
            </li>
            <li>
                <label>
                    工种/班组
                </label>            
                <input type="text" id="worktype" placeholder="工种" class="dfinput" style="width: 169px;" readonly="readonly"/>
                <input type="text" id="teamleader" placeholder="班组" class="dfinput" style="width: 169px;" readonly="readonly"/>       
            </li>
            <li>
                <label>
                    工作内容
                </label>
                <input type="text" id="workcontent" placeholder="工作内容" class="dfinput" readonly="readonly"/>
            </li>
            <li>
                <label>
                    单位
                </label>
                <input type="text" id='unit' placeholder="单位" class="dfinput" readonly="readonly"/>
            </li>
            <li>
                <label>单价</label>
                <input type="text" class="dfinput"  id='price' placeholder="单价" readonly="readonly" />
            </li>
            <li>
                <label>工作量</label>
                <input type="text" class="dfinput"  id='number' placeholder="工作量" readonly="readonly"/>
            </li>
            <li>
                <label>小计</label>
                <input type="text" id='totalprice' placeholder="小计" readonly="readonly"
                    class="dfinput" />
            </li>
            <li>
                <label>说明</label>
                <textarea class="textinput2" id="remarkbywork" placeholder="说明" readonly="readonly"></textarea>
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
                <label>备注</label>
                <textarea class="textinput2" id="remark" placeholder="备注" readonly="readonly"></textarea>
            </li>
            <li>
                <label>总结</label>
                <textarea class="textinput2" id="summary" placeholder="总结" ></textarea>
            </li>
            <li> 
                <button type="button" class="btn" onclick="doSummary();">
                    确认保存
                </button>
            </li>
        </ul>
    </div>
    </form>
</asp:Content>
