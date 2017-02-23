﻿<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="EditLOB.ascx.cs" Inherits="WealthERP.Advisor.EditLOB" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:ScriptManager ID="scriptmanager1" runat="server">
</asp:ScriptManager>
<asp:UpdatePanel ID="up1" runat="server">
    <ContentTemplate>
        <table width="100%" class="TableBackground">
            <tr>
                <td class="HeaderCell">
                    <asp:Label ID="lblEdit" runat="server" CssClass="HeaderTextBig" Text="Edit LOB" Visible="false"></asp:Label>
                    
                </td>
            </tr>
        </table>
        <table width="100%" class="TableBackground">
            <tr>
                <td class="HeaderCell">
                    <asp:Label ID="lblView" runat="server" CssClass="HeaderTextBig" Text="View LOB" Visible="false"></asp:Label>
                    <hr />
                </td>
            </tr>
        </table>
        <table>
            <tr id="trMandatory" runat="server" visible="false">
                <td class="tdRequiredText" visible="false">
                    <label id="lbl" class="lblRequiredText" visible="false">
                        Note: Fields marked with ' * ' are compulsory</label>&nbsp;
                </td>
            </tr>
            <tr>
                <td>
                    <asp:LinkButton runat="server" ID="lnkBtnBack" CssClass="LinkButtons" Text="Back"
                        OnClick="lnkBtnBack_Click" CausesValidation="false"></asp:LinkButton>
                    &nbsp;&nbsp;
                    <asp:LinkButton ID="lnkEdit" runat="server" CssClass="LinkButtons" Text="Edit" OnClick="lnkEdit_Click" Visible="false"></asp:LinkButton>
                </td>
            </tr>
            <tr>
                <td>
                    &nbsp;
                </td>
            </tr>
        </table>
        <table style="width: 100%;" class="TableBackground">
            <tr id="divMFDetails" runat="server">
                <td>
                    <table class="TableBackground" style="width: 100%;">
                        <tr>
                            <td colspan="2" class="HeaderCell">
                                <asp:Label ID="Label16" runat="server" CssClass="HeaderTextBig" Text="Mutual Fund Intermediary"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td class="leftField">
                                <asp:Label ID="Label17" runat="server" CssClass="FieldName" Text="Intermediary Name:"></asp:Label>
                            </td>
                            <td class="rightField">
                                <asp:TextBox ID="txtMFOrgName" runat="server" CssClass="txtField"></asp:TextBox>
                                <span id="Span1" class="spnRequiredField">*</span>
                                <asp:RequiredFieldValidator ID="rfvName" ControlToValidate="txtMFOrgName" ErrorMessage="<br />Please Enter Intermediary Name"
                                    ValidationGroup="btnMF" Display="Dynamic" runat="server" CssClass="rfvPCG">
                                </asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td class="leftField">
                                <asp:Label ID="Label18" runat="server" CssClass="FieldName" Text="AMFI ARN Code:"></asp:Label>
                            </td>
                            <td class="rightField">
                                <asp:TextBox ID="txtMFARNCode" runat="server" CssClass="txtField" Enabled="false"></asp:TextBox>
                                <span id="Span2" class="spnRequiredField">*</span>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" ControlToValidate="txtMFARNCode"
                                    ValidationGroup="btnMF" ErrorMessage="<br />Please Enter the ARN Code" Display="Dynamic"
                                    runat="server" CssClass="rfvPCG">
                                </asp:RequiredFieldValidator>
                                &nbsp;&nbsp;&nbsp;
                                <asp:Button ID="btnAddARNVariations" class="leftField" runat="server" Text="Add Variations"
                                    CssClass="PCGMediumButton" OnClick="btnAddARNVariations_Click" />
                            </td>
                        </tr>
                        <tr id="trMFAddVariation" runat="server" visible="false">
                            <td>
                            </td>
                            <td class="rightField">
                                <asp:TextBox ID="txtMFARNVariation" runat="server" CssClass="txtField"></asp:TextBox>
                                <span id="Span78" class="spnRequiredField">*</span>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator73" ControlToValidate="txtMFARNVariation"
                                    ValidationGroup="btnMF" ErrorMessage="<br />Please Enter variation of ARN Code"
                                    Display="Dynamic" runat="server" CssClass="rfvPCG">
                                </asp:RequiredFieldValidator>
                                &nbsp;&nbsp;&nbsp;
                                <asp:Button ID="btnAddVariant" class="leftField" runat="server" Text="Add" CssClass="PCGButton"
                                    OnClick="btnAddVariant_Click" />
                            </td>
                        </tr>
                        <tr>
                            <td class="leftField">
                                <asp:Label ID="Label19" runat="server" CssClass="FieldName" Text="Expiry Date:"></asp:Label>
                            </td>
                            <td class="rightField">
                                <asp:TextBox ID="txtMFValidity" runat="server" CssClass="txtField"></asp:TextBox>
                                <cc1:CalendarExtender ID="txtMFValidity_CalendarExtender" runat="server" Enabled="True"
                                    TargetControlID="txtMFValidity" Format="dd/MM/yyyy">
                                </cc1:CalendarExtender>
                                <cc1:TextBoxWatermarkExtender ID="txtMFValidity_TextBoxWatermarkExtender" WatermarkText="dd/mm/yyyy"
                                    TargetControlID="txtMFValidity" runat="server">
                                </cc1:TextBoxWatermarkExtender>
                                <span id="Span23" class="spnRequiredField">*</span>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator22" ControlToValidate="txtMFValidity"
                                    ValidationGroup="btnMF" ErrorMessage="<br />Please Enter Expiry Date" Display="Dynamic"
                                    runat="server" CssClass="rfvPCG">
                                </asp:RequiredFieldValidator>
                                <asp:CompareValidator ID="cvMFExpiryDate" runat="server" ErrorMessage="<br/>Sorry, Expiry date should not be prior to current date !"
                                    Type="Date" ControlToValidate="txtMFValidity" CssClass="cvPCG" Operator="greaterthanequal"
                                    ValueToCompare="" Display="Dynamic" ValidationGroup="btnMF"></asp:CompareValidator>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                &nbsp;
                            </td>
                            <td>
                                <div id="showCalendar" runat="server">
                                    <table class="TableBackground">
                                        <tr>
                                            <td class="rightField">
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>
                            </td>
                            <td align="left">
                                <asp:Button ID="btnMFSubmit" runat="server" CssClass="PCGButton" onmouseover="javascript:ChangeButtonCss('hover', 'ctrl_LOB_btnMFSubmit');"
                                    onmouseout="javascript:ChangeButtonCss('out', 'ctrl_LOB_btnMFSubmit');" OnClick="btnMFSubmit_Click"
                                    ValidationGroup="btnMF" Text="Submit" />
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr id="BrokerCash" runat="server">
                <td>
                    <table class="TableBackground" style="width: 100%; height: 225px;">
                        <tr>
                            <td colspan="2" class="HeaderCell">
                                <asp:Label ID="Label20" runat="server" CssClass="HeaderTextBig" Text="Equity Broker Cash Details"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                &nbsp;
                            </td>
                        </tr>
                        <tr>
                            <td class="leftField">
                                <asp:Label ID="Label21" runat="server" CssClass="FieldName" Text="Broker Name:"></asp:Label>
                            </td>
                            <td class="rightField">
                                <asp:DropDownList ID="ddlEqBrCashBrokerName" runat="server" CssClass="cmbField">
                                </asp:DropDownList>
                                <span id="Span3" class="spnRequiredField">*</span>
                                <asp:CompareValidator ID="EqBrCashCompareValidator2" runat="server" ControlToValidate="ddlEqBrCashBrokerName"
                                    ErrorMessage="Please select a Broker Name" Operator="NotEqual" ValueToCompare="Select Broker Name"
                                    CssClass="cvPCG"></asp:CompareValidator>
                            </td>
                        </tr>
                        <tr>
                            <td class="leftField">
                                <asp:Label ID="Label22" runat="server" CssClass="FieldName" Text="Identifier Type:"></asp:Label>
                            </td>
                            <td class="rightField">
                                <asp:DropDownList ID="ddlBrokerCashId" runat="server" AutoPostBack="True" CssClass="cmbField"
                                    Enabled="false">
                                    <asp:ListItem>BSE</asp:ListItem>
                                    <asp:ListItem>NSE</asp:ListItem>
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr id="trBCBse" runat="server">
                            <td class="leftField">
                                <asp:Label ID="lblBrokerCashBseNumber" runat="server" CssClass="FieldName" Text="SEBI Regn No. BSE No.:"></asp:Label>
                            </td>
                            <td class="rightField">
                                <asp:TextBox ID="txtBrokerCashBseNumber" runat="server" CssClass="txtField"></asp:TextBox>
                                <span id="Span4" class="spnRequiredField">*</span>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" ControlToValidate="txtBrokerCashBseNumber"
                                    ValidationGroup="btnBC" ErrorMessage="<br />Please Enter BSE Number" Display="Dynamic"
                                    runat="server" CssClass="rfvPCG">
                                </asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr id="trBCNse" runat="server">
                            <td class="leftField">
                                <asp:Label ID="lblBrokerCashNseNumber" runat="server" CssClass="FieldName" Text="SEBI Regn No. NSE No.:"></asp:Label>
                            </td>
                            <td class="rightField">
                                <asp:TextBox ID="txtBrokerCashNseNumber" runat="server" CssClass="txtField"></asp:TextBox>
                                <span id="Span5" class="spnRequiredField">*</span>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator4" ControlToValidate="txtBrokerCashNseNumber"
                                    ValidationGroup="btnBC" ErrorMessage="<br />Please Enter NSE Number" Display="Dynamic"
                                    runat="server" CssClass="rfvPCG">
                                </asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" class="SubmitCell">
                                <asp:Button ID="btnBrokerCash" runat="server" OnClick="btnBrokerCash_Click" Text="Submit"
                                    ValidationGroup="btnBC" CssClass="PCGButton" onmouseover="javascript:ChangeButtonCss('hover', 'ctrl_LOB_btnBrokerCash');"
                                    onmouseout="javascript:ChangeButtonCss('out', 'ctrl_LOB_btnBrokerCash');" />
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr id="BrokerDerivative" runat="server">
                <td>
                    <table style="width: 100%;" class="TableBackground">
                        <tr>
                            <td colspan="2" class="HeaderCell">
                                <asp:Label ID="Label24" runat="server" CssClass="HeaderTextBig" Text="Equity Broker Derivative Details"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                &nbsp;
                            </td>
                        </tr>
                        <tr>
                            <td class="leftField">
                                <asp:Label ID="Label25" runat="server" CssClass="FieldName" Text="Broker Name:"></asp:Label>
                            </td>
                            <td class="rightField">
                                <asp:DropDownList ID="ddlEqBrDerBrokerName" runat="server" CssClass="cmbField">
                                </asp:DropDownList>
                                <span id="Span6" class="spnRequiredField">*</span>
                                <asp:CompareValidator ID="EqBrDerCompareValidator3" runat="server" ControlToValidate="ddlEqBrDerBrokerName"
                                    ErrorMessage="Please select a Broker Name" Operator="NotEqual" ValueToCompare="Select Broker Name"
                                    CssClass="cvPCG"></asp:CompareValidator>
                            </td>
                        </tr>
                        <tr>
                            <td class="leftField">
                                <asp:Label ID="Label26" runat="server" CssClass="FieldName" Text="Identifier Type:"></asp:Label>
                            </td>
                            <td class="rightField">
                                <asp:DropDownList ID="ddlBrokerDeivIdentifier" runat="server" CssClass="cmbField"
                                    AutoPostBack="True" Enabled="false">
                                    <asp:ListItem>BSE</asp:ListItem>
                                    <asp:ListItem>NSE</asp:ListItem>
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr id="trBDBse" runat="server">
                            <td class="leftField">
                                <asp:Label ID="lblBrokerDerivBseNumber" runat="server" CssClass="FieldName" Text="SEBI Regn No. BSE No.:"></asp:Label>
                            </td>
                            <td class="rightField">
                                <asp:TextBox ID="txtBrokerDerivBseNUmber" runat="server" CssClass="txtField"></asp:TextBox>
                                <span id="Span7" class="spnRequiredField">*</span>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator6" ControlToValidate="txtBrokerDerivBseNUmber"
                                    ValidationGroup="btnBD" ErrorMessage="<br />Please Enter BSE Number" Display="Dynamic"
                                    runat="server" CssClass="rfvPCG">
                                </asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr id="trBDNse" runat="server">
                            <td class="leftField">
                                <asp:Label ID="lblBrokerDerivNseNUmber" runat="server" CssClass="FieldName" Text="SEBI Regn No. NSE No.:"></asp:Label>
                            </td>
                            <td class="rightField">
                                <asp:TextBox ID="txtBrokerDerivNseNUmber" runat="server" CssClass="txtField"></asp:TextBox>
                                <span id="Span8" class="spnRequiredField">*</span>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator7" ControlToValidate="txtBrokerDerivNseNUmber"
                                    ValidationGroup="btnBD" ErrorMessage="<br />Please Enter NSE Number" Display="Dynamic"
                                    runat="server" CssClass="rfvPCG">
                                </asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td class="leftField">
                                <asp:Label ID="Label23" runat="server" CssClass="FieldName" Text="License Number:"></asp:Label>
                            </td>
                            <td class="rightField">
                                <asp:TextBox ID="txtBrokerDerivLicenseNumber" runat="server" CssClass="txtField"></asp:TextBox>
                                <span id="Span22" class="spnRequiredField">*</span>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator21" ControlToValidate="txtBrokerDerivLicenseNumber"
                                    ValidationGroup="btnBD" ErrorMessage="<br />Please Enter the License Number"
                                    Display="Dynamic" runat="server" CssClass="rfvPCG">
                                </asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" class="SubmitCell">
                                <asp:Button ID="btnBrokerDeriv" runat="server" Text="Submit" CssClass="PCGButton"
                                    ValidationGroup="btnBD" onmouseover="javascript:ChangeButtonCss('hover', 'ctrl_LOB_btnBrokerDeriv');"
                                    onmouseout="javascript:ChangeButtonCss('out', 'ctrl_LOB_btnBrokerDeriv');" OnClick="btnBrokerDeriv_Click" />
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr id="EquitySubBrokerCash" runat="server">
                <td>
                    <table style="width: 100%;" class="TableBackground">
                        <tr>
                            <td colspan="2" class="HeaderCell">
                                <asp:Label ID="Label28" runat="server" CssClass="HeaderTextBig" Text="Equity Sub Broker Cash Details"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                &nbsp;
                            </td>
                        </tr>
                        <%--<tr>
                        <td class="leftField">
                            <asp:Label ID="Label29" runat="server" CssClass="FieldName" Text="Organization Name:"></asp:Label>
                        </td>
                        <td class="rightField">
                            <asp:TextBox ID="txtSubCashOrgName" runat="server" CssClass="txtField"></asp:TextBox>
                            <span id="Span9" class="spnRequiredField">*</span>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator8" ControlToValidate="txtSubCashOrgName"
                                ValidationGroup="btnSC" ErrorMessage="<br />Please Enter Broker Name" Display="Dynamic"
                                runat="server" CssClass="rfvPCG">
                            </asp:RequiredFieldValidator>
                        </td>
                    </tr>--%>
                        <tr>
                            <td class="leftField">
                                <asp:Label ID="lblBrokerName" runat="server" CssClass="FieldName" Text="Broker Name :"></asp:Label>
                            </td>
                            <td class="rightField">
                                <asp:DropDownList ID="ddlBrokerCode" runat="server" CssClass="cmbField">
                                </asp:DropDownList>
                                <span id="Span9" class="spnRequiredField">*</span>
                                <asp:CompareValidator ID="EqSubBrCashCompareValidator1" runat="server" ControlToValidate="ddlBrokerCode"
                                    ErrorMessage="Please select a Broker Name" Operator="NotEqual" ValueToCompare="Select Broker Name"
                                    CssClass="cvPCG"></asp:CompareValidator>
                            </td>
                        </tr>
                        <tr>
                            <td class="leftField">
                                <asp:Label ID="Label30" runat="server" CssClass="FieldName" Text="Identifier Type:"></asp:Label>
                            </td>
                            <td class="rightField">
                                <asp:DropDownList ID="ddlSubCashIdentifier" runat="server" CssClass="cmbField" AutoPostBack="True"
                                    Enabled="false">
                                    <asp:ListItem>BSE</asp:ListItem>
                                    <asp:ListItem>NSE</asp:ListItem>
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr id="trSCBse" runat="server">
                            <td class="leftField">
                                <asp:Label ID="lblSubCashBseNumber" runat="server" CssClass="FieldName" Text="SEBI Regn No. BSE No.:"></asp:Label>
                            </td>
                            <td class="rightField">
                                <asp:TextBox ID="txtSubCashBseNumber" runat="server" CssClass="txtField"></asp:TextBox>
                                <span id="Span10" class="spnRequiredField">*</span>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator9" ControlToValidate="txtSubCashBseNumber"
                                    ValidationGroup="btnSC" ErrorMessage="<br />Please Enter BSE Number" Display="Dynamic"
                                    runat="server" CssClass="rfvPCG">
                                </asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr id="trSCNse" runat="server">
                            <td class="leftField">
                                <asp:Label ID="lblSubCashNseNumber" runat="server" CssClass="FieldName" Text="SEBI Regn No. NSE No.:"></asp:Label>
                            </td>
                            <td class="rightField">
                                <asp:TextBox ID="txtSubCashNseNumber" runat="server" CssClass="txtField"></asp:TextBox>
                                <span id="Span11" class="spnRequiredField">*</span>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator10" ControlToValidate="txtSubCashNseNumber"
                                    ValidationGroup="btnSC" ErrorMessage="<br />Please Enter NSE Number" Display="Dynamic"
                                    runat="server" CssClass="rfvPCG">
                                </asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td class="SubmitCell" colspan="2">
                                <asp:Button ID="btnSubCash" runat="server" CssClass="PCGButton" onmouseover="javascript:ChangeButtonCss('hover', 'ctrl_LOB_btnSubCash');"
                                    onmouseout="javascript:ChangeButtonCss('out', 'ctrl_LOB_btnSubCash');" Text="Submit"
                                    ValidationGroup="btnSC" OnClick="btnSubCash_Click" />
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr id="EquitySubBrokerDerivative" runat="server">
                <td>
                    <table style="width: 100%;" class="TableBackground">
                        <tr>
                            <td class="HeaderCell" colspan="2">
                                <asp:Label ID="Label35" runat="server" CssClass="HeaderTextBig" Text="Equity Sub Broker Derivative Details"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                &nbsp;
                            </td>
                        </tr>
                        <%--  <tr>
                        <td class="leftField">
                            <asp:Label ID="Label36" runat="server" CssClass="FieldName" Text="Broker Name:"></asp:Label>
                        </td>
                        <td class="rightField">
                            <asp:TextBox ID="txtSubDerivOrgName" runat="server" CssClass="txtField"></asp:TextBox>
                            <span id="Span12" class="spnRequiredField">*</span>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator11" ControlToValidate="txtSubDerivOrgName"
                                ValidationGroup="btnSD" ErrorMessage="<br />Please Enter Broker Name" Display="Dynamic"
                                runat="server" CssClass="rfvPCG">
                            </asp:RequiredFieldValidator>
                        </td>
                    </tr>--%>
                        <tr>
                            <td class="leftField">
                                <asp:Label ID="lblEQSubBroker" runat="server" CssClass="FieldName" Text="Broker Name:"></asp:Label>
                            </td>
                            <td class="rightField">
                                <asp:DropDownList ID="ddlSubBrokerCode" runat="server" CssClass="cmbField">
                                </asp:DropDownList>
                                <span id="Span12" class="spnRequiredField">*</span>
                                <asp:CompareValidator ID="EqSubBrDerCompareValidator2" runat="server" ControlToValidate="ddlSubBrokerCode"
                                    ErrorMessage="Please select Broker Name" Operator="NotEqual" ValueToCompare="Select Broker Name"
                                    CssClass="cvPCG"></asp:CompareValidator>
                            </td>
                        </tr>
                        <tr>
                            <td class="leftField">
                                <asp:Label ID="Label31" runat="server" CssClass="FieldName" Text="Identifier Type:"></asp:Label>
                            </td>
                            <td class="rightField">
                                <asp:DropDownList ID="ddlSubDerivIdentifier" runat="server" CssClass="cmbField" Enabled="false"
                                    AutoPostBack="True">
                                    <asp:ListItem>BSE</asp:ListItem>
                                    <asp:ListItem>NSE</asp:ListItem>
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr id="trSDBse" runat="server">
                            <td class="leftField">
                                <asp:Label ID="lblSubDerivBseNumber" runat="server" CssClass="FieldName" Text="SEBI Regn No. BSE No.:"></asp:Label>
                            </td>
                            <td class="rightField">
                                <asp:TextBox ID="txtSubDerivBseNumber" runat="server" CssClass="txtField"></asp:TextBox>
                                <span id="Span13" class="spnRequiredField">*</span>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator12" ControlToValidate="txtSubDerivBseNumber"
                                    ValidationGroup="btnSD" ErrorMessage="<br />Please Enter BSE Number" Display="Dynamic"
                                    runat="server" CssClass="rfvPCG">
                                </asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr id="trSDNse" runat="server">
                            <td class="leftField">
                                <asp:Label ID="lblSubDerivNseNumber" runat="server" CssClass="FieldName" Text="SEBI Regn No. NSE No.:"></asp:Label>
                            </td>
                            <td class="rightField">
                                <asp:TextBox ID="txtSubDerivNseNumber" runat="server" CssClass="txtField"></asp:TextBox>
                                <span id="Span14" class="spnRequiredField">*</span>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator13" ControlToValidate="txtSubDerivNseNumber"
                                    ValidationGroup="btnSD" ErrorMessage="<br />Please Enter NSE Number" Display="Dynamic"
                                    runat="server" CssClass="rfvPCG"> 
                                </asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td class="leftField">
                                <asp:Label ID="Label34" runat="server" CssClass="FieldName" Text="License Number:"></asp:Label>
                            </td>
                            <td class="rightField">
                                <asp:TextBox ID="txtSubDerivLicenseNumber" runat="server" CssClass="txtField"></asp:TextBox>
                                <span id="Span24" class="spnRequiredField">*</span>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator23" ControlToValidate="txtSubDerivLicenseNumber"
                                    ValidationGroup="btnSD" ErrorMessage="<br />Please Enter the License Number"
                                    Display="Dynamic" runat="server" CssClass="rfvPCG"> 
                                </asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" class="SubmitCell">
                                <asp:Button ID="btnSubDeriv" runat="server" CssClass="PCGButton" onmouseover="javascript:ChangeButtonCss('hover', 'ctrl_LOB_btnSubDeriv');"
                                    ValidationGroup="btnSD" onmouseout="javascript:ChangeButtonCss('out', 'ctrl_LOB_btnSubDeriv');"
                                    Text="Submit" OnClick="btnSubDeriv_Click" />
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr id="RemissaryCash" runat="server">
                <td>
                    <table style="width: 100%; height: 223px;" class="TableBackground">
                        <tr>
                            <td class="HeaderCell" colspan="2">
                                <asp:Label ID="Label38" runat="server" CssClass="HeaderTextBig" Text="Equity Remissary Cash Details"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                &nbsp;
                            </td>
                        </tr>
                        <tr>
                            <td class="leftField">
                                <asp:Label ID="Label39" runat="server" CssClass="FieldName" Text="Broker Name:"></asp:Label>
                            </td>
                            <td class="rightField">
                                <asp:DropDownList ID="ddlEqRemCashBrokerName" runat="server" CssClass="cmbField">
                                </asp:DropDownList>
                                <span id="Span15" class="spnRequiredField">*</span>
                                <asp:CompareValidator ID="EqRemCashCompareValidator3" runat="server" ControlToValidate="ddlEqRemCashBrokerName"
                                    ErrorMessage="Please select a Broker Name" Operator="NotEqual" ValueToCompare="Select Broker Name"
                                    CssClass="cvPCG"></asp:CompareValidator>
                            </td>
                        </tr>
                        <tr>
                            <td class="leftField">
                                <asp:Label ID="Label37" runat="server" CssClass="FieldName" Text="Identifier Type:"></asp:Label>
                            </td>
                            <td class="rightField">
                                <asp:DropDownList ID="ddlRemissCashIdentifier" runat="server" CssClass="cmbField"
                                    AppendDataBoundItems="True" Enabled="false" AutoPostBack="True">
                                    <asp:ListItem>BSE</asp:ListItem>
                                    <asp:ListItem>NSE</asp:ListItem>
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr id="trRCBse" runat="server">
                            <td class="leftField">
                                <asp:Label ID="lblRemissCashBseNUmber" runat="server" CssClass="FieldName" Text="SEBI Regn No. BSE No.:"></asp:Label>
                            </td>
                            <td class="rightField">
                                <asp:TextBox ID="txtRemissCashBseNumber" runat="server" CssClass="txtField"></asp:TextBox>
                                <span id="Span16" class="spnRequiredField">*</span>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator15" ControlToValidate="txtRemissCashBseNumber"
                                    ValidationGroup="btnRC" ErrorMessage="<br />Please Enter BSE Number" Display="Dynamic"
                                    runat="server" CssClass="rfvPCG">
                                </asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr id="trRCNse" runat="server">
                            <td class="leftField">
                                <asp:Label ID="lblRemissCashNseNumber" runat="server" CssClass="FieldName" Text="SEBI Regn No. NSE No.:"></asp:Label>
                            </td>
                            <td class="rightField">
                                <asp:TextBox ID="txtRemissCashNseNumber" runat="server" CssClass="txtField"></asp:TextBox>
                                <span id="Span17" class="spnRequiredField">*</span>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator16" ControlToValidate="txtRemissCashNseNumber"
                                    ValidationGroup="btnRC" ErrorMessage="<br />Please Enter NSE Number" Display="Dynamic"
                                    runat="server" CssClass="rfvPCG">
                                </asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" class="SubmitCell">
                                <asp:Button ID="btnRemissCash" runat="server" Text="Submit" CssClass="PCGButton"
                                    onmouseover="javascript:ChangeButtonCss('hover', 'ctrl_LOB_btnRemissCash');"
                                    ValidationGroup="btnRC" onmouseout="javascript:ChangeButtonCss('out', 'ctrl_LOB_btnRemissCash');"
                                    OnClick="btnRemissCash_Click" />
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr id="RemissaryDerivative" runat="server">
                <td>
                    <table style="width: 82%; height: 238px;" class="TableBackground">
                        <tr>
                            <td colspan="2" class="HeaderCell">
                                <asp:Label ID="Label40" runat="server" CssClass="HeaderTextBig" Text="Equity Remissary Derivative Details"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td>
                            </td>
                            <td>
                            </td>
                        </tr>
                        <tr>
                            <td class="leftField">
                                <asp:Label ID="Label41" runat="server" CssClass="FieldName" Text="Broker Name:"></asp:Label>
                            </td>
                            <td class="rightField">
                                <asp:DropDownList ID="ddlEqRemDerBrokerName" runat="server" CssClass="cmbField">
                                </asp:DropDownList>
                                <span id="Span18" class="spnRequiredField">*</span>
                                <asp:CompareValidator ID="EqRemDerCompareValidator4" runat="server" ControlToValidate="ddlEqRemDerBrokerName"
                                    ErrorMessage="Please select a Broker Name" Operator="NotEqual" ValueToCompare="Select Broker Name"
                                    CssClass="cvPCG"></asp:CompareValidator>
                            </td>
                        </tr>
                        <tr>
                            <td class="leftField">
                                <asp:Label ID="Label42" runat="server" CssClass="FieldName" Text="Identifier Type:"></asp:Label>
                            </td>
                            <td class="rightField">
                                <asp:DropDownList ID="ddlRemissDerivIdentifer" runat="server" CssClass="cmbField"
                                    AppendDataBoundItems="True" Enabled="false" AutoPostBack="True">
                                    <asp:ListItem>BSE</asp:ListItem>
                                    <asp:ListItem>NSE</asp:ListItem>
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr id="trRDBse" runat="server">
                            <td class="leftField">
                                <asp:Label ID="lblRemissDerivBseNumber" runat="server" CssClass="FieldName" Text="SEBI Regn No. BSE No.:"></asp:Label>
                            </td>
                            <td class="rightField">
                                <asp:TextBox ID="txtRemissDerivBseNumber" runat="server" CssClass="txtField"></asp:TextBox>
                                <span id="Span19" class="spnRequiredField">*</span>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator18" ControlToValidate="txtRemissDerivBseNumber"
                                    ValidationGroup="btnRD" ErrorMessage="<br />Please Enter BSE Number" Display="Dynamic"
                                    runat="server" CssClass="rfvPCG">
                                </asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr id="trRDNse" runat="server">
                            <td class="leftField">
                                <asp:Label ID="lblRemissDerivNseUNumber" runat="server" CssClass="FieldName" Text="SEBI Regn No. NSE No.:"></asp:Label>
                            </td>
                            <td class="rightField">
                                <asp:TextBox ID="txtRemissDerivNseNumber" runat="server" CssClass="txtField"></asp:TextBox>
                                <span id="Span20" class="spnRequiredField">*</span>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator19" ControlToValidate="txtRemissDerivNseNumber"
                                    ValidationGroup="btnRD" ErrorMessage="<br />Please Enter NSE Number" Display="Dynamic"
                                    runat="server" CssClass="rfvPCG">
                                </asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td class="leftField">
                                <asp:Label ID="Label45" runat="server" CssClass="FieldName" Text="License Number:"></asp:Label>
                            </td>
                            <td class="rightField">
                                <asp:TextBox ID="txtRemissDerivLicenseNumber" runat="server" CssClass="txtField"></asp:TextBox>
                                <span id="Span21" class="spnRequiredField">*</span>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator20" ControlToValidate="txtRemissDerivLicenseNumber"
                                    ValidationGroup="btnRD" ErrorMessage="<br />Please Enter the License Number"
                                    Display="Dynamic" runat="server" CssClass="rfvPCG">
                                </asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" class="SubmitCell">
                                <asp:Button ID="btnRemissDeriv" runat="server" CssClass="PCGButton" onmouseover="javascript:ChangeButtonCss('hover', 'ctrl_LOB_btnRemissDeriv');"
                                    onmouseout="javascript:ChangeButtonCss('out', 'ctrl_LOB_btnRemissDeriv');" Text="Submit"
                                    ValidationGroup="btnRD" OnClick="btnRemissDeriv_Click" Style="height: 26px" />
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr id="Insurance" runat="server">
                <td>
                    <table style="width: 82%; height: 238px;" class="TableBackground">
                        <tr>
                            <td colspan="2" class="HeaderCell">
                                <asp:Label ID="Label1" runat="server" CssClass="HeaderTextBig" Text="Insurance Agent Details"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td>
                            </td>
                            <td>
                            </td>
                        </tr>
                        <tr>
                            <td class="leftField">
                                <asp:Label ID="Label2" runat="server" CssClass="FieldName" Text="Organization Name:"></asp:Label>
                            </td>
                            <td class="rightField">
                                <asp:TextBox ID="txtInsOrgName" runat="server" CssClass="txtField"></asp:TextBox>
                                <span id="Span25" class="spnRequiredField">*</span>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator24" ControlToValidate="txtInsOrgName"
                                    ValidationGroup="btnRD" ErrorMessage="<br />Please Enter Organization Name" Display="Dynamic"
                                    runat="server" CssClass="rfvPCG">
                                </asp:RequiredFieldValidator>
                            </td>
                            <td class="rightField">
                                <asp:Label ID="Label7" runat="server" CssClass="FieldName" Text="IRDA no.:"></asp:Label>
                                <%--  </td>
                        <td class="rightField">--%>
                                <asp:TextBox ID="txtInsIRDANum" runat="server" CssClass="txtField"></asp:TextBox>
                                <%--<span id="Span30" class="spnRequiredField">*</span>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator29" ControlToValidate="txtInsIRDANum"
                                    ValidationGroup="btnRD" ErrorMessage="<br />Please Enter IRDA no." Display="Dynamic"
                                    runat="server" CssClass="rfvPCG">
                                </asp:RequiredFieldValidator>--%>
                            </td>
                        </tr>
                        <tr>
                            <td class="leftField">
                                <asp:Label ID="Label3" runat="server" CssClass="FieldName" Text="Agent No./Agency Code:"></asp:Label>
                            </td>
                            <td class="rightField">
                                <asp:TextBox ID="txtInsAgentNum" runat="server" CssClass="txtField"></asp:TextBox>
                                <%--<span id="Span26" class="spnRequiredField">*</span>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator25" ControlToValidate="txtInsAgentNum"
                                    ValidationGroup="btnRD" ErrorMessage="<br />Please Enter Agent No./Agency Code"
                                    Display="Dynamic" runat="server" CssClass="rfvPCG">
                                </asp:RequiredFieldValidator>--%>
                            </td>
                            <td class="rightField">
                                <asp:Label ID="Label4" runat="server" CssClass="FieldName" Text="Agency Expiry Date:"></asp:Label>
                                <%--    </td>
                        <td class="rightField">--%>
                                <asp:TextBox ID="txtInsAgencyExpiry" runat="server" CssClass="txtField"></asp:TextBox>
                                <cc1:CalendarExtender ID="txtInsAgencyExpiry_CalendarExtender" runat="server" TargetControlID="txtInsAgencyExpiry"
                                    Format="dd/MM/yyyy">
                                </cc1:CalendarExtender>
                                <cc1:TextBoxWatermarkExtender ID="txtInsAgencyExpiry_TextBoxWatermarkExtender" WatermarkText="dd/mm/yyyy"
                                    TargetControlID="txtInsAgencyExpiry" runat="server">
                                </cc1:TextBoxWatermarkExtender>
                                <%--<span id="Span27" class="spnRequiredField">*</span>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator26" ControlToValidate="txtInsAgencyExpiry"
                                    ValidationGroup="grpIns" ErrorMessage="<br />Please Enter Expiry Date" Display="Dynamic"
                                    runat="server" CssClass="rfvPCG">
                                </asp:RequiredFieldValidator>
                                <asp:CompareValidator ID="cvInsExpiryDate" runat="server" ErrorMessage="<br/>Sorry, Expiry date should not be prior to current date !"
                                    Type="Date" ControlToValidate="txtInsAgencyExpiry" CssClass="cvPCG" Operator="greaterthanequal"
                                    ValueToCompare="" Display="Dynamic" ValidationGroup="grpIns"></asp:CompareValidator>--%>
                            </td>
                        </tr>
                        <tr>
                            <td class="leftField">
                                <asp:Label ID="Label5" runat="server" CssClass="FieldName" Text="Minimum Business Criteria"></asp:Label>
                            </td>
                            <td class="leftField">
                                &nbsp;&nbsp;&nbsp;
                                <asp:Label ID="Label8" runat="server" CssClass="FieldName" Text="Target No. of policies:"></asp:Label>
                                <asp:TextBox ID="txtInsTargetPolicies" runat="server" CssClass="txtField" MaxLength="5"></asp:TextBox>
                                <asp:CompareValidator ID="cvtxtInsTargetPolicies" runat="server" ErrorMessage="<br/>Sorry, Please enter a numeric value !"
                                    Type="Double" ControlToValidate="txtInsTargetPolicies" CssClass="cvPCG" Operator="Equal"
                                    Display="Dynamic" ValidationGroup="grpIns"></asp:CompareValidator>
                            </td>
                            <td class="rightField">
                                <%--<span id="Span28" class="spnRequiredField">*</span>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator27" ControlToValidate="txtInsTargetPolicies"
                                ValidationGroup="btnRD" ErrorMessage="<br />Please Enter Agent No./Agency Code" Display="Dynamic"
                                runat="server" CssClass="rfvPCG">
                            </asp:RequiredFieldValidator>--%>
                            </td>
                        </tr>
                        <tr>
                            <td class="leftField">
                            </td>
                            <td class="leftField">
                                &nbsp;&nbsp;&nbsp;
                                <asp:Label ID="Label9" runat="server" CssClass="FieldName" Text="Target Sum Assured amount:"></asp:Label>
                                <asp:TextBox ID="txtInsTargetSumAssuredAmt" runat="server" CssClass="txtField" MaxLength="19"></asp:TextBox>
                                <asp:CompareValidator ID="cvtxtInsTargetSumAssuredAmt" runat="server" ErrorMessage="<br/>Sorry, Please enter a numeric value !"
                                    Type="Double" ControlToValidate="txtInsTargetSumAssuredAmt" CssClass="cvPCG" Operator="Equal"
                                    Display="Dynamic" ValidationGroup="grpIns"></asp:CompareValidator>
                            </td>
                            <td class="rightField">
                                <%--<span id="Span29" class="spnRequiredField">*</span>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator27" ControlToValidate="txtInsTargetSumAssuredAmt"
                                ValidationGroup="btnRD" ErrorMessage="<br />Please Enter Agent No./Agency Code" Display="Dynamic"
                                runat="server" CssClass="rfvPCG">
                            </asp:RequiredFieldValidator>--%>
                            </td>
                        </tr>
                        <tr>
                            <td class="leftField">
                            </td>
                            <td class="leftField">
                                &nbsp;&nbsp;&nbsp;
                                <asp:Label ID="Label6" runat="server" CssClass="FieldName" Text="Target Premium amount:"></asp:Label>
                                <asp:TextBox ID="txtInsTargetPremiumAmt" runat="server" CssClass="txtField" MaxLength="19"></asp:TextBox>
                                <asp:CompareValidator ID="cvtxtInsTargetPremiumAmt" runat="server" ErrorMessage="<br/>Sorry, Please enter a numeric value !"
                                    Type="Double" ControlToValidate="txtInsTargetPremiumAmt" CssClass="cvPCG" Operator="Equal"
                                    Display="Dynamic" ValidationGroup="grpIns"></asp:CompareValidator>
                            </td>
                            <td class="rightField">
                                <%-- <span id="Span31" class="spnRequiredField">*</span>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator27" ControlToValidate="txtInsTargetPremiumAmt"
                                ValidationGroup="btnRD" ErrorMessage="<br />Please Enter Agent No./Agency Code" Display="Dynamic"
                                runat="server" CssClass="rfvPCG">
                            </asp:RequiredFieldValidator>--%>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="3" class="SubmitCell">
                                <asp:Button ID="btnIns" runat="server" CssClass="PCGButton" onmouseover="javascript:ChangeButtonCss('hover', 'ctrl_LOB_btnRemissDeriv');"
                                    onmouseout="javascript:ChangeButtonCss('out', 'ctrl_LOB_btnRemissDeriv');" Text="Submit"
                                    ValidationGroup="grpIns" OnClick="btnIns_Click" Style="height: 26px" />
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr id="PostalSavings" runat="server">
                <td>
                    <table style="width: 82%; height: 238px;" class="TableBackground">
                        <tr>
                            <td colspan="2" class="HeaderCell">
                                <asp:Label ID="Label10" runat="server" CssClass="HeaderTextBig" Text="Postal Savings Agent Details"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td>
                            </td>
                            <td>
                            </td>
                        </tr>
                        <tr>
                            <td class="leftField">
                                <asp:Label ID="Label11" runat="server" CssClass="FieldName" Text="Organization Name:"></asp:Label>
                            </td>
                            <td class="rightField">
                                <asp:TextBox ID="txtPostalOrgName" runat="server" CssClass="txtField"></asp:TextBox>
                                <span id="Span28" class="spnRequiredField">*</span>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator27" ControlToValidate="txtPostalOrgName"
                                    ValidationGroup="btnRD" ErrorMessage="<br />Please Enter Organization Name" Display="Dynamic"
                                    runat="server" CssClass="rfvPCG">
                                </asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td class="leftField">
                                <asp:Label ID="Label13" runat="server" CssClass="FieldName" Text="Agent No./Agency Code:"></asp:Label>
                            </td>
                            <td class="rightField">
                                <asp:TextBox ID="txtPostalAgentNum" runat="server" CssClass="txtField"></asp:TextBox>
                                <%--<span id="Span31" class="spnRequiredField">*</span>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator30" ControlToValidate="txtPostalAgentNum"
                                    ValidationGroup="btnRD" ErrorMessage="<br />Please Enter Agent No./Agency Code"
                                    Display="Dynamic" runat="server" CssClass="rfvPCG">
                                </asp:RequiredFieldValidator>--%>
                            </td>
                            <td class="rightField">
                                <asp:Label ID="Label14" runat="server" CssClass="FieldName" Text="Agency Expiry Date:"></asp:Label>
                                <%--  </td>
                        <td class="rightField">--%>
                                <asp:TextBox ID="txtPostalAgencyExpiry" runat="server" CssClass="txtField"></asp:TextBox>
                                <cc1:CalendarExtender ID="txtPostalAgencyExpiry_CalendarExtender" runat="server"
                                    TargetControlID="txtPostalAgencyExpiry" Format="dd/MM/yyyy">
                                </cc1:CalendarExtender>
                                <cc1:TextBoxWatermarkExtender ID="txtPostalAgencyExpiry_TextBoxWatermarkExtender"
                                    WatermarkText="dd/mm/yyyy" TargetControlID="txtPostalAgencyExpiry" runat="server">
                                </cc1:TextBoxWatermarkExtender>
                                <%--<span id="Span32" class="spnRequiredField">*</span>
                                <asp:RequiredFieldValidator ID="txtPostalAgencyExpiry_RequiredFieldValidator" ControlToValidate="txtPostalAgencyExpiry"
                                    ValidationGroup="grpPostal" ErrorMessage="<br />Please Enter Expiry Date" Display="Dynamic"
                                    runat="server" CssClass="rfvPCG">
                                </asp:RequiredFieldValidator>
                                <asp:CompareValidator ID="cvPostExpiryDate" runat="server" ErrorMessage="<br/>Sorry, Expiry date should not be prior to current date !"
                                    Type="Date" ControlToValidate="txtPostalAgencyExpiry" CssClass="cvPCG" Operator="greaterthanequal"
                                    ValueToCompare="" Display="Dynamic" ValidationGroup="grpPostal"></asp:CompareValidator>--%>
                            </td>
                        </tr>
                        <tr>
                            <td class="leftField">
                                <asp:Label ID="Label15" runat="server" CssClass="FieldName" Text="Minimum Business Criteria"></asp:Label>
                            </td>
                            <td style="vertical-align: middle;">
                                &nbsp;&nbsp;&nbsp;
                                <asp:Label ID="Label27" runat="server" CssClass="FieldName" Text="Target Amount:"></asp:Label>
                                <asp:TextBox ID="txtPostalTargetAmt" runat="server" CssClass="txtField" MaxLength="19"></asp:TextBox>
                                 <asp:CompareValidator ID="cvtxtPostalTargetAmt" runat="server" ErrorMessage="<br/>Sorry, Please enter a numeric value !"
                                    Type="Double" ControlToValidate="txtPostalTargetAmt" CssClass="cvPCG" Operator="Equal"
                                    Display="Dynamic" ValidationGroup="grpIns"></asp:CompareValidator>
                                <%--<span id="Span28" class="spnRequiredField">*</span>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator27" ControlToValidate="txtPostalTargetAmt"
                                ValidationGroup="btnRD" ErrorMessage="<br />Please Enter Agent No./Agency Code" Display="Dynamic"
                                runat="server" CssClass="rfvPCG">
                            </asp:RequiredFieldValidator>--%>
                            </td>
                        </tr>
                        <tr>
                            <td>
                            </td>
                            <td style="vertical-align: middle;">
                                &nbsp;&nbsp;&nbsp;
                                <asp:Label ID="Label32" runat="server" CssClass="FieldName" Text="Target Account:"></asp:Label>
                                <asp:TextBox ID="txtPostalTargetAccount" runat="server" CssClass="txtField" MaxLength="5"></asp:TextBox>
                                <asp:CompareValidator ID="cvtxtPostalTargetAccount" runat="server" ErrorMessage="<br/>Sorry, Please enter a numeric value !"
                                    Type="Double" ControlToValidate="txtPostalTargetAccount" CssClass="cvPCG" Operator="Equal"
                                    Display="Dynamic" ValidationGroup="grpIns"></asp:CompareValidator>
                                <%--<span id="Span29" class="spnRequiredField">*</span>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator27" ControlToValidate="txtPostalTargetAccount"
                                ValidationGroup="btnRD" ErrorMessage="<br />Please Enter Agent No./Agency Code" Display="Dynamic"
                                runat="server" CssClass="rfvPCG">
                            </asp:RequiredFieldValidator>--%>
                            </td>
                            <td class="rightField">
                            </td>
                        </tr>
                        <tr>
                            <td colspan="3" class="SubmitCell">
                                <asp:Button ID="btnPostal" runat="server" CssClass="PCGButton" onmouseover="javascript:ChangeButtonCss('hover', 'ctrl_LOB_btnRemissDeriv');"
                                    onmouseout="javascript:ChangeButtonCss('out', 'ctrl_LOB_btnRemissDeriv');" Text="Submit"
                                    ValidationGroup="grpPostal" OnClick="btnPostal_Click" Style="height: 26px" />
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr id="RealEstate" runat="server">
                <td>
                    <table style="width: 82%; height: 238px;" class="TableBackground">
                        <tr>
                            <td colspan="2" class="HeaderCell">
                                <asp:Label ID="Label49" runat="server" CssClass="HeaderTextBig" Text="Real Estate Agent Details"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td>
                            </td>
                            <td>
                            </td>
                        </tr>
                        <tr>
                            <td class="leftField">
                                <asp:Label ID="Label50" runat="server" CssClass="FieldName" Text="Organization Name:"></asp:Label>
                            </td>
                            <td class="rightField">
                                <asp:TextBox ID="txtRealEstOrgName" runat="server" CssClass="txtField"></asp:TextBox>
                                <span id="Span35" class="spnRequiredField">*</span>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator34" ControlToValidate="txtRealEstOrgName"
                                    ValidationGroup="btnRD" ErrorMessage="<br />Please Enter Organization Name" Display="Dynamic"
                                    runat="server" CssClass="rfvPCG">
                                </asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td class="leftField">
                                <asp:Label ID="Label51" runat="server" CssClass="FieldName" Text="Agent No./Agency Code:"></asp:Label>
                            </td>
                            <td class="rightField">
                                <asp:TextBox ID="txtRealEstAgentNum" runat="server" CssClass="txtField"></asp:TextBox>
                                <%--<span id="Span36" class="spnRequiredField">*</span>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator35" ControlToValidate="txtRealEstAgentNum"
                                    ValidationGroup="btnRD" ErrorMessage="<br />Please Enter Agent No./Agency Code"
                                    Display="Dynamic" runat="server" CssClass="rfvPCG">
                                </asp:RequiredFieldValidator>--%>
                            </td>
                            <td class="rightField">
                                <asp:Label ID="Label52" runat="server" CssClass="FieldName" Text="Agency Expiry Date:"></asp:Label>
                                <%--   </td>
                        <td class="rightField">--%>
                                <asp:TextBox ID="txtRealEstAgencyExpiry" runat="server" CssClass="txtField"></asp:TextBox>
                                <cc1:CalendarExtender ID="txtRealEstAgencyExpiry_CalendarExtender" runat="server"
                                    TargetControlID="txtRealEstAgencyExpiry" Format="dd/MM/yyyy">
                                </cc1:CalendarExtender>
                                <cc1:TextBoxWatermarkExtender ID="txtRealEstAgencyExpiry_TextBoxWatermarkExtender"
                                    WatermarkText="dd/mm/yyyy" TargetControlID="txtRealEstAgencyExpiry" runat="server">
                                </cc1:TextBoxWatermarkExtender>
                                <%--<span id="Span37" class="spnRequiredField">*</span>
                                <asp:RequiredFieldValidator ID="txtRealEstAgencyExpiry_RequiredFieldValidator" ControlToValidate="txtRealEstAgencyExpiry"
                                    ValidationGroup="grpRealEst" ErrorMessage="<br />Please Enter Expiry Date" Display="Dynamic"
                                    runat="server" CssClass="rfvPCG">
                                </asp:RequiredFieldValidator>
                                <asp:CompareValidator ID="cvRealEstExpiryDate" runat="server" ErrorMessage="<br/>Sorry, Expiry date should not be prior to current date !"
                                    Type="Date" ControlToValidate="txtRealEstAgencyExpiry" CssClass="cvPCG" Operator="GreaterThanEqual"
                                    ValueToCompare="" Display="Dynamic" ValidationGroup="grpRealEst"></asp:CompareValidator>--%>
                            </td>
                        </tr>
                        <tr>
                            <td class="leftField">
                                <asp:Label ID="Label53" runat="server" CssClass="FieldName" Text="Minimum Business Criteria"></asp:Label>
                            </td>
                            <td style="vertical-align: middle;">
                                &nbsp;&nbsp;&nbsp;
                                <asp:Label ID="Label54" runat="server" CssClass="FieldName" Text="Target Amount:"></asp:Label>
                                <asp:TextBox ID="txtRealEstTargetAmt" runat="server" CssClass="txtField" MaxLength="19"></asp:TextBox>
                                <asp:CompareValidator ID="cvtxtRealEstTargetAmt" runat="server" ErrorMessage="<br/>Sorry, Please enter a numeric value !"
                                    Type="Double" ControlToValidate="txtRealEstTargetAmt" CssClass="cvPCG" Operator="Equal"
                                    Display="Dynamic" ValidationGroup="grpIns"></asp:CompareValidator>
                            </td>
                            <td class="rightField">
                                <%--<span id="Span28" class="spnRequiredField">*</span>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator27" ControlToValidate="txtRealEstTargetAmt"
                                ValidationGroup="btnRD" ErrorMessage="<br />Please Enter Agent No./Agency Code" Display="Dynamic"
                                runat="server" CssClass="rfvPCG">
                            </asp:RequiredFieldValidator>--%>
                            </td>
                        </tr>
                        <tr>
                            <td class="leftField">
                            </td>
                            <td style="vertical-align: middle;">
                                &nbsp;&nbsp;&nbsp;
                                <asp:Label ID="Label55" runat="server" CssClass="FieldName" Text="Target Account:"></asp:Label>
                                <asp:TextBox ID="txtRealEstTargetAccount" runat="server" CssClass="txtField" MaxLength="5"></asp:TextBox>
                                <asp:CompareValidator ID="cvtxtRealEstTargetAccount" runat="server" ErrorMessage="<br/>Sorry, Please enter a numeric value !"
                                    Type="Double" ControlToValidate="txtRealEstTargetAccount" CssClass="cvPCG" Operator="Equal"
                                    Display="Dynamic" ValidationGroup="grpIns"></asp:CompareValidator>
                            </td>
                            <td class="rightField">
                                <%--<span id="Span29" class="spnRequiredField">*</span>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator27" ControlToValidate="txtRealEstTargetAccount"
                                ValidationGroup="btnRD" ErrorMessage="<br />Please Enter Agent No./Agency Code" Display="Dynamic"
                                runat="server" CssClass="rfvPCG">
                            </asp:RequiredFieldValidator>--%>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="3" class="SubmitCell">
                                <asp:Button ID="btnRealEst" runat="server" CssClass="PCGButton" onmouseover="javascript:ChangeButtonCss('hover', 'ctrl_LOB_btnRemissDeriv');"
                                    onmouseout="javascript:ChangeButtonCss('out', 'ctrl_LOB_btnRemissDeriv');" Text="Submit"
                                    ValidationGroup="grpRealEst" OnClick="btnRealEst_Click" Style="height: 26px" />
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr id="FixedIncome" runat="server">
                <td>
                    <table style="width: 82%; height: 238px;" class="TableBackground">
                        <tr>
                            <td colspan="2" class="HeaderCell">
                                <asp:Label ID="Label56" runat="server" CssClass="HeaderTextBig" Text="Fixed Income Agent Details"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td>
                            </td>
                            <td>
                            </td>
                        </tr>
                        <tr>
                            <td class="leftField">
                                <asp:Label ID="Label57" runat="server" CssClass="FieldName" Text="Organization Name:"></asp:Label>
                            </td>
                            <td class="rightField">
                                <asp:TextBox ID="txtFixIncOrgName" runat="server" CssClass="txtField"></asp:TextBox>
                                <span id="Span38" class="spnRequiredField">*</span>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator37" ControlToValidate="txtFixIncOrgName"
                                    ValidationGroup="btnRD" ErrorMessage="<br />Please Enter Organization Name" Display="Dynamic"
                                    runat="server" CssClass="rfvPCG">
                                </asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td class="leftField">
                                <asp:Label ID="Label58" runat="server" CssClass="FieldName" Text="Agent No./Agency Code:"></asp:Label>
                            </td>
                            <td class="rightField">
                                <asp:TextBox ID="txtFixIncAgentNum" runat="server" CssClass="txtField"></asp:TextBox>
                                <%--<span id="Span39" class="spnRequiredField">*</span>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator38" ControlToValidate="txtFixIncAgentNum"
                                    ValidationGroup="btnRD" ErrorMessage="<br />Please Enter Agent No./Agency Code"
                                    Display="Dynamic" runat="server" CssClass="rfvPCG">
                                </asp:RequiredFieldValidator>--%>
                            </td>
                            <td class="rightField">
                                <asp:Label ID="Label59" runat="server" CssClass="FieldName" Text="Agency Expiry Date:"></asp:Label>
                                <%--   </td>
                        <td class="rightField">--%>
                                <asp:TextBox ID="txtFixIncAgencyExpiry" runat="server" CssClass="txtField"></asp:TextBox>
                                <cc1:CalendarExtender ID="txtFixIncAgencyExpiry_CalendarExtender" runat="server"
                                    TargetControlID="txtFixIncAgencyExpiry" Format="dd/MM/yyyy">
                                </cc1:CalendarExtender>
                                <cc1:TextBoxWatermarkExtender ID="txtFixIncAgencyExpiry_TextBoxWatermarkExtender"
                                    WatermarkText="dd/mm/yyyy" TargetControlID="txtFixIncAgencyExpiry" runat="server">
                                </cc1:TextBoxWatermarkExtender>
                                <%--<span id="Span40" class="spnRequiredField">*</span>
                                <asp:RequiredFieldValidator ID="txtFixIncAgencyExpiry_RequiredFieldValidator" ControlToValidate="txtFixIncAgencyExpiry"
                                    ValidationGroup="grpFixInc" ErrorMessage="<br />Please Enter Expiry Date" Display="Dynamic"
                                    runat="server" CssClass="rfvPCG">
                                </asp:RequiredFieldValidator>
                                <asp:CompareValidator ID="cvFixIncExpiryDate" runat="server" ErrorMessage="<br/>Sorry, Expiry date should not be prior to current date !"
                                    Type="Date" ControlToValidate="txtFixIncAgencyExpiry" CssClass="cvPCG" Operator="greaterthanequal"
                                    ValueToCompare="" Display="Dynamic" ValidationGroup="grpFixInc"></asp:CompareValidator>--%>
                            </td>
                        </tr>
                        <tr>
                            <td class="leftField">
                                <asp:Label ID="Label60" runat="server" CssClass="FieldName" Text="Minimum Business Criteria"></asp:Label>
                            </td>
                            <td style="vertical-align: middle;">
                                &nbsp;&nbsp;&nbsp;
                                <asp:Label ID="Label61" runat="server" CssClass="FieldName" Text="Target Amount:"></asp:Label>
                                <asp:TextBox ID="txtFixIncTargetAmt" runat="server" CssClass="txtField" MaxLength="19"></asp:TextBox>
                                <asp:CompareValidator ID="cvtxtFixIncTargetAmt" runat="server" ErrorMessage="<br/>Sorry, Please enter a numeric value !"
                                    Type="Double" ControlToValidate="txtFixIncTargetAmt" CssClass="cvPCG" Operator="Equal"
                                    Display="Dynamic" ValidationGroup="grpIns"></asp:CompareValidator>
                            </td>
                            <td class="rightField">
                                <%--<span id="Span28" class="spnRequiredField">*</span>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator27" ControlToValidate="txtFixIncTargetAmt"
                                ValidationGroup="btnRD" ErrorMessage="<br />Please Enter Agent No./Agency Code" Display="Dynamic"
                                runat="server" CssClass="rfvPCG">
                            </asp:RequiredFieldValidator>--%>
                            </td>
                        </tr>
                        <tr>
                            <td class="leftField">
                            </td>
                            <td style="vertical-align: middle;">
                                &nbsp;&nbsp;&nbsp;
                                <asp:Label ID="Label62" runat="server" CssClass="FieldName" Text="Target Account:"></asp:Label>
                                <asp:TextBox ID="txtFixIncTargetAccount" runat="server" CssClass="txtField" MaxLength="5"></asp:TextBox>
                                <asp:CompareValidator ID="cvtxtFixIncTargetAccount" runat="server" ErrorMessage="<br/>Sorry, Please enter a numeric value !"
                                    Type="Double" ControlToValidate="txtFixIncTargetAccount" CssClass="cvPCG" Operator="Equal"
                                    Display="Dynamic" ValidationGroup="grpIns"></asp:CompareValidator>
                            </td>
                            <td class="rightField">
                                <%--<span id="Span29" class="spnRequiredField">*</span>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator27" ControlToValidate="txtFixIncTargetAccount"
                                ValidationGroup="btnRD" ErrorMessage="<br />Please Enter Agent No./Agency Code" Display="Dynamic"
                                runat="server" CssClass="rfvPCG">
                            </asp:RequiredFieldValidator>--%>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="3" class="SubmitCell">
                                <asp:Button ID="btnFixInc" runat="server" CssClass="PCGButton" onmouseover="javascript:ChangeButtonCss('hover', 'ctrl_LOB_btnRemissDeriv');"
                                    onmouseout="javascript:ChangeButtonCss('out', 'ctrl_LOB_btnRemissDeriv');" Text="Submit"
                                    ValidationGroup="grpFixInc" OnClick="btnFixInc_Click" Style="height: 26px" />
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr id="Liabilities" runat="server">
                <td>
                    <table style="width: 82%; height: 238px;" class="TableBackground">
                        <tr>
                            <td colspan="2" class="HeaderCell">
                                <asp:Label ID="Label12" runat="server" CssClass="HeaderTextBig" Text="Liabilities Agent Details"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td>
                            </td>
                            <td class="style1">
                            </td>
                        </tr>
                        <tr>
                            <td class="leftField">
                                <asp:Label ID="Label33" runat="server" CssClass="FieldName" Text="Organization Name:"></asp:Label>
                            </td>
                            <td class="style2">
                                <asp:TextBox ID="txtLiabOrgName" runat="server" CssClass="txtField"></asp:TextBox>
                                <span id="Span29" class="spnRequiredField">*</span>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator28" ControlToValidate="txtLiabOrgName"
                                    ValidationGroup="btnRD" ErrorMessage="<br />Please Enter Organization Name" Display="Dynamic"
                                    runat="server" CssClass="rfvPCG">
                                </asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td class="leftField">
                                <asp:Label ID="Label43" runat="server" CssClass="FieldName" Text="Agent No./Agency Code:"></asp:Label>
                            </td>
                            <td class="style2">
                                <asp:TextBox ID="txtLiabAgentNum" runat="server" CssClass="txtField"></asp:TextBox>
                                <%--<span id="Span33" class="spnRequiredField">*</span>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator32" ControlToValidate="txtLiabAgentNum"
                                    ValidationGroup="btnRD" ErrorMessage="<br />Please Enter Agent No./Agency Code"
                                    Display="Dynamic" runat="server" CssClass="rfvPCG">
                                </asp:RequiredFieldValidator>--%>
                            </td>
                            <td class="rightField">
                                <asp:Label ID="Label44" runat="server" CssClass="FieldName" Text="Agency Expiry Date:"></asp:Label>
                                <%--  </td>
                        <td class="rightField">--%>
                                <asp:TextBox ID="txtLiabAgencyExpiry" runat="server" CssClass="txtField"></asp:TextBox>
                                <cc1:CalendarExtender ID="txtLiabAgencyExpiry_CalendarExtender" runat="server" TargetControlID="txtLiabAgencyExpiry"
                                    Format="dd/MM/yyyy">
                                </cc1:CalendarExtender>
                                <cc1:TextBoxWatermarkExtender ID="txtLiabAgencyExpiry_TextBoxWatermarkExtender" WatermarkText="dd/mm/yyyy"
                                    TargetControlID="txtLiabAgencyExpiry" runat="server">
                                </cc1:TextBoxWatermarkExtender>
                                <%--<span id="Span34" class="spnRequiredField">*</span>
                                <asp:RequiredFieldValidator ID="txtFixIncAgencyExpiryRequiredFieldValidator" ControlToValidate="txtFixIncAgencyExpiry"
                                    ValidationGroup="grpLiab" ErrorMessage="<br />Please Enter Expiry Date" Display="Dynamic"
                                    runat="server" CssClass="rfvPCG">
                                </asp:RequiredFieldValidator>
                                <asp:CompareValidator ID="cvLiabExpiryDate" runat="server" ErrorMessage="<br/>Sorry, Expiry date should not be prior to current date !"
                                    Type="Date" ControlToValidate="txtLiabAgencyExpiry" CssClass="cvPCG" Operator="greaterthanequal"
                                    ValueToCompare="" Display="Dynamic" ValidationGroup="grpLiab"></asp:CompareValidator>--%>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="Label63" runat="server" CssClass="FieldName" Text="Type Of Agent:"></asp:Label>
                            </td>
                            <td class="style1">
                                <asp:CheckBox ID="chkLiabCarLoan" AutoPostBack="true" runat="server" Text="Car Loan Agent"
                                    CssClass="txtField" OnCheckedChanged="chkLiabCarLoan_CheckedChanged" />
                            </td>
                            <td>
                                <asp:CheckBox ID="chkLiabPerLoan" AutoPostBack="true" runat="server" Text="Personal Loan Agent"
                                    CssClass="txtField" OnCheckedChanged="chkLiabPerLoan_CheckedChanged" />
                            </td>
                            <td>
                                <asp:CheckBox ID="chkLiabBothLoan" AutoPostBack="true" runat="server" Text="Car/Personal Loan Agent"
                                    CssClass="txtField" OnCheckedChanged="chkLiabBothLoan_CheckedChanged" />
                            </td>
                        </tr>
                        <tr>
                            <td class="leftField">
                                <asp:Label ID="Label46" runat="server" CssClass="FieldName" Text="Minimum Business Criteria"></asp:Label>
                            </td>
                            <td style="vertical-align: middle;" class="style1">
                                &nbsp;&nbsp;&nbsp;
                                <asp:Label ID="Label47" runat="server" CssClass="FieldName" Text="Target Amount:"></asp:Label>
                                <asp:TextBox ID="txtLiabTargetAmt" runat="server" CssClass="txtField" MaxLength="19"></asp:TextBox>
                                <asp:CompareValidator ID="cvtxtLiabTargetAmt" runat="server" ErrorMessage="<br/>Sorry, Please enter a numeric value !"
                                    Type="Double" ControlToValidate="txtLiabTargetAmt" CssClass="cvPCG" Operator="Equal"
                                    Display="Dynamic" ValidationGroup="grpIns"></asp:CompareValidator>
                            </td>
                            <td class="rightField">
                                <%--<span id="Span28" class="spnRequiredField">*</span>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator27" ControlToValidate="txtLiabTargetAmt"
                                ValidationGroup="btnRD" ErrorMessage="<br />Please Enter Agent No./Agency Code" Display="Dynamic"
                                runat="server" CssClass="rfvPCG">
                            </asp:RequiredFieldValidator>--%>
                            </td>
                        </tr>
                        <tr>
                            <td class="leftField">
                            </td>
                            <td style="vertical-align: middle;" class="style1">
                                &nbsp;&nbsp;&nbsp;
                                <asp:Label ID="Label48" runat="server" CssClass="FieldName" Text="Target Account:"></asp:Label>
                                <asp:TextBox ID="txtLiabTargetAccount" runat="server" CssClass="txtField" MaxLength="5"></asp:TextBox>
                                <asp:CompareValidator ID="cvtxtLiabTargetAccount" runat="server" ErrorMessage="<br/>Sorry, Please enter a numeric value !"
                                    Type="Double" ControlToValidate="txtLiabTargetAccount" CssClass="cvPCG" Operator="Equal"
                                    Display="Dynamic" ValidationGroup="grpIns"></asp:CompareValidator>
                            </td>
                            <td class="rightField">
                                <%--<span id="Span29" class="spnRequiredField">*</span>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator27" ControlToValidate="txtLiabTargetAccount"
                                ValidationGroup="btnRD" ErrorMessage="<br />Please Enter Agent No./Agency Code" Display="Dynamic"
                                runat="server" CssClass="rfvPCG">
                            </asp:RequiredFieldValidator>--%>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="4" class="SubmitCell">
                                <asp:Button ID="btnLiab" runat="server" CssClass="PCGButton" onmouseover="javascript:ChangeButtonCss('hover', 'ctrl_LOB_btnRemissDeriv');"
                                    onmouseout="javascript:ChangeButtonCss('out', 'ctrl_LOB_btnRemissDeriv');" Text="Submit"
                                    ValidationGroup="grpLiab" OnClick="btnLiab_Click" Style="height: 26px" />
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr id="PMSBrokerCash" runat="server">
                <td>
                    <table class="TableBackground" style="width: 100%; height: 225px;">
                        <tr>
                            <td colspan="2" class="HeaderCell">
                                <asp:Label ID="Label64" runat="server" CssClass="HeaderTextBig" Text="PMS Broker Cash Details"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                &nbsp;
                            </td>
                        </tr>
                        <tr>
                            <td class="leftField">
                                <asp:Label ID="Label65" runat="server" CssClass="FieldName" Text="Broker Name:"></asp:Label>
                            </td>
                            <td class="rightField">
                                <asp:DropDownList ID="ddlPMSBrCashBrokerName" runat="server" CssClass="cmbField">
                                </asp:DropDownList>
                                <span id="Span41" class="spnRequiredField">*</span>
                                <asp:CompareValidator ID="PMSBrCashCompareValidator3" runat="server" ControlToValidate="ddlPMSBrCashBrokerName"
                                    ErrorMessage="Please select a Broker Name" Operator="NotEqual" ValueToCompare="Select Broker Name"
                                    CssClass="cvPCG"></asp:CompareValidator>
                            </td>
                        </tr>
                        <tr>
                            <td class="leftField">
                                <asp:Label ID="Label66" runat="server" CssClass="FieldName" Text="Identifier Type:"></asp:Label>
                            </td>
                            <td class="rightField">
                                <asp:DropDownList ID="ddlPMSBrCashIdType" runat="server" AutoPostBack="True" Enabled="false"
                                    CssClass="cmbField">
                                    <asp:ListItem>BSE</asp:ListItem>
                                    <asp:ListItem>NSE</asp:ListItem>
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr id="trPMSBCBse" runat="server">
                            <td class="leftField">
                                <asp:Label ID="Label67" runat="server" CssClass="FieldName" Text="SEBI Regn No. BSE No.:"></asp:Label>
                            </td>
                            <td class="rightField">
                                <asp:TextBox ID="txtPMSBrCashBSENum" runat="server" CssClass="txtField"></asp:TextBox>
                                <span id="Span42" class="spnRequiredField">*</span>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator33" ControlToValidate="txtPMSBrCashBSENum"
                                    ValidationGroup="grpPMSBrCash" ErrorMessage="<br />Please Enter BSE Number" Display="Dynamic"
                                    runat="server" CssClass="rfvPCG">
                                </asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr id="trPMSBCNse" runat="server">
                            <td class="leftField">
                                <asp:Label ID="Label68" runat="server" CssClass="FieldName" Text="SEBI Regn No. NSE No.:"></asp:Label>
                            </td>
                            <td class="rightField">
                                <asp:TextBox ID="txtPMSBrCashNSENum" runat="server" CssClass="txtField"></asp:TextBox>
                                <span id="Span43" class="spnRequiredField">*</span>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator36" ControlToValidate="txtPMSBrCashNSENum"
                                    ValidationGroup="grpPMSBrCash" ErrorMessage="<br />Please Enter NSE Number" Display="Dynamic"
                                    runat="server" CssClass="rfvPCG">
                                </asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" class="SubmitCell">
                                <asp:Button ID="btnPMSBrCash" runat="server" OnClick="btnPMSBrCash_Click" Text="Submit"
                                    ValidationGroup="grpPMSBrCash" CssClass="PCGButton" onmouseover="javascript:ChangeButtonCss('hover', 'ctrl_LOB_btnBrokerCash');"
                                    onmouseout="javascript:ChangeButtonCss('out', 'ctrl_LOB_btnBrokerCash');" />
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr id="PMSBrokerDerivative" runat="server">
                <td>
                    <table class="TableBackground" style="width: 100%; height: 225px;">
                        <tr>
                            <td colspan="2" class="HeaderCell">
                                <asp:Label ID="Label69" runat="server" CssClass="HeaderTextBig" Text="PMS Broker Derivative Details"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                &nbsp;
                            </td>
                        </tr>
                        <tr>
                            <td class="leftField">
                                <asp:Label ID="Label70" runat="server" CssClass="FieldName" Text="Broker Name:"></asp:Label>
                            </td>
                            <td class="rightField">
                                <asp:DropDownList ID="ddlPMSBrDerBrokerName" runat="server" CssClass="cmbField">
                                </asp:DropDownList>
                                <span id="Span44" class="spnRequiredField">*</span>
                                <asp:CompareValidator ID="PMSBrDerCompareValidator3" runat="server" ControlToValidate="ddlPMSBrDerBrokerName"
                                    ErrorMessage="Please select a Broker Name" Operator="NotEqual" ValueToCompare="Select Broker Name"
                                    CssClass="cvPCG"></asp:CompareValidator>
                            </td>
                        </tr>
                        <tr>
                            <td class="leftField">
                                <asp:Label ID="Label71" runat="server" CssClass="FieldName" Text="Identifier Type:"></asp:Label>
                            </td>
                            <td class="rightField">
                                <asp:DropDownList ID="ddlPMSBrDerIdType" runat="server" AutoPostBack="True" CssClass="cmbField"
                                    Enabled="false">
                                    <asp:ListItem>BSE</asp:ListItem>
                                    <asp:ListItem>NSE</asp:ListItem>
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr id="trPMSBDBse" runat="server">
                            <td class="leftField">
                                <asp:Label ID="Label72" runat="server" CssClass="FieldName" Text="SEBI Regn No. BSE No.:"></asp:Label>
                            </td>
                            <td class="rightField">
                                <asp:TextBox ID="txtPMSBrDerBSENum" runat="server" CssClass="txtField"></asp:TextBox>
                                <span id="Span45" class="spnRequiredField">*</span>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator40" ControlToValidate="txtPMSBrDerBSENum"
                                    ValidationGroup="grpPMSBrDer" ErrorMessage="<br />Please Enter BSE Number" Display="Dynamic"
                                    runat="server" CssClass="rfvPCG">
                                </asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr id="trPMSBDNse" runat="server">
                            <td class="leftField">
                                <asp:Label ID="Label73" runat="server" CssClass="FieldName" Text="SEBI Regn No. NSE No.:"></asp:Label>
                            </td>
                            <td class="rightField">
                                <asp:TextBox ID="txtPMSBrDerNSENum" runat="server" CssClass="txtField"></asp:TextBox>
                                <span id="Span46" class="spnRequiredField">*</span>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator41" ControlToValidate="txtPMSBrDerNSENum"
                                    ValidationGroup="grpPMSBrDer" ErrorMessage="<br />Please Enter NSE Number" Display="Dynamic"
                                    runat="server" CssClass="rfvPCG">
                                </asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td class="leftField">
                                <asp:Label ID="Label74" runat="server" CssClass="FieldName" Text="License No.:"></asp:Label>
                            </td>
                            <td class="rightField">
                                <asp:TextBox ID="txtPMSBrDerLicenseNum" runat="server" CssClass="txtField"></asp:TextBox>
                                <span id="Span47" class="spnRequiredField">*</span>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator42" ControlToValidate="txtPMSBrDerLicenseNum"
                                    ValidationGroup="grpPMSBrDer" ErrorMessage="<br />Please Enter the License Number"
                                    Display="Dynamic" runat="server" CssClass="rfvPCG">
                                </asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" class="SubmitCell">
                                <asp:Button ID="btnPMSBrDer" runat="server" OnClick="btnPMSBrDer_Click" Text="Submit"
                                    ValidationGroup="grpPMSBrDer" CssClass="PCGButton" onmouseover="javascript:ChangeButtonCss('hover', 'ctrl_LOB_btnBrokerCash');"
                                    onmouseout="javascript:ChangeButtonCss('out', 'ctrl_LOB_btnBrokerCash');" />
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr id="PMSSubBrokerCash" runat="server">
                <td>
                    <table class="TableBackground" style="width: 100%; height: 225px;">
                        <tr>
                            <td colspan="2" class="HeaderCell">
                                <asp:Label ID="Label75" runat="server" CssClass="HeaderTextBig" Text="PMS Sub Broker Cash Details"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                &nbsp;
                            </td>
                        </tr>
                        <%--          <tr>
                        <td class="leftField">
                            <asp:Label ID="Label76" runat="server" CssClass="FieldName" Text="Broker Name:"></asp:Label>
                        </td>
                        <td class="rightField">
                            <asp:TextBox ID="txtPMSSubBrCashBrokerName" runat="server" CssClass="txtField"></asp:TextBox>
                            <span id="Span48" class="spnRequiredField">*</span>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator43" ControlToValidate="txtPMSSubBrCashBrokerName"
                                ValidationGroup="grpPMSSubBrCash" ErrorMessage="<br />Please Enter Broker Name"
                                Display="Dynamic" runat="server" CssClass="rfvPCG">
                            </asp:RequiredFieldValidator>
                        </td>
                    </tr>--%><tr>
                        <td class="leftField">
                            <asp:Label ID="Label29" runat="server" CssClass="FieldName" Text="Broker Name:"></asp:Label>
                        </td>
                        <td class="rightField">
                            <asp:DropDownList ID="ddlPMSBrokerCode" runat="server" CssClass="cmbField">
                            </asp:DropDownList>
                            <span id="Span48" class="spnRequiredField">*</span>
                            <asp:CompareValidator ID="PMSSubBrCashCompareValidator3" runat="server" ControlToValidate="ddlPMSBrokerCode"
                                ErrorMessage="Please select Broker Name" Operator="NotEqual" ValueToCompare="Select Broker Name"
                                CssClass="cvPCG"></asp:CompareValidator>
                        </td>
                    </tr>
                        <tr>
                            <td class="leftField">
                                <asp:Label ID="Label77" runat="server" CssClass="FieldName" Text="Identifier Type:"></asp:Label>
                            </td>
                            <td class="rightField">
                                <asp:DropDownList ID="ddlPMSSubBrCashIdType" runat="server" AutoPostBack="True" Enabled="false"
                                    CssClass="cmbField">
                                    <asp:ListItem>BSE</asp:ListItem>
                                    <asp:ListItem>NSE</asp:ListItem>
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr id="trPMSSBCBse" runat="server">
                            <td class="leftField">
                                <asp:Label ID="Label78" runat="server" CssClass="FieldName" Text="SEBI Regn No. BSE No.:"></asp:Label>
                            </td>
                            <td class="rightField">
                                <asp:TextBox ID="txtPMSSubBrCashBSENum" runat="server" CssClass="txtField"></asp:TextBox>
                                <span id="Span49" class="spnRequiredField">*</span>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator44" ControlToValidate="txtPMSSubBrCashBSENum"
                                    ValidationGroup="grpPMSSubBrCash" ErrorMessage="<br />Please Enter BSE Number"
                                    Display="Dynamic" runat="server" CssClass="rfvPCG">
                                </asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr id="trPMSSBCNse" runat="server">
                            <td class="leftField">
                                <asp:Label ID="Label79" runat="server" CssClass="FieldName" Text="SEBI Regn No. NSE No.:"></asp:Label>
                            </td>
                            <td class="rightField">
                                <asp:TextBox ID="txtPMSSubBrCashNSENum" runat="server" CssClass="txtField"></asp:TextBox>
                                <span id="Span50" class="spnRequiredField">*</span>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator45" ControlToValidate="txtPMSSubBrCashNSENum"
                                    ValidationGroup="grpPMSSubBrCash" ErrorMessage="<br />Please Enter NSE Number"
                                    Display="Dynamic" runat="server" CssClass="rfvPCG">
                                </asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" class="SubmitCell">
                                <asp:Button ID="btnPMSSubBrCash" runat="server" OnClick="btnPMSSubBrCash_Click" Text="Submit"
                                    ValidationGroup="grpPMSSubBrCash" CssClass="PCGButton" onmouseover="javascript:ChangeButtonCss('hover', 'ctrl_LOB_btnBrokerCash');"
                                    onmouseout="javascript:ChangeButtonCss('out', 'ctrl_LOB_btnBrokerCash');" />
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr id="PMSSubBrokerDerivative" runat="server">
                <td>
                    <table class="TableBackground" style="width: 100%; height: 225px;">
                        <tr>
                            <td colspan="2" class="HeaderCell">
                                <asp:Label ID="Label80" runat="server" CssClass="HeaderTextBig" Text="PMS Sub Broker Derivative Details"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                &nbsp;
                            </td>
                        </tr>
                        <%--<tr>
                        <td class="leftField">
                            <asp:Label ID="Label81" runat="server" CssClass="FieldName" Text="Broker Name:"></asp:Label>
                        </td>
                        <td class="rightField">
                            <asp:TextBox ID="txtPMSSubBrDerBrokerName" runat="server" CssClass="txtField"></asp:TextBox>
                            <span id="Span51" class="spnRequiredField">*</span>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator46" ControlToValidate="txtPMSSubBrDerBrokerName"
                                ValidationGroup="grpPMSSubBrDer" ErrorMessage="<br />Please Enter Broker Name"
                                Display="Dynamic" runat="server" CssClass="rfvPCG">
                            </asp:RequiredFieldValidator>
                        </td>
                    </tr>--%><tr>
                        <td class="leftField">
                            <asp:Label ID="Label36" runat="server" CssClass="FieldName" Text="Broker Name:"></asp:Label>
                        </td>
                        <td class="rightField">
                            <asp:DropDownList ID="ddlPMSDeriBrokerCode" runat="server" CssClass="cmbField">
                            </asp:DropDownList>
                            <span id="Span51" class="spnRequiredField">*</span>
                            <asp:CompareValidator ID="PMSSubBrDerCompareValidator4" runat="server" ControlToValidate="ddlPMSDeriBrokerCode"
                                ErrorMessage="Please select Broker Name" Operator="NotEqual" ValueToCompare="Select Broker Name"
                                CssClass="cvPCG"></asp:CompareValidator>
                        </td>
                    </tr>
                        <tr>
                            <td class="leftField">
                                <asp:Label ID="Label82" runat="server" CssClass="FieldName" Text="Identifier Type:"></asp:Label>
                            </td>
                            <td class="rightField">
                                <asp:DropDownList ID="ddlPMSSubBrDerIdType" runat="server" AutoPostBack="True" Enabled="false"
                                    CssClass="cmbField">
                                    <asp:ListItem>BSE</asp:ListItem>
                                    <asp:ListItem>NSE</asp:ListItem>
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr id="trPMSSBDBse" runat="server">
                            <td class="leftField">
                                <asp:Label ID="Label83" runat="server" CssClass="FieldName" Text="SEBI Regn No. BSE No.:"></asp:Label>
                            </td>
                            <td class="rightField">
                                <asp:TextBox ID="txtPMSSubBrDerBSENum" runat="server" CssClass="txtField"></asp:TextBox>
                                <span id="Span52" class="spnRequiredField">*</span>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator47" ControlToValidate="txtPMSSubBrDerBSENum"
                                    ValidationGroup="grpPMSSubBrDer" ErrorMessage="<br />Please Enter BSE Number"
                                    Display="Dynamic" runat="server" CssClass="rfvPCG">
                                </asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr id="trPMSSBDNse" runat="server">
                            <td class="leftField">
                                <asp:Label ID="Label84" runat="server" CssClass="FieldName" Text="SEBI Regn No. NSE No.:"></asp:Label>
                            </td>
                            <td class="rightField">
                                <asp:TextBox ID="txtPMSSubBrDerNSENum" runat="server" CssClass="txtField"></asp:TextBox>
                                <span id="Span53" class="spnRequiredField">*</span>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator48" ControlToValidate="txtPMSSubBrDerNSENum"
                                    ValidationGroup="grpPMSSubBrDer" ErrorMessage="<br />Please Enter NSE Number"
                                    Display="Dynamic" runat="server" CssClass="rfvPCG">
                                </asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td class="leftField">
                                <asp:Label ID="Label85" runat="server" CssClass="FieldName" Text="License No.:"></asp:Label>
                            </td>
                            <td class="rightField">
                                <asp:TextBox ID="txtPMSSubBrDerLicenseNum" runat="server" CssClass="txtField"></asp:TextBox>
                                <span id="Span54" class="spnRequiredField">*</span>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator49" ControlToValidate="txtPMSSubBrDerLicenseNum"
                                    ValidationGroup="grpPMSSubBrDer" ErrorMessage="<br />Please Enter the License Number"
                                    Display="Dynamic" runat="server" CssClass="rfvPCG">
                                </asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" class="SubmitCell">
                                <asp:Button ID="btnPMSSubBrDer" runat="server" OnClick="btnPMSSubBrDer_Click" Text="Submit"
                                    ValidationGroup="grpPMSSubBrDer" CssClass="PCGButton" onmouseover="javascript:ChangeButtonCss('hover', 'ctrl_LOB_btnBrokerCash');"
                                    onmouseout="javascript:ChangeButtonCss('out', 'ctrl_LOB_btnBrokerCash');" />
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr id="PMSRemissaryCash" runat="server">
                <td>
                    <table class="TableBackground" style="width: 100%; height: 225px;">
                        <tr>
                            <td colspan="2" class="HeaderCell">
                                <asp:Label ID="Label86" runat="server" CssClass="HeaderTextBig" Text="PMS Remissary Cash Details"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                &nbsp;
                            </td>
                        </tr>
                        <tr>
                            <td class="leftField">
                                <asp:Label ID="Label87" runat="server" CssClass="FieldName" Text="Broker Name:"></asp:Label>
                            </td>
                            <td class="rightField">
                                <asp:DropDownList ID="ddlPMSRemCashBrokerName" runat="server" CssClass="cmbField">
                                </asp:DropDownList>
                                <span id="Span55" class="spnRequiredField">*</span>
                                <asp:CompareValidator ID="PMSRemCashCompareValidator5" runat="server" ControlToValidate="ddlPMSRemCashBrokerName"
                                    ErrorMessage="Please select a Broker Name" Operator="NotEqual" ValueToCompare="Select Broker Name"
                                    CssClass="cvPCG"></asp:CompareValidator>
                            </td>
                        </tr>
                        <tr>
                            <td class="leftField">
                                <asp:Label ID="Label88" runat="server" CssClass="FieldName" Text="Identifier Type:"></asp:Label>
                            </td>
                            <td class="rightField">
                                <asp:DropDownList ID="ddlPMSRemissCashIdType" runat="server" AutoPostBack="True"
                                    Enabled="false" CssClass="cmbField">
                                    <asp:ListItem>BSE</asp:ListItem>
                                    <asp:ListItem>NSE</asp:ListItem>
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr id="trPMSRCBse" runat="server">
                            <td class="leftField">
                                <asp:Label ID="Label89" runat="server" CssClass="FieldName" Text="SEBI Regn No. BSE No.:"></asp:Label>
                            </td>
                            <td class="rightField">
                                <asp:TextBox ID="txtPMSRemissCashBSENum" runat="server" CssClass="txtField"></asp:TextBox>
                                <span id="Span56" class="spnRequiredField">*</span>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator51" ControlToValidate="txtPMSRemissCashBSENum"
                                    ValidationGroup="grpPMSRemissCash" ErrorMessage="<br />Please Enter BSE Number"
                                    Display="Dynamic" runat="server" CssClass="rfvPCG">
                                </asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr id="trPMSRCNse" runat="server">
                            <td class="leftField">
                                <asp:Label ID="Label90" runat="server" CssClass="FieldName" Text="SEBI Regn No. NSE No.:"></asp:Label>
                            </td>
                            <td class="rightField">
                                <asp:TextBox ID="txtPMSRemissCashNSENum" runat="server" CssClass="txtField"></asp:TextBox>
                                <span id="Span57" class="spnRequiredField">*</span>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator52" ControlToValidate="txtPMSRemissCashNSENum"
                                    ValidationGroup="grpPMSRemissCash" ErrorMessage="<br />Please Enter NSE Number"
                                    Display="Dynamic" runat="server" CssClass="rfvPCG">
                                </asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" class="SubmitCell">
                                <asp:Button ID="btnPMSRemissCash" runat="server" OnClick="btnPMSRemissCash_Click"
                                    Text="Submit" ValidationGroup="grpPMSRemissCash" CssClass="PCGButton" onmouseover="javascript:ChangeButtonCss('hover', 'ctrl_LOB_btnBrokerCash');"
                                    onmouseout="javascript:ChangeButtonCss('out', 'ctrl_LOB_btnBrokerCash');" />
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr id="PMSRemissaryDerivative" runat="server">
                <td>
                    <table class="TableBackground" style="width: 100%; height: 225px;">
                        <tr>
                            <td colspan="2" class="HeaderCell">
                                <asp:Label ID="Label91" runat="server" CssClass="HeaderTextBig" Text="PMS Remissary Derivative Details"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                &nbsp;
                            </td>
                        </tr>
                        <tr>
                            <td class="leftField">
                                <asp:Label ID="Label92" runat="server" CssClass="FieldName" Text="Broker Name:"></asp:Label>
                            </td>
                            <td class="rightField">
                                <asp:DropDownList ID="ddlPMSRemDerBrokerName" runat="server" CssClass="cmbField">
                                </asp:DropDownList>
                                <span id="Span58" class="spnRequiredField">*</span>
                                <asp:CompareValidator ID="PMSRemDerCompareValidator6" runat="server" ControlToValidate="ddlPMSRemDerBrokerName"
                                    ErrorMessage="Please select a Broker Name" Operator="NotEqual" ValueToCompare="Select Broker Name"
                                    CssClass="cvPCG"></asp:CompareValidator>
                            </td>
                        </tr>
                        <tr>
                            <td class="leftField">
                                <asp:Label ID="Label93" runat="server" CssClass="FieldName" Text="Identifier Type:"></asp:Label>
                            </td>
                            <td class="rightField">
                                <asp:DropDownList ID="ddlPMSRemissDerIdType" runat="server" AutoPostBack="True" Enabled="false"
                                    CssClass="cmbField">
                                    <asp:ListItem>BSE</asp:ListItem>
                                    <asp:ListItem>NSE</asp:ListItem>
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr id="trPMSRDBse" runat="server">
                            <td class="leftField">
                                <asp:Label ID="Label94" runat="server" CssClass="FieldName" Text="SEBI Regn No. BSE No.:"></asp:Label>
                            </td>
                            <td class="rightField">
                                <asp:TextBox ID="txtPMSRemissDerBSENum" runat="server" CssClass="txtField"></asp:TextBox>
                                <span id="Span59" class="spnRequiredField">*</span>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator54" ControlToValidate="txtPMSRemissDerBSENum"
                                    ValidationGroup="grpPMSRemissDer" ErrorMessage="<br />Please Enter BSE Number"
                                    Display="Dynamic" runat="server" CssClass="rfvPCG">
                                </asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr id="trPMSRDNse" runat="server">
                            <td class="leftField">
                                <asp:Label ID="Label95" runat="server" CssClass="FieldName" Text="SEBI Regn No. NSE No.:"></asp:Label>
                            </td>
                            <td class="rightField">
                                <asp:TextBox ID="txtPMSRemissDerNSENum" runat="server" CssClass="txtField"></asp:TextBox>
                                <span id="Span60" class="spnRequiredField">*</span>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator55" ControlToValidate="txtPMSRemissDerNSENum"
                                    ValidationGroup="grpPMSRemissDer" ErrorMessage="<br />Please Enter NSE Number"
                                    Display="Dynamic" runat="server" CssClass="rfvPCG">
                                </asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td class="leftField">
                                <asp:Label ID="Label96" runat="server" CssClass="FieldName" Text="License No.:"></asp:Label>
                            </td>
                            <td class="rightField">
                                <asp:TextBox ID="txtPMSRemissDerLicenseNum" runat="server" CssClass="txtField"></asp:TextBox>
                                <span id="Span61" class="spnRequiredField">*</span>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator56" ControlToValidate="txtPMSRemissDerLicenseNum"
                                    ValidationGroup="grpPMSRemissDer" ErrorMessage="<br />Please Enter the License Number"
                                    Display="Dynamic" runat="server" CssClass="rfvPCG">
                                </asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" class="SubmitCell">
                                <asp:Button ID="btnPMSRemissDer" runat="server" OnClick="btnPMSRemissDer_Click" Text="Submit"
                                    ValidationGroup="grpPMSRemissDer" CssClass="PCGButton" onmouseover="javascript:ChangeButtonCss('hover', 'ctrl_LOB_btnBrokerCash');"
                                    onmouseout="javascript:ChangeButtonCss('out', 'ctrl_LOB_btnBrokerCash');" />
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr id="CommoditiesBrokerCash" runat="server">
                <td>
                    <table class="TableBackground" style="width: 100%; height: 225px;">
                        <tr>
                            <td colspan="2" class="HeaderCell">
                                <asp:Label ID="Label97" runat="server" CssClass="HeaderTextBig" Text="Commodities Broker Cash Details"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                &nbsp;
                            </td>
                        </tr>
                        <tr>
                            <td class="leftField">
                                <asp:Label ID="Label98" runat="server" CssClass="FieldName" Text="Broker Name:"></asp:Label>
                            </td>
                            <td class="rightField">
                                <asp:DropDownList ID="ddlCommBrCashBrokerName" runat="server" CssClass="cmbField">
                                </asp:DropDownList>
                                <span id="Span62" class="spnRequiredField">*</span>
                                <asp:CompareValidator ID="CommBrCashCompareValidator7" runat="server" ControlToValidate="ddlCommBrCashBrokerName"
                                    ErrorMessage="Please select a Broker Name" Operator="NotEqual" ValueToCompare="Select Broker Name"
                                    CssClass="cvPCG"></asp:CompareValidator>
                            </td>
                        </tr>
                        <tr>
                            <td class="leftField">
                                <asp:Label ID="Label99" runat="server" CssClass="FieldName" Text="Identifier Type:"></asp:Label>
                            </td>
                            <td class="rightField">
                                <asp:DropDownList ID="ddlCommBrCashIdType" runat="server" AutoPostBack="True" Enabled="false"
                                    CssClass="cmbField">
                                    <asp:ListItem>BSE</asp:ListItem>
                                    <asp:ListItem>NSE</asp:ListItem>
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr id="trCommBCBse" runat="server">
                            <td class="leftField">
                                <asp:Label ID="Label100" runat="server" CssClass="FieldName" Text="SEBI Regn No. BSE No.:"></asp:Label>
                            </td>
                            <td class="rightField">
                                <asp:TextBox ID="txtCommBrCashBSENum" runat="server" CssClass="txtField"></asp:TextBox>
                                <span id="Span63" class="spnRequiredField">*</span>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator58" ControlToValidate="txtCommBrCashBSENum"
                                    ValidationGroup="grpCommBrCash" ErrorMessage="<br />Please Enter BSE Number"
                                    Display="Dynamic" runat="server" CssClass="rfvPCG">
                                </asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr id="trCommBCNse" runat="server">
                            <td class="leftField">
                                <asp:Label ID="Label101" runat="server" CssClass="FieldName" Text="SEBI Regn No. NSE No.:"></asp:Label>
                            </td>
                            <td class="rightField">
                                <asp:TextBox ID="txtCommBrCashNSENum" runat="server" CssClass="txtField"></asp:TextBox>
                                <span id="Span64" class="spnRequiredField">*</span>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator59" ControlToValidate="txtCommBrCashNSENum"
                                    ValidationGroup="grpCommBrCash" ErrorMessage="<br />Please Enter NSE Number"
                                    Display="Dynamic" runat="server" CssClass="rfvPCG">
                                </asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" class="SubmitCell">
                                <asp:Button ID="btnCommBrCash" runat="server" OnClick="btnCommBrCash_Click" Text="Submit"
                                    ValidationGroup="grpCommBrCash" CssClass="PCGButton" onmouseover="javascript:ChangeButtonCss('hover', 'ctrl_LOB_btnBrokerCash');"
                                    onmouseout="javascript:ChangeButtonCss('out', 'ctrl_LOB_btnBrokerCash');" />
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr id="CommoditiesBrokerDerivatives" runat="server">
                <td>
                    <table class="TableBackground" style="width: 100%; height: 225px;">
                        <tr>
                            <td colspan="2" class="HeaderCell">
                                <asp:Label ID="Label102" runat="server" CssClass="HeaderTextBig" Text="Commodities Broker Derivative Details"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                &nbsp;
                            </td>
                        </tr>
                        <tr>
                            <td class="leftField">
                                <asp:Label ID="Label103" runat="server" CssClass="FieldName" Text="Broker Name:"></asp:Label>
                            </td>
                            <td class="rightField">
                                <asp:DropDownList ID="ddlCommBrDerBrokerName" runat="server" CssClass="cmbField">
                                </asp:DropDownList>
                                <span id="Span65" class="spnRequiredField">*</span>
                                <asp:CompareValidator ID="CommBrDerCompareValidator7" runat="server" ControlToValidate="ddlCommBrDerBrokerName"
                                    ErrorMessage="Please select a Broker Name" Operator="NotEqual" ValueToCompare="Select Broker Name"
                                    CssClass="cvPCG"></asp:CompareValidator>
                            </td>
                        </tr>
                        <tr>
                            <td class="leftField">
                                <asp:Label ID="Label104" runat="server" CssClass="FieldName" Text="Identifier Type:"></asp:Label>
                            </td>
                            <td class="rightField">
                                <asp:DropDownList ID="ddlCommBrDerIdType" runat="server" AutoPostBack="True" Enabled="false"
                                    CssClass="cmbField">
                                    <asp:ListItem>BSE</asp:ListItem>
                                    <asp:ListItem>NSE</asp:ListItem>
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr id="trCommBDBse" runat="server">
                            <td class="leftField">
                                <asp:Label ID="Label105" runat="server" CssClass="FieldName" Text="SEBI Regn No. BSE No.:"></asp:Label>
                            </td>
                            <td class="rightField">
                                <asp:TextBox ID="txtCommBrDerBSENum" runat="server" CssClass="txtField"></asp:TextBox>
                                <span id="Span66" class="spnRequiredField">*</span>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator61" ControlToValidate="txtCommBrDerBSENum"
                                    ValidationGroup="grpCommBrDer" ErrorMessage="<br />Please Enter BSE Number" Display="Dynamic"
                                    runat="server" CssClass="rfvPCG">
                                </asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr id="trCommBDNse" runat="server">
                            <td class="leftField">
                                <asp:Label ID="Label106" runat="server" CssClass="FieldName" Text="SEBI Regn No. NSE No.:"></asp:Label>
                            </td>
                            <td class="rightField">
                                <asp:TextBox ID="txtCommBrDerNSENum" runat="server" CssClass="txtField"></asp:TextBox>
                                <span id="Span67" class="spnRequiredField">*</span>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator62" ControlToValidate="txtCommBrDerNSENum"
                                    ValidationGroup="grpCommBrDer" ErrorMessage="<br />Please Enter NSE Number" Display="Dynamic"
                                    runat="server" CssClass="rfvPCG">
                                </asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td class="leftField">
                                <asp:Label ID="Label107" runat="server" CssClass="FieldName" Text="License No.:"></asp:Label>
                            </td>
                            <td class="rightField">
                                <asp:TextBox ID="txtCommBrDerLicenseNum" runat="server" CssClass="txtField"></asp:TextBox>
                                <span id="Span68" class="spnRequiredField">*</span>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator63" ControlToValidate="txtCommBrDerLicenseNum"
                                    ValidationGroup="grpCommBrDer" ErrorMessage="<br />Please Enter the License Number"
                                    Display="Dynamic" runat="server" CssClass="rfvPCG">
                                </asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" class="SubmitCell">
                                <asp:Button ID="btnCommBrDer" runat="server" OnClick="btnCommBrDer_Click" Text="Submit"
                                    ValidationGroup="grpCommBrDer" CssClass="PCGButton" onmouseover="javascript:ChangeButtonCss('hover', 'ctrl_LOB_btnBrokerCash');"
                                    onmouseout="javascript:ChangeButtonCss('out', 'ctrl_LOB_btnBrokerCash');" />
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr id="CommoditiesSubBrokerCash" runat="server">
                <td>
                    <table class="TableBackground" style="width: 100%; height: 225px;">
                        <tr>
                            <td colspan="2" class="HeaderCell">
                                <asp:Label ID="Label108" runat="server" CssClass="HeaderTextBig" Text="Commodities Sub Broker Cash Details"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                &nbsp;
                            </td>
                        </tr>
                        <%--  <tr>
                        <td class="leftField">
                            <asp:Label ID="Label109" runat="server" CssClass="FieldName" Text="Broker Name:"></asp:Label>
                        </td>
                        <td class="rightField">
                            <asp:TextBox ID="txtCommSubBrCashBrokerName" runat="server" CssClass="txtField"></asp:TextBox>
                            <span id="Span69" class="spnRequiredField">*</span>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator64" ControlToValidate="txtCommSubBrCashBrokerName"
                                ValidationGroup="grpCommSubBrCash" ErrorMessage="<br />Please Enter Broker Name"
                                Display="Dynamic" runat="server" CssClass="rfvPCG">
                            </asp:RequiredFieldValidator>
                        </td>
                    </tr>--%><tr>
                        <td class="leftField">
                            <asp:Label ID="Label76" runat="server" CssClass="FieldName" Text="Broker Name:"></asp:Label>
                        </td>
                        <td class="rightField">
                            <asp:DropDownList ID="ddlCommCashBrokerCode" runat="server" CssClass="cmbField">
                            </asp:DropDownList>
                            <span id="Span69" class="spnRequiredField">*</span>
                            <asp:CompareValidator ID="CommSubBrCashCompareValidator5" runat="server" ControlToValidate="ddlCommCashBrokerCode"
                                ErrorMessage="Please select Broker Name" Operator="NotEqual" ValueToCompare="Select Broker Name"
                                CssClass="cvPCG"></asp:CompareValidator>
                        </td>
                    </tr>
                        <tr>
                            <td class="leftField">
                                <asp:Label ID="Label110" runat="server" CssClass="FieldName" Text="Identifier Type:"></asp:Label>
                            </td>
                            <td class="rightField">
                                <asp:DropDownList ID="ddlCommSubBrCashIdType" runat="server" AutoPostBack="True"
                                    Enabled="false" CssClass="cmbField">
                                    <asp:ListItem>BSE</asp:ListItem>
                                    <asp:ListItem>NSE</asp:ListItem>
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr id="trCommSBCBse" runat="server">
                            <td class="leftField">
                                <asp:Label ID="Label789" runat="server" CssClass="FieldName" Text="SEBI Regn No. BSE No.:"></asp:Label>
                            </td>
                            <td class="rightField">
                                <asp:TextBox ID="txtCommSubBrCashBSENum" runat="server" CssClass="txtField"></asp:TextBox>
                                <span id="Span499" class="spnRequiredField">*</span>
                                <asp:RequiredFieldValidator ID="txtCommSubBrCashBSENum_RequiredFieldValidator" ControlToValidate="txtCommSubBrCashBSENum"
                                    ValidationGroup="grpCommSubBrCash" ErrorMessage="<br />Please Enter BSE Number"
                                    Display="Dynamic" runat="server" CssClass="rfvPCG">
                                </asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr id="trCommSBCNse" runat="server">
                            <td class="leftField">
                                <asp:Label ID="Label799" runat="server" CssClass="FieldName" Text="SEBI Regn No. NSE No.:"></asp:Label>
                            </td>
                            <td class="rightField">
                                <asp:TextBox ID="txtCommSubBrCashNSENum" runat="server" CssClass="txtField"></asp:TextBox>
                                <span id="Span509" class="spnRequiredField">*</span>
                                <asp:RequiredFieldValidator ID="txtCommSubBrCashNSENum_RequiredFieldValidator" ControlToValidate="txtCommSubBrCashNSENum"
                                    ValidationGroup="grpCommSubBrCash" ErrorMessage="<br />Please Enter NSE Number"
                                    Display="Dynamic" runat="server" CssClass="rfvPCG">
                                </asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" class="SubmitCell">
                                <asp:Button ID="btnCommSubBrCash" runat="server" OnClick="btnCommSubBrCash_Click"
                                    Text="Submit" ValidationGroup="grpCommSubBrCash" CssClass="PCGButton" onmouseover="javascript:ChangeButtonCss('hover', 'ctrl_LOB_btnBrokerCash');"
                                    onmouseout="javascript:ChangeButtonCss('out', 'ctrl_LOB_btnBrokerCash');" />
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr id="CommoditiesSubBrokerDerivatives" runat="server">
                <td>
                    <table class="TableBackground" style="width: 100%; height: 225px;">
                        <tr>
                            <td colspan="2" class="HeaderCell">
                                <asp:Label ID="Label111" runat="server" CssClass="HeaderTextBig" Text="Commodities Sub Broker Derivative Details"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                &nbsp;
                            </td>
                        </tr>
                        <%-- <tr>
                        <td class="leftField">
                            <asp:Label ID="Label112" runat="server" CssClass="FieldName" Text="Broker Name:"></asp:Label>
                        </td>
                        <td class="rightField">
                            <asp:TextBox ID="txtCommSubBrDerBrokerName" runat="server" CssClass="txtField"></asp:TextBox>
                            <span id="Span70" class="spnRequiredField">*</span>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator65" ControlToValidate="txtCommSubBrDerBrokerName"
                                ValidationGroup="grpCommSubBrDer" ErrorMessage="<br />Please Enter Broker Name"
                                Display="Dynamic" runat="server" CssClass="rfvPCG">
                            </asp:RequiredFieldValidator>
                        </td>
                    </tr>--%><tr>
                        <td class="leftField">
                            <asp:Label ID="Label81" runat="server" CssClass="FieldName" Text="Broker Name:"></asp:Label>
                        </td>
                        <td class="rightField">
                            <asp:DropDownList ID="ddlCommDeriBrokerCde" runat="server" CssClass="cmbField">
                            </asp:DropDownList>
                            <span id="Span70" class="spnRequiredField">*</span>
                            <asp:CompareValidator ID="CommSubBrDerCompareValidator6" runat="server" ControlToValidate="ddlCommDeriBrokerCde"
                                ErrorMessage="Please select Broker Name" Operator="NotEqual" ValueToCompare="Select Broker Name"
                                CssClass="cvPCG"></asp:CompareValidator>
                        </td>
                    </tr>
                        <tr>
                            <td class="leftField">
                                <asp:Label ID="Label113" runat="server" CssClass="FieldName" Text="Identifier Type:"></asp:Label>
                            </td>
                            <td class="rightField">
                                <asp:DropDownList ID="ddlCommSubBrDerIdType" runat="server" AutoPostBack="True" Enabled="false"
                                    CssClass="cmbField">
                                    <asp:ListItem>BSE</asp:ListItem>
                                    <asp:ListItem>NSE</asp:ListItem>
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr id="trCommSBDBse" runat="server">
                            <td class="leftField">
                                <asp:Label ID="Label114" runat="server" CssClass="FieldName" Text="SEBI Regn No. BSE No.:"></asp:Label>
                            </td>
                            <td class="rightField">
                                <asp:TextBox ID="txtCommSubBrDerBSENum" runat="server" CssClass="txtField"></asp:TextBox>
                                <span id="Span71" class="spnRequiredField">*</span>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator66" ControlToValidate="txtCommSubBrDerBSENum"
                                    ValidationGroup="grpCommSubBrDer" ErrorMessage="<br />Please Enter BSE Number"
                                    Display="Dynamic" runat="server" CssClass="rfvPCG">
                                </asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr id="trCommSBDNse" runat="server">
                            <td class="leftField">
                                <asp:Label ID="Label115" runat="server" CssClass="FieldName" Text="SEBI Regn No. NSE No.:"></asp:Label>
                            </td>
                            <td class="rightField">
                                <asp:TextBox ID="txtCommSubBrDerNSENum" runat="server" CssClass="txtField"></asp:TextBox>
                                <span id="Span72" class="spnRequiredField">*</span>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator67" ControlToValidate="txtCommSubBrDerNSENum"
                                    ValidationGroup="grpCommSubBrDer" ErrorMessage="<br />Please Enter NSE Number"
                                    Display="Dynamic" runat="server" CssClass="rfvPCG">
                                </asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td class="leftField">
                                <asp:Label ID="Label116" runat="server" CssClass="FieldName" Text="License No.:"></asp:Label>
                            </td>
                            <td class="rightField">
                                <asp:TextBox ID="txtCommSubBrDerLicenseNum" runat="server" CssClass="txtField"></asp:TextBox>
                                <span id="Span73" class="spnRequiredField">*</span>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator68" ControlToValidate="txtCommSubBrDerLicenseNum"
                                    ValidationGroup="grpCommSubBrDer" ErrorMessage="<br />Please Enter the License Number"
                                    Display="Dynamic" runat="server" CssClass="rfvPCG">
                                </asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" class="SubmitCell">
                                <asp:Button ID="btnCommSubBrDer" runat="server" OnClick="btnCommSubBrDer_Click" Text="Submit"
                                    ValidationGroup="grpCommSubBrDer" CssClass="PCGButton" onmouseover="javascript:ChangeButtonCss('hover', 'ctrl_LOB_btnBrokerCash');"
                                    onmouseout="javascript:ChangeButtonCss('out', 'ctrl_LOB_btnBrokerCash');" />
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr id="CommoditiesRemissaryCash" runat="server">
                <td>
                    <table class="TableBackground" style="width: 100%; height: 225px;">
                        <tr>
                            <td colspan="2" class="HeaderCell">
                                <asp:Label ID="Label117" runat="server" CssClass="HeaderTextBig" Text="Commodities Remissary Cash Details"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                &nbsp;
                            </td>
                        </tr>
                        <tr>
                            <td class="leftField">
                                <asp:Label ID="Label118" runat="server" CssClass="FieldName" Text="Broker Name:"></asp:Label>
                            </td>
                            <td class="rightField">
                                <asp:DropDownList ID="ddlCommRemCashBrokerName" runat="server" CssClass="cmbField">
                                </asp:DropDownList>
                                <span id="Span74" class="spnRequiredField">*</span>
                                <asp:CompareValidator ID="CommRemCashCompareValidator7" runat="server" ControlToValidate="ddlCommRemCashBrokerName"
                                    ErrorMessage="Please select a Broker Name" Operator="NotEqual" ValueToCompare="Select Broker Name"
                                    CssClass="cvPCG"></asp:CompareValidator>
                            </td>
                        </tr>
                        <tr>
                            <td class="leftField">
                                <asp:Label ID="Label119" runat="server" CssClass="FieldName" Text="Identifier Type:"></asp:Label>
                            </td>
                            <td class="rightField">
                                <asp:DropDownList ID="ddlCommRemissCashIdType" runat="server" AutoPostBack="True"
                                    Enabled="false" CssClass="cmbField">
                                    <asp:ListItem>BSE</asp:ListItem>
                                    <asp:ListItem>NSE</asp:ListItem>
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr id="trCommRCBse" runat="server">
                            <td class="leftField">
                                <asp:Label ID="Label120" runat="server" CssClass="FieldName" Text="SEBI Regn No. BSE No.:"></asp:Label>
                            </td>
                            <td class="rightField">
                                <asp:TextBox ID="txtCommRemissCashBSENum" runat="server" CssClass="txtField"></asp:TextBox>
                                <span id="Span75" class="spnRequiredField">*</span>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator70" ControlToValidate="txtCommRemissCashBSENum"
                                    ValidationGroup="grpCommRemissBrCash" ErrorMessage="<br />Please Enter BSE Number"
                                    Display="Dynamic" runat="server" CssClass="rfvPCG">
                                </asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr id="trCommRCNse" runat="server">
                            <td class="leftField">
                                <asp:Label ID="Label121" runat="server" CssClass="FieldName" Text="SEBI Regn No. NSE No.:"></asp:Label>
                            </td>
                            <td class="rightField">
                                <asp:TextBox ID="txtCommRemissCashNSENum" runat="server" CssClass="txtField"></asp:TextBox>
                                <span id="Span76" class="spnRequiredField">*</span>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator71" ControlToValidate="txtCommRemissCashNSENum"
                                    ValidationGroup="grpCommRemissBrCash" ErrorMessage="<br />Please Enter NSE Number"
                                    Display="Dynamic" runat="server" CssClass="rfvPCG">
                                </asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" class="SubmitCell">
                                <asp:Button ID="btnCommRemissCash" runat="server" OnClick="btnCommRemissCash_Click"
                                    Text="Submit" ValidationGroup="grpCommRemissBrCash" CssClass="PCGButton" onmouseover="javascript:ChangeButtonCss('hover', 'ctrl_LOB_btnBrokerCash');"
                                    onmouseout="javascript:ChangeButtonCss('out', 'ctrl_LOB_btnBrokerCash');" />
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr id="CommoditiesRemissaryDerivatives" runat="server">
                <td>
                    <table class="TableBackground" style="width: 82%; height: 238px;">
                        <tr>
                            <td colspan="2" class="HeaderCell">
                                <asp:Label ID="Label122" runat="server" CssClass="HeaderTextBig" Text="Commodities Remissary Derivative Details"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                &nbsp;
                            </td>
                        </tr>
                        <tr>
                            <td class="leftField">
                                <asp:Label ID="Label123" runat="server" CssClass="FieldName" Text="Broker Name:"></asp:Label>
                            </td>
                            <td class="rightField">
                                <asp:DropDownList ID="ddlCommRemDerBrokerName" runat="server" CssClass="cmbField">
                                </asp:DropDownList>
                                <span id="Span77" class="spnRequiredField">*</span>
                                <asp:CompareValidator ID="CommRemDerCompareValidator7" runat="server" ControlToValidate="ddlCommRemDerBrokerName"
                                    ErrorMessage="Please select a Broker Name" Operator="NotEqual" ValueToCompare="Select Broker Name"
                                    CssClass="cvPCG"></asp:CompareValidator>
                            </td>
                        </tr>
                        <tr>
                            <td class="leftField">
                                <asp:Label ID="Label124" runat="server" CssClass="FieldName" Text="Identifier Type:"></asp:Label>
                            </td>
                            <td class="rightField">
                                <asp:DropDownList ID="ddlCommRemissIdType" runat="server" AutoPostBack="True" Enabled="false"
                                    CssClass="cmbField">
                                    <asp:ListItem>BSE</asp:ListItem>
                                    <asp:ListItem>NSE</asp:ListItem>
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr id="trCommRDBse" runat="server">
                            <td class="leftField">
                                <asp:Label ID="Label949" runat="server" CssClass="FieldName" Text="SEBI Regn No. BSE No.:"></asp:Label>
                            </td>
                            <td class="rightField">
                                <asp:TextBox ID="txtCommRemissDerBSENum" runat="server" CssClass="txtField"></asp:TextBox>
                                <span id="Span599" class="spnRequiredField">*</span>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator549" ControlToValidate="txtCommRemissDerBSENum"
                                    ValidationGroup="grpCommRemissDer" ErrorMessage="<br />Please Enter BSE Number"
                                    Display="Dynamic" runat="server" CssClass="rfvPCG">
                                </asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr id="trCommRDNse" runat="server">
                            <td class="leftField">
                                <asp:Label ID="Label959" runat="server" CssClass="FieldName" Text="SEBI Regn No. NSE No.:"></asp:Label>
                            </td>
                            <td class="rightField">
                                <asp:TextBox ID="txtCommRemissDerNSENum" runat="server" CssClass="txtField"></asp:TextBox>
                                <span id="Span609" class="spnRequiredField">*</span>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator559" ControlToValidate="txtCommRemissDerNSENum"
                                    ValidationGroup="grpCommRemissDer" ErrorMessage="<br />Please Enter NSE Number"
                                    Display="Dynamic" runat="server" CssClass="rfvPCG">
                                </asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td class="leftField">
                                <asp:Label ID="Label969" runat="server" CssClass="FieldName" Text="License No.:"></asp:Label>
                            </td>
                            <td class="rightField">
                                <asp:TextBox ID="txtCommRemissDerLicenseNum" runat="server" CssClass="txtField"></asp:TextBox>
                                <span id="Span619" class="spnRequiredField">*</span>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator569" ControlToValidate="txtCommRemissDerLicenseNum"
                                    ValidationGroup="grpCommRemissDer" ErrorMessage="<br />Please Enter the License Number"
                                    Display="Dynamic" runat="server" CssClass="rfvPCG">
                                </asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" class="SubmitCell">
                                <asp:Button ID="btnCommRemissDer" runat="server" OnClick="btnCommRemissDer_Click"
                                    Text="Submit" ValidationGroup="grpCommRemissDer" CssClass="PCGButton" onmouseover="javascript:ChangeButtonCss('hover', 'ctrl_LOB_btnBrokerCash');"
                                    onmouseout="javascript:ChangeButtonCss('out', 'ctrl_LOB_btnBrokerCash');" />
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
        <div id="login" runat="server" class="SubmitCell">
        </div>
    </ContentTemplate>
</asp:UpdatePanel>