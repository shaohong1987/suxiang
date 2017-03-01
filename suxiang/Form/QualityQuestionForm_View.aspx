﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
    CodeBehind="QualityQuestionForm_View.aspx.cs" Inherits="suxiang.Form.QualityQuestionForm_View" %>

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
                $(".placeul").html("<li><a  href='Complete.aspx'>已处理</a></li><li><a>质量问题表</a></li>");
                $(".select3").uedSelect({
                    width: 80
                });
                var formid = GetQueryString('formId');
                $("#formId").val(formid);
            $.ajax({
                type: "POST",
                url: "../Handler/Process.ashx?action=getdata&type=problem_quality&formid=" + formid,
                cache: false,
                success: function (data) {
                    var d = JSON.parse(data);
                    $("#formId").val(d[0].id);
                    $("#addr").val(d[0].projectname + d[0].buildingno + '栋' + d[0].location);
                    $("#checkdate").val(jsonDateFormat(d[0].checkdate));
                    $("#finishdate").val(jsonDateFormat(d[0].finishdate));
                    $("#problemdescription").val(d[0].problemdescription);
                    $("#causation").val(d[0].causation);
                    $("#teamleader").val(d[0].teamleader);
                    $("#worker").val(d[0].worker);
                    $("#responsibleperson1").val(d[0].responsibleperson1);
                    $("#responsibleperson2").val(d[0].responsibleperson2);
                    $("#rebuildsolution").val(d[0].rebuildsolution);
                    $("#rebuilder").val(d[0].rebuilder);
                    if (d[0].treatmentmeasures == "0") {
                        $("#treatmentmeasures").val('正在进行');
                    }
                    if (d[0].treatmentmeasures == "-1") {
                        $("#treatmentmeasures").val('未完成');
                    }
                    if (d[0].treatmentmeasures == "1") {
                        $("#treatmentmeasures").val('已完成');
                    }
                    $("#worktimecost_db").val(d[0].worktimecost_db);
                    $("#worktimecost_xb").val(d[0].worktimecost_xb);
                    $("#materialcost").val(d[0].materialcost);
                    $("#rechecker").val(d[0].rechecker); 
                    if (d[0].levelno == "3") {
                        $("#levelno").val('三级');
                    }
                    if (d[0].levelno == "4") {
                        $("#levelno").val('四级');
                    }
                    if (d[0].levelno == "5") {
                        $("#levelno").val('五级');
                    }
                    $("#remark").val(d[0].remark);
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
    <form class="formbody" id="sqform">
    <input type="hidden" id="formId" value="-1"/>
    <div id="usual1" class="usual">
        <ul class="forminfo">
            <li>
                <label>
                    具体部位
                </label>
                <input type="text" name="addr" id="addr" placeholder="地点" class="dfinput" readonly="readonly"/>
            </li>
            <li>
                <div>
                    <label>
                        检查日期 
                    </label>
                    <input type="text" name="checkdate" id="checkdate" placeholder="检查日期" class="dfinput" readonly="readonly"style="width: 126px;" />
                    整改完成时间 
                    <input type="text" name="finishdate" id="finishdate" placeholder="完成时间" class="dfinput"
                       readonly="readonly" style="width: 126px;" /></div>
            </li>
            <li>
                <label>
                    问题说明 
                </label>
                <input type="text" id="problemdescription" placeholder="问题说明" class="dfinput" readonly="readonly"/>
            </li>
            <li>
                <label>
                    原因分析 
                </label>
                <textarea class="textinput2" id="causation" placeholder="原因分析" readonly="readonly"></textarea>
            </li>
            <li>
                <label>
                    班组/施工人员 
                </label>
                <input type="text" id="teamleader" placeholder="施工人员" class="dfinput" style="width: 169px;" readonly="readonly"/>
                <input type="text" id="worker" placeholder="施工人员" class="dfinput" style="width: 169px;" readonly="readonly"/>
            </li>
            <li>
                <label>
                    管理责任人 
                </label>
                <input type="text" id="responsibleperson1" placeholder="质量员" class="dfinput" style="width: 169px;" readonly="readonly"/>
                <input type="text" id="responsibleperson2" placeholder="栋号长/生产经理" class="dfinput" style="width: 169px;" readonly="readonly"/>
            </li>
            <li>
                <label>
                    整改方案 
                </label>
                <textarea class="textinput2" id="rebuildsolution" placeholder="整改方案" readonly="readonly"></textarea>
            </li>
           <li>
                <div style="float: left;">
                    <label>
                        整改人员 
                    </label>
                    <input type="text" id="rebuilder" placeholder="整改人员" readonly="readonly" class="dfinput" style="width: 208px;" />
                    处理结果</div>
                <div style="float: left; margin-left: 5px;">
                    <input type="text" id="treatmentmeasures" placeholder="处理结果" class="dfinput" style="width: 80px;" readonly="readonly"/>
                </div>
            </li>
            <li>
                <label>
                    耗费工时 
                </label>
                <input type="text" id="worktimecost_db" placeholder="整改花费工时（数字）" class="dfinput"
                    readonly="readonly" style="width: 140px; margin-right: 3px;" />大工
                <input type="text" id="worktimecost_xb" placeholder="整改花费工时（数字）" class="dfinput"
                    readonly="readonly" style="width: 140px; margin-right: 3px;
                    margin-left: 6px;" />小工 </li>
            <li>
                <label>
                    耗费材料 
                </label>
                <textarea class="textinput3" id="materialcost" placeholder="整改耗费材料" readonly="readonly"></textarea>
            </li>
              <li>
                <div style="float: left;">
                    <label>
                        复查人员 
                    </label>
                    <input type="text" id="rechecker" placeholder="复查人员" readonly="readonly" class="dfinput" style="width: 208px" />
                    质量等级
                </div>
                <div style="float: left; margin-left: 5px;">
                    <input type="text" id="levelno" placeholder="质量等级" class="dfinput" style="width: 80px" readonly="readonly"/>
                </div>
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