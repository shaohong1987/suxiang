﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="LaborCostForm_Comfirm.aspx.cs" Inherits="suxiang.mobile.Form.LaborCostForm_Comfirm" %>

<!DOCTYPE html>
<html>
<head>
    <title>网上办公</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="../Content/css/jquery.mobile-1.4.5.min.css">
    <link rel="stylesheet" href="../Content/css/jquery.mobile.datepicker.css">
    <link href="../Content/css/bootstrap.min.css" rel="stylesheet" />
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
                    url: "../Handler/Process.ashx?action=getdata&type=cost_labor&formid=" + formid,
                    cache: false,
                    success: function (data) {
                        var d = JSON.parse(data);
                        $("#formId").val(d[0].id);
                        $("#ids").val(d[0].projectid + "-" + d[0].buildingno);
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
                        if (d[0].attachment.length > 0) {
                            $("#pic").attr("src", "../uploads/" + d[0].attachment);
                        } else {
                            $("#pic").remove();
                        }
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

        function doComfirm(i) {
            var t = $("#formtype").val();
            var fid = $("#formId").val();
            var ids = $("#ids").val();
            var r = $("#comfirmremark").val();
            var ct = $("#comfirmType").val();
            $.ajax({
                type: "POST",
                url: "../Handler/Process.ashx",
                data: { action: 'doComfirm',comfirmType:ct, type: t, formid: fid, remark: r,ids:ids,cp:i },
                cache: false,
                success: function(data) {
                    var json = JSON.parse(data);
                    alert(json.Msg);
                    if (json.State === true) {
                        window.open("ToDo.aspx", "_self");
                    }
                },
                error: function(data) {
                    var json = JSON.parse(data);
                    alert(json.Msg);
                }
            });
        }
    </script>
</head>
<body>
    <div data-role="page">
        <div data-role="header" data-position="fixed">
            <a href="ToDo.aspx" target="_self" class="ui-btn ui-btn-left ui-alt-icon ui-nodisc-icon ui-corner-all ui-btn-icon-notext ui-icon-carat-l">Back</a>
            <h1>班组确认——用工成本记录</h1>
        </div>
        <div data-role="content">
            <form id="laborcostForm">
                <div data-role="fieldcontain">
                    <input type="hidden" id="formId" value="-1"/>
                    <input type="hidden" id="formtype" value="cost_labor"/>
                    <input type="hidden" value="doComfirm" id="action" />
                    <input type="hidden" value="comfirm" id="comfirmType" /> 
                    <input type="hidden" value="-1" id="ids" />
                    <label for="addr">地点：</label>
                    <input type="text" id='addr' placeholder="地点" readonly="readonly"/>
                    <label for="startdate">开始日期：</label>
                    <input type="text" name='startdate' id="startdate" readonly="readonly"/>
                    <label for="endate">结束日期：</label>
                    <input type="text" name='endate' id="endate" readonly="readonly"/>
                    <label for="worktype">工种：</label>
                    <input type="text" name='worktype' id='worktype' placeholder="工种" readonly="readonly"/>
                    <label for="teamleader">班组：</label>
                    <input type="text" id="teamleader" name="teamleader" placeholder="班组" readonly="readonly"/>   
                    <label for="workcontent">工作内容：</label>
                    <input type="text" name='workcontent' id='workcontent' placeholder="工作内容" readonly="readonly"/>
                    <label for="unit">单位：</label>
                    <input type="text" name='unit' id='unit' placeholder="单位" readonly="readonly"/>
                    <label for="number">工作量：</label>
                    <input type="text" name='number' id='number' placeholder="工作量" readonly="readonly"/>
                    <label for="price">单价：</label>
                    <input type="text" name='price' id="price" placeholder="单价" readonly="readonly"/>
                    <label for="totalprice">小计：</label>
                    <input type="text" name='totalprice' id="totalprice" placeholder="小计" readonly="readonly"/>
                    <label for="remarkbywork">说明：</label>
                    <textarea cols="40" rows="18" id="remarkbywork"  name="remarkbywork" placeholder="说明" readonly="readonly"></textarea>
                    <label for="comfirmremark">班组备注：</label>
                    <textarea cols="40" rows="18" id="comfirmremark"  name="comfirmremark" placeholder="班组备注"></textarea>
                    <img  id="pic" width="98%"/>
                    <h3 id="notification"></h3>
                    <p>
                    <button  class="btn btn-primary btn-sm" type="button" onclick="doComfirm(1);">确认</button>
                    <button  class="btn btn-primary btn-sm" type="button" onclick="doComfirm(0);">退回</button>
                    </p>
                </div>
            </form>
        </div>
    </div>
</body>
</html>
