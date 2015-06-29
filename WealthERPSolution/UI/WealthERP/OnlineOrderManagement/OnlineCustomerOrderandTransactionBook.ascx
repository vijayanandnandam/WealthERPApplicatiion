﻿<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="OnlineCustomerOrderandTransactionBook.ascx.cs" Inherits="WealthERP.OnlineOrderManagement.OnlineCustomerOrderandTransactionBook" %>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap.min.css">
<!-- Optional theme -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap-theme.min.css">

<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/js/bootstrap.min.js"></script>

<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap.min.css">

<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>

<script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/js/bootstrap.min.js"></script>

<asp:ScriptManager ID="scriptmanager" runat="server">
</asp:ScriptManager>
<style>
    .ft_sort
    {
        background: #999999 none repeat scroll 0 0;
        border: 0 none;
        border-radius: 12px;
        box-shadow: 0 1.5px 2px #bfbfbf inset;
        color: #ffffff;
        cursor: pointer;
        display: block;
        font-size: 11.5px;
        font-style: normal;
        padding: 3px 12px;
        width: 60px;
    }
    .ft_sort:hover
    {
        background: #565656;
        color: #ffffff;
    }
    .divs
    {
        background-color: #EEEEEE;
        margin-bottom: .5%;
        margin-top: .5%;
         margin-left:.2%;
          margin-right:.1%;
        border: solid 1.5px #EEEEEE;
    }
    .divs:hover
    {
        border: solid 1.5px #00CEFF;
        cursor: pointer;
    }
</style>
<div id="demo" class="row" style="margin-left: 5%; margin-top: 1%; margin-bottom: 2%;
    margin-right: 5%; padding-top: 1%; padding-bottom: 1%; background-color: #2480C7;
    height: 20%">
    <div style="margin-left: 5%; font-size: 20px;" class="col-md-12 col-xs-12 col-sm-12">
        <font color="#fff"><b>Order Book</b></font>
    </div>
    <div class="col-md-12 col-xs-12 col-sm-12">
        <div class="col-md-5">
            <font color="#fff"><b>AMC:</b></font>
            <asp:DropDownList ID="ddlAMC" runat="server" CssClass="form-control input-sm" Width="100%"
                AutoPostBack="true" OnSelectedIndexChanged="ddlAMC_OnSelectedIndexChanged">
            </asp:DropDownList>
            <%--<asp:RequiredFieldValidator ID="rfvAMC" runat="server" ControlToValidate="ddlAMC" InitialValue="0" ErrorMessage="Please Select AMC" Display="Dynamic"></asp:RequiredFieldValidator>--%>
        </div>
        <div class="col-md-7">
            <font color="#fff"><b>Scheme:</b></font>
            <asp:DropDownList ID="ddlScheme" runat="server" CssClass="form-control input-sm"
                class="form-control">
            </asp:DropDownList>
        </div>
    </div>
    <div class="col-md-12">
        <div class="col-md-2" style="margin-top: 1.6%;">
            <asp:Button ID="btnSIP" runat="server" class="btn btn-sm btn-default" Text="SIP"
                OnClick="btnSIP_OnClick" Width="120px"></asp:Button>
        </div>
        <div class="col-md-2" style="margin-top: 1.6%">
            <asp:Button ID="btnNewPurchase" runat="server" class="btn btn-sm btn-default" Text="New Purchase"
                OnClick="btnNewPurchase_OnClick" Width="120px"></asp:Button>
        </div>
        <div class="col-md-2" style="margin-top: 1.6%">
            <asp:Button ID="btnAdditionalPurchase" runat="server" class="btn btn-sm btn-default"
                Text="Additional Purchase" OnClick="btnAdditionalPurchase_OnClick" Width="130px">
            </asp:Button>
        </div>
        <div class="col-md-2" style="margin-top: 1.6%">
            <asp:Button ID="btnRedeem" runat="server" class="btn btn-sm btn-default" Text="Redeem"
                OnClick="btnRedeem_OnClick" Width="120px"></asp:Button>
        </div>
    </div>
</div>
<div id="Div1" class="row" style="margin-left: 5%; margin-right: 5%; background-color: #2480C7;" visible="false" runat="server">
    <telerik:RadGrid ID="gvOrderBook" runat="server" GridLines="None" AllowPaging="True"
        PageSize="5" AllowSorting="True" AutoGenerateColumns="False" ShowStatusBar="true"
        AllowAutomaticDeletes="false" AllowAutomaticInserts="false" AllowAutomaticUpdates="false"
        HorizontalAlign="NotSet" CellPadding="15" OnNeedDataSource="gvOrderBook_OnNeedDataSource">
        <MasterTableView CommandItemDisplay="None" DataKeyNames="CO_OrderId" AllowCustomSorting="true">
            <Columns>
                <telerik:GridTemplateColumn>
                    <HeaderTemplate>
                        <%--  <div class="col-md-2">
                            <asp:Button ID="btnAMC" runat="server" CssClass="ft_sort" Text="AMC" /></div>
                        <div class="col-md-2">
                            <asp:Button ID="Button1" runat="server" CssClass="ft_sort" Text="Scheme" /></div>--%>
                        <%--<div class="col-md-4">
                            <asp:Button ID="Button2" runat="server" CssClass="ft_sort" Text="Order Status" Width="100px" /></div>--%>
                    </HeaderTemplate>
                    <ItemTemplate>
                        <div class="col-sm-12 col-sm-12 col-md-12 col-lg-12 divs">
                            <div class="col-xs-3 col-sm-3 col-md-3 col-lg-3 fk-font-3" style="margin-bottom: 1.5px;">
                                <font color="#565656"><b>Fund Name:</b></font>
                                <%# Eval("PA_AMCName")%>
                            </div>
                            <div class="col-xs-7 col-sm-7 col-md-7 col-lg-7 fk-font-7" style="margin-bottom: 1.5px;">
                                <font color="#565656"><b>Scheme Name:</b> </font>
                                <%# Eval("PASP_SchemePlanName")%>
                            </div>
                            <div class="col-xs-3 col-sm-3 col-md-3 col-lg-3 fk-font-3" style="margin-bottom: 1.5px;">
                                <font color="#565656"><b>Sub Category:</b></font>
                                <%# Eval("PAISC_AssetInstrumentSubCategoryName")%>
                            </div>
                            <div class="col-xs-3 col-sm-3 col-md-3 col-lg-3 fk-font-3" style="margin-bottom: 1.5px;">
                                <font color="#565656"><b>Order No.:</b></font>
                                <%# Eval("CO_OrderId")%>
                            </div>
                            <div class="col-xs-3 col-sm-3 col-md-3 col-lg-3 fk-font-3" style="margin-bottom: 1.5px;">
                                <font color="#565656"><b>Request Date:</b></font>
                                <%# Eval("CO_OrderDate")%>
                            </div>
                            <div class="col-xs-3 col-sm-3 col-md-3 col-lg-3 fk-font-3" style="margin-bottom: 1.5px;">
                                <font color="#565656"><b>Order Type:</b></font>
                                <%# Eval("WMTT_TransactionType")%>
                            </div>
                            <div class="col-xs-3 col-sm-3 col-md-3 col-lg-3 fk-font-3" style="margin-bottom: 1.5px;">
                                <font color="#565656"><b>Dividend Type:</b></font>
                                <%# Eval("CMFOD_DividendOption")%>
                            </div>
                            <div class="col-xs-3 col-sm-3 col-md-3 col-lg-3 fk-font-3" style="margin-bottom: 1.5px;">
                                <font color="#565656"><b>Amount:</b></font>
                                <%# Eval("CMFOD_Amount")%>
                            </div>
                            <div class="col-xs-3 col-sm-3 col-md-3 col-lg-3 fk-font-3" style="margin-bottom: 1.5px;">
                                <font color="#565656"><b>Units:</b></font>
                                <%# Eval("CMFOD_Units")%>
                            </div>
                            <div class="col-xs-3 col-sm-3 col-md-3 col-lg-3 fk-font-3" style="margin-bottom: 1.5px;">
                                <font color="#565656"><b>Redeme All:</b></font>
                                <%# Eval("CMFOD_IsAllUnits")%>
                            </div>
                            <div class="col-xs-3 col-sm-3 col-md-3 col-lg-3 fk-font-3" style="margin-bottom: 1.5px;">
                                <font color="#565656"><b>Order Status:</b></font>
                                <%# Eval("XS_Status")%>
                            </div>
                            <div class="col-xs-3 col-sm-3 col-md-3 col-lg-3 fk-font-3" style="margin-bottom: 1.5px;">
                                <font color="#565656"><b>Online:</b></font>
                                <%# Eval("Channel")%>
                            </div>
                            <div class="col-xs-9 col-sm-9 col-md-9 col-lg-9 fk-font-9 style="margin-bottom: 1.5px;">
                                <font color="#565656"><b>Reject Remark:</b></font>
                                <%# Eval("COS_Reason")%>
                            </div>
                            <div class="col-xs-2 col-sm-2 col-md-2 col-lg-2 fk-font-2" style="margin-bottom: 1.5px;">
                                <asp:Button ID="btnDetails" runat="server" class="ft_sort btn-sm btn-info" Text="Transaction Details"
                                    OnClick="btnDetails_OnClick" Width="120px" ></asp:Button>
                            </div>
                        </div>
                    </ItemTemplate>
                </telerik:GridTemplateColumn>
                <telerik:GridTemplateColumn>
                    <ItemTemplate>
                        <tr>
                            <td colspan="100%">
                                <telerik:RadGrid ID="gvChildDetails" runat="server"  AllowPaging="True"
                                    PageSize="5" AllowSorting="True" AutoGenerateColumns="False" ShowStatusBar="true"
                                    AllowAutomaticDeletes="false" AllowAutomaticInserts="false" AllowAutomaticUpdates="false"
                                    HorizontalAlign="NotSet" CellPadding="15" Visible="false" >
                                    <MasterTableView AllowMultiColumnSorting="True" AllowSorting="true" AutoGenerateColumns="false"
                                        Width="100%" ShowHeader="false" >
                                        <Columns>
                                            <telerik:GridTemplateColumn>
                                            <HeaderStyle />
                                                <ItemTemplate>
                                                   <div class="col-sm-12 col-sm-12 col-md-12 col-lg-12">
                                                        <div class="col-xs-3 col-sm-3 col-md-3 col-lg-3 fk-font-3" style="margin-bottom: 1.5px;">
                                                            <font color="#565656"><b>Customer Name:</b></font>
                                                            <%# Eval("Name")%>
                                                        </div>
                                                        <div class="col-xs-3 col-sm-3 col-md-3col-lg-3 fk-font-3" style="margin-bottom: 1.5px;">
                                                            <font color="#565656"><b>Folio Number:</b> </font>
                                                            <%# Eval("CMFA_FolioNum")%>
                                                        </div>
                                                        <div class="col-xs-3 col-sm-3 col-md-3 col-lg-3 fk-font-3" style="margin-bottom: 1.5px;">
                                                            <font color="#565656"><b>Actioned NAV:</b></font>
                                                            <%# Eval("CMFOD_DividendOption")%>
                                                        </div>
                                                        <div class="col-xs-3 col-sm-3 col-md-3 col-lg-3 fk-font-3" style="margin-bottom: 1.5px;">
                                                            <font color="#565656"><b>Transaction Date:</b></font>
                                                            <%# Eval("CMFT_TransactionDate")%>
                                                        </div>
                                                        <div class="col-xs-3 col-sm-3 col-md-3 col-lg-3 fk-font-3" style="margin-bottom: 1.5px;">
                                                            <font color="#565656"><b>Amount (Rs):</b></font>
                                                            <%# Eval("CMFT_Amount")%>
                                                        </div>
                                                        <div class="col-xs-3 col-sm-3 col-md-3 col-lg-3 fk-font-3" style="margin-bottom: 1.5px;">
                                                            <font color="#565656"><b>Units:</b></font>
                                                            <%# Eval("CMFT_Units")%>
                                                        </div>
                                                        <div class="col-xs-3 col-sm-3 col-md-3 col-lg-3 fk-font-3" style="margin-bottom: 1.5px;">
                                                            <font color="#565656"><b>Dividend Type:</b></font>
                                                            <%# Eval("CMFOD_DividendOption")%>
                                                        </div>
                                                        <div class="col-xs-3 col-sm-3 col-md-3 col-lg-3 fk-font-3" style="margin-bottom: 1.5px;">
                                                            <font color="#565656"><b>Amount:</b></font>
                                                            <%# Eval("CMFOD_Amount")%>
                                                        </div>
                                                        
                                                        <div class="col-xs-3 col-sm-3 col-md-3 col-lg-3 fk-font-3" style="margin-bottom: 1.5px;">
                                                            <font color="#565656"><b>Maturity Date:</b></font>
                                                            <%# Eval("CMFT_ELSSMaturityDate")%>
                                                        </div>
                                                   </div>
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>
                                        </Columns>
                                    </MasterTableView>
                                </telerik:RadGrid>
                            </td>
                        </tr>
                    </ItemTemplate>
                </telerik:GridTemplateColumn>
            </Columns>
        </MasterTableView>
        <ClientSettings EnableAlternatingItems="false">
        </ClientSettings>
        <PagerStyle Mode="NextPrevAndNumeric" />
    </telerik:RadGrid>
</div>

<script>
    $(document).ready(function() {
        $(".btn-primary").click(function() {
            $(".collapse").collapse('toggle');
        });

    });
</script>