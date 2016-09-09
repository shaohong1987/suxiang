﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
    CodeBehind="SecurityQuestionForm.aspx.cs" Inherits="suxiang.Form.SecurityQuestionForm" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="formbody">
        <ul class="forminfo">
            <li>
                <label>
                    文章标题</label><input name="" type="text" class="dfinput" /><i>标题不能超过30个字符</i></li>
            <li>
                <label>
                    关键字</label><input name="" type="text" class="dfinput" /><i>多个关键字用,隔开</i></li>
            <li>
                <label>
                    是否审核</label><cite><input name="" type="radio" value="" checked="checked" />是&nbsp;&nbsp;&nbsp;&nbsp;<input
                        name="" type="radio" value="" />否</cite></li>
            <li>
                <label>
                    引用地址</label><input name="" type="text" class="dfinput" value="http://www.uimaker.com/uimakerhtml/uidesign/" /></li>
            <li>
                <label>
                    文章内容</label><textarea name="" cols="" rows="" class="textinput"></textarea></li>
            <li>
                <label>
                    &nbsp;</label><input name="" type="button" class="btn" value="确认保存" /></li>
        </ul>
    </div>
</asp:Content>
