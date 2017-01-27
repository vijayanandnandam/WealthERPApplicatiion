﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using BoUser;
using VoUser;
using WealthERP.Base;
using BoCommon;
using System.Configuration;
using BoCustomerPortfolio;
using System.Data;
using VOAssociates;
using VoAdvisorProfiling;
using VoCustomerPortfolio;
using BoCustomerProfiling;
using BoOnlineOrderManagement;
using BoAdvisorProfiling;
using Telerik.Web.UI;
namespace WealthERP.BusinessMIS
{
    public partial class Commissiondashboard : System.Web.UI.UserControl
    {
        UserBo userBo;
        UserVo userVo;
        AdvisorVo advisorVo;
        string path;
        AdvisorPreferenceVo advisorPrefernceVo = new AdvisorPreferenceVo();
        AssociatesVO associatesVo = new AssociatesVO();
        AssociatesUserHeirarchyVo assocUsrHeirVo = new AssociatesUserHeirarchyVo();
        RMVo rmVo = new RMVo();
        CustomerBo customerBo = new CustomerBo();

        protected void Page_Load(object sender, EventArgs e)
        {
            SessionBo.CheckSession();
            userVo = (UserVo)Session["userVo"];
            advisorPrefernceVo = (AdvisorPreferenceVo)Session["AdvisorPreferenceVo"];
            rmVo = (RMVo)Session["rmVo"];
            advisorVo = (AdvisorVo)Session["advisorVo"];
            associatesVo = (AssociatesVO)Session["associatesVo"];
            assocUsrHeirVo = (AssociatesUserHeirarchyVo)Session["associatesUserHeirarchyVo"];
            trNewOrder.Visible = false;
            if (!Page.IsPostBack)
            {
                if (Request.QueryString["IsAdd"] != null)
                {
                    if (Request.QueryString["IsAdd"].ToString() == "1")
                        dvAddMandate.Visible = true;
                    else
                        dvViewMandateMis.Visible = true;
                }
            }
            if (Session[SessionContents.CurrentUserRole].ToString().ToLower() == "admin" || Session[SessionContents.CurrentUserRole].ToString().ToLower() == "ops" || userVo.AdviserRole.ContainsValue("CNT"))
            {
                txtClientCode_autoCompleteExtender.ContextKey = advisorVo.advisorId.ToString();
                txtClientCode_autoCompleteExtender.ServiceMethod = "GetCustCode";

            }
            else if (Session[SessionContents.CurrentUserRole].ToString() == "BM")
            {

                txtClientCode_autoCompleteExtender.ContextKey = advisorVo.advisorId.ToString();
                txtClientCode_autoCompleteExtender.ServiceMethod = "GetCustCode";

            }
            else if (Session[SessionContents.CurrentUserRole].ToString() == "RM")
            {

                txtClientCode_autoCompleteExtender.ContextKey = advisorVo.advisorId.ToString();
                txtClientCode_autoCompleteExtender.ServiceMethod = "GetCustCode";

            }
            else if (Session[SessionContents.CurrentUserRole].ToString() == "Associates")
            {

                txtClientCode_autoCompleteExtender.ContextKey = advisorVo.advisorId.ToString();
                txtClientCode_autoCompleteExtender.ServiceMethod = "GetCustCode";
            }
        }
        protected void hdnCustomerId_ValueChanged(object sender, EventArgs e)
        {

            if (!string.IsNullOrEmpty(txtCustomerId.Value.ToString().Trim()))
            {
                CustomerVo customerVo = new CustomerVo();
                Session["customerid"] = txtCustomerId.Value.ToString();
                ScriptManager.RegisterStartupScript(Page, Page.GetType(), "confirm", " ShowIsa();", true);
                customerVo = customerBo.GetCustomer(int.Parse(txtCustomerId.Value));
                Session["customerVo"] = customerVo;

                lblgetPan.Text = customerVo.PANNum;
                lblgetcust.Text = customerVo.FirstName;

            }

        }
        protected void btnMandateSubmit_Click(object sender, EventArgs e)
        {
            string userMessage = string.Empty;
            string BSEMessage = string.Empty;
            char msgtype = 's';
            bool result = false;
            OnlineMFOrderBo onlineMFOrderBo = new OnlineMFOrderBo();
            int mandateId = 0;
            AdviserStaffSMTPBo advstaffsmtpbo = new AdviserStaffSMTPBo();
            if (txtCustomerId.Value != "0")
            {
                result = advstaffsmtpbo.BSEMandateCreate(txtClientCode.Text, lblgetcust.Text, Convert.ToDouble(txtAmount.Text), txtBankName.Text, txtBBranch.Text, userVo.UserId, out BSEMessage, out mandateId);
                if (result)
                {
                    int OrderId = onlineMFOrderBo.CreateMandateOrder(int.Parse(txtCustomerId.Value.ToString()), Convert.ToDouble(txtAmount.Text), txtBankName.Text, txtBBranch.Text, userVo.UserId, mandateId);
                    if (OrderId != 0)
                    {
                        userMessage = BSEMessage + " " + "Order Reference Number is: " + OrderId.ToString();
                        msgtype = 'S';
                        freezeControls();
                        trNewOrder.Visible = true;
                    }
                    else
                    {
                        userMessage = "Order cannot be processed";
                        msgtype = 'F';
                    }
                }
                else
                {
                    userMessage = BSEMessage;
                    msgtype = 'F';
                }
                ShowMessage(userMessage, msgtype);
                BindMandateddetailsDetailsGrid(advisorVo.advisorId);

            }
        }
        private void ShowMessage(string msg, char type)
        {
            //--S(success)
            //--F(failure)
            //--W(warning)
            //--I(information)
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "wsedrftgyhjukloghjnnnghj", " showMsg('" + msg + "','" + type.ToString() + "');", true);
        }
        private void freezeControls()
        {
            txtClientCode.Enabled = false;
            txtBankName.Enabled = false;
            txtBBranch.Enabled = false;
            txtAmount.Enabled = false;
            txtCustomerId.Value = "0";
        }
        protected void lnkMandateOrder_Click(object sender, EventArgs e)
        {
            ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "pageloadscript", "loadcontrol('Commissiondashboard','login');", true);
        }


        private void BindMandateddetailsDetailsGrid(int adviserId)
        {
            DataSet ds;
            DataTable dt = new DataTable();
            OnlineMFOrderBo onlineMFOrderBo = new OnlineMFOrderBo();
            ds = onlineMFOrderBo.BindMandateddetailsDetails(adviserId);
            dt = ds.Tables[0];

            gvMandatedetails.DataSource = dt;
            gvMandatedetails.DataBind();
            pnlZoneCluster.Visible = true;
            gvMandatedetails.Visible = true;
            UpdatePanel1.Visible = true;
            dvViewMandateMis.Visible = true;
            btnExportFilteredMandatedetails.Visible = true;

            if (Cache["gvMandatedetails" + advisorVo.advisorId.ToString()] == null)
            {
                Cache.Insert("gvMandatedetails" + advisorVo.advisorId.ToString(), dt);
            }
            else
            {
                Cache.Remove("gvMandatedetails" + advisorVo.advisorId.ToString());
                Cache.Insert("gvMandatedetails" + advisorVo.advisorId.ToString(), dt);
            }
        }




        protected void gvMandatedetails_NeedDataSource(object source, GridNeedDataSourceEventArgs e)
        {
            DataTable dt = new DataTable();
            dt = (DataTable)Cache["gvMandatedetails" + advisorVo.advisorId.ToString()];
            gvMandatedetails.DataSource = dt;

        }


        protected void btnExportFilteredMandatedetails_OnClick(object sender, ImageClickEventArgs e)
        {
            gvMandatedetails.ExportSettings.OpenInNewWindow = true;
            gvMandatedetails.ExportSettings.IgnorePaging = true;
            gvMandatedetails.ExportSettings.HideStructureColumns = true;
            gvMandatedetails.ExportSettings.ExportOnlyData = true;
            gvMandatedetails.ExportSettings.FileName = "Mandate details";
            gvMandatedetails.ExportSettings.Excel.Format = GridExcelExportFormat.ExcelML;
            gvMandatedetails.MasterTableView.ExportToExcel();


        }
    }

}