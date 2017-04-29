<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ManageCostForm.aspx.cs" Inherits="suxiang.mobile.Form.ManageCostForm" %>

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
            $.post("../Handler/Process.ashx", { action: "GetProjects" }, function (data) {
                var json = eval(data);
                if (json.State === true) {
                    $.each(json.Data, function (i, item) {
                        $("#projectid").append("<option value='" + item['Id'] + "'>" + item['Projectname'] + "</option>");
                    });
                }
            },
                "json");
        });

        function doPost() {
            if ($("#projectname").val() == '' || $("#projectname").val() == '' || $("#curdate").val() == '' || $("#type").val() == ''
            || $("#unit").val() == '' || $("#price").val() == '' || $("#number").val() == '' || $("#totalprice").val() == '' || $("#content").val() == '') {
                alert('请将数据填写完整,谢谢!');
                return false;
            }
            var v1 = parseFloat($("#number").val());
            var v2 = parseFloat($("#price").val());
            $("#totalprice").val(v1 * v2);
            //var formData = $("#managecostForm").serialize();
            var formData = new FormData(document.getElementById("managecostForm"));
            $.ajax({
                type: "POST",
                url: "../Handler/process.ashx?action=ManageCostForm",
                processData: false,  // 告诉jQuery不要去处理发送的数据
                contentType: false,   // 
                data: formData,
                success: function (data) {
                    var json = JSON.parse(data);
                    alert(json.Msg);
                    if (json.State === true) {
                        window.open("ManageCostForm.aspx", "_self");
                    }
                },
                error: function (data) {
                    var json = JSON.parse(data);
                    alert(json.Msg);
                }
            });
            return false;
        }

        function changepro() {
            $("#projectname").val($('#projectid').find("option:selected").text());
        }

        function check(e) {
            var re = /^\d+(?=\.{0,1}\d+$|$)/;
            if (e.value != "") {
                if (!re.test(e.value)) {
                    alert("请输入正确的数字");
                    e.value = "";
                    e.focus();
                }
            }
            var v1 = parseFloat($("#number").val());
            var v2 = parseFloat($("#price").val());
            $("#totalprice").val(v1 * v2);
        }
    </script>
</head>
<body>
    <div data-role="page">
        <div data-role="header" data-position="fixed">
            <a href="NewForm.aspx" target="_self" class="ui-btn ui-btn-left ui-alt-icon ui-nodisc-icon ui-corner-all ui-btn-icon-notext ui-icon-carat-l">Back</a>
            <h1>填写——管理成本记录</h1>
        </div>
        <div data-role="content">
            <form id="managecostForm">
                <div data-role="fieldcontain">
                    <input type='hidden' name='projectname' id='projectname' />
                    <label for="projectid">地点：</label>
                    <select name="projectid" id="projectid" onchange="changepro(this.value)">
                        <option value='-1'>请选择项目</option>
                    </select>
                    <label for="curdate">日期：</label>
                    <input type="text" name='curdate' id="curdate" data-role="date" />
                    <label for="type">类别：</label>
                    <input type="text" name='type' id='type' placeholder="类别" />
                    <label for="content">内容：</label>
                    <input type="text" name='content' id='content' placeholder="内容" />
                    <label for="content">单位：</label>
                    <input type="text" name='unit' id='unit' placeholder="单位" />
                    <label for="price">单价：</label>
                    <input type="text" name='price' id="price" placeholder="单价" onblur="check(this)" onkeyup="this.value=this.value.replace(/[^0-9.]/g,'')" />
                    <label for="number">数量：</label>
                    <input type="text" name='number' id='number' placeholder="数量" onblur="check(this)" onkeyup="this.value=this.value.replace(/[^0-9.]/g,'')" />
                    <label for="totalprice">小计：</label>
                    <input type="text" name='totalprice' id='totalprice' placeholder="小计" readonly="readonly" />
                    <label for="remarkbyaccount">备注：</label>
                    <textarea cols="40" rows="18" id="remarkbyaccount" name="remarkbyaccount" placeholder="备注"></textarea>
                     <label id="piclabel">附件</label>
                    <input type="file" name="pic" id="pic"  />
                    <h3 id="notification"></h3>
                    <button data-theme="b" id="submit" type="button" onclick="doPost()">提交</button>
                </div>
            </form>
        </div>
    </div>
</body>
</html>
