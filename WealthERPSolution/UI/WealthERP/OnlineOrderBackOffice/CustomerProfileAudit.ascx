﻿<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="CustomerProfileAudit.ascx.cs"
    Inherits="WealthERP.OnlineOrderBackOffice.CustomerProfileAudit" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>

<script src="../Scripts/jquery.js" type="text/javascript"></script>

<script src="../Scripts/jquery-1.2.6.js" type="text/javascript"></script>

<script src="../Scripts/jquery-1.4.2.min.js" type="text/javascript"></script>

<script src="../Scripts/jquery-ui-1.7.2.custom.min.js" type="text/javascript"></script>

<script src="../Scripts/jquery.min.js" type="text/javascript"></script>

<script src="../Scripts/jquery-1.3.1.min.js" type="text/javascript"></script>

<script src="../Scripts/jQuery.bubbletip-1.0.6.js" type="text/javascript"></script>

<script src="../Scripts/JScript.js" type="text/javascript"></script>

<script type="text/javascript" language="javascript">
    function GetCustomerId(source, eventArgs) {
        isItemSelected = true;
        //         document.getElementById("lblgetPan").innerHTML = "";
        document.getElementById("<%=  hdnCustomerId.ClientID %>").value = eventArgs.get_value();

        return false;
    }

    function ShowIsa() {

        var hdn = document.getElementById("<%=hdnIsSubscripted.ClientID%>").value;
    }
    function GetSchemePlanCode(source, eventArgs) {
        isItemSelected = true;
        //         document.getElementById("lblgetPan").innerHTML = "";
        document.getElementById("<%=  hdnschemePlanId.ClientID %>").value = eventArgs.get_value();

        return false;
    }
</script>

<asp:ScriptManager ID="ScriptManager1" runat="server">
</asp:ScriptManager>
<table width="100%">
    <tr>
        <td>
            <div class="divPageHeading">
                <table cellspacing="0" cellpadding="2" width="100%">
                    <tr>
                        <td align="left">
                            Customer Profile Audit
                        </td>
                    </tr>
                </table>
            </div>
        </td>
    </tr>
</table>
<table width="100%">
    <tr>
        <td >
            <asp:Label ID="lblType" runat="server" Text="Select Type:" CssClass="FieldName"></asp:Label>
       <%-- </td>
        <td >--%>
            <asp:DropDownList ID="ddlType" runat="server" CssClass="cmbField" OnSelectedIndexChanged="ddlType_OnSelectedIndexChanged"
                AutoPostBack="true">
                <asp:ListItem Text="Select" Value="select"></asp:ListItem>
                <asp:ListItem Text="Customer Profile" Value="CustomerProfile"></asp:ListItem>
                <asp:ListItem Text="Scheme" Value="Schemeplan"></asp:ListItem>
            </asp:DropDownList>
        </td>
    </tr>
    <tr>
        <td id="tdSchemePlan" runat="server" visible="false" style="width: 21.5%;">
            <asp:Label ID="lblSchemePlan" runat="server" Text="SchemePlan Name:" CssClass="FieldName"></asp:Label>
            <asp:TextBox ID="txtSchemeName" runat="server" CssClass="txtField" AutoPostBack="True"
                AutoComplete="Off" Width="300px"></asp:TextBox>
            <ajaxToolkit:AutoCompleteExtender ID="txtSchemeName_AutoCompleteExtender" runat="server"
                TargetControlID="txtSchemeName" ServiceMethod="GetSchemeName" ServicePath="~/CustomerPortfolio/AutoComplete.asmx"
                MinimumPrefixLength="3" EnableCaching="False" CompletionSetCount="5" CompletionInterval="100"
                CompletionListCssClass="AutoCompleteExtender_CompletionList" CompletionListItemCssClass="AutoCompleteExtender_CompletionListItem"
                CompletionListHighlightedItemCssClass="AutoCompleteExtender_HighlightedItem"
                UseContextKey="True" OnClientItemSelected="GetSchemePlanCode" DelimiterCharacters=""
                Enabled="True" />
        </td>
        <td style="width: 21.5%;" id="tdCustomer" runat="server" visible="false">
            <asp:Label ID="lblCustName" runat="server" Text="Select Customer:" CssClass="FieldName"></asp:Label>
            <asp:TextBox ID="txtCustomerName" runat="server" CssClass="txtField" AutoComplete="Off"
                AutoPostBack="True" onclientClick="ShowIsa()" Width="165px">  </asp:TextBox>
            <cc1:TextBoxWatermarkExtender ID="txtCustomerName_water" TargetControlID="txtCustomerName"
                WatermarkText="Enter Three Characters" runat="server" EnableViewState="false">
            </cc1:TextBoxWatermarkExtender>
            <ajaxToolkit:AutoCompleteExtender ID="txtCustomerName_autoCompleteExtender" runat="server"
                TargetControlID="txtCustomerName" ServiceMethod="GetCustomerName" ServicePath="~/CustomerPortfolio/AutoComplete.asmx"
                MinimumPrefixLength="3" EnableCaching="False" CompletionSetCount="5" CompletionInterval="100"
                CompletionListCssClass="AutoCompleteExtender_CompletionList" CompletionListItemCssClass="AutoCompleteExtender_CompletionListItem"
                CompletionListHighlightedItemCssClass="AutoCompleteExtender_HighlightedItem"
                UseContextKey="True" OnClientItemSelected="GetCustomerId" DelimiterCharacters=""
                Enabled="True" />
            <br />
            <asp:RequiredFieldValidator ID="rfvCustomerName" ControlToValidate="txtCustomerName"
                ErrorMessage="<br />Please Enter Customer Name" Display="Dynamic" runat="server"
                CssClass="rfvPCG" ValidationGroup="BtnGo"></asp:RequiredFieldValidator>
        </td>
        <td style="width: 15%;" id="tdFromDate" runat="server" visible="false">
            <asp:Label ID="lblModificationDate" runat="server" Text="From:" CssClass="FieldName"></asp:Label>
            <telerik:RadDatePicker ID="rdpFromModificationDate" CssClass="txtField" runat="server"
                AutoPostBack="false" Skin="Telerik" EnableEmbeddedSkins="false">
                <Calendar ID="Calendar1" runat="server" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False"
                    ViewSelectorText="x" Skin="Telerik" EnableEmbeddedSkins="false">
                </Calendar>
                <DateInput ID="DateInput1" runat="server" DisplayDateFormat="d/M/yyyy" DateFormat="d/M/yyyy">
                </DateInput>
            </telerik:RadDatePicker>
            <br />
            <asp:RequiredFieldValidator ID="RFVDModificationDate" runat="server" ErrorMessage="Please select a valid date"
                Display="Dynamic" ControlToValidate="rdpFromModificationDate" Text="Please select a valid date"
                CssClass="rfvPCG" ValidationGroup="BtnGo">Please select a valid date</asp:RequiredFieldValidator>
        </td>
        <td style="width: 12.5%;" id="tdTodate" runat="server" visible="false">
            <asp:Label ID="lblToDate" runat="server" Text="To:" CssClass="FieldName"></asp:Label>
            <telerik:RadDatePicker ID="rdpToDate" CssClass="txtField" runat="server" AutoPostBack="false"
                Skin="Telerik" EnableEmbeddedSkins="false">
                <Calendar ID="Calendar2" runat="server" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False"
                    ViewSelectorText="x" Skin="Telerik" EnableEmbeddedSkins="false">
                </Calendar>
                <DateInput ID="DateInput2" runat="server" DisplayDateFormat="d/M/yyyy" DateFormat="d/M/yyyy">
                </DateInput>
            </telerik:RadDatePicker>
            <br />
            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Please select a valid date"
                Display="Dynamic" ControlToValidate="rdpToDate" Text="Please select a valid date"
                CssClass="rfvPCG" ValidationGroup="BtnGo">Please select a valid date</asp:RequiredFieldValidator>
            <asp:CompareValidator ID="CompareValidator14" runat="server" ControlToValidate="rdpToDate"
                ErrorMessage="<br/> To Date should be greater than From Date" Type="Date" Operator="GreaterThanEqual"
                ControlToCompare="rdpFromModificationDate" CssClass="cvPCG" ValidationGroup="btnViewOrder"
                Display="Dynamic">
            </asp:CompareValidator>
        </td>
        <td style="width: 21%;" id="tdCustomerAuditList" runat="server" visible="false">
            <asp:Label ID="lblFilterType" runat="server" Text="Select Type:" CssClass="FieldName"></asp:Label>
            <asp:DropDownList ID="ddlAuditType" runat="server" CssClass="cmbField">
                <asp:ListItem Text="Select" Value="select"></asp:ListItem>
                <asp:ListItem Text="Customer Profile" Value="CP"></asp:ListItem>
                <asp:ListItem Text="Customer Bank" Value="CB"></asp:ListItem>
                <asp:ListItem Text="Customer Demat" Value="CD"></asp:ListItem>
                <asp:ListItem Text="Customer Demat Association" Value="CDA"></asp:ListItem>
                <asp:ListItem Text="Customer Transaction" Value="CTA"></asp:ListItem>
            </asp:DropDownList>
            <br />
            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="Please select a Type Audit"
                Display="Dynamic" ControlToValidate="ddlAuditType" Text="Please select a Type Audit"
                CssClass="rfvPCG" ValidationGroup="BtnGo" InitialValue="select">Please select a Type Audit</asp:RequiredFieldValidator>
        </td>
        <td style="width: 1%;">
            <asp:Button ID="btnSubmit" runat="server" Text="Go" CssClass="PCGButton" OnClick="btnSubmit_Click"
                ValidationGroup="BtnGo" Visible="false"/>
        </td>
    </tr>
</table>
<table id="tblProfileHeading" runat="server" visible="false" style="width: 100%"
    cellpadding="2" cellspacing="5">
    <tr>
        <td class="tdSectionHeading">
            <div class="divSectionHeading" style="vertical-align: text-bottom;">
                <asp:Label ID="Label1" runat="server" Text="Profile Audit Details"></asp:Label>
            </div>
        </td>
    </tr>
</table>
<table id="tblProfileData" runat="server" visible="false" width="100%" cellpadding="2"
    cellspacing="5">
    <tr>
        <td>
            <div>
                <table>
                    <tr>
                        <td>
                            <asp:Panel ID="pnlCustomerProfile" runat="server" Width="90%" ScrollBars="Horizontal"
                                Visible="true">
                                <telerik:RadGrid ID="rdCustomerProfile" runat="server" AutoGenerateColumns="false"
                                    AllowPaging="true" AllowSorting="true" Skin="Telerik" EnableHeaderContextMenu="true"
                                    GridLines="Both" EnableEmbeddedSkins="false" ShowFooter="true" PagerStyle-AlwaysVisible="true"
                                    EnableViewState="true" ShowStatusBar="true" AllowFilteringByColumn="true" PageSize="5"
                                    OnNeedDataSource="rdCustomerProfile_OnNeedDataSource">
                                    <ExportSettings HideStructureColumns="true">
                                    </ExportSettings>
                                    <MasterTableView Width="130%" AllowMultiColumnSorting="True" AutoGenerateColumns="false">
                                        <Columns>
                                            <telerik:GridBoundColumn DataField="Status" SortExpression="Status" AutoPostBackOnFilter="true"
                                                CurrentFilterFunction="Contains" ShowFilterIcon="false" AllowFiltering="false"
                                                HeaderText=" Audit Status" UniqueName="Status" HeaderStyle-Width="10px">
                                                <ItemStyle Width="" HorizontalAlign="left" Wrap="false" VerticalAlign="Top" />
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn Visible="true" DataField="C_CustomerId" SortExpression="C_CustomerId"
                                                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                                HeaderText="System Id" UniqueName="C_CustomerId" HeaderStyle-Width="10px">
                                                <ItemStyle Width="" HorizontalAlign="left" Wrap="false" VerticalAlign="Top" />
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="C_FirstName" SortExpression="C_FirstName" AutoPostBackOnFilter="true"
                                                CurrentFilterFunction="Contains" ShowFilterIcon="false" AllowFiltering="false"
                                                HeaderText="First Name" UniqueName="C_FirstName" HeaderStyle-Width="20px">
                                                <ItemStyle Width="" HorizontalAlign="left" Wrap="false" VerticalAlign="Top" />
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="C_MiddleName" SortExpression="C_MiddleName" AutoPostBackOnFilter="true"
                                                CurrentFilterFunction="Contains" ShowFilterIcon="false" AllowFiltering="false"
                                                HeaderText="Middle Name" UniqueName="C_MiddleName" HeaderStyle-Width="20px">
                                                <ItemStyle Width="" HorizontalAlign="left" Wrap="false" VerticalAlign="Top" />
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="C_LastName" SortExpression="C_LastName" AutoPostBackOnFilter="true"
                                                CurrentFilterFunction="Contains" ShowFilterIcon="false" AllowFiltering="false"
                                                HeaderText="Last Name" UniqueName="C_LastName" HeaderStyle-Width="20px">
                                                <ItemStyle Width="" HorizontalAlign="left" Wrap="false" VerticalAlign="Top" />
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="C_PANNum" SortExpression="C_PANNum" AutoPostBackOnFilter="true"
                                                CurrentFilterFunction="Contains" ShowFilterIcon="false" AllowFiltering="false"
                                                HeaderText="PAN Number" UniqueName="C_PANNum" HeaderStyle-Width="20px">
                                                <ItemStyle Width="" HorizontalAlign="left" Wrap="false" VerticalAlign="Top" />
                                            </telerik:GridBoundColumn>
                                            <telerik:GridTemplateColumn DataField="C_Mobile1" SortExpression="C_Mobile1" AutoPostBackOnFilter="true"
                                                CurrentFilterFunction="Contains" ShowFilterIcon="false" AllowFiltering="false"
                                                HeaderText="Mobile No" UniqueName="C_Mobile1" HeaderStyle-Width="20px">
                                                <ItemStyle Width="" HorizontalAlign="left" Wrap="false" VerticalAlign="Top" />
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridBoundColumn DataField="C_ResPhoneNum" SortExpression="C_ResPhoneNum"
                                                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                                AllowFiltering="false" HeaderText="Phone No" UniqueName="C_ResPhoneNum" HeaderStyle-Width="10px">
                                                <ItemStyle Width="" HorizontalAlign="left" Wrap="false" VerticalAlign="Top" />
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="C_Email" SortExpression="C_Email" AutoPostBackOnFilter="true"
                                                CurrentFilterFunction="Contains" ShowFilterIcon="false" AllowFiltering="false"
                                                HeaderText="Email Id" UniqueName="C_Email" HeaderStyle-Width="20px">
                                                <ItemStyle Width="" HorizontalAlign="left" Wrap="false" VerticalAlign="Top" />
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="[Address]" SortExpression="[Address]" AutoPostBackOnFilter="true"
                                                CurrentFilterFunction="Contains" ShowFilterIcon="false" AllowFiltering="false"
                                                HeaderText="Address" UniqueName="[Address]" HeaderStyle-Width="20px">
                                                <ItemStyle Width="" HorizontalAlign="left" Wrap="false" VerticalAlign="Top" />
                                            </telerik:GridBoundColumn>
                                            <telerik:GridTemplateColumn DataField="C_Adr1PinCode" SortExpression="C_Adr1PinCode"
                                                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                                AllowFiltering="false" HeaderText="PinCode" UniqueName="C_Adr1PinCode" HeaderStyle-Width="20px">
                                                <ItemStyle Width="" HorizontalAlign="left" Wrap="false" VerticalAlign="Top" />
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn DataField="city" SortExpression="city" AutoPostBackOnFilter="true"
                                                CurrentFilterFunction="Contains" ShowFilterIcon="false" AllowFiltering="false"
                                                HeaderText="City" UniqueName="city" HeaderStyle-Width="20px">
                                                <ItemStyle Width="" HorizontalAlign="left" Wrap="false" VerticalAlign="Top" />
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridBoundColumn DataField="state" SortExpression="state" AutoPostBackOnFilter="true"
                                                CurrentFilterFunction="Contains" ShowFilterIcon="false" AllowFiltering="false"
                                                HeaderText="state" UniqueName="state" HeaderStyle-Width="20px">
                                                <ItemStyle Width="" HorizontalAlign="left" Wrap="true" VerticalAlign="Top" />
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="C_IsKYCAvailable" SortExpression="C_IsKYCAvailable"
                                                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                                AllowFiltering="false" HeaderText="IsKYCAvailable" UniqueName="C_IsKYCAvailable"
                                                HeaderStyle-Width="10px">
                                                <ItemStyle Width="" HorizontalAlign="left" Wrap="false" VerticalAlign="Top" />
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="C_DOB" DataFormatString="{0:dd/MM/yyyy HH:mm:ss}"
                                                AllowFiltering="true" HeaderText="DOB" UniqueName="C_DOB" SortExpression="C_DOB"
                                                ShowFilterIcon="false" CurrentFilterFunction="Contains" AutoPostBackOnFilter="true"
                                                HeaderStyle-Width="20px" FilterControlWidth="60px">
                                                <ItemStyle Width="" HorizontalAlign="left" Wrap="false" VerticalAlign="Top" />
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="ModiicationDateTime" DataFormatString="{0:dd/MM/yyyy HH:mm:ss}"
                                                AllowFiltering="true" HeaderText="Modiication Date Time" UniqueName="ModiicationDateTime"
                                                SortExpression="ModiicationDateTime" ShowFilterIcon="false" CurrentFilterFunction="Contains"
                                                AutoPostBackOnFilter="true" HeaderStyle-Width="20px" FilterControlWidth="60px">
                                                <ItemStyle Width="" HorizontalAlign="left" Wrap="false" VerticalAlign="Top" />
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="ModificationBy" SortExpression="ModificationBy"
                                                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                                AllowFiltering="false" HeaderText="Modified By" UniqueName="ModificationBy" HeaderStyle-Width="20px">
                                                <ItemStyle Width="" HorizontalAlign="left" Wrap="true" VerticalAlign="Top" />
                                            </telerik:GridBoundColumn>
                                        </Columns>
                                    </MasterTableView>
                                    <ClientSettings>
                                        <Resizing AllowColumnResize="true" />
                                        <Selecting AllowRowSelect="True" EnableDragToSelectRows="True" />
                                    </ClientSettings>
                                    <FilterMenu EnableEmbeddedSkins="false">
                                    </FilterMenu>
                                </telerik:RadGrid>
                            </asp:Panel>
                        </td>
                    </tr>
                </table>
            </div>
        </td>
    </tr>
</table>
<table id="tblCustomerBankHeading" runat="server" visible="false" style="width: 100%"
    cellpadding="2" cellspacing="5">
    <tr>
        <td class="tdSectionHeading" colspan="6">
            <div class="divSectionHeading" style="vertical-align: text-bottom">
                <asp:Label ID="lblBankDetails" runat="server" Text="Bank Audit Details"></asp:Label>
            </div>
        </td>
    </tr>
</table>
<table id="tblCustomerBank" runat="server" visible="false">
    <tr>
        <td>
            <asp:Panel ID="PnlCustomerBank" runat="server" Width="100%" ScrollBars="Horizontal"
                Visible="true">
                <telerik:RadGrid ID="rdCustomerBank" runat="server" AutoGenerateColumns="false" AllowPaging="true"
                    AllowSorting="true" Skin="Telerik" EnableHeaderContextMenu="true" GridLines="Both"
                    EnableEmbeddedSkins="false" ShowFooter="true" PagerStyle-AlwaysVisible="true"
                    EnableViewState="true" ShowStatusBar="true" AllowFilteringByColumn="true" PageSize="5"
                    OnNeedDataSource="rdCustomerBank_OnNeedDataSource">
                    <ExportSettings HideStructureColumns="true">
                    </ExportSettings>
                    <MasterTableView Width="120%" AllowMultiColumnSorting="True" AutoGenerateColumns="false">
                        <Columns>
                            <telerik:GridBoundColumn DataField="Status" SortExpression="Status" AutoPostBackOnFilter="true"
                                CurrentFilterFunction="Contains" ShowFilterIcon="false" AllowFiltering="false"
                                HeaderText=" Audit Status" UniqueName="Status" HeaderStyle-Width="15px">
                                <ItemStyle Width="" HorizontalAlign="left" Wrap="false" VerticalAlign="Top" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="C_CustomerId" SortExpression="C_CustomerId" UniqueName="C_CustomerId"
                                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                HeaderText="System Id" HeaderStyle-Width="15px">
                                <ItemStyle Width="" HorizontalAlign="left" Wrap="false" VerticalAlign="Top" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="CB_AccountNum" SortExpression="CB_AccountNum"
                                UniqueName="CB_AccountNum" AutoPostBackOnFilter="true" CurrentFilterFunction="Contains"
                                ShowFilterIcon="false" HeaderText="Account Number" HeaderStyle-Width="15px">
                                <ItemStyle Width="" HorizontalAlign="left" Wrap="false" VerticalAlign="Top" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="Bank_Name" SortExpression="Bank_Name" AutoPostBackOnFilter="true"
                                CurrentFilterFunction="Contains" ShowFilterIcon="false" AllowFiltering="false"
                                HeaderText="Bank Name" UniqueName="Bank_Name" HeaderStyle-Width="20px">
                                <ItemStyle Width="" HorizontalAlign="left" Wrap="false" VerticalAlign="Top" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="AccountType" SortExpression="AccountType" AutoPostBackOnFilter="true"
                                CurrentFilterFunction="Contains" ShowFilterIcon="false" AllowFiltering="false"
                                HeaderText="Pan Number" UniqueName="AccountType" HeaderStyle-Width="20px">
                                <ItemStyle Width="" HorizontalAlign="left" Wrap="false" VerticalAlign="Top" />
                            </telerik:GridBoundColumn>
                            <telerik:GridTemplateColumn DataField="XMOH_ModeOfHolding" SortExpression="XMOH_ModeOfHolding"
                                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                AllowFiltering="false" HeaderText="Mode of Holding" UniqueName="XMOH_ModeOfHolding"
                                HeaderStyle-Width="20px">
                                <ItemStyle Width="" HorizontalAlign="left" Wrap="false" VerticalAlign="Top" />
                            </telerik:GridTemplateColumn>
                            <telerik:GridBoundColumn DataField="CB_BranchName" SortExpression="CB_BranchName"
                                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                AllowFiltering="false" HeaderText="Branch Name" UniqueName="CB_BranchName" HeaderStyle-Width="10px">
                                <ItemStyle Width="" HorizontalAlign="left" Wrap="false" VerticalAlign="Top" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="CB_BankCity" SortExpression="CB_BankCity" AutoPostBackOnFilter="true"
                                CurrentFilterFunction="Contains" ShowFilterIcon="false" AllowFiltering="false"
                                HeaderText="Bank City" UniqueName="CB_BankCity" HeaderStyle-Width="20px">
                                <ItemStyle Width="" HorizontalAlign="left" Wrap="false" VerticalAlign="Top" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="Bank_Address" SortExpression="Bank_Address" AutoPostBackOnFilter="true"
                                CurrentFilterFunction="Contains" ShowFilterIcon="false" AllowFiltering="false"
                                HeaderText=" Bank Address" UniqueName="Bank_Address" HeaderStyle-Width="20px">
                                <ItemStyle Width="" HorizontalAlign="left" Wrap="true" VerticalAlign="Top" />
                            </telerik:GridBoundColumn>
                            <telerik:GridTemplateColumn DataField="CB_BranchAdrPinCode" SortExpression="CB_BranchAdrPinCode"
                                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                AllowFiltering="false" HeaderText="PinCode" UniqueName="CB_BranchAdrPinCode"
                                HeaderStyle-Width="20px">
                                <ItemStyle Width="" HorizontalAlign="left" Wrap="false" VerticalAlign="Top" />
                            </telerik:GridTemplateColumn>
                            <telerik:GridBoundColumn DataField="CB_IFSC" SortExpression="CB_IFSC" AutoPostBackOnFilter="true"
                                CurrentFilterFunction="Contains" ShowFilterIcon="false" AllowFiltering="false"
                                HeaderText="IFSC" UniqueName="CB_IFSC" HeaderStyle-Width="10px">
                                <ItemStyle Width="" HorizontalAlign="left" Wrap="false" VerticalAlign="Top" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="Status" SortExpression="Status" AutoPostBackOnFilter="true"
                                CurrentFilterFunction="Contains" ShowFilterIcon="false" AllowFiltering="false"
                                HeaderText=" Audit Status" UniqueName="Status" HeaderStyle-Width="15px">
                                <ItemStyle Width="" HorizontalAlign="left" Wrap="false" VerticalAlign="Top" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="CB_Balance" SortExpression="CB_Balance" UniqueName="CB_Balance"
                                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                HeaderText="Balance" HeaderStyle-Width="15px">
                                <ItemStyle Width="" HorizontalAlign="left" Wrap="false" VerticalAlign="Top" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="CB_MICR" SortExpression="CB_MICR" AutoPostBackOnFilter="true"
                                CurrentFilterFunction="Contains" ShowFilterIcon="false" AllowFiltering="false"
                                HeaderText="MICR" UniqueName="CB_MICR" HeaderStyle-Width="20px">
                                <ItemStyle Width="" HorizontalAlign="left" Wrap="false" VerticalAlign="Top" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="CB_IsHeldJointly" SortExpression="CB_IsHeldJointly"
                                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                AllowFiltering="false" HeaderText="IsHeldJointly" UniqueName="CB_IsHeldJointly"
                                HeaderStyle-Width="20px">
                                <ItemStyle Width="" HorizontalAlign="left" Wrap="false" VerticalAlign="Top" />
                            </telerik:GridBoundColumn>
                            <telerik:GridTemplateColumn DataField="CB_NEFT" SortExpression="CB_NEFT" AutoPostBackOnFilter="true"
                                CurrentFilterFunction="Contains" ShowFilterIcon="false" AllowFiltering="false"
                                HeaderText="NEFT" UniqueName="CB_NEFT" HeaderStyle-Width="20px">
                                <ItemStyle Width="" HorizontalAlign="left" Wrap="false" VerticalAlign="Top" />
                            </telerik:GridTemplateColumn>
                            <telerik:GridBoundColumn DataField="CB_RTGS" SortExpression="CB_RTGS" AutoPostBackOnFilter="true"
                                CurrentFilterFunction="Contains" ShowFilterIcon="false" AllowFiltering="false"
                                HeaderText="RTGS" UniqueName="CB_RTGS" HeaderStyle-Width="10px">
                                <ItemStyle Width="" HorizontalAlign="left" Wrap="false" VerticalAlign="Top" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="XBAT_BankAccountTye" SortExpression="XBAT_BankAccountTye"
                                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                AllowFiltering="false" HeaderText="Bank Account Type" UniqueName="XBAT_BankAccountTye"
                                HeaderStyle-Width="20px">
                                <ItemStyle Width="" HorizontalAlign="left" Wrap="false" VerticalAlign="Top" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="ModificationBy" SortExpression="ModificationBy"
                                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                AllowFiltering="false" HeaderText="Modified By" UniqueName="ModificationBy" HeaderStyle-Width="20px">
                                <ItemStyle Width="" HorizontalAlign="left" Wrap="true" VerticalAlign="Top" />
                            </telerik:GridBoundColumn>
                            <telerik:GridTemplateColumn DataField="ModiicationDateTime" SortExpression="ModiicationDateTime"
                                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                AllowFiltering="false" HeaderText="Modiication Date" UniqueName="ModiicationDateTime"
                                HeaderStyle-Width="20px">
                                <ItemStyle Width="" HorizontalAlign="left" Wrap="false" VerticalAlign="Top" />
                            </telerik:GridTemplateColumn>
                        </Columns>
                    </MasterTableView>
                    <ClientSettings>
                        <Resizing AllowColumnResize="true" />
                        <Selecting AllowRowSelect="True" EnableDragToSelectRows="True" />
                    </ClientSettings>
                    <FilterMenu EnableEmbeddedSkins="false">
                    </FilterMenu>
                </telerik:RadGrid>
            </asp:Panel>
        </td>
    </tr>
</table>
<table id="tblCustomerDematHeading" runat="server" visible="false" style="width: 100%"
    cellpadding="2" cellspacing="5">
    <tr>
        <td class="tdSectionHeading" colspan="6">
            <div class="divSectionHeading" style="vertical-align: text-bottom">
                <asp:Label ID="Label4" runat="server" Text="Demat Audit Details"></asp:Label>
            </div>
        </td>
    </tr>
</table>
<table id="tblCustomerDemat" runat="server" visible="false">
    <tr>
        <td>
            <asp:Panel ID="pnlCustomerDemat" runat="server" Width="100%" ScrollBars="Horizontal"
                Visible="true">
                <telerik:RadGrid ID="rdCustomerDemat" runat="server" AutoGenerateColumns="false"
                    AllowPaging="true" AllowSorting="true" Skin="Telerik" EnableHeaderContextMenu="true"
                    GridLines="Both" EnableEmbeddedSkins="false" ShowFooter="true" PagerStyle-AlwaysVisible="true"
                    EnableViewState="true" ShowStatusBar="true" AllowFilteringByColumn="true" PageSize="5"
                    OnNeedDataSource="rdCustomerDemat_OnNeedDataSource">
                    <ExportSettings HideStructureColumns="true">
                    </ExportSettings>
                    <MasterTableView Width="100%" AllowMultiColumnSorting="True" AutoGenerateColumns="false"
                        HeaderStyle-Width="120px">
                        <Columns>
                            <telerik:GridBoundColumn DataField="Status" SortExpression="Status" AutoPostBackOnFilter="true"
                                CurrentFilterFunction="Contains" ShowFilterIcon="false" AllowFiltering="false"
                                HeaderText=" Audit Status" UniqueName="Status" HeaderStyle-Width="15px">
                                <ItemStyle Width="" HorizontalAlign="left" Wrap="false" VerticalAlign="Top" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="CEDA_DPId" SortExpression="CEDA_DPId" UniqueName="CEDA_DPId"
                                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                HeaderText="DP Id" HeaderStyle-Width="15px">
                                <ItemStyle Width="" HorizontalAlign="left" Wrap="false" VerticalAlign="Top" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="CEDA_DPName" SortExpression="CEDA_DPName" UniqueName="CEDA_DPName"
                                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                HeaderText="DP Name" HeaderStyle-Width="15px">
                                <ItemStyle Width="" HorizontalAlign="left" Wrap="false" VerticalAlign="Top" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="CEDA_DepositoryName" SortExpression="CEDA_DepositoryName"
                                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                AllowFiltering="false" HeaderText="Depository Name" UniqueName="CEDA_DepositoryName"
                                HeaderStyle-Width="20px">
                                <ItemStyle Width="" HorizontalAlign="left" Wrap="false" VerticalAlign="Top" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="AccountType" SortExpression="AccountType" AutoPostBackOnFilter="true"
                                CurrentFilterFunction="Contains" ShowFilterIcon="false" AllowFiltering="false"
                                HeaderText="Pan Number" UniqueName="AccountType" HeaderStyle-Width="20px">
                                <ItemStyle Width="" HorizontalAlign="left" Wrap="false" VerticalAlign="Top" />
                            </telerik:GridBoundColumn>
                            <telerik:GridTemplateColumn DataField="CEDA_BeneficiaryAccountNum" SortExpression="CEDA_BeneficiaryAccountNum"
                                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                AllowFiltering="false" HeaderText="Beneficiary Account Number" UniqueName="CEDA_BeneficiaryAccountNum"
                                HeaderStyle-Width="20px">
                                <ItemStyle Width="" HorizontalAlign="left" Wrap="false" VerticalAlign="Top" />
                            </telerik:GridTemplateColumn>
                            <telerik:GridBoundColumn DataField="XMOH_ModeOfHolding" SortExpression="XMOH_ModeOfHolding"
                                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                AllowFiltering="false" HeaderText="Mode Of Holding" UniqueName="XMOH_ModeOfHolding"
                                HeaderStyle-Width="10px">
                                <ItemStyle Width="" HorizontalAlign="left" Wrap="false" VerticalAlign="Top" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="ModificationBy" SortExpression="ModificationBy"
                                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                AllowFiltering="false" HeaderText="Modified By" UniqueName="ModificationBy" HeaderStyle-Width="20px">
                                <ItemStyle Width="" HorizontalAlign="left" Wrap="false" VerticalAlign="Top" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="ModiicationDateTime" SortExpression="ModiicationDateTime"
                                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                AllowFiltering="false" HeaderText="ModiicationDateTime" UniqueName="ModificationBy"
                                HeaderStyle-Width="20px">
                                <ItemStyle Width="" HorizontalAlign="left" Wrap="false" VerticalAlign="Top" />
                            </telerik:GridBoundColumn>
                        </Columns>
                    </MasterTableView>
                    <ClientSettings>
                        <Resizing AllowColumnResize="true" />
                        <Selecting AllowRowSelect="True" EnableDragToSelectRows="True" />
                    </ClientSettings>
                    <FilterMenu EnableEmbeddedSkins="false">
                    </FilterMenu>
                </telerik:RadGrid>
            </asp:Panel>
        </td>
    </tr>
</table>
<table id="tblCustomerDematAssociatesHeading" runat="server" visible="false" style="width: 100%"
    cellpadding="2" cellspacing="5">
    <tr>
        <td class="tdSectionHeading" colspan="6">
            <div class="divSectionHeading" style="vertical-align: text-bottom">
                <asp:Label ID="Label3" runat="server" Text="Demat Association Audit Details"></asp:Label>
            </div>
        </td>
    </tr>
</table>
<table id="tblCustomerDematAssociates" runat="server" visible="false">
    <tr>
        <td>
            <asp:Panel ID="pnlCustomerDematAssociates" runat="server" Width="100%" ScrollBars="Horizontal"
                Visible="true">
                <telerik:RadGrid ID="rdCustomerDematAssociates" runat="server" AutoGenerateColumns="false"
                    AllowPaging="true" AllowSorting="true" Skin="Telerik" EnableHeaderContextMenu="true"
                    GridLines="Both" EnableEmbeddedSkins="false" ShowFooter="true" PagerStyle-AlwaysVisible="true"
                    EnableViewState="true" ShowStatusBar="true" AllowFilteringByColumn="true" PageSize="5"
                    OnNeedDataSource="rdCustomerDematAssociates_OnNeedDataSource">
                    <ExportSettings HideStructureColumns="true">
                    </ExportSettings>
                    <MasterTableView Width="110%" AllowMultiColumnSorting="True" AutoGenerateColumns="false">
                        <Columns>
                            <telerik:GridBoundColumn DataField="Status" SortExpression="Status" AutoPostBackOnFilter="true"
                                CurrentFilterFunction="Contains" ShowFilterIcon="false" AllowFiltering="false"
                                HeaderText=" Audit Status" UniqueName="Status" HeaderStyle-Width="15px">
                                <ItemStyle Width="" HorizontalAlign="left" Wrap="false" VerticalAlign="Top" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="C_CustomerId" SortExpression="C_CustomerId" UniqueName="C_CustomerId"
                                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                HeaderText="System Id " HeaderStyle-Width="15px">
                                <ItemStyle Width="" HorizontalAlign="left" Wrap="false" VerticalAlign="Top" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="CDAA_Name" SortExpression="CDAA_Name" UniqueName="CDAA_Name"
                                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                HeaderText="Name" HeaderStyle-Width="15px">
                                <ItemStyle Width="" HorizontalAlign="left" Wrap="false" VerticalAlign="Top" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="CDAA_PanNum" SortExpression="CDAA_PanNum" AutoPostBackOnFilter="true"
                                CurrentFilterFunction="Contains" ShowFilterIcon="false" AllowFiltering="false"
                                HeaderText="PAN Number" UniqueName="CDAA_PanNum" HeaderStyle-Width="20px">
                                <ItemStyle Width="" HorizontalAlign="left" Wrap="false" VerticalAlign="Top" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="CDAA_Sex" SortExpression="CDAA_Sex" AutoPostBackOnFilter="true"
                                CurrentFilterFunction="Contains" ShowFilterIcon="false" AllowFiltering="false"
                                HeaderText="Gender" UniqueName="CDAA_Sex" HeaderStyle-Width="20px">
                                <ItemStyle Width="" HorizontalAlign="left" Wrap="false" VerticalAlign="Top" />
                            </telerik:GridBoundColumn>
                            <telerik:GridTemplateColumn DataField="CDAA_IsKYC" SortExpression="CDAA_IsKYC" AutoPostBackOnFilter="true"
                                CurrentFilterFunction="Contains" ShowFilterIcon="false" AllowFiltering="false"
                                HeaderText="IsKYC" UniqueName="CDAA_IsKYC" HeaderStyle-Width="20px">
                                <ItemStyle Width="" HorizontalAlign="left" Wrap="false" VerticalAlign="Top" />
                            </telerik:GridTemplateColumn>
                            <telerik:GridBoundColumn DataField="XR_Relationship" SortExpression="XR_Relationship"
                                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                AllowFiltering="false" HeaderText="Relationship" UniqueName="XR_Relationship"
                                HeaderStyle-Width="10px">
                                <ItemStyle Width="" HorizontalAlign="left" Wrap="false" VerticalAlign="Top" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="CDAA_GaurdianName" SortExpression="CDAA_GaurdianName"
                                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                AllowFiltering="false" HeaderText="GaurdianName" UniqueName="CDAA_GaurdianName"
                                HeaderStyle-Width="20px">
                                <ItemStyle Width="" HorizontalAlign="left" Wrap="false" VerticalAlign="Top" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="ModificationBy" SortExpression="ModificationBy"
                                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                AllowFiltering="false" HeaderText="Modified By" UniqueName="ModificationBy" HeaderStyle-Width="20px">
                                <ItemStyle Width="" HorizontalAlign="left" Wrap="false" VerticalAlign="Top" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="ModiicationDateTime" SortExpression="ModiicationDateTime"
                                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                AllowFiltering="false" HeaderText="Modified By" UniqueName="ModiicationDateTime"
                                HeaderStyle-Width="20px">
                                <ItemStyle Width="" HorizontalAlign="left" Wrap="false" VerticalAlign="Top" />
                            </telerik:GridBoundColumn>
                        </Columns>
                    </MasterTableView>
                    <ClientSettings>
                        <Resizing AllowColumnResize="true" />
                        <Selecting AllowRowSelect="True" EnableDragToSelectRows="True" />
                    </ClientSettings>
                    <FilterMenu EnableEmbeddedSkins="false">
                    </FilterMenu>
                </telerik:RadGrid>
            </asp:Panel>
        </td>
    </tr>
</table>
<table id="tableCustomerTransaction" runat="server" visible="false" style="width: 100%"
    cellpadding="2" cellspacing="5">
    <tr>
        <td class="tdSectionHeading" colspan="6">
            <div class="divSectionHeading" style="vertical-align: text-bottom">
                <asp:Label ID="lblCustomerTransaction" runat="server" Text="Customer Transaction Audit"></asp:Label>
            </div>
        </td>
    </tr>
</table>
<table id="tableTransaction" runat="server" visible="false">
    <tr>
        <td>
            <asp:Panel ID="pnlTransaction" runat="server" Width="95%" ScrollBars="Horizontal"
                Visible="true">
                <telerik:RadGrid ID="rdTransaction" runat="server" AutoGenerateColumns="false" AllowPaging="true"
                    AllowSorting="true" Skin="Telerik" EnableHeaderContextMenu="true" GridLines="Both"
                    EnableEmbeddedSkins="false" ShowFooter="true" PagerStyle-AlwaysVisible="true"
                    EnableViewState="true" ShowStatusBar="true" AllowFilteringByColumn="true" PageSize="5"
                    OnNeedDataSource="rdTransaction_OnNeedDataSource">
                    <ExportSettings HideStructureColumns="true">
                    </ExportSettings>
                    <MasterTableView Width="110%" AllowMultiColumnSorting="True" AutoGenerateColumns="false">
                        <Columns>
                            <telerik:GridBoundColumn DataField="Status" SortExpression="Status" AutoPostBackOnFilter="true"
                                CurrentFilterFunction="Contains" ShowFilterIcon="false" AllowFiltering="false"
                                HeaderText=" Audit Status" UniqueName="Status" HeaderStyle-Width="15px">
                                <ItemStyle Width="" HorizontalAlign="left" Wrap="false" VerticalAlign="Top" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="PASP_SchemePlanCode" SortExpression="PASP_SchemePlanCode"
                                UniqueName="PASP_SchemePlanCode" AutoPostBackOnFilter="true" CurrentFilterFunction="Contains"
                                ShowFilterIcon="false" HeaderText="SchemePlan Code " HeaderStyle-Width="15px">
                                <ItemStyle Width="" HorizontalAlign="left" Wrap="false" VerticalAlign="Top" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="PASP_SchemePlanName" SortExpression="PASP_SchemePlanName"
                                UniqueName="PASP_SchemePlanName" AutoPostBackOnFilter="true" CurrentFilterFunction="Contains"
                                ShowFilterIcon="false" HeaderText="SchemePlan Name" HeaderStyle-Width="15px">
                                <ItemStyle Width="" HorizontalAlign="left" Wrap="false" VerticalAlign="Top" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="CMFA_AccountId" SortExpression="CMFA_AccountId"
                                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                AllowFiltering="false" HeaderText="Account Id" UniqueName="CMFA_AccountId" HeaderStyle-Width="20px">
                                <ItemStyle Width="" HorizontalAlign="left" Wrap="false" VerticalAlign="Top" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="CMFT_TransactionDate" SortExpression="CMFT_TransactionDate"
                                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                AllowFiltering="false" HeaderText="Transaction Date" UniqueName="CMFT_TransactionDate"
                                HeaderStyle-Width="20px">
                                <ItemStyle Width="" HorizontalAlign="left" Wrap="false" VerticalAlign="Top" />
                            </telerik:GridBoundColumn>
                            <telerik:GridTemplateColumn DataField="CMFT_BuySell" SortExpression="CMFT_BuySell"
                                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                AllowFiltering="false" HeaderText="BuySell" UniqueName="CMFT_BuySell" HeaderStyle-Width="20px">
                                <ItemStyle Width="" HorizontalAlign="left" Wrap="false" VerticalAlign="Top" />
                            </telerik:GridTemplateColumn>
                            <telerik:GridBoundColumn DataField="CMFT_Units" SortExpression="CMFT_Units" AutoPostBackOnFilter="true"
                                CurrentFilterFunction="Contains" ShowFilterIcon="false" AllowFiltering="false"
                                HeaderText="Units" UniqueName="CMFT_Units" HeaderStyle-Width="10px">
                                <ItemStyle Width="" HorizontalAlign="left" Wrap="false" VerticalAlign="Top" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="CMFT_Amount" SortExpression="CMFT_Amount" AutoPostBackOnFilter="true"
                                CurrentFilterFunction="Contains" ShowFilterIcon="false" AllowFiltering="false"
                                HeaderText="Amount" UniqueName="CMFT_Amount" HeaderStyle-Width="20px">
                                <ItemStyle Width="" HorizontalAlign="left" Wrap="false" VerticalAlign="Top" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="CMFT_UserTransactionNo" SortExpression="CMFT_UserTransactionNo"
                                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                AllowFiltering="false" HeaderText="UserTransactionNo" UniqueName="CMFT_UserTransactionNo"
                                HeaderStyle-Width="20px">
                                <ItemStyle Width="" HorizontalAlign="left" Wrap="false" VerticalAlign="Top" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="WTS_TransactionStatus" SortExpression="WTS_TransactionStatus"
                                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                AllowFiltering="false" HeaderText="TransactionStatus" UniqueName="WTS_TransactionStatus"
                                HeaderStyle-Width="20px">
                                <ItemStyle Width="" HorizontalAlign="left" Wrap="false" VerticalAlign="Top" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="ModificationBy" SortExpression="ModificationBy"
                                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                AllowFiltering="false" HeaderText="Modified By" UniqueName="ModificationBy" HeaderStyle-Width="20px">
                                <ItemStyle Width="" HorizontalAlign="left" Wrap="false" VerticalAlign="Top" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="ModiicationDateTime" SortExpression="ModiicationDateTime"
                                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                AllowFiltering="false" HeaderText="Modified By" UniqueName="ModiicationDateTime"
                                HeaderStyle-Width="20px">
                                <ItemStyle Width="" HorizontalAlign="left" Wrap="false" VerticalAlign="Top" />
                            </telerik:GridBoundColumn>
                        </Columns>
                    </MasterTableView>
                    <ClientSettings>
                        <Resizing AllowColumnResize="true" />
                        <Selecting AllowRowSelect="True" EnableDragToSelectRows="True" />
                    </ClientSettings>
                    <FilterMenu EnableEmbeddedSkins="false">
                    </FilterMenu>
                </telerik:RadGrid>
            </asp:Panel>
        </td>
    </tr>
</table>
<table id="tblSchemePlan" runat="server" visible="false" style="width: 100%"
    cellpadding="2" cellspacing="5">
    <tr>
        <td class="tdSectionHeading">
            <div class="divSectionHeading" style="vertical-align: text-bottom;">
                <asp:Label ID="Label2" runat="server" Text="SchemePlan Audit"></asp:Label>
            </div>
        </td>
    </tr>
</table>
<table id="taSchemeAudit" runat="server" visible="false">
    <tr>
        <td>
            <asp:Panel ID="pnlSchemeAudit" runat="server" Width="95%" ScrollBars="Horizontal"
                Visible="true">
                <telerik:RadGrid ID="rdSchemeAudit" runat="server" AutoGenerateColumns="false" AllowPaging="true"
                    AllowSorting="true" Skin="Telerik" EnableHeaderContextMenu="true" GridLines="Both"
                    EnableEmbeddedSkins="false" ShowFooter="true" PagerStyle-AlwaysVisible="true"
                    EnableViewState="true" ShowStatusBar="true" AllowFilteringByColumn="true" PageSize="5"
                    OnNeedDataSource="rdSchemeAudit_OnNeedDataSource">
                    <ExportSettings HideStructureColumns="true">
                    </ExportSettings>
                    <MasterTableView Width="110%" AllowMultiColumnSorting="True" AutoGenerateColumns="false">
                        <Columns>
                            <telerik:GridBoundColumn DataField="Status" SortExpression="Status" AutoPostBackOnFilter="true"
                                CurrentFilterFunction="Contains" ShowFilterIcon="false" AllowFiltering="false"
                                HeaderText=" Audit Status" UniqueName="Status" HeaderStyle-Width="15px">
                                <ItemStyle Width="" HorizontalAlign="left" Wrap="false" VerticalAlign="Top" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="PASP_SchemePlanCode" SortExpression="PASP_SchemePlanCode"
                                UniqueName="PASP_SchemePlanCode" AutoPostBackOnFilter="true" CurrentFilterFunction="Contains"
                                ShowFilterIcon="false" HeaderText="SchemePlan Code " HeaderStyle-Width="15px">
                                <ItemStyle Width="" HorizontalAlign="left" Wrap="false" VerticalAlign="Top" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="PASP_SchemePlanName" SortExpression="PASP_SchemePlanName"
                                UniqueName="PASP_SchemePlanName" AutoPostBackOnFilter="true" CurrentFilterFunction="Contains"
                                ShowFilterIcon="false" HeaderText="SchemePlan Name" HeaderStyle-Width="15px">
                                <ItemStyle Width="" HorizontalAlign="left" Wrap="false" VerticalAlign="Top" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="PA_AMCName" SortExpression="PA_AMCName"
                                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                AllowFiltering="false" HeaderText="AMC Name" UniqueName="PA_AMCName" HeaderStyle-Width="20px">
                                <ItemStyle Width="" HorizontalAlign="left" Wrap="false" VerticalAlign="Top" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="XES_SourceName" SortExpression="XES_SourceName"
                                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                AllowFiltering="false" HeaderText="RNT" UniqueName="XES_SourceName"
                                HeaderStyle-Width="20px">
                                <ItemStyle Width="" HorizontalAlign="left" Wrap="false" VerticalAlign="Top" />
                            </telerik:GridBoundColumn>
                            <telerik:GridTemplateColumn DataField="PASP_Status" SortExpression="PASP_Status"
                                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                AllowFiltering="false" HeaderText="Status" UniqueName="PASP_Status" HeaderStyle-Width="20px">
                                <ItemStyle Width="" HorizontalAlign="left" Wrap="false" VerticalAlign="Top" />
                            </telerik:GridTemplateColumn>
                            <telerik:GridBoundColumn DataField="ModificationBy" SortExpression="ModificationBy"
                                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                AllowFiltering="false" HeaderText="Modified By" UniqueName="ModificationBy" HeaderStyle-Width="20px">
                                <ItemStyle Width="" HorizontalAlign="left" Wrap="false" VerticalAlign="Top" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="ModiicationDateTime" SortExpression="ModiicationDateTime"
                                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" ShowFilterIcon="false"
                                AllowFiltering="false" HeaderText="Modified By" UniqueName="ModiicationDateTime"
                                HeaderStyle-Width="20px">
                                <ItemStyle Width="" HorizontalAlign="left" Wrap="false" VerticalAlign="Top" />
                            </telerik:GridBoundColumn>
                        </Columns>
                    </MasterTableView>
                    <ClientSettings>
                        <Resizing AllowColumnResize="true" />
                        <Selecting AllowRowSelect="True" EnableDragToSelectRows="True" />
                    </ClientSettings>
                    <FilterMenu EnableEmbeddedSkins="false">
                    </FilterMenu>
                </telerik:RadGrid>
            </asp:Panel>
        </td>
    </tr>
</table>

<asp:HiddenField ID="hdnCustomerId" runat="server" />
<asp:HiddenField ID="hdnIsSubscripted" runat="server" />
<asp:HiddenField ID="hdnschemePlanId" runat="server" />