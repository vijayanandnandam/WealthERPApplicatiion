﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using VoUser;
using VoCustomerProfiling;
using BoUser;
using BoCustomerProfiling;
using System.Collections.Specialized;
using Microsoft.ApplicationBlocks.ExceptionManagement;
using System.Data;
using WealthERP.Base;
using BoCommon;
using System.Configuration;
using System.Text;
namespace WealthERP.Advisor
{
    public partial class RMCustomerDashboard : System.Web.UI.UserControl
    {
        UserVo userVo = new UserVo();
        CustomerVo customerVo = new CustomerVo();
        RMVo rmVo = new RMVo();
        CustomerBo customerBo = new CustomerBo();
        CustomerFamilyBo customerFamilyBo = new CustomerFamilyBo();
        CustomerBankAccountVo customerBankAccountVo = new CustomerBankAccountVo();
        CustomerBankAccountBo customerBankAccountBo = new CustomerBankAccountBo();
        List<CustomerBankAccountVo> customerBankAccountList = new List<CustomerBankAccountVo>();
        string path = "";
        List<CustomerFamilyVo> customerFamilyList = null;
        DataSet ds = new DataSet();
        DataSet dsBankDetails = new DataSet();
        int customerId;
       

        protected void Page_Load(object sender, EventArgs e)
        {
            SessionBo.CheckSession();
            userVo = (UserVo)Session[SessionContents.UserVo];
            path = Server.MapPath(ConfigurationManager.AppSettings["xmllookuppath"].ToString());
            try
            {
              //  customerFamilyList = new List<CustomerFamilyVo>();

                customerVo = (CustomerVo)Session["CustomerVo"];
                rmVo = (RMVo)Session["RmVo"];
                customerId = customerVo.CustomerId;
                StringBuilder sbAddress = new StringBuilder();
                
                lblName.Text = customerVo.FirstName.ToString() + " " + customerVo.MiddleName.ToString() + " " + customerVo.LastName.ToString();
                lblPhone.Text = customerVo.ResISDCode.ToString() + " - " + customerVo.ResSTDCode.ToString() + " - " + customerVo.ResPhoneNum.ToString();
                if (!string.IsNullOrEmpty(customerVo.Email))
                {
                    lblEmail.Text = customerVo.Email.ToString();
                }
                else
                {
                    lblEmail.Text = "";
                }
                sbAddress.Append(customerVo.Adr1Line1);
                sbAddress.Append("<br />");
                sbAddress.Append(customerVo.Adr1Line2);
                sbAddress.Append("<br />");
                sbAddress.Append(customerVo.Adr1Line3);
                sbAddress.Append("<br />");
                sbAddress.Append(customerVo.Adr1PinCode);
                sbAddress.Append("<br />");

                if (customerVo.Adr1State != "")
                {
                    sbAddress.Append(XMLBo.GetStateName(path, customerVo.Adr1State));
                    sbAddress.Append("<br />");
                }
                
                sbAddress.Append(customerVo.Adr1City);
                sbAddress.Append("<br />");
                sbAddress.Append(customerVo.Adr1Country);

                lblAddress.Text = sbAddress.ToString();

                Session["RmVo"] = rmVo;
                // Session["CustomerVo"] = customerVo;
                Session["Check"] = "Dashboard";

                //Binding the Customer Family Grid
               
                

                //Call the function to bind the Bank Details
                lblBankDetailsMsg.Visible = false;
                BindBankDetails();
                BindFamilyDematDetails();
                BindDematDetails();
            }
            catch (BaseApplicationException Ex)
            {
                throw Ex;
            }
            catch (Exception Ex)
            {
                BaseApplicationException exBase = new BaseApplicationException(Ex.Message, Ex);
                NameValueCollection FunctionInfo = new NameValueCollection();
                FunctionInfo.Add("Method", "RMCustomerDashboard.ascx:Page_Load()");
                object[] objects = new object[4];
                objects[0] = customerFamilyList;
                objects[1] = rmVo;
                objects[2] = customerVo;
                objects[3] = userVo;
                FunctionInfo = exBase.AddObject(FunctionInfo, objects);
                exBase.AdditionalInformation = FunctionInfo;
                ExceptionManager.Publish(exBase);
                throw exBase;
            }
        }
        protected void BindFamilyDematDetails()
        {
            DataSet dsDematDetails = new DataSet();
            DataTable dtDematDetails = new DataTable();
            dsDematDetails = customerFamilyBo.GetCustomerDematDetails(customerId);
            dtDematDetails = dsDematDetails.Tables[0];
            if (dsDematDetails == null)
            {
                tdFamilyDetailsHeader.Visible = false;
                tdFamilyDetailsGrid.Visible = false;
            }
            else
            {


                if (dtDematDetails.Rows.Count > 0)
                {
                    gvFamilyMembers.DataSource = dtDematDetails;
                    gvFamilyMembers.DataBind();
                    gvFamilyMembers.Visible = true;
                }
                else
                {
                    gvFamilyMembers.DataSource = null;
                    gvFamilyMembers.DataBind();
                }
            }
        }
        protected void BindDematDetails()
        {
            DataSet dsDematDetails = new DataSet();
            DataTable dtDematDetails = new DataTable();
            dsDematDetails = customerFamilyBo.GetCustomerDematDetails(customerId);
            dtDematDetails = dsDematDetails.Tables[1];
            if (dsDematDetails == null)
            {
                tdDematDetailsHeader.Visible = false;
                tdDematDetailsGrid.Visible = false;
            }
            else
            {


                if (dtDematDetails.Rows.Count > 0)
                {
                    gvDematDetails.DataSource = dtDematDetails;
                    gvDematDetails.DataBind();
                    gvDematDetails.Visible = true;
                }
                else
                {
                    gvDematDetails.DataSource = null;
                    gvDematDetails.DataBind();
                }
            }
        }
        protected void gvFamilyMembers_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvFamilyMembers.PageIndex = e.NewPageIndex;
            gvFamilyMembers.DataBind();
        }

        /// <summary>
        /// Function to bind the Details to the Bank Grid
        /// </summary>
        public void BindBankDetails()
        {
            try
            {
                customerBankAccountList = customerBankAccountBo.GetCustomerBankAccounts(customerId);
                if (customerBankAccountList.Count != 0)
                {
                    DataTable dtCustomerBankAccounts = new DataTable();
                    //dtCustomerBankAccounts.Columns.Add("CustBankAccId");
                    dtCustomerBankAccounts.Columns.Add("Bank Name");
                    //dtCustomerBankAccounts.Columns.Add("Branch Name");
                    dtCustomerBankAccounts.Columns.Add("Account Type");
                    //dtCustomerBankAccounts.Columns.Add("Mode Of Operation");
                    dtCustomerBankAccounts.Columns.Add("Account Number");


                    DataRow drCustomerBankAccount;
                    for (int i = 0; i < customerBankAccountList.Count; i++)
                    {
                        drCustomerBankAccount = dtCustomerBankAccounts.NewRow();
                        customerBankAccountVo = new CustomerBankAccountVo();
                        customerBankAccountVo = customerBankAccountList[i];
                        //drCustomerBankAccount[0] = customerBankAccountVo.CustBankAccId.ToString();
                        drCustomerBankAccount[0] = customerBankAccountVo.WERPBMBankName;
                        //drCustomerBankAccount[2] = customerBankAccountVo.BranchName.ToString();
                        drCustomerBankAccount[1] = customerBankAccountVo.AccountType;
                        //drCustomerBankAccount[4] = customerBankAccountVo.ModeOfOperation.ToString();
                        drCustomerBankAccount[2] = customerBankAccountVo.BankAccountNum;

                        dtCustomerBankAccounts.Rows.Add(drCustomerBankAccount);
                    }

                    gvBankDetails.DataSource = dtCustomerBankAccounts;
                    gvBankDetails.DataBind();
                    gvBankDetails.Visible = true;
                }
                else
                {
                    gvBankDetails.Visible = false;
                    lblBankDetailsMsg.Visible = true;
                    lnkMoreBankDetails.Visible = false;
                    gvBankDetails.DataSource = null;
                    gvBankDetails.DataBind();
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

                FunctionInfo.Add("Method", "RMCustIndividualDashboard.ascx:BindBankDetails()");

                object[] objects = new object[0];

                FunctionInfo = exBase.AddObject(FunctionInfo, objects);
                exBase.AdditionalInformation = FunctionInfo;
                ExceptionManager.Publish(exBase);
                throw exBase;

            }
        }
         
        /// <summary>
        /// Goes to the Bank Details Dashboard when we click on the Member name on the Bank Details Grid
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void lnkMoreBankDetails_Click(object sender, EventArgs e)
        {
            customerVo = customerBo.GetCustomer(customerId);
            Session["CustomerVo"] = customerVo;
            Session["IsDashboard"] = "BankDetails";
            Page.ClientScript.RegisterClientScriptBlock(this.GetType(), "leftpane", "loadcontrol('ViewBankDetails','none');", true);
            ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "CustomerIndLeftPane", "loadlinks('RMCustomerIndividualLeftPane','login');", true);
        }

        /// <summary>
        /// Goes to the Customer Dashboard when we click on the Member name on the Customer Family Grid
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void lnkCustomerNameFamilyGrid_Click(object sender, EventArgs e)
        {
            GridViewRow gvRow = ((GridViewRow)(((LinkButton)sender).Parent.Parent));
            int rowIndex = gvRow.RowIndex;
            DataKey dk = gvFamilyMembers.DataKeys[rowIndex];
            int customerId = Convert.ToInt32(dk.Value);

            customerVo = customerBo.GetCustomer(customerId);
            Session["CustomerVo"] = customerVo;
            Session["IsDashboard"] = "CustDashboard";

            if(Session["S_CurrentUserRole"] == "Customer")
                Page.ClientScript.RegisterClientScriptBlock(this.GetType(), "leftpane", "loadcontrolCustomer('AdvisorRMCustIndiDashboard','none');", true);
            else
                Page.ClientScript.RegisterClientScriptBlock(this.GetType(), "leftpane", "loadcontrol('AdvisorRMCustIndiDashboard','none');", true);

        }
    }
}