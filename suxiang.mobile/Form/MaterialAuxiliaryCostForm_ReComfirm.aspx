﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MaterialAuxiliaryCostForm_ReComfirm.aspx.cs" Inherits="suxiang.mobile.Form.MaterialAuxiliaryCostForm_ReComfirm" %>

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
        $(document).ready(function () {
            var formid = GetQueryString('formId');
            $("#formId").val(formid);
            $.ajax({
                type: "POST",
                url: "../Handler/Process.ashx?action=getdata&type=cost_materialauxiliary&formid=" + formid,
                cache: false,
                success: function (data) {
                    var d = JSON.parse(data);
                    $("#formId").val(d[0].id);
                    $("#ids").val(d[0].projectid + "-" + d[0].buildingno);
                    $("#addr").val(d[0].projectname + d[0].buildingno + '栋');
                    $("#curdate").val(jsonDateFormat(d[0].curdate));
                    $("#teamleader").val(d[0].teamleader);
                    $("#materialname").val(d[0].materialname);
                    $("#unit").val(d[0].unit);
                    $("#price").val(d[0].price);
                    $("#number").val(d[0].number);
                    $("#totalprice").val(d[0].totalprice);
                    $("#remarkbyworker").val(d[0].remarkbyworker);
                    $("#comfirmremark").val(d[0].comfirmremark);
                    if (d[0].attachment.length > 0) {
                        $("#pic").attr("src", "../uploads/" + d[0].attachment);
                    } else {
                        $("#pic").remove();
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

        function doComfirm(i) {
            var t = $("#formtype").val();
            var fid = $("#formId").val();
            var ids = $("#ids").val();
            var r = $("#recomfirmremark").val();
            var ct = $("#comfirmType").val(); 
            $.ajax({
                type: "POST",
                url: "../Handler/Process.ashx",
                data: { action: 'doComfirm', comfirmType: ct, type: t, formid: fid, remark: r, ids: ids, cp: i },
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
    </script>
</head>
<body>
    <div>
        <div data-role="header" data-position="fixed">
            <a href="ToDo.aspx" target="_self"class="ui-btn ui-btn-left ui-alt-icon ui-nodisc-icon ui-corner-all ui-btn-icon-notext ui-icon-carat-l">Back</a>
            <h1>栋号长确认——材料成本记录</h1>
        </div>
        <div>
            <form id="materialcostForm" method="POST">
                <div data-role="fieldcontain">
                   <input type="hidden" id="formId" value="-1"/>
                   <input type="hidden" id="formtype" value="cost_materialauxiliary"/>
                   <input type="hidden" value="doComfirm" id="action" />
                   <input type="hidden" value="recomfirm" id="comfirmType" /> 
                   <input type="hidden" value="-1" id="ids" />
                    <label for="addr">项目：</label>
                    <input type="text" name="addr" id="addr" placeholder="项目" readonly="readonly"/>
                    <label for="curdate">日期：</label>
                    <input type="text" name='curdate' id="curdate" readonly="readonly"/>
                    <label for="teamleader">班组：</label>
                    <input type="text" name='teamleader' id='teamleader' placeholder="班组" readonly="readonly"/>
                    <label for="materialname">材料名称：</label>
                    <input type="text" name='materialname' id='materialname' placeholder="材料名称" readonly="readonly"/>
                    <label for="unit">单位：</label>
                    <input type="text" name='unit' id='unit' placeholder="单位" readonly="readonly"/>
                    <label for="price">单价：</label>
                    <input type="text" name='price' id='price' placeholder="单价" readonly="readonly"/>
                    <label for="number">数量：</label>
                    <input type="text" name='number' id='number' placeholder="数量" readonly="readonly"/>
                    <label for="totalprice">小计：</label>
                    <input type="text" name='totalprice' id='totalprice' placeholder="小计" readonly="readonly" />
                    <label for="remarkbyworker">说明：</label>
                    <textarea cols="40" rows="18" id="remarkbyworker" name="remarkbyworker" placeholder="说明" readonly="readonly"></textarea>
                    <label for="comfirmremark">班组长备注：</label>
                    <textarea cols="40" rows="18" id="comfirmremark" name="comfirmremark" placeholder="班组长备注" readonly="readonly"></textarea>
                    <label for="recomfirmremark">栋号长备注：</label>
                    <textarea cols="40" rows="18" id="recomfirmremark" name="recomfirmremark" placeholder="栋号长备注"></textarea>
                    <img  id="pic" width="98%"/>
                    <h3 id="notification"></h3>
                    <button data-theme="c" type="button" onclick='doComfirm(1);'>确认</button>
                    <button data-theme="c" type="button" onclick='doComfirm(0);'>退回</button>
                </div>
            </form>
        </div>
    </div>
</body>
</html>
