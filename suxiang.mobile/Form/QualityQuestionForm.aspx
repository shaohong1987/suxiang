<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="QualityQuestionForm.aspx.cs" Inherits="suxiang.mobile.Form.QualityQuestionForm" %>

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
        var arr = new Array();
        $(document).ready(function() {
                $.post("../Handler/Process.ashx",
                    { action: "GetBuildings" },
                    function(data) {
                        var json = eval(data);
                        if (json.State === true) {
                            $.each(json.Data,
                                function(i, item) {
                                    arr[i] = new Array();
                                    arr[i][0] = item['Projectid'];
                                    arr[i][1] = item['Buildingid'];
                                });
                        }
                    },
                    "json");

                $.post("../Handler/Process.ashx",
                    { action: "GetProjects" },
                    function(data) {
                        var json = eval(data);
                        if (json.State === true) {
                            $.each(json.Data,
                                function(i, item) {
                                    $("#projectid").append("<option value='" +item['Id'] +"'>" +item['Projectname'] +"</option>");
                                });
                        }
                    },
                    "json");
            });
        function doPost() {
            if ($("#projectname").val() == '' || $("#projectname").val() == '' || $("#buildingno").val() == '' || $("#buildingno").val() == '-1' || $("#levelno").val() == '' || $("#location").val() == ''
                || $("#details").val() == '' || $("#checktime").val() == '' || $("#buildingleader").val() == '' || $("#workers").val() == '' || $("#managers").val() == ''
                || $("#results").val() == '' || $("#reworkers").val() == '' || $("#finishtime").val() == '' || $("#costofworktime").val() == ''
                || $("#costofmaterial").val() == '' || $("#rechecker").val() == '') {
                alert('请将数据填写完整,谢谢!');
                return false;
            }
            var formData = $("#securityform").serialize();
            $.ajax({
                type: "POST",
                url: "../Handler/process.ashx?action=QualityQuestionForm",
                cache: false,
                data: formData,
                success: function (data) {
                    var json = JSON.parse(data);
                    alert(json.Msg);
                    if (json.State === true) {
                        window.open("QualityQuestionForm.aspx", "_self");
                    }
                },
                error: function (data) {
                    var json = JSON.parse(data);
                    alert(json.Msg);
                }
            });
            return false;
        }

        function changepro(proid) {
            $("#projectname").val($('#projectid').find("option:selected").text());
            $("#buildingno").empty();
            $("#buildingno").append($("<option>").val(-1).text('请选择栋号'));
            for (var i = 0; i < arr.length; i++) {
                if (arr[i][0] == proid) {
                    $("#buildingno").append($("<option>").val(arr[i][1]).text(arr[i][1]));
                }
            }
        }
    </script>
</head>
<body>
    <div data-role="page">
        <div data-role="header" data-position="fixed">
            <a href="../FormList.aspx" target="_self" data-rel="back" class="ui-btn ui-btn-left ui-alt-icon ui-nodisc-icon ui-corner-all ui-btn-icon-notext ui-icon-carat-l">Back</a>
            <h1>填写——质量问题报告</h1>
        </div>
        <div data-role="content">
            <form id="securityform">
                <div data-role="fieldcontain">
                    <input type='hidden' name='projectname' id='projectname' />
                    <label for="projectid">项目：</label>
                    <select name="projectid" id="projectid" onchange="changepro(this.value)">
                        <option value='-1'>请选择项目</option>
                    </select>
                    <label for="buildingno">栋号：</label>
                    <select name="buildingno" id="buildingno">
                        <option value='-1'>请选择栋号</option>
                    </select>
                    <label for="levelno">层号/户型：</label>
                    <input type="text" name='levelno' placeholder="层号/户型" />
                    <label for="location">位置：</label>
                    <input type="text" name='location' placeholder="详细位置" />
                    <label for="details">问题说明：</label>
                    <textarea cols="40" rows="8" name="details" placeholder="问题说明"></textarea>
                    <label for="checktime">检查日期：</label>
                    <input type="text" name='checktime' id="checktime" data-role="date" placeholder="检查日期" />
                    <label for="workers">施工人员（班组）：</label>
                    <input type="text" name='workers' placeholder="施工人员（班组）" />
                    <label for="managers">责任人员：</label>
                    <input type="text" name='managers' placeholder="责任人员" />
                    <label for="results">处理措施，结果：</label>
                    <textarea cols="40" rows="8" name="results" placeholder="处理措施，结果"></textarea>
                    <label for="reworkers">整改人员：</label>
                    <input type="text" name='reworkers' placeholder="整改人员" />
                    <label for="finishtime">整改完成时间：</label>
                    <input type="text" name='finishtime' id="finishtime" data-role="date" placeholder="完成时间" />
                    <label for="costofworktime">整改花费工时：</label>
                    <input type="text" name='costofworktime' placeholder="整改花费工时" />
                    <label for="costofmaterial">整改消耗材料：</label>
                    <input type="text" name='costofmaterial' placeholder="整改消耗材料" />
                    <label for="rechecker">复查人员：</label>
                    <input type="text" name='rechecker' placeholder="复查人员" />
                    <h3 id="notification"></h3>
                    <button data-theme="b" type="button" onclick="doPost()">提交报告</button>
                </div>
            </form>
        </div>
    </div>
</body>
</html>
