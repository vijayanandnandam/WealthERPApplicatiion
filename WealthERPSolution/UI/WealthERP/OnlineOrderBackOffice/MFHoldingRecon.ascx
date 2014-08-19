﻿<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="MFHoldingRecon.ascx.cs"
    Inherits="WealthERP.OnlineOrderBackOffice.MFHoldingRecon" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:ScriptManager ID="scrptMgr" runat="server">
</asp:ScriptManager>
<table width="100%">
    <tr>
        <td>
            <div class="divPageHeading">
                <table cellspacing="0" cellpadding="2" width="100%">
                    <tr>
                        <td align="left">
                            MF Holding Recon
                        </td>
                        <td align="right">
                            <%-- <asp:ImageButton ID="imgexportButton" ImageUrl="~/App_Themes/Maroon/Images/Export_Excel.png"
                                Visible="false" runat="server" AlternateText="Excel" ToolTip="Export To Excel"
                                OnClick="btnExportData_OnClick" OnClientClick="setFormat('excel')" Height="22px"
                                Width="25px"></asp:ImageButton>--%>
                        </td>
                    </tr>
                </table>
            </div>
        </td>
    </tr>
</table>
<table>
    <tr>
        <td align="right">
            <asp:Label ID="lblSelect" runat="server" CssClass="FieldName" Text="Select:"></asp:Label>
        </td>
        <td>
            <asp:DropDownList ID="ddlIssue" runat="server" CssClass="cmbField">
            </asp:DropDownList>
            <span id="Span26" class="spnRequiredField">*</span>
            <br />
            <asp:RequiredFieldValidator ID="rfvddlIssue" runat="server" ErrorMessage="Please Select Request"
                CssClass="rfvPCG" ControlToValidate="ddlIssue" ValidationGroup="btnbasicsubmit"
                Display="Dynamic" InitialValue="Select"></asp:RequiredFieldValidator>
        </td>
        <td>
            <asp:Button ID="btnGo" runat="server" CssClass="PCGButton" OnClick="btnGo_OnClick"
                ValidationGroup="btnbasicsubmit" Text="Go" />
        </td>
        <td align="right">
            <asp:Label ID="Label1" runat="server" CssClass="FieldName" Text="Select:"></asp:Label>
        </td>
        <td>
            <telerik:RadDatePicker ID="txtTo" CssClass="txtField" runat="server" Culture="English (United States)"
                Skin="Telerik" EnableEmbeddedSkins="false" ShowAnimation-Type="Fade" MinDate="1900-01-01">
                <Calendar ID="Calendar1" runat="server" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False"
                    ViewSelectorText="x" Skin="Telerik" EnableEmbeddedSkins="false">
                </Calendar>
                <DatePopupButton ImageUrl="" HoverImageUrl=""></DatePopupButton>
                <DateInput ID="DateInput1" runat="server" DisplayDateFormat="d/M/yyyy" DateFormat="d/M/yyyy">
                </DateInput>
            </telerik:RadDatePicker>
            <%--  <span id="Span1" class="spnRequiredField" visible="false">*</span>--%>
            <br />
            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Please Select A Date"
                CssClass="rfvPCG" ControlToValidate="txtTo" ValidationGroup="btnSynch" Display="Dynamic"></asp:RequiredFieldValidator>
        </td>
        <td>
            <asp:Button ID="btnSynch" runat="server" CssClass="PCGButton" OnClick="btnSync_OnClick"
                ValidationGroup="btnSynch" Text="Sync" />
        </td>
    </tr>
</table>
<asp:Panel ID="pnlMFHoldingRecons" runat="server" ScrollBars="Horizontal" Height="100%"
    Width="100%" Visible="false">
    <table width="100%">
        <tr>
            <td>
                <div id="MFHoldingRecons" runat="server" style="width: 100%; padding-left: 0px;"
                    visible="false">
                    <telerik:RadGrid ID="gvMFHoldinfRecon" runat="server" AllowAutomaticDeletes="false"
                        PageSize="20" EnableEmbeddedSkins="false" AllowFilteringByColumn="true" AutoGenerateColumns="true"
                        ShowStatusBar="false" ShowFooter="false" AllowPaging="true" AllowSorting="true"
                        GridLines="none" AllowAutomaticInserts="false" Skin="Telerik" EnableHeaderContextMenu="true"
                        Width="120%" Height="400px" OnNeedDataSource="gvMFHoldinfRecon_OnNeedDataSource">
                        <ExportSettings HideStructureColumns="true" ExportOnlyData="true" FileName="OrderMIS">
                        </ExportSettings>
                        <MasterTableView DataKeyNames="" Width="102%" AllowMultiColumnSorting="True" AutoGenerateColumns="false"
                            CommandItemDisplay="None" EditMode="PopUp">
                            <CommandItemSettings ShowExportToWordButton="false" ShowExportToExcelButton="false"
                                ShowExportToCsvButton="false" ShowAddNewRecordButton="false" ShowRefreshButton="false" />
                            <Columns>
                                <telerik:GridBoundColumn DataField="InvestorName" AllowFiltering="true" HeaderText="InvestorName"
                                    UniqueName="InvestorName" SortExpression="InvestorName" ShowFilterIcon="false"
                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" HeaderStyle-Width="120px"
                                    FilterControlWidth="60px">
                                    <ItemStyle Width="" HorizontalAlign="left" Wrap="false" VerticalAlign="Top" />
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="FolioNumber" AllowFiltering="true" HeaderText="FolioNumber"
                                    UniqueName="FolioNumber" SortExpression="FolioNumber" ShowFilterIcon="false"
                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" HeaderStyle-Width="120px"
                                    FilterControlWidth="60px">
                                    <ItemStyle Width="" HorizontalAlign="left" Wrap="false" VerticalAlign="Top" />
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="Address1" AllowFiltering="true" HeaderText="Address1"
                                    UniqueName="Address1" SortExpression="Address1" ShowFilterIcon="false" CurrentFilterFunction="Contains"
                                    AutoPostBackOnFilter="true" HeaderStyle-Width="120px" FilterControlWidth="60px">
                                    <ItemStyle Width="" HorizontalAlign="left" Wrap="false" VerticalAlign="Top" />
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="Address2" AllowFiltering="true" HeaderText="Address2"
                                    UniqueName="Address2" SortExpression="Address2" ShowFilterIcon="false" CurrentFilterFunction="Contains"
                                    AutoPostBackOnFilter="true" HeaderStyle-Width="120px" FilterControlWidth="60px">
                                    <ItemStyle Width="" HorizontalAlign="left" Wrap="false" VerticalAlign="Top" />
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="Address3" AllowFiltering="true" HeaderText="Address3"
                                    UniqueName="Address3" SortExpression="Address3" ShowFilterIcon="false" CurrentFilterFunction="Contains"
                                    AutoPostBackOnFilter="true" HeaderStyle-Width="120px" FilterControlWidth="60px">
                                    <ItemStyle Width="" HorizontalAlign="left" Wrap="false" VerticalAlign="Top" />
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="City" AllowFiltering="true" HeaderText="City"
                                    UniqueName="City" SortExpression="City" ShowFilterIcon="false" CurrentFilterFunction="Contains"
                                    AutoPostBackOnFilter="true" HeaderStyle-Width="120px" FilterControlWidth="60px">
                                    <ItemStyle Width="" HorizontalAlign="left" Wrap="false" VerticalAlign="Top" />
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="Pincode" AllowFiltering="true" HeaderText="Pincode"
                                    UniqueName="Pincode" SortExpression="Pincode" ShowFilterIcon="false" CurrentFilterFunction="Contains"
                                    AutoPostBackOnFilter="true" HeaderStyle-Width="120px" FilterControlWidth="60px">
                                    <ItemStyle Width="" HorizontalAlign="left" Wrap="false" VerticalAlign="Top" />
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="Email" AllowFiltering="true" HeaderText="Email"
                                    UniqueName="Email" SortExpression="Email" ShowFilterIcon="false" CurrentFilterFunction="Contains"
                                    AutoPostBackOnFilter="true" HeaderStyle-Width="120px" FilterControlWidth="60px">
                                    <ItemStyle Width="" HorizontalAlign="left" Wrap="false" VerticalAlign="Top" />
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="PhoneResidence" AllowFiltering="true" HeaderText="PhoneResidence"
                                    UniqueName="PhoneResidence" SortExpression="PhoneResidence" ShowFilterIcon="false"
                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" HeaderStyle-Width="120px"
                                    FilterControlWidth="60px">
                                    <ItemStyle Width="" HorizontalAlign="left" Wrap="false" VerticalAlign="Top" />
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="PhoneOffice" AllowFiltering="true" HeaderText="PhoneOffice"
                                    UniqueName="PhoneOffice" SortExpression="PhoneOffice" ShowFilterIcon="false"
                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" HeaderStyle-Width="120px"
                                    FilterControlWidth="60px">
                                    <ItemStyle Width="" HorizontalAlign="left" Wrap="false" VerticalAlign="Top" />
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="ProductCode" AllowFiltering="true" HeaderText="ProductCode"
                                    UniqueName="ProductCode" SortExpression="ProductCode" ShowFilterIcon="false"
                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" HeaderStyle-Width="120px"
                                    FilterControlWidth="60px">
                                    <ItemStyle Width="" HorizontalAlign="left" Wrap="false" VerticalAlign="Top" />
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="SchemeName" AllowFiltering="true" HeaderText="SchemeName"
                                    UniqueName="SchemeName" SortExpression="SchemeName" ShowFilterIcon="false" CurrentFilterFunction="Contains"
                                    AutoPostBackOnFilter="true" HeaderStyle-Width="120px" FilterControlWidth="60px">
                                    <ItemStyle Width="" HorizontalAlign="left" Wrap="false" VerticalAlign="Top" />
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="REPDate" AllowFiltering="true" HeaderText="REPDate"
                                    UniqueName="REPDate" SortExpression="REPDate" ShowFilterIcon="false" CurrentFilterFunction="Contains"
                                    AutoPostBackOnFilter="true" HeaderStyle-Width="120px" FilterControlWidth="60px">
                                    <ItemStyle Width="" HorizontalAlign="left" Wrap="false" VerticalAlign="Top" />
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="ReportTime" AllowFiltering="true" HeaderText="ReportTime"
                                    UniqueName="ReportTime" SortExpression="ReportTime" ShowFilterIcon="false" CurrentFilterFunction="Contains"
                                    AutoPostBackOnFilter="true" HeaderStyle-Width="120px" FilterControlWidth="60px">
                                    <ItemStyle Width="" HorizontalAlign="left" Wrap="false" VerticalAlign="Top" />
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="NAV" AllowFiltering="true" HeaderText="NAV" UniqueName="NAV"
                                    SortExpression="NAV" ShowFilterIcon="false" CurrentFilterFunction="Contains"
                                    AutoPostBackOnFilter="true" HeaderStyle-Width="120px" FilterControlWidth="60px">
                                    <ItemStyle Width="" HorizontalAlign="left" Wrap="false" VerticalAlign="Top" />
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="NAVDate" AllowFiltering="true" HeaderText="NAVDate"
                                    UniqueName="NAVDate" SortExpression="NAVDate" ShowFilterIcon="false" CurrentFilterFunction="Contains"
                                    AutoPostBackOnFilter="true" HeaderStyle-Width="120px" FilterControlWidth="60px">
                                    <ItemStyle Width="" HorizontalAlign="left" Wrap="false" VerticalAlign="Top" />
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="BrokerCode" AllowFiltering="true" HeaderText="BrokerCode"
                                    UniqueName="BrokerCode" SortExpression="BrokerCode" ShowFilterIcon="false" CurrentFilterFunction="Contains"
                                    AutoPostBackOnFilter="true" HeaderStyle-Width="120px" FilterControlWidth="60px">
                                    <ItemStyle Width="" HorizontalAlign="left" Wrap="false" VerticalAlign="Top" />
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="SubBrokerCode" AllowFiltering="true" HeaderText="SubBrokerCode"
                                    UniqueName="SubBrokerCode" SortExpression="SubBrokerCode" ShowFilterIcon="false"
                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" HeaderStyle-Width="120px"
                                    FilterControlWidth="60px">
                                    <ItemStyle Width="" HorizontalAlign="left" Wrap="false" VerticalAlign="Top" />
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="HoldingMode" AllowFiltering="true" HeaderText="HoldingMode"
                                    UniqueName="HoldingMode" SortExpression="HoldingMode" ShowFilterIcon="false"
                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" HeaderStyle-Width="120px"
                                    FilterControlWidth="60px">
                                    <ItemStyle Width="" HorizontalAlign="left" Wrap="false" VerticalAlign="Top" />
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="Pan" AllowFiltering="true" HeaderText="Pan" UniqueName="Pan"
                                    SortExpression="Pan" ShowFilterIcon="false" CurrentFilterFunction="Contains"
                                    AutoPostBackOnFilter="true" HeaderStyle-Width="120px" FilterControlWidth="60px">
                                    <ItemStyle Width="" HorizontalAlign="left" Wrap="false" VerticalAlign="Top" />
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="TransactionDate" AllowFiltering="true" HeaderText="TransactionDate"
                                    UniqueName="TransactionDate" SortExpression="TransactionDate" ShowFilterIcon="false"
                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" HeaderStyle-Width="120px"
                                    FilterControlWidth="60px">
                                    <ItemStyle Width="" HorizontalAlign="left" Wrap="false" VerticalAlign="Top" />
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="TransactionType" AllowFiltering="true" HeaderText="TransactionType"
                                    UniqueName="TransactionType" SortExpression="TransactionType" ShowFilterIcon="false"
                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" HeaderStyle-Width="120px"
                                    FilterControlWidth="60px">
                                    <ItemStyle Width="" HorizontalAlign="left" Wrap="false" VerticalAlign="Top" />
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="JointHolder1" AllowFiltering="true" HeaderText="JointHolder1"
                                    UniqueName="JointHolder1" SortExpression="JointHolder1" ShowFilterIcon="false"
                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" HeaderStyle-Width="120px"
                                    FilterControlWidth="60px">
                                    <ItemStyle Width="" HorizontalAlign="left" Wrap="false" VerticalAlign="Top" />
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="JointHolder2" AllowFiltering="true" HeaderText="JointHolder2"
                                    UniqueName="JointHolder2" SortExpression="JointHolder2" ShowFilterIcon="false"
                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" HeaderStyle-Width="120px"
                                    FilterControlWidth="60px">
                                    <ItemStyle Width="" HorizontalAlign="left" Wrap="false" VerticalAlign="Top" />
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="JointHolder1Pan" AllowFiltering="true" HeaderText="JointHolder1Pan"
                                    UniqueName="JointHolder1Pan" SortExpression="JointHolder1Pan" ShowFilterIcon="false"
                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" HeaderStyle-Width="120px"
                                    FilterControlWidth="60px">
                                    <ItemStyle Width="" HorizontalAlign="left" Wrap="false" VerticalAlign="Top" />
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="JointHolder2Pan" AllowFiltering="true" HeaderText="JointHolder2Pan"
                                    UniqueName="JointHolder2Pan" SortExpression="JointHolder2Pan" ShowFilterIcon="false"
                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" HeaderStyle-Width="120px"
                                    FilterControlWidth="60px">
                                    <ItemStyle Width="" HorizontalAlign="left" Wrap="false" VerticalAlign="Top" />
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="TAXStatus" AllowFiltering="true" HeaderText="TAXStatus"
                                    UniqueName="TAXStatus" SortExpression="TAXStatus" ShowFilterIcon="false" CurrentFilterFunction="Contains"
                                    AutoPostBackOnFilter="true" HeaderStyle-Width="120px" FilterControlWidth="60px">
                                    <ItemStyle Width="" HorizontalAlign="left" Wrap="false" VerticalAlign="Top" />
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="GuardianPan" AllowFiltering="true" HeaderText="GuardianPan"
                                    UniqueName="GuardianPan" SortExpression="GuardianPan" ShowFilterIcon="false"
                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" HeaderStyle-Width="120px"
                                    FilterControlWidth="60px">
                                    <ItemStyle Width="" HorizontalAlign="left" Wrap="false" VerticalAlign="Top" />
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="CMFHR_ReInvFlag" AllowFiltering="true" HeaderText="CMFHR_ReInvFlag"
                                    UniqueName="CMFHR_ReInvFlag" SortExpression="CMFHR_ReInvFlag" ShowFilterIcon="false"
                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" HeaderStyle-Width="120px"
                                    FilterControlWidth="60px">
                                    <ItemStyle Width="" HorizontalAlign="left" Wrap="false" VerticalAlign="Top" />
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="IIN" AllowFiltering="true" HeaderText="IIN" UniqueName="IIN"
                                    SortExpression="IIN" ShowFilterIcon="false" CurrentFilterFunction="Contains"
                                    AutoPostBackOnFilter="true" HeaderStyle-Width="120px" FilterControlWidth="60px">
                                    <ItemStyle Width="" HorizontalAlign="left" Wrap="false" VerticalAlign="Top" />
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="EUIN" AllowFiltering="true" HeaderText="EUIN"
                                    UniqueName="EUIN" SortExpression="EUIN" ShowFilterIcon="false" CurrentFilterFunction="Contains"
                                    AutoPostBackOnFilter="true" HeaderStyle-Width="120px" FilterControlWidth="60px">
                                    <ItemStyle Width="" HorizontalAlign="left" Wrap="false" VerticalAlign="Top" />
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="AltFolio" AllowFiltering="true" HeaderText="AltFolio"
                                    UniqueName="AltFolio" SortExpression="AltFolio" ShowFilterIcon="false" CurrentFilterFunction="Contains"
                                    AutoPostBackOnFilter="true" HeaderStyle-Width="120px" FilterControlWidth="60px">
                                    <ItemStyle Width="" HorizontalAlign="left" Wrap="false" VerticalAlign="Top" />
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="Pledged" AllowFiltering="true" HeaderText="Pledged"
                                    UniqueName="Pledged" SortExpression="Pledged" ShowFilterIcon="false" CurrentFilterFunction="Contains"
                                    AutoPostBackOnFilter="true" HeaderStyle-Width="120px" FilterControlWidth="60px">
                                    <ItemStyle Width="" HorizontalAlign="left" Wrap="false" VerticalAlign="Top" />
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="ClosingBalance" AllowFiltering="true" HeaderText="ClosingBalance"
                                    UniqueName="ClosingBalance" SortExpression="ClosingBalance" ShowFilterIcon="false"
                                    CurrentFilterFunction="Contains" DataFormatString="{0:F2}" AutoPostBackOnFilter="true"
                                    HeaderStyle-Width="120px" FilterControlWidth="60px">
                                    <ItemStyle Width="" HorizontalAlign="right" Wrap="false" VerticalAlign="Top" />
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="RupeeBalance" AllowFiltering="true" HeaderText="RupeeBalance"
                                    UniqueName="RupeeBalance" SortExpression="RupeeBalance" ShowFilterIcon="false"
                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" HeaderStyle-Width="120px"
                                    FilterControlWidth="60px">
                                    <ItemStyle Width="" HorizontalAlign="right" Wrap="false" VerticalAlign="Top" />
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="SchemePlanName" AllowFiltering="true" HeaderText="SchemePlanName"
                                    UniqueName="SchemePlanName" SortExpression="SchemePlanName" ShowFilterIcon="false"
                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" Visible="true" HeaderStyle-Width="120px"
                                    FilterControlWidth="60px">
                                    <ItemStyle Width="" HorizontalAlign="left" Wrap="false" VerticalAlign="Top" />
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="SystemUnits" AllowFiltering="true" HeaderText="SystemUnits"
                                    UniqueName="SystemUnits" SortExpression="SystemUnits" ShowFilterIcon="false"
                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" HeaderStyle-Width="120px"
                                    FilterControlWidth="60px" Visible="true">
                                    <ItemStyle Width="" HorizontalAlign="right" Wrap="false" VerticalAlign="Top" />
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="SystemNAV" AllowFiltering="true" HeaderText="SystemNAV"
                                    UniqueName="SystemNAV" SortExpression="CMFHR_SystemNAV" ShowFilterIcon="false"
                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" HeaderStyle-Width="120px"
                                    FilterControlWidth="60px" Visible="true">
                                    <ItemStyle Width="" HorizontalAlign="right" Wrap="false" VerticalAlign="Top" />
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="SystemNAVDate" AllowFiltering="true" HeaderText="SystemNAVDate"
                                    UniqueName="SystemNAVDate" SortExpression="CMFHR_SystemNAVDate" ShowFilterIcon="false"
                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" HeaderStyle-Width="120px"
                                    FilterControlWidth="60px" Visible="true">
                                    <ItemStyle Width="" HorizontalAlign="right" Wrap="false" VerticalAlign="Top" />
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="SystemAUM" AllowFiltering="true" HeaderText="SystemAUM"
                                    UniqueName="SystemAUM" SortExpression="CMFHR_SystemAUM" ShowFilterIcon="false"
                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" HeaderStyle-Width="120px"
                                    FilterControlWidth="60px" Visible="true">
                                    <ItemStyle Width="" HorizontalAlign="right" Wrap="false" VerticalAlign="Top" />
                                </telerik:GridBoundColumn>
                               <%-- <telerik:GridBoundColumn DataField="Diff" AllowFiltering="true" HeaderText="Difference"
                                    UniqueName="Diff" SortExpression="Difference" ShowFilterIcon="false"
                                    CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" HeaderStyle-Width="120px"
                                    FilterControlWidth="60px" Visible="true">
                                    <ItemStyle Width="" HorizontalAlign="right" Wrap="false" VerticalAlign="Top" />
                                </telerik:GridBoundColumn>--%>
                            </Columns>
                        </MasterTableView>
                    </telerik:RadGrid>
                </div>
            </td>
        </tr>
    </table>
</asp:Panel>