<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="LaborCostForm_Remark.aspx.cs" Inherits="suxiang.Form.LaborCostForm_Remark" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="../content/css/style.css" rel="stylesheet" type="text/css" />
    <link href="../Content/css/select.css" rel="stylesheet" type="text/css" />
    <script src="../content/js/jquery-1.11.1.min.js" type="text/javascript"></script>
    <script src="../Content/js/select-ui.min.js" type="text/javascript"></script>
    <script src="../Content/js/My97/WdatePicker.js" type="text/javascript"></script>
    <script src="../Content/js/jquery.validate.min.js" type="text/javascript"></script>
    <script type="text/javascript">
        $(document)
            .ready(function() {
                $(".placeul").html("<li><a>各类表单</a></li><li><a>用工成本表</a></li>");
                $.ajax({
                    type: "POST",
                    url: "../Handler/Process.ashx?action=getdata&type=cost_labor&formid=1",
                    cache: false,
                    success: function (data) {
                        var d = JSON.parse(data);
                        alert(d[0].id);
                    },
                    error: function(data) {
                        var json = JSON.parse(data);
                        alert(json.Msg);
                    }
                });
            });
            </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <form class="formbody" id="lcform">
    <input type="hidden" value="LaborCostForm" name="action" />
    <div id="usual1" class="usual">
        <input type="hidden" id="formId" value="-1"/>
        <ul class="forminfo">
            <li>
                <label>地点</label>
                <input type="text" id='totalprice' placeholder="地点" readonly="readonly" class="dfinput" />
                 </li>
            <li>
                <label>
                    开始日期
                </label>
                <input type="text" name="startdate" id="startdate" placeholder="开始日期" class="dfinput"
                    readonly="readonly"  />
            </li>
            <li>
                <label>
                    结束日期
                </label>
                <input type="text" name="endate" id="endate" placeholder="结束日期" class="dfinput"
                    readonly="readonly"  />
            </li>
            <li>
                <label>
                    工种/班组
                </label>            
                <input type="text" name="worktype" placeholder="工种" class="dfinput" style="width: 169px;" readonly="readonly"/>
                <input type="text" name="teamleader" placeholder="班组" class="dfinput" style="width: 169px;" readonly="readonly"/>       
            </li>
            <li>
                <label>
                    工作内容
                </label>
                <input type="text" name="workcontent" placeholder="工作内容" class="dfinput" readonly="readonly"/>
            </li>
            <li>
                <label>
                    单位
                </label>
                <input type="text" name='unit' id='unit' placeholder="单位" class="dfinput" readonly="readonly"/>
            </li>
            <li>
                <label>单价</label>
                <input type="text" class="dfinput" name='price' id='price' placeholder="单价" readonly="readonly" />
            </li>
            <li>
                <label>工作量</label>
                <input type="text" class="dfinput" name='number' id='number' placeholder="工作量" readonly="readonly"/>
            </li>
            <li>
                <label>小计</label>
                <input type="text" name='totalprice' id='totalprice' placeholder="小计" readonly="readonly"
                    class="dfinput" />
            </li>
            <li>
                <label>说明</label>
                <textarea class="textinput2" name="remarkbywork" placeholder="说明" readonly="readonly"></textarea>
            </li>
              <li>
                <label>备注</label>
                <textarea class="textinput2" name="remark" placeholder="备注"></textarea>
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
