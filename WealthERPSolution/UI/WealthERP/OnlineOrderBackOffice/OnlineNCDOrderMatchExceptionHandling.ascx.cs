﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;
using System.Data;
using WealthERP.Base;
using System.Collections.Specialized;
using Microsoft.ApplicationBlocks.ExceptionManagement;


using VoUser;
using BoCommon;

using BoOnlineOrderManagement;
using VoOnlineOrderManagemnet;

using BoOps;


namespace WealthERP.OnlineOrderBackOffice
{
    public partial class OnlineNCDOrderMatchExceptionHandling : System.Web.UI.UserControl
    {

        UserVo userVo;
        AdvisorVo advisorVo;
        OnlineNCDBackOfficeBo onlineNCDBackOfficeBo = new OnlineNCDBackOfficeBo();
        OperationBo operationBo = new OperationBo();
        CommonLookupBo commonLookupBo = new CommonLookupBo();
        OnlineNCDBackOfficeVo onlineNCDBackOfficeVo;
        string categoryCode = "";

        protected void Page_Load(object sender, EventArgs e)
        {
            SessionBo.CheckSession();
            userVo = (UserVo)Session[SessionContents.UserVo];
            advisorVo = (AdvisorVo)Session["advisorVo"];
            int adviserId = advisorVo.advisorId;
            if (!IsPostBack)
            {
                BindIssuerIssue();
                BindOrderStatus();
            }
        }

        protected void btnGo_Click(object sender, EventArgs e)
        {

            if (ddlProduct.SelectedValue == "IP")
            {
                categoryCode = "FIIP";
            }
            else
            {
                categoryCode = "FISD";
            }
            BindOrdersGrid(Convert.ToInt32(ddlIssue.SelectedValue), categoryCode, ddlOrderStatus.SelectedValue, Convert.ToDateTime(txtFrom.Text), Convert.ToDateTime(txtTo.Text));
        }

        protected void btnManualMatchGo_Click(object sender, EventArgs e)
        {
            Button btnMatchGO = (Button)sender;
            GridEditableItem editedItem = btnMatchGO.NamingContainer as GridEditableItem;
            DropDownList ddlIssuer = (DropDownList)editedItem.FindControl("ddlIssuer");
            RadGrid gvUnmatchedAllotments = (RadGrid)editedItem.FindControl("gvUnmatchedAllotments");
            System.Web.UI.HtmlControls.HtmlTableRow trUnMatchedGrd = (System.Web.UI.HtmlControls.HtmlTableRow)editedItem.FindControl("trUnMatchedGrd");
            System.Web.UI.HtmlControls.HtmlTableRow trUnMatchedBtns = (System.Web.UI.HtmlControls.HtmlTableRow)editedItem.FindControl("trUnMatchedBtns");
            trUnMatchedGrd.Visible = true;
            trUnMatchedBtns.Visible = true;

            BindUnmatchedAllotmentsGrid(gvUnmatchedAllotments, Convert.ToInt32(ddlIssuer.SelectedValue));

        }

        protected void gvOrders_ItemDataBound(object sender, GridItemEventArgs e)
        {
            try
            {
                if ((e.Item is GridEditFormItem) && (e.Item.IsInEditMode) && e.Item.ItemIndex != -1)
                {
                    DropDownList ddlIssuer = (DropDownList)e.Item.FindControl("ddlIssuer");
                    RadGrid gvUnmatchedAllotments = (RadGrid)e.Item.FindControl("gvUnmatchedAllotments");
                    Button btnMatchGO = (Button)e.Item.FindControl("btnMatchGO");
                    System.Web.UI.HtmlControls.HtmlTableRow trUnMatchedGrd = (System.Web.UI.HtmlControls.HtmlTableRow)e.Item.FindControl("trUnMatchedGrd");
                    System.Web.UI.HtmlControls.HtmlTableRow trUnMatchedBtns = (System.Web.UI.HtmlControls.HtmlTableRow)e.Item.FindControl("trUnMatchedBtns");
                    //Label lblordertype = e.Item.FindControl("lblOrderType") as Label;

                    trUnMatchedGrd.Visible = false;
                    trUnMatchedBtns.Visible = false;
                    BindIssuer(ddlIssuer);
                }
                if (e.Item is GridDataItem && e.Item.ItemIndex != -1)
                {
                    string Status = Convert.ToString(gvOrders.MasterTableView.DataKeyValues[e.Item.ItemIndex]["WOS_OrderStepCode"].ToString());
                    // EditCommandColumn colmatch = (EditCommandColumn)e.Item["Match"];

                    GridDataItem item = (GridDataItem)e.Item;
                    LinkButton editButton = (LinkButton)item["Match"].Controls[0];

                    if (Status == "")
                    {
                        editButton.Visible = false;
                    }
                    if (Status.Trim() == "IP")
                    {
                        editButton.Visible = true;
                    }
                    else
                    {
                        editButton.Visible = false;
                    }



                }

            }
            catch (BaseApplicationException Ex)
            {
                throw Ex;
            }
            catch (Exception Ex)
            {
                BaseApplicationException exBase = new BaseApplicationException(Ex.Message, Ex);
                NameValueCollection FunctionInfo = new NameValueCollection();
                FunctionInfo.Add("Method", "NCDIssuesetup.ascx.cs:gvOrders_ItemDataBound()");
                object[] objects = new object[2];
                objects[1] = sender;
                objects[2] = e;
                FunctionInfo = exBase.AddObject(FunctionInfo, objects);
                exBase.AdditionalInformation = FunctionInfo;
                ExceptionManager.Publish(exBase);
                throw exBase;
            }
        }


        protected void gvOrders_OnNeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            DataTable dtOrder = new DataTable();
            dtOrder = (DataTable)Cache[userVo.UserId.ToString() + "OrdersMatch"];// Cache["OrderMIS" + userVo.UserId];
            gvOrders.DataSource = dtOrder;
        }

        protected void gvOrders_ItemCommand(object source, GridCommandEventArgs e)
        {
            if (e.CommandName == RadGrid.UpdateCommandName)
            {
                RadGrid gvUnmatchedAllotments = (RadGrid)e.Item.FindControl("gvUnmatchedAllotments");
                int orderId = Convert.ToInt32(gvOrders.MasterTableView.DataKeyValues[e.Item.ItemIndex]["CO_OrderId"].ToString());
                ManualMatch(gvUnmatchedAllotments, orderId);
                BindOrdersGrid(Convert.ToInt32(ddlIssue.SelectedValue), categoryCode, ddlOrderStatus.SelectedValue, Convert.ToDateTime(txtFrom.Text), Convert.ToDateTime(txtTo.Text));
            }
        }


        private void ManualMatch(RadGrid gvUnmatchedAllotments, int orderId)
        {
            int i = 0;
            bool result = false;

            foreach (GridDataItem gvRow in gvUnmatchedAllotments.Items)
            {
                CheckBox chk = (CheckBox)gvRow.FindControl("cbUnMatched");
                if (chk.Checked)
                {
                    i++;
                }
            }
            if (i > 1)
            {
                ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "pageloadscript", "alert('Please select One record!');", true);
                return;
            }
            if (i == 0)
            {
                ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "pageloadscript", "alert('Please select a record!');", true);
                return;
            }

            foreach (GridDataItem gdi in gvUnmatchedAllotments.Items)
            {
                if (((CheckBox)gdi.FindControl("cbUnMatched")).Checked == true)
                {
                    int allotmentId = Convert.ToInt32(gdi["AIA_Id"].Text);// Convert.ToInt32(gvUnmatchedAllotments.MasterTableView.DataKeyValues[selectedRow - 1]["AIA_Id"].ToString());
                    result = onlineNCDBackOfficeBo.UpdateNcdOrderMannualMatch(orderId, allotmentId);
                }
            }

            if (result == true)
            {
                ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "pageloadscript", "alert('Match is done');", true);
                BindOrdersGrid(Convert.ToInt32(ddlIssue.SelectedValue), ddlProduct.SelectedValue, ddlOrderStatus.SelectedValue, Convert.ToDateTime(txtFrom.Text), Convert.ToDateTime(txtTo.Text));
            }
            else
                ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "pageloadscript", "alert('Not able to match');", true);
        }

        protected void gvUnmatchedAllotments_OnNeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            DataTable dtUNmatchedAllotments = new DataTable();
            dtUNmatchedAllotments = (DataTable)Cache[userVo.UserId.ToString() + "UnAllotedOrders"];// Cache["OrderMIS" + userVo.UserId];
            gvOrders.DataSource = dtUNmatchedAllotments;

        }

        private void BindUnmatchedAllotmentsGrid(RadGrid gvUnmatchedAllotments, int issuerID)
        {
            try
            {
                DataTable dtUNmatchedAllotments = new DataTable();
                dtUNmatchedAllotments = onlineNCDBackOfficeBo.GetUnmatchedAllotments(advisorVo.advisorId, issuerID).Tables[0];
                gvUnmatchedAllotments.DataSource = dtUNmatchedAllotments;
                gvUnmatchedAllotments.DataBind();
                if (Cache[userVo.UserId.ToString() + "UnAllotedOrders"] != null)
                    Cache.Remove(userVo.UserId.ToString() + "UnAllotedOrders");
                Cache.Insert(userVo.UserId.ToString() + "UnAllotedOrders", dtUNmatchedAllotments);
            }
            catch (BaseApplicationException Ex)
            {
                throw Ex;
            }
            catch (Exception Ex)
            {
                BaseApplicationException exBase = new BaseApplicationException(Ex.Message, Ex);
                NameValueCollection FunctionInfo = new NameValueCollection();
                FunctionInfo.Add("Method", "NCDIssuesetup.ascx.cs:BindSeriesCategoryGrid()");
                object[] objects = new object[1];
                //objects[1] = issuerId;
                //objects[2] = issueId;
                FunctionInfo = exBase.AddObject(FunctionInfo, objects);
                exBase.AdditionalInformation = FunctionInfo;
                ExceptionManager.Publish(exBase);
                throw exBase;
            }
        }

        private void BindOrdersGrid(int IssueId, string Product, string Status, DateTime FromDate, DateTime ToDate)
        {
            try
            {
                DataTable dtOrdersMatch = new DataTable();
                pnlGrid.Visible = true;
                dtOrdersMatch = onlineNCDBackOfficeBo.GetAdviserOrders(IssueId, Product, Status, FromDate, ToDate).Tables[0];
                gvOrders.DataSource = dtOrdersMatch;
                gvOrders.DataBind();
                if (Cache[userVo.UserId.ToString() + "OrdersMatch"] != null)
                    Cache.Remove(userVo.UserId.ToString() + "OrdersMatch");
                Cache.Insert(userVo.UserId.ToString() + "OrdersMatch", dtOrdersMatch);
            }
            catch (BaseApplicationException Ex)
            {
                throw Ex;
            }
            catch (Exception Ex)
            {
                BaseApplicationException exBase = new BaseApplicationException(Ex.Message, Ex);
                NameValueCollection FunctionInfo = new NameValueCollection();
                FunctionInfo.Add("Method", "NCDIssuesetup.ascx.cs:BindSeriesCategoryGrid()");
                object[] objects = new object[1];
                //objects[1] = issuerId;
                //objects[2] = issueId;
                FunctionInfo = exBase.AddObject(FunctionInfo, objects);
                exBase.AdditionalInformation = FunctionInfo;
                ExceptionManager.Publish(exBase);
                throw exBase;
            }
        }

        private void BindOrderStatus()
        {
            DataSet dsOrderStaus;
            DataTable dtOrderStatus;
            dsOrderStaus = operationBo.Get_Onl_OrderStatus();
            dtOrderStatus = dsOrderStaus.Tables[0];
            if (dtOrderStatus.Rows.Count > 0)
            {
                ddlOrderStatus.DataSource = dtOrderStatus;
                ddlOrderStatus.DataValueField = dtOrderStatus.Columns["WOS_OrderStepCode"].ToString();
                ddlOrderStatus.DataTextField = dtOrderStatus.Columns["WOS_OrderStep"].ToString();
                ddlOrderStatus.DataBind();
            }
            ddlOrderStatus.Items.Insert(0, new ListItem("Select", "Select"));
        }

        protected void ddlOrderStatus_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlOrderStatus.SelectedValue == "IP")
            {
                pnlBtns.Visible = true;
            }
            else
            {
                pnlBtns.Visible = false;
            }

        }

        private void BindIssuer(DropDownList ddlIssuer)
        {
            try
            {
                DataSet dsIssuer = new DataSet();
                dsIssuer = onlineNCDBackOfficeBo.GetIssuer();
                if (dsIssuer.Tables[0].Rows.Count > 0)
                {
                    ddlIssuer.DataSource = dsIssuer;
                    ddlIssuer.DataValueField = dsIssuer.Tables[0].Columns["PI_issuerId"].ToString();
                    ddlIssuer.DataTextField = dsIssuer.Tables[0].Columns["PI_IssuerName"].ToString();
                    ddlIssuer.DataBind();
                }
                ddlIssuer.Items.Insert(0, new ListItem("Select", "Select"));

            }
            catch (BaseApplicationException Ex)
            {
                throw Ex;
            }
            catch (Exception Ex)
            {
                BaseApplicationException exBase = new BaseApplicationException(Ex.Message, Ex);
                NameValueCollection FunctionInfo = new NameValueCollection();
                FunctionInfo.Add("Method", "OnlineNCDOrderMatchExceptionHandling.ascx.cs:BindIssuer()");
                object[] objects = new object[0];
                FunctionInfo = exBase.AddObject(FunctionInfo, objects);
                exBase.AdditionalInformation = FunctionInfo;
                ExceptionManager.Publish(exBase);
                throw exBase;
            }

        }

        private void BindIssuerIssue()
        {
            try
            {
                DataSet dsIssuer = new DataSet();
                dsIssuer = onlineNCDBackOfficeBo.GetIssuerIssue(advisorVo.advisorId);
                if (dsIssuer.Tables[0].Rows.Count > 0)
                {
                    ddlIssue.DataSource = dsIssuer;
                    ddlIssue.DataValueField = dsIssuer.Tables[0].Columns["AIM_IssueId"].ToString();
                    ddlIssue.DataTextField = dsIssuer.Tables[0].Columns["AIM_IssueName"].ToString();
                    ddlIssue.DataBind();
                }
                ddlIssue.Items.Insert(0, new ListItem("Select", "Select"));

            }
            catch (BaseApplicationException Ex)
            {
                throw Ex;
            }
            catch (Exception Ex)
            {
                BaseApplicationException exBase = new BaseApplicationException(Ex.Message, Ex);
                NameValueCollection FunctionInfo = new NameValueCollection();
                FunctionInfo.Add("Method", "OnlineNCDOrderMatchExceptionHandling.ascx.cs:BindIssuer()");
                object[] objects = new object[0];
                FunctionInfo = exBase.AddObject(FunctionInfo, objects);
                exBase.AdditionalInformation = FunctionInfo;
                ExceptionManager.Publish(exBase);
                throw exBase;
            }

        }


        private bool MFAutoMatch()
        {
            int OrderId = 0;

            bool result = false;
            foreach (GridDataItem gdi in gvOrders.Items)
            {
                if (((CheckBox)gdi.FindControl("cbAutoMatch")).Checked == true)
                {
                    int selectedRow = gdi.ItemIndex + 1;
                    OrderId = Convert.ToInt32(gvOrders.MasterTableView.DataKeyValues[selectedRow - 1]["CO_OrderId"].ToString());

                    result = onlineNCDBackOfficeBo.UpdateNcdAutoMatch(OrderId);

                }
            }

            return result;
        }

        protected void btnAutoMatch_Click(object sender, EventArgs e)
        {
            int i = 0;
            bool result = false;

            foreach (GridDataItem gvRow in gvOrders.Items)
            {
                CheckBox chk = (CheckBox)gvRow.FindControl("cbAutoMatch");
                if (chk.Checked)
                {
                    i++;
                }
            }
            if (i == 0)
            {
                ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "pageloadscript", "alert('Please select a record!');", true);
                //BindMISGridView();
                return;
            }

            result = MFAutoMatch();

            if (result == true)
            {
                ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "pageloadscript", "alert('Match is done');", true);
                BindOrdersGrid(Convert.ToInt32(ddlIssue.SelectedValue), ddlProduct.SelectedValue, ddlOrderStatus.SelectedValue, Convert.ToDateTime(txtFrom.Text), Convert.ToDateTime(txtTo.Text));
            }
            else
                ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "pageloadscript", "alert('Not able to match');", true);


        }



    }
}
