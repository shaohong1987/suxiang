<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
    CodeBehind="SecurityQuestionForm.aspx.cs" Inherits="suxiang.Form.SecurityQuestionForm" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="../content/css/style.css" rel="stylesheet" type="text/css" />
    <link href="../Content/css/select.css" rel="stylesheet" type="text/css" />
    <script src="../content/js/jquery-1.11.1.min.js" type="text/javascript"></script>
    <script src="../Content/js/select-ui.min.js" type="text/javascript"></script>
    <script src="../Content/js/My97/WdatePicker.js" type="text/javascript"></script>
    <script src="../Content/js/jquery.validate.min.js" type="text/javascript"></script>
    <script type="text/javascript">
        var arr = new Array();
        $(document).ready(function () {
            $(".placeul").html("<li><a href='NewForm.aspx'>各类表单</a></li><li><a>安全问题表</a></li>");
            $(".select1").uedSelect({
                width: 345
            });
            $(".select2").uedSelect({
                width: 167
            });
            $(".select3").uedSelect({
                width: 80
            });
            $(".select4").uedSelect({
                width: 100
            });
            $(".select5").uedSelect({
                width: 70
            });
            $(".select6").uedSelect({
                width: 172
            });
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
                        var formData = $("#sqform").serialize();
                        $.ajax({
                            type: "POST",
                            url: "../Handler/Process.ashx",
                            cache: false,
                            data: formData,
                            success: function (data) {
                                var json = JSON.parse(data);
                                alert(json.Msg);
                                if (json.State === true) {
                                    window.open("SecurityQuestionForm.aspx", "_self");
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
                    worker: "required",
                    responsibleperson1: "required",
                    responsibleperson2: "required",
                    rebuildsolution: "required",
                    rebuilder: "required",
                    worktimecost_db: "required",
                    worktimecost_xb: "required",
                    materialcost: "required",
                    rechecker: "required"
                },
                messages: {
                    levelno: "请填写层高/户型",
                    location: "请填写详细地点",
                    checkdate: "请填写检查日期",
                    finishdate: "请填写整改完成日期",
                    problemdescription: "请输入问题说明",
                    causation: "请填写原因分析",
                    worker: "请填写处理措施,结果",
                    responsibleperson1: "请选择班组长",
                    responsibleperson2: "请填写栋号长/生产经理",
                    rebuildsolution: "请填写整改方案",
                    rebuilder: "请填写整改人员",
                    worktimecost_db: "请填写耗费工时(大工)",
                    worktimecost_xb: "请填写耗费工时(小工)",
                    materialcost: "请填写消耗的材料",
                    rechecker: "请填写复查人员"
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
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <form class="formbody" id="sqform">
    <input type="hidden" value="SecurityQuestionForm" name="action" />
    <div id="usual1" class="usual">
        <ul class="forminfo">
            <li>
                <label>
                    具体部位
                </label>
                <div class="vocation">
                    <select name="projectid" id="projectid" onchange="changepro(this.value)" class="select4">
                        <option value="-1">请选择项目</option>
                    </select>
                    <input type="hidden" id="projectname" name="projectname" />
                </div>
                <div class="vocation" style="margin-left: 10px; margin-right: 7px;">
                    <select name="buildingno" id="buildingno" class="select5">
                        <option value="-1">栋号</option>
                    </select>
                </div>
                栋
                <input type="text" name="location" id="location" placeholder="层号/户型" class="dfinput"
                    style="width: 140px;" />
            </li>
            <li>
                <div>
                    <label>
                        检查日期<b>*</b>
                    </label>
                    <input type="text" name="checkdate" id="checkdate" placeholder="检查日期" class="dfinput"
                        onclick="WdatePicker()" style="width: 126px;" />
                    整改完成时间<b>*</b>
                    <input type="text" name="finishdate" id="finishdate" placeholder="完成时间" class="dfinput"
                        onclick="WdatePicker()" style="width: 126px;" /></div>
            </li>
            <li>
                <label>
                    问题说明<b>*</b>
                </label>
                <input type="text" name="problemdescription" placeholder="问题说明" class="dfinput" />
            </li>
            <li>
                <label>
                    原因分析<b>*</b>
                </label>
                <textarea class="textinput2" name="causation" placeholder="原因分析"></textarea>
            </li>
            <li>
                <label>
                    班组/施工人员<b>*</b>
                </label>
                 <div class="vocation" style="margin-right: 5px;">
                    <select name="teamleader" id="teamleader" class="select6">
                        <option value="-1">班组</option>
                    </select>
                </div>
                <input type="text" name="worker" placeholder="施工人员" class="dfinput" style="width: 169px;" />
            </li>
            <li>
                <label>
                    管理责任人<b>*</b>
                </label>
                <input type="text" name="responsibleperson1" placeholder="安全员" class="dfinput" style="width: 169px;" />
                <input type="text" name="responsibleperson2" placeholder="栋号长/生产经理" class="dfinput" style="width: 169px;" />
            </li>
            <li>
                <label>
                    整改方案<b>*</b>
                </label>
                <textarea class="textinput2" name="rebuildsolution" placeholder="整改方案"></textarea>
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
                    耗费工时<b>*</b>
                </label>
                <input type="text" name="worktimecost_db" placeholder="整改花费工时（数字）" class="dfinput"
                    onkeyup="this.value=this.value.replace(/[^0-9.]/g,'')" style="width: 140px; margin-right: 3px;" />大工
                <input type="text" name="worktimecost_xb" placeholder="整改花费工时（数字）" class="dfinput"
                    onkeyup="this.value=this.value.replace(/[^0-9.]/g,'')" style="width: 140px; margin-right: 3px;
                    margin-left: 6px;" />小工 </li>
            <li>
                <label>
                    耗费材料<b>*</b>
                </label>
                <textarea class="textinput3" name="materialcost" placeholder="整改耗费材料"></textarea>
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
                       <option value="3">三级</option>
                        <option value="4">四级</option>
                        <option value="5">五级</option>
                    </select>
                </div>
            </li>
            <li>
                <button type="submit" class="btn">
                    确认保存
                </button>
            </li>
        </ul>
    </div>
    </form>
</asp:Content>
