﻿<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="AlertDashboard.ascx.cs"
    Inherits="WealthERP.Alerts.AlertDashboard" %>
<%@ Register Src="~/General/Pager.ascx" TagPrefix="Pager" TagName="Pager" %>

<div>
    <table style="width: 100%;" cssclass="TableBackground">
        <tr>
            <td colspan="2" class="rightField">
                <asp:Label ID="lblHeader" runat="server" CssClass="HeaderTextBig" Text="Alert Setup Screen"> </asp:Label>
                <hr />
            </td>
        </tr>
        <tr>
            <td class="leftField">
                <asp:Label ID="lblCurrentPage" class="Field" runat="server"></asp:Label>
                <asp:Label ID="lblTotalRows" class="Field" runat="server"></asp:Label>
            </td>
        </tr>
        <%--        <tr id="trChooseCustomer" runat="server">
            <td align="center">
                <asp:Label ID="lblChooseCust" runat="server" CssClass="HeaderTextSmall" Text="Choose a Customer">
                </asp:Label>
            </td>
            <td align="left">
                <asp:DropDownList ID="ddlRMCustList" runat="server" CssClass="cmbField" OnSelectedIndexChanged="ddlRMCustList_SelectedIndexChanged"
                    AutoPostBack="true">
                </asp:DropDownList>
            </td>
        </tr>--%>
        <%--<tr id="trAlertType" runat="server">
            <td align="center">
                <asp:Label ID="lblChooseAlert" runat="server" CssClass="HeaderTextSmall" Text="Choose an Alert Type">
                </asp:Label>
            </td>
            <td align="left">
                <asp:DropDownList ID="ddlAlertTypes" runat="server" CssClass="cmbField" OnSelectedIndexChanged="ddlAlertTypes_SelectedIndexChanged"
                    AutoPostBack="true">
                </asp:DropDownList>
            </td>
        </tr>--%>
    </table>
    <asp:Panel ID="pnlDashboardGrid" runat="server" Visible="false">
        <table style="width: 100%;" cssclass="TableBackground">
            <tr>
                <td>
                    <asp:GridView ID="gvSystemAlerts" runat="server" AutoGenerateColumns="False" CellPadding="4"
                        CssClass="GridViewStyle" DataKeyNames="EventID,EventType,EventCode" 
                        Font-Size="Small" HorizontalAlign="Center" 
                        ShowFooter="True" OnRowCommand="gvSystemAlerts_RowCommand" EnableViewState="true">
                        <%--OnRowDataBound="gvAlertDashboard_RowDataBound"--%>
                        <FooterStyle Font-Bold="True" ForeColor="White" HorizontalAlign="Center" />
                        <RowStyle Font-Size="Small" CssClass="RowStyle" HorizontalAlign="Center" />
                        <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" CssClass="SelectedRowStyle"
                            HorizontalAlign="Center" />
                        <PagerStyle ForeColor="White" HorizontalAlign="Center" />
                        <HeaderStyle Font-Bold="True" ForeColor="White" Font-Size="Small" HorizontalAlign="Center"
                            CssClass="HeaderStyle" />
                        <AlternatingRowStyle CssClass="AltRowStyle" />
                        <Columns>
                            <asp:TemplateField HeaderText="Select">
                                <ItemTemplate>
                                    <asp:CheckBox ID="chkId" runat="server" />
                                </ItemTemplate>
                            </asp:TemplateField>
                            <%--Subscription Status--%>
                            <%--<asp:TemplateField HeaderText="Subscribed">
                                <ItemTemplate>
                                    <asp:Image ID="imgSubscribed" runat="server" ImageUrl='<%# (Eval("Subscribed").ToString() == "false" ? "~/Images/cross.jpg" : "~/Images/check.jpg") %>' />
                                </ItemTemplate>
                            </asp:TemplateField>--%>
                            <%--Event Code--%>
                            <asp:BoundField DataField="Alert" HeaderText="Alert"  ItemStyle-HorizontalAlign="Left" />
                            <asp:BoundField DataField="Default" HeaderText="Default" />
                            <%--Event Type--%>
                            <%--<asp:BoundField DataField="Type" HeaderText="Type" SortExpression="Type" />--%>
                            <%--Reminder--%>
                            <%--<asp:BoundField DataField="Reminder" HeaderText="Reminder" SortExpression="Reminder" />--%>
                            <%--Manage--%>
                            <%--<asp:ButtonField Text="Setup" HeaderText="Manage" CommandName="subscribe" />--%>
                        </Columns>
                    </asp:GridView>
                </td>
            </tr>
            <tr>
                <td>
                </td>
            </tr>
            <tr>
                <td class="SubmitCell">
                    <asp:Button ID="btnSubmit" runat="server" Text="Apply Alert" CssClass="PCGLongButton"
                        onmouseover="javascript:ChangeButtonCss('hover', 'ctrl_AlertDashboard_btnSubmit', 'S');"
                        onmouseout="javascript:ChangeButtonCss('out', 'ctrl_AlertDashboard_btnSubmit', 'S');"
                        OnClick="btnSubmit_Click" />
                    <asp:Button ID="btnEdit" runat="server" Text="Edit Default" CssClass="PCGLongButton"
                        onmouseover="javascript:ChangeButtonCss('hover', 'ctrl_AlertDashboard_btnEdit', 'S');"
                        onmouseout="javascript:ChangeButtonCss('out', 'ctrl_AlertDashboard_btnEdit', 'S');"
                        OnClick="btnEdit_Click" />
                    <asp:Button ID="btnReset" runat="server" Text="Reset Alert" CssClass="PCGLongButton"
                        onmouseover="javascript:ChangeButtonCss('hover', 'ctrl_AlertDashboard_btnReset', 'S');"
                        onmouseout="javascript:ChangeButtonCss('out', 'ctrl_AlertDashboard_btnReset', 'S');"
                        OnClick="btnReset_Click" />
                </td>
            </tr>
            <tr>
            <td class="Message">
            <asp:Label ID="lblError" runat="server" CssClass="Error" Text="You have already subcribed for the following Alerts"> </asp:Label>
            </td>
            </tr>
            <tr>
            <td class="Message">
            <asp:Label ID="lblSolution" runat="server" CssClass="Error" Text="To Resubscribe please Reset and subscribe again"> </asp:Label>
            </td>
            </tr>
        </table>
        <table style="width: 100%" id="tblPager" runat="server" visible="false">
            <tr>
                <td>
                    <Pager:Pager ID="mypager" runat="server"></Pager:Pager>
                </td>
            </tr>
        </table>
        <asp:HiddenField ID="hdnSort" runat="server" Value="SchemeName ASC" />
        <asp:HiddenField ID="hdnRecordCount" runat="server" />
    </asp:Panel>
    <table id="tblReminderEdit" width="100%" runat="server">
        <tr>
            <td colspan="2">
                <asp:Label ID="lblReminderEdit" CssClass="HeaderTextSmall" Text="For Reminder Alert Setup"
                    runat="server"></asp:Label>
                <hr />
            </td>
        </tr>
        <tr>
            <td>
            </td>
            <td>
            </td>
        </tr>
        <tr>
            <td class="leftField" width="15%">
                <asp:Label ID="lblReminderDays" CssClass="FieldName" Text="Reminder:" runat="server"></asp:Label>
            </td>
            <td class="rightField">
                <asp:TextBox ID="txtReminderDays" CssClass="txtField" runat="server"></asp:TextBox>
                <asp:Label ID="lblDaysBefore" CssClass="Field" Text=" days before" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="leftField" width="15%">
                &nbsp;
            </td>
            <td class="rightField">
                <asp:Button ID="btnSubmitReminder" runat="server" Text="Submit" CssClass="PCGButton"
                    onmouseover="javascript:ChangeButtonCss('hover', 'ctrl_AlertDashboard_btnSubmit', 'S');"
                    onmouseout="javascript:ChangeButtonCss('out', 'ctrl_AlertDashboard_btnSubmit', 'S');"
                    OnClick="btnSubmitReminder_Click" />
            </td>
        </tr>
    </table>
    <table id="tblOccurrenceEdit" width="100%" runat="server">
        <tr>
            <td colspan="3">
                <asp:Label ID="lblOccurrenceEdit" CssClass="HeaderTextSmall" Text="For Occurrence Alert Setup"
                    runat="server"></asp:Label>
                <hr />
            </td>
        </tr>
        <tr>
            <td class="leftField">
                <asp:Label ID="lblCondition" CssClass="FieldName" Text="Preset Condition" runat="server"></asp:Label>
            </td>
            <td>
            </td>
            <td>
                <asp:Label ID="lblPreset" CssClass="FieldName" Text="Preset" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="leftField" width="15%">
                &nbsp;
            </td>
            <td>
            </td>
            <td class="rightField">
                &nbsp;
            </td>
        </tr>
        <tr>
            <td class="leftField" width="15%">
                <asp:DropDownList ID="ddlOccurrenceCondition" CssClass="cmbField" runat="server">
                    <asp:ListItem>&gt;</asp:ListItem>
                    <asp:ListItem>&lt;</asp:ListItem>
                    <asp:ListItem>&gt;=</asp:ListItem>
                    <asp:ListItem>&lt;=</asp:ListItem>
                </asp:DropDownList>
            </td>
            <td align="center">
                <asp:Label ID="lblBy" CssClass="Field" Text="By" runat="server"></asp:Label>
            </td>
            <td class="rightField">
                <asp:TextBox ID="txtOccurrencePreset" CssClass="txtField" runat="server"></asp:TextBox>
                <asp:Label ID="lblPercent" CssClass="Field" Text="%" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="leftField" width="15%">
                &nbsp;
            </td>
            <td align="center" width="15%">
                <asp:Button ID="btnSubmitOccurrence" runat="server" Text="Submit" CssClass="PCGButton"
                    onmouseover="javascript:ChangeButtonCss('hover', 'ctrl_AlertDashboard_btnSubmit', 'S');"
                    onmouseout="javascript:ChangeButtonCss('out', 'ctrl_AlertDashboard_btnSubmit', 'S');"
                    OnClick="btnSubmitOccurrence_Click" />
            </td>
            <td class="rightField">
                &nbsp;
            </td>
        </tr>
    </table>
</div>
