﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="OnlineTopHost.aspx.cs" Inherits="WealthERP.OnlineTopHost" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >

<script language="javascript" type="text/javascript" src="Scripts/JScript.js"></script>

<%--<link href="../App_Themes/Blue/StyleSheet.css" rel="stylesheet" type="text/css" />--%>

<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    <asp:Panel ID="toppanel" runat="server">
            <asp:PlaceHolder ID="phTop" EnableViewState="true" runat="server"></asp:PlaceHolder>
        </asp:Panel>
    </div>
    </form>
</body>
</html>
