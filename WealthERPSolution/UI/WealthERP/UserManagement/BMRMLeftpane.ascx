﻿<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="BMRMLeftpane.ascx.cs"
    Inherits="WealthERP.UserManagement.BMRMLeftpane" %>
<asp:TreeView ID="TreeView1" runat="server" ShowLines="True" OnSelectedNodeChanged="TreeView1_SelectedNodeChanged">
    <Nodes>
        <asp:TreeNode Text="Roles" Value="Roles">
            <asp:TreeNode Text="Branch Manager" Value="Branch Manager"></asp:TreeNode>
            <asp:TreeNode Text="RM" Value="RM"></asp:TreeNode>
        </asp:TreeNode>
    </Nodes>
    <NodeStyle Font-Names="Verdana" Font-Size="8pt" ForeColor="Black" HorizontalPadding="5px"
        NodeSpacing="0px" VerticalPadding="0px" />
</asp:TreeView>
