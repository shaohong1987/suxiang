<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="QualityQuestionForm_Remark.aspx.cs" Inherits="suxiang.mobile.Form.QualityQuestionForm_Remark" %>

<!DOCTYPE html>
<html>
<head>
    <title>网上办公</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="../Content/css/jquery.mobile-1.4.5.min.css">
    <script src="../Content/js/jquery.min.js"></script>
    <script src="../Content/js/jquery.mobile-1.4.5.min.js"></script>
    <script type="text/javascript">
        $(document)
            .ready(function() {
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
                    $("#worktimecost_db").val(d[0].worktimecost_db);
                    $("#worktimecost_xb").val(d[0].worktimecost_xb);
                    $("#materialcost").val(d[0].materialcost);
                    if (d[0].attachment.length > 0) {
                        $("#pic").attr("src", "../uploads/" + d[0].attachment);
                    } else {
                        $("#pic").remove();
                    }
                    $("#levelno").val(d[0].levelno);
                    if (d[0].levelno == "3") {
                        $("#levelno").val('三级');
                    }
                    if (d[0].levelno == "4") {
                        $("#levelno").val('四级');
                    }
                    if (d[0].levelno == "5") {
                        $("#levelno").val('五级');
                    }
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
</head>
<body>
   <div data-role="page">
        <div data-role="header" data-position="fixed">
            <a href="ToDo.aspx" target="_self" class="ui-btn ui-btn-left ui-alt-icon ui-nodisc-icon ui-corner-all ui-btn-icon-notext ui-icon-carat-l">Back</a>
            <h1>备注——质量问题报告</h1>
        </div>
        <div data-role="content">
            <form id="sqform"> 
                <div data-role="fieldcontain">
                    <input type="hidden" id="formId" value="-1"/>
                    <input type="hidden" id="formtype" value="problem_quality"/>
                    <input type="hidden" value="doRemark" name="action" />
                    <input type='hidden' name='projectname' id='projectname' />
                    <label for="addr">具体部位：</label>
                    <input type="text" name='addr' id="addr" readonly="readonly"/>
                    <label for="checkdate">检查日期：</label> 
                    <input type="text" name='checkdate' id="checkdate" readonly="readonly" />
                    <label for="finishdate">整改完成时间：</label> 
                    <input type="text" name='finishdate' id="finishdate" readonly="readonly"/>
                    <label for="problemdescription">问题说明：</label>
                    <textarea cols="40" rows="18" name="problemdescription" id="problemdescription" readonly="readonly"></textarea>
                    <label for="causation">原因分析：</label>
                    <textarea cols="40" rows="18" name="causation" id="causation" readonly="readonly"></textarea>
                    <label for="teamleader">班组：</label>
                    <input type="text" name='teamleader' id="teamleader" readonly="readonly"/>
                    <label for="worker">施工人员：</label>
                    <input type="text" name='worker' id="worker" readonly="readonly"/>
                    <label for="responsibleperson1">质量员：</label>
                    <input type="text" name='responsibleperson1' id="responsibleperson1" readonly="readonly"/>
                    <label for="responsibleperson2">责任人员：</label>
                    <input type="text" name='responsibleperson2' id="responsibleperson2" readonly="readonly"/>  
                    <label for="rebuildsolution">整改方案：</label>
                    <textarea cols="40" rows="18" id="rebuildsolution" name="rebuildsolution" readonly="readonly"></textarea>
                    <label for="rebuilder">整改班组：</label>
                    <input type="text" name='rebuilder' id="rebuilder" readonly="readonly"/>
                    <label for="levelno">质量等级：</label>
                    <input type="text" name='levelno' id="levelno" readonly="readonly" />
                    <label for="worktimecost_db">耗费工时（大工）：</label>
                    <input type="text" name='worktimecost_db' id="worktimecost_db" readonly="readonly" />
                    <label for="worktimecost_xb">耗费工时（小工）：</label>
                    <input type="text" name='worktimecost_xb' id="worktimecost_xb"readonly="readonly" />
                    <label for="materialcost">耗费材料：</label>
                    <input type="text" name='materialcost' id="materialcost" readonly="readonly" />
                    
                    <img  id="pic" width="98%"/>
                    <label for="remark">备注：</label>
                    <textarea cols="40" rows="18" id="remark" name="remark"></textarea>
                    <h3 id="notification"></h3>
                    <button data-theme="b" type="button" onclick="doRemark();">确认提交</button>
                </div>
            </form>
        </div>
    </div>
</body>
</html>
