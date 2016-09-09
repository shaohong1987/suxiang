<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
    CodeBehind="SecurityQuestionForm.aspx.cs" Inherits="suxiang.Form.SecurityQuestionForm" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="../content/css/style.css" rel="stylesheet" type="text/css" />
    <link href="../Content/css/select.css" rel="stylesheet" type="text/css" />
    <script src="../content/js/jquery-1.11.1.min.js" type="text/javascript"></script>
    <script src="../Content/js/select-ui.min.js" type="text/javascript"></script>
    <script src="../Content/js/My97/WdatePicker.js" type="text/javascript"></script>
    <script type="text/javascript">
        $(document).ready(function (e) {
            $(".select1").uedSelect({
                width: 345
            });
            $(".select2").uedSelect({
                width: 167
            });
            $(".select3").uedSelect({
                width: 80
            });
        });
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="formbody">
        <div id="usual1" class="usual">
            <ul class="forminfo">
                <li>
                    <label>
                        地点</label><div class="vocation">
                            <select name="projectid" id="projectid" onchange="changepro(this.value)" class="select2">
                                <option value='-1'>选择项目</option>
                            </select>
                        </div>
                    <div class="vocation">
                        <select name="buildingno" id="buildingno" onchange="changebuilding(this.value)" class="select3">
                            <option value='-1'>选择栋号</option>
                        </select>
                    </div>栋
                    <input type="text" name='levelno' placeholder="层号/户型" class="dfinput" style="width: 80px;"/></li>
                <li>
                    <label>
                        详细位置<b>*</b></label>
                    <input type="text" name='location' placeholder="详细位置" class="dfinput" /></li>
                <li>
                    <label>
                        问题说明<b>*</b></label>
                    <textarea class="textinput2" name="details" placeholder="问题说明"></textarea></li>
                <li>
                    <label for="checktime">
                        检查日期<b>*</b></label>
                    <input type="text" name='checktime' id="checktime" placeholder="检查日期" class="dfinput"  onClick="WdatePicker()"/></li>
                <li>
                    <label for="buildingleader">
                        栋号长<b>*</b></label>
                    <input type="text" name='buildingleader' id='buildingleader' placeholder="栋号长" class="dfinput" /></li>
                <li>
                    <label>
                        施工人员/班组<b>*</b></label>
                    <input type="text" name='workers' placeholder="施工人员/班组" class="dfinput" /></li>
                <li>
                    <label>
                        责任人员<b>*</b></label>
                    <input type="text" name='managers' placeholder="责任人员" class="dfinput" /></li>
                <li>
                    <label>
                        处理措施,结果<b>*</b></label>
                    <textarea class="textinput2" name="results" placeholder="处理措施，结果" ></textarea></li>
                <li>
                    <label>
                        整改人员<b>*</b></label>
                    <input type="text" name='reworkers' placeholder="整改人员" class="dfinput" /></li>
                <li>
                    <label>
                        整改完成时间<b>*</b></label>
                    <input type="text" name='finishtime' id="finishtime" placeholder="完成时间" class="dfinput" onClick="WdatePicker()"/></li>
                <li>
                    <label>
                        整改花费工时<b>*</b></label>
                    <input type="text" name='costofworktime' placeholder="整改花费工时" class="dfinput" /></li>
                <li>
                    <label>
                        整改消耗材料<b>*</b></label>
                    <input type="text" name='costofmaterial' placeholder="整改消耗材料" class="dfinput" /></li>
                <li>
                    <label>
                        复查人员<b>*</b></label>
                    <input type="text" name='rechecker' placeholder="复查人员" class="dfinput" /></li>
                <li>
                    <button type="button" onclick="doPost()" class="btn">
                        确认保存
                    </button>
                </li>
            </ul>
        </div>
    </div>
</asp:Content>
