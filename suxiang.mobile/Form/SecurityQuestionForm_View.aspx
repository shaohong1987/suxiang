<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SecurityQuestionForm_View.aspx.cs" Inherits="suxiang.mobile.Form.SecurityQuestionForm_View" %>

<!DOCTYPE html>
<html>
<head>
    <title>网上办公</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="../Content/css/jquery.mobile-1.4.5.min.css">
    <link rel="stylesheet" href="../Content/css/jquery.mobile.datepicker.css">
    <script src="../Content/js/jquery.min.js"></script>
    <script src="../Content/js/jquery.mobile-1.4.5.min.js"></script>
    <script src="../Content/js/jquery.ui.datepicker.js"></script>
    <script src="../Content/js/jquery.mobile.datepicker.js"></script>
    <script type="text/javascript">
        $(document).ready(function() {
            var formid = GetQueryString('formId');
            $("#formId").val(formid);
            $.ajax({
                type: "POST",
                url: "../Handler/Process.ashx?action=getdata&type=problem_sercurity&formid=" + formid,
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
                    $("#levelno").val(d[0].levelno);
                    if (d[0].attachment.length>0) {
                        $("#pic").attr("src", "../uploads/" + d[0].attachment);
                    } else {
                        $("#pic").remove();
                    }
                    if (d[0].levelno == "3") {
                        $("#levelno").val('三级');
                    }
                    if (d[0].levelno == "2") {
                        $("#levelno").val('四级');
                    }
                    if (d[0].levelno == "3") {
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
</head>
<body>
    <div data-role="page">
        <div data-role="header" data-position="fixed">
            <a href="Complete.aspx" target="_self" class="ui-btn ui-btn-left ui-alt-icon ui-nodisc-icon ui-corner-all ui-btn-icon-notext ui-icon-carat-l" data-rel="back">Back</a>
            <h1>浏览——安全问题报告</h1>
        </div>
        <div data-role="content">
            <form id="securityform">
                <div data-role="fieldcontain">
                    <input type='hidden' name='projectname' id='projectname' />
                    <label for="addr">具体部位：</label>
                    <input type="text" name='addr' id="addr" readonly="readonly"/>
                    <label for="checkdate">检查日期：</label> 
                    <input type="text" name='checkdate' id="checkdate" readonly="readonly" />
                    <label for="finishdate">整改完成时间：</label> 
                    <input type="text" name='finishdate' id="finishdate" readonly="readonly"/>
                    <label for="problemdescription">问题说明：</label>
                    <textarea cols="40" rows="8" name="problemdescription" id="problemdescription"></textarea>
                    <label for="causation">原因分析：</label>
                    <textarea cols="40" rows="8" name="causation" id="causation"></textarea>
                    <label for="teamleader">班组：</label>
                    <input type="text" name='teamleader' id="teamleader" readonly="readonly"/>
                    <label for="worker">施工人员：</label>
                    <input type="text" name='worker' id="worker" readonly="readonly"/>
                    <label for="responsibleperson1">安全员：</label>
                    <input type="text" name='responsibleperson1' id="responsibleperson1" readonly="readonly"/>
                    <label for="responsibleperson2">责任人员：</label>
                   <input type="text" name='responsibleperson2' id="responsibleperson2" readonly="readonly"/>  
                    <label for="rebuildsolution">整改方案：</label>
                    <textarea cols="40" rows="8" id="rebuildsolution" name="rebuildsolution"></textarea>
                    <label for="rebuilder">整改人员：</label>
                    <input type="text" name='rebuilder' id="rebuilder" readonly="readonly"/>
                    <label for="treatmentmeasures">处理结果：</label>
                    <input type="text" name='treatmentmeasures' id="treatmentmeasures" readonly="readonly"/>
                    <label for="worktimecost_db">耗费工时（大工）：</label>
                    <input type="text" name='worktimecost_db' id="worktimecost_db" readonly="readonly" />
                    <label for="worktimecost_xb">耗费工时（小工）：</label>
                    <input type="text" name='worktimecost_xb' id="worktimecost_xb"readonly="readonly" />
                    <label for="materialcost">耗费材料：</label>
                    <input type="text" name='materialcost' id="materialcost" readonly="readonly" />
                    <label for="rechecker">复查人员：</label>
                    <input type="text" name='rechecker' id="rechecker" readonly="readonly" />
                    <label for="levelno">安全等级：</label>
                    <input type="text" name='levelno' id="levelno" readonly="readonly" />
                    <img  id="pic"/>
                    <label for="remark">备注：</label>
                    <textarea cols="40" rows="8" id="remark" name="remark"></textarea>
                    <label for="remark">总结：</label>
                    <textarea cols="40" rows="8" id="summary" name="summary"></textarea>
                </div>
            </form>
        </div>
    </div>
</body>
</html>
