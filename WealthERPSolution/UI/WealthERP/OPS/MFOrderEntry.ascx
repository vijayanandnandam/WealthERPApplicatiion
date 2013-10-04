﻿<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="MFOrderEntry.ascx.cs"
    Inherits="WealthERP.OPS.MFOrderEntry" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>
<asp:ScriptManager ID="scrptMgr" runat="server">
    <%--<Services>
        <asp:ServiceReference Path="~/CustomerPortfolio/AutoComplete.asmx" />
    </Services>--%>
</asp:ScriptManager>

<script type="text/javascript" language="javascript">

    function GetCustomerId(source, eventArgs) {
        isItemSelected = true;
        //         document.getElementById("lblgetPan").innerHTML = "";
        document.getElementById("<%= txtCustomerId.ClientID %>").value = eventArgs.get_value();

        return false;
    }

    //    function GetAplicationNo(source, eventArgs) {
    //        isItemSelected = true;
    //        //         document.getElementById("lblgetPan").innerHTML = "";
    //        document.getElementById("<%= hdnAplicationNo.ClientID %>").value = eventArgs.get_value();

    //        return false;
    //    }

    function CheckPanno() {
        //        var Val, val1;
        //        Val = document.getElementById("<%= txtPansearch.ClientID %>").value;

        //        if (Val != "") {
        //            val1 = document.getElementById("<%= lblgetcust.ClientID %>").value;
        //            if (val1 == "") {
        //                document.getElementById("<%= txtPansearch.ClientID %>").Focus();
        //            }
        //        }


    }


    function ValidateAssociateName() {
        //        var x = document.forms["form1"]["TextBoxName"].value;
        document.getElementById("<%=  lblAssociatetext.ClientID %>").value = eventArgs.get_value();
        document.getElementById("lblAssociatetext").innerHTML = "AgentCode Required";
        return true;
    }

    function openpopupAddCustomer() {
        window.open('PopUp.aspx?AddMFCustLinkId=mf&pageID=CustomerType&', 'mywindow', 'width=750,height=500,scrollbars=yes,location=no')
        return false;
    }

    
   
</script>

<script type="text/javascript">

    var isItemSelected = false;

    //Handler for textbox blur event
    function checkItemSelected(txtPanNumber) {
        var returnValue = true;
        if (!isItemSelected) {

            if (txtPanNumber.value != "") {
                txtPanNumber.focus();
                alert("Please select Pan Number from the Pan list only");
                txtPanNumber.value = "";
                returnValue = false;
            }
        }
        return returnValue;



    }
    
</script>

<script type="text/javascript" language="javascript">

    function openpopupAddBank() {
        window.open('PopUp.aspx?PageId=AddBankAccount', 'mywindow', 'width=750,height=500,scrollbars=yes,location=no')
        return false;

        //        document.getElementById("<%= HiddenField1.ClientID %>").value = 1;

    }





    //    function closepopupAddBank() {
    //        window.close('PopUp.aspx?PageId=CustomerType', 'mywindow', 'width=750,height=500,scrollbars=yes,location=no')
    //        return false;
    ////     window.close('
    ////    for (var i = 0; i < popups.length; i++) {
    ////        popups[i].close();
    //    }
</script>

<script type="text/javascript">
    function CustomerValidate(type) {
        if (type == 'pdf') {
            window.document.forms[0].target = '_blank';
            window.document.forms[0].action = "/Reports/Display.aspx?mail=2";
        } else if (type == 'doc') {
            window.document.forms[0].target = '_blank';
            window.document.forms[0].action = "/Reports/Display.aspx?mail=4";
        }
        else if (type == 'View') {
            window.document.forms[0].target = '_blank';
            window.document.forms[0].action = "/Reports/Display.aspx?mail=0";
        }
        else {
            window.document.forms[0].target = '_blank';
            window.document.forms[0].action = "/Reports/Display.aspx?mail=3";
        }

        setTimeout(function() {
            window.document.forms[0].target = '';
            window.document.forms[0].action = "ControlHost.aspx?pageid=OrderEntry";
        }, 500);
        return true;

    }
    function ShowIsa() {

        var hdn = document.getElementById("<%=hdnIsSubscripted.ClientID%>").value;

        //        if (hdn == "True") {

        //            document.getElementById("<%= trIsa.ClientID %>").style.visibility = 'visible';
        //            document.getElementById("<%= trJointHoldersList.ClientID %>").style.visibility = 'visible';

        //        }
        //        else {
        //            document.getElementById("<%= trIsa.ClientID %>").style.visibility = 'collapse';
        //            document.getElementById("<%= trJointHoldersList.ClientID %>").style.visibility = 'collapse';

        //        }

    }
    function ShowInitialIsa() {

        //        document.getElementById("<%= trIsa.ClientID %>").style.visibility = 'collapse';
        //        document.getElementById("<%= trJointHoldersList.ClientID %>").style.visibility = 'collapse';

    }
    function CheckSubscription() {

        document.getElementById("<%= trIsa.ClientID %>").style.visibility = 'visible';
        document.getElementById("<%= trJointHoldersList.ClientID %>").style.visibility = 'collapse';
    }
</script>

<script type="text/javascript">

    var isValidFolio = false;
    function GetSchemeCode(source, eventArgs) {

        document.getElementById("<%= txtSchemeCode.ClientID %>").value = eventArgs.get_value();

        return false;
    };
    function GetSwitchSchemeCode(source, eventArgs) {

        document.getElementById("<%= txtSwitchSchemeCode.ClientID %>").value = eventArgs.get_value();

        return false;
    };

    function GetFolioAccount(source, eventArgs) {
        isValidFolio = true;
        document.getElementById("<%= hidFolioNumber.ClientID %>").value = eventArgs.get_value();

        return false;
    };

    function ValidateFolioSelection(txtFolioNuber) {

        var returnValue = true;
        if (!isValidFolio) {

            if (txtFolioNuber.value != "") {
                txtFolioNuber.focus();
                alert("Please select valid folio");
                txtFolioNuber.value = "";
                returnValue = false;
            }
        } else {
            if (txtFolioNuber.value != "")
                alert("Valid folio found");
        }
        return returnValue;


    }

</script>

<script type="text/javascript">
    function checkFolioDuplicate() {
        $("#<%= hidValidCheck.ClientID %>").val("0");
        alert("here..");
        if ($("#<%=txtFolioNumber.ClientID %>").val() == "") {
            $("#spnExistingFolio").html("");
            alert("here-null");
            return;
        }
        $("#spnExistingFolio").html("<img src='Images/loader.gif' />");
        alert("here1");
        $.ajax({
            type: "POST",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            url: "ControlHost.aspx/CheckFolioDuplicate",
            data: "{ 'customerId': '" + $("#<%=txtCustomerId.ClientID %>").val() + "','folioNumber': '" + $("#<%=txtFolioNumber.ClientID %>").val() + "' }",
            error: function(xhr, status, error) {
                //                alert("Please select AMC!");
            },
            success: function(msg) {

                if (msg.d) {

                    $("#<%= hidValidCheck.ClientID %>").val("1");
                    $("#spnExistingFolio").html("");
                    alert("here-sucess");
                }
                else {


                    $("#<%= hidValidCheck.ClientID %>").val("0");
                    $("#spnExistingFolio").removeClass();
                    alert("Folio Number Already Exists!");
                    return false;
                }
            }

        });
    }
   
</script>

<telerik:RadWindow ID="radwindowPopup" runat="server" VisibleOnPageLoad="false" Height="30%"
    Width="400px" Modal="true" BackColor="#DADADA" VisibleStatusbar="false" Behaviors="None"
    Title="Add New Folio">
    <ContentTemplate>
        <div style="padding: 20px">
            <table width="100%">
                <tr>
                    <td class="leftField" style="width: 10%">
                        <asp:Label ID="lblAMCName" runat="server" Text="AMC Name: " CssClass="FieldName"></asp:Label>
                    </td>
                    <td class="rightField" style="width: 25%">
                        <asp:Label ID="lblFolioAMC" runat="server" Text="" CssClass="FieldName"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="leftField" style="width: 10%">
                        <asp:Label ID="lblFolioNo" runat="server" Text="Folio Number: " CssClass="FieldName"></asp:Label>
                    </td>
                    <td class="rightField" style="width: 25%">
                        <asp:TextBox ID="txtNewFolio" runat="server" CssClass="txtField"></asp:TextBox><br />
                        <span id="spnNewFolioValidation"></span>
                        <asp:RequiredFieldValidator ID="rfvName" ControlToValidate="txtNewFolio" ErrorMessage="Please enter folio name"
                            ValidationGroup="vgOK" Display="Dynamic" runat="server" CssClass="rfvPCG">
                        </asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td class="leftField" style="width: 10%">
                        <asp:Button ID="btnSubmitFolio" runat="server" Text="Submit" CssClass="PCGButton"
                            OnClick="btnOk_Click" ValidationGroup="vgOK" />
                    </td>
                    <td class="rightField" style="width: 25%">
                        <asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="PCGButton" CausesValidation="false"
                            OnClick="btnCancel_Click" />
                    </td>
                </tr>
            </table>
        </div>
    </ContentTemplate>
</telerik:RadWindow>
<table width="100%">
    <tr>
        <td colspan="5">
            <div class="divPageHeading">
                <table cellspacing="0" cellpadding="3" width="100%">
                    <tr>
                        <td align="left">
                            MF Order Entry
                        </td>
                        <td align="right">
                            <asp:LinkButton ID="lnkBtnEdit" runat="server" CssClass="LinkButtons" Text="Edit"
                                OnClick="lnkBtnEdit_Click"></asp:LinkButton>
                            &nbsp; &nbsp;
                            <asp:LinkButton runat="server" ID="lnlBack" CssClass="LinkButtons" Text="Back" Visible="false"
                                OnClick="lnlBack_Click"></asp:LinkButton>&nbsp; &nbsp;
                            <asp:LinkButton runat="server" ID="lnkDelete" CssClass="LinkButtons" Text="Delete"
                                OnClick="lnkDelete_Click" OnClientClick="javascript: return confirm('Are you sure you want to Delete the Order?')"></asp:LinkButton>&nbsp;
                            &nbsp;
                            <asp:Button ID="btnViewReport" runat="server" PostBackUrl="~/Reports/Display.aspx?mail=0"
                                CssClass="CrystalButton" ValidationGroup="MFSubmit" OnClientClick="return CustomerValidate('View')" />&nbsp;&nbsp;
                            <div id="div1" style="display: none;">
                                <p class="tip">
                                    Click here to view order details.
                                </p>
                            </div>
                            <asp:Button ID="btnViewInPDF" runat="server" ValidationGroup="MFSubmit" OnClientClick="return CustomerValidate('pdf')"
                                PostBackUrl="~/Reports/Display.aspx?mail=2" CssClass="PDFButton" />&nbsp;&nbsp;
                            <asp:Button ID="btnreport" runat="server" CssClass="CrystalButton" Visible="false"
                                OnClick="btnreport_Click" />
                            <asp:Button ID="btnpdfReport" runat="server" CssClass="PDFButton" Visible="false"
                                OnClick="btnpdfReport_Click" />
                            <div id="div2" style="display: none;">
                                <p class="tip">
                                    Click here to view order details.
                                </p>
                            </div>
                            <asp:Button ID="btnViewInDOC" runat="server" ValidationGroup="MFSubmit" CssClass="DOCButton"
                                OnClientClick="return CustomerValidate('doc')" PostBackUrl="~/Reports/Display.aspx?mail=4" />
                            <div id="div3" style="display: none;">
                                <p class="tip">
                                    Click here to view order details in word doc.</p>
                            </div>
                            <asp:Button ID="btnViewInPDFNew" runat="server" ValidationGroup="MFSubmit" CssClass="PDFButton"
                                Visible="false" OnClientClick="return CustomerValidate('pdf')" PostBackUrl="~/Reports/Display.aspx?mail=2" />
                            <asp:Button ID="btnViewInDOCNew" runat="server" ValidationGroup="MFSubmit" CssClass="DOCButton"
                                Visible="false" OnClientClick="return CustomerValidate('doc')" PostBackUrl="~/Reports/Display.aspx?mail=4" />
                        </td>
                    </tr>
                </table>
            </div>
        </td>
    </tr>
    <tr>
        <td colspan="5">
        </td>
    </tr>
    <tr>
        <td colspan="5">
        </td>
    </tr>
    <tr>
        <td colspan="5">
            <div class="divSectionHeading" style="vertical-align: text-bottom">
                Customer Details
                
            </div>
        </td>
    </tr>
    <tr>
        <td colspan="6">
        </td>
    </tr>
    <tr>
        <td class="leftField" style="width: 20%">
            <asp:Label ID="lblsearch" runat="server" CssClass="FieldName" Text="Search for"></asp:Label>
        </td>
        <td class="rightField" style="width: 20%">
            <asp:DropDownList ID="ddlsearch" runat="server" CssClass="cmbField" OnSelectedIndexChanged="ddlsearch_Selectedindexchanged"
                AutoPostBack="true">
                <asp:ListItem Text="Select" Value="0"></asp:ListItem>
                <asp:ListItem Text="Customer" Value="1"></asp:ListItem>
                <asp:ListItem Text="Pan" Value="2"></asp:ListItem>
            </asp:DropDownList>
        </td>
        <td class="leftField" style="width: 20%">
            <asp:Label ID="lblARNNo" runat="server" CssClass="FieldName" Text="ARN No:"></asp:Label>
        </td>
        <td class="rightField" style="width: 20%">
            <asp:DropDownList ID="ddlARNNo" runat="server" CssClass="cmbField" AutoPostBack="false">
            </asp:DropDownList>
            <span id="Span14" class="spnRequiredField">*</span>
            <asp:CompareValidator ID="CompareValidator12" runat="server" ControlToValidate="ddlARNNo"
                CssClass="cvPCG" Display="Dynamic" ErrorMessage="<br />Please select an ARN"
                Operator="NotEqual" ValidationGroup="MFSubmit" ValueToCompare="Select"></asp:CompareValidator>
        </td>
        <td colspan="2">
        </td>
    </tr>
    <tr id="trpan" runat="server">
        <td class="leftField" style="width: 20%">
            <asp:Label ID="lblPansearch" runat="server" Text="Pan Number: " CssClass="FieldName"></asp:Label>
        </td>
        <td class="rightField" style="width: 20%">
            <asp:TextBox ID="txtPansearch" runat="server" CssClass="txtField" AutoComplete="Off"
                AutoPostBack="True" onclientClick="ShowIsa()" onblur="return checkItemSelected(this)"
                OnTextChanged="OnAssociateTextchanged1">
            </asp:TextBox><span id="Span1" class="spnRequiredField">*</span>
            <%--<asp:Button ID="btnAddCustomer" runat="server" Text="Add a Customer" CssClass="PCGMediumButton"
                CausesValidation="true" onmouseover="javascript:ChangeButtonCss('hover', 'ctrl_OrderEntry_btnAddCustomer','S');"
                onmouseout="javascript:ChangeButtonCss('out', 'ctrl_OrderEntry_btnAddCustomer','S');"
                OnClientClick="return openpopupAddCustomer()" 
                onclick="btnAddCustomer_Click" />--%>
            <cc1:TextBoxWatermarkExtender ID="TextBoxWatermarkExtender1" TargetControlID="txtPansearch"
                WatermarkText="Enter few chars of Pan" runat="server" EnableViewState="false">
            </cc1:TextBoxWatermarkExtender>
            <ajaxToolkit:AutoCompleteExtender ID="AutoCompleteExtender1" runat="server" TargetControlID="txtPansearch"
                ServiceMethod="GetAdviserCustomerPan" ServicePath="~/CustomerPortfolio/AutoComplete.asmx"
                MinimumPrefixLength="1" EnableCaching="False" CompletionSetCount="1" CompletionInterval="0"
                CompletionListCssClass="AutoCompleteExtender_CompletionList" CompletionListItemCssClass="AutoCompleteExtender_CompletionListItem"
                CompletionListHighlightedItemCssClass="AutoCompleteExtender_HighlightedItem"
                UseContextKey="True" OnClientItemSelected="GetCustomerId" DelimiterCharacters=""
                Enabled="True" />
            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" ControlToValidate="txtPansearch"
                ErrorMessage="<br />Please Enter Pan number" Display="Dynamic" runat="server"
                CssClass="rfvPCG" ValidationGroup="MFSubmit"></asp:RequiredFieldValidator>
        </td>
        <td class="leftField" style="width: 20%">
            <asp:Label ID="label2" runat="server" Text="Customer Name: " CssClass="FieldName"></asp:Label>
        </td>
        <td class="rightField" style="width: 20%">
            <asp:Label ID="lblgetcust" runat="server" Text="" CssClass="FieldName" onclientClick="CheckPanno()"></asp:Label>
        </td>
        <td colspan="2">
        </td>
    </tr>
    <tr id="trCust" runat="server">
        <td class="leftField" style="width: 20%">
            <asp:Label ID="lblCustomer" runat="server" Text="Customer Name: " CssClass="FieldName"></asp:Label>
        </td>
        <td class="rightField" style="width: 20%">
            <asp:TextBox ID="txtCustomerName" runat="server" CssClass="txtField" AutoComplete="Off"
                onclientClick="ShowIsa()" AutoPostBack="True">
            
                 
                   <%--   onblur="return checkItemSelected(this)"--%>
            </asp:TextBox><span id="spnCustomer" class="spnRequiredField">*</span>
            <%--<asp:Button ID="btnAddCustomer" runat="server" Text="Add a Customer" CssClass="PCGMediumButton"
                CausesValidation="true" onmouseover="javascript:ChangeButtonCss('hover', 'ctrl_OrderEntry_btnAddCustomer','S');"
                onmouseout="javascript:ChangeButtonCss('out', 'ctrl_OrderEntry_btnAddCustomer','S');"
                OnClientClick="return openpopupAddCustomer()" 
                onclick="btnAddCustomer_Click" />--%>
            <asp:ImageButton ID="btnImgAddCustomer" ImageUrl="~/App_Themes/Maroon/Images/user_add.png"
                AlternateText="Add" runat="server" ToolTip="Click here to Add Customer" OnClientClick="return openpopupAddCustomer()"
                Height="15px" Width="15px"></asp:ImageButton>
            <cc1:TextBoxWatermarkExtender ID="txtCustomer_water" TargetControlID="txtCustomerName"
                WatermarkText="Enter few chars of Customer" runat="server" EnableViewState="false">
            </cc1:TextBoxWatermarkExtender>
            <ajaxToolkit:AutoCompleteExtender ID="txtCustomerName_autoCompleteExtender" runat="server"
                TargetControlID="txtCustomerName" ServiceMethod="GetCustomerName" ServicePath="~/CustomerPortfolio/AutoComplete.asmx"
                MinimumPrefixLength="1" EnableCaching="False" CompletionSetCount="5" CompletionInterval="100"
                CompletionListCssClass="AutoCompleteExtender_CompletionList" CompletionListItemCssClass="AutoCompleteExtender_CompletionListItem"
                CompletionListHighlightedItemCssClass="AutoCompleteExtender_HighlightedItem"
                UseContextKey="True" OnClientItemSelected="GetCustomerId" DelimiterCharacters=""
                Enabled="True" />
            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" ControlToValidate="txtCustomerName"
                ErrorMessage="<br />Please Enter Customer Name" Display="Dynamic" runat="server"
                CssClass="rfvPCG" ValidationGroup="Submit"></asp:RequiredFieldValidator>
        </td>
        <td class="leftField" style="width: 20%">
            <asp:Label ID="lblPan" runat="server" Text="PAN No: " CssClass="FieldName"></asp:Label>
        </td>
        <td class="rightField" style="width: 20%">
            <asp:Label ID="lblgetPan" runat="server" Text="" CssClass="FieldName"></asp:Label>
        </td>
        <td class="leftField" style="width: 20%">
            <asp:Label ID="lblRM" runat="server" Text="RM: " CssClass="FieldName"></asp:Label>
        </td>
        <td class="rightField" style="width: 20%">
            <asp:Label ID="lblGetRM" runat="server" Text="" CssClass="FieldName"></asp:Label>
        </td>
    </tr>
    <tr>
        <td class="leftField" style="width: 20%">
            <asp:Label ID="lblBranch" runat="server" Text="Branch: " CssClass="FieldName"></asp:Label>
        </td>
        <td class="rightField" style="width: 20%">
            <asp:Label ID="lblGetBranch" runat="server" Text="" CssClass="FieldName"></asp:Label>
        </td>
        <td colspan="4">
        </td>
    </tr>
    <tr>
        <td class="leftField" style="width: 20%">
            <asp:Label ID="lblAssociateSearch" runat="server" CssClass="FieldName" Text="Agent Code:"></asp:Label>
        </td>
        <td class="rightField" style="width: 20%">
            <asp:TextBox ID="txtAssociateSearch" runat="server" CssClass="txtField" AutoComplete="Off"
                OnTextChanged="OnAssociateTextchanged" AutoPostBack="True">
            </asp:TextBox><span id="Span7" class="spnRequiredField">*</span>
            <cc1:TextBoxWatermarkExtender ID="TextBoxWatermarkExtender2" TargetControlID="txtAssociateSearch"
                WatermarkText="Enter few chars of Agent code" runat="server" EnableViewState="false">
            </cc1:TextBoxWatermarkExtender>
            <ajaxToolkit:AutoCompleteExtender ID="AutoCompleteExtender2" runat="server" TargetControlID="txtAssociateSearch"
                ServiceMethod="GetCustomerName" ServicePath="~/CustomerPortfolio/AutoComplete.asmx"
                MinimumPrefixLength="1" EnableCaching="False" CompletionSetCount="5" CompletionInterval="100"
                CompletionListCssClass="AutoCompleteExtender_CompletionList" CompletionListItemCssClass="AutoCompleteExtender_CompletionListItem"
                CompletionListHighlightedItemCssClass="AutoCompleteExtender_HighlightedItem"
                UseContextKey="True" DelimiterCharacters="" Enabled="True" />
            <%--  OnClientItemSelected="CheckPanno"--%>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" ControlToValidate="txtAssociateSearch"
                ErrorMessage="<br />Please Enter a agent code" Display="Dynamic" runat="server"
                CssClass="rfvPCG" ValidationGroup="MFSubmit"></asp:RequiredFieldValidator>
        </td>
        <td class="leftField" style="width: 20%">
            <asp:Label ID="lblAssociate" runat="server" CssClass="FieldName" Text="Associate:"></asp:Label>
        </td>
        <td class="rightField" style="width: 20%">
            <asp:Label ID="lblAssociatetext" runat="server" CssClass="FieldName" Enabled="false"></asp:Label>
        </td>
        <%--<td class="rightField" style="width: 20%">
            <asp:DropDownList ID="ddlAssociate" runat="server" CssClass="cmbLongField" AutoPostBack="false">
            </asp:DropDownList>
            <asp:CompareValidator ID="ddlAssociate_CompareValidator2" runat="server" ControlToValidate="ddlAssociate"
                CssClass="cvPCG" Display="Dynamic" ErrorMessage="<br />Please select a associate"
                Operator="NotEqual" ValidationGroup="MFSubmit" ValueToCompare="Select(SubBroker Code/Name/Type)"></asp:CompareValidator>
        </td>--%>
    </tr>
    <tr id="trIsa" runat="server">
        <td class="leftField" style="width: 20%">
            <asp:Label ID="lblIsa" runat="server" CssClass="FieldName" Text="ISA No:"></asp:Label>
        </td>
        <td>
            <asp:DropDownList ID="ddlCustomerISAAccount" runat="server" CssClass="cmbField" AutoPostBack="true"
                OnSelectedIndexChanged="ddlCustomerISAAccount_SelectedIndexChanged">
            </asp:DropDownList>
            &nbsp
            <asp:ImageButton ID="btnIsa" ImageUrl="~/App_Themes/Maroon/Images/user_add.png" AlternateText="Add"
                runat="server" ToolTip="Click here to Request ISA" OnClick="ISA_Onclick" Height="15px"
                Width="15px"></asp:ImageButton>
        </td>
        <td class="rightField" style="width: 20%">
        </td>
        <td class="rightField" style="width: 20%">
        </td>
    </tr>
    <%-- <tr id="trRegretMsg" runat="server">
        <td class="leftField" style="width: 20%">
            <asp:Label ID="lblRegretMsg" runat="server" CssClass="FieldName" Text="ISA not Created for this Adviser"></asp:Label>
        </td>
        <td style="width: 20%">
            <%--<asp:Button ID="btnIsa" runat="server" CssClass="PCGLongButton" OnClick="ISA_Onclick"
                Text="Request ISA Account" />
        </td>
        <td style="width: 20%">
        </td>
        <td style="width: 20%">
        </td>
        <td style="width: 20%">
        
        </td> 
    </tr>--%>
    <tr id="trJointHoldersList" runat="server">
        <td class="leftField" style="width: 20%">
        </td>
        <td colspan="5">
            <%-- <asp:Panel ID="pnlJointholders" runat="server" ScrollBars="Horizontal">--%>
            <telerik:RadGrid ID="gvJointHoldersList" Height="70px" runat="server" GridLines="None"
                AutoGenerateColumns="False" Width="45%" PageSize="4" AllowSorting="false" AllowPaging="True"
                ShowStatusBar="True" ShowFooter="true" Skin="Telerik" EnableEmbeddedSkins="false"
                AllowFilteringByColumn="false" AllowAutomaticInserts="false" ExportSettings-FileName="Count">
                <MasterTableView Width="100%" AllowMultiColumnSorting="false" AutoGenerateColumns="false"
                    CommandItemDisplay="None">
                    <Columns>
                        <telerik:GridBoundColumn DataField="AccountNumber" HeaderText="Account Number" UniqueName="AccountNumber"
                            SortExpression="Account Number">
                            <ItemStyle HorizontalAlign="left" Wrap="false" VerticalAlign="Top" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="Customer" HeaderText="Customer" AllowFiltering="false"
                            HeaderStyle-HorizontalAlign="Left" UniqueName="Customer">
                            <ItemStyle HorizontalAlign="Left" Wrap="false" VerticalAlign="Top" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="ModeOfHolding" HeaderText="Mode Of Holding" AllowFiltering="false"
                            HeaderStyle-HorizontalAlign="Left" UniqueName="ModeOfHolding">
                            <ItemStyle HorizontalAlign="Left" Wrap="false" VerticalAlign="Top" />
                        </telerik:GridBoundColumn>
                    </Columns>
                </MasterTableView>
                <ClientSettings>
                    <Selecting AllowRowSelect="True" EnableDragToSelectRows="True" />
                </ClientSettings>
            </telerik:RadGrid>
            <%-- </asp:Panel>  --%>
        </td>
        <%--<td></td>
   <td></td>
   <td></td>
   <td></td>--%>
    </tr>
    <tr>
        <td colspan="5">
        </td>
    </tr>
    <tr>
        <td colspan="5">
            <div class="divSectionHeading" style="vertical-align: text-bottom">
                Order Details
            </div>
        </td>
    </tr>
    <tr>
        <td colspan="5">
        </td>
    </tr>
    <tr id="trTransactionType" runat="server">
        <td class="leftField" style="width: 20%">
            <asp:Label ID="ddlTransactionType" runat="server" Text="Transaction Type: " CssClass="FieldName"></asp:Label>
        </td>
        <td class="rightField" style="width: 20%">
            <asp:DropDownList ID="ddltransType" runat="server" CssClass="cmbField" AutoPostBack="true"
                OnSelectedIndexChanged="ddltransType_SelectedIndexChanged">
                <asp:ListItem Text="Select" Value="Select" Selected="true"></asp:ListItem>
                <asp:ListItem Text="New Purchase" Value="BUY"></asp:ListItem>
                <asp:ListItem Text="Additional Purchase" Value="ABY"></asp:ListItem>
                <asp:ListItem Text="Redemption" Value="Sel"></asp:ListItem>
                <asp:ListItem Text="SIP" Value="SIP"></asp:ListItem>
                <asp:ListItem Text="SWP" Value="SWP"></asp:ListItem>
                <asp:ListItem Text="STP" Value="STB"></asp:ListItem>
                <asp:ListItem Text="Switch" Value="SWB"></asp:ListItem>
                <asp:ListItem Text="Change Of Address Form" Value="CAF"></asp:ListItem>
            </asp:DropDownList>
            <span id="spnTransType" class="spnRequiredField">*</span>
            <asp:CompareValidator ID="CVTrxType" runat="server" ControlToValidate="ddltransType"
                CssClass="cvPCG" Display="Dynamic" ErrorMessage="<br />Please select a transaction type"
                Operator="NotEqual" ValidationGroup="MFSubmit" ValueToCompare="Select"></asp:CompareValidator>
        </td>
        <td class="leftField" style="width: 30%">
            <asp:Label ID="lblReceivedDate" runat="server" Text="Application Received Date: "
                CssClass="FieldName"></asp:Label>
        </td>
        <td class="rightField" style="width: 10%">
            <telerik:RadDatePicker ID="txtReceivedDate" CssClass="txtField" runat="server" Culture="English (United States)"
                AutoPostBack="true" Skin="Telerik" EnableEmbeddedSkins="false" ShowAnimation-Type="Fade"
                MinDate="1900-01-01" OnSelectedDateChanged="txtReceivedDate_SelectedDateChanged">
                <Calendar UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x"
                    Skin="Telerik" EnableEmbeddedSkins="false">
                    <SpecialDays>
                        <%-- <telerik:RadCalendarDay Repeatable="Today" ItemStyle-BackColor="Red" />--%>
                    </SpecialDays>
                </Calendar>
                <DatePopupButton ImageUrl="" HoverImageUrl=""></DatePopupButton>
                <DateInput DisplayDateFormat="d/M/yyyy" DateFormat="d/M/yyyy">
                </DateInput>
            </telerik:RadDatePicker>
            <span id="Span7" class="spnRequiredField">*</span>
            <asp:RequiredFieldValidator ID="appRecidRequiredFieldValidator" ControlToValidate="txtReceivedDate"
                CssClass="rfvPCG" ErrorMessage="<br />Please select an Application received Date"
                Display="Dynamic" runat="server" InitialValue="" ValidationGroup="MFSubmit"></asp:RequiredFieldValidator>
           
            <%--  <asp:CompareValidator ID="CVReceivedDate" runat="server" ErrorMessage="<br/>Please enter a valid date."
                Type="Date" ControlToValidate="txtReceivedDate" CssClass="cvPCG" Operator="DataTypeCheck"
                ValidationGroup="MFSubmit" ValueToCompare="" Display="Dynamic"></asp:CompareValidator>
            <asp:CompareValidator ID="cvAppRcvDate" runat="server" ControlToValidate="txtReceivedDate"
                Display="Dynamic" CssClass="cvPCG" ValidationGroup="MFSubmit" ErrorMessage="<br />Application Received date must be less than or equal to Today"
                Operator="LessThanEqual" Type="Date"></asp:CompareValidator>--%>
        </td>
    </tr>
    <%--  <span id="Span7" class="spnRequiredField">*</span>--%>
    <%-- <asp:RequiredFieldValidator ID="RequiredFieldValidator3" ControlToValidate="txtReceivedDate"
                CssClass="rfvPCG" ErrorMessage="<br />Please select an Application received Date"
                Display="Dynamic" runat="server" InitialValue="" ValidationGroup="MFSubmit"></asp:RequiredFieldValidator>--%>
    <%-- </td>--%>
    <%--</tr>--%>
    <tr id="trARDate" runat="server">
        <td class="leftField" style="width: 20%">
            <asp:Label ID="lblApplicationNumber" runat="server" Text="Application Number:" CssClass="FieldName"></asp:Label>
        </td>
        <td class="rightField" style="width: 20%">
            <asp:TextBox ID="txtApplicationNumber" runat="server" CssClass="txtField"></asp:TextBox>
            <%--  <ajaxToolkit:AutoCompleteExtender ID="AutoCompleteExtender3" runat="server" TargetControlID="txtApplicationNumber"
                ServiceMethod="GetAplicationNOs" ServicePath="~/CustomerPortfolio/AutoComplete.asmx"
                MinimumPrefixLength="1" EnableCaching="False" CompletionSetCount="1" CompletionInterval="0"
                CompletionListCssClass="AutoCompleteExtender_CompletionList" CompletionListItemCssClass="AutoCompleteExtender_CompletionListItem"
                CompletionListHighlightedItemCssClass="AutoCompleteExtender_HighlightedItem"
                UseContextKey="True" OnClientItemSelected="GetAplicationNOs" DelimiterCharacters="" 
                Enabled="True" />--%>
            <%-- <asp:CompareValidator ID="CompareValidator6" runat="server" ControlToValidate="txtApplicationNumber"
                CssClass="cvPCG" ErrorMessage="<br />ApplicationNumber Exist"
                ValueToCompare="" Operator="Equal" Type="String"></asp:CompareValidator>--%>
        </td>
        <td class="leftField" style="width: 20%">
            <asp:Label ID="lblOrderDate" runat="server" Text="Order Date:" CssClass="FieldName"></asp:Label>
        </td>
        <td class="rightField" style="width: 30%">
            <telerik:RadDatePicker ID="txtOrderDate" CssClass="txtField" runat="server" Culture="English (United States)"
                Skin="Telerik" EnableEmbeddedSkins="false" ShowAnimation-Type="Fade" MinDate="1900-01-01"
                AutoPostBack="true" OnSelectedDateChanged="txtOrderDate_DateChanged">
                <Calendar UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x"
                    Skin="Telerik" EnableEmbeddedSkins="false">
                    <%-- <SpecialDays>
           <telerik:RadCalendarDay Repeatable="Today" ItemStyle-BackColor="Red" />
       </SpecialDays>--%>
                </Calendar>
                <DatePopupButton ImageUrl="" HoverImageUrl=""></DatePopupButton>
                <DateInput DisplayDateFormat="d/M/yyyy" DateFormat="d/M/yyyy">
                </DateInput>
            </telerik:RadDatePicker>
            <span id="Span6" class="spnRequiredField">*</span>
            <%--  <asp:CompareValidator ID="CompareValidator8" runat="server" ErrorMessage="<br/>Please enter a valid date."
                Type="Date" ControlToValidate="txtOrderDate" CssClass="cvPCG" Operator="DataTypeCheck"
                ValueToCompare="" Display="Dynamic"></asp:CompareValidator>--%>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator4" ControlToValidate="txtOrderDate"
                CssClass="rfvPCG" ErrorMessage="<br />Please select order date" Display="Dynamic"
                runat="server" InitialValue="" ValidationGroup="MFSubmit"></asp:RequiredFieldValidator>
           
        </td>
    </tr>
    <tr id="trAplNumber" runat="server">
        <td class="leftField" style="width: 20%">
            <asp:Label ID="lblAMC" runat="server" Text="AMC: " CssClass="FieldName"></asp:Label>
        </td>
        <td class="rightField" style="width: 20%">
            <asp:DropDownList ID="ddlAMCList" runat="server" CssClass="cmbLongField" AutoPostBack="true"
                OnSelectedIndexChanged="ddlAMCList_SelectedIndexChanged">
            </asp:DropDownList>
            <span id="spnAMC" runat="server" class="spnRequiredField">*</span>
            <asp:CompareValidator ID="CompareValidator1" runat="server" ControlToValidate="ddlAMCList"
                CssClass="cvPCG" Display="Dynamic" ErrorMessage="<br />Please select an AMC"
                Operator="NotEqual" ValidationGroup="MFSubmit" ValueToCompare="Select"></asp:CompareValidator>
        </td>
        <td class="leftField" style="width: 20%">
            <asp:Label ID="lblCategory" runat="server" Text="Category:" CssClass="FieldName"></asp:Label>
        </td>
        <td class="rightField" style="width: 20%">
            <asp:DropDownList ID="ddlCategory" runat="server" CssClass="cmbLongField" AutoPostBack="true"
                OnSelectedIndexChanged="ddlCategory_SelectedIndexChanged">
            </asp:DropDownList>
        </td>
    </tr>
    <tr id="trOrderDate" runat="server">
        <td class="leftField" style="width: 20%">
            <asp:Label ID="lblSearchScheme" runat="server" Text="Scheme:" CssClass="FieldName"></asp:Label>
        </td>
        <td colspan="3">
            <asp:HiddenField ID="txtSchemeCode" runat="server" OnValueChanged="txtSchemeCode_ValueChanged" />
            <asp:TextBox ID="txtSearchScheme" runat="server" Style="width: 300px;" CssClass="txtField"
                AutoComplete="Off" AutoPostBack="True">
            </asp:TextBox>
            <cc1:TextBoxWatermarkExtender ID="txtSearchScheme_TextBoxWatermarkExtender" runat="server"
                TargetControlID="txtSearchScheme" WatermarkText="Type the Scheme Name">
            </cc1:TextBoxWatermarkExtender>
            <ajaxToolkit:AutoCompleteExtender ID="txtSearchScheme_autoCompleteExtender" runat="server"
                TargetControlID="txtSearchScheme" ServicePath="~/CustomerPortfolio/AutoComplete.asmx"
                ServiceMethod="GetSchemeName" MinimumPrefixLength="1" EnableCaching="false" CompletionSetCount="1"
                CompletionInterval="1" CompletionListCssClass="AutoCompleteExtender_CompletionList"
                CompletionListItemCssClass="AutoCompleteExtender_CompletionListItem" CompletionListHighlightedItemCssClass="AutoCompleteExtender_HighlightedItem"
                UseContextKey="true" OnClientItemSelected="GetSchemeCode" />
            <span id="Span9" class="spnRequiredField" runat="server">*<br />
            </span>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator9" ControlToValidate="txtSearchScheme"
                CssClass="rfvPCG" ErrorMessage="<br />Please select Scheme" Display="Dynamic"
                runat="server" InitialValue="" ValidationGroup="MFSubmit"></asp:RequiredFieldValidator>
        </td>
    </tr>
    <tr id="Tr1" runat="server" visible="true">
        <td colspan="2">
        </td>
        <td class="leftField" style="width: 20%">
            <asp:Label ID="lblFolioNumber" runat="server" Text="Folio Number:" CssClass="FieldName"></asp:Label>
        </td>
        <td class="rightField" style="width: 20%">
            <asp:HiddenField ID="hidFolioNumber" runat="server" OnValueChanged="hidFolioNumber_ValueChanged" />
            <asp:TextBox ID="txtFolioNumber" runat="server" CssClass="txtField" onblur="return ValidateFolioSelection(this)"
                AutoPostBack="true">
            </asp:TextBox>
            <span id="spnExistingFolio"></span>
            <asp:ImageButton ID="imgFolioAdd" ImageUrl="~/App_Themes/Maroon/Images/user_add.png"
                AlternateText="Add" runat="server" ToolTip="Click here to Add folio" OnClick="btnOpenPopup_Click"
                Height="15px" Width="15px"></asp:ImageButton>
            <cc1:TextBoxWatermarkExtender ID="TextBoxWatermarkExtender3" runat="server" TargetControlID="txtFolioNumber"
                WatermarkText="Type the folio name">
            </cc1:TextBoxWatermarkExtender>
            <ajaxToolkit:AutoCompleteExtender ID="txtFolioNumber_autoCompleteExtender" runat="server"
                TargetControlID="txtFolioNumber" ServicePath="~/CustomerPortfolio/AutoComplete.asmx"
                ServiceMethod="GetCustomerFolioAccount" MinimumPrefixLength="3" EnableCaching="false"
                CompletionSetCount="1" CompletionInterval="1" CompletionListCssClass="AutoCompleteExtender_CompletionList"
                CompletionListItemCssClass="AutoCompleteExtender_CompletionListItem" CompletionListHighlightedItemCssClass="AutoCompleteExtender_HighlightedItem"
                UseContextKey="true" OnClientItemSelected="GetFolioAccount" />
        </td>
        <%-- <td class="rightField" style="width: 20%">
            <asp:DropDownList ID="ddlFolioNumber" runat="server" CssClass="cmbField" AutoPostBack="true">
            </asp:DropDownList>
        </td>--%>
    </tr>
    <tr runat="server" visible="false">
        <td class="rightField" style="width: 20%" colspan="4">
            <asp:DropDownList ID="ddlAmcSchemeList" runat="server" CssClass="cmbField" Width="400px"
                AutoPostBack="true" OnSelectedIndexChanged="ddlAmcSchemeList_SelectedIndexChanged">
            </asp:DropDownList>
            <span id="spnScheme" runat="server" class="spnRequiredField">*</span>
            <asp:CompareValidator ID="CompareValidator2" runat="server" ControlToValidate="ddlAmcSchemeList"
                CssClass="cvPCG" Display="Dynamic" ErrorMessage="<br />Please select a scheme"
                Operator="NotEqual" ValidationGroup="MFSubmit" ValueToCompare="Select"></asp:CompareValidator>
            <%--ServiceMethod="GetSchemeList"--%>
            <%--<asp:RequiredFieldValidator ID="rfvtxtSearchScheme" ControlToValidate="txtSearchScheme"
                ErrorMessage="<br />Please select a Scheme" Display="Dynamic" runat="server"
                CssClass="rfvPCG" ValidationGroup="MFSubmit">
            </asp:RequiredFieldValidator>--%>
            <%--<span style='font-size: 8px; font-weight: normal' class='FieldName'>Enter
                                        few characters of Scheme Name.</span>--%>
        </td>
    </tr>
    <tr id="trOrderNo" runat="server">
        <td class="leftField" style="width: 20%">
            <asp:Label ID="lblOrderNumber" runat="server" Text="Order Number:" CssClass="FieldName"
                Visible="false"></asp:Label>
        </td>
        <td class="rightField" style="width: 20%">
            <asp:Label ID="lblGetOrderNo" runat="server" Text="" CssClass="txtField" Visible="false"></asp:Label>
        </td>
        <td align="right" id="tdLblNav" runat="server" visible="false">
            <asp:Label ID="Label19" runat="server" Text="Purchase Price:" CssClass="FieldName"></asp:Label>
        </td>
        <td class="style1" id="tdtxtNAV" runat="server" visible="false">
            <asp:TextBox ID="txtNAV" runat="server" CssClass="txtField" onkeypress="return onlyNumbers();"
                CausesValidation="true" ValidationGroup="MFSubmit"></asp:TextBox>
            <span id="Span13" class="spnRequiredField">*</span>
            <%--  <asp:CompareValidator ID="CompareValidator15" ControlToValidate="txtNAV" runat="server"
                ValidationGroup="MFSubmit" Display="Dynamic" ErrorMessage="<br />Please enter a numeric value"
                Type="Double" Operator="DataTypeCheck" CssClass="cvPCG"></asp:CompareValidator>--%>
            <asp:RangeValidator ID="RangeValidator1" Display="Dynamic" ValidationGroup="MFSubmit"
                runat="server" ErrorMessage="<br />Please enter a numeric value" ControlToValidate="txtNAV"
                MaximumValue="2147483647" MinimumValue="0" Type="Double" CssClass="cvPCG"></asp:RangeValidator>
            <%-- <asp:CompareValidator ID="CompareValidator15" ControlToValidate="txtNAV" runat="server"  
                ValidationGroup="MFSubmit" Display="Dynamic" ErrorMessage="<br />Please enter a numeric value"
                Type="Integer" Operator="DataTypeCheck" CssClass="cvPCG">
                </asp:CompareValidator>--%>
            <%--   <asp:RangeValidator ID="RangeValidator1" Display="Dynamic" ValidationGroup="MFSubmit"  runat="server" ErrorMessage="RangeValidator" ControlToValidate="txtNAV" MaximumValue="100" MinimumValue="-100" Type="Double"></asp:RangeValidator>--%>
        </td>
        <td class="leftField" style="width: 20%" visible="false">
            <asp:Label ID="lblPortfolio" runat="server" Text="Portfolio: " CssClass="FieldName"></asp:Label>
        </td>
        <td class="rightField" style="width: 20%" visible="false">
            <asp:DropDownList ID="ddlPortfolio" runat="server" CssClass="cmbField">
            </asp:DropDownList>
        </td>
    </tr>
    <tr id="trOrderType" runat="server" visible="false">
        <td class="leftField" style="width: 20%">
            <asp:Label ID="lblOrderType" runat="server" Text="Order Type:" CssClass="FieldName"></asp:Label>
        </td>
        <td class="rightField" style="width: 20%">
            <asp:RadioButton ID="rbtnImmediate" Class="cmbField" runat="server" AutoPostBack="true"
                GroupName="OrderType" Checked="True" Text="Immediate" OnCheckedChanged="rbtnImmediate_CheckedChanged" />
            <asp:RadioButton ID="rbtnFuture" Class="cmbField" runat="server" AutoPostBack="true"
                GroupName="OrderType" Text="Future" OnCheckedChanged="rbtnImmediate_CheckedChanged" />
        </td>
        <td align="right">
            <asp:Label ID="lblPurDate" runat="server" Text="As on Date:" CssClass="FieldName"></asp:Label>
        </td>
        <td class="style1">
            <asp:Label ID="lblNavAsOnDate" runat="server" CssClass="txtField" Enabled="false"></asp:Label>
        </td>
        <td colspan="2">
        </td>
        <%--         <td class="leftField" style="width: 20%">
            <asp:Label ID="lblOrderStatus" runat="server" Text="Order Status: " CssClass="FieldName"></asp:Label>
        </td>
        <td class="rightField" style="width: 20%">
            <asp:DropDownList ID="ddlOrderStatus" runat="server" CssClass="cmbField" AutoPostBack="true">
            </asp:DropDownList>
        </td>--%>
    </tr>
    <%--<tr id="trrejectReason" runat="server">
        <td class="leftField" colspan="2" style="width: 40%">
  
        </td>
         <td class="leftField" style="width: 20%">
            <asp:Label ID="lblOrderPendingReason" runat="server" Text="Order Pending Reason: " CssClass="FieldName" ></asp:Label>
        </td>
        <td class="rightField" style="width: 20%">
              <asp:DropDownList ID="ddlOrderPendingReason" runat="server" CssClass="cmbField">
              </asp:DropDownList>
        </td>
    </tr>--%>
    <tr id="trfutureDate" runat="Server">
        <td class="leftField" style="width: 20%">
            <asp:Label ID="lblFutureDate" runat="server" Text="Select Future Date:" CssClass="FieldName"></asp:Label>
        </td>
        <td class="rightField" style="width: 20%">
            <telerik:RadDatePicker ID="txtFutureDate" CssClass="txtField" runat="server" Culture="English (United States)"
                Skin="Telerik" EnableEmbeddedSkins="false" ShowAnimation-Type="Fade" MinDate="1900-01-01">
                <Calendar UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x"
                    Skin="Telerik" EnableEmbeddedSkins="false">
                </Calendar>
                <DatePopupButton ImageUrl="" HoverImageUrl=""></DatePopupButton>
                <DateInput DisplayDateFormat="d/M/yyyy" DateFormat="d/M/yyyy">
                </DateInput>
            </telerik:RadDatePicker>
            <span id="Span8" class="spnRequiredField">*</span>
            <asp:CompareValidator ID="CVFutureDate" runat="server" ErrorMessage="<br/>Please enter a valid date."
                Type="Date" ControlToValidate="txtFutureDate" CssClass="cvPCG" Operator="DataTypeCheck"
                ValueToCompare="" Display="Dynamic"></asp:CompareValidator>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator6" ControlToValidate="txtFutureDate"
                CssClass="rfvPCG" ErrorMessage="<br />Please select Future Date" Display="Dynamic"
                runat="server" InitialValue="" ValidationGroup="MFSubmit"></asp:RequiredFieldValidator>
            <asp:CompareValidator ID="cvFutureDate1" runat="server" ControlToValidate="txtFutureDate"
                CssClass="cvPCG" ErrorMessage="<br />Future date should  be greater than or equal to Today"
                Operator="GreaterThanEqual" Type="Date"></asp:CompareValidator>
        </td>
        <td class="leftField" style="width: 20%">
            <asp:Label ID="lblFutureTrigger" runat="server" Text="Future Trigger:" CssClass="FieldName"></asp:Label>
        </td>
        <td class="rightField" style="width: 20%">
            <asp:TextBox ID="txtFutureTrigger" runat="server" CssClass="txtField" TextMode="MultiLine"></asp:TextBox>
        </td>
    </tr>
    <tr>
        <td colspan="5">
        </td>
    </tr>
    <tr id="trSection1" runat="server">
        <td colspan="5">
            <div class="divSectionHeading" style="vertical-align: text-bottom">
                Order Section Details
            </div>
        </td>
    </tr>
    <tr>
        <td colspan="5">
        </td>
    </tr>
    <tr id="trAmount" runat="server">
        <td class="leftField" style="width: 20%">
            <asp:Label ID="lblAmount" runat="server" Text="Amount:" CssClass="FieldName"></asp:Label>
        </td>
        <td class="rightField" style="width: 20%">
            <asp:TextBox ID="txtAmount" runat="server" CssClass="txtField" CausesValidation="true"
                ValidationGroup="MFSubmit"></asp:TextBox><span id="Span5" class="spnRequiredField">*</span>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator5" ControlToValidate="txtAmount"
                CssClass="rfvPCG" ErrorMessage="<br />Please select amount" Display="Dynamic"
                runat="server" InitialValue="" ValidationGroup="MFSubmit"></asp:RequiredFieldValidator>
            <asp:RangeValidator ID="RangeValidator2" Display="Dynamic" ValidationGroup="MFSubmit"
                runat="server" ErrorMessage="<br />Please enter a numeric value" ControlToValidate="txtAmount"
                MaximumValue="2147483647" MinimumValue="1" Type="Double" CssClass="cvPCG"></asp:RangeValidator>
            <%--<asp:CompareValidator ID="CompareValidator6" ControlToValidate="txtAmount" runat="server"
                ValidationGroup="MFSubmit" Display="Dynamic" ErrorMessage="<br />Please enter a numeric value"
                Type="Double" Operator="DataTypeCheck" CssClass="cvPCG"></asp:CompareValidator>--%>
        </td>
        <td class="leftField" style="width: 20%">
            <asp:Label ID="lblMode" runat="server" Text="Mode Of Payment:" CssClass="FieldName"></asp:Label>
        </td>
        <td class="rightField" style="width: 20%">
            <asp:DropDownList ID="ddlPaymentMode" runat="server" CssClass="cmbField" OnSelectedIndexChanged="ddlPaymentMode_SelectedIndexChanged"
                AutoPostBack="true">
                <asp:ListItem Text="Select" Value="Select"></asp:ListItem>
                <asp:ListItem Text="Cheque" Value="CQ"></asp:ListItem>
                <asp:ListItem Text="Draft" Value="DF"></asp:ListItem>
                <asp:ListItem Text="ECS" Value="ES"></asp:ListItem>
            </asp:DropDownList>
            <span id="Span10" class="spnRequiredField">*</span>
            <%-- <asp:RequiredFieldValidator ID="RequiredFieldValidator8" ControlToValidate="ddlPaymentMode"
                CssClass="rfvPCG" ErrorMessage="<br />Please select Mode Of Payment" Display="Dynamic"
                runat="server" InitialValue="" ValidationGroup="MFSubmit"></asp:RequiredFieldValidator>--%>
            <asp:CompareValidator ID="CompareValidator13" runat="server" ControlToValidate="ddlPaymentMode"
                CssClass="cvPCG" Display="Dynamic" ErrorMessage="<br />Please select  Mode Of Payment"
                Operator="NotEqual" ValidationGroup="MFSubmit" ValueToCompare="Select"></asp:CompareValidator>
        </td>
    </tr>
    <tr id="trPINo" runat="server" visible="false">
        <td class="leftField" style="width: 20%">
            <asp:Label ID="lblPaymentNumber" runat="server" Text="Payment Instrument Number: "
                CssClass="FieldName"></asp:Label>
        </td>
        <td class="rightField" style="width: 20%">
            <asp:TextBox ID="txtPaymentNumber" runat="server" MaxLength="6" CssClass="txtField"></asp:TextBox>
            <span id="Span12" class="spnRequiredField">*</span>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator8" ControlToValidate="txtPaymentNumber"
                ErrorMessage="<br />Please Enter a Payment Instrument No." Display="Dynamic"
                runat="server" CssClass="rfvPCG" ValidationGroup="MFSubmit"></asp:RequiredFieldValidator>
        </td>
        <td class="leftField" style="width: 20%">
            <asp:Label ID="lblPIDate" runat="server" Text="Payment Instrument Date:" CssClass="FieldName"></asp:Label>
        </td>
        <td class="rightField" style="width: 20%">
            <telerik:RadDatePicker ID="txtPaymentInstDate" CssClass="txtField" runat="server"
                Culture="English (United States)" Skin="Telerik" EnableEmbeddedSkins="false"
                ShowAnimation-Type="Fade" MinDate="1900-01-01">
                <Calendar UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x"
                    Skin="Telerik" EnableEmbeddedSkins="false">
                </Calendar>
                <DatePopupButton ImageUrl="" HoverImageUrl=""></DatePopupButton>
                <DateInput DisplayDateFormat="d/M/yyyy" DateFormat="d/M/yyyy">
                </DateInput>
            </telerik:RadDatePicker>
            <span id="Span11" class="spnRequiredField">*</span>
            <asp:CompareValidator ID="CompareValidator14" runat="server" ErrorMessage="<br/>Please enter a valid date."
                Type="Date" ControlToValidate="txtPaymentInstDate" CssClass="cvPCG" Operator="DataTypeCheck"
                ValueToCompare="" Display="Dynamic"></asp:CompareValidator>
            <%--<asp:CompareValidator ID="CVPaymentdate2" runat="server" ErrorMessage="<br/>Payment date cannot be greater than order date"
                 ControlToValidate="txtPaymentInstDate" ValidationGroup="MFSubmit" CssClass="cvPCG" Operator="LessThanEqual" Display="Dynamic"
               Type="Date"></asp:CompareValidator>--%>
            <%--<asp:CompareValidator ID="cvdate" runat="server" ErrorMessage="<br />Payment Instrument Date should be less than or equal to Order Date"
                Type="Date" ControlToValidate="txtPaymentInstDate" ControlToCompare="txtOrderDate"
                Operator="LessThanEqual" CssClass="cvPCG" Display="Dynamic" ValidationGroup="MFSubmit"></asp:CompareValidator>--%>
        </td>
    </tr>
    <tr id="trBankName" runat="server">
        <td class="leftField" style="width: 20%">
            <asp:Label ID="lblBankName" runat="server" Text="Bank Name:" CssClass="FieldName"></asp:Label>
        </td>
        <td class="rightField" style="width: 20%">
            <asp:DropDownList ID="ddlBankName" runat="server" CssClass="cmbField" AutoPostBack="true"
                AppendDataBoundItems="true" OnSelectedIndexChanged="ddlBankName_SelectedIndexChanged">
            </asp:DropDownList>
            <span id="Span4" class="spnRequiredField">*</span>
            <asp:ImageButton ID="imgAddBank" ImageUrl="~/App_Themes/Maroon/Images/user_add.png"
                AlternateText="Add" runat="server" ToolTip="Click here to Add Bank"
                OnClientClick="return openpopupAddBank()" Height="15px" Width="15px"></asp:ImageButton>
            <%-- --%>
            <asp:ImageButton ID="imgBtnRefereshBank" ImageUrl="~/Images/refresh.png" AlternateText="Refresh"
                  runat="server" ToolTip="Click here to refresh Bank List" OnClick="imgBtnRefereshBank_OnClick"
                OnClientClick="return closepopupAddBank()" Height="15px" Width="25px"></asp:ImageButton>
            <asp:CompareValidator ID="CompareValidator18" runat="server" ControlToValidate="ddlBankName"
                CssClass="cvPCG" Display="Dynamic" ErrorMessage="<br />Please select a Bank"
                Operator="NotEqual" ValidationGroup="MFSubmit" ValueToCompare="Select"></asp:CompareValidator>
            <%--      
            <asp:CompareValidator ID="CompareValidator11" runat="server" ControlToValidate="ddlBankName"
                CssClass="cvPCG" Display="Dynamic" ErrorMessage="<br />Please select a Bank"
                Operator="NotEqual" ValidationGroup="MFSubmit" ValueToCompare="Select"></asp:CompareValidator>--%>
        </td>
        <td class="leftField" style="width: 20%">
            <asp:Label ID="lblBranchName" runat="server" Text="Bank BranchName:" CssClass="FieldName"></asp:Label>
        </td>
        <td class="rightField" style="width: 20%">
            <asp:TextBox ID="txtBranchName" runat="server" CssClass="txtField"></asp:TextBox>
        </td>
    </tr>
    <tr id="trFrequency" runat="server">
        <td class="leftField" style="width: 20%">
            <asp:Label ID="lblFrequencySIP" runat="server" Text="Frequency:" CssClass="FieldName"></asp:Label>
        </td>
        <td class="rightField" style="width: 20%">
            <asp:DropDownList ID="ddlFrequencySIP" runat="server" CssClass="cmbField">
            </asp:DropDownList>
        </td>
        <td class="leftField" colspan="2" style="width: 40%">
        </td>
    </tr>
    <tr id="trSIPStartDate" runat="server">
        <td class="leftField" style="width: 20%">
            <asp:Label ID="lblStartDateSIP" runat="server" Text="Start Date:" CssClass="FieldName"></asp:Label>
        </td>
        <td class="rightField" style="width: 20%">
            <telerik:RadDatePicker ID="txtstartDateSIP" CssClass="txtField" runat="server" Culture="English (United States)"
                Skin="Telerik" EnableEmbeddedSkins="false" ShowAnimation-Type="Fade" MinDate="1900-01-01">
                <Calendar UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x"
                    Skin="Telerik" EnableEmbeddedSkins="false">
                </Calendar>
                <DatePopupButton ImageUrl="" HoverImageUrl=""></DatePopupButton>
                <DateInput DisplayDateFormat="d/M/yyyy" DateFormat="d/M/yyyy">
                </DateInput>
            </telerik:RadDatePicker>
            <asp:CompareValidator ID="CompareValidator3" runat="server" ErrorMessage="<br/>Please enter a valid date."
                Type="Date" ControlToValidate="txtstartDateSIP" CssClass="cvPCG" Operator="DataTypeCheck"
                ValueToCompare="" Display="Dynamic" ValidationGroup="MFSubmit"></asp:CompareValidator>
        </td>
        <td class="leftField" style="width: 20%">
            <asp:Label ID="lblEndDateSIP" runat="server" Text="End Date:" CssClass="FieldName"></asp:Label>
        </td>
        <td class="rightField" style="width: 20%">
            <telerik:RadDatePicker ID="txtendDateSIP" CssClass="txtField" runat="server" Culture="English (United States)"
                Skin="Telerik" EnableEmbeddedSkins="false" ShowAnimation-Type="Fade" MinDate="1900-01-01">
                <Calendar UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x"
                    Skin="Telerik" EnableEmbeddedSkins="false">
                </Calendar>
                <DatePopupButton ImageUrl="" HoverImageUrl=""></DatePopupButton>
                <DateInput DisplayDateFormat="d/M/yyyy" DateFormat="d/M/yyyy">
                </DateInput>
            </telerik:RadDatePicker>
            <%--<asp:CompareValidator ID="CompareValidator16" runat="server" CssClass="rfvPCG"
            ControlToValidate="txtTo" Display="Dynamic" ErrorMessage="Invalid Date" ValidationGroup="MFSubmit"
            Operator="DataTypeCheck" Type="Date">
            </asp:CompareValidator>  
            
            
            <asp:CompareValidator ID="CompareValidator4" runat="server" ErrorMessage="<br/>Please enter a valid date."
                Type="Date" ControlToValidate="txtendDateSIP" CssClass="cvPCG" Operator="DataTypeCheck"
                ValueToCompare="" Display="Dynamic" ValidationGroup="MFSubmit">
                </asp:CompareValidator >--%>
            <asp:CompareValidator ID="CompareValidator6" runat="server" ErrorMessage="<br/>To date should be greater than from date."
                Type="Date" ControlToValidate="txtendDateSIP" CssClass="cvPCG" Operator="DataTypeCheck"
                ControlToCompare="txtstartDateSIP" Display="Dynamic" ValidationGroup="MFSubmit"></asp:CompareValidator>
        </td>
    </tr>
    <tr id="trSection2" runat="server">
        <td colspan="5">
            <div class="divSectionHeading" style="vertical-align: text-bottom">
                Order Section Details
            </div>
        </td>
    </tr>
    <tr id="trGetAmount" runat="server">
        <td class="leftField" style="width: 20%">
            <asp:Label ID="lblAvailableAmount" runat="server" Text="Available Amount:" CssClass="FieldName"></asp:Label>
        </td>
        <td class="rightField" style="width: 20%">
            <asp:Label ID="lblGetAvailableAmount" runat="server" Text="" CssClass="txtField"></asp:Label>
        </td>
        <td class="leftField" style="width: 20%">
            <asp:Label ID="lblAvailableUnits" runat="server" Text="Available Units:" CssClass="FieldName"></asp:Label>
        </td>
        <td class="rightField" style="width: 20%">
            <asp:Label ID="lblGetAvailableUnits" runat="server" Text="" CssClass="txtField"></asp:Label>
        </td>
    </tr>
    <tr id="trRedeemed" runat="server">
        <td class="leftField" style="width: 20%">
            <asp:Label ID="lblReedeemed" runat="server" Text="Redeem/Switch:" CssClass="FieldName"></asp:Label>
        </td>
        <td class="rightField" style="width: 20%">
            <asp:RadioButton ID="rbtAmount" Class="cmbField" runat="server" GroupName="AmountUnit"
                Checked="True" Text="Amount" />
            <asp:RadioButton ID="rbtUnit" Class="cmbField" runat="server" GroupName="AmountUnit"
                Text="Units" />
        </td>
        <td class="leftField" style="width: 20%">
            <asp:Label ID="lblAmountUnits" runat="server" Text="Amount/Unit:" CssClass="FieldName"></asp:Label>
        </td>
        <td class="rightField" style="width: 20%">
            <asp:TextBox ID="txtNewAmount" runat="server" CssClass="txtField"></asp:TextBox><span
                id="Span2" class="spnRequiredField">*</span>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator7" ControlToValidate="txtNewAmount"
                CssClass="rfvPCG" ErrorMessage="<br />Please select Amount/Unit" Display="Dynamic"
                runat="server" InitialValue="" ValidationGroup="MFSubmit"></asp:RequiredFieldValidator>
            <asp:CompareValidator ID="CompareValidator9" ControlToValidate="txtNewAmount" runat="server"
                Display="Dynamic" ErrorMessage="<br />Please enter a numeric value" Type="Double"
                Operator="DataTypeCheck" CssClass="cvPCG"></asp:CompareValidator>
            <asp:RangeValidator ID="RangeValidator3" Display="Dynamic" ValidationGroup="MFSubmit"
                runat="server" ErrorMessage="<br />Please enter a valid amount" ControlToValidate="txtNewAmount"
                MaximumValue="2147483647" MinimumValue="1" Type="Double" CssClass="cvPCG"></asp:RangeValidator>
        </td>
    </tr>
    <tr id="trScheme" runat="server">
        <td class="leftField" style="width: 20%">
            <asp:Label ID="lblSchemeSwitch" runat="server" Text="To Scheme:" CssClass="FieldName"></asp:Label>
        </td>
        <td class="rightField" style="width: 20%">
            <asp:DropDownList ID="ddlSchemeSwitch" runat="server" CssClass="cmbLongField">
            </asp:DropDownList>
            <span id="Span3" runat="server" class="spnRequiredField">*</span>
            <asp:CompareValidator ID="CompareValidator10" runat="server" ControlToValidate="ddlSchemeSwitch"
                CssClass="cvPCG" Display="Dynamic" ErrorMessage="<br />Please select a scheme"
                Operator="NotEqual" ValidationGroup="MFSubmit" ValueToCompare="Select"></asp:CompareValidator>
        </td>
        <td class="leftField" colspan="2" style="width: 40%">
        </td>
    </tr>
    <tr id="trFrequencySTP" runat="server">
        <td class="leftField" style="width: 20%">
            <asp:Label ID="lblFrequencySTP" runat="server" Text="Frequency:" CssClass="FieldName"></asp:Label>
        </td>
        <td class="rightField" style="width: 20%">
            <asp:DropDownList ID="ddlFrequencySTP" runat="server" CssClass="cmbField">
            </asp:DropDownList>
        </td>
        <td class="leftField" colspan="2" style="width: 40%">
        </td>
    </tr>
    <tr id="trSTPStart" runat="server">
        <td class="leftField" style="width: 20%">
            <asp:Label ID="lblstartDateSTP" runat="server" Text="Start Date:" CssClass="FieldName"></asp:Label>
        </td>
        <td class="rightField" style="width: 20%">
            <telerik:RadDatePicker ID="txtstartDateSTP" CssClass="txtField" runat="server" Culture="English (United States)"
                Skin="Telerik" EnableEmbeddedSkins="false" ShowAnimation-Type="Fade" MinDate="1900-01-01">
                <Calendar UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x"
                    Skin="Telerik" EnableEmbeddedSkins="false">
                </Calendar>
                <DatePopupButton ImageUrl="" HoverImageUrl=""></DatePopupButton>
                <DateInput DisplayDateFormat="d/M/yyyy" DateFormat="d/M/yyyy">
                </DateInput>
            </telerik:RadDatePicker>
            <asp:CompareValidator ID="CompareValidator5" runat="server" ErrorMessage="<br/>Please enter a valid date."
                Type="Date" ControlToValidate="txtstartDateSTP" CssClass="cvPCG" Operator="DataTypeCheck"
                ValueToCompare="" Display="Dynamic" ValidationGroup="MFSubmit"></asp:CompareValidator>
        </td>
        <td class="leftField" style="width: 20%">
            <asp:Label ID="lblendDateSTP" runat="server" Text="End Date:" CssClass="FieldName"></asp:Label>
        </td>
        <td class="rightField" style="width: 20%">
            <telerik:RadDatePicker ID="txtendDateSTP" CssClass="txtField" runat="server" Culture="English (United States)"
                Skin="Telerik" EnableEmbeddedSkins="false" ShowAnimation-Type="Fade" MinDate="1900-01-01">
                <Calendar UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x"
                    Skin="Telerik" EnableEmbeddedSkins="false">
                </Calendar>
                <DatePopupButton ImageUrl="" HoverImageUrl=""></DatePopupButton>
                <DateInput DisplayDateFormat="d/M/yyyy" DateFormat="d/M/yyyy">
                </DateInput>
            </telerik:RadDatePicker>
            <asp:CompareValidator ID="CompareValidator7" runat="server" ErrorMessage="<br/>Please enter a valid date."
                Type="Date" ControlToValidate="txtendDateSTP" CssClass="cvPCG" Operator="DataTypeCheck"
                ValueToCompare="" Display="Dynamic" ValidationGroup="MFSubmit"></asp:CompareValidator>
            <asp:CompareValidator ID="CompareValidator15" runat="server" ErrorMessage="<br/>To date should be greater than from date."
                Type="Date" ControlToValidate="txtendDateSTP" CssClass="cvPCG" Operator="GreaterThan"
                ControlToCompare="txtstartDateSTP" Display="Dynamic" ValidationGroup="MFSubmit"></asp:CompareValidator>
        </td>
    </tr>
    <tr id="trSection3" runat="server">
        <td colspan="5">
            <div class="divSectionHeading" style="vertical-align: text-bottom">
                Order Section Details
            </div>
        </td>
    </tr>
    <tr id="trAddress1" runat="server">
        <td colspan="4">
            <asp:Label ID="Label23" CssClass="HeaderTextSmall" runat="server" Text="Current Address"></asp:Label>
        </td>
    </tr>
    <tr id="trOldLine1" runat="server">
        <td class="leftField" style="width: 20%">
            <asp:Label ID="lblLine1" CssClass="FieldName" runat="server" Text="Line1(House No./Building):"></asp:Label>
        </td>
        <td class="rightField" style="width: 20%">
            <asp:Label ID="lblGetLine1" CssClass="txtField" runat="server" Text=""></asp:Label>
        </td>
        <td class="leftField" style="width: 20%">
            <asp:Label ID="lblLine2" CssClass="FieldName" runat="server" Text="Line2(Street):"></asp:Label>
        </td>
        <td class="rightField" style="width: 20%">
            <asp:Label ID="lblGetLine2" CssClass="txtField" runat="server" Text=""></asp:Label>
        </td>
    </tr>
    <tr id="trOldLine3" runat="server">
        <td class="leftField" style="width: 20%">
            <asp:Label ID="lblLine3" CssClass="FieldName" runat="server" Text="Line3(Area):"></asp:Label>
        </td>
        <td class="rightField" style="width: 20%">
            <asp:Label ID="lblGetline3" CssClass="txtField" runat="server" Text=""></asp:Label>
        </td>
        <td class="leftField" style="width: 20%">
            <asp:Label ID="lblLivingSince" CssClass="FieldName" runat="server" Text="Living Since:"></asp:Label>
        </td>
        <td class="rightField" style="width: 20%">
            <asp:Label ID="lblGetLivingSince" CssClass="txtField" runat="server" Text=""></asp:Label>
        </td>
    </tr>
    <tr id="trOldCity" runat="server">
        <td class="leftField" style="width: 20%">
            <asp:Label ID="lblCity" CssClass="FieldName" runat="server" Text="City:"></asp:Label>
        </td>
        <td class="rightField" style="width: 20%">
            <asp:Label ID="lblgetCity" CssClass="txtField" runat="server" Text=""></asp:Label>
        </td>
        <td class="leftField" style="width: 20%">
            <asp:Label ID="lblstate" CssClass="FieldName" runat="server" Text="State:"></asp:Label>
        </td>
        <td class="rightField" style="width: 20%">
            <asp:Label ID="lblGetstate" CssClass="FieldName" runat="server" Text=""></asp:Label>
        </td>
    </tr>
    <tr id="trOldPin" runat="server">
        <td class="leftField" style="width: 20%">
            <asp:Label ID="lblPin" CssClass="FieldName" runat="server" Text="Pin Code:"></asp:Label>
        </td>
        <td class="rightField" style="width: 20%">
            <asp:Label ID="lblGetPin" CssClass="txtField" runat="server" Text=""></asp:Label>
        </td>
        <td class="leftField" style="width: 20%">
            <asp:Label ID="lblCountry" CssClass="FieldName" runat="server" Text="Country:"></asp:Label>
        </td>
        <td class="rightField" style="width: 20%">
            <asp:Label ID="lblGetCountry" CssClass="txtField" runat="server" Text=""></asp:Label>
        </td>
    </tr>
    <tr id="trAddress6" runat="server">
        <td colspan="4">
            <asp:Label ID="Label18" CssClass="HeaderTextSmall" runat="server" Text="New Address"></asp:Label>
        </td>
    </tr>
    <tr id="trNewLine1" runat="server">
        <td class="leftField" style="width: 20%">
            <asp:Label ID="lblAdrLine1" CssClass="FieldName" runat="server" Text="Line1(House No./Building):"></asp:Label>
        </td>
        <td class="rightField" style="width: 20%">
            <asp:TextBox ID="txtCorrAdrLine1" runat="server" CssClass="txtField"></asp:TextBox>
            <span id="Span15" class="spnRequiredField">*</span>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator10" ControlToValidate="txtCorrAdrLine1"
                CssClass="rfvPCG" ErrorMessage="<br />Please Enter Details" Display="Dynamic"
                runat="server" InitialValue="" ValidationGroup="MFSubmit"></asp:RequiredFieldValidator>
        </td>
        <td class="leftField" style="width: 20%">
            <asp:Label ID="lblAdrLine2" CssClass="FieldName" runat="server" Text="Line2(Street):"></asp:Label>
        </td>
        <td class="rightField" style="width: 20%">
            <asp:TextBox ID="txtCorrAdrLine2" runat="server" CssClass="txtField"></asp:TextBox>
            <span id="Span16" class="spnRequiredField">*</span>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator11" ControlToValidate="txtCorrAdrLine2"
                CssClass="rfvPCG" ErrorMessage="<br />Please Enter Details" Display="Dynamic"
                runat="server" InitialValue="" ValidationGroup="MFSubmit"></asp:RequiredFieldValidator>
        </td>
    </tr>
    <tr id="trNewLine3" runat="server">
        <td class="leftField" style="width: 20%">
            <asp:Label ID="lblAdrLine3" CssClass="FieldName" runat="server" Text="Line3(Area):"></asp:Label>
        </td>
        <td class="rightField" style="width: 20%">
            <asp:TextBox ID="txtCorrAdrLine3" runat="server" CssClass="txtField"></asp:TextBox>
            <span id="Span17" class="spnRequiredField">*</span>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator12" ControlToValidate="txtCorrAdrLine3"
                CssClass="rfvPCG" ErrorMessage="<br />Please Enter Details" Display="Dynamic"
                runat="server" InitialValue="" ValidationGroup="MFSubmit"></asp:RequiredFieldValidator>
        </td>
        <td class="leftField" style="width: 20%">
            <asp:Label ID="lblResidenceLivingDate" CssClass="FieldName" runat="server" Text="Living Since:"></asp:Label>
        </td>
        <td class="rightField" style="width: 20%">
            <telerik:RadDatePicker ID="txtLivingSince" CssClass="txtField" runat="server" Culture="English (United States)"
                Skin="Telerik" EnableEmbeddedSkins="false" ShowAnimation-Type="Fade" MinDate="1900-01-01">
                <Calendar UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x"
                    Skin="Telerik" EnableEmbeddedSkins="false">
                </Calendar>
                <DatePopupButton ImageUrl="" HoverImageUrl=""></DatePopupButton>
                <DateInput DisplayDateFormat="d/M/yyyy" DateFormat="d/M/yyyy">
                </DateInput>
            </telerik:RadDatePicker>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator16" ControlToValidate="txtLivingSince"
                CssClass="rfvPCG" ErrorMessage="<br />Please Enter  a valid date" Display="Dynamic"
                runat="server" InitialValue="" ValidationGroup="MFSubmit"></asp:RequiredFieldValidator>
            <asp:CompareValidator ID="txtLivingSince_CompareValidator" runat="server" ErrorMessage="<br/>Please enter a valid date."
                Type="Date" ControlToValidate="txtLivingSince" CssClass="cvPCG" Operator="DataTypeCheck"
                ValueToCompare="" Display="Dynamic"></asp:CompareValidator>
        </td>
    </tr>
    <tr id="trNewCity" runat="server">
        <td class="leftField" style="width: 20%">
            <asp:Label ID="lblAdrCity" CssClass="FieldName" runat="server" Text="City:"></asp:Label>
        </td>
        <td class="rightField" style="width: 20%">
            <asp:TextBox ID="txtCorrAdrCity" runat="server" CssClass="txtField"></asp:TextBox>
            <span id="Span18" class="spnRequiredField">*</span>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator13" ControlToValidate="txtCorrAdrCity"
                CssClass="rfvPCG" ErrorMessage="<br />Please Enter City" Display="Dynamic" runat="server"
                InitialValue="" ValidationGroup="MFSubmit"></asp:RequiredFieldValidator>
        </td>
        <td class="leftField" style="width: 20%">
            <asp:Label ID="lblAdrState" CssClass="FieldName" runat="server" Text="State:"></asp:Label>
        </td>
        <td class="rightField" style="width: 20%">
            <asp:DropDownList ID="ddlCorrAdrState" runat="server" CssClass="cmbField">
            </asp:DropDownList>
            <span id="Span20" class="spnRequiredField">*</span>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator15" ControlToValidate="ddlCorrAdrState"
                CssClass="rfvPCG" Display="Dynamic" ErrorMessage="<br />Please enter State" runat="server"
                InitialValue="Select" ValidationGroup="MFSubmit"></asp:RequiredFieldValidator>
            <%--   <asp:CompareValidator ID="CompareValidator6" ControlToValidate="ddlCorrAdrState"
                runat="server" Display="Dynamic" ErrorMessage="<br />Please enter State"
                Type="Integer" Operator="DataTypeCheck" CssClass="cvPCG"></asp:CompareValidator>--%>
        </td>
    </tr>
    <tr id="trNewPin" runat="server">
        <td class="leftField" style="width: 20%">
            <asp:Label ID="lblAdrPinCode" CssClass="FieldName" runat="server" Text="Pin Code:"></asp:Label>
        </td>
        <td class="rightField" style="width: 20%">
            <asp:TextBox ID="txtCorrAdrPinCode" runat="server" CssClass="txtField" MaxLength="6"></asp:TextBox>
            <span id="Span19" class="spnRequiredField">*</span>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator14" ControlToValidate="txtCorrAdrPinCode"
                CssClass="rfvPCG" ErrorMessage="<br />Please Enter PinCode" Display="Dynamic"
                runat="server" InitialValue="" ValidationGroup="MFSubmit"></asp:RequiredFieldValidator>
            <asp:CompareValidator ID="txtCorrAdrPinCode_comparevalidator" ControlToValidate="txtCorrAdrPinCode"
                runat="server" Display="Dynamic" ErrorMessage="<br />Please enter a numeric value"
                Type="Integer" Operator="DataTypeCheck" CssClass="cvPCG"></asp:CompareValidator>
        </td>
        <td class="leftField" style="width: 20%">
            <asp:Label ID="lblAdrCountry" CssClass="FieldName" runat="server" Text="Country:"></asp:Label>
        </td>
        <td class="rightField" style="width: 20%">
            <asp:DropDownList ID="ddlCorrAdrCountry" runat="server" CssClass="cmbField">
                <asp:ListItem Text="India" Value="India" Selected="True"></asp:ListItem>
            </asp:DropDownList>
        </td>
    </tr>
    <tr id="trSystematicDateChk1" runat="server" visible="false">
        <td width="25%" class="leftField">
            <asp:Label ID="lblSystematicDate" runat="server" Text="Date of Systematic Trx:" CssClass="FieldName"></asp:Label>
        </td>
        <td colspan="3">
            
        </td>
    </tr>
    <tr id="trSystematicDateChk2" runat="server">
        <td>
        </td>
        <td colspan="3">
            <asp:CheckBox ID="chkDate11" Text="11" runat="server" CssClass="cmbField" Width="40px"
                AutoPostBack="true" CausesValidation="False" />
            <asp:CheckBox ID="chkDate12" Text="12" runat="server" CssClass="cmbField" Width="40px" />
            <asp:CheckBox ID="chkDate13" Text="13" runat="server" CssClass="cmbField" Width="40px" />
            <asp:CheckBox ID="chkDate14" Text="14" runat="server" CssClass="cmbField" Width="40px" />
            <asp:CheckBox ID="chkDate15" Text="15" runat="server" CssClass="cmbField" Width="40px" />
            <asp:CheckBox ID="chkDate16" Text="16" runat="server" CssClass="cmbField" Width="40px" />
            <asp:CheckBox ID="chkDate17" Text="17" runat="server" CssClass="cmbField" Width="40px" />
            <asp:CheckBox ID="chkDate18" Text="18" runat="server" CssClass="cmbField" Width="40px" />
            <asp:CheckBox ID="chkDate19" Text="19" runat="server" CssClass="cmbField" Width="40px" />
            <asp:CheckBox ID="chkDate20" Text="20" runat="server" CssClass="cmbField" Width="40px" />
        </td>
    </tr>
    <tr id="trSystematicDateChk3" runat="server">
        <td>
        </td>
        <td colspan="3">
            <asp:CheckBox ID="chkDate21" Text="21" runat="server" CssClass="cmbField" Width="40px" />
            <asp:CheckBox ID="chkDate22" Text="22" runat="server" CssClass="cmbField" Width="40px" />
            <asp:CheckBox ID="chkDate23" Text="23" runat="server" CssClass="cmbField" Width="40px" />
            <asp:CheckBox ID="chkDate24" Text="24" runat="server" CssClass="cmbField" Width="40px" />
            <asp:CheckBox ID="chkDate25" Text="25" runat="server" CssClass="cmbField" Width="40px" />
            <asp:CheckBox ID="chkDate26" Text="26" runat="server" CssClass="cmbField" Width="40px" />
            <asp:CheckBox ID="chkDate27" Text="27" runat="server" CssClass="cmbField" Width="40px" />
            <asp:CheckBox ID="chkDate28" Text="28" runat="server" CssClass="cmbField" Width="40px" />
            <asp:CheckBox ID="chkDate29" Text="29" runat="server" CssClass="cmbField" Width="40px" />
            <asp:CheckBox ID="chkDate30" Text="30" runat="server" CssClass="cmbField" Width="40px" />
            <asp:CheckBox ID="chkDate31" Text="31" runat="server" CssClass="cmbField" Width="40px" />
        </td>
    </tr>
    <%--  <tr id="trSystematicDate" runat="server" visible="false" >
        <td class="leftField">
            <asp:Label ID="lblSystematicDateText" runat="server" Text="Date of Systematic Trx:"
                CssClass="FieldName"></asp:Label>
        </td>
        <%--<td>
            <asp:TextBox ID="txtSystematicDate" runat="server" CssClass="txtField"></asp:TextBox>
            <asp:CompareValidator ID="cvSystematicDate" runat="server" ErrorMessage="<br />Please Enter Systematic Date between 1 to 31"
                ValidationGroup="MFSubmit" ControlToValidate="txtSystematicDate" class="rfvPCG"
                Operator="LessThan" Type="Integer" ValueToCompare="32" Display="Dynamic"></asp:CompareValidator>
        </td>--%>
    <%-- <td>
        </td>
    </tr>--%>
    <tr id="trSystematicDate" runat="server">
        <td class="leftField" width="25%">
            <asp:Label ID="lblPeriod" runat="server" Text="Tenure:" CssClass="FieldName"></asp:Label>
        </td>
        <td colspan="3">
            <asp:TextBox ID="txtPeriod" runat="server" CssClass="txtField" AutoPostBack="true"
                ValidationGroup="MFSubmit" CausesValidation="true" OnTextChanged="txtPeriod_TextChanged"></asp:TextBox>
            <span id="Span21" class="spnRequiredField">*</span>
            <asp:DropDownList ID="ddlPeriodSelection" runat="server" AutoPostBack="true" CssClass="cmbField"
                CausesValidation="true" ValidationGroup="MFSubmit" OnSelectedIndexChanged="ddlPeriodSelection_SelectedIndexChanged">
                <%--<asp:ListItem>Select</asp:ListItem>  --%>
                <asp:ListItem Text="Days" Value="DA"></asp:ListItem>
                <asp:ListItem Text="Months" Value="MN"></asp:ListItem>
                <asp:ListItem Text="Years" Value="YR"></asp:ListItem>
            </asp:DropDownList>
            <asp:Label ID="lblUnits" runat="server" Text="&nbsp;&nbsp;(Units)" CssClass="FieldName"></asp:Label>
            <%-- <span id="Span8" class="spnRequiredField">*</span>--%>
            <%--<asp:Label ID="lblMonths" runat="server" Text="in Months" CssClass="txtField"></asp:Label>--%>
            <asp:RequiredFieldValidator ID="rfvPeriod" ControlToValidate="txtPeriod" ErrorMessage="<br />Please Enter a Period"
                Display="Dynamic" runat="server" CssClass="rfvPCG" ValidationGroup="MFSubmit">
            </asp:RequiredFieldValidator>&nbsp;&nbsp;
            <asp:CompareValidator ID="CompareValidator_txtPeriod" runat="server" ControlToValidate="txtPeriod"
                ErrorMessage="<br />Please Enter a numeric Value" Operator="DataTypeCheck" Type="Integer"
                ValueToCompare="Select" CssClass="cvPCG" Display="Dynamic" ValidationGroup="MFSubmit">
            </asp:CompareValidator>
            <asp:CompareValidator ID="CompareValidator4" runat="server" ControlToValidate="txtPeriod"
                ErrorMessage="<br />Please update the  value" Operator="GreaterThan" Type="Integer"
                ValueToCompare="0" CssClass="cvPCG" Display="Dynamic" ValidationGroup="MFSubmit">
            </asp:CompareValidator>
        </td>
    </tr>
    <tr id="trRegistrationDate" runat="server">
        <td class="leftField" width="25%">
            <asp:Label ID="lblRegistrationDate" runat="server" Text="Registration Date in R&T system: "
                CssClass="FieldName"></asp:Label>
        </td>
        <td>
            <asp:TextBox ID="txtRegistrationDate" runat="server" CssClass="txtField"></asp:TextBox>
            <cc1:CalendarExtender ID="RegistrationDate_CalendarExtender" runat="server" TargetControlID="txtRegistrationDate"
                Format="dd/MM/yyyy">
            </cc1:CalendarExtender>
            <cc1:TextBoxWatermarkExtender ID="RegistrationDate_TextBoxWatermarkExtender" runat="server"
                TargetControlID="txtRegistrationDate" WatermarkText="dd/mm/yyyy">
            </cc1:TextBoxWatermarkExtender>
            <asp:CompareValidator ID="CompareValidator16" runat="server" ErrorMessage="<br />The date format should be dd/mm/yyyy"
                Type="Date" ControlToValidate="txtRegistrationDate" Operator="DataTypeCheck"
                CssClass="cvPCG" ValidationGroup="MFSubmit" Display="Dynamic"></asp:CompareValidator>
        </td>
        <td>
            <%--  <asp:RequiredFieldValidator ID="RequiredFieldValidator2" ControlToValidate="txtRegistrationDate" ErrorMessage="Please select a Registration Date"
                Display="Dynamic" runat="server" CssClass="rfvPCG">
            </asp:RequiredFieldValidator>--%>
        </td>
    </tr>
    <tr id="trCeaseDate" runat="server">
        <td class="leftField" width="25%">
            <asp:Label ID="lblCeaseDate" runat="server" Text="Stopped Date: " CssClass="FieldName"></asp:Label>
        </td>
        <td>
            <asp:TextBox ID="txtCeaseDate" runat="server" CssClass="txtField"></asp:TextBox>
            <cc1:CalendarExtender ID="CeaseDate_CalendarExtender" runat="server" TargetControlID="txtCeaseDate"
                Format="dd/MM/yyyy">
            </cc1:CalendarExtender>
            <cc1:TextBoxWatermarkExtender ID="CeaseDate_TextBoxWatermarkExtender" runat="server"
                TargetControlID="txtCeaseDate" WatermarkText="dd/mm/yyyy">
            </cc1:TextBoxWatermarkExtender>
            <asp:CompareValidator ID="CompareValidator17" runat="server" ErrorMessage="<br />The date format should be dd/mm/yyyy"
                Type="Date" ControlToValidate="txtCeaseDate" Operator="DataTypeCheck" SipChequeDate_CalendarExtender="cvPCG"
                Display="Dynamic" ValidationGroup="MFSubmit"></asp:CompareValidator>
        </td>
        <td>
        </td>
    </tr>
    <tr id="trBtnSubmit" runat="server">
        <td align="left" colspan="3">
            <asp:Button ID="btnSubmit" runat="server" Text="Submit" CssClass="PCGButton" ValidationGroup="MFSubmit"
                OnClick="btnSubmit_Click" />
            <asp:Button ID="btnAddMore" runat="server" Text="Save & AddMore" CssClass="PCGMediumButton"
                ValidationGroup="MFSubmit" OnClick="btnAddMore_Click" />
            <asp:Button ID="btnUpdate" runat="server" Text="Update" CssClass="PCGButton" ValidationGroup="MFSubmit"
                OnClick="btnUpdate_Click" />
        </td>
    </tr>
    <tr>
        <td colspan="3">
            <asp:Label ID="LabelMainNote" runat="server" Text="Note: To print transaction slip with Payment Details, please save the order first."
                Font-Size="Small" CssClass="cmbField"></asp:Label>
        </td>
    </tr>
</table>
<asp:Panel ID="pnlOrderSteps" runat="server" Width="100%" Height="80%">
    <table width="100%">
        <tr>
            <td>
                <telerik:RadGrid ID="rgvOrderSteps" runat="server" Skin="Telerik" CssClass="RadGrid"
                    Width="80%" GridLines="None" AllowPaging="True" PageSize="20" AllowSorting="false"
                    AutoGenerateColumns="False" OnItemCreated="rgvOrderSteps_ItemCreated" ShowStatusBar="true"
                    AllowAutomaticUpdates="false" HorizontalAlign="NotSet" DataKeyNames="CO_OrderId,WOS_OrderStepCode"
                    OnItemDataBound="rgvOrderSteps_ItemDataBound" OnItemCommand="rgvOrderSteps_ItemCommand"
                    OnNeedDataSource="rgvOrderSteps_NeedDataSource">
                    <MasterTableView CommandItemDisplay="none" EditMode="PopUp" EnableViewState="false">
                        <Columns>
                            <%-- <telerik:GridBoundColumn  DataField="CO_OrderId"  HeaderText="OrderId" UniqueName="CO_OrderId" ReadOnly="True">
                            <ItemStyle Width="" HorizontalAlign="left"  Wrap="false" VerticalAlign="Top" />
                        </telerik:GridBoundColumn>--%>
                            <telerik:GridBoundColumn DataField="WOS_OrderStep" HeaderText="Stages" UniqueName="WOS_OrderStep"
                                ReadOnly="True">
                                <ItemStyle Width="" HorizontalAlign="left" Wrap="false" VerticalAlign="Top" />
                            </telerik:GridBoundColumn>
                            <telerik:GridTemplateColumn HeaderText="Stages" UniqueName="WOS_OrderStepCode" DataField="WOS_OrderStepCode"
                                Visible="false" ReadOnly="True">
                                <ItemTemplate>
                                    <asp:Label ID="lblOrderStepCode" runat="server" Text='<%#Eval("WOS_OrderStepCode")%>'></asp:Label>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                            <%-- <telerik:GridDropDownColumn UniqueName="DropDownColumnStatus" HeaderText="Status" 
                        ListTextField="XS_Status" ListValueField="XS_StatusCode" DataField="XS_StatusCode"></telerik:GridDropDownColumn>
                        
                        <telerik:GridDropDownColumn UniqueName="DropDownColumnStatusReason" HeaderText="Pending Reason"
                        ListTextField="XSR_StatusReason" ListValueField="XSR_StatusReasonCode" DataField="XSR_StatusReasonCode"></telerik:GridDropDownColumn>--%>
                            <telerik:GridTemplateColumn DataField="XS_StatusCode" HeaderText="Status" UniqueName="DropDownColumnStatus">
                                <EditItemTemplate>
                                    <telerik:RadComboBox ID="ddlCustomerOrderStatus" AutoPostBack="true" OnSelectedIndexChanged="ddlCustomerOrderStatus_OnSelectedIndexChanged"
                                        SelectedValue='<%#Bind("XS_StatusCode") %>' runat="server">
                                    </telerik:RadComboBox>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lblOrderStatus" runat="server" Text='<%#Eval("XS_Status")%>'></asp:Label>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn DataField="XSR_StatusReasonCode" HeaderText="Pending Reason"
                                UniqueName="DropDownColumnStatusReason">
                                <EditItemTemplate>
                                    <telerik:RadComboBox ID="ddlCustomerOrderStatusReason" runat="server">
                                    </telerik:RadComboBox>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lblOrderStatusReason" runat="server" Text='<%#Eval("XSR_StatusReason")%>'></asp:Label>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                            <%--     <telerik:GridDateTimeColumn DataField="CMFOS_Date" HeaderText="Date" DataFormatString="{0:d}" HtmlEncode="false" DataType="System.DateTime"
                        UniqueName="CMFOS_Date" ReadOnly="true"/>--%>
                            <telerik:GridTemplateColumn UniqueName="lblCMFOS_Date" DataField="CMFOS_Date" HeaderText="Date">
                                <ItemTemplate>
                                    <asp:Label ID="lblCMFOS_Date" runat="server" DataFormatString="{0:d}" Text='<%# DataBinder.Eval(Container.DataItem, "CMFOS_Date", "{0:dd/MM/yyyy}") %>'></asp:Label>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                            <telerik:GridEditCommandColumn UpdateText="Update" UniqueName="EditCommandColumn"
                                CancelText="Cancel">
                                <HeaderStyle></HeaderStyle>
                            </telerik:GridEditCommandColumn>
                            <telerik:GridBoundColumn DataField="COS_IsEditable" DataType="System.Boolean" UniqueName="COS_IsEditable"
                                Display="false" ReadOnly="True">
                            </telerik:GridBoundColumn>
                            <telerik:GridTemplateColumn Visible="false" UniqueName="lblStatus" DataField="XS_StatusCode">
                                <ItemTemplate>
                                    <asp:Label ID="lblStatusCode" runat="server" Text='<%#Eval("XS_StatusCode")%>'></asp:Label>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                        </Columns>
                    </MasterTableView>
                </telerik:RadGrid>
            </td>
        </tr>
    </table>
</asp:Panel>
<asp:HiddenField ID="txtCustomerId" runat="server" OnValueChanged="txtCustomerId_ValueChanged1" />
<asp:HiddenField ID="hdnCustomerId" runat="server" />
<asp:HiddenField ID="hdnType" runat="server" />
<asp:HiddenField ID="hdnSchemeCode" runat="server" OnValueChanged="txtSchemeCode_ValueChanged" />
<asp:HiddenField ID="hdnPortfolioId" runat="server" />
<asp:HiddenField ID="hdnAccountId" runat="server" />
<asp:HiddenField ID="hdnAmcCode" runat="server" />
<asp:HiddenField ID="hdnSchemeName" runat="server" />
<asp:HiddenField ID="hdnSchemeSwitch" runat="server" />
<asp:HiddenField ID="hdnBankName" runat="server" />
<asp:HiddenField ID="hdnIsSubscripted" runat="server" />
<asp:HiddenField ID="txtSwitchSchemeCode" runat="server" />
<asp:HiddenField ID="txtAgentId" runat="server" OnValueChanged="txtAgentId_ValueChanged1" />
<asp:HiddenField ID="hdnAplicationNo" runat="server" OnValueChanged="txtAgentId_ValueChanged1" />
<asp:HiddenField ID="hidValidCheck" runat="server" EnableViewState="true" />
<asp:HiddenField ID="HiddenField1" runat="server" OnValueChanged="HiddenField1_ValueChanged1" />
