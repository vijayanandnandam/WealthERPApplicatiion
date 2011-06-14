﻿<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="CustomerFPProjections.ascx.cs" Inherits="WealthERP.FP.CustomerFPProjections" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register TagPrefix="qsf" Namespace="Telerik" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Charting" Assembly="Telerik.Web.UI" %>

   <script src="Scripts/jquery-1.2.6.js" type="text/javascript"></script>
    <script src="Scripts/webtoolkit.jscrollable.js" type="text/javascript"></script>
    <script src="Scripts/webtoolkit.scrollabletable.js" type="text/javascript"></script> 


<script type="text/javascript">

    function ShowHideGaolType() {
       
        
        document.getElementById("<%= trRangeYear.ClientID %>").style.display = 'none';
        if (document.getElementById("<%= rdbYearWise.ClientID %>").checked == true) {
          
            document.getElementById("<%= trPickYear.ClientID %>").style.display = 'block';
          
            document.getElementById("<%= trRangeYear.ClientID %>").visible = false;
        }
        else if (document.getElementById("<%= rdbYearRangeWise.ClientID %>").checked == true) {
            document.getElementById("<%= trPickYear.ClientID %>").style.display = 'none';
            document.getElementById("<%= trRangeYear.ClientID %>").style.display = 'block';
        }

    }
  

</script>
<script type="text/javascript">

    function ShowHideGaolTypeFS() {

        document.getElementById("<%= trRangeYearFSFROM.ClientID %>").style.display = 'none';
        if (document.getElementById("<%= rbtnFSPickYear.ClientID %>").checked == true) {

            document.getElementById("<%= trPickYearFS.ClientID %>").style.display = 'block';

            document.getElementById("<%= trRangeYearFSFROM.ClientID %>").visible = false;
        }
        else if (document.getElementById("<%= rbtnFSRangeYear.ClientID %>").checked == true) {
        document.getElementById("<%= trPickYearFS.ClientID %>").style.display = 'none';
            document.getElementById("<%= trRangeYearFSFROM.ClientID %>").style.display = 'block';
        }
    }

</script>

<%--  <script type="text/javascript">
        $(document).ready(function() {
            jQuery('table').Scrollable(400, 800);
        });
   </script>--%>

<script language="javascript" type="text/javascript">

    function JSValidateToAssetClass() {
        var sum = 0;
        var sum1 = 0;
        var sum2 = 0;
        var sum3 = 0;
        var sum4 = 0;
        var equity = document.getElementById('<%=txtEquity.ClientID %>').value;
        if (equity == "") {
            sum1 = 0;
        }
        else {
            sum1 = sum1 + parseFloat(equity);
        }
        var debt = document.getElementById('<%=txtDebt.ClientID %>').value;
     
     if (debt == "") {
         sum2 = 0;
     }
     else
         sum2 = sum2 + parseFloat(debt); 
     var cash = document.getElementById('<%=txtCash.ClientID %>').value;
     if (cash == "") {
         sum3 = 0;
     }
     else
         sum3 = sum3 + parseFloat(cash); 
     var alternate = document.getElementById('<%=txtAlternate.ClientID %>').value;
     if (alternate == "") {
         sum4 = 0;
     }
     else
         sum4 = sum4 + parseFloat(alternate);
    
     sum = sum1 + sum2 + sum3 + sum4;
     
        if (sum > 100) // you can also write args.Value
        {
            alert("Total sum should not exceed 100");
            document.getElementById('<%=btnSubmitAggredAllocation.ClientID %>').disabled = true;
        }

        else {
            document.getElementById('<%=btnSubmitAggredAllocation.ClientID %>').disabled = false;
        }

    }
    

</script>
<script language="javascript" type="text/javascript">
    function JSValidateToAssetClassFS() {
        var sum = 0;
        var sum1 = 0;
        var sum2 = 0;
        var sum3 = 0;
        var sum4 = 0;
        var equity = document.getElementById('<%=txtEquityFS.ClientID %>').value;
        if (equity == "") {
            sum1 = 0;
        }
        else {
            sum1 = sum1 + parseFloat(equity);
        }
        var debt = document.getElementById('<%=txtDebtFS.ClientID %>').value;

        if (debt == "") {
            sum2 = 0;
        }
        else
            sum2 = sum2 + parseFloat(debt);
        var cash = document.getElementById('<%=txtCashFS.ClientID %>').value;
        if (cash == "") {
            sum3 = 0;
        }
        else
            sum3 = sum3 + parseFloat(cash);
        var alternate = document.getElementById('<%=txtAlternateFS.ClientID %>').value;
        if (alternate == "") {
            sum4 = 0;
        }
        else
            sum4 = sum4 + parseFloat(alternate);

        sum = sum1 + sum2 + sum3 + sum4;

        if (sum > 100) // you can also write args.Value
        {
            alert("Total sum should not exceed 100");
            document.getElementById('<%=btnSubmitFpFs.ClientID %>').disabled = true;
        }

        else {
            document.getElementById('<%=btnSubmitFpFs.ClientID %>').disabled = false;
        }

    }

</script>






<%--<style type="text/css">
                  table {                      
                      font: normal 11px "Trebuchet MS", Verdana, Arial;                                              
                      background:#fff;                                 
                      border:solid 1px #C2EAD6;
                  }                
                 
                  td{                  
                  padding: 3px 3px 3px 6px;
                  color: #5D829B;
                  }
                  th {
                        font-weight:bold;
                        font-size:smaller;
                  color: #5D728A;                                             
                  padding: 0px 3px 3px 6px;
                  background: #CAE8EA                      
                  }
            </style>--%>
<telerik:RadStyleSheetManager ID="RadStyleSheetManager1" runat="server" />
<telerik:RadScriptManager ID="RadScriptManager1" runat="server">
</telerik:RadScriptManager>

<asp:Label ID="headertitle" runat="server" CssClass="HeaderTextBig" Text="FP Projection"></asp:Label>
<br />
</br>

<telerik:RadTabStrip ID="RadTabStripFPProjection" runat="server" EnableTheming="True" Skin="Telerik"
    EnableEmbeddedSkins="False" MultiPageID="CustomerFPProjection" SelectedIndex="0" EnableViewState="true">
    <Tabs>
        <telerik:RadTab runat="server" Text="AssetAllocation" Value="AssetAllocation" Selected="true" TabIndex="0">
        </telerik:RadTab>
        <telerik:RadTab runat="server" Text="FutureSavings" Value="FutureSavings" TabIndex="1">
        </telerik:RadTab>
        <telerik:RadTab runat="server" Text="Rebalancing" Value="Rebalancing" TabIndex="2">
        </telerik:RadTab>        
    </Tabs>
</telerik:RadTabStrip>

<telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server" Skin="Telerik"
    EnableEmbeddedSkins="false">
</telerik:RadAjaxLoadingPanel>

<telerik:RadMultiPage ID="CustomerFPProjection" EnableViewState="true" runat="server" SelectedIndex="0">
 <telerik:RadPageView ID="RadPageView2" runat="server">
        <asp:Panel ID="pnlInvestment" runat="server">
        <table>
        <tr>
        <td >
        <asp:RadioButton ID="rdbYearWise" runat="server" Checked="true" GroupName="year" Text="Edit value for a year" Class="FieldName" onClick="return ShowHideGaolType()"/>
        </td><td><asp:RadioButton ID="rdbYearRangeWise" runat="server" GroupName="year" Text="Edit value for a range of years" Class="FieldName" onClick="return ShowHideGaolType()"/>
        </td>        
        </tr></table>
        <table>
        
        <tr id="trPickYear" runat="server">
        <td align="right">
        <asp:Label ID="lblTerm" runat="server" Text="Pick a year : " CssClass="FieldName"></asp:Label>
        </td>
        <td>
        <asp:DropDownList ID="ddlPickYear" runat="server" CssClass="cmbField">
        </asp:DropDownList>
        </td>
        </tr>  
        
        <tr id="trRangeYear" runat="server">
        <td align="right">
        <asp:Label ID="Label1" runat="server" Text="From year : " CssClass="FieldName"></asp:Label>
        </td>
        <td align="left">
        <asp:DropDownList ID="ddlFromYear" runat="server" CssClass="cmbField">
        </asp:DropDownList>
        </td>
        <td></td>
        <td align="right">
        <asp:Label ID="Label2" runat="server" Text="To year : " CssClass="FieldName"></asp:Label>
        </td><td></td>
        <td align="left" >
        <asp:DropDownList ID="ddlToYear" runat="server" CssClass="cmbField">
        </asp:DropDownList>
        </td><td><asp:CompareValidator ID="cvlblRangeTo" runat="server" ValidationGroup="btnSubmit" ControlToCompare="ddlFromYear" ControlToValidate="ddlToYear" Operator="GreaterThanEqual" ErrorMessage="To Year can not be leas then From Year" CssClass="cvPCG"></asp:CompareValidator></td>
        </tr>
        </table>
        <table>
        
        <tr>
        <td colspan="4">
        <asp:Label ID="Label3" runat="server" Text="Agreed allocation :" CssClass="FieldName"  Font-Bold="true"></asp:Label>
        </td>
        </tr> 
        
        <tr><td ></td><td ></td><td ></td><td ></td><td ></td>
          <td align="right">
           <asp:Label ID="lblEquity" runat="server" Text="Equity : " CssClass="FieldName"></asp:Label>
          </td>
          <td align="left">
           <asp:TextBox ID="txtEquity" runat="server" onchange="JSValidateToAssetClass()" Style="direction: rtl" CssClass="txtField"></asp:TextBox>
           <br />
           <asp:RangeValidator ID="txtEquityRV" ValidationGroup="btnSubmit" Type="Integer" CssClass="cvPCG" ControlToValidate="txtEquity" MinimumValue="0" MaximumValue="100" runat="server" ErrorMessage="Should not be greater than 100" Display="Dynamic">
           </asp:RangeValidator>
          </td>
          <td align="right">
          <asp:Label ID="lblDebt" runat="server" Text="Debt : " CssClass="FieldName"></asp:Label>
          </td>
           <td align="left">
           <asp:TextBox ID="txtDebt" runat="server" onchange="JSValidateToAssetClass()" Style="direction: rtl" CssClass="txtField"></asp:TextBox>
           <br />
           <asp:RangeValidator ID="txtDebtRV" ValidationGroup="btnSubmit" Type="Integer" CssClass="cvPCG" ControlToValidate="txtDebt" MinimumValue="0" MaximumValue="100" runat="server" ErrorMessage="Should not be greater than 100" Display="Dynamic">
           </asp:RangeValidator>
           </td>
        </tr>
        
        <tr><td></td><td ></td><td ></td><td ></td><td ></td>
          <td align="right">
           <asp:Label ID="lblCash" runat="server" Text="Cash : " CssClass="FieldName"></asp:Label>
          </td>
          <td align="left">
           <asp:TextBox ID="txtCash" runat="server" onchange="JSValidateToAssetClass()" Style="direction: rtl" CssClass="txtField"></asp:TextBox>
           <br />
           <asp:RangeValidator ID="txtCashRV" ValidationGroup="btnSubmit" CssClass="cvPCG" Type="Integer" ControlToValidate="txtCash" MinimumValue="0" MaximumValue="100" runat="server" ErrorMessage="Should not be greater than 100" Display="Dynamic">
           </asp:RangeValidator>
          </td>
          <td align="right">
          <asp:Label ID="lblAlternate" runat="server" Text="Alternate : " CssClass="FieldName"></asp:Label>
          </td>
           <td align="left">
           <asp:TextBox ID="txtAlternate" runat="server" Style="direction: rtl" onchange="JSValidateToAssetClass()" CssClass="txtField"></asp:TextBox>
           <br />
           <asp:RangeValidator ID="txtAlternateRV" CssClass="cvPCG" Type="Integer" ValidationGroup="btnSubmit" ControlToValidate="txtAlternate" MinimumValue="0" MaximumValue="100" runat="server" ErrorMessage="Should not be greater than 100" Display="Dynamic">
           </asp:RangeValidator>
           </td>
        </tr>
       
         <tr id="trBtnSubmit" runat="server">
          <td align="left" colspan="3">
           <asp:Button ID="btnSubmitAggredAllocation" runat="server" Text="Submit" CssClass="PCGButton" OnClick="btnSubmitAggredAllocation_OnClick"  ValidationGroup="btnSubmit"/>
          </td>          
        </tr>
               
        
        </table>
        <telerik:RadAjaxPanel ID="RadAjaxPanel1" runat="server" Width="98%" EnableHistory="True"
    HorizontalAlign="NotSet" LoadingPanelID="PorspectListLoading">
<telerik:RadGrid ID="gvAssetAllocation" runat="server" GridLines="None" AutoGenerateColumns="False"
        PageSize="15" AllowSorting="True" AllowPaging="True" HeaderStyle-Wrap="true" HeaderStyle-VerticalAlign="Top" 
        ShowStatusBar="True" ShowFooter="true" Width="100%"
        Skin="Telerik" EnableEmbeddedSkins="false"
        
        AllowAutomaticInserts="false">
        <MasterTableView AllowMultiColumnSorting="True" AutoGenerateColumns="false">
           
            <Columns>
             <telerik:GridBoundColumn DataField="Year" HeaderText="Year" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="100px" SortExpression="Year"
                    UniqueName="Year">
                     <ItemStyle HorizontalAlign="Right" />
                </telerik:GridBoundColumn>
               
                  <telerik:GridTemplateColumn UniqueName="Equity" AllowFiltering="true" HeaderStyle-Width="100px" DataField="Equity" HeaderText="Equity" >
                <ItemStyle HorizontalAlign="Right" VerticalAlign="Top" />
                    <ItemTemplate>
                        <asp:Label ID="lblRecEquity" runat="server" CssClass="CmbField" Text='<%# Eval("Rec_Equity").ToString() %>'></asp:Label>
                    </ItemTemplate>
                </telerik:GridTemplateColumn>
                
                <telerik:GridTemplateColumn UniqueName="Debt" AllowFiltering="true" HeaderStyle-Width="110px" DataField="Debt" HeaderText="Debt" >
                <ItemStyle HorizontalAlign="Right" VerticalAlign="Top" />
                    <ItemTemplate>
                        <asp:Label ID="lblRecDebt" runat="server" CssClass="CmbField" Text='<%# Eval("Rec_Debt").ToString() %>'></asp:Label>
                    </ItemTemplate>
                </telerik:GridTemplateColumn>
                
                
                <telerik:GridTemplateColumn UniqueName="Cash" AllowFiltering="true" HeaderStyle-Width="100px" DataField="Cash" HeaderText="Cash" >
                <ItemStyle HorizontalAlign="Right" VerticalAlign="Top" />
                    <ItemTemplate>
                        <asp:Label ID="lblRecCash" runat="server" CssClass="CmbField" Text='<%# Eval("Rec_Cash").ToString() %>'></asp:Label>
                    </ItemTemplate>
                </telerik:GridTemplateColumn>
                
                
                <telerik:GridTemplateColumn UniqueName="Alternate" AllowFiltering="true" HeaderStyle-Width="100px" DataField="Alternate" HeaderText="Alternate" >
                <ItemStyle HorizontalAlign="Right" VerticalAlign="Top" />
                    <ItemTemplate>
                        <asp:Label ID="lblRecAlternate" runat="server" CssClass="CmbField" Text='<%# Eval("Rec_Alternate").ToString() %>'></asp:Label>
                    </ItemTemplate>
                </telerik:GridTemplateColumn>
                
                
                <telerik:GridTemplateColumn UniqueName="Equity" AllowFiltering="true" DataField="Equity" HeaderText="Equity" >
                <ItemStyle HorizontalAlign="Right" VerticalAlign="Top" />
                    <ItemTemplate>
                        <asp:Label ID="lblAgrEquity" runat="server" CssClass="CmbField" Text='<%# Eval("Agr_Equity").ToString() %>'></asp:Label>
                    </ItemTemplate>
                </telerik:GridTemplateColumn>
                
                  <telerik:GridTemplateColumn UniqueName="Debt" AllowFiltering="true" DataField="Debt" HeaderText="Debt" >
                <ItemStyle HorizontalAlign="Right" VerticalAlign="Top" />
                    <ItemTemplate>
                        <asp:Label ID="lblAgrDebt" runat="server" CssClass="CmbField" Text='<%# Eval("Agr_Debt").ToString() %>'></asp:Label>
                    </ItemTemplate>
                </telerik:GridTemplateColumn>
                
                  <telerik:GridTemplateColumn UniqueName="Cash" AllowFiltering="true" DataField="Cash" HeaderText="Cash" >
                <ItemStyle HorizontalAlign="Right" VerticalAlign="Top" />
                    <ItemTemplate>
                        <asp:Label ID="lblAgrCash" runat="server" CssClass="CmbField" Text='<%# Eval("Agr_Cash").ToString() %>'></asp:Label>
                    </ItemTemplate>
                </telerik:GridTemplateColumn>
                
                             <telerik:GridTemplateColumn UniqueName="Alternate" AllowFiltering="true" DataField="Alternate" HeaderText="Alternate" >
                <ItemStyle HorizontalAlign="Right" VerticalAlign="Top" />
                    <ItemTemplate>
                        <asp:Label ID="lblAgrAlternate" runat="server" CssClass="CmbField" Text='<%# Eval("Agr_Alternate").ToString() %>'></asp:Label>
                    </ItemTemplate>
                </telerik:GridTemplateColumn>
                
            </Columns>
                
        </MasterTableView>
        <HeaderStyle Width="140px" VerticalAlign="Top" Wrap="false" />
        <ClientSettings>
            <Scrolling AllowScroll="True" UseStaticHeaders="True" EnableVirtualScrollPaging="false" SaveScrollPosition="true" FrozenColumnsCount="1">
            </Scrolling>
            <Selecting AllowRowSelect="True" EnableDragToSelectRows="True" />
        </ClientSettings>
    </telerik:RadGrid>
    </telerik:RadAjaxPanel>
        </asp:Panel>
 </telerik:RadPageView>
 
 <telerik:RadPageView ID="RadPageView1" runat="server">
        <asp:Panel ID="Panel1" runat="server">
          <table>
        <tr>
        <td >
        <asp:RadioButton ID="rbtnFSPickYear" runat="server" Checked="true" GroupName="yearFS" Text="Edit value for a year" Class="FieldName" onClick="return ShowHideGaolTypeFS()"/>
        </td><td><asp:RadioButton ID="rbtnFSRangeYear" runat="server" GroupName="yearFS" Text="Edit value for a range of years" Class="FieldName" onClick="return ShowHideGaolTypeFS()"/>
        </td>        
        </tr></table>
        <table>
        
        <tr id="trPickYearFS" runat="server">
        <td align="right">
        <asp:Label ID="lblChooseYearFS" runat="server" Text="Pick a year : " CssClass="FieldName"></asp:Label>
        </td>
        <td>
        <asp:DropDownList ID="ddlPickYearFS" runat="server" CssClass="cmbField">
        </asp:DropDownList>
        </td>
        </tr>  
        
        <tr id="trRangeYearFSFROM" runat="server">
        <td align="right">
        <asp:Label ID="lblRangeYearFSFROM" runat="server" Text="From year : " CssClass="FieldName"></asp:Label>
        </td>
        <td align="left">
        <asp:DropDownList ID="ddlRangeYearFSFROM" runat="server" CssClass="cmbField">
        </asp:DropDownList>
        </td>
        <td></td>
        <td align="right">
        <asp:Label ID="lblRangeYearFSTo" runat="server" Text="To year : " CssClass="FieldName"></asp:Label>
        </td><td></td>
        <td align="left" >
        <asp:DropDownList ID="ddlRangeYearFSTO" runat="server" CssClass="cmbField">
        </asp:DropDownList>
        </td><td><asp:CompareValidator ID="cvRangeYearFS" runat="server" ValidationGroup="btnSubmitFS" ControlToCompare="ddlRangeYearFSFROM" ControlToValidate="ddlRangeYearFSTO" Operator="GreaterThanEqual" ErrorMessage="To Year can not be leas then From Year" CssClass="cvPCG"></asp:CompareValidator></td>
        </tr>
        </table>
        <table>
        
        <tr>
        <td colspan="4">
        <asp:Label ID="lblAgreedFS" runat="server" Text="Agreed allocation :" CssClass="FieldName"  Font-Bold="true"></asp:Label>
        </td>
        </tr> 
        
        <tr><td ></td><td ></td><td ></td><td ></td><td ></td>
          <td align="right">
           <asp:Label ID="lblEquityFS" runat="server" Text="Equity : " CssClass="FieldName"></asp:Label>
          </td>
          <td align="left">
           <asp:TextBox ID="txtEquityFS" runat="server" onchange="JSValidateToAssetClassFS()" Style="direction: rtl" CssClass="txtField"></asp:TextBox>
           <br />
           <asp:RangeValidator ID="rvEquityFS" ValidationGroup="btnSubmitFS" Type="Integer" CssClass="cvPCG" ControlToValidate="txtEquityFS" MinimumValue="0" MaximumValue="100" runat="server" ErrorMessage="Should not be greater than 100" Display="Dynamic">
           </asp:RangeValidator>
          </td>
          <td align="right">
          <asp:Label ID="lblDebtFS" runat="server" Text="Debt : " CssClass="FieldName"></asp:Label>
          </td>
           <td align="left">
           <asp:TextBox ID="txtDebtFS" runat="server" Style="direction: rtl" onchange="JSValidateToAssetClassFS()" CssClass="txtField"></asp:TextBox>
           <br />
           <asp:RangeValidator ID="rvDebtFS" ValidationGroup="btnSubmitFS" Type="Integer" CssClass="cvPCG" ControlToValidate="txtDebtFS" MinimumValue="0" MaximumValue="100" runat="server" ErrorMessage="Should not be greater than 100" Display="Dynamic">
           </asp:RangeValidator>
           </td>
        </tr>
        
        <tr><td></td><td ></td><td ></td><td ></td><td ></td>
          <td align="right">
           <asp:Label ID="lblCashFS" runat="server" Text="Cash : " CssClass="FieldName"></asp:Label>
          </td>
          <td align="left">
           <asp:TextBox ID="txtCashFS" runat="server" Style="direction: rtl" onchange="JSValidateToAssetClassFS()" CssClass="txtField"></asp:TextBox>
           <br />
           <asp:RangeValidator ID="rvCashFS" ValidationGroup="btnSubmitFS" CssClass="cvPCG" Type="Integer" ControlToValidate="txtCashFS" MinimumValue="0" MaximumValue="100" runat="server" ErrorMessage="Should not be greater than 100" Display="Dynamic">
           </asp:RangeValidator>
          </td>
          <td align="right">
          <asp:Label ID="lblAlternateFS" runat="server" Text="Alternate : " CssClass="FieldName"></asp:Label>
          </td>
           <td align="left">
           <asp:TextBox ID="txtAlternateFS" runat="server" Style="direction: rtl" onchange="JSValidateToAssetClassFS()" CssClass="txtField"></asp:TextBox>
           <br />
           <asp:RangeValidator ID="rvAlternateFS" CssClass="cvPCG" Type="Integer" ValidationGroup="btnSubmitFS" ControlToValidate="txtAlternateFS" MinimumValue="0" MaximumValue="100" runat="server" ErrorMessage="Should not be greater than 100" Display="Dynamic">
           </asp:RangeValidator>
           </td>
        </tr>
       
         <tr id="tr3" runat="server">
          <td align="left" colspan="3">
           <asp:Button ID="btnSubmitFpFs" runat="server" Text="Submit" CssClass="PCGButton" OnClick="btnSubmitFpFs_OnClick" ValidationGroup="btnSubmitFS"/>
          </td>          
        </tr>
               
        
        </table>
        
        <telerik:RadAjaxPanel ID="RadAjaxPanel2" runat="server" Width="98%" EnableHistory="True"
    HorizontalAlign="NotSet" LoadingPanelID="PorspectListLoading">
<telerik:RadGrid ID="gdvwFutureSavings" runat="server" GridLines="None" AutoGenerateColumns="False"
        PageSize="15" AllowSorting="True" AllowPaging="True" HeaderStyle-Wrap="false" HeaderStyle-VerticalAlign="Top" 
        ShowStatusBar="True" ShowFooter="true" Width="100%"
        Skin="Telerik" EnableEmbeddedSkins="false"
        
        AllowAutomaticInserts="false">
        <MasterTableView AllowMultiColumnSorting="True" AutoGenerateColumns="false">
           
            <Columns>
             <telerik:GridBoundColumn DataField="Year" HeaderText="Year" HeaderStyle-HorizontalAlign="Center"  HeaderStyle-Width="50px" SortExpression="Year"
                    UniqueName="Year">
                     <ItemStyle HorizontalAlign="Right" />
                </telerik:GridBoundColumn>
                
                  
                  <telerik:GridTemplateColumn UniqueName="IncomeGrowthRate" HeaderStyle-Wrap="true" AllowFiltering="true" DataField="IncomeGrowthRate" HeaderText="Income Growth Rate" >
                <ItemStyle HorizontalAlign="Right" VerticalAlign="Top" />
                    <ItemTemplate>
                        <asp:Label ID="lblIncomeGrowthRate" runat="server" CssClass="CmbField" Text='<%# Eval("IncomeGrowthRate").ToString() %>'></asp:Label>
                    </ItemTemplate>
                </telerik:GridTemplateColumn>
                
                  
                  <telerik:GridTemplateColumn UniqueName="ExpenseGrowthRate" HeaderStyle-Wrap="true" AllowFiltering="true" DataField="ExpenseGrowthRate" HeaderText="Expense Growth Rate" >
                <ItemStyle HorizontalAlign="Right" VerticalAlign="Top" />
                    <ItemTemplate>
                        <asp:Label ID="lblExpenseGrowthRate" runat="server" CssClass="CmbField" Text='<%# Eval("ExpenseGrowthRate").ToString() %>'></asp:Label>
                    </ItemTemplate>
                </telerik:GridTemplateColumn>
               
                  <telerik:GridTemplateColumn UniqueName="Avialable_Surplus" HeaderStyle-Wrap="true" AllowFiltering="true" DataField="Avialable_Surplus" HeaderText="Avialable Surplus   (Post Tax)" >
                <ItemStyle HorizontalAlign="Right" VerticalAlign="Top" />
                    <ItemTemplate>
                        <asp:Label ID="lblAvialable_Surplus" runat="server" CssClass="CmbField" Text='<%# Eval("Avialable_Surplus").ToString() %>'></asp:Label>
                    </ItemTemplate>
                </telerik:GridTemplateColumn>
                
                      <telerik:GridTemplateColumn UniqueName="Equity_Allocation_per" AllowFiltering="true" DataField="Equity_Allocation_per" HeaderText="Equity Allocation(%)" >
                <ItemStyle HorizontalAlign="Right" VerticalAlign="Top" />
                    <ItemTemplate>
                        <asp:Label ID="lblEquity_Allocation_per" runat="server" CssClass="CmbField" Text='<%# Eval("Equity_Allocation_per").ToString() %>'></asp:Label>
                    </ItemTemplate>
                </telerik:GridTemplateColumn>
                
                <telerik:GridTemplateColumn UniqueName="Equity_Allocation" AllowFiltering="true" DataField="Equity_Allocation" HeaderText="Equity Allocation" >
                <ItemStyle HorizontalAlign="Right" VerticalAlign="Top" />
                    <ItemTemplate>
                        <asp:Label ID="lblEquity_Allocation" runat="server" CssClass="CmbField" Text='<%# Eval("Equity_Allocation").ToString() %>'></asp:Label>
                    </ItemTemplate>
                </telerik:GridTemplateColumn>
                
                <telerik:GridTemplateColumn UniqueName="Equity_FutureValue" AllowFiltering="true" DataField="Equity_FutureValue" HeaderText="Equity Growth" >
                <ItemStyle HorizontalAlign="Right" VerticalAlign="Top" />
                    <ItemTemplate>
                        <asp:Label ID="lblEquity_FutureValue" runat="server" CssClass="CmbField" Text='<%# Eval("Equity_FutureValue").ToString() %>'></asp:Label>
                    </ItemTemplate>
                </telerik:GridTemplateColumn>
                
                
          <telerik:GridTemplateColumn UniqueName="Debt_Allocation_per" AllowFiltering="true" DataField="Debt_Allocation_per" HeaderText="Debt Allocation(%)" >
                <ItemStyle HorizontalAlign="Right" VerticalAlign="Top" />
                    <ItemTemplate>
                        <asp:Label ID="lblDebt_Allocation_per" runat="server" CssClass="CmbField" Text='<%# Eval("Debt_Allocation_per").ToString() %>'></asp:Label>
                    </ItemTemplate>
                </telerik:GridTemplateColumn>
                
                
                <telerik:GridTemplateColumn UniqueName="Debt_Allocation" AllowFiltering="true" DataField="Debt_Allocation" HeaderText="Debt Allocation" >
                <ItemStyle HorizontalAlign="Right" VerticalAlign="Top" />
                    <ItemTemplate>
                        <asp:Label ID="lblDebt_Allocation" runat="server" CssClass="CmbField" Text='<%# Eval("Debt_Allocation").ToString() %>'></asp:Label>
                    </ItemTemplate>
                </telerik:GridTemplateColumn>
                
                  <telerik:GridTemplateColumn UniqueName="Debt_FutureValue" AllowFiltering="true" DataField="Debt_FutureValue" HeaderText="Debt Growth" >
                <ItemStyle HorizontalAlign="Right" VerticalAlign="Top" />
                    <ItemTemplate>
                        <asp:Label ID="lblDebt_FutureValue" runat="server" CssClass="CmbField" Text='<%# Eval("Debt_FutureValue").ToString() %>'></asp:Label>
                    </ItemTemplate>
                </telerik:GridTemplateColumn>
                
                
                 <telerik:GridTemplateColumn UniqueName="Cash_Allocation_per" AllowFiltering="true" DataField="Cash_Allocation_per" HeaderText="Cash Allocation(%)" >
                <ItemStyle HorizontalAlign="Right" VerticalAlign="Top" />
                    <ItemTemplate>
                        <asp:Label ID="lblCash_Allocation_per" runat="server" CssClass="CmbField" Text='<%# Eval("Cash_Allocation_per").ToString() %>'></asp:Label>
                    </ItemTemplate>
                </telerik:GridTemplateColumn>
                
                  <telerik:GridTemplateColumn UniqueName="Cash_Allocation" AllowFiltering="true" DataField="Cash_Allocation" HeaderText="Cash Allocation" >
                <ItemStyle HorizontalAlign="Right" VerticalAlign="Top" />
                    <ItemTemplate>
                        <asp:Label ID="lblCash_Allocation" runat="server" CssClass="CmbField" Text='<%# Eval("Cash_Allocation").ToString() %>'></asp:Label>
                    </ItemTemplate>
                </telerik:GridTemplateColumn>
                
                  <telerik:GridTemplateColumn UniqueName="Cash_FutureValue" AllowFiltering="true" DataField="Cash_FutureValue" HeaderText="Cash Growth" >
                <ItemStyle HorizontalAlign="Right" VerticalAlign="Top" />
                    <ItemTemplate>
                        <asp:Label ID="lblCash_FutureValue" runat="server" CssClass="CmbField" Text='<%# Eval("Cash_FutureValue").ToString() %>'></asp:Label>
                    </ItemTemplate>
                </telerik:GridTemplateColumn>
                
                     <telerik:GridTemplateColumn UniqueName="Alternate_Allocation_per" AllowFiltering="true" DataField="Alternate_Allocation_per" HeaderText="Alternate Allocation(%)" >
                <ItemStyle HorizontalAlign="Right" VerticalAlign="Top" />
                    <ItemTemplate>
                        <asp:Label ID="lblAlternate_Allocation_per" runat="server" CssClass="CmbField" Text='<%# Eval("Alternate_Allocation_per").ToString() %>'></asp:Label>
                    </ItemTemplate>
                </telerik:GridTemplateColumn>
                
                
                             <telerik:GridTemplateColumn UniqueName="Alternate_Allocation" AllowFiltering="true" DataField="Alternate_Allocation" HeaderText="Alternate Allocation" >
                <ItemStyle HorizontalAlign="Right" VerticalAlign="Top" />
                    <ItemTemplate>
                        <asp:Label ID="lblAlternate_Allocation" runat="server" CssClass="CmbField" Text='<%# Eval("Alternate_Allocation").ToString() %>'></asp:Label>
                    </ItemTemplate>
                </telerik:GridTemplateColumn>
                
                  <telerik:GridTemplateColumn UniqueName="Alternate_FutureValue" AllowFiltering="true" DataField="Alternate_FutureValue" HeaderText="Alternate Growth" >
                <ItemStyle HorizontalAlign="Right" VerticalAlign="Top" />
                    <ItemTemplate>
                        <asp:Label ID="lblAlternate_FutureValue" runat="server" CssClass="CmbField" Text='<%# Eval("Alternate_FutureValue").ToString() %>'></asp:Label>
                    </ItemTemplate>
                </telerik:GridTemplateColumn>
                
                
                    <telerik:GridTemplateColumn UniqueName="Amount_Returns" HeaderStyle-Wrap="true" AllowFiltering="true" DataField="Amount_Returns" HeaderText="Amount After Returns From Savings" >
                <ItemStyle HorizontalAlign="Right" VerticalAlign="Top" />
                    <ItemTemplate>
                        <asp:Label ID="lblAmount_Returns" runat="server" CssClass="CmbField" Text='<%# Eval("Amount_Returns").ToString() %>'></asp:Label>
                    </ItemTemplate>
                </telerik:GridTemplateColumn>
                
            </Columns>
                
        </MasterTableView>
        <HeaderStyle Width="140px" VerticalAlign="Top" Wrap="false" />
        <ClientSettings>
            <Scrolling AllowScroll="True" UseStaticHeaders="True" EnableVirtualScrollPaging="false" SaveScrollPosition="true" FrozenColumnsCount="1">
            </Scrolling>
            <Selecting AllowRowSelect="True" EnableDragToSelectRows="True" />
        </ClientSettings>
    </telerik:RadGrid>
    </telerik:RadAjaxPanel>
        </asp:Panel>
 </telerik:RadPageView>
 
 <telerik:RadPageView ID="RadPageView3" runat="server">
        <asp:Panel ID="Panel2" runat="server">
        <table width="100%">
            <tr>
            <td align="right" runat="server">
                <asp:Label ID="lblAssetClass" runat="server" Text="Pick a asset class" CssClass="FieldName"></asp:Label>
            </td>
            <td>
                  <asp:DropDownList ID="ddlRebalancing" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlRebalancing_OnSelectIndexChanged" CssClass="cmbField">
            </asp:DropDownList>
            </td>
            </tr>
      
        </table>
        <telerik:RadAjaxPanel ID="RadAjaxPanel3" runat="server" Width="98%" EnableHistory="True"
    HorizontalAlign="NotSet" LoadingPanelID="PorspectListLoading">
<telerik:RadGrid ID="rdRebalancing" runat="server" GridLines="None" AutoGenerateColumns="False"
        PageSize="15" AllowSorting="True" AllowPaging="True" HeaderStyle-Wrap="false" HeaderStyle-VerticalAlign="Top" 
        ShowStatusBar="True" ShowFooter="true" Width="100%"
        Skin="Telerik" EnableEmbeddedSkins="false"
        
        AllowAutomaticInserts="false">
        <MasterTableView AllowMultiColumnSorting="True" AutoGenerateColumns="false">
           
            <Columns>
             <telerik:GridBoundColumn DataField="Year" HeaderText="Year" HeaderStyle-HorizontalAlign="Center"  HeaderStyle-Width="50px" SortExpression="Year"
                    UniqueName="Year">
                     <ItemStyle HorizontalAlign="Right" />
                </telerik:GridBoundColumn>
               
                  <telerik:GridTemplateColumn UniqueName="Money_Available" HeaderStyle-Wrap="true"  AllowFiltering="true" DataField="Money_Available" HeaderText="Money Available" >
                <ItemStyle HorizontalAlign="Right" VerticalAlign="Top" />
                    <ItemTemplate>
                        <asp:Label ID="lblMoney_Available" runat="server" CssClass="CmbField" Text='<%# Eval("Money_Available").ToString() %>'></asp:Label>
                    </ItemTemplate>
                </telerik:GridTemplateColumn>
                
                <telerik:GridTemplateColumn UniqueName="Existing_Asset_Allocation" AllowFiltering="true" DataField="Existing_Asset_Allocation" HeaderText="Existing Asset Allocation" >
                <ItemStyle HorizontalAlign="Right" VerticalAlign="Top" />
                    <ItemTemplate>
                        <asp:Label ID="lblExisting_Asset_Allocation" runat="server" CssClass="CmbField" Text='<%# Eval("Existing_Asset_Allocation").ToString() %>'></asp:Label>
                    </ItemTemplate>
                </telerik:GridTemplateColumn>
                
                
                <telerik:GridTemplateColumn UniqueName="Gap_from_Agreed_Allocation" AllowFiltering="true" DataField="Gap_from_Agreed_Allocation" HeaderText="Gap from Agreed Allocation" >
                <ItemStyle HorizontalAlign="Right" VerticalAlign="Top" />
                    <ItemTemplate>
                        <asp:Label ID="lblGap_from_Agreed_Allocation" runat="server" CssClass="CmbField" Text='<%# Eval("Gap_from_Agreed_Allocation").ToString() %>'></asp:Label>
                    </ItemTemplate>
                </telerik:GridTemplateColumn>
                
                
                <telerik:GridTemplateColumn UniqueName="Money_Rebalanced" AllowFiltering="true" DataField="Money_Rebalanced" HeaderText="Money Rebalanced" >
                <ItemStyle HorizontalAlign="Right" VerticalAlign="Top" />
                    <ItemTemplate>
                        <asp:Label ID="lblMoney_Rebalanced" runat="server" CssClass="CmbField" Text='<%# Eval("Money_Rebalanced").ToString() %>'></asp:Label>
                    </ItemTemplate>
                </telerik:GridTemplateColumn>
                
                
                <telerik:GridTemplateColumn UniqueName="Money_withdrawn" AllowFiltering="true" DataField="Money_withdrawn" HeaderText="Money withdrawn" >
                <ItemStyle HorizontalAlign="Right" VerticalAlign="Top" />
                    <ItemTemplate>
                        <asp:Label ID="lblMoney_withdrawn" runat="server" CssClass="CmbField" Text='<%# Eval("Money_withdrawn").ToString() %>'></asp:Label>
                    </ItemTemplate>
                </telerik:GridTemplateColumn>
                
                  <telerik:GridTemplateColumn UniqueName="Money_After_rebalancing" AllowFiltering="true" DataField="Money_After_rebalancing" HeaderText="Money After Rebalancing" >
                <ItemStyle HorizontalAlign="Right" VerticalAlign="Top" />
                    <ItemTemplate>
                        <asp:Label ID="lblMoney_After_rebalancing" runat="server" CssClass="CmbField" Text='<%# Eval("Money_After_rebalancing").ToString() %>'></asp:Label>
                    </ItemTemplate>
                </telerik:GridTemplateColumn>
                
                  <telerik:GridTemplateColumn UniqueName="Money_After_rebalancing_returns" AllowFiltering="true" DataField="Money_After_rebalancing_returns" HeaderText="Money After Rebalancing Returns" >
                <ItemStyle HorizontalAlign="Right" VerticalAlign="Top" />
                    <ItemTemplate>
                        <asp:Label ID="lblMoney_After_rebalancing_returns" runat="server" CssClass="CmbField" Text='<%# Eval("Money_After_rebalancing_returns").ToString() %>'></asp:Label>
                    </ItemTemplate>
                </telerik:GridTemplateColumn>
                
                             <telerik:GridTemplateColumn UniqueName="Money_flowing" AllowFiltering="true" DataField="Money_flowing" HeaderText="Money flowing" >
                <ItemStyle HorizontalAlign="Right" VerticalAlign="Top" />
                    <ItemTemplate>
                        <asp:Label ID="lblMoney_flowing" runat="server" CssClass="CmbField" Text='<%# Eval("Money_flowing").ToString() %>'></asp:Label>
                    </ItemTemplate>
                </telerik:GridTemplateColumn>
                
                    <telerik:GridTemplateColumn UniqueName="Money_flowing_returns" AllowFiltering="true" DataField="Money_flowing_returns" HeaderText="Money flowing returns" >
                <ItemStyle HorizontalAlign="Right" VerticalAlign="Top" />
                    <ItemTemplate>
                        <asp:Label ID="lblMoney_flowing_returns" runat="server" CssClass="CmbField" Text='<%# Eval("Money_flowing_returns").ToString() %>'></asp:Label>
                    </ItemTemplate>
                </telerik:GridTemplateColumn>
                
                
                    <telerik:GridTemplateColumn UniqueName="Balance_Money" HeaderStyle-Wrap="true" AllowFiltering="true" DataField="Balance_Money" HeaderText="Balance Money" >
                <ItemStyle HorizontalAlign="Right" VerticalAlign="Top" />
                    <ItemTemplate>
                        <asp:Label ID="lblBalance_Money" runat="server" CssClass="CmbField" Text='<%# Eval("Balance_Money").ToString() %>'></asp:Label>
                    </ItemTemplate>
                </telerik:GridTemplateColumn>
                
            </Columns>
                
        </MasterTableView>
        <HeaderStyle Width="140px" VerticalAlign="Top" Wrap="false" />
        <ClientSettings>
            <Scrolling AllowScroll="True" UseStaticHeaders="True" EnableVirtualScrollPaging="false" SaveScrollPosition="true" FrozenColumnsCount="1">
            </Scrolling>
            <Selecting AllowRowSelect="True" EnableDragToSelectRows="True" />
        </ClientSettings>
    </telerik:RadGrid>
    </telerik:RadAjaxPanel>
        </asp:Panel>
 </telerik:RadPageView>
</telerik:RadMultiPage>

<script language="javascript" type="text/javascript">
    document.getElementById('<%=trRangeYear.ClientID %>').style.display = 'none';
    document.getElementById('<%=trRangeYearFSFROM.ClientID %>').style.display = 'none'; 
 </script>