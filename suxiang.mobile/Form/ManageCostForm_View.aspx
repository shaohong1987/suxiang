<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ManageCostForm_View.aspx.cs" Inherits="suxiang.mobile.Form.ManageCostForm_View" %>

<!DOCTYPE html>
<html>
<head>
    <title>网上办公</title>
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <link rel="stylesheet" href="../Content/css/jquery.mobile-1.4.5.min.css"/>
    <link rel="stylesheet" href="../Content/css/jquery.mobile.datepicker.css"/>
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
                url: "../Handler/Process.ashx?action=getdata&type=cost_management&formid=" + formid,
                cache: false,
                success: function (data) {
                    var d = JSON.parse(data);
                    $("#formId").val(d[0].id);
                    $("#addr").val(d[0].projectname);
                    $("#curdate").val(jsonDateFormat(d[0].curdate));
                    $("#type").val(d[0].type);
                    $("#content").val(d[0].content);
                    $("#unit").val(d[0].unit);
                    $("#price").val(d[0].price);
                    $("#number").val(d[0].number);
                    $("#totalprice").val(d[0].totalprice);
                    $("#remarkbyaccount").val(d[0].remarkbyaccount);
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
            <h1>浏览——管理成本记录</h1>
        </div>
        <div data-role="content">
            <form id="managecostForm">
                <div data-role="fieldcontain">
                    <input type='hidden' name='projectname' id='projectname' />
                    <label for="addr">地点：</label>
                    <input type="text" id="addr" placeholder="地点"  readonly="readonly"/>
                    <label for="curdate">日期：</label>
                    <input type="text" name='curdate' id="curdate"  readonly="readonly"/>
                    <label for="type">类别：</label>
                    <input type="text" name='type' id='type' placeholder="类别"  readonly="readonly"/>
                    <label for="content">内容：</label>
                    <input type="text" name='content' id='content' placeholder="内容"  readonly="readonly"/>
                    <label for="content">单位：</label>
                    <input type="text" name='unit' id='unit' placeholder="单位"  readonly="readonly"/>
                    <label for="price">单价：</label>
                    <input type="text" name='price' id="price" placeholder="单价"  readonly="readonly"/>
                    <label for="number">数量：</label>
                    <input type="text" name='number' id='number' placeholder="数量"  readonly="readonly"/>
                    <label for="totalprice">总价：</label>
                    <input type="text" name='totalprice' id='totalprice' placeholder="总价" readonly="readonly" />
                    <label for="remarkbyaccount">说明：</label>
                    <textarea cols="40" rows="8" id="remarkbyaccount" name="remarkbyaccount" placeholder="说明"  readonly="readonly"></textarea>
                    <label for="remarkbyaccount">备注：</label>
                    <textarea cols="40" rows="8" id="remark" name="remark" placeholder="备注"  readonly="readonly"></textarea>
                    <label for="summary">总结：</label>
                    <textarea cols="40" rows="8" id="summary" name="summary" placeholder="总结"  readonly="readonly"></textarea>
                </div>
            </form>
        </div>
    </div>
</body>
</html>
