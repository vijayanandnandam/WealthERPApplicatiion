﻿<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="RMMultipleTransactionView.ascx.cs"
    Inherits="WealthERP.CustomerPortfolio.RMMultipleTransactionView" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Charting" Assembly="Telerik.Web.UI" %>
<%@ Register Src="~/General/Pager.ascx" TagPrefix="Pager" TagName="Pager" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:ScriptManager ID="scptMgr" runat="server">
</asp:ScriptManager>

<script type="text/javascript" language="javascript">
    function GetParentCustomerId(source, eventArgs) {
        document.getElementById("<%= txtParentCustomerId.ClientID %>").value = eventArgs.get_value();
        return false;
    };


    function keyPress(sender, args) {
        if (args.keyCode == 13) {
            return false;
        }
    }
</script>

<style type="text/css" media="print">
    ..noDisplay
    {
    }
    .noPrint
    {
        display: none;
    }
    .landScape
    {
        width: 100%;
        height: 100%;
        margin: 0% 0% 0% 0%;
        filter: progid:DXImageTransform.Microsoft.BasicImage(Rotation=3);
    }
    .pageBreak
    {
        page-break-before: always;
    }
</style>
<asp:UpdatePanel ID="UpdatePanel1" runat="server">
    <ContentTemplate>
        <table width="100%" cellpadding="0" cellspacing="0">
            <tr>
                <td>
                    <table width="100%">
                        <tr>
                            <td style="width: 100%;">
                                <div class="divPageHeading">
                                    <table cellspacing="0" cellpadding="3" width="100%">
                                        <tr>
                                            <td align="left">
                                               View MF Transaction
                                            </td>
                                            <td align="right" style="padding-bottom: 2px;">
                                                <asp:LinkButton ID="lbBack" runat="server" Text="Back" OnClick="lbBack_Click" Visible="false"
                                                    CssClass="FieldName"></asp:LinkButton>
                                                <asp:ImageButton ID="btnTrnxExport" ImageUrl="~/Images/Export_Excel.png" Visible="false"
                                                    runat="server" AlternateText="Excel" ToolTip="Export To Excel" OnClientClick="setFormat('excel')"
                                                    Height="23px" Width="25px" OnClick="btnTrnxExport_Click"></asp:ImageButton>
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <div>
                <tr>
                    <td>
                        <table>
                            <tr id="trRangeNcustomer" runat="server">
                                <td align="right">
                                    <asp:Label ID="Label2" runat="server" CssClass="FieldName" Text="Date Type :"></asp:Label>
                                </td>
                                <td align="left">
                                    <asp:RadioButton ID="rbtnPickDate" AutoPostBack="true" Checked="true" OnCheckedChanged="rbtnDate_CheckedChanged"
                                        runat="server" GroupName="Date" />
                                    <asp:Label ID="lblPickDate" runat="server" Text="Date Range" CssClass="Field"></asp:Label>
                                    &nbsp;
                                    <asp:RadioButton ID="rbtnPickPeriod" AutoPostBack="true" OnCheckedChanged="rbtnDate_CheckedChanged"
                                        runat="server" GroupName="Date" />
                                    <asp:Label ID="lblPickPeriod" runat="server" Text="Period" CssClass="Field"></asp:Label>
                                </td>
                                <td>
                                    &nbsp;&nbsp;
                                </td>
                                <td align="right">
                                    <asp:Label ID="lblCustomerGroup" runat="server" CssClass="FieldName" Text="Customer :"></asp:Label>
                                </td>
                                <td align="left">
                                    <asp:RadioButton ID="rbtnAll" AutoPostBack="true" Checked="true" runat="server" GroupName="GroupAll"
                                        Text="All" CssClass="cmbField" OnCheckedChanged="rbtnAll_CheckedChanged" />
                                    &nbsp;
                                    <asp:RadioButton ID="rbtnGroup" AutoPostBack="true" runat="server" GroupName="GroupAll"
                                        Text="Group" CssClass="cmbField" OnCheckedChanged="rbtnAll_CheckedChanged" />
                                </td>
                            </tr>
                            <tr id="trRange" visible="false" runat="server" onkeypress="return keyPress(this, event)">
                                <td align="right" valign="top">
                                    <asp:Label ID="lblFromDate" runat="server" CssClass="FieldName">From:</asp:Label>
                                </td>
                                <td valign="top">
                                    <telerik:RadDatePicker ID="txtFromDate" CssClass="txtField" runat="server" Culture="English (United States)"
                                        Skin="Telerik" EnableEmbeddedSkins="false" ShowAnimation-Type="Fade" MinDate="1900-01-01">
                                        <Calendar ID="Calendar1" runat="server" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False"
                                            ViewSelectorText="x" Skin="Telerik" EnableEmbeddedSkins="false">
                                        </Calendar>
                                        <DatePopupButton ImageUrl="" HoverImageUrl=""></DatePopupButton>
                                        <DateInput ID="DateInput1" runat="server" DisplayDateFormat="d/M/yyyy" DateFormat="d/M/yyyy">
                                        </DateInput>
                                    </telerik:RadDatePicker>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" ControlToValidate="txtFromDate"
                                        CssClass="rfvPCG" ErrorMessage="<br />Please select a From Date" Display="Dynamic"
                                        runat="server" InitialValue="" ValidationGroup="btnGo"> </asp:RequiredFieldValidator>
                                </td>
                                <td>
                                    &nbsp;&nbsp;
                                </td>
                                <td align="right" valign="top">
                                    <asp:Label ID="lblToDate" runat="server" CssClass="FieldName">To:</asp:Label>
                                </td>
                                <td valign="top">
                                    <telerik:RadDatePicker ID="txtToDate" CssClass="txtTo" runat="server" Culture="English (United States)"
                                        Skin="Telerik" EnableEmbeddedSkins="false" ShowAnimation-Type="Fade" MinDate="1900-01-01">
                                        <Calendar ID="Calendar2" runat="server" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False"
                                            ViewSelectorText="x" Skin="Telerik" EnableEmbeddedSkins="false">
                                        </Calendar>
                                        <DatePopupButton ImageUrl="" HoverImageUrl=""></DatePopupButton>
                                        <DateInput ID="DateInput2" runat="server" DisplayDateFormat="d/M/yyyy" DateFormat="d/M/yyyy">
                                        </DateInput>
                                    </telerik:RadDatePicker>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" ControlToValidate="txtToDate"
                                        CssClass="rfvPCG" ErrorMessage="<br />Please select a To Date" Display="Dynamic"
                                        runat="server" InitialValue="" ValidationGroup="btnGo"> </asp:RequiredFieldValidator>
                                    <asp:CompareValidator ID="CompareValidator1" runat="server" ErrorMessage="To Date should not be less than From Date"
                                        Type="Date" ControlToValidate="txtToDate" ControlToCompare="txtFromDate" Operator="GreaterThanEqual"
                                        CssClass="cvPCG" Display="Dynamic" ValidationGroup="btnGo"></asp:CompareValidator>
                                </td>
                            </tr>
                            <tr id="trPeriod" visible="false" runat="server">
                                <td align="right" valign="top">
                                    <asp:Label ID="lblPeriod" runat="server" CssClass="FieldName">Period:</asp:Label>
                                </td>
                                <td valign="top">
                                    <asp:DropDownList ID="ddlPeriod" runat="server" CssClass="cmbField">
                                    </asp:DropDownList>
                                    <span id="Span4" class="spnRequiredField"></span>
                                    <br />
                                    <asp:CompareValidator ID="CompareValidator2" runat="server" ControlToValidate="ddlPeriod"
                                        CssClass="rfvPCG" ErrorMessage="Please select a Period" Operator="NotEqual" ValueToCompare="Select a Period"
                                        ValidationGroup="btnGo"> </asp:CompareValidator>
                                </td>
                                <td>
                                    &nbsp;&nbsp;
                                </td>
                                <td colspan="2">
                                    &nbsp;
                                </td>
                            </tr>
                            <tr id="trGroupHead" runat="server">
                                <td align="right" valign="top">
                                    <asp:Label ID="lblGroupHead" runat="server" CssClass="FieldName" Text="Group Head :"></asp:Label>
                                </td>
                                <td valign="top">
                                    <asp:TextBox ID="txtParentCustomer" runat="server" CssClass="txtField" AutoPostBack="true"
                                        AutoComplete="Off"></asp:TextBox>
                                    <cc1:TextBoxWatermarkExtender ID="txtParentCustomer_TextBoxWatermarkExtender" runat="server"
                                        TargetControlID="txtParentCustomer" WatermarkText="Type the Customer Name">
                                    </cc1:TextBoxWatermarkExtender>
                                    <cc1:AutoCompleteExtender ID="txtParentCustomer_autoCompleteExtender" runat="server"
                                        TargetControlID="txtParentCustomer" ServiceMethod="GetParentCustomerName" ServicePath="~/CustomerPortfolio/AutoComplete.asmx"
                                        MinimumPrefixLength="1" EnableCaching="false" CompletionSetCount="5" CompletionInterval="100"
                                        CompletionListCssClass="AutoCompleteExtender_CompletionList" CompletionListItemCssClass="AutoCompleteExtender_CompletionListItem"
                                        CompletionListHighlightedItemCssClass="AutoCompleteExtender_HighlightedItem"
                                        UseContextKey="true" OnClientItemSelected="GetParentCustomerId" />
                                </td>
                                <td>
                                    &nbsp;&nbsp;
                                </td>
                                <td colspan="2">
                                    &nbsp;
                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    <asp:Label ID="Label1" runat="server" CssClass="FieldName" Text="Portfolio :"></asp:Label>
                                </td>
                                <td align="left">
                                    <asp:DropDownList ID="ddlPortfolioGroup" runat="server" CssClass="cmbField">
                                        <asp:ListItem Text="Managed" Value="1">Managed</asp:ListItem>
                                        <asp:ListItem Text="UnManaged" Value="0">UnManaged</asp:ListItem>
                                    </asp:DropDownList>
                                </td>
                                <td>
                                    &nbsp;&nbsp;
                                </td>
                                <td align="right">
                                    <asp:Label ID="Label4" runat="server" CssClass="FieldName" Text="Display Type :"></asp:Label>
                                </td>
                                <td>
                                    <asp:DropDownList ID="ddlDisplayType" runat="server" AutoPostBack="true" CssClass="cmbField">
                                        <asp:ListItem Text="TransactionView " Value="0">Transaction View</asp:ListItem>
                                        <asp:ListItem Text="BalanceView" Value="1">Return Holding View</asp:ListItem>
                                    </asp:DropDownList>
                                </td>
                                <td>
                                    &nbsp;
                                </td>
                                <tr>
                                    <td>
                                        <asp:Button ID="btnGo" runat="server" OnClick="btnGo_Click" Text="Go" CssClass="PCGButton"
                                            ValidationGroup="btnGo" onmouseover="javascript:ChangeButtonCss('hover', 'ctrl_RMMultipleTransactionView_btnGo', 'S');"
                                            onmouseout="javascript:ChangeButtonCss('out', 'ctrl_RMMultipleTransactionView_btnGo', 'S');" />
                                    </td>
                                </tr>
                            </tr>
                        </table>
                    </td>
                </tr>
            </div>
            <tr>
                <td>
                    <asp:UpdateProgress ID="UpdateProgress1" runat="server" AssociatedUpdatePanelID="UpdatePanel1">
                        <ProgressTemplate>
                            <table width="100%">
                                <tr>
                                    <td align="center">
                                        <asp:Image ID="imgProgress" ImageUrl="~/Images/ajax-loader.gif" AlternateText="Processing"
                                            runat="server" />
                                    </td>
                                </tr>
                            </table>
                            <%--<img alt="Processing" src="~/Images/ajax_loader.gif" style="width: 200px; height: 100px" />--%>
                        </ProgressTemplate>
                    </asp:UpdateProgress>
                </td>
            </tr>
            <%-- <div style="width: 100%">
                <telerik:RadTabStrip ID="RadTabStrip1" runat="server" EnableTheming="True" Skin="Telerik" OnTabClick="TabClick"
                    EnableEmbeddedSkins="False" MultiPageID="TransactionMIS" SelectedIndex="1">
                    <Tabs>
                        <telerik:RadTab runat="server" Text="Transaction View" Value="Transaction View" TabIndex="0"
                            Selected="True">
                        </telerik:RadTab>
                        <telerik:RadTab runat="server" Text="Balance View" Value="Balance View" TabIndex="1">
                        </telerik:RadTab>
                    </Tabs>
                </telerik:RadTabStrip>
                <telerik:RadMultiPage ID="TransactionMIS" EnableViewState="true" runat="server" SelectedIndex="0"
                    Width="100%">
                    <telerik:RadPageView ID="RadPageView1" runat="server">--%>
            <tr>
                <td style="padding-top: 20px">
                    <div id="tbl" runat="server">
                        <asp:Panel ID="Panel2" runat="server" class="Landscape" Width="100%" ScrollBars="Horizontal">
                            <table width="100%" cellspacing="0" cellpadding="0">
                                <tr>
                                    <td>
                                        <div id="dvTransactionsView" runat="server" style="margin: 2px; width: 640px;">
                                            <telerik:RadGrid ID="gvMFTransactions" runat="server" GridLines="None" AutoGenerateColumns="False"
                                                AllowFiltering="true" AllowFilteringByColumn="true" PageSize="10" AllowSorting="true" OnPreRender="gvMFTransactions_PreRender"
                                                AllowPaging="True" ShowStatusBar="True" OnItemCommand="gvMFTransactions_OnItemCommand" OnItemDataBound="gvMFTransactions_ItemDataBound" 
                                                OnNeedDataSource="gvMFTransactions_OnNeedDataSource" ShowFooter="true" Skin="Telerik"
                                                EnableEmbeddedSkins="false" Width="120%" AllowAutomaticInserts="false">
                                                <ExportSettings HideStructureColumns="true" ExportOnlyData="true" IgnorePaging="true">
                                                </ExportSettings>
                                                <MasterTableView DataKeyNames="TransactionId" Width="100%" AllowMultiColumnSorting="True"
                                                    AutoGenerateColumns="false" CommandItemDisplay="None">
                                                    <Columns>
                                                        <telerik:GridTemplateColumn AllowFiltering="false" FooterText="Grand Total:" HeaderStyle-Wrap="false">
                                                            <ItemStyle Wrap="false" />
                                                            <ItemTemplate>
                                                                <asp:LinkButton ID="lnkView" runat="server" CssClass="cmbField" Text="View Details"
                                                                    OnClick="lnkView_Click">
                                                                </asp:LinkButton>
                                                            </ItemTemplate>
                                                        </telerik:GridTemplateColumn>
                                                        <telerik:GridBoundColumn DataField="Customer Name" HeaderText="Customer" AllowFiltering="true"
                                                            HeaderStyle-Wrap="false" SortExpression="Customer Name" ShowFilterIcon="false"
                                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" UniqueName="Customer Name"
                                                            FooterStyle-HorizontalAlign="Left">
                                                            <ItemStyle Width="" HorizontalAlign="Left" Wrap="false" VerticalAlign="Top" />
                                                        </telerik:GridBoundColumn>
                                                        <telerik:GridBoundColumn DataField="TransactionId" HeaderText="TransactionId" AllowFiltering="false"
                                                            Visible="false" SortExpression="TransactionId" ShowFilterIcon="false" CurrentFilterFunction="Contains"
                                                            AutoPostBackOnFilter="true" UniqueName="TransactionId" FooterStyle-HorizontalAlign="Left">
                                                            <ItemStyle Width="" HorizontalAlign="Left" Wrap="false" VerticalAlign="Top" />
                                                        </telerik:GridBoundColumn>
                                                        <telerik:GridBoundColumn DataField="CMFT_SubBrokerCode" HeaderText="Sub-Broker Code"
                                                            AllowFiltering="false" SortExpression="CMFT_SubBrokerCode" ShowFilterIcon="false"
                                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" UniqueName="CMFT_SubBrokerCode"
                                                            FooterStyle-HorizontalAlign="Left">
                                                            <ItemStyle Width="" HorizontalAlign="Left" Wrap="false" VerticalAlign="Top" />
                                                        </telerik:GridBoundColumn>
                                                        <telerik:GridBoundColumn DataField="Folio Number" HeaderText="Folio No." AllowFiltering="true"
                                                            SortExpression="Folio Number" ShowFilterIcon="false" CurrentFilterFunction="Contains"
                                                            AutoPostBackOnFilter="true" UniqueName="Folio Number" FooterStyle-HorizontalAlign="Left">
                                                            <ItemStyle Width="" HorizontalAlign="Left" Wrap="false" VerticalAlign="Top" />
                                                        </telerik:GridBoundColumn>
                                                        <telerik:GridBoundColumn DataField="Category" HeaderText="Category" AllowFiltering="true"
                                                            HeaderStyle-Wrap="false" SortExpression="Category" ShowFilterIcon="false" CurrentFilterFunction="Contains"
                                                            AutoPostBackOnFilter="true" UniqueName="Category" FooterStyle-HorizontalAlign="Left">
                                                            <ItemStyle Width="" HorizontalAlign="Left" Wrap="false" VerticalAlign="Top" />
                                                        </telerik:GridBoundColumn>
                                                        <telerik:GridBoundColumn DataField="PAISC_AssetInstrumentSubCategoryName" HeaderText="Sub Category"
                                                            AllowFiltering="false" HeaderStyle-Wrap="false" SortExpression="PAISC_AssetInstrumentSubCategoryName"
                                                            ShowFilterIcon="false" CurrentFilterFunction="Contains" AutoPostBackOnFilter="true"
                                                            UniqueName="PAISC_AssetInstrumentSubCategoryName" FooterStyle-HorizontalAlign="Left">
                                                            <ItemStyle Width="" HorizontalAlign="Left" Wrap="false" VerticalAlign="Top" />
                                                        </telerik:GridBoundColumn>
                                                        <telerik:GridBoundColumn DataField="AMC" HeaderText="AMC" AllowFiltering="true" HeaderStyle-Wrap="false"
                                                            SortExpression="AMC" ShowFilterIcon="false" CurrentFilterFunction="Contains"
                                                            AutoPostBackOnFilter="true" UniqueName="AMC" FooterStyle-HorizontalAlign="Left">
                                                            <ItemStyle Width="" HorizontalAlign="Left" Wrap="false" VerticalAlign="Top" />
                                                        </telerik:GridBoundColumn>
                                                        <telerik:GridTemplateColumn AllowFiltering="true" HeaderText="Scheme" ShowFilterIcon="false">
                                                            <ItemStyle Wrap="false" />
                                                            <ItemTemplate>
                                                                <asp:LinkButton ID="lnkprAmc" runat="server" CommandName="Scheme" Text='<%# Eval("Scheme Name").ToString() %>' />
                                                            </ItemTemplate>
                                                        </telerik:GridTemplateColumn>
                                                        <telerik:GridBoundColumn DataField="Transaction Type" HeaderText="Type" AllowFiltering="true"
                                                            HeaderStyle-Wrap="false" SortExpression="Transaction Type" ShowFilterIcon="false"
                                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" UniqueName="Transaction Type"
                                                            FooterStyle-HorizontalAlign="Left">
                                                            <ItemStyle Width="" HorizontalAlign="Left" Wrap="false" VerticalAlign="Top" />
                                                        </telerik:GridBoundColumn>
                                                        <telerik:GridBoundColumn DataField="Transaction Date" HeaderText="Date" AllowFiltering="true"
                                                            HeaderStyle-Wrap="false" SortExpression="Transaction Date" ShowFilterIcon="false"
                                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" UniqueName="Transaction Date"
                                                            FooterStyle-HorizontalAlign="Center">
                                                            <ItemStyle Width="" HorizontalAlign="Center" Wrap="false" VerticalAlign="Top" />
                                                        </telerik:GridBoundColumn>
                                                        <telerik:GridBoundColumn DataField="Price" HeaderText="Price (Rs)" AllowFiltering="false"
                                                            SortExpression="Price" ShowFilterIcon="false" CurrentFilterFunction="Contains"
                                                            HeaderStyle-Wrap="false" AutoPostBackOnFilter="true" UniqueName="Price" FooterStyle-HorizontalAlign="Right"
                                                            DataFormatString="{0:n}" Aggregate="Sum">
                                                            <ItemStyle Width="" HorizontalAlign="Right" Wrap="false" VerticalAlign="Top" />
                                                        </telerik:GridBoundColumn>
                                                        <telerik:GridBoundColumn DataField="Units" HeaderText="Units" AllowFiltering="false"
                                                            HeaderStyle-Wrap="false" SortExpression="Units" ShowFilterIcon="false" CurrentFilterFunction="Contains"
                                                            AutoPostBackOnFilter="true" UniqueName="Units" FooterStyle-HorizontalAlign="Right"
                                                            DataFormatString="{0:n}" Aggregate="Sum">
                                                            <ItemStyle Width="" HorizontalAlign="Right" Wrap="false" VerticalAlign="Top" />
                                                        </telerik:GridBoundColumn>
                                                        <telerik:GridBoundColumn DataField="Amount" HeaderText="Amount (Rs)" AllowFiltering="false"
                                                            HeaderStyle-Wrap="false" SortExpression="Amount" ShowFilterIcon="false" CurrentFilterFunction="Contains"
                                                            AutoPostBackOnFilter="true" UniqueName="Amount" FooterStyle-HorizontalAlign="Right"
                                                            DataFormatString="{0:n}" Aggregate="Sum">
                                                            <ItemStyle Width="" HorizontalAlign="Right" Wrap="false" VerticalAlign="Top" />
                                                        </telerik:GridBoundColumn>
                                                        <telerik:GridBoundColumn DataField="STT" HeaderText="STT (Rs)" AllowFiltering="false"
                                                            HeaderStyle-Wrap="false" SortExpression="STT" ShowFilterIcon="false" CurrentFilterFunction="Contains"
                                                            AutoPostBackOnFilter="true" UniqueName="STT" FooterStyle-HorizontalAlign="Right"
                                                            DataFormatString="{0:n}" Aggregate="Sum">
                                                            <ItemStyle Width="" HorizontalAlign="Right" Wrap="false" VerticalAlign="Top" />
                                                        </telerik:GridBoundColumn>
                                                        <telerik:GridBoundColumn DataField="Portfolio Name" HeaderText="Portfolio Name" AllowFiltering="false"
                                                            HeaderStyle-Wrap="false" SortExpression="Portfolio Name" ShowFilterIcon="false"
                                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" UniqueName="Portfolio Name"
                                                            FooterStyle-HorizontalAlign="Left">
                                                            <ItemStyle Width="" HorizontalAlign="Left" Wrap="false" VerticalAlign="Top" />
                                                        </telerik:GridBoundColumn>
                                                        <telerik:GridBoundColumn DataField="ADUL_ProcessId" HeaderText="Process ID" AllowFiltering="true"
                                                            HeaderStyle-Wrap="false" SortExpression="ADUL_ProcessId" ShowFilterIcon="false"
                                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" UniqueName="ADUL_ProcessId"
                                                            FooterStyle-HorizontalAlign="Left">
                                                            <ItemStyle Width="" HorizontalAlign="Left" Wrap="false" VerticalAlign="Top" />
                                                        </telerik:GridBoundColumn>
                                                        <telerik:GridBoundColumn DataField="TransactionStatus" HeaderText="Transaction Status" AllowFiltering="true"
                                                            HeaderStyle-Wrap="false" SortExpression="TransactionStatus"
                                                            ShowFilterIcon="false"  AutoPostBackOnFilter="true" UniqueName="TransactionStatus" FooterStyle-HorizontalAlign="Left">
                                                            <ItemStyle Width="" HorizontalAlign="Left" Wrap="false" VerticalAlign="Top" />
                                                            <FilterTemplate>
                                                                <telerik:RadComboBox ID="RadComboBoxTS" AutoPostBack="true" AllowFiltering="true" CssClass="cmbField" Width="100px"  IsFilteringEnabled="true"
                                                                    AppendDataBoundItems="true" OnPreRender="Transaction_PreRender" EnableViewState="true"
                                                                    OnSelectedIndexChanged="RadComboBoxTS_SelectedIndexChanged" SelectedValue='<%# ((GridItem)Container).OwnerTableView.GetColumn("TransactionStatus").CurrentFilterValue %>'
                                                                    runat="server">
                                                                    <Items>
                                                                        <telerik:RadComboBoxItem Text="ALL" Value="" Selected="false"></telerik:RadComboBoxItem>
                                                                        <telerik:RadComboBoxItem Text="OK" Value="OK"  Selected="false" ></telerik:RadComboBoxItem>
                                                                        <telerik:RadComboBoxItem Text="Cancel" Value="Cancel"  Selected="false" ></telerik:RadComboBoxItem>
                                                                        <telerik:RadComboBoxItem Text="Original" Value="Original"  Selected="false" ></telerik:RadComboBoxItem>
                                                                        
                                                                   </Items>
                                                                   </telerik:RadComboBox>
                                                                   <telerik:RadScriptBlock ID="RadScriptBlock2" runat="server">
                                                                    <script type="text/javascript">
                                                                        function TransactionIndexChanged(sender, args) {
                                                                            var tableView = $find("<%#((GridItem)Container).OwnerTableView.ClientID %>");
                                                                            //////                                                    sender.value = args.get_item().get_value();
                                                                            tableView.filter("RadComboBoxTS", args.get_item().get_value(), "EqualTo");
                                                                        }
                                                                    </script>
                                                                </telerik:RadScriptBlock>
                                                            </FilterTemplate>
                                                        </telerik:GridBoundColumn>
                                                    </Columns>
                                                </MasterTableView>
                                                <ClientSettings>
                                                <Selecting AllowRowSelect="True" EnableDragToSelectRows="True" />
                                                </ClientSettings>
                                            </telerik:RadGrid>
                                        </div>
                                    </td>
                                </tr>
                            </table>
                        </asp:Panel>
                    </div>
                </td>
            </tr>
            <table id="tbspace" runat="server" cellpadding="5">
                <tr>
                    <td>
                    </td>
                </tr>
            </table>
            <tr>
                <td style="padding-top: 20px">
                    <div id="Div1" runat="server">
                        <asp:Panel ID="Panel1" runat="server" class="Landscape" Width="100%" ScrollBars="Horizontal">
                            <table width="100%" cellspacing="0" cellpadding="0">
                                <tr>
                                    <td>
                                        <div id="dvBalanceView" runat="server" style="margin: 2px; width: 640px;">
                                            <telerik:RadGrid ID="gvBalanceView" runat="server" GridLines="None" AutoGenerateColumns="False"
                                                AllowFiltering="true" AllowFilteringByColumn="true" PageSize="10" AllowSorting="true"
                                                AllowPaging="True" ShowStatusBar="True" OnNeedDataSource="gvMFBalance_OnNeedDataSource"
                                                ShowFooter="true" Skin="Telerik" EnableEmbeddedSkins="false" Width="120%" AllowAutomaticInserts="false"
                                                ExportSettings-ExportOnlyData="true">
                                                <ExportSettings HideStructureColumns="true" ExportOnlyData="true" IgnorePaging="true"
                                                    FileName="View Balance" Excel-Format="ExcelML">
                                                </ExportSettings>
                                                <MasterTableView DataKeyNames="TransactionId" Width="100%" AllowMultiColumnSorting="True"
                                                    AutoGenerateColumns="false" CommandItemDisplay="None">
                                                    <Columns>
                                                        <telerik:GridTemplateColumn AllowFiltering="false" FooterText="Grand Total:" HeaderStyle-Wrap="false">
                                                            <ItemStyle Wrap="false" />
                                                    <ItemTemplate>
                                                                <asp:LinkButton ID="lnkView" runat="server" CssClass="cmbField" Text="View Details"
                                                                    OnClick="lnkView_Click">
                                                                </asp:LinkButton>
                                                            </ItemTemplate>
                                                        </telerik:GridTemplateColumn>
                                                         <telerik:GridBoundColumn DataField="Customer Name" HeaderText="Customer" AllowFiltering="true"
                                                            HeaderStyle-Wrap="false" SortExpression="Customer Name" ShowFilterIcon="false"
                                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" UniqueName="Customer Name"
                                                            FooterStyle-HorizontalAlign="Left">
                                                            <ItemStyle Width="" HorizontalAlign="Left" Wrap="false" VerticalAlign="Top" />
                                                        </telerik:GridBoundColumn>
                                                        <telerik:GridBoundColumn DataField="Folio Number" HeaderText="Folio No." AllowFiltering="true"
                                                            SortExpression="Folio Number" ShowFilterIcon="false" CurrentFilterFunction="Contains"
                                                            AutoPostBackOnFilter="true" UniqueName="Folio Number" FooterStyle-HorizontalAlign="Left">
                                                            <ItemStyle Width="" HorizontalAlign="Right" Wrap="false" VerticalAlign="Top" />
                                                        </telerik:GridBoundColumn>
                                                        <telerik:GridBoundColumn DataField="TransactionId" HeaderText="TransactionId" AllowFiltering="false"
                                                            Visible="false" SortExpression="TransactionId" ShowFilterIcon="false" CurrentFilterFunction="Contains"
                                                            AutoPostBackOnFilter="true" UniqueName="TransactionId" FooterStyle-HorizontalAlign="Left">
                                                            <ItemStyle Width="" HorizontalAlign="Left" Wrap="false" VerticalAlign="Top" />
                                                        </telerik:GridBoundColumn>
                                                        <telerik:GridBoundColumn DataField="Transaction Date" HeaderText="Transaction Date"
                                                            AllowFiltering="false" Visible="false" SortExpression="Transaction Date" ShowFilterIcon="false"
                                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" UniqueName="Transaction Date"
                                                            FooterStyle-HorizontalAlign="Left">
                                                            <ItemStyle Width="" HorizontalAlign="Left" Wrap="false" VerticalAlign="Top" />
                                                        </telerik:GridBoundColumn>
                                                        <telerik:GridTemplateColumn AllowFiltering="true" HeaderText="Scheme" ShowFilterIcon="false">
                                                            <ItemStyle Wrap="false" />
                                                            <ItemTemplate>
                                                                <asp:LinkButton ID="lnkprAmc" runat="server" CommandName="Scheme" Text='<%# Eval("Scheme Name").ToString() %>' />
                                                            </ItemTemplate>
                                                        </telerik:GridTemplateColumn>
                                                        <telerik:GridBoundColumn DataField="Category" HeaderText="Category" AllowFiltering="true"
                                                            HeaderStyle-Wrap="false" SortExpression="Category" ShowFilterIcon="false" CurrentFilterFunction="Contains"
                                                            AutoPostBackOnFilter="true" UniqueName="Category" FooterStyle-HorizontalAlign="Left">
                                                            <ItemStyle Width="" HorizontalAlign="Left" Wrap="false" VerticalAlign="Top" />
                                                        </telerik:GridBoundColumn>
                                                        <telerik:GridBoundColumn DataField="PAISC_AssetInstrumentSubCategoryName" HeaderText="Sub Category"
                                                            AllowFiltering="false" HeaderStyle-Wrap="false" SortExpression="PAISC_AssetInstrumentSubCategoryName"
                                                            ShowFilterIcon="false" CurrentFilterFunction="Contains" AutoPostBackOnFilter="true"
                                                            UniqueName="PAISC_AssetInstrumentSubCategoryName" FooterStyle-HorizontalAlign="Left">
                                                            <ItemStyle Width="" HorizontalAlign="Left" Wrap="false" VerticalAlign="Top" />
                                                        </telerik:GridBoundColumn>
                                                        <telerik:GridBoundColumn DataField="Transaction Type" HeaderText="Type" AllowFiltering="true"
                                                            HeaderStyle-Wrap="false" SortExpression="Transaction Type" ShowFilterIcon="false"
                                                            CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" UniqueName="Transaction Type"
                                                            FooterStyle-HorizontalAlign="Left">
                                                            <ItemStyle Width="" HorizontalAlign="Left" Wrap="false" VerticalAlign="Top" />
                                                        </telerik:GridBoundColumn>
                                                           <telerik:GridBoundColumn DataField="Amount" HeaderText="Amount (Rs)" AllowFiltering="false"
                                                            HeaderStyle-Wrap="false" SortExpression="Amount" ShowFilterIcon="false" CurrentFilterFunction="Contains"
                                                            AutoPostBackOnFilter="true" UniqueName="Amount" FooterStyle-HorizontalAlign="Right"
                                                            DataFormatString="{0:n0}" Aggregate="Sum">
                                                            <ItemStyle Width="" HorizontalAlign="Right" Wrap="false" VerticalAlign="Top" />
                                                        </telerik:GridBoundColumn>
                                                        <telerik:GridBoundColumn DataField="Price" HeaderText="Price (Rs)" AllowFiltering="false"
                                                            SortExpression="Price" ShowFilterIcon="false" CurrentFilterFunction="Contains"
                                                            HeaderStyle-Wrap="false" AutoPostBackOnFilter="true" UniqueName="Price" FooterStyle-HorizontalAlign="Right"
                                                            DataFormatString="{0:n4}" Aggregate="Sum">
                                                            <ItemStyle Width="" HorizontalAlign="Right" Wrap="false" VerticalAlign="Top" />
                                                        </telerik:GridBoundColumn>                                                       
                                                         <telerik:GridBoundColumn DataField="NAV" HeaderText="NAV (Rs)" AllowFiltering="false"
                                                            SortExpression="NAV" ShowFilterIcon="false" CurrentFilterFunction="Contains"
                                                            HeaderStyle-Wrap="false" AutoPostBackOnFilter="true" UniqueName="NAV" FooterStyle-HorizontalAlign="Right"
                                                            DataFormatString="{0:n4}" Aggregate="Sum">
                                                            <ItemStyle Width="" HorizontalAlign="Right" Wrap="false" VerticalAlign="Top" />
                                                        </telerik:GridBoundColumn>                                                    
                                                        <telerik:GridBoundColumn DataField="Units" HeaderText="Units" AllowFiltering="false"
                                                            HeaderStyle-Wrap="false" SortExpression="Units" ShowFilterIcon="false" CurrentFilterFunction="Contains"
                                                            AutoPostBackOnFilter="true" UniqueName="Units" FooterStyle-HorizontalAlign="Right"
                                                            DataFormatString="{0:n3}" Aggregate="Sum">
                                                            <ItemStyle Width="" HorizontalAlign="Right" Wrap="false" VerticalAlign="Top" />
                                                        </telerik:GridBoundColumn>                                                     
                                                         <telerik:GridBoundColumn DataField="CurrentValue" HeaderText="Current Value" AllowFiltering="false"
                                                            SortExpression="CurrentValue" ShowFilterIcon="false" CurrentFilterFunction="Contains"
                                                            HeaderStyle-Wrap="false" AutoPostBackOnFilter="true" UniqueName="CurrentValue" FooterStyle-HorizontalAlign="Right"
                                                            DataFormatString="{0:n0}">
                                                            <ItemStyle Width="" HorizontalAlign="Right" Wrap="false" VerticalAlign="Top" />
                                                        </telerik:GridBoundColumn>
                                                        <telerik:GridBoundColumn DataField="Age" HeaderText="Age" AllowFiltering="false"
                                                            HeaderStyle-Wrap="false" SortExpression="CMFTB_Age" ShowFilterIcon="false" CurrentFilterFunction="Contains"
                                                            AutoPostBackOnFilter="true" UniqueName="CMFTB_Age" FooterStyle-HorizontalAlign="Left">
                                                            <ItemStyle Width="" HorizontalAlign="Left" Wrap="false" VerticalAlign="Top" />
                                                        </telerik:GridBoundColumn>
                                                        <telerik:GridBoundColumn DataField="Balance" HeaderText="Abs Rtn(%)" AllowFiltering="false"  DataFormatString="{0:n2}" 
                                                            HeaderStyle-Wrap="false" SortExpression="Return" ShowFilterIcon="false" CurrentFilterFunction="Contains"
                                                            AutoPostBackOnFilter="true" UniqueName="Return" FooterStyle-HorizontalAlign="Left">
                                                            <ItemStyle Width="" HorizontalAlign="Left" Wrap="false" VerticalAlign="Top" />
                                                        </telerik:GridBoundColumn>
                                                    </Columns>
                                                </MasterTableView>
                                                <ClientSettings>
                                                    <Selecting AllowRowSelect="True" EnableDragToSelectRows="True" />
                                                </ClientSettings>
                                            </telerik:RadGrid>
                                        </div>
                                    </td>
                                </tr>
                            </table>
                        </asp:Panel>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <table id="ErrorMessage" align="center" runat="server">
                        <tr>
                            <td>
                                <div class="failure-msg" align="center">
                                    No Records found.....
                                </div>
                            </td>
                        </tr>
                    </table>
                    <asp:HiddenField ID="hdnRecordCount" runat="server" Visible="false" />
                    <asp:HiddenField ID="hdnCurrentPage" runat="server" />
                    <asp:HiddenField ID="hdnCustomerNameSearch" runat="server" Visible="false" />
                    <asp:HiddenField ID="hdnSchemeSearch" runat="server" Visible="false" />
                    <asp:HiddenField ID="hdnTranType" runat="server" Visible="false" />
                    <asp:HiddenField ID="hdnCategory" runat="server" Visible="false" />
                    <asp:HiddenField ID="hdnAMC" runat="server" Visible="false" />
                    <asp:HiddenField ID="hdnFolioNumber" runat="server" Visible="false" />
                    <asp:HiddenField ID="hdnDownloadPageType" runat="server" Visible="true" />
                    <asp:HiddenField ID="hdnDownloadFormat" runat="server" Visible="true" />
                    <asp:HiddenField ID="txtParentCustomerId" runat="server" />
                    <asp:HiddenField ID="txtParentCustomerType" runat="server" />
                    <asp:HiddenField ID="hdnStatus" runat="server" />
                    <asp:HiddenField ID="hdnProcessIdSearch" runat="server" />
                </td>
            </tr>
        </table>
    </ContentTemplate>
    <Triggers>
        <asp:PostBackTrigger ControlID="btnTrnxExport" />
    </Triggers>
</asp:UpdatePanel>
<html>
<body class="Landscape">
</body>
</html>
