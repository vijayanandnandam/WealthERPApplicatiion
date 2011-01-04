﻿<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="FPSectional.ascx.cs" Inherits="WealthERP.Reports.FPSectional" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>
<asp:ScriptManager ID="ScriptManager1" runat="server">
    
</asp:ScriptManager>

<table border="0" width="100%">
    <tr>
        <td colspan="3">
            <asp:Label ID="lblHeader" runat="server" CssClass="HeaderTextSmall" Text="Financial Planning Reports"></asp:Label>
            <hr />
        </td>
        
    </tr>  
    
      <tr>
      <td style="width:3%">
      </td> 
      <td colspan="2">
       <asp:CheckBox ID="CheckBox1" runat="server" CssClass="cmbField" Text="Select All" Enabled="false" />
      </td>
      </tr>
      
      <tr>
      <td style="width:3%">
      </td> 
      <td colspan="2">
      <div id="Div1">
      <fieldset style="height: 30%; width: 50%;">
       <legend class="HeaderTextSmall">Select the sections to generate the report</legend>
       <table width="100%">
        <tr>
            <td style="width:3%">
            </td> 
            <td style="width:44%">
             <asp:CheckBox ID="chkCover_page" runat="server" CssClass="cmbField" Text="Cover page" />
            </td>
            <td style="width:50%">
             <asp:CheckBox ID="chkIncome_Expense" runat="server" CssClass="cmbField" Text="Income and Expense Summary" />
            </td>
        </tr>    
      
         <tr>
            <td style="width:3%">
            </td> 
            <td style="width:44%">
             <asp:CheckBox ID="chkRM_Messgae" runat="server" CssClass="cmbField" Text="RM Messgae" />
            </td>
            <td style="width:50%">
             <asp:CheckBox ID="chkCash_Flows" runat="server" CssClass="cmbField" Text="Cash Flows" />
            </td>
         </tr>
         
         
         <tr>
    <td style="width:3%">
    </td> 
    <td style="width:44%">
     <asp:CheckBox ID="chkImage" runat="server" CssClass="cmbField" Text="Image" /> 
    </td>
    <td style="width:50%">
   <asp:CheckBox ID="chkNetWorthSummary" runat="server" CssClass="cmbField" Text="Net Worth Summary" />
    </td>
    </tr>
    
      
    <tr>
    <td style="width:3%">
    </td> 
    <td style="width:44%">
     <asp:CheckBox ID="chkTableContent" runat="server" CssClass="cmbField" Text="Table of Content" Enabled="false" /> 
    </td>
    <td style="width:50%">
    <asp:CheckBox ID="chkRiskProfile" runat="server" CssClass="cmbField" Text=" Risk profile & Portfolio allocation" />
    </td>
    </tr>
    
      
    <tr>
    <td style="width:3%">
    </td> 
    <td style="width:44%">
     <asp:CheckBox ID="chkFPIntroduction" runat="server" CssClass="cmbField" Text="FP Introduction" />
    </td>
    <td style="width:50%">
     <asp:CheckBox ID="chkInsurance" runat="server" CssClass="cmbField" Text="Insurance Details" />  
    </td>
    </tr>
   
      
    <tr>
    <td style="width:3%">
    </td> 
   <td style="width:44%">
     <asp:CheckBox ID="chkProfileSummary" runat="server" CssClass="cmbField" Text="Profile Summary" />    
    </td>
    <td style="width:50%">
     <asp:CheckBox ID="chkCurrentObservation" runat="server" CssClass="cmbField" Text="Current Situation and Observations" /> 
    </td>
    </tr>
    
    
    
      
    <tr>
    <td style="width:3%">
    </td> 
    <td style="width:44%">
    <asp:CheckBox ID="chkFinancialHealth" runat="server" CssClass="cmbField" Text="Financial Health" /> 
    </td>
    <td style="width:50%">
     <asp:CheckBox ID="chkDisclaimer" runat="server" CssClass="cmbField" Text="Disclaimer" />     
    </td>
    </tr>  
    
    
    <tr>
    <td style="width:3%">
    </td> 
    <td style="width:44%">
    <%-- <asp:CheckBox ID="chkKeyAssumptions" runat="server" CssClass="cmbField" Text="Key Assumptions" />  --%>
    <asp:CheckBox ID="chkGoalProfile" runat="server" CssClass="cmbField" Text="Goal Profiling" />      
    </td>
    <td style="width:50%">
    <asp:CheckBox ID="chkNotes" runat="server" CssClass="cmbField" Text="Notes" /> 
    </td>
    </tr>   
    
         
       </table>
      </fieldset>
      </div>
      </td>
      </tr>
    
    
    <tr>
   
    </tr>    
    <tr>
    <td style="width:3%">
    </td> 
    <td style="width:50%">
    <asp:Button ID="btnViewReport" runat="server" Text="View Report" 
     PostBackUrl="~/Reports/Display.aspx?mail=0" CssClass="PCGMediumButton" />
    </td>
    <td style="width:50%">
    
    </td>
    </tr>
 </table>
 
 
 
 