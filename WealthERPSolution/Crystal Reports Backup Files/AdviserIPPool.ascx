﻿<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="AdviserIPPool.ascx.cs" Inherits="WealthERP.Advisor.AdviserIPPool" %>  
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>


<script type="text/javascript">

    function ValidateIPTextBox() {
        alert('Please fill the IP address..!!');
    }

    function modalPopUpOKButton() {

        if (confirm("Do you want to proceed..??? ")) {
            document.getElementById("ctrl_AdviserIPPool_hdnGetIPbtn").click();
            __doPostBack('hdnGetIPbtn', 'click');
        }
    }
</script>

<script type="text/javascript">
    function showmessage() {
        
        __doPostBack('ctrl_AdviserIPPool_RadGrid1_ctl00_ctl02_ctl03_CancelButton', 'click');
    }

</script>

<script type="text/javascript">
    function showBtnGetIP() {

        document.getElementById("<%= btnGetIPsfromlog.ClientID %>").style.visibility = 'visible';

    }
</script>


<script type="text/javascript">
    function showmessage() {
        if (confirm("By removing all IP's you will loose IP login Security.!! \n\n Are You sure you want to remove ??")) {
            document.getElementById("ctrl_AdviserIPPool_hdnMsgValue").value = 2;
            document.getElementById("ctrl_AdviserIPPool_hiddenassociation").click();
            return true;
        }
        else {
            document.getElementById("ctrl_AdviserIPPool_hdnMsgValue").value = 0;           
            return false;
        }
    }
    function DeleteAdviserIPs() {
        if (confirm("Do you want to remove the IP?")) {
            document.getElementById("ctrl_AdviserIPPool_hdnMsgValue").value = 1;
            document.getElementById("ctrl_AdviserIPPool_hiddenReloadPage").click();
            return true;
        }
        else {
            document.getElementById("ctrl_AdviserIPPool_hdnMsgValue").value = 0;
            return false;
        }
    }
    function DeleteAdviserLastIP() {
        if (confirm("No More IP Security for your account..!! \n You have removed all the IPs..!")) {
            document.getElementById("ctrl_AdviserIPPool_hdnMsgValue").value = 1;
            document.getElementById("ctrl_AdviserIPPool_hiddenReloadPage").click();
            return true;
        }
        else {
            document.getElementById("ctrl_AdviserIPPool_hdnMsgValue").value = 0;
            return false;
        }
    }
</script>


<script type="text/javascript">

    function makeButtonGetIPVisible() {
        if (document.getElementById("<%=btnGetIPsfromlog.ClientID%>").style.visibility == 'hidden') {
            document.getElementById("<%=btnGetIPsfromlog.ClientID%>").style.visibility = 'visible';
            return true;
        }
    }    
</script>
<telerik:RadStyleSheetManager ID="RadStyleSheetManager1" runat="server" />
<telerik:RadScriptManager ID="RadScriptManager1" runat="server">
</telerik:RadScriptManager>
<telerik:RadFormDecorator ID="RadFormDecorator1" runat="server" DecoratedControls="All"
    Skin="Telerik" EnableEmbeddedSkins="false" />
<table width="100%">
    <tr>
        <td colspan="3">
            <div class="divPageHeading">
                <table cellspacing="0" cellpadding="3" width="100%">
                    <tr>
                        <td align="left">
                            IP Pool
                        </td>
                    </tr>
                </table>
            </div>
        </td>
    </tr>
    </table>
<table width="100%" cellspacing="0" cellpadding="0">
    <tr>
        <td align="center">
            <div id="msgRecordStatus" runat="server" class="success-msg" align="center" visible="false">
                Record created Successfully
            </div>
        </td>
    </tr>
</table>

<asp:UpdatePanel ID="updatePnl" runat="server">

<ContentTemplate>

      <telerik:RadAjaxLoadingPanel ID="IPAddressDetailsLoading" runat="server" Skin="Telerik"
        EnableEmbeddedSkins="false">
      </telerik:RadAjaxLoadingPanel>

      <asp:Panel ID="Panel2" runat="server" class="Landscape" Width="100%" ScrollBars="Horizontal">
      
      <table width="100%" runat="server" id="tblIPAddresses">
    <tr>
        <td>
            <div style="float: left; width: 100%;" id="Div2" runat="server">
                <%--<asp:Label ID="lblIP" runat="server" CssClass="HeaderText" Text="Already entered  IPs"></asp:Label>--%>
                <br />
                <telerik:RadAjaxPanel ID="AdviserIPPoolPanel" runat="server" Width="100%" HorizontalAlign="Center"
                    LoadingPanelID="IPAddressDetailsLoading" RenderMode="Block" EnablePageHeadUpdate="False">
                    <telerik:RadGrid ID="RadGrid1" runat="server" Width="96%" GridLines="None" AutoGenerateColumns="False"
                        PageSize="13" AllowSorting="True" AllowPaging="True" OnNeedDataSource="RadGrid1_NeedDataSource"
                        ShowStatusBar="True" OnInsertCommand="RadGrid1_InsertCommand" OnDeleteCommand="RadGrid1_DeleteCommand"
                        OnUpdateCommand="RadGrid1_UpdateCommand" OnItemDataBound="RadGrid1_ItemDataBound"
                        Skin="Telerik" EnableEmbeddedSkins="false">
                        <PagerStyle Mode="NextPrevAndNumeric" Position="Bottom" />
                        <MasterTableView AllowMultiColumnSorting="True" Width="100%"
                            CommandItemDisplay="Top" AutoGenerateColumns="false" EditMode="InPlace">
                            <CommandItemSettings ExportToPdfText="Export to Pdf" />
                            <Columns>
                                <telerik:GridEditCommandColumn UpdateText="Update" UniqueName="EditCommandColumn"
                                    CancelText="Cancel" ButtonType="ImageButton" CancelImageUrl="../Images/Telerik/Cancel.gif"
                                    InsertImageUrl="../Images/Telerik/Update.gif" UpdateImageUrl="../Images/Telerik/Update.gif"
                                    EditImageUrl="../Images/Telerik/Edit.gif">
                                    <HeaderStyle Width="100px"></HeaderStyle>
                                </telerik:GridEditCommandColumn>
                                
                                <telerik:GridTemplateColumn HeaderText="IPs" SortExpression="AIPP_IP" UniqueName="AIPP_IP"
                                    EditFormColumnIndex="1" HeaderStyle-HorizontalAlign="Center">
                                    <HeaderStyle Width="300px" />
                                    <ItemTemplate>
                                        <asp:Label runat="server" ID="lblIPName" Text='<%# Eval("AIPP_IP")%>'></asp:Label>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                       <asp:TextBox runat="server" ID="txtIPName" onclick="showBtnGetIP()" Width="200px" MaxLength="16" Text='<%# Bind("AIPP_IP")%>' ></asp:TextBox>
                                       
                                        <asp:RegularExpressionValidator ID="RExpForValidIP" Display="Dynamic" runat="server" Text="Invalid IP Addres"
                                          ValidationExpression="\b(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\b"
                                          ControlToValidate="txtIPName">
                                        </asp:RegularExpressionValidator>
                                       
                                        <%--<telerik:RadMaskedTextBox ID="txtIPName" Width="200px" Mask="<0..255>.<0..255>.<0..255>.<0..255>" Text='<%# Bind("AIPP_IP")%>' runat="server"></telerik:RadMaskedTextBox>--%>
                                        
                                      <%--  <telerik:RadMaskedTextBox ID="txtIPName" Text='<%# Bind("AIPP_IP")%>' TextMode="SingleLine" onclick="showBtnGetIP()" runat="server" 
                                         Width="200px" NumericRangeAlign="Left" Mask="###.###.###.###">
                                        </telerik:RadMaskedTextBox>--%>
                                        
                                    </EditItemTemplate>
                                </telerik:GridTemplateColumn>
                                
                                <telerik:GridTemplateColumn HeaderText="Comments" SortExpression="AIPP_Comments" UniqueName="AIPP_Comments"
                                    HeaderStyle-HorizontalAlign="Center" EditFormColumnIndex="1">
                                    <HeaderStyle Width="700px" />
                                    <ItemTemplate>
                                        <asp:Label runat="server" ID="lblIPComments" Text='<%# Eval("AIPP_Comments")%>'></asp:Label>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox runat="server" ID="txtIPComments" Width="700px" Wrap="true" Text='<%# Bind("AIPP_Comments")%>'></asp:TextBox>
                                    </EditItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridButtonColumn UniqueName="DeleteColumn" HeaderStyle-Width="50px" Text="Delete" Visible="true"  CommandName="Delete"
                                    ImageUrl="../Images/Telerik/Delete.gif" ButtonType="ImageButton" />
                            </Columns>
                            <EditFormSettings CaptionFormatString="Edit details for employee with ID {0}" CaptionDataField="FirstName">
                                <FormTableItemStyle Width="100%" Height="29px"></FormTableItemStyle>
                                <FormTableStyle GridLines="None" CellSpacing="0" CellPadding="2"></FormTableStyle>
                                <FormStyle Width="100%" BackColor="#eef2ea"></FormStyle>
                                <EditColumn ButtonType="ImageButton" />
                            </EditFormSettings>
                        </MasterTableView>
                        <ClientSettings>
                        </ClientSettings>
                    </telerik:RadGrid>

                </telerik:RadAjaxPanel>
            </div>
        </td>
    </tr>
</table>
     </asp:Panel>
</ContentTemplate>

</asp:UpdatePanel>


    <table width="100%">
    <tr>
        <td align="center" >
            <asp:Button ID="btnSubmit" runat="server" CssClass="PCGButton" Text="" 
                onclick="btnSubmit_Click" />
            &nbsp;
            <asp:Button ID="btnGetIPsfromlog" runat="server" style="visibility: hidden" CssClass="PCGLongButton" CausesValidation="false" 
                Text="Get IPs from log" onclick="btnGetIPsfromlog_Click" />
            
            <cc1:ModalPopupExtender ID="mdlPopupGetIPlog" runat="server" PopupControlID="IPLogPopUp"
            TargetControlID="hdnModalPopUpEvent" OkControlID="btnOk" Drag="true" CancelControlID="btnCancel" BackgroundCssClass="modalBackground" Enabled="true">
            </cc1:ModalPopupExtender>
        </td>
        <td>
            <asp:Panel ID="IPLogPopUp" Width="300px" style="visibility: hidden;" CssClass="ModelPup" class="Landscape" Height="250px" runat="server" >
                <table>
                    <tr>
                        <td>
                        <asp:Panel ID="panelChkBoxlist" Width="300px" ScrollBars="Vertical" class="Landscape" Height="200px" runat="server">
                        <table>
                            <asp:CheckBoxList ID="chklistIPPools" onclick="checkBox()" runat="server" RepeatDirection="Vertical" 
                            CssClass="cmbField" RepeatLayout="Flow" >
                                <asp:ListItem Text="" Value=""></asp:ListItem>
                            </asp:CheckBoxList>
                            </table>
                            </asp:Panel>
                        </td>
                    </tr>
                    </table>
                    <table>
                        <tr>
                            <td>
                                <asp:Button ID="btnOk" runat="server" Text="Create" OnClientClick="return modalPopUpOKButton()" OnClick="btnOk_Click" />
                                &nbsp;
                                <asp:Button ID="btnCancel" runat="server" Text="Cancel" />
                            </td>
                        </tr>
                    </table>
            </asp:Panel>
        </td>
    </tr>
</table>


<asp:HiddenField ID="hdnIsActive" runat="server" />
<asp:HiddenField ID="hdnIsProspect" runat="server" />
<asp:HiddenField ID="hdnMsgValue" runat="server" />
<asp:HiddenField ID="hdnassociationcount" runat="server" />

<asp:HiddenField ID="hdnModalPopUpEvent" runat="server" />    

<asp:HiddenField ID="hidValidCheck" runat="server" EnableViewState="true"/>   

<div style="visibility: hidden">
<asp:Button ID="hdnGetIPbtn" runat="server" BorderStyle="None" 
    BackColor="Transparent" BorderColor="Transparent" OnClick="hdnGetIPbtn_Click"   />

<asp:Button ID="hiddenReloadPage" runat="server" BorderStyle="None" 
    BackColor="Transparent" BorderColor="Transparent" 
    onclick="hiddenReloadPage_Click" style="background-color: Transparent; background: None; border: none; visibility: hidden;" />
    
<asp:Button ID="hiddenassociation" runat="server" OnClick="hiddenassociation_Click" style="background-color: Transparent; background: None; border: none; visibility: hidden;"   />
</div>