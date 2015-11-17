﻿<%@ Control Language="C#" AutoEventWireup="True" CodeBehind="MFSchemeRelateInformation.ascx.cs"
    Inherits="WealthERP.OnlineOrderManagement.MFSchemeRelateInformation" %>
<%--<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>--%>

<script src="../Scripts/jquery.js" type="text/javascript"></script>

<script src="../Scripts/JScript.js" type="text/javascript"></script>

<script src="../Scripts/jquery.min.js" type="text/javascript"></script>

<script src="Scripts/jquery-1.4.1.js" type="text/javascript"></script>

<asp:ScriptManager ID="scriptmanager" runat="server">
    <%--<Services>
        <asp:ServiceReference Path="~/CustomerPortfolio/AutoComplete.asmx" />
    </Services>--%>
</asp:ScriptManager>

<script type="text/javascript">
    function setCustomPosition(sender, args) {
        sender.moveTo(sender.get_left(), sender.get_top());
    }
   
    
</script>

<style type="text/css">
    @media only screen and (max-width: 800px)
    {
        /* Force table to not be like tables anymore */    #no-more-tables table, #no-more-tables thead, #no-more-tables tbody, #no-more-tables th, #no-more-tables td, #no-more-tables tr
        {
            display: block;
        }
        /* Hide table headers (but not display: none;, for accessibility) */    #no-more-tables thead tr
        {
            position: absolute;
            top: -9999px;
            left: -9999px;
        }
        #no-more-tables tr
        {
            border: 1px solid #ccc;
        }
        #no-more-tables td
        {
            /* Behave  like a "row" */
            border: none;
            border-bottom: 1px solid #eee;
            position: relative;
            padding-left: 60%;
            white-space: normal;
            text-align: left;
        }
        #no-more-tables td:before
        {
            /* Now like a table header */
            position: absolute; /* Top/left values mimic padding */
            top: 6px;
            left: 6px;
            width: 80%;
            padding-right: 10px;
            white-space: nowrap;
            text-align: left;
            font-weight: bold;
            z-index: auto;
        }
        /*
	Label the data
	*/    #no-more-tables td:before
        {
            content: attr(data-title);
        }
    }
    .alignCenter
    {
        text-align: center;
        font-size: small;
    }
    table, th
    {
        border: 1px solid black;
    }
    .dottedBottom
    {
        border-bottom-style: inset;
        border-bottom-width: thin;
        margin-bottom: 1%;
        border-collapse: collapse;
        border-spacing: 10px;
    }
    .linkButton
    {
        font-size: small;
    }
    .linkButton:active
    {
        font-size: larger;
    }
    .page_enabled, .page_disabled
    {
        display: inline-block;
        height: 20px;
        min-width: 20px;
        line-height: 20px;
        text-align: center;
        text-decoration: none;
        border: 1px solid #ccc;
    }
    .page_enabled
    {
        background-color: #eee;
        color: #000;
    }
    .page_disabled
    {
        background-color: #6C6C6C;
        color: #fff !important;
    }
</style>

<script src="../Scripts/bootstrap.js" type="text/javascript"></script>

<script src="../Scripts/jquery.js" type="text/javascript"></script>

<script src="../Scripts/JScript.js" type="text/javascript"></script>

<script src="../Scripts/jquery.min.js" type="text/javascript"></script>

<script src="../Scripts/jquery.min.js" type="text/javascript"></script>

<link href="../Base/CSS/bootstrap-theme.css" rel="stylesheet" type="text/css" />
<link href="../Base/CSS/bootstrap.css" rel="stylesheet" type="text/css" />
<link href="../Base/CSS/bootstrap.min.css" rel="stylesheet" type="text/css" />

<script type="text/javascript">
    //        $(document).ready(function() {
    //        GetSchemeLists();
    //        });
       
</script>

<table class="tblMessage" cellpadding="0" cellspacing="0">
    <tr>
        <td>
            <div class="divOnlinePageHeading" style="height: 25px;">
                <%-- <div class="divClientAccountBalance" id="divClientAccountBalance" runat="server">
                    <asp:Label ID="Label1" runat="server" Text="Available Limits:" CssClass="BalanceLabel"> </asp:Label>
                    <asp:Label ID="lblAvailableLimits" runat="server" Text="" CssClass="BalanceAmount"></asp:Label>--%>
            </div>
        </td>
    </tr>
</table>
<asp:UpdatePanel ID="UpdatePanel1" runat="server">
    <ContentTemplate>
    <div style="margin-left: 11%; margin-top: 1%; margin-bottom: 0.5%; margin-right: 5%;
            padding-top: 0.5%; padding-bottom: 0.5%; width: 80%">
        <div id="dvDemo"  visible="true" runat="server">
            <div class="col-md-9  col-xs-9 col-sm-9" >
                <div class="col-md-12  col-xs-12 col-sm-12">
                    <div class="col-md-8 dottedBottom">
                        <b>Fund Filter </b>
                    </div>
                    <div class="col-md-3 dottedBottom">
                        <b>Predefined Search </b>
                    </div>
                </div>
                <div class="col-md-12 col-xs-12 col-sm-12" style="margin-bottom: 1%">
                    <div class="col-md-5">
                        <asp:DropDownList ID="ddlAMC" runat="server" CssClass="form-control input-sm" OnSelectedIndexChanged="ddlAMC_SelectedIndexChanged"
                            AutoPostBack="true" >
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator ID="rfvtxtTransactionDate" ControlToValidate="ddlAMC"
                            ErrorMessage="<br />Please select AMC" Style="color: Red;" Display="Dynamic"
                            runat="server" InitialValue="0" ValidationGroup="btnViewscheme">
                        </asp:RequiredFieldValidator>
                        <%--<asp:RequiredFieldValidator ID="rfvAMC" runat="server" ControlToValidate="ddlAMC" InitialValue="0" ErrorMessage="Please Select AMC" Display="Dynamic"></asp:RequiredFieldValidator>--%>
                    </div>
                    <div class="col-md-3">
                        <fieldset>
                            <asp:DropDownList ID="ddlCategory" runat="server" CssClass="form-control input-sm"
                                AutoPostBack="true" OnSelectedIndexChanged="ddlCategory_OnSelectedIndexChanged">
                            </asp:DropDownList>
                            
                         <%--   <asp:RequiredFieldValidator ID="RequiredFieldValidator1" ControlToValidate="ddlCategory"
                                ErrorMessage="<br />Please select category" Style="color: Red;" Display="Dynamic"
                                runat="server" InitialValue="0" ValidationGroup="btnViewscheme">
                            </asp:RequiredFieldValidator>--%>
                            
                        </fieldset>
                    </div>
                    <div class="col-md-4">
                        <asp:LinkButton ID="lbNFOList" runat="server" OnClick="GetSchemeDetails" CssClass="linkButton">NFO Scheme </asp:LinkButton>
                    </div>
                </div>
                <div class="col-md-12">
                    <div class="col-md-7">
                        <asp:DropDownList ID="ddlScheme" runat="server" CssClass="form-control input-sm"
                            class="form-control">
                        </asp:DropDownList>
                    </div>
                    <div class="col-md-1"><asp:Button ID="Button1" runat="server" class="btn btn-sm btn-primary" Text="GO"
                            OnClick="Go_OnClick" ValidationGroup="btnViewscheme"></asp:Button></div>
                    <div class="col-md-3 ">
                        <asp:LinkButton ID="lbTopSchemes" runat="server" OnClick="GetSchemeDetails" CssClass="linkButton">Top Ten Schemes </asp:LinkButton>
                    </div>
                </div>
                <div class="col-md-12" style="margin-top: 1%">
                    <div class="col-md-8">
                        
                    </div>
                    <div class="col-md-3">
                        <asp:LinkButton ID="lbViewWatchList" runat="server" OnClick="GetSchemeDetails" CssClass="linkButton">My Watch list  </asp:LinkButton>
                    </div>
                </div>
            </div>
            <div class="col-md-3 col-xs-3 col-sm-3" style="margin-top: 0px;">
                    <div class="col-md-12 dottedBottom">
                        <b>Fund News</b>
                    </div>
                    <div>
                        <marquee style="margin-bottom: 0px; height: 100px" direction="up" scrolldelay="150" onmouseover="this.setAttribute('scrollamount', 0, 0);" onmouseout="this.setAttribute('scrollamount', 6, 0);">
                    <asp:Repeater ID="RepNews" runat="server" OnItemCommand="repFundDetails_OnItemCommand">
                        <ItemTemplate>
                            <div class="dottedBottom">
                                <div>
                                <asp:LinkButton ID="lnknews" runat="server" style="color:Black" Text='<%# Eval("heading")%>' CommandName="NewsDetailsLnk" CommandArgument='<%# Eval("sno")%>'></asp:LinkButton>
                                    <asp:Label ID="Label2" runat="server" Text='<%# Eval("sno")%>' Visible="false"></asp:Label>
                                </div>
                                <div>
                                    <asp:Label ID="lblDate" Style="font-size: x-small; color: Gray;" runat="server" Text='<%# Eval("date")%>'></asp:Label>
                                </div>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>
                       </marquee>
                        <div>
                            <asp:LinkButton ID="lnkMoreNews" Style="font-size: large; color: #4582DF; font-weight: bold;
                                margin-top: 0px" runat="server" Text=">>>" ToolTip="Detail" OnClick="lnkMoreNews_lnkMoreNews"></asp:LinkButton>
                        </div>
                    </div>
                </div>
        </div>
        <div class="row "  runat="server" visible="false" id="dvHeading">
            <div class="col-md-12">
                <div class="col-md-2">
                    <asp:Label ID="lblHeading" runat="server" Text="Scheme Details" Font-Bold="true"
                        Font-Size="Larger" ForeColor="#2475C7"></asp:Label>
                         
                </div>
               
                <div class="col-md-4">
                  <asp:RadioButtonList ID="rblNFOType" runat="server" AutoPostBack="true" RepeatDirection="Horizontal" 
                    OnSelectedIndexChanged="rblNFOType_OnSelectedIndexChanged" 
                    BorderStyle="None" CellSpacing="2"  CellPadding="2" >
                    <asp:ListItem Text="Active" Value="true" Selected="True" style="margin-right:10px; font-size:small;color:#2475C7"></asp:ListItem>
                        <asp:ListItem Text="Closed" Value="false" style=" font-size:small;color:#2475C7"></asp:ListItem>
                    </asp:RadioButtonList>
                   
                </div>
                 <div class="col-md-4">
                </div>
            </div>
        </div>
        <div class="container" id="dvSchemeDetails" runat="server" visible="false" >
            <div class="row">
                <div id="no-more-tables">
                    <table class="col-md-12 table-bordered table-striped table-condensed cf" style="width: 90%; margin-left:1%">
                        <thead class="cf">
                            <tr style=" background-color: #2480c7; font-size: small; color: White;
                                text-align: center">
                                <th data-title="SchemeRank" class="alignCenter" runat="server" visible="false" id="thSchemeRank">
                                    Rank
                                </th>
                                <th data-title="Scheme Name" class="alignCenter">
                                    Scheme
                                </th>
                                <th data-title="category" class="alignCenter" runat="server" visible="false" id="thNFOcategory">
                                    Category
                                </th>
                                <th data-title="Rating" class="alignCenter">
                                    Rating
                                </th>
                                <th data-title="FundManager" class="alignCenter">
                                    Fund Manager
                                </th>
                                <th data-title="startDate" class="alignCenter" runat="server" visible="false" id="thNFOStrtDate">
                                    Start Date
                                </th>
                                <th data-title="endDate" class="alignCenter" runat="server" visible="false" id="thNFOEndDate">
                                    End Date
                                </th>
                                <th data-title="MiniAmt" class="alignCenter" runat="server" visible="false" id="thNFOAmt">
                                    Min Initial Amt
                                </th>
                                <th data-title="NAV" class="alignCenter" runat="server" visible="false" id="thNAV">
                                    NAV (Date)
                                </th>
                                <th data-title="Return" class="alignCenter" runat="server" visible="false" id="thReturn">
                                    Returns (1yr / 3Yr / 5yr)
                                </th>
                                <th data-title="Buy" class="alignCenter" runat="server" visible="true" id="thBuy">
                                    Buy
                                </th>
                                <th data-title="SIP" class="alignCenter" runat="server" visible="false" id="thSIP">
                                    SIP
                                </th>
                                <th data-title="Watch" class="alignCenter">
                                    Watch
                                </th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <asp:Repeater ID="rpSchemeDetails" runat="server" OnItemCommand="rpSchemeDetails_OnItemCommand"
                                    OnItemDataBound="rpSchemeDetails_OnItemDataBound">
                                    <ItemTemplate>
                                        <td data-title="SchemeRank" class="alignCenter" runat="server" visible="false" id="tdSchemeRank">
                                            <asp:Label ID="lblSchemeRank" runat="server" Text='<%# Eval("PMFSR_SchemeRank")%>'></asp:Label>
                                        </td>
                                        <td data-title="Scheme Name">
                                            <asp:LinkButton ID="lbSchemeName" runat="server" ToolTip="Click To view Details Information"
                                                CommandName="schemeDetails" CommandArgument='<%# Eval("PASP_SchemePlanCode")%>'
                                                Font-Size="Small"> <%# Eval("PASP_SchemePlanName")%>
                                            </asp:LinkButton>
                                        </td>
                                        <td data-title="category" runat="server" visible="false" id="tdNFOcategory">
                                            <asp:Label ID="lblNFOCategory" runat="server" Text='<%# Eval("PAIC_AssetInstrumentCategoryName")%>'
                                                Font-Size="Small"></asp:Label>
                                        </td>
                                        <td data-title="Rating">
                                            <asp:Image runat="server" ID="imgRatingOvelAll" ImageUrl='<%# string.Format("../Images/MorningStarRating/RatingSmallIcon/{0}.{1}", Eval("SchemeRatingOverall"),"png")%>' />
                                        </td>
                                        <td data-title="FundManager">
                                            <asp:Label ID="Label1" runat="server" Text='<%# Eval("PMFRD_FundManagerName")%>'
                                                Font-Size="Small"></asp:Label>
                                        </td>
                                        <td data-title="startDate" runat="server" visible="false" id="tdNFOStrtDate">
                                            <asp:Label ID="lblNFOStart" runat="server" Text='<%# Eval("PASPD_NFOStartDate")%>'
                                                Font-Size="Small"></asp:Label>
                                        </td>
                                        <td data-title="endDate" runat="server" visible="false" id="tdNFOEndDate">
                                            <asp:Label ID="lblEndDate" runat="server" Text='<%# Eval("PASPD_NFOEndDate")%>' Font-Size="Small"></asp:Label>
                                        </td>
                                        <td data-title="MiniAmt " runat="server" visible="false" id="tdNFOAmt">
                                            <asp:Label ID="lblMiniAmt" runat="server" Text='<%# Eval("MiniAmt")%>' Font-Size="Small"></asp:Label>
                                        </td>
                                        <td data-title="NAV" runat="server" visible="false" id="tdNAV">
                                            <asp:Label ID="lblNavVale" runat="server" Text='<%# Eval("CMFNP_NAVDate")%> ' Font-Size="Small"></asp:Label>
                                        </td>
                                        <td data-title="Return" runat="server" visible="false" id="tdReturn">
                                            <asp:Label ID="lblReturn" runat="server" Text='<%# Eval("schemeReturns")%>' Font-Size="Small"></asp:Label>
                                        </td>
                                        <td data-title="Buy" runat="server" visible="false" id="tdBuy">
                                            <asp:LinkButton ID="lbBuy" runat="server" CommandArgument='<%# Eval("PASP_SchemePlanCode")%>'
                                                CommandName="Buy"  Visible='<%# Eval("IsSchemePurchege")%>' >   
                                                <img src="../Images/Buy_BIG_Buttons.png" height="30px" width="50px"/>
                                              
                                    </span>
                                            </asp:LinkButton>
                                        </td>
                                        <td data-title="SIP" runat="server" visible="false" id="tdSIP">
                                         
                                            <asp:LinkButton ID="lbSIP" runat="server" CommandArgument='<%# Eval("PASP_SchemePlanCode")%>'
                                                CommandName="SIP" Visible='<%# Eval("IsSchemeSIPType")%>' > <img src="../Images/SIP_BIG_Buttons.png" height="30px" width="50px"/>  </asp:LinkButton>
                                        </td>
                                        <td data-title="Watch">
                                            <asp:LinkButton ID="lbRemoveWatch" runat="server" CommandName="RemoveFrmWatch" Visible='<% #(Convert.ToBoolean(Eval("IsInWatch"))==true) ? true : false %>'
                                                Font-Size="Small" CommandArgument='<%# Eval("PASP_SchemePlanCode")%>'>Remove <span class="glyphicon glyphicon-dashboard">
                            </span></asp:LinkButton>
                                            <asp:LinkButton ID="lbAddToWatch" runat="server" CommandName="addToWatch" CommandArgument='<%# Eval("PASP_SchemePlanCode")%>'
                                                Visible='<% #(Convert.ToBoolean(Eval("IsInWatch"))==true) ? false :true %>' Font-Size="Small"> Add To <span class="glyphicon glyphicon-dashboard">
                            </span>
                                            </asp:LinkButton>
                                        </td>
                                        </tr>
                                    </ItemTemplate>
                                </asp:Repeater>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
        <div class="row" style=" margin-left:1%; margin-top:2%">
            <asp:Repeater ID="rptPager" runat="server">
                <ItemTemplate>
                    <asp:LinkButton ID="lnkPage" runat="server" Text='<%#Eval("Text") %>' CommandArgument='<%# Eval("Value") %>'
                        CssClass='<%# Convert.ToBoolean(Eval("Enabled")) ? "page_enabled" : "page_disabled" %>'
                        OnClick="Page_Changed"></asp:LinkButton>
                </ItemTemplate>
            </asp:Repeater>
        </div>
       </div>
        <asp:HiddenField ID="hfAMCCode" runat="server" />
        <asp:HiddenField ID="hfSchemeCode" runat="server" />
        <asp:HiddenField ID="hfCategory" runat="server" />
        <asp:HiddenField ID="hfCustomerId" runat="server" />
        <asp:HiddenField ID="hfIsSchemeDetails" runat="server" />
        <asp:HiddenField ID="hfNFOType" runat="server" />
    </ContentTemplate>
    <Triggers>
    </Triggers>
</asp:UpdatePanel>
<Banner:footer ID="MyHeader" assetCategory="MF" runat="server" />
