﻿using VoUser;
using BoFPSuperlite;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using BoCustomerPortfolio;
using VoUser;
using BoCustomerProfiling;
using WealthERP.Base;
using BoCommon;
using Microsoft.ApplicationBlocks.ExceptionManagement;
using System.Collections.Specialized;
using BoAdvisorProfiling;
using BoUploads;
using Telerik.Web.UI;
using BoProductMaster;
using BoOps;
using BOAssociates;
using System.Configuration;
using VoOps;
using BoWerpAdmin;
using VoCustomerPortfolio;
using VOAssociates;
using iTextSharp.text.pdf;
using System.IO;
using System.Globalization;
using BoOnlineOrderManagement;
using VoOnlineOrderManagemnet;
using System.Text;
using VoCustomerProfiling;
using BoFPSuperlite;
using System;

namespace WealthERP.FP
{
    public partial class CustomerCashFlow : System.Web.UI.UserControl
    {
        CustomerVo customerVo = new CustomerVo();
        CustomerFPAnalyticsBo customerFPAnalyticsBo = new CustomerFPAnalyticsBo();
        DataSet dsGetProductTypes;
        int customercashrecomendationid;
        UserVo userVo = new UserVo();
        DataSet dsGetDropDownList;
        int ProductListId;
        int CCRL_ID = 0;
        int CFCustomerId = 0;
      

        protected void Page_Load(object sender, EventArgs e)
        {
            customerVo = (CustomerVo)Session["customerVo"];
            userVo = (UserVo)Session["userVo"];
            if (!IsPostBack)
            {
                BindProductType();
                if (Request.QueryString["action"] != "" && Request.QueryString["action"] != null)
                {
                    if (Request.QueryString["action"].Trim() == "Edit")
                    {
                        BtnSetVisiblity(1);
                        EditCustomerCashFlowDetails();
                    }
                    else if (Request.QueryString["action"].Trim() == "View")
                    {
                        BtnSetVisiblity(0);
                        lnkBack.Visible = true;
                        BindCustomerCashFlowDetails();
                    }
                    else
                    {
                       // BtnSetVisiblity(0);
                        //BindCustomerCashFlowDetails();
                    }

                }
            }
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            customercashrecomendationid = customerFPAnalyticsBo.CreateCashFlowRecomendation(customerVo.CustomerId, userVo.UserId, Convert.ToInt32(ddlptype.SelectedValue), Convert.ToInt32(DropDownList1.SelectedValue), DropDownList2.SelectedValue, Convert.ToDecimal(txtAmount.Text), Convert.ToDateTime(txtStartDate.SelectedDate), Convert.ToDateTime(txtEndDate.SelectedDate), Convert.ToDecimal(txtsumassure.Text), Convert.ToDateTime(txtRecomendationDate.SelectedDate), txtRemarks.Text, ddlfrequncy.SelectedValue,Convert.ToInt32(ddlpaytyppe.SelectedValue),Convert.ToInt32(txttenure.Text));
            ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "MyScript", "alert('Record Submitted Sucessfully.');", true);
            ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "pageloadscript", "loadcontrol('CustomerCashFlowView','none');", true);
        }

        private void BindCustomerCashFlowDetails()
        {
            DataSet ds = customerFPAnalyticsBo.CustomerCashFlowDetails(int.Parse(Request.QueryString["CFCustomerId"]));
            foreach (DataRow dr in ds.Tables[0].Rows)
            {
                ddlptype.SelectedValue = dr["CRPL_ID"].ToString();
                BindAllControl();
                txtAmount.Text = dr["CCRL_Amount"].ToString();
                txtRemarks.Text = dr["CCRL_Remarks"].ToString();
                txtsumassure.Text = dr["CCRL_SumAssured"].ToString();
                ddlfrequncy.SelectedValue = dr["CCRL_FrequencyMode"].ToString();
                txtStartDate.SelectedDate = Convert.ToDateTime(dr["CCRL_StartDate"].ToString());
                txtEndDate.SelectedDate = Convert.ToDateTime(dr["CCRL_EndDate"].ToString());
                txtRecomendationDate.SelectedDate = Convert.ToDateTime(dr["CCRL_RecommendationDate"].ToString());
                txttenure.Text = dr["CCRL_tenure"].ToString();
                ddlpaytyppe.SelectedValue = dr["CCRL_Paymentmode"].ToString();
                chkIsactive.Checked = Convert.ToBoolean(dr["CCRL_Isactive"].ToString());

                SetVisiblity(0);

            }
        }

        private void EditCustomerCashFlowDetails()
        {
            DataSet ds = customerFPAnalyticsBo.CustomerCashFlowDetails(int.Parse(Request.QueryString["CFCustomerId"]));
            foreach (DataRow dr in ds.Tables[0].Rows)
            {
                ddlptype.SelectedValue = dr["CRPL_ID"].ToString();
                BindAllControl();
                txtAmount.Text = dr["CCRL_Amount"].ToString();
                txtRemarks.Text = dr["CCRL_Remarks"].ToString();
                txtsumassure.Text = dr["CCRL_SumAssured"].ToString();
                ddlfrequncy.SelectedValue = dr["CCRL_FrequencyMode"].ToString();
                txtStartDate.SelectedDate = Convert.ToDateTime(dr["CCRL_StartDate"].ToString());
                txtEndDate.SelectedDate = Convert.ToDateTime(dr["CCRL_EndDate"].ToString());
                txtEndDate.Enabled = false;
                txtRecomendationDate.SelectedDate = Convert.ToDateTime(dr["CCRL_RecommendationDate"].ToString());
                txttenure.Text = dr["CCRL_tenure"].ToString();
                ddlpaytyppe.SelectedValue = dr["CCRL_Paymentmode"].ToString();
                chkIsactive.Checked = Convert.ToBoolean(dr["CCRL_Isactive"].ToString());
            }
        }

        private void BindProductType()
        {
            dsGetProductTypes = customerFPAnalyticsBo.GetProductTypes();
            ddlptype.DataSource = dsGetProductTypes.Tables[0];
            ddlptype.DataTextField = "CRPL_ProductName";
            ddlptype.DataValueField = "CRPL_ID";
            ddlptype.DataBind();
            ddlptype.Items.Insert(0, new ListItem("Select", "0"));

        }

        protected void ddlpaytyppe_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlpaytyppe.SelectedItem.Value.ToString() == "lump sum amt")
            {
                ddlfrequncy.Visible = false;
                lblfrequncy.Visible = false;
                txtEndDate.Visible = false;
                lblEndDate.Visible = false;
            }
            else
            {
                txtAmount.Visible = true;
                txtRemarks.Visible = true;
                txtStartDate.Visible = true;
                ddlpaytyppe.Visible = true;
                txtsumassure.Visible = true;
                ddlfrequncy.Visible = true;
                lblfrequncy.Visible = true;
                lblEndDate.Visible = true;
                txtEndDate.Visible = true;
                txttenure.Visible = true;
                chkIsactive.Visible = true;
            }
        }

        protected void DropDownList2_SelectedIndexChanged(object sender, EventArgs e)
        {

        }
        protected void ddlptype_SelectedIndexChanged(object sender, EventArgs e)
        {
            BindAllControl();
        }
        protected void BindAllControl()
        {
            dsGetDropDownList = customerFPAnalyticsBo.GetCustomerCashFlowDropDownList(Convert.ToInt32(ddlptype.SelectedValue));
            DropDownList1.DataSource = dsGetDropDownList.Tables[0];
            DropDownList1.DataTextField = "Name";
            DropDownList1.DataValueField = "code";
            DropDownList1.DataBind();
            //DropDownList1.Items.Insert(0, new ListItem("Select", "0"));
            DropDownList2.DataSource = dsGetDropDownList.Tables[1];
            DropDownList2.DataTextField = "Name";
            DropDownList2.DataValueField = "code";
            DropDownList2.DataBind();
            //DropDownList2.Items.Insert(0, new ListItem("Select", "0"));
            //ddlpaytyppe.DataSource = dsGetDropDownList.Tables[2];
            //ddlpaytyppe.DataTextField = "Name";
            //ddlpaytyppe.DataValueField = "code";
            //ddlpaytyppe.DataBind();
            //ddlpaytyppe.Items.Insert(0, new ListItem("Select", "0"));

        }
        protected void lnkEdit_Click(object sender, EventArgs e)
        {
            txtEndDate.Enabled = false;
            SetEditFields();

        }
        private void SetEditFields()
        {
            btnSubmit.Visible = false;
            btnUpdate.Visible = true;
            ddlfrequncy.Enabled = true;
            ddlpaytyppe.Enabled = true;
            DropDownList1.Enabled = true;
            DropDownList2.Enabled = true;
            txtStartDate.Enabled = true;
            txtEndDate.Enabled = false;
            txtRemarks.Enabled = true;
            txtAmount.Enabled = true;
            txtsumassure.Enabled = true;
            ddlptype.Enabled = true;
            txtRecomendationDate.Enabled = true;
            txttenure.Enabled = true;
            chkIsactive.Enabled = true;
            lnkEdit.Visible = false;


            DataSet ds = customerFPAnalyticsBo.CustomerCashFlowDetails(int.Parse(Request.QueryString["CFCustomerId"]));
            foreach (DataRow dr in ds.Tables[0].Rows)
            {
                ddlptype.SelectedValue = dr["CRPL_ID"].ToString();
                BindAllControl();
                txtAmount.Text = dr["CCRL_Amount"].ToString();
                txtRemarks.Text = dr["CCRL_Remarks"].ToString();
                txtsumassure.Text = dr["CCRL_SumAssured"].ToString();
                ddlfrequncy.SelectedValue = dr["CCRL_FrequencyMode"].ToString();
                txtStartDate.SelectedDate = Convert.ToDateTime(dr["CCRL_StartDate"].ToString());
                txtEndDate.SelectedDate = Convert.ToDateTime(dr["CCRL_EndDate"].ToString());
                txtEndDate.Enabled = false;
                txtRecomendationDate.SelectedDate = Convert.ToDateTime(dr["CCRL_RecommendationDate"].ToString());
                txttenure.Text = dr["CCRL_tenure"].ToString();
                ddlpaytyppe.SelectedValue = dr["CCRL_Paymentmode"].ToString();
                chkIsactive.Checked = Convert.ToBoolean(dr["CCRL_Isactive"].ToString());
            }
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            Page.ClientScript.RegisterClientScriptBlock(this.GetType(), "leftpane", "loadcontrol('CustomerCashFlowView','none');", true);
        }

        protected void lnkBack_Click(object sender, EventArgs e)
        {
            ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "leftpane", "loadcontrol('CustomerCashFlowView','none');", true);

        }
        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            customercashrecomendationid = customerFPAnalyticsBo.UpdateCashFlowRecomendation(customerVo.CustomerId, userVo.UserId,20, Convert.ToInt32(ddlptype.SelectedValue), Convert.ToInt32(DropDownList1.SelectedValue), DropDownList2.SelectedValue, Convert.ToDecimal(txtAmount.Text), Convert.ToDateTime(txtStartDate.SelectedDate), Convert.ToDateTime(txtEndDate.SelectedDate), Convert.ToDecimal(txtsumassure.Text), Convert.ToDateTime(txtRecomendationDate.SelectedDate), txtRemarks.Text, ddlfrequncy.SelectedValue, Convert.ToInt32(ddlpaytyppe.SelectedValue), Convert.ToInt32(txttenure.Text));
            ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "MyScript", "alert('Record Updated Sucessfully.');", true);
            ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "pageloadscript", "loadcontrol('CustomerCashFlowView','none');", true);
        }
        private void SetVisiblity(int p)
        {
            if (p == 0)
            {
                // For View Mode
                ddlfrequncy.Enabled = false;
                ddlpaytyppe.Enabled = false;
                DropDownList1.Enabled = false;
                DropDownList2.Enabled = false;
                txtStartDate.Enabled = false;
                txtEndDate.Enabled = false;
                txtRemarks.Enabled = false;
                txtAmount.Enabled = false;
                txtsumassure.Enabled = false;
                ddlptype.Enabled = false;
                txtRecomendationDate.Enabled = false;
                txttenure.Enabled = false;
                chkIsactive.Enabled = false;
                txtTenureMonths.Visible = false;


            }
            else
            {
                //for Edit Mode

                ddlfrequncy.Enabled = true;
                ddlpaytyppe.Enabled = true;
                DropDownList1.Enabled = true;
                DropDownList2.Enabled = true;
                txtStartDate.Enabled = true;
                txtEndDate.Enabled = false;
                txtRemarks.Enabled = true;
                txtAmount.Enabled = true;
                txtsumassure.Enabled = true;
                ddlptype.Enabled = true;
                txtRecomendationDate.Enabled = true;
                txttenure.Enabled = true;
                chkIsactive.Enabled = true;
                txtTenureMonths.Enabled = true;

            }
        }




        private void BtnSetVisiblity(int p)
        {
            if (p == 0)
            {   //for view selected
               // lblError.Visible = false;
                lnkEdit.Visible = true;
                btnSubmit.Visible = false;
                btnUpdate.Visible = false;
                lnkBack.Visible = false;

            }
            else
            {  //for Edit selected 
               // lblError.Visible = true;
                lnkEdit.Visible = false;
                btnSubmit.Visible = false;
                btnUpdate.Visible = true;
                lnkBack.Visible = true;
            }


        }

        protected void ddlfrequncy_SelectedIndexChanged(object sender, EventArgs e)
        {


            if ((String.IsNullOrEmpty(txttenure.Text)) || (String.IsNullOrEmpty(txtStartDate.ToString())))
            {
                ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "pageloadscript", "alert('Please fill enter values into Previous texboxs');", true);

            }


            else
            {
              //  CalcEndDate(Int16.Parse(txttenure.Text), DateTime.Parse(txtStartDate.ToString()));
                CalcEndDate(Int16.Parse(txttenure.Text), DateTime.Parse(txtStartDate.SelectedDate.ToString()));


                btnSubmit.Enabled = true;
            }

        }

        private void CalcEndDate(Int16 period, DateTime startDate)
        {
            DateTime endDate = new DateTime();
            if (ddlfrequncy.SelectedItem.Value == "MN")
            {
                int a = (period * 12) + ((!string.IsNullOrEmpty(txtTenureMonths.Text)) ? int.Parse(txtTenureMonths.Text) : 0);
                DateTime dt = DateTime.Now.AddMonths(a);
                endDate = dt;
            }
            else if (ddlfrequncy.SelectedItem.Value == "YR")
            {
                int a = (period * 12) + ((!string.IsNullOrEmpty(txtTenureMonths.Text)) ? int.Parse(txtTenureMonths.Text) : 0);
                DateTime dt = DateTime.Now.AddMonths(a);
                endDate = dt;
                //endDate = startDate.AddYears(period);
            }
            else if (ddlfrequncy.SelectedItem.Value == "QT")
            {
                int a = (period * 12) + ((!string.IsNullOrEmpty(txtTenureMonths.Text)) ? int.Parse(txtTenureMonths.Text) : 0);
                DateTime dt = DateTime.Now.AddMonths(a);
                endDate = dt;
                //endDate = startDate.AddYears(period);
            }
            else if (ddlfrequncy.SelectedItem.Value == "HY")
            {
                int a = (period * 12) + ((!string.IsNullOrEmpty(txtTenureMonths.Text)) ? int.Parse(txtTenureMonths.Text) : 0);
                DateTime dt = DateTime.Now.AddMonths(a);
                endDate = dt;
                //endDate = startDate.AddYears(period);
            }
            txtEndDate.SelectedDate = Convert.ToDateTime(endDate.ToString());
        }

    }
}