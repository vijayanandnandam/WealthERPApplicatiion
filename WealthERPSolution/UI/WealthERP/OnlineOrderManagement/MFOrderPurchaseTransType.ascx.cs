﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using BoCommon;
using System.Data.Common;
using VoCustomerPortfolio;
using BoCustomerPortfolio;
using Microsoft.ApplicationBlocks.ExceptionManagement;
using System.Collections.Specialized;
using Telerik.Web.UI;
using System.Text;
using BoOnlineOrderManagement;
using System.Configuration;
using VoUser;
using VoOnlineOrderManagemnet;

namespace WealthERP.OnlineOrderManagement
{
    public partial class MFOrderPurchaseTransactionType : System.Web.UI.UserControl
    {
        CommonLookupBo commonLookupBo = new CommonLookupBo();
        OnlineMFOrderBo onlineMforderBo = new OnlineMFOrderBo();
        CustomerAccountBo customerAccountBo = new CustomerAccountBo();
        CustomerAccountsVo customerAccountsVo = new CustomerAccountsVo();
        CustomerAccountAssociationVo customerAccountAssociationVo = new CustomerAccountAssociationVo();
        CustomerTransactionBo customerTransactionBo = new CustomerTransactionBo();
        CustomerVo customerVo = new CustomerVo();
        OnlineMFOrderVo onlinemforderVo = new OnlineMFOrderVo();
        UserVo userVo;
        string path;
        DataSet dsCustomerAssociates = new DataSet();
        DataTable dtCustomerAssociatesRaw = new DataTable();
        DataTable dtCustomerAssociates = new DataTable();
        DataRow drCustomerAssociates;
        int accountId;
        int OrderId;

        protected void Page_Load(object sender, EventArgs e)
        {
            path = Server.MapPath(ConfigurationManager.AppSettings["xmllookuppath"].ToString());
            SessionBo.CheckSession();
            customerVo = (CustomerVo)Session["customerVo"];
            userVo = (UserVo)Session["userVo"];
            if (!IsPostBack)
            {
                AmcBind();
                trJointHolder.Visible = true;
                trNominee.Visible = true;

            }


        }
        protected void AmcBind()
        {
            DataTable dtAmc = new DataTable();
            dtAmc = commonLookupBo.GetProdAmc();
            if (dtAmc.Rows.Count > 0)
            {
                ddlAmc.DataSource = dtAmc;
                ddlAmc.DataValueField = dtAmc.Columns["PA_AMCCode"].ToString();
                ddlAmc.DataTextField = dtAmc.Columns["PA_AMCName"].ToString();
                ddlAmc.DataBind();
                ddlAmc.Items.Insert(0, new ListItem("Select", "0"));
            }
        }

        public void ddlAmc_OnSelectedIndexChanged(object sender, EventArgs e)
        {
            CategoryBind();
            SchemeBind(int.Parse(ddlAmc.SelectedValue), null);
            BindFolioNumber(int.Parse(ddlAmc.SelectedValue));
        }
        public void ddlCategory_OnSelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlAmc.SelectedIndex != -1 && ddlCategory.SelectedIndex != -1)
            {
                int amcCode = int.Parse(ddlAmc.SelectedValue);
                string category = ddlCategory.SelectedValue.ToString();
                SchemeBind(amcCode, category);
            }

        }

        protected void ddlScheme_onSelectedChanged(object sender, EventArgs e)
        {
            if (ddlScheme.SelectedIndex != -1)
            {
                ResetControlDetails();
                GetControlDetails(int.Parse(ddlScheme.SelectedValue), null);
                SetControlDetails();
            }
        }

        protected void ResetControlDetails()
        {
            lblDividendType.Text = "";
            lblMintxt.Text = "";
            lblMulti.Text = "";
            lbltime.Text = "";
            lbldftext.Text = "";
            txtAmt.Text = "";
            lblNavDisplay.Text = "";

        }
        protected void GetControlDetails(int scheme, string folio)
        {
            DataSet ds = new DataSet();

            ds = onlineMforderBo.GetControlDetails(scheme, folio);
            DataTable dt = ds.Tables[0];
            if (dt.Rows.Count > -1)
            {

                foreach (DataRow dr in dt.Rows)
                {
                    if (!string.IsNullOrEmpty(dr["PSLV_LookupValue"].ToString()))
                    {
                        lblDividendType.Text = dr["PSLV_LookupValue"].ToString();
                    }
                    if (!string.IsNullOrEmpty(dr["MinAmt"].ToString()))
                    {
                        lblMintxt.Text = dr["MinAmt"].ToString();
                    }
                    if (!string.IsNullOrEmpty(dr["MultiAmt"].ToString()))
                    {
                        lblMulti.Text = dr["MultiAmt"].ToString();
                    }
                    if (!string.IsNullOrEmpty(dr["CutOffTime"].ToString()))
                    {
                        lbltime.Text = dr["CutOffTime"].ToString();
                    }

                    if (!string.IsNullOrEmpty(dr["divFrequency"].ToString()))
                    {
                        lbldftext.Text = dr["divFrequency"].ToString();
                    }
                }
                DataSet dsNav = commonLookupBo.GetLatestNav(int.Parse(ddlScheme.SelectedValue));
                lblNavDisplay.Text = dsNav.Tables[0].Rows[0][0].ToString();
            }

        }
        private void BindFolioNumber(int amcCode)
        {

            try
            {

                {
                    
                    ddlFolio.DataTextField = "New";
                    ddlFolio.DataValueField = "New";
                    ddlFolio.DataBind();
                }

            }
            catch (BaseApplicationException Ex)
            {
                throw (Ex);
            }
        }
        protected void SetControlDetails()
        {
            lbltime.Visible = true;
            lblDividendType.Visible = true;
            lblMulti.Visible = true;
            lblMintxt.Visible = true;
            lblDivType.Visible = true;

            if (lblDividendType.Text == "growth")
            {
                trDivfeq.Visible = false;
                trDivtype.Visible = false;
            }


        }

        protected void CategoryBind()
        {
            DataSet dsCategory = new DataSet();
            dsCategory = commonLookupBo.GetAllCategoryList();

            if (dsCategory.Tables[0].Rows.Count > 0)
            {
                ddlCategory.DataSource = dsCategory.Tables[0];
                ddlCategory.DataValueField = dsCategory.Tables[0].Columns["Category_Code"].ToString();
                ddlCategory.DataTextField = dsCategory.Tables[0].Columns["Category_Name"].ToString();
                ddlCategory.DataBind();
                ddlCategory.Items.Insert(0, new ListItem("All", "0"));
            }
        }

        protected void SchemeBind(int amccode, string category)
        {
            DataTable dtScheme = new DataTable();
            dtScheme = commonLookupBo.GetAmcSchemeList(amccode, category);
            if (dtScheme.Rows.Count > 0)
            {
                ddlScheme.DataSource = dtScheme;
                ddlScheme.DataValueField = dtScheme.Columns["PASP_SchemePlanCode"].ToString();
                ddlScheme.DataTextField = dtScheme.Columns["PASP_SchemePlanName"].ToString();
                ddlScheme.DataBind();
            }
        }
        protected void OnClick_Submit(object sender, EventArgs e)
        {
            List<int> OrderIds = new List<int>();
            onlinemforderVo.SchemePlanCode = Int32.Parse(ddlScheme.SelectedValue.ToString());
            if (!string.IsNullOrEmpty(txtAmt.Text.ToString()))
            {
                onlinemforderVo.Amount = double.Parse(txtAmt.Text.ToString());
            }
            else
                onlinemforderVo.Amount = 0.0;
            onlinemforderVo.DividendType = ddlDivType.SelectedValue;
            onlinemforderVo.TransactionType = "BUY";
            float amt;
            float minAmt;
            float multiAmt;
            DateTime Dt;

            if (string.IsNullOrEmpty(txtAmt.Text))
            {
                amt = 0;

            }
            else
            {
                amt = float.Parse(txtAmt.Text);
            }
            if (string.IsNullOrEmpty(lblMintxt.Text) && string.IsNullOrEmpty(lblMulti.Text) && string.IsNullOrEmpty(lbltime.Text))
            {
                minAmt = 0; multiAmt = 0; Dt = DateTime.MinValue;
            }
            else
            {

                minAmt = float.Parse(lblMintxt.Text);
                multiAmt = float.Parse(lblMulti.Text);
                Dt = DateTime.Parse(lbltime.Text);
            }
            int retVal = commonLookupBo.IsRuleCorrect(amt, minAmt, amt, multiAmt, Dt);
            if (retVal != 0)
            {
                ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "pageloadscript", "alert('Rules defined were incorrect');", true); return;
            }

            OrderIds = onlineMforderBo.CreateCustomerOnlineMFOrderDetails(onlinemforderVo, userVo.UserId, customerVo.CustomerId);
            ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "Message", "alert('Your order added successfully.');", true);
            OrderId = int.Parse(OrderIds[0].ToString());
        }
        protected void ddlDivType_OnSelectedIndexChanged(object sender, EventArgs e)
        {

        }



    }
}
