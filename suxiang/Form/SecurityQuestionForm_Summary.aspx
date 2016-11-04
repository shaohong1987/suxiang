﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
    CodeBehind="SecurityQuestionForm_Summary.aspx.cs" Inherits="suxiang.Form.SecurityQuestionForm_Summary" %>


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
                $(".placeul").html("<li><a>各类表单</a></li><li><a>质量问题表</a></li>");
                $(".select3").uedSelect({
                    width: 80
                });
            $.ajax({
                type: "POST",
                url: "../Handler/Process.ashx?action=getdata&type=problem_sercurity&formid=1",
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
                        $("#treatmentmeasures").text('正在进行');
                    }
                    if (d[0].treatmentmeasures == "-1") {
                        $("#treatmentmeasures").val('未完成');
                        $("#treatmentmeasures").text('未完成');
                    }
                    if (d[0].treatmentmeasures == "1") {
                        $("#treatmentmeasures").val('已完成');
                        $("#treatmentmeasures").text('已完成');
                    }
                    $("#worktimecost_db").val(d[0].worktimecost_db);
                    $("#worktimecost_xb").val(d[0].worktimecost_xb);
                    $("#materialcost").val(d[0].materialcost);
                    $("#rechecker").val(d[0].rechecker); 
                    $("#levelno").val(d[0].levelno);
                    if (d[0].levelno == "1") {
                        $("#levelno").val('1');
                        $("#levelno").text('1');
                    }
                    if (d[0].levelno == "2") {
                        $("#levelno").val('2');
                        $("#levelno").text('2');
                    }
                    if (d[0].levelno == "3") {
                        $("#levelno").val('3');
                        $("#levelno").text('3');
                    }
                    $("#remark").val(d[0].remark);
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
            var r = $("#summary").val();
            var t = $("#formtype").val();
            var fid = $("#formId").val();
            if (r.length > 0) {
                $.ajax({
                    type: "POST",
                    url: "../Handler/Process.ashx",
                    data: { action: 'doRemark', type: t, formid: fid, summary: r },
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
    <form class="formbody" id="sqform">
    <input type="hidden" id="formId" value="-1"/>
        <input type="hidden" id="formtype" value="problem_sercurity"/>
        <input type="hidden" value="doRemark" name="action" />
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
                    整改完成时间<b>*</b>
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
                        整改人员<b>*</b>
                    </label>
                    <input type="text" name="rebuilder" placeholder="整改人员" class="dfinput" style="width: 208px;" />
                    处理结果</div>
                <div style="float: left; margin-left: 5px;">
                    <select name="treatmentmeasures" id="treatmentmeasures" class="select3">
                        <option value="-1">未完成</option>
                        <option value="0">进行中</option>
                        <option value="1">已完成</option>
                    </select>
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
                        复查人员<b>*</b>
                    </label>
                    <input type="text" name="rechecker" placeholder="复查人员" class="dfinput" style="width: 208px" />
                    安全等级
                </div>
                <div style="float: left; margin-left: 5px;">
                    <select name="levelno" id="levelno" class="select3">
                        <option value="1">一级</option>
                        <option value="2">二级</option>
                        <option value="3">三级</option>
                    </select>
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
                <textarea class="textinput2" id="summary" placeholder="总结" ></textarea>
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
