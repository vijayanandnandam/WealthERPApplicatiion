﻿using System;
using System.Collections.Generic;
using System.Linq;
using BoUser;
using VoUser;
using WealthERP.Base;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using VoCustomerPortfolio;
using BoCustomerPortfolio;
using VoUser;
using WealthERP.Base;
using System.Data;
using Microsoft.ApplicationBlocks.ExceptionManagement;
using System.Collections.Specialized;
using BoCommon;
using BoCalculator;
using Telerik.Web.UI;


namespace WealthERP.Customer
{
    public partial class CustomerISARequestList : System.Web.UI.UserControl
    {
        UserBo userBo;
        UserVo userVo;
        List<LiabilitiesVo> ISAQueueListVo = null;
        LiabilitiesBo liabilitiesBo = new LiabilitiesBo();
        CustomerVo customerVo = null;
        Calculator calculator = new Calculator();
        AdvisorVo advisorVo = new AdvisorVo();
        int advisorId;

        protected void Page_Load(object sender, EventArgs e)
        {
            SessionBo.CheckSession();
            userBo = new UserBo();
            userVo = (UserVo)Session[SessionContents.UserVo];
            advisorVo = (AdvisorVo)Session[SessionContents.AdvisorVo];
            if (!IsPostBack)
            {

                advisorId = advisorVo.advisorId;
                BindGridview();
            }
        }
        protected void gvISArequest_OnNeedDataSource(object source, GridNeedDataSourceEventArgs e)
        {
            gvISArequest.Visible = true;
            DataTable dt = new DataTable();

            btnExportFilteredData.Visible = true;
            dt = (DataTable)Cache["IsaRequestDetails  + '" + advisorVo.advisorId + "'"];
            gvISArequest.DataSource = dt;
        }
        protected void btnExportFilteredData_OnClick(object sender, ImageClickEventArgs e)
        {

            gvISArequest.ExportSettings.OpenInNewWindow = true;
            gvISArequest.ExportSettings.IgnorePaging = true;
            foreach (GridFilteringItem filter in gvISArequest.MasterTableView.GetItems(GridItemType.FilteringItem))
            {
                filter.Visible = false;
            }
            gvISArequest.MasterTableView.ExportToExcel();

        }
        protected void BindGridview()
        {
            ISAQueueListVo = new List<LiabilitiesVo>();
            LiabilitiesVo liabilityVo = new LiabilitiesVo();
            ISAQueueListVo = liabilitiesBo.GetISAQueueList(advisorVo.advisorId);
            DataTable dt = new DataTable();
            DataRow dr;
            Double loanOutStanding = 0;
            DateTime nextInsDate = new DateTime();

            if (ISAQueueListVo != null)
            {
                btnExportFilteredData.Visible = true;
                trErrorMessage.Visible = false;
                dt.Columns.Add("AISAQ_RequestQueueid");
                dt.Columns.Add("AISAQ_date");
                dt.Columns.Add("AISAQ_Status");
                dt.Columns.Add("AISAQ_Priority");
                dt.Columns.Add("CustomerName");
                dt.Columns.Add("WWFSM_StepCode");
                dt.Columns.Add("AISAQD_Status");
                dt.Columns.Add("BranchName");
                dt.Columns.Add("StepName");
                dt.Columns.Add("StatusCode");

                for (int i = 0; i < ISAQueueListVo.Count; i++)
                {
                    dr = dt.NewRow();
                    liabilityVo = ISAQueueListVo[i];
                    dr[0] = liabilityVo.ISARequestId;
                    if (liabilityVo.RequestDate != DateTime.MinValue)
                        dr[1] = liabilityVo.RequestDate.ToShortDateString();
                    if (liabilityVo.CurrentStatus != null)
                        dr[2] = liabilityVo.CurrentStatus;
                    if (liabilityVo.Priority != null)
                        dr[3] = liabilityVo.Priority;
                    if (liabilityVo.CustomerName != null)
                        dr[4] = liabilityVo.CustomerName;
                    if (liabilityVo.StepCode != null)
                        dr[5] = liabilityVo.StepCode;
                    if (liabilityVo.Status != null)
                        dr[6] = liabilityVo.Status;
                    if (liabilityVo.BranchName != null)
                        dr[7] = liabilityVo.BranchName;
                    if (liabilityVo.StepName != null)
                        dr[8] = liabilityVo.StepName;
                    if (liabilityVo.StatusCode != null)
                        dr[9] = liabilityVo.StatusCode;
                    dt.Rows.Add(dr);
                }
                gvISArequest.DataSource = dt;
                gvISArequest.DataBind();

                if (Cache["IsaRequestDetails + '" + advisorVo.advisorId + "'"] == null)
                {
                    Cache.Insert("IsaRequestDetails  + '" + advisorVo.advisorId + "'", dt);
                }
                else
                {
                    Cache.Remove("IsaRequestDetails  + '" + advisorVo.advisorId + "'");
                    Cache.Insert("IsaRequestDetails  + '" + advisorVo.advisorId + "'", dt);
                }

            }

            else
            {
                trErrorMessage.Visible = true;
                gvISArequest.Visible = false;
                btnExportFilteredData.Visible = false;
            }
        }
        protected void ddlAction_OnSelectedIndexChange(object sender, EventArgs e)
        {
            RadComboBox ddlAction = (RadComboBox)sender;
            //Page.ClientScript.RegisterClientScriptBlock(this.GetType(), "leftpane", "Page_ClientValidate();Loading(true);", true); 
            GridDataItem gvr = (GridDataItem)ddlAction.NamingContainer;
            int selectedRow = gvr.ItemIndex + 1;
            int requestId = int.Parse(gvISArequest.MasterTableView.DataKeyValues[selectedRow - 1]["AISAQ_RequestQueueid"].ToString());
            string statusCode = gvISArequest.MasterTableView.DataKeyValues[selectedRow - 1]["StatusCode"].ToString();
            string stepCode = gvISArequest.MasterTableView.DataKeyValues[selectedRow - 1]["WWFSM_StepCode"].ToString();
            if (ddlAction.SelectedValue == "View")
            {
                ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "GenerateISA", "loadcontrol('CustomerISARequest','?RequestId=" + requestId + "&stepCode=" + stepCode + "&statusCode=" + statusCode + "');", true);
            }

        }
    }
}
