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
    <script src="../Content/js/jquery.validate.min.js"></script> 
  <script type="text/javascript">
        var arr = new Array();
        $(document).ready(function () {
            $.post("../Handler/Process.ashx", { action: "GetBuildings" }, function (data) {
                var json = eval(data);
                if (json.State === true) {
                    $.each(json.Data, function (i, item) {
                        arr[i] = new Array();
                        arr[i][0] = item['Projectid'];
                        arr[i][1] = item['Buildingid'];
                    });
                }
            },
                    "json");
            $.post("../Handler/Process.ashx", { action: "GetProjects" }, function (data) {
                var json = eval(data);
                if (json.State === true) {
                    $.each(json.Data, function (i, item) {
                        $("#projectid").append("<option value='" + item['Id'] + "'>" + item['Projectname'] + "</option>");
                    });
                }
            },
                    "json");


            $.ajax({
                type: "POST",
                url: "../Handler/Auth.ashx?action=GetUserWithOutAdmin",
                cache: false,
                success: function (data) {
                    var d = JSON.parse(data);
                    $.each(d, function (i, item) {
                        $("#teamleader").append("<option value='" + item['Id'] + "-" + item["realname"] + "'>" + item['realname'] + "</option>");
                    });
                },
                error: function (data) {
                    var json = JSON.parse(data);
                    alert(json.Msg);
                }
            });

            $("#sqform").validate({
                focusInvalid: false,
                onkeyup: false,
                submitHandler: function () {
                    if ($("#projectid").val() != -1 && $("#buildingno").val() != '') {
                        //var formData = $("#sqform").serialize();
                        var formData = new FormData(document.getElementById("sqform"));
                        $.ajax({
                            type: "POST",
                            url: "../Handler/Process.ashx",
                            processData: false,  // 告诉jQuery不要去处理发送的数据
                            contentType: false,   // 
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
                    } else {
                        alert("请补充必要的数据!");
                    }

                },
                rules: {
                    levelno: "required",
                    location: "required",
                    checkdate: "required",
                    finishdate: "required",
                    problemdescription: "required",
                    causation: "required",
                    responsibleperson1: "required",
                    responsibleperson2: "required",
                    rebuildsolution: "required",
                    rebuilder: "required"
                },
                messages: {
                    levelno: "请填写层高/户型",
                    location: "请填写详细地点",
                    checkdate: "请填写检查日期",
                    finishdate: "请填写整改完成日期",
                    problemdescription: "请输入问题说明",
                    causation: "请填写原因分析",
                    responsibleperson1: "请选择班组长",
                    responsibleperson2: "请填写栋号长/生产经理",
                    rebuildsolution: "请填写整改方案",
                    rebuilder: "请填写整改班组"
                },
                errorElement: "em",
                errorPlacement: function (error, element) {
                    if (element.prop("type") === "checkbox") {
                        error.insertAfter(element.parent("label"));
                    } else {
                        error.insertAfter(element);
                    }
                }
            });
        });

        function changepro(proid) {
            $("#projectname").val($('#projectid').find("option:selected").text());
            $("#buildingno").empty();
            $("#buildingno").append($("<option>").val(-1).text('栋号'));
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
            <a href="NewForm.aspx" target="_self" class="ui-btn ui-btn-left ui-alt-icon ui-nodisc-icon ui-corner-all ui-btn-icon-notext ui-icon-carat-l">Back</a>
            <h1>填写——质量问题报告</h1>
        </div>
        <div data-role="content">
            <form id="sqform"> 
                <div data-role="fieldcontain">
                    <input type="hidden" value="QualityQuestionForm" name="action" />
                    <input type='hidden' name='projectname' id='projectname' />
                    <label for="projectid">项目：</label>
                    <select name="projectid" id="projectid" onchange="changepro(this.value)">
                        <option value='-1'>请选择项目</option>
                    </select>
                    <label for="buildingno">栋号：</label>
                    <select name="buildingno" id="buildingno">
                        <option value='-1'>请选择栋号</option>
                    </select>
                    <label for="location">层号/户型：</label> 
                    <input type="text" name='location' placeholder="层号/户型" id="location"/>
                    <label for="location">检查日期：</label> 
                    <input type="text" name='checkdate' id="checkdate" data-role="date" placeholder="检查日期" />
                    <label for="location">整改完成时间：</label> 
                    <input type="text" name='finishdate' id="finishdate" data-role="date" placeholder="整改完成时间" />
                    <label for="problemdescription">问题说明：</label>
                    <textarea cols="40" rows="8" name="problemdescription" id="problemdescription" placeholder="问题说明"></textarea>
                    <label for="causation">原因分析：</label>
                    <textarea cols="40" rows="8" name="causation" id="causation" placeholder="原因分析"></textarea>
                    <label for="teamleader">班组：</label>
                    <select name="teamleader" id="teamleader"> 
                        <option value='-1'>请选择班组</option> 
                    </select>
                    <label for="worker">施工人员：</label>
                    <input type="text" name='worker' id="worker" placeholder="施工人员" />
                    <label for="responsibleperson1">质量员：</label>
                    <input type="text" name='responsibleperson1' id="responsibleperson1" placeholder="安全员" />
                    <label for="responsibleperson2">责任人员：</label>
                   <input type="text" name='responsibleperson2' id="responsibleperson2" placeholder="栋号长/生产经理" />  
                    <label for="rebuildsolution">整改方案：</label>
                    <textarea cols="40" rows="8" id="rebuildsolution" name="rebuildsolution" placeholder="整改方案"></textarea>
                    <label for="rebuilder">整改班组：</label>
                    <input type="text" name='rebuilder' id="rebuilder" placeholder="整改班组" />
                    <label for="levelno">质量等级：</label>
                    <select name="levelno" id="levelno">
                        <option value='3'>三级</option> 
                        <option value='4'>四级</option> 
                        <option value='5'>五级</option> 
                    </select>
                    <label for="worktimecost_db">耗费工时（大工）：</label>
                    <input type="text" name='worktimecost_db' id="worktimecost_db" placeholder="耗费工时（大工）" />
                    <label for="worktimecost_xb">耗费工时（小工）：</label>
                    <input type="text" name='worktimecost_xb' id="worktimecost_xb" placeholder="耗费工时（小工）" />
                    <label for="materialcost">耗费材料：</label>
                    <input type="text" name='materialcost' id="materialcost" placeholder="耗费材料" />

                     <label id="piclabel">附件</label>
                    <input type="file" name="pic" id="pic"  />
                    <h3 id="notification"></h3>
                    <button data-theme="b" type="submit">提交报告</button>
                </div>
            </form>
        </div>
    </div>
</body>
</html>
