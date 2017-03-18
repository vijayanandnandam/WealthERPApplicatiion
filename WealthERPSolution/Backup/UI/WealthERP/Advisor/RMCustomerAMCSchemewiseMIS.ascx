﻿<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="RMCustomerAMCSchemewiseMIS.ascx.cs"
    Inherits="WealthERP.Advisor.RMCustomerAMCSchemewiseMIS" %>
<%@ Register Src="~/General/Pager.ascx" TagPrefix="Pager" TagName="Pager" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:ScriptManager ID="scptMgr" runat="server">
</asp:ScriptManager>

<script type="text/javascript" language="javascript">
    function CheckValuationDate() {
        var valuationDate = document.getElementById("<%=hdnValuationDate.ClientID %>").value;
        var txtDate = document.getElementById("<%=txtDate.ClientID %>").value;
        txtDate = new Date(txtDate);
        valuationDate = new Date(valuationDate);
        txtDate.setHours(0, 0, 0, 0);
        valuationDate.setHours(0, 0, 0, 0);


        if (txtDate <= valuationDate) {
            return true;
        }
        else {
            alert("Please Select Prior Business Date");
            return false;
        }

    }
</script>

<script type="text/javascript">

    function checkdate(sender, args) {

        //create a new date var and set it to the
        //value of the senders selected date
        var selectedDate = new Date();
        selectedDate = sender._selectedDate;
        //create a date var and set it's value to gvMFMIS
        var todayDate = new Date();
        var mssge = "";

        if (selectedDate > todayDate) {

            //set the senders selected date to today
            sender._selectedDate = todayDate;
            //set the textbox assigned to the cal-ex to today
            sender._textbox.set_Value(sender._selectedDate.format(sender._format));
            //alert the user what we just did and why
            alert("Warning! - Date Cannot be in the future. Date value is reset to the current date");
        }
    }

    function DownloadScript() {
        if (document.getElementById('<%= gvMFMIS.ClientID %>') == null) {
            alert("No records to export");
            return false;
        }
        btn = document.getElementById('<%= btnExportExcel.ClientID %>');
        btn.click();

    }

    function setPageType(pageType) {
        document.getElementById('<%= hdnDownloadPageType.ClientID %>').value = pageType;

    }
    function AferExportAll(btnID) {
        var btn = document.getElementById(btnID);
        btn.click();
    }

</script>

<table width="100%">
    <tr>
        <td colspan="3">
            <div class="divPageHeading">
                <table cellspacing="0" cellpadding="3" width="100%">
                    <tr>
                        <td align="left">
                            MF MIS
                        </td>
                        <td align="right" style="padding-bottom: 2px;">
                            <asp:ImageButton ID="imgBtnExport" ImageUrl="../Images/Export_Excel.png" Visible="false"
                                runat="server" AlternateText="Excel" ToolTip="Export To Excel" OnClick="imgBtnExport_Click" />
                        </td>
                    </tr>
                </table>
            </div>
        </td>
    </tr>
</table>
<%--    <table style="width: 100%; margin: 0px; padding: 0px;" cellpadding="1" cellspacing="1">
    <tr >
        <td class="HeaderTextBig" colspan="3">
            <asp:Label ID="lblMfMIS" runat="server" CssClass="HeaderTextBig" Text="MF MIS"></asp:Label>
            <hr />
        </td>
    </tr>
   
    </table>--%>
<table style="width: 100%;">
    <tr>
        <td align="right">
            <asp:Label ID="lblMISType" runat="server" CssClass="FieldName">MIS Type:</asp:Label>
        </td>
        <td>
            <asp:DropDownList ID="ddlMISType" runat="server" CssClass="cmbField" OnSelectedIndexChanged="ddlMISType_SelectedIndexChanged"
                AutoPostBack="true">
                <asp:ListItem Value="AMCWiseAUM">AMC Wise AUM</asp:ListItem>
                <asp:ListItem Value="AMCSchemeWiseAUM">Scheme Wise AUM</asp:ListItem>
                <asp:ListItem Value="FolioWiseAUM" Selected="True">Folio Wise AUM</asp:ListItem>
                <asp:ListItem Value="TurnOverSummary">Turn Over Summary</asp:ListItem>
            </asp:DropDownList>
        </td>
        <td align="right">
            <span id="spnBranch" runat="server">
                <asp:Label ID="lblBranch" runat="server" CssClass="FieldName" Text="Branch:"></asp:Label>
        </td>
        <td>
            <asp:DropDownList ID="ddlBranch" runat="server" CssClass="cmbField" OnSelectedIndexChanged="ddlBranch_SelectedIndexChanged"
                AutoPostBack="true">
                <%-- <asp:ListItem Value="1086" Text="All"></asp:ListItem>
                     <asp:ListItem Value="1145" Text="AJAY SINGH"></asp:ListItem>
                     <asp:ListItem Value="1058" Text="INVESTPRO FINANCIAL  SERV"></asp:ListItem>--%>
            </asp:DropDownList>
           </span>
        </td>
        <td align="right">
            <asp:Label ID="LstValDt" runat="server" CssClass="FieldName" Text="Last Valuation Date:"></asp:Label>
            <asp:Label ID="lblValDt" runat="server" CssClass="txtField"></asp:Label>
             
        </td>
    </tr>
    <tr id="trRange" runat="server">
        <td align="right" valign="top">
            <asp:Label ID="lblDate" runat="server" CssClass="FieldName">As on Date:</asp:Label>
        </td>
        <td valign="top">
            <telerik:RadDatePicker ID="txtDate" CssClass="txtTo" runat="server" Culture="English (United States)"
                Skin="Telerik" EnableEmbeddedSkins="false" ShowAnimation-Type="Fade" MinDate="1900-01-01">
                <Calendar ID="Calendar1" runat="server" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False"
                    ViewSelectorText="x" Skin="Telerik" EnableEmbeddedSkins="false">
                </Calendar>
                <DatePopupButton ImageUrl="" HoverImageUrl=""></DatePopupButton>
                <DateInput ID="DateInput1" runat="server" DisplayDateFormat="d/M/yyyy" DateFormat="d/M/yyyy">
                </DateInput>
            </telerik:RadDatePicker>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" ControlToValidate="txtDate"
                CssClass="rfvPCG" ErrorMessage="<br />Please select a Date" Display="Dynamic"
                runat="server" InitialValue="" ValidationGroup="btnGo">
            </asp:RequiredFieldValidator>
        </td>
        <td align="right" valign="top">
            <span id="spnRM" runat="server">
                <asp:Label ID="lblRM" runat="server" CssClass="FieldName" Text="RM:"></asp:Label>
        </td>
        <td valign="top">
            <asp:DropDownList ID="ddlRM" runat="server" CssClass="cmbField">
            </asp:DropDownList>
            </span>
        </td>
    </tr>
    <tr>
        <td>
        </td>
        <td>
            <asp:Button ID="btnGo" runat="server" Text="Go" ValidationGroup="btnGo" CssClass="PCGButton"
                onmouseover="javascript:ChangeButtonCss('hover', 'ctrl_RMCustomerAMCSchemewiseMIS_btnGo', 'S');"
                onmouseout="javascript:ChangeButtonCss('out', 'ctrl_RMCustomerAMCSchemewiseMIS_btnGo', 'S');"
                OnClick="btnGo_Click" OnClientClick="return CheckValuationDate();" />
        </td>
        <td>
        </td>
        <td>
        </td>
    </tr>
</table>
<table style="width: 100%; margin: 0px; padding: 0px;" cellpadding="0" cellspacing="0">
    <tr id="trModalPopup" runat="server">
        <td>
            <cc1:ModalPopupExtender ID="ModalPopupExtender1" runat="server" PopupControlID="Panel1"
                TargetControlID="imgBtnExport" DynamicServicePath="" BackgroundCssClass="modalBackground"
                Enabled="True" OkControlID="btnOK" CancelControlID="btnCancel" Drag="true" OnOkScript="DownloadScript();"
                PopupDragHandleControlID="Panel1" X="280" Y="35">
            </cc1:ModalPopupExtender>
        </td>
    </tr>
    <tr id="trExportPopup" runat="server">
        <td>
            <asp:Panel ID="Panel1" runat="server" CssClass="ExortPanelpopup">
                <br />
                <table width="100%">
                    <tr>
                        <td>
                            &nbsp;&nbsp;&nbsp;
                        </td>
                        <td align="right">
                            <input id="rbCurrent" runat="server" name="Radio" onclick="setPageType('single')"
                                type="radio" />
                        </td>
                        <td align="left">
                            <label for="rbCurrent" style="color: Black; font-family: Verdana; font-size: 8pt;
                                text-decoration: none">
                                Current Page</label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            &nbsp;&nbsp;&nbsp;
                        </td>
                        <td align="right">
                            <input id="rbAll" runat="server" name="Radio" onclick="setPageType('multiple')" type="radio" />
                        </td>
                        <td align="left">
                            <label for="rbAll" style="color: Black; font-family: Verdana; font-size: 8pt; text-decoration: none">
                                All Pages</label>
                        </td>
                    </tr>
                </table>
                <table width="100%">
                    <tr>
                        <td align="right">
                            <asp:Button ID="btnOk" runat="server" Text="OK" CssClass="PCGButton" />
                        </td>
                        <td align="left">
                            <asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="PCGButton" />
                        </td>
                    </tr>
                </table>
            </asp:Panel>
            <asp:Button class="ExportButton" ID="btnExportExcel" runat="server" Style="display: none"
                OnClick="btnExportExcel_Click" Height="31px" Width="30px" />
        </td>
    </tr>
    <tr id="trMessage" runat="server" visible="false">
        <td colspan="3">
            <asp:Label ID="lblMessage" runat="server" CssClass="Error" Text="No Records Found."></asp:Label>
        </td>
    </tr>
    <tr>
        <td colspan="3">
            <table style="width: 100%; border: none; margin: 0px; padding: 0px;" cellpadding="0"
                cellspacing="0">
                <tr>
                    <td>
                    </td>
                    <td>
                        &nbsp;
                    </td>
                    <td>
                        &nbsp;
                    </td>
                    <td>
                        &nbsp;
                    </td>
                    <td class="leftField" align="right">
                        <asp:Label ID="lblCurrentPage" class="Field" runat="server"></asp:Label>
                        <asp:Label ID="lblTotalRows" class="Field" runat="server"></asp:Label>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<asp:Panel ID="tbl" runat="server" class="Landscape" Width="100%" ScrollBars="Horizontal">
    <table width="100%" cellspacing="0" cellpadding="0">
        <tr>
            <td colspan="3">
                <asp:UpdatePanel ID="upnl" runat="server">
                    <ContentTemplate>
                        <asp:GridView ID="gvMFMIS" runat="server" AllowSorting="True" AutoGenerateColumns="False"
                            CellPadding="4" CssClass="GridViewStyle" ShowFooter="True" DataKeyNames="FolioNum"
                            OnSelectedIndexChanged="gvMFMIS_SelectedIndexChanged">
                            <%--OnSorting="gvMFMIS_Sorting" OnDataBound="gvMFMIS_DataBound"--%>
                            <RowStyle CssClass="RowStyle" />
                            <FooterStyle CssClass="FooterStyle" />
                            <PagerStyle HorizontalAlign="Center" CssClass="PagerStyle" />
                            <SelectedRowStyle CssClass="SelectedRowStyle" />
                            <HeaderStyle CssClass="HeaderStyle" />
                            <EditRowStyle CssClass="EditRowStyle" />
                            <AlternatingRowStyle CssClass="AltRowStyle" />
                            <Columns>
                                <asp:CommandField ShowSelectButton="True" SelectText="Details" />
                                <asp:TemplateField HeaderStyle-Wrap="false">
                                    <HeaderTemplate>
                                        <asp:Label ID="lblCustomerName" runat="server" Text="Customer"></asp:Label>
                                        <asp:TextBox ID="txtCustomerSearch" runat="server" CssClass="GridViewTxtField" onkeydown="return JSdoPostback(event,'ctrl_RMCustomerAMCSchemewiseMIS_btnSearch');" />
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <asp:Label ID="lblCustomerHeader" runat="server" Text='<%# Eval("CustomerName").ToString() %>'></asp:Label>
                                    </ItemTemplate>
                                    <HeaderStyle Wrap="False"></HeaderStyle>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderStyle-Wrap="false">
                                    <HeaderTemplate>
                                        <asp:Label ID="lblRmName" runat="server" Text="RM"></asp:Label>
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <asp:Label ID="lblRMHeader" runat="server" Text='<%# Eval("RmName").ToString() %>'></asp:Label>
                                    </ItemTemplate>
                                    <HeaderStyle Wrap="False"></HeaderStyle>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderStyle-Wrap="false">
                                    <HeaderTemplate>
                                        <asp:Label ID="lblBranchName" runat="server" Text="Branch"></asp:Label>
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <asp:Label ID="lblBranchHeader" runat="server" Text='<%# Eval("BranchName").ToString() %>'></asp:Label>
                                    </ItemTemplate>
                                    <HeaderStyle Wrap="False"></HeaderStyle>
                                </asp:TemplateField>
                                <%--<asp:BoundField DataField="CustomerName" HeaderText="Customer Name" 
                        ItemStyle-HorizontalAlign="Left" HeaderStyle-Wrap="false" />--%>
                                <asp:TemplateField HeaderStyle-Wrap="false">
                                    <HeaderTemplate>
                                        <asp:Label ID="lblFolioNum" runat="server" Text="Folio"></asp:Label>
                                        <asp:TextBox ID="txtFolioSearch" runat="server" CssClass="GridViewTxtField" onkeydown="return JSdoPostback(event,'ctrl_RMCustomerAMCSchemewiseMIS_btnSearch');" />
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <asp:Label ID="lblFolioHeader" runat="server" Text='<%# Eval("FolioNum").ToString() %>'></asp:Label>
                                    </ItemTemplate>
                                    <HeaderStyle Wrap="False"></HeaderStyle>
                                </asp:TemplateField>
                                <%--<asp:BoundField DataField="FolioNum" HeaderText="Folio Num" 
                        ItemStyle-HorizontalAlign="Left" HeaderStyle-Wrap="false" />--%>
                                <asp:TemplateField HeaderStyle-Wrap="false">
                                    <HeaderTemplate>
                                        <asp:Label ID="lblAMC" runat="server" Text="AMC"></asp:Label>
                                        <asp:TextBox ID="txtAMCSearch" runat="server" CssClass="GridViewTxtField" onkeydown="return JSdoPostback(event,'ctrl_RMCustomerAMCSchemewiseMIS_btnSearch');" />
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <asp:Label ID="lblAMCHeader" runat="server" Text='<%# Eval("AMC").ToString() %>'></asp:Label>
                                    </ItemTemplate>
                                    <HeaderStyle Wrap="False"></HeaderStyle>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderStyle-Wrap="false">
                                    <HeaderTemplate>
                                        <asp:Label ID="lblScheme" runat="server" Text="Scheme"></asp:Label>
                                        <asp:TextBox ID="txtSchemeSearch" runat="server" CssClass="GridViewTxtField" onkeydown="return JSdoPostback(event,'ctrl_RMCustomerAMCSchemewiseMIS_btnSearch');" />
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <asp:Label ID="lblSchemeHeader" runat="server" Text='<%# Eval("Scheme").ToString() %>'></asp:Label>
                                    </ItemTemplate>
                                    <HeaderStyle Wrap="False"></HeaderStyle>
                                </asp:TemplateField>
                                <%-- <asp:BoundField DataField="AMC" HeaderText="AMC" 
                        ItemStyle-HorizontalAlign="Left" HeaderStyle-Wrap="false" />
                    <asp:BoundField DataField="Scheme" HeaderText="Scheme" 
                        ItemStyle-HorizontalAlign="Left" HeaderStyle-Wrap="false" />--%>
                                <asp:BoundField DataField="Category" HeaderText="Category" ItemStyle-HorizontalAlign="Left"
                                    HeaderStyle-Wrap="false">
                                    <HeaderStyle Wrap="False"></HeaderStyle>
                                    <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                </asp:BoundField>
                                <asp:BoundField DataField="MarketPrice" HeaderText="Curr NAV" ItemStyle-HorizontalAlign="Right"
                                    HeaderStyle-Wrap="false">
                                    <HeaderStyle Wrap="False"></HeaderStyle>
                                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                </asp:BoundField>
                                <asp:BoundField DataField="Units" HeaderText="Units" ItemStyle-HorizontalAlign="Right"
                                    HeaderStyle-Wrap="false">
                                    <HeaderStyle Wrap="False"></HeaderStyle>
                                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                </asp:BoundField>
                                <asp:BoundField DataField="AUM" HeaderText="AUM" ItemStyle-HorizontalAlign="Right"
                                    HeaderStyle-Wrap="false">
                                    <HeaderStyle Wrap="False"></HeaderStyle>
                                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                </asp:BoundField>
                                <asp:BoundField DataField="Percentage" HeaderText="AUM %" ItemStyle-HorizontalAlign="Right"
                                    HeaderStyle-Wrap="false">
                                    <HeaderStyle Wrap="False"></HeaderStyle>
                                    <ItemStyle HorizontalAlign="Right"></ItemStyle>
                                </asp:BoundField>
                            </Columns>
                        </asp:GridView>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </td>
        </tr>
        <tr id="ValuationNotDoneErrorMsg" align="center" style="width: 100%" runat="server">
            <td align="center" style="width: 100%">
                <div class="failure-msg" style="text-align: center" align="center">
                    Valuation not done for this adviser....
                </div>
            </td>
        </tr>
    </table>
</asp:Panel>
<div style="margin: 6px">
    <label id="lbl" class="HeaderTextSmall">
        Note: Only historical data is accessible from this screen. Recent data for the last
        2 Business day will not be available. To view the recent data View Dashboards &
        Net Positions.</label>
</div>
<div id="DivPager" runat="server" style="display: none">
    <table style="width: 100%">
        <tr align="center">
            <td>
                <Pager:Pager ID="mypager" runat="server"></Pager:Pager>
            </td>
        </tr>
    </table>
</div>
<asp:Button ID="btnSearch" runat="server" Text="" BorderStyle="None" BackColor="Transparent"
    OnClick="btnSearch_Click" />
<asp:HiddenField ID="hdnRecordCount" runat="server" />
<asp:HiddenField ID="hdnCurrentPage" runat="server" />
<asp:HiddenField ID="hdnSort" runat="server" Value="ADUL_StartTime DESC" />
<asp:HiddenField ID="hdnAMCSearchVal" runat="server" Visible="false" />
<asp:HiddenField ID="hdnSchemeSearchVal" runat="server" Visible="false" />
<asp:HiddenField ID="hdnCustomerNameVal" runat="server" Visible="false" />
<asp:HiddenField ID="hdnFolioNumVal" runat="server" Visible="false" />
<asp:HiddenField ID="hdnDownloadPageType" runat="server" Visible="true" />
<asp:HiddenField ID="hdnValuationDate" runat="server" />
<asp:HiddenField ID="hdnrmId" runat="server" Visible="false" />
<asp:HiddenField ID="hdnbranchId" runat="server" Visible="false" />
<asp:HiddenField ID="hdnbranchHeadId" runat="server" Visible="false" />
<asp:HiddenField ID="hdnAll" runat="server" Visible="false" />
<asp:HiddenField ID="hdnXWise" runat="server" Visible="false" />