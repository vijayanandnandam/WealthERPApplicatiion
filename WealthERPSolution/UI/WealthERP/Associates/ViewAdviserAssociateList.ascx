﻿<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ViewAdviserAssociateList.ascx.cs"
    Inherits="WealthERP.Associates.ViewAdviserAssociateList" %>
<telerik:RadScriptManager ID="scptMgr" runat="server">
</telerik:RadScriptManager>
<table width="100%">
    <tr>
        <td colspan="3" style="width: 100%;">
            <div class="divPageHeading">
                <table cellspacing="0" width="100%">
                    <tr>
                        <td align="left">
                            View Associates List
                        </td>
                        <td align="right" id="tdExport" runat="server" style="padding-bottom: 2px;">
                            <asp:ImageButton ID="imgViewAssoList" ImageUrl="~/App_Themes/Maroon/Images/Export_Excel.png"
                                runat="server" AlternateText="Excel" ToolTip="Export To Excel" Height="20px"
                                Width="25px" Visible="false"></asp:ImageButton>
                        </td>
                    </tr>
                </table>
            </div>
        </td>
    </tr>
</table>
<table width="100%">
    <tr>
        <td colspan="4">
            <asp:Panel ID="pnlAdviserAssociateList" runat="server" Width="98%"
                Visible="true">
                <table>
                    <tr>
                        <td>
                            <div runat="server" id="divAdviserAssociateList" style="margin: 2px; width: 640px;">
                                <telerik:RadGrid ID="gvAdviserAssociateList" runat="server" GridLines="None" AutoGenerateColumns="False"
                                    PageSize="15" AllowSorting="true" AllowPaging="True" ShowStatusBar="True" ShowFooter="true"
                                    Skin="Telerik" EnableEmbeddedSkins="false" Width="120%" AllowFilteringByColumn="true"
                                    AllowAutomaticInserts="false" ExportSettings-ExportOnlyData="true" OnNeedDataSource="gvAdviserAssociateList_OnNeedDataSource"
                                    EnableHeaderContextMenu="true" EnableHeaderContextFilterMenu="true">
                                    <ExportSettings HideStructureColumns="true" ExportOnlyData="true" IgnorePaging="true"
                                        FileName="ViewAssociateList" Excel-Format="ExcelML">
                                    </ExportSettings>
                                    <MasterTableView Width="100%" DataKeyNames="AA_AdviserAssociateId"
                                        AllowMultiColumnSorting="True" AutoGenerateColumns="false" CommandItemDisplay="None"
                                        GroupsDefaultExpanded="false" ExpandCollapseColumn-Groupable="true" GroupLoadMode="Client"
                                        ShowGroupFooter="true">
                                        <Columns>
                                            <telerik:GridTemplateColumn ItemStyle-Width="80Px" AllowFiltering="false">
                                                <ItemTemplate>
                                                    <telerik:RadComboBox ID="ddlMenu" OnSelectedIndexChanged="ddlMenu_SelectedIndexChanged"
                                                        CssClass="cmbField" runat="server" EnableEmbeddedSkins="false" Skin="Telerik"
                                                        AllowCustomText="true" Width="120px" AutoPostBack="true">
                                                        <Items>
                                                            <telerik:RadComboBoxItem ImageUrl="~/Images/Select.png" Text="Select" Value="0" Selected="true">
                                                            </telerik:RadComboBoxItem>
                                                            <telerik:RadComboBoxItem Text="View" Value="View" ImageUrl="~/Images/DetailedView.png"
                                                                runat="server"></telerik:RadComboBoxItem>
                                                            <telerik:RadComboBoxItem ImageUrl="~/Images/RecordEdit.png" Text="Edit" Value="Edit"
                                                                runat="server"></telerik:RadComboBoxItem>
                                                       </Items>
                                                    </telerik:RadComboBox>
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridBoundColumn HeaderStyle-Width="150px" HeaderText="Name" DataField="AA_ContactPersonName"
                                                UniqueName="AA_ContactPersonName" SortExpression="AA_ContactPersonName" AutoPostBackOnFilter="true"
                                                AllowFiltering="true" ShowFilterIcon="false" CurrentFilterFunction="Contains">
                                                <ItemStyle Width="" HorizontalAlign="left" Wrap="false" VerticalAlign="Top" />
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn HeaderStyle-Width="150px" HeaderText="PAN DataField="AA_PAN"
                                                UniqueName="AA_PAN" SortExpression="AA_PAN" AutoPostBackOnFilter="true"
                                                AllowFiltering="false" ShowFilterIcon="false" CurrentFilterFunction="Contains">
                                                <ItemStyle Width="" HorizontalAlign="left" Wrap="false" VerticalAlign="Top" />
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn HeaderStyle-Width="150px" HeaderText="Branch" DataField="AB_BranchName"
                                                UniqueName="AB_BranchName" SortExpression="AB_BranchName" AutoPostBackOnFilter="true"
                                                AllowFiltering="false" ShowFilterIcon="false" CurrentFilterFunction="Contains">
                                                <ItemStyle Width="" HorizontalAlign="left" Wrap="false" VerticalAlign="Top" />
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn HeaderStyle-Width="150px" HeaderText="RM" DataField="RMName"
                                                UniqueName="RMName" SortExpression="RMName" AutoPostBackOnFilter="true"
                                                AllowFiltering="false" ShowFilterIcon="false" CurrentFilterFunction="Contains">
                                                <ItemStyle Width="" HorizontalAlign="left" Wrap="false" VerticalAlign="Top" />
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn HeaderStyle-Width="150px" HeaderText="Mobile" DataField="AA_Mobile"
                                                UniqueName="AA_Mobile" SortExpression="AA_Mobile" AutoPostBackOnFilter="true"
                                                AllowFiltering="false" ShowFilterIcon="false" CurrentFilterFunction="Contains">
                                                <ItemStyle Width="" HorizontalAlign="left" Wrap="false" VerticalAlign="Top" />
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn HeaderStyle-Width="150px" HeaderText="Email Id" DataField="AA_Email"
                                                UniqueName="AA_Email" SortExpression="AA_Email" AutoPostBackOnFilter="true"
                                                AllowFiltering="true" ShowFilterIcon="false" CurrentFilterFunction="Contains"
                                                Visible="false">
                                                <ItemStyle Width="" HorizontalAlign="left" Wrap="false" VerticalAlign="Top" />
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn HeaderStyle-Width="150px" HeaderText="Address" DataField="Address"
                                                UniqueName="Address" SortExpression="Address" AutoPostBackOnFilter="true"
                                                AllowFiltering="true" ShowFilterIcon="false" CurrentFilterFunction="Contains">
                                                <ItemStyle HorizontalAlign="left" Wrap="false" VerticalAlign="Top" />
                                            </telerik:GridBoundColumn>
                                        </Columns>
                                    </MasterTableView>
                                    <HeaderStyle Width="150px" />
                                    <ClientSettings>
                                        <Selecting AllowRowSelect="True" EnableDragToSelectRows="True" />
                                        <Resizing AllowColumnResize="true" />
                                    </ClientSettings>
                                </telerik:RadGrid>
                            </div>
                        </td>
                    </tr>
                </table>
            </asp:Panel>
        </td>
    </tr>
</table>
