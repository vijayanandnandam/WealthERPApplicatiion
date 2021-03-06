<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ReceivableSetup.ascx.cs"
    Inherits="WealthERP.Receivable.ReceivableSetup" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>
<meta http-equiv="content-type" content="text/html; charset=ISO-8859-1" />

<script src="../Scripts/jquery.js" type="text/javascript"></script>

<script src="../Scripts/jquery-1.2.6.js" type="text/javascript"></script>

<script src="../Scripts/jquery-1.4.2.min.js" type="text/javascript"></script>

<script src="../Scripts/jquery-ui-1.7.2.custom.min.js" type="text/javascript"></script>

<script src="../Scripts/jquery.min.js" type="text/javascript"></script>

<script src="../Scripts/jquery-1.3.1.min.js" type="text/javascript"></script>

<script src="../Scripts/jQuery.bubbletip-1.0.6.js" type="text/javascript"></script>

<script language="JavaScript" type="text/jscript">

    function SearchList() {


        var tb = document.getElementById('<%=TextBox1.ClientID%>').value;

        var l = document.getElementById("<%= rlbAvailSchemes.ClientID %>");

        var items = l.options.length;

        if (tb == "") {
            l.selectedIndex = -1;
        }
        else {
            for (var i = 0; i < l.options.length; i++) {

                if (l.options[i].text.toLowerCase().match(tb.toLowerCase())) {
                    l.options[i].selected = true;
                    return false;
                }
                else {
                    l.selectedIndex = -1;
                }

            }
        }
    }
   


</script>

<script language="JavaScript" type="text/jscript">

    function Associate() {


        var tb = document.getElementById('<%=txtAssociateSearch.ClientID%>').value;

        var l = document.getElementById("<%= LBAgentCodes.ClientID %>");

        var items = l.options.length;

        if (tb == "") {
            l.selectedIndex = -1;
        }
        else {
            for (var i = 0; i < l.options.length; i++) {

                if (l.options[i].text.toLowerCase().match(tb.toLowerCase())) {
                    l.options[i].selected = true;
                    return false;
                }
                else {
                    l.selectedIndex = -1;
                }

            }
        }
    }
   
    
</script>

<script language="JavaScript" type="text/jscript">
    function DeleteAllStructureRule() {
        alert(hi);
        var conf = confirm("Are you sure you want to delete this image?");

        if (conf == true) {
            return false;
        }
        else
            return false;

    }

    function doOpen() {
        $find("cpe")._doOpen();
    }

    function doClose() {
        $find("cpe")._doClose();
    }
    function CheckOnline() {
        if (confirm("Are you sure you want to delete ...?")) {
            return true;
        }
        return false;
    }
</script>

<script type="text/javascript">
    function Confirm() {

        var minValue = document.getElementById('<%=hdnViewMode.ClientID%>').value;
        //        var eligible = document.getElemeFntById('<%=hdneligible.ClientID%>').value;
        if (minValue == "ViewEdit") {
            var confirm_value = document.createElement("INPUT");
            confirm_value.type = "hidden";
            confirm_value.name = "confirm_value";
            if (confirm("All existing mapping will be deleted for this structure. Would you like to continue ?")) {
                confirm_value.value = "Yes";
            } else {
                confirm_value.value = "No";
            }
            document.forms[0].appendChild(confirm_value);
        }
    }
</script>

<%--<script type="text/javascript">
    $(document).ready(function() {
        $(".panel").show();

        $(".flip").click(function() { $(".panel").slideToggle(); });
    });
</script>

<script type="text/javascript">
    $(document).ready(function() {
        $(".panel1").show();

        $(".flip1").click(function() { $(".panel1").slideToggle(); });
    });
</script>--%>
<%--<script type="text/javascript">
    $(document).ready(function() {
        $(".panel1Hide").hide();
        $(".flipHide").click(function() { $(".panel1Hide").slideUp("slow"); });

    });
</script>

<script type="text/javascript">
    $(document).ready(function() {
        $(".panel2").show();

        $(".flip2").click(function() { $(".panel2").slideToggle(); });
    });
</script>--%>

<script language="JavaScript" type="text/jscript">

    function openpopupAddCustomer() {
        window.open('PopUp.aspx?AddPayableMapping=mf&pageID=PayableStructureToAgentCategoryMapping&', 'mywindow', 'width=800,height=600,scrollbars=yes,location=no')
        return false;
    }

    function InvestmentAmountValidation(source, args) {
        args.IsValid = false;
        var minValue = document.getElementById('ctrl_ReceivableSetup_RadGridStructureRule_ctl00_ctl02_ctl03_txtMinInvestmentAmount').value;
        var maxValue = document.getElementById('ctrl_ReceivableSetup_RadGridStructureRule_ctl00_ctl02_ctl03_txtMaxInvestmentAmount').value;
        if (parseInt(maxValue) > parseInt(minValue))
            args.IsValid = true;

        if ((minValue == "" && maxValue == "") || (minValue != "" && maxValue == ""))
            args.IsValid = true;

    }

    //    function alertTest() {
    //        var maxValue = document.getElementById('ctrl_ReceivableSetup_RadGridStructureRule_ctl00_ctl02_ctl03_txtMaxTenure').value;
    //        if (maxValue=="")
    //            alert("blank");
    //            else
    //                alert("empty");
    //    }

    function TenureValidation(source, args) {
        args.IsValid = false;
        var minValue = document.getElementById('ctrl_ReceivableSetup_RadGridStructureRule_ctl00_ctl02_ctl03_txtMinTenure').value;
        var maxValue = document.getElementById('ctrl_ReceivableSetup_RadGridStructureRule_ctl00_ctl02_ctl03_txtMaxTenure').value;
        if (parseInt(maxValue) > parseInt(minValue))
            args.IsValid = true;

        if ((minValue == "" && maxValue == "") || (minValue != "" && maxValue == ""))
            args.IsValid = true;
    }

    function InvestmentAgeValidation(source, args) {
        args.IsValid = false;
        var minValue = document.getElementById('ctrl_ReceivableSetup_RadGridStructureRule_ctl00_ctl02_ctl03_txtMinInvestAge').value;
        var maxValue = document.getElementById('ctrl_ReceivableSetup_RadGridStructureRule_ctl00_ctl02_ctl03_txtMaxInvestAge').value;
        if (parseInt(minValue) < parseInt(maxValue)) {
            args.IsValid = true;

        }

        if ((minValue == "" && maxValue == "") || (minValue != "" && maxValue == "")) {
            args.IsValid = true;
        }
    }

  
  
</script>

<script type="text/javascript">

    $(document).ready(function() {
        //    alert($("#imgCEStepOne").attr('src'))
        $(".panel").hide();
        $("#img1").click(function() {
            $(".panel").slideToggle(50);
            var src = $(this).attr('src');
            if (src == '../Images/Section-Expand.png') {
                $("#img1").attr("src", "../Images/Section-Collapse.png");

                if ($("#img1").attr('src') == '../Images/Section-Collapse.png') {
                    $(".panel1").slideToggle(50);
                    $("#img1").attr("src", "../Images/Section-Expand.png");
                }
                if ($("#imgCEStepThree").attr('src') == '../Images/Section-Collapse.png') {
                    $(".StepThreeContentTable").slideToggle(50);
                    $("#imgCEStepThree").attr("src", "../Images/Section-Expand.png");
                }

            }
            else if (src == '../Images/Section-Collapse.png') {
                $("#panel").attr("src", "../Images/Section-Expand.png");
            }
        });

    });

    //    $(document).ready(function() {
    //    $(".panel1").hide();
    //    $("#img2").click(function() {
    //    $(".panel1").slideToggle(50);
    //            var src = $(this).attr('src');
    //            if (src == '../Images/Section-Expand.png') {
    //                $("#img2").attr("src", "../Images/Section-Collapse.png");
    //                if ($("#img2").attr('src') == '../Images/Section-Collapse.png') {
    //                    $(".panel").slideToggle(50);
    //                    $("#img2").attr("src", "../Images/Section-Expand.png");
    //                }
    //                if ($("#imgCEStepThree").attr('src') == '../Images/Section-Collapse.png') {
    //                    $(".StepThreeContentTable").slideToggle(50);
    //                    $("#imgCEStepThree").attr("src", "../Images/Section-Expand.png");
    //                }

    //            }
    //            else if (src == '../Images/Section-Collapse.png')
    //                $("#img2").attr("src", "../Images/Section-Expand.png");
    //        });

    //    });








    $(document).ready(function() {
        //    alert($("#imgCEStepOne").attr('src'))
        $(".StepOneContentTable").hide();
        $("#imgCEStepOne").click(function() {
            $(".StepOneContentTable").slideToggle(50);
            var src = $(this).attr('src');
            if (src == '../Images/Section-Expand.png') {
                $("#imgCEStepOne").attr("src", "../Images/Section-Collapse.png");

                if ($("#imgCEStepTwo").attr('src') == '../Images/Section-Collapse.png') {
                    $(".StepTwoContentTable").slideToggle(50);
                    $("#imgCEStepTwo").attr("src", "../Images/Section-Expand.png");
                }
                if ($("#imgCEStepThree").attr('src') == '../Images/Section-Collapse.png') {
                    $(".StepThreeContentTable").slideToggle(50);
                    $("#imgCEStepThree").attr("src", "../Images/Section-Expand.png");
                }

            }
            else if (src == '../Images/Section-Collapse.png') {
                $("#imgCEStepOne").attr("src", "../Images/Section-Expand.png");
            }
        });

    });


    function keyPress(sender, args) {
        if (args.keyCode == 13) {
            return false;
        }
    }

    $(document).ready(function() {
        $(".StepTwoContentTable").hide();
        $("#imgCEStepTwo").click(function() {
            $(".StepTwoContentTable").slideToggle(50);
            var src = $(this).attr('src');
            if (src == '../Images/Section-Expand.png') {
                $("#imgCEStepTwo").attr("src", "../Images/Section-Collapse.png");
                if ($("#imgCEStepOne").attr('src') == '../Images/Section-Collapse.png') {
                    $(".StepOneContentTable").slideToggle(50);
                    $("#imgCEStepOne").attr("src", "../Images/Section-Expand.png");
                }
                if ($("#imgCEStepThree").attr('src') == '../Images/Section-Collapse.png') {
                    $(".StepThreeContentTable").slideToggle(50);
                    $("#imgCEStepThree").attr("src", "../Images/Section-Expand.png");
                }

            }
            else if (src == '../Images/Section-Collapse.png')
                $("#imgCEStepTwo").attr("src", "../Images/Section-Expand.png");
        });

    });

    function keyPress(sender, args) {
        if (args.keyCode == 13) {
            return false;
        }
    }

    $(document).ready(function() {
        $(".StepThreeContentTable").hide();
        $("#imgCEStepThree").click(function() {
            $(".StepThreeContentTable").slideToggle(50);
            var src = $(this).attr('src');
            if (src == '../Images/Section-Expand.png') {
                $("#imgCEStepThree").attr("src", "../Images/Section-Collapse.png");

                if ($("#imgCEStepTwo").attr('src') == '../Images/Section-Collapse.png') {
                    $(".StepTwoContentTable").slideToggle(50);
                    $("#imgCEStepTwo").attr("src", "../Images/Section-Expand.png");
                }
                if ($("#imgCEStepOne").attr('src') == '../Images/Section-Collapse.png') {
                    $(".StepOneContentTable").slideToggle(50);
                    $("#imgCEStepOne").attr("src", "../Images/Section-Expand.png");
                }

            }
            else if (src == '../Images/Section-Collapse.png')
                $("#imgCEStepThree").attr("src", "../Images/Section-Expand.png");
        });

    });

    function keyPress(sender, args) {
        if (args.keyCode == 13) {
            return false;
        }
    }


    /*---SECTION FOR POSTBACK HANDEL--*/



    
</script>

<asp:ScriptManager ID="scrptMgr" runat="server">
    <Services>
        <asp:ServiceReference Path="AutoComplete.asmx" />
    </Services>
</asp:ScriptManager>
<style type="text/css">
    .imgCollapse
    {
        background: Url(../Images/Section-Expand.png);
        cursor: pointer;
        cursor: hand;
    }
    .divCollapseImage
    {
        float: left;
        padding-left: 5px;
        width: 1000px;
        float: right;
        text-align: right;
        cursor: pointer;
        cursor: hand;
    }
    .table
    {
        border: 1px solid orange;
    }
    .leftLabel
    {
        width: 15%;
        text-align: right;
    }
    .rightData
    {
        width: 18%;
        text-align: left;
    }
    .rightDataTwoColumn
    {
        width: 25%;
        text-align: left;
    }
    .rightDataFourColumn
    {
        width: 50%;
        text-align: left;
    }
    .rightDataThreeColumn
    {
        width: 41%;
        text-align: left;
    }
    .tdSectionHeading
    {
        padding-bottom: 6px;
        padding-top: 6px;
        width: 100%;
    }
    .divSectionHeading table td span
    {
        padding-bottom: 5px !important;
    }
    .fltlft
    {
        float: left;
        padding-left: 3px;
        width: 20%;
    }
    .fltlft1
    {
        float: left;
        padding-left: 3px;
        width: 30%;
    }
    .divCollapseImage
    {
        float: left;
        padding-left: 5px;
        width: 2%;
        float: right;
        text-align: right;
        cursor: pointer;
        cursor: hand;
    }
    .imgCollapse
    {
        background: Url(../Images/Section-Expand.png);
        cursor: pointer;
        cursor: hand;
    }
    .imgExpand
    {
        background: Url(../Images/Section-Collapse.png) no-repeat left top;
        cursor: pointer;
        cursor: hand;
    }
    .fltlftStep
    {
        float: left;
    }
    .StepOneContentTable, .StepTwoContentTable, .StageRequestTable, .StepThreeContentTable, .StepFourContentTable
    {
        width: 100%;
    }
    .SectionBody
    {
        width: 100%;
    }
    .collapse
    {
        text-align: right;
    }
    .divStepStatus
    {
        float: left;
        padding-left: 2px;
        padding-right: 5px;
    }
    .divViewEdit
    {
        padding-right: 15px;
        width: 2%;
        float: right;
        text-align: right;
        cursor: hand;
    }
    .divTextCenter
    {
        text-align: right;
        vertical-align: middle;
    }
</style>
<asp:Panel ID="pnl1" runat="server">
    <asp:UpdatePanel ID="UpdatePanel1">
        <ContentTemplate>
            <table width="100%">
                <tr>
                    <td>
                        <div class="divPageHeading">
                            <table cellspacing="0" cellpadding="3" width="100%">
                                <tr>
                                    <td align="left">
                                        Add Brokerage Structure Set Up
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </td>
                </tr>
            </table>
            <table width="100%">
                <%--***********************************************Commission receivable Structure setup********************************--%>
                <tr id="trStepOneHeading" runat="server" class="SectionBody">
                    <td class="tdSectionHeading" colspan="5">
                        <div class="divStepStatus">
                            <asp:Image ID="imgStepOneStatus" ImageUrl="" alt="" runat="server" />
                        </div>
                        <div class="divSectionHeading" style="vertical-align: text-bottom">
                            <div style="float: left; padding-left: 3px">
                                <asp:ImageButton ID="ImageButton3" runat="server" ImageUrl="~/Images/toggle-collapse-alt_blue.png"
                                    alt="Collapse/Expand" OnClick="imgBuy_Click" Height="28px" Width="30px" Style="cursor: hand;"
                                    ToolTip="Collapse" ImageAlign="Top" />&nbsp;
                            </div>
                            <div class="divSectionHeadingNumber fltlftStep">
                                1
                            </div>
                            <div class="fltlft">
                                &nbsp;
                                <asp:Label ID="Label2" runat="server" Text="Basic Detail"></asp:Label>
                            </div>
                            <div class="divViewEdit">
                                <asp:LinkButton ID="lnkAddNewStructure" Text="Add" runat="server" CssClass="LinkButtons"
                                    ToolTip="Add new commission structure" OnClick="lnkAddNewStructure_Click" Visible="false">
                                </asp:LinkButton>
                            </div>
                            <div class="divViewEdit">
                                <asp:LinkButton ID="lnkEditStructure" Text="Edit" runat="server" CssClass="LinkButtons"
                                    OnClick="lnkEditStructure_Click">
                                </asp:LinkButton>
                            </div>
                    </td>
                </tr>
            </table>
            <table width="100%" id="tb1" runat="server">
                <tr>
                    <td class="leftLabel">
                        <asp:Label ID="lblStatusStage2" runat="server" Text="Pick Product:" CssClass="FieldName"></asp:Label>
                    </td>
                    <td class="rightData">
                        <asp:DropDownList ID="ddlProductType" runat="server" CssClass="cmbField" AutoPostBack="true"
                            OnSelectedIndexChanged="ddlProductType_OnSelectedIndexChanged">
                        </asp:DropDownList>
                        <br />
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" CssClass="rfvPCG"
                            ErrorMessage="Please Select Product Type" Display="Dynamic" ControlToValidate="ddlProductType"
                            InitialValue="Select" ValidationGroup="vgBtnSubmitStage2">
                        </asp:RequiredFieldValidator>
                    </td>
                    <td class="leftLabel" id="tdlblCategory" runat="server" visible="false">
                        <asp:Label ID="Label16" runat="server" Text="Category:" CssClass="FieldName"></asp:Label>
                    </td>
                    <td align="rightData" id="tdddlCategory" runat="server" visible="false">
                        <asp:DropDownList ID="ddlSubInstrCategory" runat="server" CssClass="cmbField" AutoPostBack="true"
                            Width="205px" OnSelectedIndexChanged="ddlSubInstrCategory_OnSelectedIndexChanged">
                        </asp:DropDownList>
                        <asp:Label ID="lblcategoryerror" runat="server" Text="*" Visible="false" CssClass="Error"></asp:Label><br />
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator10" runat="server" ErrorMessage="Please Select Category"
                            CssClass="rfvPCG" ControlToValidate="ddlSubInstrCategory" ValidationGroup="btnStrAddUpdate"
                            Display="Dynamic" InitialValue="0"></asp:RequiredFieldValidator>
                        <asp:DropDownList ID="ddlInstrCat" runat="server" CssClass="cmbLongField" Width="500px"
                            Visible="false">
                        </asp:DropDownList>
                    </td>
                    <td class="leftLabel">
                        <asp:Label ID="lblCategory" runat="server" Text="Category:" CssClass="FieldName"></asp:Label>
                    </td>
                    <td class="rightData">
                        <asp:DropDownList ID="ddlCategory" runat="server" CssClass="cmbField" AutoPostBack="true"
                            OnSelectedIndexChanged="ddlCategory_OnSelectedIndexChanged">
                        </asp:DropDownList>
                        <span id="SpanCategory" class="spnRequiredField" runat="server">*</span>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ErrorMessage="Please Select Category"
                            CssClass="rfvPCG" ControlToValidate="ddlCategory" ValidationGroup="btnStrAddUpdate"
                            Display="Dynamic" InitialValue="0"></asp:RequiredFieldValidator>
                    </td>
                    <td align="left">
                        <asp:Label ID="lblSubCategory" runat="server" Text="Sub Category:" CssClass="FieldName"
                            Visible="false"></asp:Label>
                    </td>
                </tr>
                <tr id="trIssuer" runat="server">
                    <td class="leftLabel">
                    </td>
                    <td class="rightData">
                    </td>
                    <td rowspan="5" class="rightDataTwoColumn">
                        <telerik:RadListBox ID="rlbAssetSubCategory" runat="server" CheckBoxes="true" CssClass="txtField"
                            Width="220px" Height="200px" Visible="false">
                        </telerik:RadListBox>
                    </td>
                </tr>
                <tr>
                    <td class="leftLabel">
                        <asp:Label ID="lblValidityFrom" runat="server" Text="Validity From :" CssClass="FieldName"></asp:Label>
                    </td>
                    <td class="rightData">
                        <asp:TextBox ID="txtValidityFrom" runat="server" CssClass="txtField"></asp:TextBox>
                        <span id="Span1" class="spnRequiredField">*</span>
                        <cc1:CalendarExtender ID="CalendarExtender2" runat="server" TargetControlID="txtValidityFrom"
                            Format="dd/MM/yyyy">
                        </cc1:CalendarExtender>
                        <cc1:TextBoxWatermarkExtender ID="TextBoxWatermarkExtender2" runat="server" TargetControlID="txtValidityFrom"
                            WatermarkText="dd/mm/yyyy">
                        </cc1:TextBoxWatermarkExtender>
                        <asp:CompareValidator ID="CompareValidator1" runat="server" ErrorMessage="<br/>Please enter a valid date."
                            Type="Date" ControlToValidate="txtValidityFrom" CssClass="cvPCG" Operator="DataTypeCheck"
                            ValidationGroup="vgBtnSubmitTemp" ValueToCompare="" Display="Dynamic"></asp:CompareValidator>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" ControlToValidate="txtValidityFrom"
                            ErrorMessage="<br />Please enter a validity from Date" Display="Dynamic" CssClass="rfvPCG"
                            runat="server" InitialValue="" ValidationGroup="btnStrAddUpdate">
                        </asp:RequiredFieldValidator>
                    </td>
                    <td class="leftLabel">
                        <asp:Label ID="lblValidityTo" runat="server" Text="To:" CssClass="FieldName"></asp:Label>
                    </td>
                    <td class="rightData">
                        <asp:TextBox ID="txtValidityTo" runat="server" CssClass="txtField"></asp:TextBox>
                        <span id="Span3" class="spnRequiredField">*</span>
                        <cc1:CalendarExtender ID="CalendarExtender1" runat="server" TargetControlID="txtValidityTo"
                            Format="dd/MM/yyyy">
                        </cc1:CalendarExtender>
                        <cc1:TextBoxWatermarkExtender ID="TextBoxWatermarkExtender1" runat="server" TargetControlID="txtValidityTo"
                            WatermarkText="dd/mm/yyyy">
                        </cc1:TextBoxWatermarkExtender>
                        <asp:CompareValidator ID="CVReceivedDate" runat="server" ErrorMessage="<br/>Please enter a valid date."
                            Type="Date" ControlToValidate="txtValidityTo" CssClass="cvPCG" Operator="DataTypeCheck"
                            ValidationGroup="vgBtnSubmitTemp" ValueToCompare="" Display="Dynamic"></asp:CompareValidator>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator7" ControlToValidate="txtValidityTo"
                            ErrorMessage="<br />Please enter a validity to Date" Display="Dynamic" CssClass="rfvPCG"
                            runat="server" InitialValue="" ValidationGroup="btnStrAddUpdate">
                        </asp:RequiredFieldValidator>
                        <asp:CompareValidator ControlToCompare="txtValidityFrom" ControlToValidate="txtValidityTo"
                            Display="Dynamic" CssClass="rfvPCG" ValidationGroup="btnStrAddUpdate" ErrorMessage="The Validity To must be greater than or equal to Validity From"
                            ID="CompareValidator2" Operator="GreaterThanEqual" Type="Date" runat="server" />
                    </td>
                </tr>
                <tr>
                    <td class="leftLabel">
                        <asp:Label ID="lblStructureName" runat="server" Text="Name:" CssClass="FieldName"></asp:Label>
                    </td>
                    <td class="rightDataThreeColumn" colspan="3">
                        <asp:TextBox ID="txtStructureName" runat="server" CssClass="txtField" Style="width: 70% !Important"></asp:TextBox>
                        <span id="Span2" class="spnRequiredField">*</span>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator4" ControlToValidate="txtStructureName"
                            ErrorMessage="<br />Structure name required" Display="Dynamic" CssClass="rfvPCG"
                            runat="server" InitialValue="" ValidationGroup="btnStrAddUpdate">
                        </asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr id="trReward" runat="server" visible="false">
                    <td class="leftLabel">
                        <asp:Label ID="lblOptions" runat="server" Text="Options:" CssClass="FieldName"></asp:Label>
                    </td>
                    <td class="rightDataThreeColumn" colspan="3">
                        <asp:CheckBox ID="chkHasClawBackOption" Text="" runat="server" Visible="false" />
                        <asp:Label ID="lblHasClawBackOption" runat="server" Text="Has clawback option" CssClass="txtField"
                            Visible="false"></asp:Label>
                        <asp:CheckBox ID="chkMoneytaryReward" Text="" runat="server" />
                        <asp:Label ID="Label1" runat="server" Text="Is non moneytary reward" CssClass="txtField"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="leftLabel">
                        <asp:Label ID="lblNote" runat="server" Text="Note:" CssClass="FieldName"></asp:Label>
                    </td>
                    <td class="rightDataThreeColumn" colspan="3">
                        <asp:TextBox ID="txtNote" runat="server" CssClass="txtField" TextMode="MultiLine"
                            Width="50%"></asp:TextBox>
                        <asp:Button ID="btnStructureSubmit" CssClass="PCGButton" Text="Submit" runat="server"
                            ValidationGroup="btnStrAddUpdate" OnClick="btnStructureSubmit_Click" />
                        <asp:Button ID="btnStructureUpdate" CssClass="PCGButton" Text="Update" runat="server"
                            OnClick="btnStructureUpdate_Click" ValidationGroup="btnStrAddUpdate" />
                        <asp:Button ID="btnMapToscheme" CssClass="PCGMediumButton" Text="Map Scheme" runat="server"
                            Visible="false" OnClick="btnMapToscheme_Click" ValidationGroup="btnStrAddUpdate" />
                        <asp:Button ID="ButtonAgentCodeMapping" CssClass="PCGMediumButton" Text="Map Agents"
                            Visible="false" runat="server" OnClick="ButtonAgentCodeMapping_Click" ValidationGroup="btnStrAddUpdate" />
                    </td>
                </tr>
            </table>
            <table id="Table2" runat="server" width="100%" visible="false" style="clear: both">
                <tr id="tr1" runat="server">
                    <td class="tdSectionHeading">
                        <div class="divSectionHeading" style="vertical-align: text-bottom">
                            <div style="float: left; padding-left: 3px">
                                <asp:ImageButton ID="ImageButton4" runat="server" alt="Collapse/Expand" ImageUrl="~/Images/toggle-collapse-alt_blue.png"
                                    Height="28px" Width="30px" Style="cursor: hand;" OnClick="imgBuyMapping_Click"
                                    ToolTip="Collapse" />
                            </div>
                            <div class="divSectionHeadingNumber fltlftStep">
                                2
                            </div>
                            <div class="fltlft" style="width: 300px;">
                                &nbsp;
                                <asp:Label ID="Label4" runat="server" Text="Scheme Mapping "></asp:Label>
                            </div>
                            <div class="divViewEdit" style="padding-right: 10px;">
                                <asp:ImageButton ID="ibtExportSummary" ImageUrl="~/App_Themes/Maroon/Images/Export_Excel.png"
                                    Visible="false" runat="server" AlternateText="Excel" ToolTip="Export To Excel"
                                    OnClick="ibtExportSummary_OnClick" OnClientClick="setFormat('excel')" Height="22px"
                                    Width="25px"></asp:ImageButton>
                            </div>
                        </div>
                    </td>
                </tr>
            </table>
            <table id="Table1" runat="server" width="100%">
                <tr>
                    <td>
                        <asp:Panel ID="pnlGrid" runat="server" CssClass="Landscape" Width="100%" ScrollBars="None"
                            Visible="false">
                            <table width="75%">
                                <tr>
                                    <td>
                                        <telerik:RadGrid ID="gvMappedSchemes" AllowSorting="false" runat="server" AllowAutomaticInserts="false"
                                            AllowPaging="True" AutoGenerateColumns="False" AllowFilteringByColumn="true"
                                            enableloadondemand="true" EnableEmbeddedSkins="false" GridLines="none" ShowFooter="true"
                                            PagerStyle-AlwaysVisible="true" EnableViewState="true" ShowStatusBar="true" Skin="Telerik"
                                            OnPageSizeChanged="gvMappedSchemes_PageSizeChanged" OnNeedDataSource="gvMappedSchemes_NeedDataSource"
                                            OnItemCreated="gvMappedSchemes_OnItemCreated" OnPageIndexChanged="gvMappedSchemes_PageIndexChanged"
                                            OnUpdateCommand="gvMappedSchemes_UpdateCommand" OnDeleteCommand="gvMappedSchemes_DeleteCommand">
                                            <HeaderContextMenu EnableEmbeddedSkins="False">
                                            </HeaderContextMenu>
                                            <ExportSettings HideStructureColumns="true" ExportOnlyData="true" FileName="MappedSchemes"
                                                IgnorePaging="true">
                                            </ExportSettings>
                                            <PagerStyle AlwaysVisible="True" />
                                            <MasterTableView AllowMultiColumnSorting="True" AllowSorting="true" AutoGenerateColumns="false"
                                                Width="100%" DataKeyNames="ACSTSM_SetupId">
                                                <CommandItemSettings ExportToExcelText="Export to excel" />
                                                <Columns>
                                                    <telerik:GridEditCommandColumn UniqueName="EditCommandColumn" HeaderStyle-Width="50px">
                                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Top" Width="50px" Wrap="false" />
                                                    </telerik:GridEditCommandColumn>
                                                    <telerik:GridBoundColumn DataField="Name" HeaderStyle-Width="400px" CurrentFilterFunction="Contains"
                                                        ShowFilterIcon="false" AutoPostBackOnFilter="true" HeaderText="Scheme Name" UniqueName="structSchemeName"
                                                        ReadOnly="true">
                                                        <ItemStyle HorizontalAlign="left" VerticalAlign="Top" Width="400px" Wrap="false" />
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridDateTimeColumn DataField="ValidFrom" ReadOnly="true" DataFormatString="{0:dd/MM/yyyy}"
                                                        HeaderStyle-Width="100px" CurrentFilterFunction="EqualTo" ShowFilterIcon="false"
                                                        AutoPostBackOnFilter="true" HeaderText="Valid From" SortExpression="ValidFrom"
                                                        UniqueName="schemeValidFrom" Visible="false">
                                                        <ItemStyle HorizontalAlign="left" VerticalAlign="Top" Width="100px" Wrap="false" />
                                                    </telerik:GridDateTimeColumn>
                                                    <telerik:GridDateTimeColumn DataField="ValidTill" DataFormatString="{0:dd/MM/yyyy}"
                                                        HeaderStyle-Width="100px" CurrentFilterFunction="EqualTo" ShowFilterIcon="false"
                                                        AutoPostBackOnFilter="true" HeaderText="Valid Till" UniqueName="schemeValidTill"
                                                        Visible="false">
                                                        <ItemStyle HorizontalAlign="left" VerticalAlign="Top" Width="100px" Wrap="false" />
                                                    </telerik:GridDateTimeColumn>
                                                    <telerik:GridButtonColumn ButtonType="LinkButton" Text="Delete" ConfirmText="Do you want to delete the mapping?"
                                                        CommandName="Delete" UniqueName="DeleteCommandColumn" HeaderStyle-Width="50px">
                                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Top" Width="50px" Wrap="false" />
                                                    </telerik:GridButtonColumn>
                                                </Columns>
                                                <PagerStyle AlwaysVisible="True" />
                                            </MasterTableView>
                                            <ClientSettings>
                                                <Selecting AllowRowSelect="True" EnableDragToSelectRows="True" />
                                                <Resizing AllowColumnResize="true" />
                                            </ClientSettings>
                                        </telerik:RadGrid>
                                    </td>
                                </tr>
                            </table>
                        </asp:Panel>
                    </td>
                </tr>
            </table>
            <asp:Panel ID="pnlAddSchemesButton" runat="server" Visible="false">
                <table width="33%" style="clear: both">
                    <tr>
                        <td class="leftLabel">
                            <asp:Label ID="lblAddNewSchemes" runat="server" CssClass="FieldName" Text="Add Schemes"
                                Visible="false"></asp:Label>
                        </td>
                        <td class="rightData">
                            <asp:Button ID="btnAddNewSchemes" runat="server" Text="Add Schemes" OnClick="btnAddNewSchemes_Click"
                                CssClass="PCGButton wide-button" Visible="false" />
                        </td>
                    </tr>
                </table>
            </asp:Panel>
            <asp:Panel ID="pnlAddSchemes" runat="server" Visible="false">
                <table width="100%" style="clear: both" runat="server" id="tbSchemeButton">
                    <tr>
                        <td class="leftLabel">
                            <asp:Label ID="lblIssuer" runat="server" Text="Issuer:" CssClass="FieldName"></asp:Label>
                        </td>
                        <td style="width: 24%">
                            <asp:DropDownList ID="ddlIssuer" runat="server" CssClass="cmbLongField">
                            </asp:DropDownList>
                            <span id="Span6" class="spnRequiredField">*</span>
                            <br />
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="Please Select Issuer"
                                CssClass="rfvPCG" ControlToValidate="ddlIssuer" ValidationGroup="btnScheme_Go"
                                Display="Dynamic" InitialValue="0"></asp:RequiredFieldValidator>
                        </td>
                        <td class="leftLabel">
                            <asp:Label ID="lblPeriodStart" runat="server" Style="text-align: right" CssClass="FieldName"
                                Text="Category:"></asp:Label>
                        </td>
                        <td>
                            <asp:DropDownList ID="ddlMFCategory" runat="server" CssClass="cmbField">
                            </asp:DropDownList>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator16" runat="server" ErrorMessage="Please Select category"
                                CssClass="rfvPCG" ControlToValidate="ddlMFCategory" ValidationGroup="btnScheme_Go"
                                Display="Dynamic" InitialValue="0"></asp:RequiredFieldValidator>
                        </td>
                        <td class="rightData">
                            <asp:Button ID="btn_GetAvailableSchemes" runat="server" Text="Go" CssClass="PCGButton"
                                OnClick="btn_GetAvailableSchemes_Click" ValidationGroup="btnScheme_Go" />
                        </td>
                    </tr>
                </table>
                <table width="100%" runat="server" visible="false" id="tbSchemeMapping">
                    <tr>
                        <td>
                            &nbsp;
                        </td>
                        <td align="center">
                            <asp:TextBox ID="TextBox1" runat="server" Width="412px" onkeyup="return SearchList();"></asp:TextBox>
                            <cc1:TextBoxWatermarkExtender ID="TextBoxWatermarkExtender3" runat="server" TargetControlID="TextBox1"
                                WatermarkText="Search Scheme">
                            </cc1:TextBoxWatermarkExtender>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            &nbsp;
                        </td>
                        <td align="center">
                            <asp:ListBox ID="rlbAvailSchemes" runat="server" Height="200px" Width="65%" SelectionMode="Multiple" />
                        </td>
                        <td align="left">
                            <table align="left">
                                <tr>
                                    <td align="left">
                                        <asp:Button ID="RightArrow1" runat="server" Text=">" Width="45px" OnClick="RightArrow1_Click" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Button ID="LeftArrow1" runat="server" Text="<" Width="45px" OnClick="LeftArrow1_Click" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Button ID="RightShift1" runat="server" Text=">>" Width="45px" OnClick="RightShift1_Click" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Button ID="LeftShift1" runat="server" Text="<<" Width="45px" OnClick="LeftShift1_Click" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                        <td>
                            <asp:ListBox ID="rlbMappedSchemes" runat="server" Height="200px" Width="350px" SelectionMode="Multiple" />
                        </td>
                    </tr>
                </table>
                <table width="100%" runat="server" visible="false" id="tbSchemeMapped">
                    <tr>
                        <td class="leftLabel">
                            <asp:Label ID="lblMappedFrom" runat="server" CssClass="FieldName" Text="Mapping Period: "
                                Visible="false"></asp:Label>
                        </td>
                        <td class="rightData">
                            <telerik:RadDatePicker ID="rdpMappedFrom" runat="server" Visible="false">
                            </telerik:RadDatePicker>
                        </td>
                        <td class="leftLabel">
                            <telerik:RadDatePicker ID="rdpMappedTill" runat="server" Visible="false">
                            </telerik:RadDatePicker>
                        </td>
                        <td class="rightData">
                            <asp:Button ID="btnMapSchemes" CssClass="PCGButton" runat="server" Text="Map" OnClick="btnMapSchemes_Click" />
                        </td>
                        <td colspan="2">
                            <asp:RequiredFieldValidator ID="rfvMappingTo" runat="server" ErrorMessage="Please enter valid date(s)"
                                Enabled="false" Display="Dynamic" CssClass="rfvPCG" ValidationGroup="mappingPeriod"
                                ControlToValidate="rdpMappedTill"></asp:RequiredFieldValidator>
                            <asp:RequiredFieldValidator ID="rfvMappingFrom" runat="server" ErrorMessage="Please enter valid date(s)"
                                Enabled="false" Display="Dynamic" CssClass="rfvPCG" ValidationGroup="mappingPeriod"
                                ControlToValidate="rdpMappedFrom"></asp:RequiredFieldValidator>
                            <asp:CompareValidator ID="cmvMappingPeriod" runat="server" ErrorMessage="Please enter valid date(s)"
                                Enabled="false" CssClass="rfvPCG" Display="Dynamic" ControlToCompare="rdpMappedFrom"
                                ControlToValidate="rdpMappedTill" Operator="GreaterThan"></asp:CompareValidator>
                        </td>
                    </tr>
                </table>
            </asp:Panel>
            <table id="Table3" runat="server" width="100%" visible="false">
                <tr id="tr2" runat="server">
                    <td class="tdSectionHeading">
                        <div class="divSectionHeading" style="vertical-align: text-bottom">
                            <div class="divSectionHeadingNumber fltlftStep">
                                2
                            </div>
                            <div class="fltlft" style="width: 400px;">
                                &nbsp;
                                <asp:Label ID="Label8" runat="server" Text="Payable Structure To Agent Category Mapping "></asp:Label>
                            </div>
                            <div class="divViewEdit" style="padding-right: 10px;">
                                <asp:ImageButton ID="ImageButton1" ImageUrl="~/App_Themes/Maroon/Images/Export_Excel.png"
                                    Visible="false" runat="server" AlternateText="Excel" ToolTip="Export To Excel"
                                    OnClick="ibtExportSummary_OnClick" OnClientClick="setFormat('excel')" Height="22px"
                                    Width="25px"></asp:ImageButton>
                            </div>
                            <%-- <div class="divTextCenter">
                                <asp:ImageButton ID="ImageButton5" runat="server" alt="Collapse/Expand" ImageUrl="../Images/Telerik/gp.gif"
                                    Height="20px" Width="20px" Style="float: right; cursor: hand;" OnClick="imgNcd_Click" />
                            </div>--%>
                        </div>
                    </td>
                </tr>
            </table>
            <table id="Table4" runat="server" width="100%" visible="false" style="clear: both">
                <tr id="tr3" runat="server">
                    <td class="tdSectionHeading">
                        <div class="divSectionHeading" style="vertical-align: text-bottom">
                            <div style="float: left; padding-left: 3px">
                                <asp:ImageButton ID="ImageButton5" runat="server" alt="Collapse/Expand" ImageUrl="~/Images/toggle-collapse-alt_blue.png"
                                    Height="28px" Width="30px" Style="float: right; cursor: hand;" OnClick="imgNcd_Click"
                                    ToolTip="Collapse" />
                            </div>
                            <div class="divSectionHeadingNumber fltlftStep">
                                2
                            </div>
                            <div class="fltlft" style="width: 400px;">
                                &nbsp;
                                <asp:Label ID="Label11" runat="server" Text="Issue Mapping "></asp:Label>
                            </div>
                            <div class="divViewEdit" style="padding-right: 10px;">
                                <asp:ImageButton ID="ImageButton2" ImageUrl="~/App_Themes/Maroon/Images/Export_Excel.png"
                                    Visible="false" runat="server" AlternateText="Excel" ToolTip="Export To Excel"
                                    OnClick="ibtExportSummary_OnClick" OnClientClick="setFormat('excel')" Height="22px"
                                    Width="25px"></asp:ImageButton>
                            </div>
                        </div>
                    </td>
                </tr>
            </table>
            <table runat="server" id="tbNcdIssueList" visible="false">
                <tr>
                    <td align="right" runat="server" id="tdlblIssuetype">
                        <asp:Label ID="Label9" runat="server" Text="Issue type:" CssClass="FieldName"></asp:Label>
                    </td>
                    <td runat="server" id="tdddlIssuetype">
                        <asp:DropDownList ID="ddlIssueType" runat="server" CssClass="cmbField" AutoPostBack="true"
                            Width="205px" OnSelectedIndexChanged="ddlIssueType_Selectedindexchanged">
                            <asp:ListItem Value="Select">Select</asp:ListItem>
                            <asp:ListItem Value="OpenIssue">Current Issue</asp:ListItem>
                            <asp:ListItem Value="ClosedIssue">Closed Issue</asp:ListItem>
                            <asp:ListItem Value="FutureIssue">Future Issue</asp:ListItem>
                        </asp:DropDownList>
                        <span id="Span11" class="spnRequiredField">*</span>
                        <br />
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" ErrorMessage="Please Select Issue Type"
                            CssClass="rfvPCG" ControlToValidate="ddlIssueType" ValidationGroup="btnGo" Display="Dynamic"
                            InitialValue="Select"></asp:RequiredFieldValidator>
                    </td>
                    <td align="right">
                        &nbsp;&nbsp;
                        <asp:Label ID="Label10" runat="server" Text="Unmaped Issues:" CssClass="FieldName"></asp:Label>
                    </td>
                    <td>
                        <asp:DropDownList ID="ddlUnMappedIssues" runat="server" CssClass="cmbField" AutoPostBack="true"
                            Width="205px">
                        </asp:DropDownList>
                        <span id="Span12" class="spnRequiredField">*</span>
                        <br />
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server" ErrorMessage="Please Select Issue Type"
                            CssClass="rfvPCG" ControlToValidate="ddlUnMappedIssues" ValidationGroup="btnGo"
                            Display="Dynamic" InitialValue="Select"></asp:RequiredFieldValidator>
                    </td>
                    <%-- </tr>
                <tr id="trBtnSubmit" runat="server">--%>
                    <td>
                        <asp:Button ID="btnMAP" runat="server" Text="Map" CssClass="PCGButton" ValidationGroup="btnGo"
                            OnClick="btnMAP_Click" />
                    </td>
                </tr>
            </table>
            <asp:Panel ID="pnlIssueList" Visible="false" runat="server" class="Landscape" Width="50%"
                Height="50%" ScrollBars="None">
                <table width="100%">
                    <tr>
                        <td>
                            <div id="dvIssueList" runat="server" style="width: auto;">
                                <telerik:RadGrid ID="gvMappedIssueList" runat="server" GridLines="None" AutoGenerateColumns="False"
                                    PageSize="10" AllowSorting="true" AllowPaging="True" ShowStatusBar="True" Skin="Telerik"
                                    EnableEmbeddedSkins="false" Width="100%" AllowAutomaticInserts="false" ExportSettings-FileName="Issue List"
                                    OnNeedDataSource="gvMappedIssueList_OnNeedDataSource" OnItemCommand="gvMappedIssueList_ItemCommand">
                                    <MasterTableView Width="100%" AllowMultiColumnSorting="True" DataKeyNames="ACSTSM_SetupId,AIM_IssueId"
                                        AutoGenerateColumns="false" CommandItemDisplay="None">
                                        <Columns>
                                            <telerik:GridButtonColumn CommandName="Delete" Text="Delete" ConfirmText="Do you want to delete this rule? Click OK to proceed"
                                                UniqueName="column">
                                            </telerik:GridButtonColumn>
                                            <telerik:GridBoundColumn DataField="AIM_IssueName" HeaderText="Issue Name" SortExpression="AIM_IssueName"
                                                ShowFilterIcon="false" CurrentFilterFunction="Contains" AutoPostBackOnFilter="true"
                                                UniqueName="AIM_IssueName" FooterStyle-HorizontalAlign="Left">
                                                <ItemStyle Width="" HorizontalAlign="Left" Wrap="false" VerticalAlign="Top" />
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="ACSTSM_ValidityStart" HeaderText="Validity From"
                                                SortExpression="ValidityFrom" ShowFilterIcon="false" CurrentFilterFunction="Contains"
                                                AutoPostBackOnFilter="true" DataFormatString="{0:d}" UniqueName="ACSTSM_ValidityStart"
                                                FooterStyle-HorizontalAlign="Left" Visible="false">
                                                <ItemStyle Width="" HorizontalAlign="Left" Wrap="false" VerticalAlign="Top" />
                                            </telerik:GridBoundColumn>
                                            <telerik:GridBoundColumn DataField="ACSTSM_ValidityEnd" HeaderText="Validity To"
                                                SortExpression="ValidityTo" ShowFilterIcon="false" CurrentFilterFunction="Contains"
                                                AutoPostBackOnFilter="true" DataFormatString="{0:d}" UniqueName="ACSTSM_ValidityEnd"
                                                FooterStyle-HorizontalAlign="Left" Visible="false">
                                                <ItemStyle Width="" HorizontalAlign="Left" Wrap="false" VerticalAlign="Top" />
                                            </telerik:GridBoundColumn>
                                        </Columns>
                                    </MasterTableView>
                                </telerik:RadGrid>
                            </div>
                        </td>
                        <td>
                            &nbsp;&nbsp;
                        </td>
                    </tr>
                </table>
            </asp:Panel>
            <table id="tblCommissionStructureRule" runat="server" width="100%">
                <tr id="trStepTwoHeading" runat="server" class="SectionBody">
                    <td class="tdSectionHeading" colspan="5">
                        <div class="divStepStatus">
                            <asp:Image ID="Image1" ImageUrl="" alt="" runat="server" />
                            &nbsp;
                        </div>
                        <div class="divSectionHeading" style="vertical-align: text-bottom">
                            <div style="float: left; padding-left: 3px">
                                <asp:ImageButton ID="imgBuy1" runat="server" alt="Collapse/Expand" ImageUrl="~/Images/toggle-collapse-alt_blue.png"
                                    Height="28px" Width="30px" Style="cursor: hand;" OnClick="imgBuy1_Click" ToolTip="Collapse" />
                            </div>
                            <div class="divSectionHeadingNumber">
                                3
                            </div>
                            <div class="fltlft" style="width: 200px;">
                                &nbsp;
                                <asp:Label ID="lblStage" runat="server" Text="Rules"></asp:Label>
                            </div>
                            <div class="divViewEdit" style="padding-right: 10px;">
                                <asp:ImageButton ID="imgexportButton" ImageUrl="~/App_Themes/Maroon/Images/Export_Excel.png"
                                    Visible="true" runat="server" AlternateText="Excel" ToolTip="Export To Excel"
                                    OnClick="btnExportData_OnClick" OnClientClick="setFormat('excel')" Height="22px"
                                    Width="25px"></asp:ImageButton>
                            </div>
                            <div class="divViewEdit" style="padding-right: 30px;">
                                <asp:LinkButton ID="lnkDeleteAllRule" Text="Delete" ToolTip="Delete commission structure all rule"
                                    runat="server" CssClass="LinkButtons" OnClientClick="return confirm('Do you want to delete structure all rules? Click OK to proceed');"
                                    OnClick="lnkDeleteAllRule_Click">
                                </asp:LinkButton>
                            </div>
                            <div class="divTextCenter">
                            </div>
                        </div>
                    </td>
                </tr>
            </table>
            <asp:Panel ID="pnlrulegrid" runat="server" Width="1140px" ScrollBars="Horizontal">
                <table id="tblCommissionStructureRule1" runat="server">
                    <tr>
                        <td>
                            <telerik:RadGrid ID="RadGridStructureRule" runat="server" CssClass="RadGrid" GridLines="Both"
                                AllowPaging="True" PageSize="20" AllowSorting="True" AutoGenerateColumns="false"
                                ShowStatusBar="true" AllowAutomaticDeletes="True" AllowAutomaticInserts="false"
                                AllowAutomaticUpdates="false" Skin="Telerik" OnItemDataBound="RadGridStructureRule_ItemDataBound"
                                OnNeedDataSource="RadGridStructureRule_NeedDataSource" OnInsertCommand="RadGridStructureRule_InsertCommand"
                                OnItemCommand="RadGridStructureRule_ItemCommand" OnDeleteCommand="RadGridStructureRule_DeleteCommand"
                                OnUpdateCommand="RadGridStructureRule_UpdateCommand" OnCancelCommand="RadGridStructureRule_OnCancelCommand">
                                <ExportSettings HideStructureColumns="false" ExportOnlyData="true" FileName="CommissionStructureRule">
                                </ExportSettings>
                                <MasterTableView CommandItemDisplay="Top" CommandItemSettings-ShowRefreshButton="false"
                                    EditMode="EditForms" CommandItemSettings-AddNewRecordText="Add Rule" DataKeyNames="ACSR_CommissionStructureRuleName,ACSR_CommissionStructureRuleId,ACSR_MinTenure,WCT_CommissionTypeCode,XCT_CustomerTypeCode,ACSR_TenureUnit,
                                ACSR_TransactionType,WCT_CommissionType,WCU_UnitCode,WCCO_CalculatedOnCode,ACSM_AUMFrequency,ACSR_MaxTenure,ACSR_SIPFrequency,ACG_CityGroupID,
                                ACSR_ReceivableRuleFrequency,WCAL_ApplicableLevelCode,ACSR_IsServiceTaxReduced,ACSR_IsTDSReduced,ACSM_IsOtherTaxReduced,PaybleValue,RecievableValue,ACSR_ServiceTaxValue,ASCR_WCMV_IncentiveType,CO_ApplicationNo,ACSR_ValidilityStart,ACSR_ValidilityEnd,ACSR_MinInvestmentAmount,ACSR_MaxInvestmentAmount
                                ,AID_IssueDetailId,ACSR_Mode,AIIC_InvestorCatgeoryId,ACSR_EForm,ACSR_InvestmentAgeUnit,ACSR_TenureUnit,ACSR_MinInvestmentAge,ACSR_MaxInvestmentAge,WCU_UnitCode1,RecievableValue,PaybleValue,ACSR_IsClaWback,ACSR_ClawBackAge,ACSR_IsServiceTaxInclusive,ACSR_IsSBCApplicable,ACSR_IsKKCApplicable,ACSR_SBCValue,ACSR_KKCValue,ACSR_EFormSeries">
                                    <Columns>
                                        <telerik:GridEditCommandColumn EditText="Edit" UniqueName="Edit">
                                        </telerik:GridEditCommandColumn>
                                        <telerik:GridBoundColumn UniqueName="ACSR_CommissionStructureRuleName" HeaderText="Rule Name"
                                            DataField="ACSR_CommissionStructureRuleName">
                                            <HeaderStyle></HeaderStyle>
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn UniqueName="WCT_CommissionTypeCode" HeaderText="Com Typ"
                                            DataField="WCT_CommissionTypeCode" Visible="false">
                                            <HeaderStyle></HeaderStyle>
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn UniqueName="XCT_CustomerTypeCode" HeaderText="INV Typ" DataField="XCT_CustomerTypeCode">
                                        </telerik:GridBoundColumn>
                                        <telerik:GridTemplateColumn UniqueName="ACSR_MinInvestmentAmount" HeaderText="Min. Invest Amount"
                                            DataField="ACSR_MinInvestmentAmount">
                                            <ItemTemplate>
                                                <asp:TextBox ID="txtMinInvestmentAmount" Width="80px" runat="server" Text='<%#Eval("ACSR_MinInvestmentAmount")%>'
                                                    Enabled="false"></asp:TextBox>
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn UniqueName="ACSR_MaxInvestmentAmount" HeaderText="Max. Invest Amount"
                                            DataField="ACSR_MaxInvestmentAmount">
                                            <ItemTemplate>
                                                <asp:TextBox ID="txtMaxInvestmentAmount" Width="80px" runat="server" Text='<%#Eval("ACSR_MaxInvestmentAmount")%>'
                                                    Enabled="false"></asp:TextBox>
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridBoundColumn UniqueName="ACSR_TenureUnit" HeaderText="Tenure Unit" DataField="ACSR_TenureUnit"
                                            Visible="false">
                                            <HeaderStyle></HeaderStyle>
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn UniqueName="ACSR_InvestmentAgeUnit" HeaderText="Invest Age Unit"
                                            DataField="ACSR_InvestmentAgeUnit" Visible="false">
                                            <HeaderStyle></HeaderStyle>
                                        </telerik:GridBoundColumn>
                                        <telerik:GridTemplateColumn UniqueName="ACSR_TransactionType" HeaderText="Transaction Types"
                                            DataField="ACSR_TransactionType" Visible="false">
                                            <ItemTemplate>
                                                <asp:Label ID="lblTransactionType" runat="server" Width="50px" Text='<%#Eval("ACSR_TransactionType")%>'
                                                    Enabled="false"></asp:Label>
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridBoundColumn UniqueName="ACSR_MinNumberOfApplications" HeaderText="Min. No. of App."
                                            DataField="ACSR_MinNumberOfApplications">
                                            <HeaderStyle></HeaderStyle>
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn UniqueName="ACSR_MaxNumberOfApplications" HeaderText="Max. No. of App."
                                            DataField="ACSR_MaxNumberOfApplications">
                                            <HeaderStyle></HeaderStyle>
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn UniqueName="CO_ApplicationNo" HeaderText="App. No." DataField="CO_ApplicationNo">
                                            <HeaderStyle></HeaderStyle>
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn UniqueName="ASCR_WCMV_IncentiveType" HeaderText="Incentive Type"
                                            DataField="ASCR_WCMV_IncentiveType" Visible="false">
                                            <HeaderStyle></HeaderStyle>
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn UniqueName="ACSR_ValidilityStart" HeaderText="Validity From"
                                            DataField="ACSR_ValidilityStart" Visible="false">
                                            <HeaderStyle></HeaderStyle>
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn UniqueName="ACSR_ValidilityEnd" HeaderText="Validity To"
                                            DataField="ACSR_ValidilityEnd" Visible="false">
                                            <HeaderStyle></HeaderStyle>
                                        </telerik:GridBoundColumn>
                                        <telerik:GridTemplateColumn UniqueName="ReceivableValue" HeaderStyle-Width="50px"
                                            HeaderText="Receivable Rate" DataField="RecievableValue">
                                            <ItemTemplate>
                                                <asp:TextBox ID="txtReceivableValue" runat="server" Width="50px" Text='<%#  Eval("RecievableValue")%>'
                                                    Enabled="false"></asp:TextBox>
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>
                                        <%--<telerik:GridBoundColumn UniqueName="ReceivableUnit" HeaderText="Receivable  Unit"
                                            DataField="RecievableUnit">
                                        </telerik:GridBoundColumn>--%>
                                        <telerik:GridTemplateColumn UniqueName="PaybleValue" HeaderStyle-Width="50px" HeaderText="Payable Rate"
                                            DataField="PaybleValue">
                                            <ItemTemplate>
                                                <asp:TextBox ID="txtPaybleValue" runat="server" Width="50px" Text='<%#Eval("PaybleValue")%>'
                                                    Enabled="false"></asp:TextBox>
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn HeaderStyle-Width="50px" UniqueName="Brokrage_unit" HeaderText="Brokerage Unit">
                                            <ItemTemplate>
                                                <asp:DropDownList ID="ddlBrokrageUnit" runat="server" Enabled="false">
                                                    <asp:ListItem Text="Percentage" Value="PER"></asp:ListItem>
                                                    <asp:ListItem Text="Adhoc Amount" Value="ADA"></asp:ListItem>
                                                    <asp:ListItem Text="Amount Per Unit" Value="APU"></asp:ListItem>
                                                </asp:DropDownList>
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn UniqueName="ACSR_IsClaWback" HeaderText="IsClawBack"
                                            DataField="ACSR_IsClaWback" HeaderStyle-Width="50px">
                                            <ItemTemplate>
                                                <asp:CheckBox ID="ChkIsclowBack" runat="server" AutoPostBack="true" CssClass="cmbFielde"
                                                    OnCheckedChanged="chkCloBack_OnCheckedChanged" Checked='<%# (Eval("ACSR_IsClaWback").ToString() == "1" ? true : false) %>'
                                                    Enabled="false" />
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn UniqueName="ACSR_ClawBackAge" HeaderText="ClawBack Age(Days)"
                                            DataField="ACSR_ClawBackAge" HeaderStyle-Width="50px">
                                            <ItemTemplate>
                                                <asp:TextBox ID="txtClawBackAge" runat="server" Enabled="false" Width="50px" Text='<%#Eval("ACSR_ClawBackAge")%>'></asp:TextBox>
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn UniqueName="ACSR_ServiceTaxValue" HeaderText="Service Tax Value(%)"
                                            DataField="ACSR_ServiceTaxValue" HeaderStyle-Width="50px">
                                            <ItemTemplate>
                                                <asp:TextBox ID="txtServiceTex" runat="server" Width="50px" Text='<%#Eval("ACSR_ServiceTaxValue")%>'
                                                    Enabled="false"></asp:TextBox>
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn UniqueName="ACSR_ReducedValue" HeaderStyle-Width="50px"
                                            HeaderText="TDS Value(%)" DataField="ACSR_ReducedValue">
                                            <ItemTemplate>
                                                <asp:TextBox ID="txtTDSTex" runat="server" Width="50px" Text='<%#Eval("ACSR_ReducedValue")%>'
                                                    Enabled="false"></asp:TextBox>
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridBoundColumn UniqueName="ACSR_MinInvestmentAge" HeaderText="Min. Invest Age"
                                            DataField="ACSR_MinInvestmentAge">
                                            <HeaderStyle></HeaderStyle>
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn UniqueName="ACSR_MaxInvestmentAge" HeaderText="Max.Invest Age"
                                            DataField="ACSR_MaxInvestmentAge">
                                            <HeaderStyle></HeaderStyle>
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn UniqueName="ACSR_MinTenure" HeaderText="Min. Tenure (SIP)"
                                            DataField="ACSR_MinTenure" Visible="false">
                                            <HeaderStyle></HeaderStyle>
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn UniqueName="ACSR_MaxTenure" HeaderText="Max. Tenure (SIP)"
                                            DataField="ACSR_MaxTenure" Visible="false">
                                            <HeaderStyle></HeaderStyle>
                                        </telerik:GridBoundColumn>
                                        <%-- <telerik:GridBoundColumn UniqueName="PaybleUnit" HeaderText="Payable  Unit" DataField="PaybleUnit">
                                        </telerik:GridBoundColumn>--%>
                                        <telerik:GridBoundColumn UniqueName="WCCO_CalculatedOn" HeaderText="Calculated On"
                                            DataField="WCCO_CalculatedOn" Visible="false">
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn UniqueName="ACSM_AUMFrequency" HeaderText="AUM Frequency"
                                            DataField="ACSM_AUMFrequency" Visible="false">
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn UniqueName="ACSR_AUMMonth" HeaderText="AUM Month" DataField="ACSR_AUMMonth"
                                            Visible="false">
                                        </telerik:GridBoundColumn>
                                        <telerik:GridTemplateColumn UniqueName="Edit1">
                                            <ItemTemplate>
                                                <asp:LinkButton ID="lnkEdit" runat="server" CssClass="LinkButtons" Text="Edit" OnClick="btnruleEdit_OnClick"
                                                    Visible="false"></asp:LinkButton>
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridButtonColumn CommandName="Delete" Text="Delete" ConfirmText="Do you want to delete this rule? Click OK to proceed"
                                            UniqueName="Delete">
                                        </telerik:GridButtonColumn>
                                        <telerik:GridTemplateColumn UniqueName="Update">
                                            <ItemTemplate>
                                                <asp:Button ID="btnupdate" runat="server" CssClass="PCGButton" Visible="false" Text="Update"
                                                    OnClick="btnupdate_OnClick" />
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>
                                    </Columns>
                                    <EditFormSettings EditFormType="Template">
                                        <FormTemplate>
                                            <%-- <table>
                                                <tr id="trRule" runat="server">
                                                    <td id="tdRule" runat="server">--%>
                                            <table cellspacing="3" cellpadding="3" width="100%">
                                                <tr>
                                                    <td colspan="5" class="tdSectionHeading">
                                                        <div class="divSectionHeading" style="vertical-align: text-bottom">
                                                            <div class="divSectionHeadingNumber" style="height: 22px; width: 22px">
                                                                3.1
                                                            </div>
                                                            <div class="fltlft" style="width: 250px;">
                                                                &nbsp;
                                                                <asp:Label ID="lblStage" runat="server" Text="Rule"></asp:Label>
                                                            </div>
                                                        </div>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="leftLabel">
                                                        <asp:Label ID="lb1RuleName" runat="server" Text="Rule:" CssClass="FieldName"></asp:Label>
                                                    </td>
                                                    <td class="rightData" colspan="2">
                                                        <asp:TextBox ID="TxtRuleName" runat="server" CssClass="txtField" Width="400px"></asp:TextBox>
                                                        <span id="Span14" class="spnRequiredField" runat="server" visible="true">*</span>
                                                        <asp:RequiredFieldValidator runat="server" ID="ReqRuleName" ValidationGroup="btnSubmitRule"
                                                            Display="Dynamic" ControlToValidate="TxtRuleName" ErrorMessage="<br />Enter Rule Name"
                                                            Text="" />
                                                    </td>
                                                    <%-- 
                                                        <asp:CheckBox ID="chkSpecial" runat="server" CssClass="cmbFielde" Text="Special Incentive"
                                                            Checked='<%# Eval("ACSR_IsSpecialIncentive") == DBNull.Value ? false : Convert.ToBoolean(Eval("ACSR_IsSpecialIncentive")) %>' />
                                                    </td>--%>
                                                </tr>
                                                <tr id="trDateValidation" runat="server" visible="false">
                                                    <td class="leftLabel">
                                                        <asp:Label ID="lblRuleStart" runat="server" CssClass="FieldName" Text="Validity Start:"></asp:Label>
                                                    </td>
                                                    <td class="rightData">
                                                        <asp:TextBox ID="txtRuleValidityFrom" runat="server" CssClass="txtField" Text='<%#Eval("ACSR_ValidilityStart","{0:dd/MM/yyyy}")%>'></asp:TextBox>
                                                        <span id="Span1" class="spnRequiredField">*</span>
                                                        <cc1:CalendarExtender ID="CalendarExtender2" runat="server" TargetControlID="txtRuleValidityFrom"
                                                            Format="dd/MM/yyyy">
                                                        </cc1:CalendarExtender>
                                                        <cc1:TextBoxWatermarkExtender ID="TextBoxWatermarkExtender2" runat="server" TargetControlID="txtRuleValidityFrom"
                                                            WatermarkText="dd/mm/yyyy">
                                                        </cc1:TextBoxWatermarkExtender>
                                                        <asp:CompareValidator ID="CompareValidator1" runat="server" ErrorMessage="<br/>Please enter a valid date."
                                                            Type="Date" ControlToValidate="txtRuleValidityFrom" CssClass="cvPCG" Operator="DataTypeCheck"
                                                            ValidationGroup="btnSubmitRule" ValueToCompare="" Display="Dynamic"></asp:CompareValidator>
                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" ControlToValidate="txtRuleValidityFrom"
                                                            ErrorMessage="<br />Please enter a validity from Date" Display="Dynamic" CssClass="rfvPCG"
                                                            runat="server" InitialValue="">
                                                        </asp:RequiredFieldValidator>
                                                    </td>
                                                    <td class="leftLabel">
                                                        <asp:Label ID="lblValidityEnd" runat="server" CssClass="FieldName" Text="Validity End:"></asp:Label>
                                                    </td>
                                                    <td class="rightData">
                                                        <asp:TextBox ID="txtRuleValidityTo" runat="server" CssClass="txtField" Text='<%#Eval("ACSR_ValidilityEnd","{0:dd/MM/yyyy}")%>'></asp:TextBox>
                                                        <span id="Span3" class="spnRequiredField">*</span>
                                                        <cc1:CalendarExtender ID="CalendarExtender1" runat="server" TargetControlID="txtRuleValidityTo"
                                                            Format="dd/MM/yyyy">
                                                        </cc1:CalendarExtender>
                                                        <cc1:TextBoxWatermarkExtender ID="TextBoxWatermarkExtender1" runat="server" TargetControlID="txtRuleValidityTo"
                                                            WatermarkText="dd/mm/yyyy">
                                                        </cc1:TextBoxWatermarkExtender>
                                                        <asp:CompareValidator ID="CVReceivedDate" runat="server" ErrorMessage="<br/>Please enter a valid date."
                                                            Type="Date" ControlToValidate="txtRuleValidityTo" CssClass="cvPCG" Operator="DataTypeCheck"
                                                            ValidationGroup="btnSubmitRule" ValueToCompare="" Display="Dynamic"></asp:CompareValidator>
                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator7" ControlToValidate="txtRuleValidityTo"
                                                            ErrorMessage="<br />Please enter a validity to Date" Display="Dynamic" CssClass="rfvPCG"
                                                            runat="server" InitialValue="">
                                                        </asp:RequiredFieldValidator>
                                                        <asp:CompareValidator ControlToCompare="txtRuleValidityFrom" ControlToValidate="txtRuleValidityTo"
                                                            Display="Dynamic" CssClass="rfvPCG" ValidationGroup="btnSubmitRule" ErrorMessage="The Validity To must be greater than or equal to Validity From"
                                                            ID="CompareValidator2" Operator="GreaterThanEqual" Type="Date" runat="server" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="leftLabel">
                                                        <asp:Label ID="lblCommissionType" runat="server" Text="Commission Type:" CssClass="FieldName"></asp:Label>
                                                    </td>
                                                    <td class="rightData">
                                                        <asp:DropDownList ID="ddlCommissionType" runat="server" CssClass="cmbField" AutoPostBack="true"
                                                            OnSelectedIndexChanged="ddlCommissionType_Selectedindexchanged">
                                                        </asp:DropDownList>
                                                        <span id="Span16" class="spnRequiredField">*</span>
                                                        <br />
                                                        <asp:RequiredFieldValidator runat="server" ID="rfvCommissionType" ValidationGroup="btnSubmitRule"
                                                            Display="Dynamic" ControlToValidate="ddlCommissionType" Visible="true" ErrorMessage="Please Select Commission Type"
                                                            InitialValue="0" />
                                                    </td>
                                                    <td>
                                                        <asp:CheckBox ID="chkCloBack" runat="server" CssClass="cmbFielde" Visible="false"
                                                            Text="IsClawback" AutoPostBack="true" OnCheckedChanged="chkCloBack_OnCheckedChanged" />
                                                    </td>
                                                    <td id="tdlblClock" runat="server" visible="false" >
                                                        <asp:Label ID="lblClock" runat="server" CssClass="FieldName" Text="Age(Days):" Visible="false"  ></asp:Label>
                                                        <asp:TextBox ID="txtAge" runat="server" Visible="false" Maxlength="4"></asp:TextBox>
                                                        <span id="Span9" class="spnRequiredField">*</span>
                                                        <br />
                                                        <asp:RequiredFieldValidator Visible="false" runat="server" ID="RequiredFieldValidator15"
                                                            ValidationGroup="btnSubmitRule" Display="Dynamic" ControlToValidate="txtAge"
                                                            ErrorMessage="<br />Enter Age" Text="" />
                                                             <asp:RegularExpressionValidator ID="RegularExpressionValidator9" ControlToValidate="txtAge"
                                                            ErrorMessage=" </br>Enter Only three digits" runat="server" Display="Dynamic" CssClass="cvPCG"
                                                            ValidationExpression="^[0-9]{1,4}$" ValidationGroup="btnSubmitRule">     
                                                        </asp:RegularExpressionValidator>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="leftLabel">
                                                        <asp:Label ID="lblInvestorType" runat="server" Text="Investor type:" CssClass="FieldName"></asp:Label>
                                                    </td>
                                                    <td class="rightData">
                                                        <asp:DropDownList ID="ddlInvestorType" runat="server" CssClass="cmbField">
                                                        </asp:DropDownList>
                                                    </td>
                                                </tr>
                                                <tr id="trincentive" runat="server" visible="false">
                                                    <td class="leftLabel">
                                                        <asp:Label ID="lblType" runat="server" CssClass="FieldName" Text="Commision Sub Type:"></asp:Label>
                                                    </td>
                                                    <td class="rightData">
                                                        <asp:DropDownList ID="ddlIncentiveType" runat="server" CssClass="cmbField">
                                                        </asp:DropDownList>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td colspan="5">
                                                        <table style="border: 1px solid #6DBEE1; width: 100%">
                                                            <tr>
                                                                <td align="right" style="width: 17.5%;">
                                                                    <label class="FieldName">
                                                                        Applicable Parameter:</label>
                                                                </td>
                                                                <td colspan="2" style="width: 21%">
                                                                    <asp:CheckBox ID="chkCategory" runat="server" Text="Category" AutoPostBack="true"
                                                                        CssClass="cmbFielde" OnCheckedChanged="chkCategory_OnCheckedChanged" />
                                                                    <asp:CheckBox ID="chkSeries" runat="server" Text="Series" AutoPostBack="true" CssClass="cmbFielde"
                                                                        OnCheckedChanged="chkSeries_OnCheckedChanged" />
                                                                    <asp:CheckBox ID="chkMode" runat="server" Text="Mode" AutoPostBack="true" CssClass="cmbFielde"
                                                                        OnCheckedChanged="chkMode_OnCheckedChanged" Visible="false" />
                                                                    <asp:CheckBox ID="chkEForm" runat="server" Text="e-Form" CssClass="cmbFielde" Checked='<%# Eval("ACSR_EForm") == DBNull.Value ? false : Convert.ToBoolean(Eval("ACSR_EForm")) %>'
                                                                        Visible="false" OnCheckedChanged="chkEForm_OnCheckedChanged" AutoPostBack="true"/>
                                                                </td>
                                                                <td>
                                                                    <asp:CheckBoxList ID="chkListApplyTax" runat="server" CssClass="txtField" RepeatDirection="Horizontal"
                                                                        AutoPostBack="true" OnSelectedIndexChanged="chkListApplyTax_CheckChanged" Width="100%">
                                                                        <asp:ListItem Text="Service Tax" Value="ServiceTax"></asp:ListItem>
                                                                        <asp:ListItem Text="TDS" Value="TDS"></asp:ListItem>
                                                                        <asp:ListItem Text="SBC" Value="SBC"></asp:ListItem>
                                                                        <asp:ListItem Text="KKC" Value="KKC"></asp:ListItem>
                                                                        <asp:ListItem Text="Tax Inclusive" Value="TI"></asp:ListItem>
                                                                    </asp:CheckBoxList>
                                                                    <%-- <asp:CheckBoxList>
                                                        <asp:CheckBox ID="chkServiceTax" runat="server" CssClass="txtField" OnCheckedChanged="chkListApplyTax_CheckChanged"
                                                        AutoPostBack="true" />
                                                        <asp:CheckBox ID="chkTDS" runat="server" CssClass="txtField" OnCheckedChanged="chkListApplyTax_CheckChanged"
                                                        AutoPostBack="true" />--%>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="leftLabel" id="tdlblCategory" runat="server" visible="false">
                                                        <asp:Label ID="lblCategory" runat="server" CssClass="FieldName" Text="Category:"></asp:Label>
                                                    </td>
                                                    <td class="rightData" id="tdddlCategorys" runat="server" visible="false">
                                                        <asp:DropDownList ID="ddlCategorys" runat="server" CssClass="cmbField" OnSelectedIndexChanged="ddlCategorys_OnSelectedIndexChanged"
                                                            AutoPostBack="true">
                                                        </asp:DropDownList>
                                                        <span id="Span17" class="spnRequiredField">*</span>
                                                        <br />
                                                        <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator12" ValidationGroup="btnSubmitRule"
                                                            Display="Dynamic" ControlToValidate="ddlCategorys" Visible="true" ErrorMessage="Please Select Category"
                                                            InitialValue="0" />
                                                    </td>
                                                    <td class="leftLabel" id="tdlblSerise" runat="server" visible="false">
                                                        <asp:Label ID="lblSerise" runat="server" CssClass="FieldName" Text="Series:"></asp:Label>
                                                    </td>
                                                    <td class="rightData" id="tdddlSeries" runat="server" visible="false">
                                                        <asp:DropDownList ID="ddlSeries" runat="server" CssClass="cmbField" OnSelectedIndexChanged="ddlSeries_OnSelectedIndexChanged"
                                                            AutoPostBack="true">
                                                        </asp:DropDownList>
                                                        <span id="Span18" class="spnRequiredField">*</span>
                                                        <br />
                                                        <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator13" ValidationGroup="btnSubmitRule"
                                                            Display="Dynamic" ControlToValidate="ddlSeries" Visible="true" ErrorMessage="Please Select Category"
                                                            InitialValue="0" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="leftLabel" id="tdlblMode" runat="server" visible="false">
                                                        <asp:Label ID="lblMode" runat="server" CssClass="FieldName" Text="Select Mode:"></asp:Label>
                                                    </td>
                                                    <td class="rightData" id="tdddlMode" runat="server" visible="false">
                                                        <asp:DropDownList ID="ddlMode" runat="server" CssClass="cmbField">
                                                            <asp:ListItem Text="Select" Value="Select"></asp:ListItem>
                                                            <asp:ListItem Text="Demat" Value="DMT"></asp:ListItem>
                                                            <asp:ListItem Text="Physical" Value="PHY"></asp:ListItem>
                                                        </asp:DropDownList>
                                                        <span id="Span19" class="spnRequiredField">*</span>
                                                        <br />
                                                        <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator14" ValidationGroup="btnSubmitRule"
                                                            Display="Dynamic" ControlToValidate="ddlMode" Visible="true" ErrorMessage="Please Select Category"
                                                            InitialValue="Select" />
                                                    </td>
                                                    <td class="leftLabel" id="tdlblEform" runat="server" >
                                                        <asp:Label ID="lblEform" runat="server" CssClass="FieldName" Text="E-Form Series:"></asp:Label>
                                                    </td>
                                                    <td class="rightData" id="tdtxtEform" runat="server" >
                                                        <asp:TextBox ID="txtEForm"  runat="server"
                                                            CssClass="txtField" Visible="false"></asp:TextBox>
                                                        <cc1:TextBoxWatermarkExtender ID="TextBoxWatermarkExtender6" TargetControlID="txtEForm"
                                                            WatermarkText="Enter Application Series" runat="server" EnableViewState="false">
                                                        </cc1:TextBoxWatermarkExtender>
                                                         <asp:RequiredFieldValidator ID="RFVEForm" ControlToValidate="txtEForm"
                                                            ErrorMessage="<br />Enter Application No." Display="Dynamic" runat="server" CssClass="rfvPCG"
                                                            ValidationGroup="btnSubmitRule" InitialValue=""></asp:RequiredFieldValidator>
                                                             <asp:RegularExpressionValidator ID="REVEForm" ControlToValidate="txtEForm"
                                                            ErrorMessage=" </br> Enter in range Format with Semi colon" runat="server" Display="Dynamic" CssClass="cvPCG"
                                                            ValidationExpression="^((([0-9]*)([-])([0-9])*(;))*)([;]$)*" ValidationGroup="btnSubmitRule">     
                                                        </asp:RegularExpressionValidator>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="leftLabel">
                                                        <asp:Label ID="lblAppCityGroup" runat="server" Text="App for city group:" CssClass="FieldName"></asp:Label>
                                                    </td>
                                                    <td class="rightData">
                                                        <asp:DropDownList ID="ddlAppCityGroup" runat="server" CssClass="cmbField">
                                                        </asp:DropDownList>
                                                    </td>
                                                    <td class="leftLabel">
                                                        <asp:Label ID="lblReceivableFrequency" runat="server" Text="Receivable Fre:" CssClass="FieldName"></asp:Label>
                                                    </td>
                                                    <td class="rightData">
                                                        <asp:DropDownList ID="ddlReceivableFrequency" runat="server" CssClass="cmbField">
                                                        </asp:DropDownList>
                                                        <span id="Span5" class="spnRequiredField" runat="server" visible="false">*</span>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="leftLabel">
                                                        <asp:Label ID="lblCommissionApplicableLevel" runat="server" Text="Level:" CssClass="FieldName"
                                                            Visible="false"></asp:Label>
                                                    </td>
                                                    <td class="rightData">
                                                        <asp:DropDownList ID="ddlCommissionApplicableLevel" runat="server" CssClass="cmbField"
                                                            AutoPostBack="true" OnSelectedIndexChanged="ddlCommissionApplicableLevel_Selectedindexchanged"
                                                            Visible="false">
                                                        </asp:DropDownList>
                                                    </td>
                                                    <td class="leftLabel">
                                                        <asp:Label ID="lblApplyTaxes" runat="server" Text="Apply Taxes(%):" CssClass="FieldName"
                                                            Visible="false"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <table>
                                                            <tr>
                                                                <td>
                                                                    <asp:TextBox ID="txtTaxValue" Text='<%# Bind( "ACSR_ServiceTaxValue") %>' runat="server"
                                                                        CssClass="txtField" Visible="false"></asp:TextBox>
                                                                    <cc1:TextBoxWatermarkExtender ID="twtxtTaxValue" TargetControlID="txtTaxValue" WatermarkText="Enter Service Tax"
                                                                        runat="server" EnableViewState="false">
                                                                    </cc1:TextBoxWatermarkExtender>
                                                                     <asp:RegularExpressionValidator ID="RegularExpressionValidator10" ControlToValidate="txtTaxValue"
                                                            ErrorMessage=" </br>Enter Only Three Digit Number" runat="server" Display="Dynamic" CssClass="cvPCG"
                                                            ValidationExpression="^[0-9]{1,3}(\.[0-9]{1,3})?$" ValidationGroup="btnSubmitRule">     
                                                        </asp:RegularExpressionValidator>
                                                                </td>
                                                                <td>
                                                                    <asp:TextBox ID="txtSBCValue" Text='<%# Bind( "ACSR_SBCValue") %>' runat="server"
                                                                        CssClass="txtField" Visible="false"></asp:TextBox>
                                                                    <cc1:TextBoxWatermarkExtender ID="TextBoxWatermarkExtender4" TargetControlID="txtSBCValue"
                                                                        WatermarkText="Enter SBC Tax" runat="server" EnableViewState="false">
                                                                    </cc1:TextBoxWatermarkExtender>
                                                                      <asp:RegularExpressionValidator ID="RegularExpressionValidator11" ControlToValidate="txtSBCValue"
                                                            ErrorMessage=" </br>Enter Only Three Digit Number" runat="server" Display="Dynamic" CssClass="cvPCG"
                                                            ValidationExpression="^[0-9]{1,3}(\.[0-9]{1,3})?$" ValidationGroup="btnSubmitRule">     
                                                        </asp:RegularExpressionValidator> 
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <asp:TextBox ID="txtTDS" Text='<%# Bind( "ACSR_ReducedValue") %>' runat="server"
                                                                        CssClass="txtField" Visible="false"></asp:TextBox>
                                                                    <cc1:TextBoxWatermarkExtender ID="twttxtTDS" TargetControlID="txtTDS" WatermarkText="Enter  TDS Tax"
                                                                        runat="server" EnableViewState="false">
                                                                    </cc1:TextBoxWatermarkExtender>
                                                                      <asp:RegularExpressionValidator ID="RegularExpressionValidator13" ControlToValidate="txtTDS"
                                                            ErrorMessage="</br>Enter Only Three Digit Number" runat="server" Display="Dynamic" CssClass="cvPCG"
                                                            ValidationExpression="^[0-9]{1,3}(\.[0-9]{1,3})?$" ValidationGroup="btnSubmitRule">     
                                                        </asp:RegularExpressionValidator>
                                                                </td>
                                                                <td>
                                                                    <asp:TextBox ID="txtKKCValue" Text='<%# Bind( "ACSR_KKCValue") %>' runat="server"
                                                                        CssClass="txtField" Visible="false"></asp:TextBox>
                                                                    <cc1:TextBoxWatermarkExtender ID="TextBoxWatermarkExtender5" TargetControlID="txtKKCValue"
                                                                        WatermarkText="Enter KKC Tax" runat="server" EnableViewState="false">
                                                                    </cc1:TextBoxWatermarkExtender>
                                                                     <asp:RegularExpressionValidator ID="RegularExpressionValidator12" ControlToValidate="txtKKCValue"
                                                            ErrorMessage="</br>Enter Only Three Digit Number" runat="server" Display="Dynamic" CssClass="cvPCG"
                                                            ValidationExpression="^[0-9]{1,3}(\.[0-9]{1,3})?$" ValidationGroup="btnSubmitRule">     
                                                        </asp:RegularExpressionValidator> 
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="leftLabel">
                                                        <asp:Label ID="lblCalculatedOn" runat="server" Text="Calculated On:" CssClass="FieldName"></asp:Label>
                                                    </td>
                                                    <td class="rightData">
                                                        <asp:DropDownList ID="ddlCommisionCalOn" runat="server" CssClass="cmbField" OnSelectedIndexChanged="ddlCommisionCalOn_Selectedindexchanged"
                                                            AutoPostBack="true">
                                                        </asp:DropDownList>
                                                    </td>
                                                    <td class="leftLabel" id="tdlblApplicationNo" runat="server" visible="false">
                                                        <asp:Label ID="lblApplicationNo" runat="server" Text="Application No." CssClass="FieldName"></asp:Label>
                                                    </td>
                                                    <td class="rightData" id="tdApplicationNo" runat="server" visible="false">
                                                        <asp:TextBox ID="txtApplicationNo" runat="server" Text='<%# Bind( "CO_ApplicationNo") %>'></asp:TextBox>
                                                        <span id="Span8" class="spnRequiredField">*<br>
                                                        </span>
                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" ControlToValidate="txtApplicationNo"
                                                            ErrorMessage="<br />Enter Application No." Display="Dynamic" runat="server" CssClass="rfvPCG"
                                                            ValidationGroup="btnSubmitRule" InitialValue=""></asp:RequiredFieldValidator>
                                                        <asp:RegularExpressionValidator ID="reqtxtstartDate" ControlToValidate="txtApplicationNo"
                                                            ErrorMessage=" </br>Enter Only Number" runat="server" Display="Dynamic" CssClass="cvPCG"
                                                            ValidationExpression="^([a-zA-Z0-9]+(,[a-zA-Z0-9]+)*)?$" ValidationGroup="btnSubmitRule">     
                                                        </asp:RegularExpressionValidator>
                                                    </td>
                                                </tr>
                                                <tr runat="server" id="trMinMAxInvAmount" visible="false">
                                                    <td class="leftLabel">
                                                        <asp:Label ID="lblMinInvestmentAmount" runat="server" Text="Min. Investment Amount:"
                                                            CssClass="FieldName"></asp:Label>
                                                    </td>
                                                    <td class="rightData">
                                                        <asp:TextBox ID="txtMinInvestmentAmount" Text='<%# Bind( "ACSR_MinInvestmentAmount") %>'
                                                            runat="server" CssClass="txtField"></asp:TextBox>
                                                        <span id="Span10" class="spnRequiredField" runat="server" visible="true">*</span>
                                                        <asp:RequiredFieldValidator runat="server" ID="rfvtxtMinInvestmentAmount" ValidationGroup="btnSubmitRule"
                                                            Display="Dynamic" ControlToValidate="txtMinInvestmentAmount" ErrorMessage="<br />Min. Investment Amount is mandatory"
                                                            Text="" />
                                                        <asp:RegularExpressionValidator ID="RegularExpressionValidator1" ControlToValidate="txtMinInvestmentAmount"
                                                            ErrorMessage=" </br>Enter Only Ten Digits" runat="server" Display="Dynamic" CssClass="cvPCG"
                                                            ValidationExpression="^[0-9]{1,10}(\.[0-9]{1,3})?$" ValidationGroup="btnSubmitRule">     
                                                        </asp:RegularExpressionValidator>
                                                    </td>
                                                    <td class="leftLabel">
                                                        <asp:Label ID="lblMaxInvestmentAmount" runat="server" Text="Max. Investment Amount:"
                                                            CssClass="FieldName"></asp:Label>
                                                    </td>
                                                    <td class="rightData">
                                                        <asp:TextBox ID="txtMaxInvestmentAmount" Text='<%# Bind( "ACSR_MaxInvestmentAmount") %>'
                                                            runat="server" CssClass="txtField"></asp:TextBox>
                                                        <span id="Span7" class="spnRequiredField" runat="server" visible="true">*</span>
                                                        <asp:RequiredFieldValidator runat="server" ID="rfvtxtMaxInvestmentAmount" ValidationGroup="btnSubmitRule"
                                                            Display="Dynamic" ControlToValidate="txtMaxInvestmentAmount" ErrorMessage="<br />Max. Investment Amount is mandatory"
                                                            Text="" />
                                                        <asp:RegularExpressionValidator ID="RegularExpressionValidator2" ControlToValidate="txtMaxInvestmentAmount"
                                                            ErrorMessage=" </br>Enter Only Ten Digits" runat="server" Display="Dynamic" CssClass="cvPCG"
                                                            ValidationExpression="^[0-9]{1,10}(\.[0-9]{1,3})?$" ValidationGroup="btnSubmitRule">     
                                                        </asp:RegularExpressionValidator>
                                                         <asp:CompareValidator ID="CompareValidator3" runat="server" ErrorMessage="<br/>Max Investment must be Greater than Min Investment"
                                                            ControlToValidate="txtMaxInvestmentAmount"  ControlToCompare="txtMinInvestmentAmount" CssClass="cvPCG" Operator="GreaterThan" 
                                                            ValidationGroup="btnSubmitRule" Display="Dynamic" Type="Double"></asp:CompareValidator>
                                                           
                                                    </td>
                                                    <td class="leftLabel">
                                                    </td>
                                                </tr>
                                                  <tr runat="server" id="trMinAndMaxNumberOfApplication" visible="false">
                                                    <td class="leftLabel" runat="server" id="tdlb1MinNumberOfApplication">
                                                        <asp:Label ID="lblMinNumberOfApplication" runat="server" Text="Min. no. of applications:"
                                                            CssClass="FieldName"></asp:Label>
                                                        <br />
                                                        <span id="Span4" class="spnRequiredField">&nbsp;</span>
                                                    </td>
                                                    <td class="rightData" runat="server" id="tdtxtMinNumberOfApplication">
                                                        <asp:TextBox ID="txtMinNumberOfApplication" Text='<%# Bind( "ACSR_MinNumberOfApplications") %>'
                                                            runat="server" CssClass="txtField"></asp:TextBox>
                                                        <asp:RegularExpressionValidator ID="RegularExpressionValidator7" ControlToValidate="txtMinNumberOfApplication"
                                                            ErrorMessage=" </br>Enter Only Number" runat="server" Display="Dynamic" CssClass="cvPCG"
                                                            ValidationExpression="^[0-9]*$" ValidationGroup="btnSubmitRule">     
                                                        </asp:RegularExpressionValidator>
                                                    </td>
                                                    <td class="leftLabel" runat="server" id="tdlb1MaxNumberOfApplication">
                                                        <asp:Label ID="lblMaxNumberOfApplication" runat="server" Text="Max. no. of applications:"
                                                            CssClass="FieldName"></asp:Label>
                                                        <span id="Span13" class="spnRequiredField">&nbsp;</span>
                                                    </td>
                                                    <td class="rightData" runat="server" id="tdtxtMaxNumberOfApplication">
                                                        <asp:TextBox ID="txtMaxNumberOfApplication" Text='<%# Bind( "ACSR_MaxNumberOfApplications") %>'
                                                            runat="server" CssClass="txtField"></asp:TextBox>
                                                        <asp:RegularExpressionValidator ID="RegularExpressionValidator8" ControlToValidate="txtMaxNumberOfApplication"
                                                            ErrorMessage=" </br>Enter Only Number" runat="server" Display="Dynamic" CssClass="cvPCG"
                                                            ValidationExpression="^[0-9]*$" ValidationGroup="btnSubmitRule">     
                                                        </asp:RegularExpressionValidator>
                                                    </td>
                                                </tr>
                                                <tr id="trMinMaxAge" runat="server">
                                                    <td class="leftLabel">
                                                        <asp:Label ID="lblMinInvestAge" runat="server" Text="Min. Investment age :" CssClass="FieldName"></asp:Label>
                                                    </td>
                                                    <td class="rightData">
                                                        <asp:TextBox ID="txtMinInvestAge" Text='<%# Bind( "ACSR_MinInvestmentAge") %>' runat="server"
                                                            CssClass="txtField"></asp:TextBox>
                                                        <asp:RegularExpressionValidator ID="RegularExpressionValidator3" ControlToValidate="txtMinInvestAge"
                                                            ErrorMessage=" </br>Enter Only Five Digits" runat="server" Display="Dynamic" CssClass="cvPCG"
                                                            ValidationExpression="^[0-9]{1,5}$" ValidationGroup="btnSubmitRule">     
                                                        </asp:RegularExpressionValidator>
                                                    </td>
                                                    <td class="leftLabel">
                                                        <asp:Label ID="lblMaxInvestAge" runat="server" Text="Max. Investment age :" CssClass="FieldName"></asp:Label>
                                                    </td>
                                                    <td class="rightData" colspan="2">
                                                        <asp:TextBox ID="txtMaxInvestAge" Text='<%# Bind( "ACSR_MaxInvestmentAge") %>' runat="server"
                                                            CssClass="txtField"></asp:TextBox>
                                                        <asp:RegularExpressionValidator ID="RegularExpressionValidator4" ControlToValidate="txtMaxInvestAge"
                                                            ErrorMessage=" </br>Enter Only Five Digits" runat="server" Display="Dynamic" CssClass="cvPCG"
                                                            ValidationExpression="^[0-9]{1,5}$" ValidationGroup="btnSubmitRule">     
                                                        </asp:RegularExpressionValidator>
                                                        <asp:DropDownList ID="ddlInvestAgeTenure" runat="server" CssClass="cmbField" Style="width: 100px !Important">
                                                            <asp:ListItem Text="Days" Value="Days"></asp:ListItem>
                                                           <%-- <asp:ListItem Text="Years" Value="Years"></asp:ListItem>
                                                            <asp:ListItem Text="Months" Value="Months"></asp:ListItem>--%>
                                                        </asp:DropDownList>
                                                    </td>
                                                </tr>
                                                <tr runat="server" id="trTransactionTypeSipFreq">
                                                    <td class="leftLabel" runat="server" id="tdlb1TransactionType">
                                                        <asp:Label ID="lblTransactionType" runat="server" Text="Transaction type:" CssClass="FieldName"></asp:Label>
                                                    </td>
                                                    <td class="rightData" runat="server" id="tdtxtTransactionType">
                                                        <asp:DropDownList Visible="true" ID="ddlTransaction" runat="server" CssClass="cmbField"
                                                            AutoPostBack="true" OnSelectedIndexChanged="ddlTransaction_Selectedindexchanged">
                                                            <asp:ListItem Text="All" Value="All">
                                                            </asp:ListItem>
                                                            <asp:ListItem Text="Systematic Transaction" Value="SIP">
                                                            </asp:ListItem>
                                                            <asp:ListItem Text="NonSystematic Transaction" Value="NonSIP">
                                                            </asp:ListItem>
                                                        </asp:DropDownList>
                                                        <asp:RequiredFieldValidator ID="rfvddlTransaction" runat="server" ErrorMessage="<br />Please Select Transaction type"
                                                            Enabled="false" CssClass="rfvPCG" ControlToValidate="ddlTransaction" ValidationGroup="btnStrAddUpdate"
                                                            Display="Dynamic" InitialValue="0"></asp:RequiredFieldValidator><br />
                                                    </td>
                                                    <td class="leftLabel" runat="server" id="tdlb1SipFreq">
                                                        <asp:Label ID="lblSIPFrequency" runat="server" Text="SIP Frequency:" CssClass="FieldName"></asp:Label>
                                                    </td>
                                                    <td class="rightData" runat="server" id="tdddlSipFreq">
                                                        <asp:DropDownList ID="ddlSIPFrequency" runat="server" CssClass="cmbField">
                                                        </asp:DropDownList>
                                                    </td>
                                                    <td class="leftLabel">
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                    </td>
                                                    <td id="tdchkListTtansactionType" runat="server">
                                                        <asp:CheckBoxList ID="chkListTtansactionType" runat="server" CssClass="txtField"
                                                            Visible="false" RepeatLayout="Flow" RepeatDirection="Horizontal">
                                                        </asp:CheckBoxList>
                                                    </td>
                                                </tr>
                                                <tr id="trMinMaxTenure" runat="server">
                                                    <td class="leftLabel">
                                                        <asp:Label ID="lblMinTenure" runat="server" Text="Min. Tenure:" CssClass="FieldName"></asp:Label>
                                                    </td>
                                                    <td class="rightData">
                                                        <asp:TextBox ID="txtMinTenure" Text='<%# Bind( "ACSR_MinTenure") %>' runat="server"
                                                            CssClass="txtField"></asp:TextBox>
                                                        <asp:RegularExpressionValidator ID="RegularExpressionValidator5" ControlToValidate="txtMinTenure"
                                                            ErrorMessage=" </br>Enter Only Number" runat="server" Display="Dynamic" CssClass="cvPCG"
                                                            ValidationExpression="^[0-9]*$" ValidationGroup="btnSubmitRule">     
                                                        </asp:RegularExpressionValidator>
                                                    </td>
                                                    <td class="leftLabel">
                                                        <asp:Label ID="lblMaxTenure" runat="server" Text="Max. Tenure:" CssClass="FieldName"></asp:Label>
                                                    </td>
                                                    <td class="rightData" colspan="2">
                                                        <asp:TextBox ID="txtMaxTenure" Text='<%# Bind( "ACSR_MaxTenure") %>' runat="server"
                                                            CssClass="txtField"></asp:TextBox>
                                                        <asp:RegularExpressionValidator ID="RegularExpressionValidator6" ControlToValidate="txtMaxTenure"
                                                            ErrorMessage=" </br>Enter Only Number" runat="server" Display="Dynamic" CssClass="cvPCG"
                                                            ValidationExpression="^[0-9]*$" ValidationGroup="btnSubmitRule">     
                                                        </asp:RegularExpressionValidator>
                                                        <asp:DropDownList ID="ddlTenureFrequency" runat="server" CssClass="cmbField" Style="width: 100px !Important">
                                                            <asp:ListItem Text="Day" Value="Day"></asp:ListItem>
                                                            <asp:ListItem Text="Month" Value="Month"></asp:ListItem>
                                                            <asp:ListItem Text="Installment" Value="Installment"></asp:ListItem>
                                                            <asp:ListItem Text="Year" Value="Year"></asp:ListItem>
                                                        </asp:DropDownList>
                                                    </td>
                                                </tr>
                                              
                                                <tr>
                                                    <td class="leftLabel">
                                                        <asp:Label ID="lblRuleNote" runat="server" Text="Comment:" CssClass="FieldName"></asp:Label>
                                                    </td>
                                                    <td class="rightData">
                                                        <asp:TextBox ID="txtStruRuleComment" runat="server" CssClass="txtField" Text='<%# Bind( "ACSR_Comment") %>'
                                                            TextMode="MultiLine"></asp:TextBox>
                                                    </td>
                                                    <td class="leftLabel">
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="rightData" colspan="2">
                                                        <asp:Button ID="btnSubmitRule" ValidationGroup="btnSubmitRule" Text='<%# (Container is GridEditFormInsertItem) ? "Insert" : "Update" %>'
                                                            CssClass="PCGButton" runat="server" CommandName='<%# (Container is GridEditFormInsertItem) ? "PerformInsert" : "Update" %>'
                                                            CausesValidation="true"></asp:Button>&nbsp;
                                                        <asp:Button ID="Button2" CssClass="PCGButton" Text="Close" runat="server" CausesValidation="false"
                                                            CommandName="Cancel"></asp:Button>
                                                    </td>
                                                </tr>
                                                <tr runat="server" id="trCity" visible="false">
                                                    <td colspan="4">
                                                        <div>
                                                            <div style="float: left; padding-right: 10px; clear: both">
                                                                <asp:Label ID="Label13" runat="server" Text="Note:" CssClass="FieldName"></asp:Label>
                                                            </div>
                                                            <div style="float: left">
                                                                <asp:Label ID="Label12" runat="server" Font-Size="6.5" Text="T15 cities : Ahmedabad, Bangalore, Baroda, Chandigarh, Chennai, Hyderabad (including Secunderabad), Jaipur, Kanpur, Kolkata,<br /> Lucknow, Mumbai(Including Thane & Navi Mumbai), New Delhi(including NCR), Panjim, Pune and Surat <br /><br />B15 cities : cities that are not in T15"
                                                                    CssClass="FieldName"></asp:Label>
                                                            </div>
                                                        </div>
                                                        <br />
                                                    </td>
                                                </tr>
                                                <%--<td id="tdRuleDetails" runat="server">--%>
                                                <tr id="trRuleDetailSection" class="leftLabel" visible="false" runat="server">
                                                    <td colspan="5" class="tdSectionHeading">
                                                        <div class="divSectionHeading">
                                                            <div class="divSectionHeadingNumber">
                                                                3.2
                                                            </div>
                                                            <div style="float: left; padding-left: 5px;">
                                                                <asp:Label ID="Label14" runat="server" Text="Rates"></asp:Label>
                                                            </div>
                                                        </div>
                                                    </td>
                                                    <%--  <td style="text-align: left; width: 250px;">>
                                                     <asp:Label ID="Label14" runat="server" Text="Rates"></asp:Label>
                                                    </td>--%>
                                                </tr>
                                                <tr runat="server" id="CommissionTypeCaliculation" class="rightData">
                                                    <td colspan="2">
                                                        <telerik:RadGrid ID="rgCommissionTypeCaliculation" runat="server" AllowSorting="True"
                                                            enableloadondemand="True" PageSize="5" AutoGenerateColumns="False" EnableEmbeddedSkins="False"
                                                            GridLines="None" ShowFooter="false" PagerStyle-AlwaysVisible="true" AllowPaging="false"
                                                            ShowStatusBar="True" Skin="Telerik" AllowFilteringByColumn="false" OnNeedDataSource="rgCommissionTypeCaliculation_OnNeedDataSource"
                                                            OnItemCommand="rgCommissionTypeCaliculation_ItemCommand" OnItemDataBound="rgCommissionTypeCaliculation_ItemDataBound"
                                                            Visible="false">
                                                            <MasterTableView AllowMultiColumnSorting="True" AllowSorting="true" AutoGenerateColumns="false"
                                                                Width="100%" EditMode="PopUp" CommandItemSettings-AddNewRecordText="Add Rates"
                                                                CommandItemDisplay="Top" DataKeyNames="CSRD_StructureRuleDetailsId,XB_BrokerIdentifier"
                                                                CommandItemSettings-ShowRefreshButton="false">
                                                                <Columns>
                                                                    <telerik:GridEditCommandColumn EditText="Edit" UniqueName="editColumn" CancelText="Cancel"
                                                                        UpdateText="Update" HeaderStyle-Width="20px">
                                                                    </telerik:GridEditCommandColumn>
                                                                    <telerik:GridBoundColumn DataField="CSRD_StructureRuleDetailsId" HeaderStyle-Width="20px"
                                                                        CurrentFilterFunction="Contains" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                                                        HeaderText="Issuer Name" UniqueName="CSRD_StructureRuleDetailsId" SortExpression="CSRD_StructureRuleDetailsId"
                                                                        AllowFiltering="true" Visible="false">
                                                                        <ItemStyle HorizontalAlign="left" VerticalAlign="Top" Width="" Wrap="false" />
                                                                    </telerik:GridBoundColumn>
                                                                    <telerik:GridBoundColumn DataField="CSRD_RateName" HeaderStyle-Width="20px" CurrentFilterFunction="Contains"
                                                                        ShowFilterIcon="false" AutoPostBackOnFilter="true" HeaderText="Rate Name" UniqueName="CSRD_RateName"
                                                                        SortExpression="CSRD_RateName" AllowFiltering="true">
                                                                        <ItemStyle HorizontalAlign="left" VerticalAlign="Top" Width="" Wrap="false" />
                                                                    </telerik:GridBoundColumn>
                                                                    <telerik:GridBoundColumn DataField="XB_BrokerShortName" HeaderStyle-Width="20px"
                                                                        CurrentFilterFunction="Contains" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                                                        HeaderText="Broker" UniqueName="XB_BrokerShortName" SortExpression="XB_BrokerShortName"
                                                                        AllowFiltering="true">
                                                                        <ItemStyle HorizontalAlign="left" VerticalAlign="Top" Width="" Wrap="false" />
                                                                    </telerik:GridBoundColumn>
                                                                    <telerik:GridBoundColumn DataField="ACSR_CommissionStructureRuleId" HeaderStyle-Width="20px"
                                                                        CurrentFilterFunction="Contains" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                                                        HeaderText="Issuer Name" UniqueName="ACSR_CommissionStructureRuleId" SortExpression="ACSR_CommissionStructureRuleId"
                                                                        AllowFiltering="true" Visible="false">
                                                                        <ItemStyle HorizontalAlign="left" VerticalAlign="Top" Width="" Wrap="false" />
                                                                    </telerik:GridBoundColumn>
                                                                    <telerik:GridBoundColumn DataField="CSRD_WCMV_CommissionTypeId" HeaderStyle-Width="20px"
                                                                        CurrentFilterFunction="Contains" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                                                        HeaderText="Commission Type" UniqueName="CSRD_WCMV_CommissionTypeId" SortExpression="CSRD_WCMV_CommissionTypeId"
                                                                        AllowFiltering="true">
                                                                        <ItemStyle HorizontalAlign="left" VerticalAlign="Top" Width="" Wrap="false" />
                                                                    </telerik:GridBoundColumn>
                                                                    <telerik:GridBoundColumn DataField="CSRD_BrokageValue" HeaderStyle-Width="20px" CurrentFilterFunction="Contains"
                                                                        ShowFilterIcon="false" AutoPostBackOnFilter="true" HeaderText="Brokrage Value"
                                                                        UniqueName="CSRD_BrokageValue" SortExpression="CSRD_BrokageValue" AllowFiltering="true">
                                                                        <ItemStyle HorizontalAlign="left" VerticalAlign="Top" Width="" Wrap="false" />
                                                                    </telerik:GridBoundColumn>
                                                                    <telerik:GridBoundColumn DataField="WCU_UnitCode" HeaderStyle-Width="20px" CurrentFilterFunction="Contains"
                                                                        ShowFilterIcon="false" AutoPostBackOnFilter="true" HeaderText="Brokrage Unit"
                                                                        UniqueName="WCU_UnitCode" SortExpression="WCU_UnitCode" AllowFiltering="true">
                                                                        <ItemStyle HorizontalAlign="left" VerticalAlign="Top" Width="" Wrap="false" />
                                                                    </telerik:GridBoundColumn>
                                                                    <telerik:GridButtonColumn UniqueName="deleteColumn" ConfirmText="Are you sure you want to delete?"
                                                                        ConfirmDialogType="RadWindow" ConfirmTitle="Delete" ButtonType="LinkButton" CommandName="Delete"
                                                                        Text="Delete" Visible="false">
                                                                        <ItemStyle HorizontalAlign="Center" CssClass="MyImageButton" />
                                                                    </telerik:GridButtonColumn>
                                                                </Columns>
                                                                <EditFormSettings EditFormType="Template" PopUpSettings-Height="250px" PopUpSettings-Width="400px">
                                                                    <FormTemplate>
                                                                        <table width="100%" cellspacing="3" cellpadding="3">
                                                                            <tr>
                                                                                <td class="leftLabel">
                                                                                    <asp:Label ID="lblRatename" runat="server" Text="Rate Name:" CssClass="FieldName"></asp:Label>
                                                                                </td>
                                                                                <td class="rightData">
                                                                                    <asp:TextBox ID="txtRateName" runat="server" Text='<%# Bind ("CSRD_RateName") %>'></asp:TextBox>
                                                                                </td>
                                                                            </tr>
                                                                            <tr>
                                                                                <td class="leftLabel">
                                                                                    <asp:Label ID="Label3" runat="server" Text="Commission Type:" CssClass="FieldName"></asp:Label>
                                                                                </td>
                                                                                <td class="rightData">
                                                                                    <asp:DropDownList ID="ddlCommissionype" runat="server" CssClass="cmbField" AutoPostBack="false"
                                                                                        OnSelectedIndexChanged="ddlCommissionype_OnSelectedIndexChanged">
                                                                                    </asp:DropDownList>
                                                                                    <br />
                                                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" CssClass="rfvPCG"
                                                                                        ErrorMessage="Please Select CommissionType" Display="Dynamic" ControlToValidate="ddlCommissionype"
                                                                                        InitialValue="Select" ValidationGroup="rgApllOk">
                                                                                    </asp:RequiredFieldValidator>
                                                                                </td>
                                                                            </tr>
                                                                            <tr>
                                                                                <td class="leftLabel">
                                                                                    <asp:Label ID="Label17" runat="server" Text="Mode Type:" CssClass="FieldName"></asp:Label>
                                                                                </td>
                                                                                <td class="rightData">
                                                                                    <asp:DropDownList ID="ddlmode" runat="server" CssClass="cmbField" AutoPostBack="false">
                                                                                    </asp:DropDownList>
                                                                                    <br />
                                                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator17" runat="server" CssClass="rfvPCG"
                                                                                        ErrorMessage="Please Select Mode Type" Display="Dynamic" ControlToValidate="ddlmode"
                                                                                        InitialValue="Select" ValidationGroup="rgApllOk">
                                                                                    </asp:RequiredFieldValidator>
                                                                                </td>
                                                                            </tr>
                                                                            <tr>
                                                                                <td class="leftLabel" id="tdlblBrokerCode" runat="server" visible="true">
                                                                                    <asp:Label runat="server" ID="lblBrokerCode" CssClass="FieldName" Text="Broker:"></asp:Label>
                                                                                </td>
                                                                                <td class="rightData" id="tdddlBrokerCode" runat="server" visible="true">
                                                                                    <asp:DropDownList ID="ddlBrokerCode" runat="server" CssClass="cmbField">
                                                                                    </asp:DropDownList>
                                                                                    <span id="Span13" class="spnRequiredField">*</span>
                                                                                    <asp:RequiredFieldValidator ID="ReqddlBrokerCode" ControlToValidate="ddlBrokerCode"
                                                                                        ErrorMessage="<br />Please Select Broker" Display="Dynamic" runat="server" CssClass="rfvPCG"
                                                                                        ValidationGroup="rgApllOk" InitialValue="0"></asp:RequiredFieldValidator>
                                                                                </td>
                                                                            </tr>
                                                                            <tr>
                                                                                <td class="leftLabel">
                                                                                    <asp:Label ID="lblBrokerageValue" runat="server" Text="Brokerage Value:" CssClass="FieldName"></asp:Label>
                                                                                </td>
                                                                                <td class="rightData">
                                                                                    <asp:TextBox ID="txtBrokerageValue" runat="server" CssClass="txtField"></asp:TextBox>
                                                                                    <span id="Span8" class="spnRequiredField" runat="server" visible="true">*</span>
                                                                                    <asp:RequiredFieldValidator runat="server" ID="reqName" ValidationGroup="rgApllOk"
                                                                                        Display="Dynamic" ControlToValidate="txtBrokerageValue" ErrorMessage="<br />Brokerage value is mandatory"
                                                                                        Text="" />
                                                                                    <asp:RangeValidator ID="RangeValidator1" Display="Dynamic" ValidationGroup="rgApllOk"
                                                                                        runat="server" ErrorMessage="<br />Please enter a numeric value" ControlToValidate="txtBrokerageValue"
                                                                                        MaximumValue="2147483647" MinimumValue="0" Type="Double" CssClass="cvPCG"></asp:RangeValidator>
                                                                                </td>
                                                                            </tr>
                                                                            <tr>
                                                                                <td class="leftLabel">
                                                                                    <asp:Label ID="lblUnit" runat="server" Text="Brokerage Unit:" CssClass="FieldName"></asp:Label>
                                                                                </td>
                                                                                <td class="rightData">
                                                                                    <asp:DropDownList ID="ddlBrokerageUnit" runat="server" CssClass="cmbField" OnSelectedIndexChanged="ddlBrokerageUnit_OnSelectedIndexChanged">
                                                                                    </asp:DropDownList>
                                                                                    <span id="Span15" class="spnRequiredField" runat="server" visible="true">*</span>
                                                                                    <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator11" ValidationGroup="rgApllOk"
                                                                                        Display="Dynamic" ControlToValidate="ddlBrokerageUnit" ErrorMessage="<br />Brokerage Unit"
                                                                                        InitialValue="0" />
                                                                                </td>
                                                                                <td class="leftLabel">
                                                                                </td>
                                                                            </tr>
                                                                            <tr>
                                                                                <td class="leftLabel">
                                                                                    <asp:Button ID="btnOK" runat="server" CssClass="PCGButton" CommandName='<%# (Container is GridEditFormInsertItem) ? "PerformInsert" : "Update" %>'
                                                                                        Text='<%# (Container is GridEditFormInsertItem) ? "Insert" : "Update" %>' CausesValidation="True"
                                                                                        ValidationGroup="rgApllOk"></asp:Button>
                                                                                </td>
                                                                                <td class="rightData">
                                                                                    <asp:Button ID="btnCancel" Text="Cancel" runat="server" CausesValidation="False"
                                                                                        CssClass="PCGButton" CommandName="Cancel"></asp:Button>
                                                                                </td>
                                                                                <td class="leftLabel" colspan="2">
                                                                                    &nbsp;
                                                                                </td>
                                                                            </tr>
                                                                        </table>
                                                                    </FormTemplate>
                                                                </EditFormSettings>
                                                            </MasterTableView>
                                                        </telerik:RadGrid>
                                                    </td>
                                                    <td colspan="1">
                                                    </td>
                                                </tr>
                                                <%--<tr>
                                                 <%--   <td colspan="5">
                                                        <asp:CustomValidator ID="CustomValidator1" runat="server" Text="Min. invest amount should be less than Max. invest"
                                                            ControlToValidate="txtMaxInvestmentAmount" ClientValidationFunction="InvestmentAmountValidation"
                                                            ValidateEmptyText="true" ValidationGroup="btnSubmitRule" Display="Dynamic" SetFocusOnError="true">
                                                        </asp:CustomValidator>
                                                        <asp:CustomValidator ID="CustomValidator2" runat="server" Text="Min. Tenure should be less than Max. Tenure"
                                                            ControlToValidate="txtMaxTenure" ClientValidationFunction="TenureValidation"
                                                            ValidateEmptyText="true" ValidationGroup="btnSubmitRule" Display="Dynamic" SetFocusOnError="true">
                                                        </asp:CustomValidator>
                                                        <asp:CustomValidator ID="CustomValidator3" runat="server" Text="Min. Investment Age should be less than Max. Investment Age"
                                                            ControlToValidate="txtMaxInvestAge" ClientValidationFunction="InvestmentAgeValidation"
                                                            ValidateEmptyText="true" ValidationGroup="btnSubmitRule" Display="Dynamic" SetFocusOnError="true">
                                                        </asp:CustomValidator>
                                                    </td>--%>
                                                <%--  </tr> --%>
                                            </table>
                                        </FormTemplate>
                                    </EditFormSettings>
                                </MasterTableView>
                            </telerik:RadGrid>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Button ID="btnCreateRule" runat="server" CssClass="PCGButton" Text="Create Rule"
                                OnClick="btnCreateRule_OnClick" Visible="false" />
                        </td>
                    </tr>
                </table>
            </asp:Panel>
            <table id="Table5" runat="server" width="100%" style="float: left; padding-right: 10px;
                clear: both" visible="false">
                <tr id="trPayableMapping" runat="server" visible="false">
                    <td colspan="5" class="tdSectionHeading">
                        <div class="divSectionHeading" style="vertical-align: text-bottom">
                            <div style="float: left; padding-left: 3px">
                                <asp:ImageButton ID="ImageButton7" runat="server" alt="Collapse/Expand" ImageUrl="~/Images/toggle-collapse-alt_blue.png"
                                    Height="28px" Width="30px" Style="float: right; cursor: hand;" OnClick="ImageButton7_Click"
                                    ToolTip="Collapse" />
                            </div>
                            <div class="divSectionHeadingNumber fltlftStep">
                                4
                            </div>
                            &nbsp;
                            <div class="fltlftStep" style="width: 300px;">
                                &nbsp;
                                <asp:Label ID="Label15" runat="server" Text="Associate Payable Mapped"></asp:Label>
                            </div>
                            <div class="divViewEdit" style="padding-right: 10px; width: 90px;">
                                <asp:ImageButton ID="ImageButton6" ImageUrl="~/App_Themes/Maroon/Images/Export_Excel.png"
                                    runat="server" AlternateText="Excel" ToolTip="Export To Excel" OnClick="ibtExport_OnClick"
                                    Height="22px" Width="25px" Visible="false"></asp:ImageButton>
                            </div>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>
                        <telerik:RadGrid ID="gvPayaMapping" AllowSorting="false" runat="server" AllowAutomaticInserts="false"
                            AllowPaging="True" AutoGenerateColumns="False" AllowFilteringByColumn="true"
                            ShowHeader="true" EnableEmbeddedSkins="false" GridLines="none" ShowFooter="true"
                            PagerStyle-AlwaysVisible="true" EnableViewState="true" ShowStatusBar="true" Skin="Telerik"
                            OnNeedDataSource="gvPayaMapping_NeedDataSource" OnItemCommand="gvPayaMapping_ItemCommand"
                            Visible="false" Width="98%">
                            <HeaderContextMenu EnableEmbeddedSkins="False">
                            </HeaderContextMenu>
                            <ExportSettings HideStructureColumns="true" ExportOnlyData="true" FileName="PayableMapping"
                                IgnorePaging="true">
                            </ExportSettings>
                            <PagerStyle AlwaysVisible="True" />
                            <MasterTableView AllowMultiColumnSorting="True" AllowSorting="true" AutoGenerateColumns="false"
                                CommandItemSettings-ShowRefreshButton="true" Width="100%" DataKeyNames="CSRD_StructureRuleDetailsId,AAC_AdviserAgentId,AC_Category">
                                <CommandItemSettings ExportToExcelText="Export to excel" />
                                <Columns>
                                    <telerik:GridBoundColumn DataField="CSRD_StructureRuleDetailsId" HeaderStyle-Width="70px"
                                        CurrentFilterFunction="Contains" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                        HeaderText="Rule Det. Id" UniqueName="CSRD_StructureRuleDetailsId" ReadOnly="true"
                                        Visible="false">
                                        <ItemStyle HorizontalAlign="left" VerticalAlign="Top" Width="40px" Wrap="false" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="RuleName" HeaderStyle-Width="70px" CurrentFilterFunction="Contains"
                                        ShowFilterIcon="false" AutoPostBackOnFilter="true" HeaderText="Rule Name" UniqueName="RuleName"
                                        ReadOnly="true">
                                        <ItemStyle HorizontalAlign="left" VerticalAlign="Top" Width="40px" Wrap="false" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="CSRD_BrokageValue" HeaderStyle-Width="70px" CurrentFilterFunction="Contains"
                                        ShowFilterIcon="false" AutoPostBackOnFilter="true" HeaderText="Broker/Rate(%)"
                                        UniqueName="CSRD_BrokageValue" ReadOnly="true">
                                        <ItemStyle HorizontalAlign="left" VerticalAlign="Top" Width="40px" Wrap="false" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="AAC_AdviserAgentId" HeaderStyle-Width="70px"
                                        CurrentFilterFunction="Contains" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                        HeaderText="AgentId" UniqueName="AAC_AdviserAgentId" ReadOnly="true" Visible="false">
                                        <ItemStyle HorizontalAlign="left" VerticalAlign="Top" Width="40px" Wrap="false" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="MappingFor" HeaderStyle-Width="70px" CurrentFilterFunction="Contains"
                                        ShowFilterIcon="false" AutoPostBackOnFilter="true" HeaderText="Mapping For" UniqueName="MappingFor"
                                        ReadOnly="true">
                                        <ItemStyle HorizontalAlign="left" VerticalAlign="Top" Width="40px" Wrap="false" />
                                    </telerik:GridBoundColumn>
                                    <%--  <telerik:GridBoundColumn DataField="Type" HeaderStyle-Width="70px"
                                            CurrentFilterFunction="Contains" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                            HeaderText="Type" UniqueName="Type" ReadOnly="true">
                                            <ItemStyle HorizontalAlign="left" VerticalAlign="Top" Width="40px" Wrap="false" />
                                        </telerik:GridBoundColumn>--%>
                                    <telerik:GridBoundColumn DataField="ACC_UserType" HeaderStyle-Width="70px" CurrentFilterFunction="Contains"
                                        ShowFilterIcon="false" AutoPostBackOnFilter="true" HeaderText="Type" UniqueName="ACC_UserType"
                                        ReadOnly="true">
                                        <ItemStyle HorizontalAlign="left" VerticalAlign="Top" Width="40px" Wrap="false" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="AAC_AgentCode" HeaderStyle-Width="70px" CurrentFilterFunction="Contains"
                                        ShowFilterIcon="false" AutoPostBackOnFilter="true" HeaderText="Agent Code" UniqueName="AAC_AgentCode"
                                        ReadOnly="true">
                                        <ItemStyle HorizontalAlign="left" VerticalAlign="Top" Width="400px" Wrap="false" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="AC_CategoryName" HeaderStyle-Width="80px" CurrentFilterFunction="Contains"
                                        ShowFilterIcon="false" AutoPostBackOnFilter="true" HeaderText="Name" UniqueName="AC_CategoryName"
                                        ReadOnly="true">
                                        <ItemStyle HorizontalAlign="left" VerticalAlign="Top" Width="400px" Wrap="false" />
                                    </telerik:GridBoundColumn>
                                    <%-- <telerik:GridButtonColumn ButtonType="LinkButton" Text="Delete" ConfirmText="Do you want to delete the mapping?"
                                            CommandName="Delete" UniqueName="DeleteCommandColumn" HeaderStyle-Width="50px"
                                            Visible="false">
                                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Top" Width="50px" Wrap="false" />
                                        </telerik:GridButtonColumn>--%>
                                    <telerik:GridButtonColumn UniqueName="deleteColumn" ConfirmText="Are you sure you want to delete?"
                                        ConfirmDialogType="RadWindow" ConfirmTitle="Delete" ButtonType="LinkButton" CommandName="Delete"
                                        Text="Delete" HeaderStyle-Width="80px">
                                        <ItemStyle HorizontalAlign="left" VerticalAlign="Top" Width="150px" Wrap="false" />
                                        <%-- <ItemStyle HorizontalAlign="Center" CssClass="MyImageButton" />--%>
                                    </telerik:GridButtonColumn>
                                </Columns>
                                <PagerStyle AlwaysVisible="True" />
                            </MasterTableView>
                            <ClientSettings>
                                <Selecting AllowRowSelect="True" EnableDragToSelectRows="True" />
                                <Resizing AllowColumnResize="true" />
                            </ClientSettings>
                            <%--<FilterMenu EnableEmbeddedSkins="False"></FilterMenu>--%>
                        </telerik:RadGrid>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Button ID="btnIssueMap" runat="server" CssClass="PCGButton" Text="Map Associate"
                            OnClick="Map_btnIssueMap" Visible="false" />
                    </td>
                </tr>
            </table>
            <%--   <script type="text/javascript">
                                function RadGrid1_OnRowClick(sender, args) {
                                    //changed code here
                                    var grid = $find("<%= rgPayableMapping.ClientID %>");
                                    var MasterTable = grid.get_masterTableView();
                                    var row = MasterTable.get_dataItems()[eventArgs.get_itemIndexHierarchical()];
                                    var key = MasterTable.getCellByColumnUniqueName(row, "CSRD_StructureRuleDetailsId");  // get the value by uniquecolumnname
                                    var ID = key.innerHTML;
                                    MasterTable.fireCommand("MyClick2", ID);
                                }  OnClientClick="Confirm();"
                            </script>  OnClientClick="Confirm()"--%>
            </td> </tr> </table>
            <asp:Label ID="lblEligible" runat="server"></asp:Label>
            <telerik:RadWindow ID="radAplicationPopUp" runat="server" VisibleOnPageLoad="false"
                Height="750px" Width="900px" Modal="true" BackColor="#DADADA" VisibleStatusbar="false"
                Behaviors="Resize, Close, Move" Title="Map Associate" Left="10" Top="20" OnClientShow="setCustomPosition">
                <ContentTemplate>
                    <table id="tblMapping" runat="server" width="100%">
                        <tr>
                            <td align="right">
                                <asp:Label ID="Label5" runat="server" Text="Mapping For:" CssClass="FieldName"></asp:Label>
                            </td>
                            <td>
                                <asp:DropDownList ID="ddlMapping" runat="server" CssClass="cmbField" AutoPostBack="true"
                                    OnSelectedIndexChanged="ddlMapping_Selectedindexchanged">
                                    <asp:ListItem Text="Staff" Value="Staff"></asp:ListItem>
                                    <asp:ListItem Text="Associate" Value="Associate"></asp:ListItem>
                                </asp:DropDownList>
                            </td>
                            <td align="right">
                                <asp:Label ID="Label6" runat="server" Text="Type:" CssClass="FieldName"></asp:Label>
                            </td>
                            <td width="10%">
                                <asp:DropDownList ID="ddlType" runat="server" CssClass="cmbField" OnSelectedIndexChanged="ddlType_Selectedindexchanged"
                                    AutoPostBack="true">
                                    <asp:ListItem Text="Custom" Value="Custom"></asp:ListItem>
                                    <asp:ListItem Text="UserCategory" Value="UserCategory"></asp:ListItem>
                                </asp:DropDownList>
                            </td>
                            <td align="right">
                                <asp:Label ID="lblAMFIAvaliable" runat="server" CssClass="FieldName" Text="ARN:"></asp:Label>
                            </td>
                            <td>
                                <asp:DropDownList ID="ddlAMFIAvaliable" runat="server" CssClass="cmbField" AutoPostBack="true"
                                    OnSelectedIndexChanged="ddlAMFIAvaliable_Selectedindexchanged">
                                    <asp:ListItem Text="ARN Avaliable" Value="0"></asp:ListItem>
                                    <asp:ListItem Text="ARN Not-Avaliable" Value="1"></asp:ListItem>
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td class="leftLabel">
                                <asp:Label ID="lblAssetCategory" CssClass="FieldName" runat="server" Text="Associate Category:"
                                    Visible="false"></asp:Label>
                            </td>
                            <td class="rightData">
                                <asp:DropDownList ID="ddlAdviserCategory" runat="server" CssClass="cmbField" Visible="false">
                                </asp:DropDownList>
                            </td>
                        </tr>
                    </table>
                    <table>
                        <tr style="margin-left: 10%;">
                            <td>
                            </td>
                            <td style="margin-left: 10%;">
                                <div class="clearfix" style="margin-left: 150px;">
                                    <telerik:RadGrid ID="rgPayableMapping" runat="server" AllowSorting="True" enableloadondemand="True"
                                        PageSize="5" AutoGenerateColumns="False" EnableEmbeddedSkins="False" GridLines="None"
                                        ShowFooter="True" PagerStyle-AlwaysVisible="true" AllowPaging="false" ShowStatusBar="True"
                                        Skin="Telerik" AllowFilteringByColumn="true" OnNeedDataSource="rgPayableMapping_OnNeedDataSource"
                                        Width="70%" OnItemDataBound="rgPayableMapping_OnItemDataBound" Visible="false">
                                        <MasterTableView AllowMultiColumnSorting="True" AllowSorting="true" AutoGenerateColumns="false"
                                            Width="100%" DataKeyNames="ACSR_CommissionStructureRuleId">
                                            <Columns>
                                                <telerik:GridBoundColumn DataField="ACSR_CommissionStructureRuleName" HeaderStyle-Width="20px"
                                                    CurrentFilterFunction="Contains" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                                    HeaderText="Rule Name" UniqueName="ACSR_CommissionStructureRuleName" SortExpression="ACSR_CommissionStructureRuleName"
                                                    AllowFiltering="true">
                                                    <ItemStyle HorizontalAlign="left" VerticalAlign="Top" Width="" Wrap="false" />
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn DataField="WCT_CommissionType" HeaderStyle-Width="20px"
                                                    CurrentFilterFunction="Contains" ShowFilterIcon="false" AutoPostBackOnFilter="true"
                                                    HeaderText="Commission Type" UniqueName="WCT_CommissionType" SortExpression="WCT_CommissionType"
                                                    AllowFiltering="true">
                                                    <ItemStyle HorizontalAlign="left" VerticalAlign="Top" Width="" Wrap="false" />
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn DataField="WCMV_Name" HeaderStyle-Width="20px" CurrentFilterFunction="Contains"
                                                    ShowFilterIcon="false" AutoPostBackOnFilter="true" HeaderText="City group" UniqueName="WCMV_Name"
                                                    SortExpression="WCMV_Name" AllowFiltering="true">
                                                    <ItemStyle HorizontalAlign="left" VerticalAlign="Top" Width="" Wrap="false" />
                                                </telerik:GridBoundColumn>
                                                <telerik:GridTemplateColumn HeaderText="Broker/Rate(%)" AllowFiltering="true" DataField="CSRD_StructureRuleDetailsId">
                                                    <ItemTemplate>
                                                        <asp:CheckBoxList ID="chkListrate" runat="server" RepeatDirection="Vertical" AutoPostBack="true"
                                                            OnSelectedIndexChanged="chkListrate_OnSelectedIndexChanged">
                                                        </asp:CheckBoxList>
                                                        <%-- <asp:RadioButtonList ID="rbtnListRate" runat="server" RepeatDirection="Vertical">
                                </asp:RadioButtonList>--%>
                                                    </ItemTemplate>
                                                </telerik:GridTemplateColumn>
                                                <telerik:GridButtonColumn UniqueName="deleteColumn" ConfirmText="Are you sure you want to delete?"
                                                    ConfirmDialogType="RadWindow" ConfirmTitle="Delete" ButtonType="LinkButton" CommandName="Delete"
                                                    Text="Delete" Visible="false">
                                                    <ItemStyle HorizontalAlign="Center" CssClass="MyImageButton" />
                                                </telerik:GridButtonColumn>
                                            </Columns>
                                        </MasterTableView>
                                    </telerik:RadGrid>
                                </div>
                            </td>
                        </tr>
                        <tr style="margin-left: 10%;">
                            <td>
                            </td>
                            <td style="margin-left: 10%;">
                                <asp:Button ID="btnCancelSelectedRule" runat="server" CssClass="PCGButton" Text="Uncheck Rule"
                                    OnClick="btnCancelSelectedRule_OnClick" Visible="false" />
                            </td>
                        </tr>
                    </table>
                    <table>
                        <tr runat="server" id="trListControls">
                            <td>
                                <div class="clearfix" style="margin-bottom: 1em;">
                                    <div>
                                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                        <label class="FieldName">
                                            Search AgentCodes:</label>
                                        <asp:TextBox ID="txtAssociateSearch" runat="server" Width="250px" onkeyup="return Associate();"></asp:TextBox>
                                    </div>
                                    <asp:Panel ID="PLCustomer" runat="server" Style="float: left; padding-left: 150px;">
                                        <%--&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br />
                                        --%>
                                        <asp:Label ID="lblSelectBranch" runat="server" CssClass="FieldName" Text="Existing AgentCodes">
                                        </asp:Label>
                                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                        <br />
                                        <asp:ListBox ID="LBAgentCodes" runat="server" Height="200px" Width="250px" SelectionMode="Multiple" />
                                        <td>
                                            <table align="right">
                                                <tr align="left">
                                                    <td>
                                                        <asp:Button ID="RightArrow" runat="server" Text=">" Width="45px" OnClick="RightArrow_Click" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <asp:Button ID="LeftArrow" runat="server" Text="<" Width="45px" OnClick="LeftArrow_Click" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <asp:Button ID="RightShift" runat="server" Text=">>" Width="45px" OnClick="RightShift_Click" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <asp:Button ID="LeftShift" runat="server" Text="<<" Width="45px" OnClick="LeftShift_Click" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td>
                                            <br />
                                            <asp:Label ID="Label7" runat="server" CssClass="FieldName" Text="Mapped AgentCodes">
                                            </asp:Label>
                                            <br />
                                            <asp:ListBox ID="RadListBoxSelectedAgentCodes" runat="server" Height="200px" Width="250px"
                                                SelectionMode="Multiple" />
                                        </td>
                                    </asp:Panel>
                                </div>
                            </td>
                        </tr>
                    </table>
                    <table>
                        <tr>
                            <td class="rightData" colspan="2">
                                <asp:Button ID="btnGo" ValidationGroup="btnSubmitRates" CssClass="PCGButton" OnClick="btnGo_Click"
                                    Text="Submit" runat="server" CausesValidation="true"></asp:Button>&nbsp;
                                <%--  <asp:Button ID="Button2" CssClass="PCGButton" Text="Cancel" runat="server" CausesValidation="false"
                                                        CommandName="Cancel"></asp:Button>--%>
                            </td>
                        </tr>
                    </table>
                </ContentTemplate>
            </telerik:RadWindow>
            <div>
                <asp:HiddenField ID="hidCommissionStructureName" runat="server" />
                <asp:HiddenField ID="hdnProductId" runat="server" />
                <asp:HiddenField ID="hdnStructValidFrom" runat="server" />
                <asp:HiddenField ID="hdnStructValidTill" runat="server" />
                <asp:HiddenField ID="hdnIssuerId" runat="server" />
                <asp:HiddenField ID="hdnCategoryId" runat="server" />
                <asp:HiddenField ID="hdnSubcategoryIds" runat="server" />
                <asp:HiddenField ID="HiddenField1" runat="server" />
                <asp:HiddenField ID="hdnMappedIssue" runat="server" />
                <asp:HiddenField ID="hdnRuleName" runat="server" />
                <asp:HiddenField ID="hdnRuleId" runat="server" />
                <asp:HiddenField ID="hdnIsSpecialIncentive" runat="server" />
                <asp:HiddenField ID="hdnViewMode" runat="server" />
                <asp:HiddenField ID="hdneligible" runat="server" />
                <asp:HiddenField ID="hdnRulestart" runat="server" />
                <asp:HiddenField ID="hdnRuleEnd" runat="server" />
            </div>
            <%--<div style="float:left ;padding-right:10px">
                <asp:Label ID="Label12" runat="server" Text="Note:" Visible="false" CssClass="FieldName"></asp:Label>
            </div>
            
            <div style="float:left ">
                <asp:Label ID="Label13" runat="server" Visible="false" Text="T15 cities : Ahmedabad, Bangalore, Baroda, Chandigarh, Chennai, Hyderabad (including Secunderabad), Jaipur, Kanpur, Kolkata,<br /> Lucknow, Mumbai(Including Thane & Navi Mumbai), New Delhi(including NCR), Panjim, Pune and Surat <br /><br />
 B15 cities : cities that are not in T15" CssClass="FieldName"></asp:Label>
            </div>--%>
        </ContentTemplate>
        <Triggers>
            <asp:PostBackTrigger ControlID="imgexportButton" />
            <asp:PostBackTrigger ControlID="hdneligible" />
        </Triggers>
    </asp:UpdatePanel>
</asp:Panel>

<script type="text/javascript">
    function setCustomPosition(sender, args) {
        sender.moveTo(sender.get_left(), sender.get_top());
    }
</script>

