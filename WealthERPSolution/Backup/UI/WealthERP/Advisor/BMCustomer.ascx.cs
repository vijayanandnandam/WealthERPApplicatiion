﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using VoUser;
using BoUser;
using BoAdvisorProfiling;
using BoCustomerProfiling;
using System.Data;
using WealthERP.Customer;
using System.Collections.Specialized;
using Microsoft.ApplicationBlocks.ExceptionManagement;
using WealthERP.Base;
using System.Web.UI.HtmlControls;
using System.IO;
using iTextSharp;
using iTextSharp.text;
using iTextSharp.text.pdf;
using VoCustomerPortfolio;
using BoCustomerPortfolio;
using BoCommon;

namespace WealthERP.Advisor
{
    public partial class BMCustomer : System.Web.UI.UserControl
    {
        RMVo rmVo = new RMVo();
        CustomerVo customerVo = new CustomerVo();
        CustomerBo customerBo = new CustomerBo();
        AdvisorBranchBo advisorBranchBo = new AdvisorBranchBo();
        List<CustomerVo> customerList = null;
        AdvisorStaffBo advisorStaffBo = new AdvisorStaffBo();
        int customerId;
        int bmID;
        AdvisorVo adviserVo = new AdvisorVo();
        AdvisorBo advisorBo = new AdvisorBo();
        static string user = "";
        UserVo userVo = new UserVo();

        private SortDirection GridViewSortDirection
        {
            get
            {
                if (ViewState["sortDirection"] == null)
                    ViewState["sortDirection"] = SortDirection.Ascending;
                return (SortDirection)ViewState["sortDirection"];
            }
            set { ViewState["sortDirection"] = value; }
        }

        protected override void OnInit(EventArgs e)
        {
            try
            {
                ((Pager)mypager).ItemClicked += new Pager.ItemClickEventHandler(this.HandlePagerEvent);
                mypager.EnableViewState = true;
                base.OnInit(e);
            }
            catch (BaseApplicationException Ex)
            {
                throw Ex;
            }
            catch (Exception Ex)
            {
                BaseApplicationException exBase = new BaseApplicationException(Ex.Message, Ex);
                NameValueCollection FunctionInfo = new NameValueCollection();
                FunctionInfo.Add("Method", "ViewRM.ascx.cs:OnInit()");
                object[] objects = new object[0];

                FunctionInfo = exBase.AddObject(FunctionInfo, objects);
                exBase.AdditionalInformation = FunctionInfo;
                ExceptionManager.Publish(exBase);
                throw exBase;
            }
        }

        public void HandlePagerEvent(object sender, ItemClickEventArgs e)
        {
            try
            {
                GetPageCount();
                if ((Session["Customer"] == "Customer") && (hndAll.Value != "0"))
                {
                    this.BindGrid(mypager.CurrentPage, 0);
                }
                else
                {
                    this.BindCustomer(mypager.CurrentPage);
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
                FunctionInfo.Add("Method", "ViewRM.ascx.cs:HandlePagerEvent()");
                object[] objects = new object[2];
                objects[0] = mypager.CurrentPage;
                objects[1] = user;
                FunctionInfo = exBase.AddObject(FunctionInfo, objects);
                exBase.AdditionalInformation = FunctionInfo;
                ExceptionManager.Publish(exBase);
                throw exBase;
            }
        }

        private void BindCustomer(int CurrentPage)
        {
            Dictionary<string, string> genDictParent = new Dictionary<string, string>();
            Dictionary<string, string> genDictCity = new Dictionary<string, string>();
            Dictionary<string, string> genDictRM = new Dictionary<string, string>();

            string customer = "";
            AdvisorBo adviserBo = new AdvisorBo();
            List<CustomerVo> customerList = new List<CustomerVo>();
            RMVo customerRMVo = new RMVo();

            try
            {
                /*customer = Session["Customer"].ToString();
                if (customer.ToLower().Trim() == "find customer" || customer.ToLower().Trim() == "")
                    customer = "";*/

                rmVo = (RMVo)Session["rmVo"];

                if (hdnCurrentPage.Value.ToString() != "")
                {
                    mypager.CurrentPage = Int32.Parse(hdnCurrentPage.Value.ToString());
                    hdnCurrentPage.Value = "";
                }

                int Count = 0;

                //hdnNameFilter.Value = customer;

                customerList = advisorStaffBo.GetAllBMCustomerList(int.Parse(hndBranchID.Value.ToString()), int.Parse(hndBranchHeadId.Value.ToString()), int.Parse(hndAll.Value.ToString()), rmVo.RMId, mypager.CurrentPage, out Count, hdnSort.Value, hndPAN.Value, hdnNameFilter.Value, hdnAreaFilter.Value, hdnPincodeFilter.Value, hdnParentFilter.Value, hdnCityFilter.Value, hdnRMFilter.Value, hdnIsProspect.Value, out genDictParent, out genDictCity, out genDictRM);
                lblTotalRows.Text = hdnRecordCount.Value = Count.ToString();

                if (customerList == null)
                {
                    ErrorMessage.Visible = true;
                    //gvCustomers.Visible = false;
                    tblGv.Visible = false;
                    mypager.Visible = false;
                }
                else
                {
                    gvCustomers.Visible = true;
                    tblGv.Visible = true;
                    mypager.Visible = true;
                    DataTable dtRMCustomer = new DataTable();

                    dtRMCustomer.Columns.Add("CustomerId");
                    dtRMCustomer.Columns.Add("ADUL_ProcessId");
                    dtRMCustomer.Columns.Add("UserId");
                    dtRMCustomer.Columns.Add("Parent");
                    dtRMCustomer.Columns.Add("Cust_Comp_Name");
                    dtRMCustomer.Columns.Add("PAN Number");
                    dtRMCustomer.Columns.Add("Phone Number");
                    dtRMCustomer.Columns.Add("Email");
                    dtRMCustomer.Columns.Add("Address");
                    dtRMCustomer.Columns.Add("Area");
                    dtRMCustomer.Columns.Add("City");
                    dtRMCustomer.Columns.Add("RMAssigned");
                    dtRMCustomer.Columns.Add("IsProspect");


                    DataRow drRMCustomer;

                    for (int i = 0; i < customerList.Count; i++)
                    {
                        drRMCustomer = dtRMCustomer.NewRow();
                        customerVo = new CustomerVo();
                        customerVo = customerList[i];
                        drRMCustomer[0] = customerVo.CustomerId.ToString();
                        if (customerVo.ProcessId == 0)
                        {
                            drRMCustomer[1] = "N/A";
                        }
                        else
                            drRMCustomer[1] = customerVo.ProcessId.ToString();
                        drRMCustomer[2] = customerVo.UserId.ToString();

                        if (customerVo.ParentCustomer != null)
                        {
                            drRMCustomer[3] = customerVo.ParentCustomer.ToString();
                        }
                        drRMCustomer[4] = customerVo.FirstName.ToString() + " " + customerVo.MiddleName.ToString() + " " + customerVo.LastName.ToString();

                        if (customerVo.PANNum != null)
                            drRMCustomer[5] = customerVo.PANNum.ToString();
                        else
                            drRMCustomer[5] = "";

                        drRMCustomer[6] = customerVo.ResISDCode.ToString() + "-" + customerVo.ResSTDCode.ToString() + "-" + customerVo.ResPhoneNum.ToString();
                        drRMCustomer[7] = customerVo.Email.ToString();
                        if (customerVo.Adr1Line1 == null)
                            customerVo.Adr1Line1 = "";
                        if (customerVo.Adr1Line2 == null)
                            customerVo.Adr1Line2 = "";
                        if (customerVo.Adr1Line3 == null)
                            customerVo.Adr1Line3 = "";
                        if (customerVo.Adr1City == null)
                            customerVo.Adr1City = "";
                        if (customerVo.Adr1Line1.ToString() == "" && customerVo.Adr1Line2.ToString() == "")
                        {
                            drRMCustomer[8] = "-";
                        }
                        else if (customerVo.Adr1Line1.ToString() == "" && customerVo.Adr1Line2.ToString() != "")
                        {
                            drRMCustomer[8] = customerVo.Adr1Line2.ToString();
                        }
                        else if (customerVo.Adr1Line1.ToString() != "" && customerVo.Adr1Line2.ToString() == "")
                        {
                            drRMCustomer[8] = customerVo.Adr1Line1.ToString();
                        }
                        else
                            drRMCustomer[8] = customerVo.Adr1Line1.ToString() + "," + customerVo.Adr1Line2.ToString();
                        drRMCustomer[9] = customerVo.Adr1Line3.ToString();
                        drRMCustomer[10] = customerVo.Adr1City.ToString();
                        drRMCustomer[11] = customerVo.AssignedRM.ToString();

                        if (customerVo.IsProspect == 1)
                        {
                            drRMCustomer[12] = "Yes";
                        }
                        else
                        {
                            drRMCustomer[12] = "No";
                        }

                        dtRMCustomer.Rows.Add(drRMCustomer);
                    }

                    gvCustomers.DataSource = dtRMCustomer;
                    gvCustomers.DataBind();

                    if (genDictParent.Count > 0)
                    {
                        DropDownList ddlParent = GetParentDDL();
                        if (ddlParent != null)
                        {
                            ddlParent.DataSource = genDictParent;
                            ddlParent.DataTextField = "Value";
                            ddlParent.DataValueField = "Key";
                            ddlParent.DataBind();
                            ddlParent.Items.Insert(0, new System.Web.UI.WebControls.ListItem("Select Group", "Select Group"));
                        }
                        if (hdnParentFilter.Value != "")
                        {
                            ddlParent.SelectedValue = hdnParentFilter.Value.ToString();
                        }
                    }

                    if (genDictCity.Count > 0)
                    {
                        DropDownList ddlCity = GetCityDDL();
                        if (ddlCity != null)
                        {
                            ddlCity.DataSource = genDictCity;
                            ddlCity.DataTextField = "Key";
                            ddlCity.DataValueField = "Value";
                            ddlCity.DataBind();
                            ddlCity.Items.Insert(0, new System.Web.UI.WebControls.ListItem("Select City", "Select City"));
                        }
                        if (hdnCityFilter.Value != "")
                        {
                            ddlCity.SelectedValue = hdnCityFilter.Value.ToString();
                        }
                    }

                    if (genDictRM.Count > 0)
                    {
                        DropDownList ddlRM = GetRMDDL();
                        if (ddlRM != null)
                        {
                            ddlRM.DataSource = genDictRM;
                            ddlRM.DataTextField = "Value";
                            ddlRM.DataValueField = "Key";
                            ddlRM.DataBind();
                            ddlRM.Items.Insert(0, new System.Web.UI.WebControls.ListItem("Select RM", "Select RM"));
                        }
                        if (hdnRMFilter.Value != "")
                        {
                            ddlRM.SelectedValue = hdnRMFilter.Value.ToString();
                        }
                    }

                    TextBox txtName = GetCustNameTextBox();
                    if (txtName != null)
                    {
                        if (hdnNameFilter.Value != "")
                        {
                            txtName.Text = hdnNameFilter.Value.ToString();
                        }
                    }

                    TextBox txtPincode = GetPincodeTextBox();
                    if (txtPincode != null)
                    {
                        if (hdnPincodeFilter.Value != "")
                        {
                            txtPincode.Text = hdnPincodeFilter.Value.ToString();
                        }
                    }

                    TextBox txtArea = GetAreaTextBox();
                    if (txtArea != null)
                    {
                        if (hdnNameFilter.Value != "")
                        {
                            txtArea.Text = hdnAreaFilter.Value.ToString();
                        }
                    }

                    TextBox txtPAN = GetPANTextBox();
                    if (txtPAN != null)
                    {
                        if (hndPAN.Value != "")
                        {
                            txtPAN.Text = hndPAN.Value.ToString();
                        }
                    }

                    this.GetPageCount();
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
                FunctionInfo.Add("Method", "RMCustomer.ascx.cs:BindCustomer()");
                object[] objects = new object[3];
                objects[1] = rmVo;
                objects[2] = customerVo;

                FunctionInfo = exBase.AddObject(FunctionInfo, objects);
                exBase.AdditionalInformation = FunctionInfo;
                ExceptionManager.Publish(exBase);
                throw exBase;
            }
        }

        private void GetPageCount()
        {
            string upperlimit = null;
            int rowCount = 0;
            int ratio = 0;
            string lowerlimit = null;
            string PageRecords = null;
            try
            {
                if (hdnRecordCount.Value.ToString() != "")
                {
                    rowCount = Convert.ToInt32(hdnRecordCount.Value);
                }
                else
                {
                    rowCount = 0;
                }
                ratio = rowCount / 10;
                mypager.PageCount = rowCount % 10 == 0 ? ratio : ratio + 1;
                mypager.Set_Page(mypager.CurrentPage, mypager.PageCount);
                lowerlimit = (((mypager.CurrentPage - 1) * 10) + 1).ToString();
                upperlimit = (mypager.CurrentPage * 10).ToString();
                if (mypager.CurrentPage == mypager.PageCount)
                    upperlimit = hdnRecordCount.Value;
                PageRecords = String.Format("{0}- {1} of ", lowerlimit, upperlimit);
                lblCurrentPage.Text = PageRecords;

                hdnCurrentPage.Value = mypager.CurrentPage.ToString();

            }
            catch (BaseApplicationException Ex)
            {
                throw Ex;
            }
            catch (Exception Ex)
            {
                BaseApplicationException exBase = new BaseApplicationException(Ex.Message, Ex);
                NameValueCollection FunctionInfo = new NameValueCollection();

                FunctionInfo.Add("Method", "RMCustomer.ascx.cs:GetPageCount()");

                object[] objects = new object[5];
                objects[0] = upperlimit;
                objects[0] = rowCount;
                objects[0] = ratio;
                objects[0] = lowerlimit;
                objects[0] = PageRecords;
                FunctionInfo = exBase.AddObject(FunctionInfo, objects);
                exBase.AdditionalInformation = FunctionInfo;
                ExceptionManager.Publish(exBase);
                throw exBase;
            }

        }

        protected void Page_Load(object sender, EventArgs e)
        {
            SessionBo.CheckSession();
            userVo = (UserVo)Session["userVo"];
            rmVo = advisorStaffBo.GetAdvisorStaff(userVo.UserId);
            bmID = rmVo.RMId;
            ErrorMessage.Visible = false;
            try
            {
                if (!IsPostBack)
                {
                    BindBranchDropDown();
                    string session = Session["Current_Link"].ToString();
                    //if (Session["Current_Link"].ToString() == "BMLeftpane")
                    //{
                        hndAll.Value = "1";
                        hndBranchID.Value = "0";
                        hndBranchHeadId.Value = ddlBMBranchList.SelectedValue.ToString();
                        if (Session["Customer"] != null)
                        {
                            string sessionCust = Session["Customer"].ToString();
                            if (Session["Customer"].ToString() == "Customer")
                            {
                                this.BindGrid(mypager.CurrentPage, 0);
                            }
                            else
                            {
                                this.BindCustomer(mypager.CurrentPage);
                            }
                        }
                        else
                        {
                            this.BindCustomer(mypager.CurrentPage);
                        }
                    //}
                }
                //this.BindCustomer(mypager.CurrentPage);
            }
            catch (BaseApplicationException Ex)
            {
                throw Ex;
            }
            catch (Exception Ex)
            {
                BaseApplicationException exBase = new BaseApplicationException(Ex.Message, Ex);
                NameValueCollection FunctionInfo = new NameValueCollection();
                FunctionInfo.Add("Method", "RMCustomer.ascx.cs:Page_Load()");
                object[] objects = new object[1];
                objects[0] = user;
                FunctionInfo = exBase.AddObject(FunctionInfo, objects);
                exBase.AdditionalInformation = FunctionInfo;
                ExceptionManager.Publish(exBase);
                throw exBase;
            }
        }

        protected void BindGrid(int CurrentPage, int export)
        {
            Dictionary<string, string> genDictParent = new Dictionary<string, string>();
            Dictionary<string, string> genDictCity = new Dictionary<string, string>();
            Dictionary<string, string> genDictRM = new Dictionary<string, string>();

            RMVo customerRMVo = new RMVo();
            CustomerBo customerBo = new CustomerBo();
            try
            {
                rmVo = (RMVo)Session["rmVo"];

                if (export == 1)
                {
                    ErrorMessage.Visible = true;
                    trPager.Visible = false;
                    lblTotalRows.Visible = false;
                    gvCustomers.AllowPaging = false;
                    customerList = advisorStaffBo.GetBMCustomerList(rmVo.RMId);
                }
                else
                {
                    if (hdnCurrentPage.Value.ToString() != "")
                    {
                        mypager.CurrentPage = Int32.Parse(hdnCurrentPage.Value.ToString());
                        hdnCurrentPage.Value = "";
                    }

                    int Count;

                    customerList = advisorStaffBo.GetBMCustomerList(rmVo.RMId, mypager.CurrentPage, out Count, hdnSort.Value,hndPAN.Value, hdnNameFilter.Value, hdnAreaFilter.Value, hdnPincodeFilter.Value, hdnParentFilter.Value, hdnCityFilter.Value, hdnRMFilter.Value,hdnIsProspect.Value, out genDictParent, out genDictCity, out genDictRM);
                    lblTotalRows.Text = hdnRecordCount.Value = Count.ToString();
                }

                if (customerList == null)
                {
                    hdnRecordCount.Value = "0";
                    ErrorMessage.Visible = true;
                    trPager.Visible = false;
                    lblTotalRows.Visible = false;
                    tblGv.Visible = false;
                }
                else
                {
                    ErrorMessage.Visible = false;
                    trPager.Visible = true;
                    lblTotalRows.Visible = true;
                    lblCurrentPage.Visible = true;
                    tblGv.Visible = true;
                    DataTable dtRMCustomer = new DataTable();

                    //dtRMCustomer.Columns.Add("S.No");
                    dtRMCustomer.Columns.Add("CustomerId");
                    dtRMCustomer.Columns.Add("ADUL_ProcessId");
                    dtRMCustomer.Columns.Add("UserId");
                    dtRMCustomer.Columns.Add("Parent");
                    dtRMCustomer.Columns.Add("Cust_Comp_Name");
                    dtRMCustomer.Columns.Add("PAN Number");
                    dtRMCustomer.Columns.Add("Phone Number");
                    dtRMCustomer.Columns.Add("Email");
                    dtRMCustomer.Columns.Add("Address");
                    dtRMCustomer.Columns.Add("Area");
                    dtRMCustomer.Columns.Add("City");
                    dtRMCustomer.Columns.Add("RMAssigned");
                    dtRMCustomer.Columns.Add("IsProspect");

                    DataRow drRMCustomer;

                    for (int i = 0; i < customerList.Count; i++)
                    {
                        drRMCustomer = dtRMCustomer.NewRow();
                        customerVo = new CustomerVo();
                        customerVo = customerList[i];
                        drRMCustomer[0] = customerVo.CustomerId.ToString();
                        if (customerVo.ProcessId == 0)
                        {
                            drRMCustomer[1] = "N/A";
                        }
                        else
                            drRMCustomer[1] = customerVo.ProcessId.ToString();
                        drRMCustomer[2] = customerVo.UserId.ToString();

                        if (customerVo.ParentCustomer != null)
                        {
                            drRMCustomer[3] = customerVo.ParentCustomer.ToString();
                        }
                        drRMCustomer[4] = customerVo.FirstName.ToString() + " " + customerVo.MiddleName.ToString() + " " + customerVo.LastName.ToString();

                        if (customerVo.PANNum != null)
                            drRMCustomer[5] = customerVo.PANNum.ToString();
                        else
                            drRMCustomer[5] = "";

                        drRMCustomer[6] = customerVo.ResISDCode.ToString() + "-" + customerVo.ResSTDCode.ToString() + "-" + customerVo.ResPhoneNum.ToString();
                        drRMCustomer[7] = customerVo.Email.ToString();
                        if (customerVo.Adr1Line1 == null)
                            customerVo.Adr1Line1 = "";
                        if (customerVo.Adr1Line2 == null)
                            customerVo.Adr1Line2 = "";
                        if (customerVo.Adr1Line3 == null)
                            customerVo.Adr1Line3 = "";
                        if (customerVo.Adr1City == null)
                            customerVo.Adr1City = "";
                        if (customerVo.Adr1Line1.ToString() == "" && customerVo.Adr1Line2.ToString() == "")
                        {
                            drRMCustomer[8] = "-";
                        }
                        else if (customerVo.Adr1Line1.ToString() == "" && customerVo.Adr1Line2.ToString() != "")
                        {
                            drRMCustomer[8] = customerVo.Adr1Line2.ToString();
                        }
                        else if (customerVo.Adr1Line1.ToString() != "" && customerVo.Adr1Line2.ToString() == "")
                        {
                            drRMCustomer[8] = customerVo.Adr1Line1.ToString();
                        }
                        else
                            drRMCustomer[8] = customerVo.Adr1Line1.ToString() + "," + customerVo.Adr1Line2.ToString();
                        drRMCustomer[9] = customerVo.Adr1Line3.ToString();
                        drRMCustomer[10] = customerVo.Adr1City.ToString();
                        drRMCustomer[11] = customerVo.AssignedRM.ToString();
                        if (customerVo.IsProspect == 1)
                        {
                            drRMCustomer[12] = "Yes";
                        }
                        else
                        {
                            drRMCustomer[12] = "No";
                        }

                        dtRMCustomer.Rows.Add(drRMCustomer);
                    }

                    gvCustomers.DataSource = dtRMCustomer;
                    gvCustomers.DataBind();

                    if (genDictParent.Count > 0)
                    {
                        DropDownList ddlParent = GetParentDDL();
                        if (ddlParent != null)
                        {
                            ddlParent.DataSource = genDictParent;
                            ddlParent.DataTextField = "Key";
                            ddlParent.DataValueField = "Value";
                            ddlParent.DataBind();
                            ddlParent.Items.Insert(0, new System.Web.UI.WebControls.ListItem("Select Parent", "Select Parent"));
                        }
                        if (hdnParentFilter.Value != "")
                        {
                            ddlParent.SelectedValue = hdnParentFilter.Value.ToString();
                        }
                    }

                    if (genDictCity.Count > 0)
                    {
                        DropDownList ddlCity = GetCityDDL();
                        if (ddlCity != null)
                        {
                            ddlCity.DataSource = genDictCity;
                            ddlCity.DataTextField = "Key";
                            ddlCity.DataValueField = "Value";
                            ddlCity.DataBind();
                            ddlCity.Items.Insert(0, new System.Web.UI.WebControls.ListItem("Select City", "Select City"));
                        }
                        if (hdnCityFilter.Value != "")
                        {
                            ddlCity.SelectedValue = hdnCityFilter.Value.ToString();
                        }
                    }

                    if (genDictRM.Count > 0)
                    {
                        DropDownList ddlRM = GetRMDDL();
                        if (ddlRM != null)
                        {
                            ddlRM.DataSource = genDictRM;
                            ddlRM.DataTextField = "Value";
                            ddlRM.DataValueField = "Key";
                            ddlRM.DataBind();
                            ddlRM.Items.Insert(0, new System.Web.UI.WebControls.ListItem("Select RM", "Select RM"));
                        }
                        if (hdnRMFilter.Value != "")
                        {
                            ddlRM.SelectedValue = hdnRMFilter.Value.ToString();
                        }
                    }

                    TextBox txtName = GetCustNameTextBox();
                    if (txtName != null)
                    {
                        if (hdnNameFilter.Value != "")
                        {
                            txtName.Text = hdnNameFilter.Value.ToString();
                        }
                    }

                    TextBox txtPincode = GetPincodeTextBox();
                    if (txtPincode != null)
                    {
                        if (hdnPincodeFilter.Value != "")
                        {
                            txtPincode.Text = hdnPincodeFilter.Value.ToString();
                        }
                    }

                    TextBox txtArea = GetAreaTextBox();
                    if (txtArea != null)
                    {
                        if (hdnAreaFilter.Value != "")
                        {
                            txtArea.Text = hdnAreaFilter.Value.ToString();
                        }
                    }

                    TextBox txtPAN = GetPANTextBox();
                    if (txtPAN != null)
                    {
                        if (hndPAN.Value != "")
                        {
                            txtPAN.Text = hndPAN.Value.ToString();
                        }
                    }

                    this.GetPageCount();
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
                FunctionInfo.Add("Method", "BMCustomer.ascx.cs:BindGrid()");
                object[] objects = new object[4];
                objects[0] = user;
                objects[1] = rmVo;
                objects[2] = customerVo;
                objects[3] = customerList;
                FunctionInfo = exBase.AddObject(FunctionInfo, objects);
                exBase.AdditionalInformation = FunctionInfo;
                ExceptionManager.Publish(exBase);
                throw exBase;
            }
        }

        protected void gvCustomers_SelectedIndexChanged(object sender, EventArgs e)
        {
            try
            {
                customerId = int.Parse(gvCustomers.SelectedDataKey.Value.ToString());
                customerVo = customerBo.GetCustomer(customerId);
                Session["CustomerVo"] = customerVo;
                if (customerVo.Type == "Individual")
                {
                    Page.ClientScript.RegisterClientScriptBlock(this.GetType(), "leftpane", "loadcontrol('RMCustomerIndividualDashboard','none');", true);
                }
                if (customerVo.Type == "Non Individual")
                {
                    Page.ClientScript.RegisterClientScriptBlock(this.GetType(), "leftpane", "loadcontrol('RMCustomerNonIndividualDashboard','none');", true);
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
                FunctionInfo.Add("Method", "RMCustomer.ascx:gvCustomers_SelectedIndexChanged()");
                object[] objects = new object[2];
                objects[0] = customerId;
                objects[1] = customerVo;
                FunctionInfo = exBase.AddObject(FunctionInfo, objects);
                exBase.AdditionalInformation = FunctionInfo;
                ExceptionManager.Publish(exBase);
                throw exBase;

            }
        }

        protected void gvCustomers_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvCustomers.PageIndex = e.NewPageIndex;
            gvCustomers.DataBind();
        }

        protected void  ddlAction_OnSelectedIndexChange(object sender, EventArgs e)
        {
            DropDownList ddlAction = null;
            GridViewRow gvr = null;
            int selectedRow = 0;
            CustomerPortfolioVo customerPortfolioVo = new CustomerPortfolioVo();
            PortfolioBo portfolioBo = new PortfolioBo();
            int userId = 0;
            UserVo tempUser = null;
            UserBo userBo = new UserBo();
            bool isGrpHead = false;

            try
            {
                ddlAction = (DropDownList)sender;
                gvr = (GridViewRow)ddlAction.NamingContainer;
                selectedRow = gvr.RowIndex;
                customerId = int.Parse(gvCustomers.DataKeys[selectedRow].Values["CustomerId"].ToString());
                userId = int.Parse(gvCustomers.DataKeys[selectedRow].Values["UserId"].ToString());

                customerVo = customerBo.GetCustomer(customerId);
                Session["CustomerVo"] = customerVo;
                if (ddlAction.SelectedItem.Value.ToString() != "Profile")
                {

                    Page.ClientScript.RegisterClientScriptBlock(this.GetType(), "leftpane", "loadlinks('RMCustomerIndividualLeftPane','login');", true);
                }
                if (ddlAction.SelectedItem.Value.ToString() == "Profile")
                {
                    if (customerVo.IsProspect == 0)
                    {
                        Page.ClientScript.RegisterClientScriptBlock(this.GetType(), "RMCustomerIndi", "loadlinks('RMCustomerIndividualLeftPane','login');", true);
                    }
                    else
                    {
                        //Page.ClientScript.RegisterClientScriptBlock(this.GetType(), "RMCustomerIndi", "loadlinks('RMCustomerIndividualLeftPane','login');", true);
                    }

                }
                else
                {
                }
                if (ddlAction.SelectedItem.Value.ToString() == "Dashboard")
                {
                    Session["IsDashboard"] = "true";
                    isGrpHead = customerBo.CheckCustomerGroupHead(customerId);
                    if (customerVo.IsProspect == 0)
                    {
                        if (isGrpHead == true)
                            Page.ClientScript.RegisterClientScriptBlock(this.GetType(), "AdvisorRMCustGroupDashboard", "loadcontrol('AdvisorRMCustGroupDashboard','none');", true);
                        else
                            Page.ClientScript.RegisterClientScriptBlock(this.GetType(), "AdvisorRMCustIndiDashboard", "loadcontrol('AdvisorRMCustIndiDashboard','none');", true);
                    }
                    else
                    {
                        if (isGrpHead == true)
                        {
                            ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "AdvisorRMCustGroupDashboard", "loadcontrol('AdvisorRMCustGroupDashboard','login');", true);
                        }
                        else
                        {
                            customerId = customerBo.GetCustomerGroupHead(customerId);
                            customerVo = customerBo.GetCustomer(customerId);
                            Session["CustomerVo"] = customerVo;

                            ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "AdvisorRMCustGroupDashboard", "loadcontrol('AdvisorRMCustGroupDashboard','login');", true);
                        }

                    }
                }
                else if (ddlAction.SelectedItem.Value.ToString() == "Profile")
                {
                    if (customerVo.IsProspect == 0)
                    {
                        Session["IsDashboard"] = "false";
                        customerPortfolioVo = portfolioBo.GetCustomerDefaultPortfolio(customerId);
                        Session[SessionContents.PortfolioId] = customerPortfolioVo.PortfolioId;
                        Session["customerPortfolioVo"] = customerPortfolioVo;
                        Page.ClientScript.RegisterClientScriptBlock(this.GetType(), "RMCustomerIndividualDashboard", "loadcontrol('RMCustomerIndividualDashboard','none');", true);
                    }
                    else
                    {
                        //Session["IsDashboard"] = "FP";
                        //if (customerId != 0)
                        //{
                        //    Session[SessionContents.FPS_ProspectList_CustomerId] = customerId;
                        //}
                        /////Session[SessionContents.FPS_TreeView_Status] = "FinanceProfile";
                        //Session[SessionContents.FPS_CustomerPospect_ActionStatus] = "View";
                        ////Session[SessionContents.FPS_AddProspectListActionStatus] = "FPDashBoard";
                        //ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "pageloadscript", "loadcontrol('AddProspectList','login');", true);
                        isGrpHead = customerBo.CheckCustomerGroupHead(customerId);
                        if (isGrpHead == false)
                        {
                            customerId = customerBo.GetCustomerGroupHead(customerId);
                        }
                        else
                        {
                            customerId = customerVo.CustomerId;
                        }
                        Session[SessionContents.FPS_ProspectList_CustomerId] = customerId;
                        Session[SessionContents.FPS_AddProspectListActionStatus] = "View";
                        Session["BMCustomer"] = "BM";
                        ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "pageloadscript", "loadcontrol('AddProspectList','login');", true);
                        //Session[SessionContents.FPS_TreeView_Status] = "FinanceProfile";
                    }
                }
                else if (ddlAction.SelectedItem.Value.ToString() == "Portfolio")
                {
                    if (customerVo.IsProspect == 0)
                    {
                        customerPortfolioVo = portfolioBo.GetCustomerDefaultPortfolio(customerId);
                        Session[SessionContents.PortfolioId] = customerPortfolioVo.PortfolioId;
                        Page.ClientScript.RegisterClientScriptBlock(this.GetType(), "PortfolioDashboard", "loadcontrol('PortfolioDashboard','list');", true);
                    }
                    else
                    {
                        isGrpHead = customerBo.CheckCustomerGroupHead(customerId);
                        if (isGrpHead == false)
                        {
                            customerId = customerBo.GetCustomerGroupHead(customerId);
                        }
                        else
                        {
                            customerId = customerVo.CustomerId;
                        }
                        customerPortfolioVo = portfolioBo.GetCustomerDefaultPortfolio(customerId);
                        Session[SessionContents.PortfolioId] = customerPortfolioVo.PortfolioId;
                        customerVo = customerBo.GetCustomer(customerId);
                        Session["CustomerVo"] = customerVo;
                        ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "PortfolioDashboard", "loadcontrol('PortfolioDashboard','login');", true);

                    }
                }
                else if (ddlAction.SelectedItem.Value.ToString() == "Alerts")
                {
                    isGrpHead = customerBo.CheckCustomerGroupHead(customerId);
                    if (isGrpHead == false)
                    {
                        if (customerVo.IsProspect == 1)
                        {
                            customerId = customerBo.GetCustomerGroupHead(customerId);
                        }
                        else
                        {
                            customerId = customerVo.CustomerId;
                        }
                    }
                    else
                    {
                        customerId = customerVo.CustomerId;
                    }
                    customerPortfolioVo = portfolioBo.GetCustomerDefaultPortfolio(customerId);
                    Session[SessionContents.PortfolioId] = customerPortfolioVo.PortfolioId;
                    customerVo = customerBo.GetCustomer(customerId);
                    Session["CustomerVo"] = customerVo;
                    Page.ClientScript.RegisterClientScriptBlock(this.GetType(), "RMAlertDashBoard", "loadcontrol('RMAlertDashBoard','none');", true);
                }
                else if (ddlAction.SelectedItem.Value.ToString() == "FinancialPlanning")
                {
                    if (customerVo.IsProspect == 0)
                    {
                        Session[SessionContents.FPS_ProspectList_CustomerId] = customerId;
                    }
                    else
                    {
                        isGrpHead = customerBo.CheckCustomerGroupHead(customerId);
                        if (isGrpHead == false)
                        {
                            customerId = customerBo.GetCustomerGroupHead(customerId);
                        }
                        else
                        {
                            customerId = customerVo.CustomerId;
                        }
                        customerPortfolioVo = portfolioBo.GetCustomerDefaultPortfolio(customerId);
                        Session[SessionContents.PortfolioId] = customerPortfolioVo.PortfolioId;
                        customerVo = customerBo.GetCustomer(customerId);
                        Session["CustomerVo"] = customerVo;
                        Session[SessionContents.FPS_ProspectList_CustomerId] = customerId;
                    }
                    Session[SessionContents.FPS_TreeView_Status] = "FinanceProfile";
                    Session[SessionContents.FPS_CustomerPospect_ActionStatus] = "View";
                    ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "CustomerFPDashBoard", "loadcontrol('CustomerFPDashBoard','login');", true);
                }

                else if (ddlAction.SelectedItem.Value.ToString() == "QuickLinks")
                {

                    Session["IsDashboard"] = "CusDashBoardQuicklinks";
                    isGrpHead = customerBo.CheckCustomerGroupHead(customerId);
                    if (isGrpHead == false)
                    {
                        if (customerVo.IsProspect == 1)
                        {
                            customerId = customerBo.GetCustomerGroupHead(customerId);
                        }
                        else
                        {
                            customerId = customerVo.CustomerId;
                        }
                    }
                    else
                    {
                        customerId = customerVo.CustomerId;
                    }
                    customerPortfolioVo = portfolioBo.GetCustomerDefaultPortfolio(customerId);
                    Session[SessionContents.PortfolioId] = customerPortfolioVo.PortfolioId;
                    customerVo = customerBo.GetCustomer(customerId);
                    Session["CustomerVo"] = customerVo;
                    ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "CustomerDashBoardShortcut", "loadcontrol('CustomerDashBoardShortcut','login');", true);
                }
                //else if (ddlAction.SelectedItem.Value.ToString() == "User Details")
                //{
                //    tempUser = new UserVo();
                //    tempUser = userBo.GetUserDetails(userId);
                //    Session["CustomerUser"] = tempUser;
                //    Page.ClientScript.RegisterClientScriptBlock(this.GetType(), "GenerateLoginPassword", "loadcontrol('GenerateLoginPassword','?GenLoginPassword_UserId=" + userId + "');", true);

                //}

            }
            catch (Exception Ex)
            {
                BaseApplicationException exBase = new BaseApplicationException(Ex.Message, Ex);
                NameValueCollection FunctionInfo = new NameValueCollection();

                FunctionInfo.Add("Method", "RMCustomer.ascx:ddlAction_OnSelectedIndexChange()");


                object[] objects = new object[5];
                objects[0] = customerId;
                objects[1] = customerVo;
                objects[2] = ddlAction;
                objects[3] = gvr;
                objects[4] = selectedRow;



                FunctionInfo = exBase.AddObject(FunctionInfo, objects);
                exBase.AdditionalInformation = FunctionInfo;
                ExceptionManager.Publish(exBase);
                throw exBase;

            }

        }

        private void ExportGridView(string Filetype)
        {
            {
                HtmlForm frm = new HtmlForm();
                HtmlImage image = new HtmlImage();

                frm.Controls.Clear();
                frm.Attributes["runat"] = "server";
                if (Filetype.ToLower() == "print")
                {
                    //GridView_Print();
                }
                else if (Filetype.ToLower() == "excel")
                {
                    // gvCustomer.Columns.Remove(this.gvCustomer.Columns[0]);
                    string temp = userVo.FirstName + userVo.LastName + "Customer.xls";
                    string attachment = "attachment; filename=" + temp;
                    Response.ClearContent();
                    Response.AddHeader("content-disposition", attachment);
                    Response.ContentType = "application/ms-excel";
                    StringWriter sw = new StringWriter();
                    HtmlTextWriter htw = new HtmlTextWriter(sw);
                    Response.Output.Write("<table border=\"0\"><tbody><tr><td>");
                    Response.Output.Write("Advisor Name : ");
                    Response.Output.Write("</td>");
                    Response.Output.Write("<td>");
                    Response.Output.Write(userVo.FirstName + userVo.LastName);
                    Response.Output.Write("</td></tr>");
                    Response.Output.Write("<tr><td>");
                    Response.Output.Write("Report  : ");
                    Response.Output.Write("</td>");
                    Response.Output.Write("<td>");
                    Response.Output.Write("Customer List");
                    Response.Output.Write("</td></tr><tr><td>");
                    Response.Output.Write("Date : ");
                    Response.Output.Write("</td><td>");
                    System.DateTime tDate1 = System.DateTime.Now;
                    Response.Output.Write(tDate1);
                    Response.Output.Write("</td></tr>");
                    Response.Output.Write("</tbody></table>");

                    PrepareGridViewForExport(gvCustomers);

                    if (gvCustomers.HeaderRow != null)
                    {
                        PrepareControlForExport(gvCustomers.HeaderRow);
                        //tbl.Rows.Add(gvMFTransactions.HeaderRow);
                    }
                    foreach (GridViewRow row in gvCustomers.Rows)
                    {

                        PrepareControlForExport(row);

                        //tbl.Rows.Add(row);
                    }
                    if (gvCustomers.FooterRow != null)
                    {
                        PrepareControlForExport(gvCustomers.FooterRow);
                        // tbl.Rows.Add(gvMFTransactions.FooterRow);
                    }

                    gvCustomers.Parent.Controls.Add(frm);
                    frm.Controls.Add(gvCustomers);
                    frm.RenderControl(htw);
                    HttpContext.Current.Response.Write(sw.ToString());
                    HttpContext.Current.Response.End();
                }


                else if (Filetype.ToLower() == "pdf")
                {
                    string temp = userVo.FirstName + userVo.LastName + "_Customer List";

                    gvCustomers.AllowPaging = false;
                    gvCustomers.DataBind();
                    iTextSharp.text.pdf.PdfPTable table = new iTextSharp.text.pdf.PdfPTable(gvCustomers.Columns.Count - 1);

                    table.HeaderRows = 4;
                    iTextSharp.text.pdf.PdfPTable headerTable = new iTextSharp.text.pdf.PdfPTable(2);
                    Phrase phApplicationName = new Phrase("WWW.PrincipalConsulting.net", FontFactory.GetFont("Arial", 10, iTextSharp.text.Font.NORMAL));
                    PdfPCell clApplicationName = new PdfPCell(phApplicationName);
                    clApplicationName.Border = PdfPCell.NO_BORDER;
                    clApplicationName.HorizontalAlignment = Element.ALIGN_LEFT;


                    Phrase phDate = new Phrase(DateTime.Now.Date.ToString("dd/MM/yyyy"), FontFactory.GetFont("Arial", 10, iTextSharp.text.Font.NORMAL));
                    PdfPCell clDate = new PdfPCell(phDate);
                    clDate.HorizontalAlignment = Element.ALIGN_RIGHT;
                    clDate.Border = PdfPCell.NO_BORDER;


                    headerTable.AddCell(clApplicationName);
                    headerTable.AddCell(clDate);
                    headerTable.DefaultCell.Border = PdfPCell.NO_BORDER;

                    PdfPCell cellHeader = new PdfPCell(headerTable);
                    cellHeader.Border = PdfPCell.NO_BORDER;
                    cellHeader.Colspan = gvCustomers.Columns.Count - 1;
                    table.AddCell(cellHeader);

                    Phrase phHeader = new Phrase(temp, FontFactory.GetFont("Arial", 10, iTextSharp.text.Font.BOLD));
                    PdfPCell clHeader = new PdfPCell(phHeader);
                    clHeader.Colspan = gvCustomers.Columns.Count - 1;
                    clHeader.Border = PdfPCell.NO_BORDER;
                    clHeader.HorizontalAlignment = Element.ALIGN_CENTER;
                    table.AddCell(clHeader);


                    Phrase phSpace = new Phrase("\n");
                    PdfPCell clSpace = new PdfPCell(phSpace);
                    clSpace.Border = PdfPCell.NO_BORDER;
                    clSpace.Colspan = gvCustomers.Columns.Count - 1;
                    table.AddCell(clSpace);

                    GridViewRow HeaderRow = gvCustomers.HeaderRow;
                    if (HeaderRow != null)
                    {
                        string cellText = "";
                        for (int j = 1; j < gvCustomers.Columns.Count; j++)
                        {
                            if (j == 1)
                            {
                                cellText = "Parent";
                            }
                            else if (j == 2)
                            {
                                cellText = "Customer Name / Company Name";
                            }
                            else if (j == 7)
                            {
                                cellText = "Area";
                            }
                            else if (j == 9)
                            {
                                cellText = "Pincode";
                            }
                            else if (j == 10)
                            {
                                cellText = "Assigned RM";
                            }
                            else
                            {
                                cellText = Server.HtmlDecode(gvCustomers.HeaderRow.Cells[j].Text);
                            }

                            Phrase ph = new Phrase(cellText, FontFactory.GetFont("Arial", 7, iTextSharp.text.Font.BOLD));
                            table.AddCell(ph);
                        }

                    }

                    for (int i = 0; i < gvCustomers.Rows.Count; i++)
                    {
                        string cellText = "";
                        if (gvCustomers.Rows[i].RowType == DataControlRowType.DataRow)
                        {
                            for (int j = 1; j < gvCustomers.Columns.Count; j++)
                            {
                                if (j == 1)
                                {
                                    cellText = ((Label)gvCustomers.Rows[i].FindControl("lblParenteHeader")).Text;
                                }
                                else if (j == 2)
                                {
                                    cellText = ((Label)gvCustomers.Rows[i].FindControl("lblCustNameHeader")).Text;
                                }
                                else if (j == 7)
                                {
                                    cellText = ((Label)gvCustomers.Rows[i].FindControl("lblAreaHeader")).Text;
                                }
                                else if (j == 9)
                                {
                                    cellText = ((Label)gvCustomers.Rows[i].FindControl("lblPincodeHeader")).Text;
                                }
                                else if (j == 10)
                                {
                                    cellText = ((Label)gvCustomers.Rows[i].FindControl("lblAssignedRMHeader")).Text;
                                }
                                else
                                {
                                    cellText = Server.HtmlDecode(gvCustomers.Rows[i].Cells[j].Text);
                                }
                                Phrase ph = new Phrase(cellText, FontFactory.GetFont("Arial", 7, iTextSharp.text.Font.NORMAL));
                                iTextSharp.text.Cell cell = new iTextSharp.text.Cell(cellText);
                                table.AddCell(ph);

                            }

                        }

                    }



                    //Create the PDF Document

                    Document pdfDoc = new Document(PageSize.A5, 10f, 10f, 10f, 0f);
                    PdfWriter.GetInstance(pdfDoc, Response.OutputStream);
                    pdfDoc.Open();
                    pdfDoc.Add(table);
                    pdfDoc.Close();
                    Response.ContentType = "application/pdf";
                    temp = "filename=" + temp + ".pdf";
                    //    Response.AddHeader("content-disposition", "attachment;" + "filename=GridViewExport.pdf");
                    Response.AddHeader("content-disposition", "attachment;" + temp);
                    Response.Cache.SetCacheability(HttpCacheability.NoCache);
                    Response.Write(pdfDoc);
                    Response.End();



                }
                else if (Filetype.ToLower() == "word")
                {
                    gvCustomers.Columns.Remove(this.gvCustomers.Columns[0]);
                    string temp = userVo.FirstName + userVo.LastName + "_Customer.doc";
                    string attachment = "attachment; filename=" + temp;
                    Response.ClearContent();
                    Response.AddHeader("content-disposition", attachment);
                    Response.ContentType = "application/msword";
                    StringWriter sw = new StringWriter();
                    HtmlTextWriter htw = new HtmlTextWriter(sw);

                    Response.Output.Write("<table border=\"0\"><tbody><tr><td>");
                    Response.Output.Write("Advisor Name : ");
                    Response.Output.Write("</td>");
                    Response.Output.Write("<td>");
                    Response.Output.Write(userVo.FirstName + userVo.LastName);
                    Response.Output.Write("</td></tr>");
                    Response.Output.Write("<tr><td>");
                    Response.Output.Write("Report  : ");
                    Response.Output.Write("</td>");
                    Response.Output.Write("<td>");
                    Response.Output.Write("Customer List");
                    Response.Output.Write("</td></tr><tr><td>");
                    Response.Output.Write("Date : ");
                    Response.Output.Write("</td><td>");
                    System.DateTime tDate1 = System.DateTime.Now;
                    Response.Output.Write(tDate1);
                    Response.Output.Write("</td></tr>");
                    Response.Output.Write("</tbody></table>");

                    PrepareGridViewForExport(gvCustomers);


                    if (gvCustomers.HeaderRow != null)
                    {
                        PrepareControlForExport(gvCustomers.HeaderRow);
                    }
                    foreach (GridViewRow row in gvCustomers.Rows)
                    {
                        PrepareControlForExport(row);
                    }
                    if (gvCustomers.FooterRow != null)
                    {
                        PrepareControlForExport(gvCustomers.FooterRow);
                    }
                    gvCustomers.Parent.Controls.Add(frm);
                    frm.Controls.Add(gvCustomers);
                    frm.RenderControl(htw);
                    Response.Write(sw.ToString());
                    Response.End();

                }

            }

        }


        protected void gvCustomers_Sort(object sender, GridViewSortEventArgs e)
        {
            string sortExpression = null;
            try
            {
                sortExpression = e.SortExpression;
                ViewState["sortExpression"] = sortExpression;
                if (GridViewSortDirection == SortDirection.Ascending)
                {
                    GridViewSortDirection = SortDirection.Descending;
                    hdnSort.Value = sortExpression + " DESC";
                    this.BindGrid(1, 0);
                }
                else
                {
                    GridViewSortDirection = SortDirection.Ascending;
                    hdnSort.Value = sortExpression + " ASC";
                    this.BindGrid(1, 0);

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

                FunctionInfo.Add("Method", "RMCustomer.ascx.cs:gvCustomers_Sort()");

                object[] objects = new object[1];
                objects[0] = sortExpression;

                FunctionInfo = exBase.AddObject(FunctionInfo, objects);
                exBase.AdditionalInformation = FunctionInfo;
                ExceptionManager.Publish(exBase);
                throw exBase;
            }

        }

        //protected void btnExport_Click(object sender, EventArgs e)
        //{
        //    gvCustomers.Columns[0].Visible = false;
        //    if (rbtnMultiple.Checked)
        //    {
        //        BindGrid(mypager.CurrentPage, 1);
        //    }
        //    else
        //    {
        //        BindGrid(mypager.CurrentPage, 0);
        //    }
        //    PrepareGridViewForExport(gvCustomers);
        //    if (rbtnExcel.Checked)
        //    {
        //        ExportGridView("Excel");
        //    }
        //    else if (rbtnPDF.Checked)
        //    {

        //        ExportGridView("PDF");
        //    }
        //    else if (rbtnWord.Checked)
        //    {
        //        ExportGridView("Word");
        //    }
        //    BindGrid(mypager.CurrentPage, 0);
        //    gvCustomers.Columns[0].Visible = true;

        //}

        private void ExportGridTO(string Filetype)
        {
            HtmlForm frm = new HtmlForm();
            frm.Controls.Clear();
            frm.Attributes["runat"] = "server";
            if (Filetype == "excel")
            {
                // gvCustomer.Columns.Remove(this.gvCustomer.Columns[0]);
                string temp = userVo.FirstName + userVo.LastName + "_Customer.xls";
                string attachment = "attachment; filename=" + temp;
                Response.ClearContent();
                Response.AddHeader("content-disposition", attachment);
                Response.ContentType = "application/ms-excel";
                StringWriter sw = new StringWriter();
                HtmlTextWriter htw = new HtmlTextWriter(sw);
                Response.Output.Write("<table border=\"0\"><tbody><tr><td>");
                Response.Output.Write("RM Name : ");
                Response.Output.Write("</td>");
                Response.Output.Write("<td>");
                Response.Output.Write(userVo.FirstName + userVo.LastName);
                Response.Output.Write("</td></tr>");
                Response.Output.Write("<tr><td>");
                Response.Output.Write("Report  : ");
                Response.Output.Write("</td>");
                Response.Output.Write("<td>");
                Response.Output.Write("Customer List");
                Response.Output.Write("</td></tr><tr><td>");
                Response.Output.Write("Date : ");
                Response.Output.Write("</td><td>");
                System.DateTime tDate1 = System.DateTime.Now;
                Response.Output.Write(tDate1);
                Response.Output.Write("</td></tr>");
                Response.Output.Write("</tbody></table>");

                PrepareGridViewForExport(gvCustomers);

                if (gvCustomers.HeaderRow != null)
                {
                    PrepareControlForExport(gvCustomers.HeaderRow);
                }
                foreach (GridViewRow row in gvCustomers.Rows)
                {
                    PrepareControlForExport(row);
                }
                if (gvCustomers.FooterRow != null)
                {
                    PrepareControlForExport(gvCustomers.FooterRow);
                }
                gvCustomers.Parent.Controls.Add(frm);
                frm.Controls.Add(gvCustomers);
                frm.RenderControl(htw);
                Response.Write(sw.ToString());
                Response.End();

            }
            else if (Filetype == "PDF")
            {
                string temp = userVo.FirstName + userVo.LastName + "'s_Customer List";

                gvCustomers.AllowPaging = false;
                gvCustomers.DataBind();
                iTextSharp.text.pdf.PdfPTable table = new iTextSharp.text.pdf.PdfPTable(gvCustomers.Columns.Count - 1);

                table.HeaderRows = 4;
                iTextSharp.text.pdf.PdfPTable headerTable = new iTextSharp.text.pdf.PdfPTable(2);
                Phrase phApplicationName = new Phrase("WWW.PrincipalConsulting.net", FontFactory.GetFont("Arial", 10, iTextSharp.text.Font.NORMAL));
                PdfPCell clApplicationName = new PdfPCell(phApplicationName);
                clApplicationName.Border = PdfPCell.NO_BORDER;
                clApplicationName.HorizontalAlignment = Element.ALIGN_LEFT;


                Phrase phDate = new Phrase(DateTime.Now.Date.ToString("dd/MM/yyyy"), FontFactory.GetFont("Arial", 10, iTextSharp.text.Font.NORMAL));
                PdfPCell clDate = new PdfPCell(phDate);
                clDate.HorizontalAlignment = Element.ALIGN_RIGHT;
                clDate.Border = PdfPCell.NO_BORDER;


                headerTable.AddCell(clApplicationName);
                headerTable.AddCell(clDate);
                headerTable.DefaultCell.Border = PdfPCell.NO_BORDER;

                PdfPCell cellHeader = new PdfPCell(headerTable);
                cellHeader.Border = PdfPCell.NO_BORDER;
                cellHeader.Colspan = gvCustomers.Columns.Count - 1;
                table.AddCell(cellHeader);

                Phrase phHeader = new Phrase(temp, FontFactory.GetFont("Arial", 10, iTextSharp.text.Font.BOLD));
                PdfPCell clHeader = new PdfPCell(phHeader);
                clHeader.Colspan = gvCustomers.Columns.Count - 1;
                clHeader.Border = PdfPCell.NO_BORDER;
                clHeader.HorizontalAlignment = Element.ALIGN_CENTER;
                table.AddCell(clHeader);


                Phrase phSpace = new Phrase("\n");
                PdfPCell clSpace = new PdfPCell(phSpace);
                clSpace.Border = PdfPCell.NO_BORDER;
                clSpace.Colspan = gvCustomers.Columns.Count - 1;
                table.AddCell(clSpace);

                GridViewRow HeaderRow = gvCustomers.HeaderRow;
                if (HeaderRow != null)
                {
                    string cellText = "";
                    for (int j = 1; j < gvCustomers.Columns.Count; j++)
                    {
                        if (j == 1)
                        {
                            cellText = "Parent";
                        }
                        else if (j == 2)
                        {
                            cellText = "Customer Name / Company Name";
                        }
                        else if (j == 6) { cellText = "Area"; }
                        else if (j == 7) { cellText = "City"; }
                        else if (j == 8) { cellText = "Pincode"; }
                        else
                        {
                            cellText = Server.HtmlDecode(gvCustomers.HeaderRow.Cells[j].Text);
                        }

                        Phrase ph = new Phrase(cellText, FontFactory.GetFont("Arial", 7, iTextSharp.text.Font.BOLD));
                        table.AddCell(ph);
                    }

                }

                for (int i = 0; i < gvCustomers.Rows.Count; i++)
                {
                    string cellText = "";
                    if (gvCustomers.Rows[i].RowType == DataControlRowType.DataRow)
                    {
                        for (int j = 1; j < gvCustomers.Columns.Count; j++)
                        {
                            if (j == 1)
                            {
                                cellText = ((Label)gvCustomers.Rows[i].FindControl("lblParentHeader")).Text;
                            }
                            else if (j == 2) { cellText = ((Label)gvCustomers.Rows[i].FindControl("lblCustNameHeader")).Text; }
                            else if (j == 6) { cellText = ((Label)gvCustomers.Rows[i].FindControl("lblAreaHeader")).Text; }
                            else if (j == 7) { cellText = ((Label)gvCustomers.Rows[i].FindControl("lblCityHeader")).Text; }
                            else if (j == 8) { cellText = ((Label)gvCustomers.Rows[i].FindControl("lblPincodeHeader")).Text; }
                            else { cellText = Server.HtmlDecode(gvCustomers.Rows[i].Cells[j].Text); }

                            Phrase ph = new Phrase(cellText, FontFactory.GetFont("Arial", 7, iTextSharp.text.Font.NORMAL));
                            iTextSharp.text.Cell cell = new iTextSharp.text.Cell(cellText);
                            table.AddCell(ph);

                        }

                    }

                }

                //Create the PDF Document
                Document pdfDoc = new Document(PageSize.A4, 10f, 10f, 10f, 0f);
                PdfWriter.GetInstance(pdfDoc, Response.OutputStream);
                pdfDoc.Open();
                pdfDoc.Add(table);
                pdfDoc.Close();
                Response.ContentType = "application/pdf";
                temp = "filename=" + temp + ".pdf";
                Response.AddHeader("content-disposition", "attachment;" + temp);
                Response.Cache.SetCacheability(HttpCacheability.NoCache);
                Response.Write(pdfDoc);
                Response.End();

                BindGrid(mypager.CurrentPage, 0);


            }
            else if (Filetype == "Word")
            {
                gvCustomers.Columns.Remove(this.gvCustomers.Columns[0]);
                string temp = userVo.FirstName + userVo.LastName + "_Customer.doc";
                string attachment = "attachment; filename=" + temp;
                Response.ClearContent();
                Response.AddHeader("content-disposition", attachment);
                Response.ContentType = "application/msword";
                StringWriter sw = new StringWriter();
                HtmlTextWriter htw = new HtmlTextWriter(sw);

                Response.Output.Write("<table border=\"0\"><tbody><tr><td>");
                Response.Output.Write("RM Name : ");
                Response.Output.Write("</td>");
                Response.Output.Write("<td>");
                Response.Output.Write(userVo.FirstName + userVo.LastName);
                Response.Output.Write("</td></tr>");
                Response.Output.Write("<tr><td>");
                Response.Output.Write("Report  : ");
                Response.Output.Write("</td>");
                Response.Output.Write("<td>");
                Response.Output.Write("Customer List");
                Response.Output.Write("</td></tr><tr><td>");
                Response.Output.Write("Date : ");
                Response.Output.Write("</td><td>");
                System.DateTime tDate1 = System.DateTime.Now;
                Response.Output.Write(tDate1);
                Response.Output.Write("</td></tr>");
                Response.Output.Write("</tbody></table>");

                if (gvCustomers.HeaderRow != null)
                {
                    PrepareControlForExport(gvCustomers.HeaderRow);
                }
                foreach (GridViewRow row in gvCustomers.Rows)
                {
                    PrepareControlForExport(row);
                }
                if (gvCustomers.FooterRow != null)
                {
                    PrepareControlForExport(gvCustomers.FooterRow);
                }
                gvCustomers.Parent.Controls.Add(frm);
                frm.Controls.Add(gvCustomers);

                frm.RenderControl(htw);
                Response.Write(sw.ToString());
                Response.End();


            }
        }

        private void PrepareGridViewForExport(Control gv)
        {
            LinkButton lb = new LinkButton();
            Literal l = new Literal();
            string name = String.Empty;
            for (int i = 0; i < gv.Controls.Count; i++)
            {
                if (gv.Controls[i].GetType() == typeof(LinkButton))
                {
                    l.Text = (gv.Controls[i] as LinkButton).Text;
                    gv.Controls.Remove(gv.Controls[i]);
                }
                else if (gv.Controls[i].GetType() == typeof(DropDownList))
                {
                    l.Text = (gv.Controls[i] as DropDownList).SelectedValue.ToString();
                    gv.Controls.Remove(gv.Controls[i]);

                }
                else if (gv.Controls[i].GetType() == typeof(TextBox))
                {
                    l.Text = (gv.Controls[i] as TextBox).Text;
                    gv.Controls.Remove(gv.Controls[i]);

                }
                else if (gv.Controls[i].GetType() == typeof(CheckBox))
                {
                    l.Text = (gv.Controls[i] as CheckBox).Checked ? "True" : "False";
                    gv.Controls.Remove(gv.Controls[i]);
                }

                if (gv.Controls[i].HasControls())
                {
                    PrepareGridViewForExport(gv.Controls[i]);
                }

            }

        }

        private static void PrepareControlForExport(Control control)
        {
            for (int i = 0; i < control.Controls.Count; i++)
            {
                Control current = control.Controls[i];
                if (current is LinkButton)
                {
                    control.Controls.Remove(current);
                    control.Controls.AddAt(i, new LiteralControl((current as LinkButton).Text));
                }
                else if (current is ImageButton)
                {
                    control.Controls.Remove(current);
                    control.Controls.AddAt(i, new LiteralControl((current as ImageButton).AlternateText));
                }
                else if (current is HyperLink)
                {
                    control.Controls.Remove(current);
                    control.Controls.AddAt(i, new LiteralControl((current as HyperLink).Text));
                }
                else if (current is DropDownList)
                {
                    control.Controls.Remove(current);
                    control.Controls.AddAt(i, new LiteralControl((current as DropDownList).SelectedValue.ToString()));
                }
                else if (current is CheckBox)
                {
                    control.Controls.Remove(current);
                    control.Controls.AddAt(i, new LiteralControl((current as CheckBox).Checked ? "True" : "False"));
                }

                if (current.HasControls())
                {
                    PrepareControlForExport(current);
                }
            }
        }

        //protected void rbtnSingle_CheckedChanged(object sender, EventArgs e)
        //{

        //}

        //protected void rbtnMultiple_CheckedChanged(object sender, EventArgs e)
        //{
        //    BindGrid(mypager.CurrentPage, 1);
        //    Page.ClientScript.RegisterStartupScript(this.GetType(), "Message", "AferExportAll('ctrl_RMCustomer_btnPrintGrid');", true);
        //}

        //protected void btnPrint_Click(object sender, EventArgs e)
        //{
        //    gvCustomers.Columns[0].Visible = false;
        //    if (rbtnMultiple.Checked)
        //    {
        //        BindGrid(mypager.CurrentPage, 1);
        //    }
        //    else
        //    {
        //        BindGrid(mypager.CurrentPage, 0);
        //    }

        //    if (gvCustomers.HeaderRow != null)
        //    {
        //        PrepareGridViewForExport(gvCustomers.HeaderRow);
        //    }
        //    foreach (GridViewRow row in gvCustomers.Rows)
        //    {
        //        PrepareGridViewForExport(row);
        //    }
        //    if (gvCustomers.FooterRow != null)
        //    {
        //        PrepareGridViewForExport(gvCustomers.FooterRow);
        //    }
        //    Page.ClientScript.RegisterStartupScript(this.GetType(), "Message", "Print_Click('ctrl_RMCustomer_tbl','ctrl_RMCustomer_btnGridSearch');", true);

        //}

        protected void btnPrintGrid_Click(object sender, EventArgs e)
        {
            BindGrid(mypager.CurrentPage, 0);
            gvCustomers.Columns[0].Visible = true;
        }

        protected void ddlCity_SelectedIndexChanged(object sender, EventArgs e)
        {
            DropDownList ddlCity = GetCityDDL();

            if (ddlCity != null)
            {
                if (ddlCity.SelectedIndex != 0)
                {   // Bind the Grid with Only Selected Values
                    hdnCityFilter.Value = ddlCity.SelectedValue;
                }
                else
                {   // Bind the Grid with Only All Values
                    hdnCityFilter.Value = "";
                }
                //string sessionCust = Session["Customer"].ToString();
                //if (Session["Customer"].ToString() == "Customer")
                if ((Session["Customer"] != null) && (hndAll.Value != "0"))
                {
                    this.BindGrid(mypager.CurrentPage, 0);
                }
                else
                {
                    this.BindCustomer(mypager.CurrentPage);
                }
            }
        }

        protected void ddlIsProspect_SelectedIndexChanged(object sender, EventArgs e)
        {
            DropDownList ddlIsProspectFilter = (DropDownList)gvCustomers.HeaderRow.FindControl("ddlIsProspect");

            hdnIsProspect.Value = ddlIsProspectFilter.SelectedValue;

            this.BindGrid(mypager.CurrentPage, 0);
        }

        protected void SetValue(object sender, EventArgs e)
        {
            DropDownList ddl = (DropDownList)sender;
            if (hdnIsProspect.Value.ToString() == "")
            {
                ddl.SelectedValue = "2";
            }
            else
                ddl.SelectedValue = hdnIsProspect.Value.ToString();


        }

        protected void ddlParent_SelectedIndexChanged(object sender, EventArgs e)
        {
            DropDownList ddlParent = GetParentDDL();

            if (ddlParent != null)
            {
                if (ddlParent.SelectedIndex != 0)
                {   // Bind the Grid with Only Selected Values
                    hdnParentFilter.Value = ddlParent.SelectedValue;
                }
                else
                {   // Bind the Grid with Only All Values
                    hdnParentFilter.Value = "";
                }

                if (Session["Customer"] != null)
                {
                    if ((Session["Customer"].ToString() == "Customer") && (hndAll.Value != "0"))
                    {
                        this.BindGrid(mypager.CurrentPage, 0);
                    }
                    else
                    {
                        this.BindCustomer(mypager.CurrentPage);
                    }
                }
                else
                {
                    this.BindCustomer(mypager.CurrentPage);
                }
            }
        }

        protected void ddlAssignedRM_SelectedIndexChanged(object sender, EventArgs e)
        {
            DropDownList ddlRM = GetRMDDL();

            if (ddlRM != null)
            {
                if (ddlRM.SelectedIndex != 0)
                {   // Bind the Grid with Only Selected Values
                    //hdnRMFilter.Value = ddlRM.SelectedValue;
                    hdnRMFilter.Value = ddlRM.SelectedItem.Value;
                    //hdnCurrentPage.Value = "";
                }
                else
                {   // Bind the Grid with Only All Values
                    hdnRMFilter.Value = "";
                }

                if (Session["Customer"] != null)
                {
                    if ((Session["Customer"].ToString() == "Customer") && (hndAll.Value != "0"))
                    {
                        this.BindGrid(mypager.CurrentPage, 0);
                    }
                    else
                    {
                        this.BindCustomer(mypager.CurrentPage);
                    }
                }
                else
                {
                    this.BindCustomer(mypager.CurrentPage);
                }
            }
        }

        //protected void ddlAssignedRM_SelectedIndexChanged(object sender, EventArgs e)
        //{
        //    DropDownList ddlRM = GetRMDDL();

        //    if (ddlRM != null)
        //    {
        //        if (ddlRM.SelectedIndex != 0)
        //        {   // Bind the Grid with Only Selected Values
        //            hdnRMFilter.Value = ddlRM.SelectedValue;
        //            //hdnRMFilter.Value = ddlRM.SelectedItem.Text;
        //        }
        //        else
        //        {   // Bind the Grid with Only All Values
        //            hdnRMFilter.Value = "";
        //        }

        //        if (Session["Customer"].ToString() == "Customer")
        //        {
        //            this.BindGrid(mypager.CurrentPage, 0);
        //        }
        //        else
        //        {
        //            this.BindCustomer(mypager.CurrentPage);
        //        }
        //    }
        //}

        protected void btnPincodeSearch_Click(object sender, EventArgs e)
        {
            TextBox txtPincode = GetPincodeTextBox();
            hdnCurrentPage.Value = "1";
            if (txtPincode != null)
            {
                hdnPincodeFilter.Value = txtPincode.Text.Trim();
                if ((Session["Customer"].ToString() == "Customer") && (hndAll.Value != "0"))
                {
                    this.BindGrid(mypager.CurrentPage, 0);
                }
                else
                {
                    this.BindCustomer(mypager.CurrentPage);
                }
            }
        }

        protected void btnAreaSearch_Click(object sender, EventArgs e)
        {
            TextBox txtArea = GetAreaTextBox();
            hdnCurrentPage.Value = "1";
            if (txtArea != null)
            {
                hdnAreaFilter.Value = txtArea.Text.Trim();
                if ((Session["Customer"] == null || Session["Customer"].ToString() == "Customer") && (hndAll.Value != "0"))
                {
                    this.BindGrid(mypager.CurrentPage, 0);
                }
                else
                {
                    this.BindCustomer(mypager.CurrentPage);
                }
            }
        }

        protected void btnNameSearch_Click(object sender, EventArgs e)
        {
            TextBox txtName = GetCustNameTextBox();
            hdnCurrentPage.Value = "1";
            if (txtName != null)
            {
                hdnNameFilter.Value = txtName.Text.Trim();
                if ((Session["Customer"] == null || Session["Customer"].ToString() == "Customer") && (hndAll.Value != "0"))
                {
                    this.BindGrid(mypager.CurrentPage, 0);
                }
                else
                {
                    this.BindCustomer(mypager.CurrentPage);
                }
            }
        }

        protected void btnPANSearch_Click(object sender, EventArgs e)
        {
            TextBox txtPAN = GetPANTextBox();
            hdnCurrentPage.Value = "1";
            if (txtPAN != null)
            {
                hndPAN.Value = txtPAN.Text.Trim();
                if ((Session["Customer"] == null || Session["Customer"].ToString() == "Customer") && (hndAll.Value != "0"))
                {
                    this.BindGrid(mypager.CurrentPage, 0);
                }
                else
                {
                    this.BindCustomer(mypager.CurrentPage);
                }
            }
        }


        private DropDownList GetParentDDL()
        {
            DropDownList ddl = new DropDownList();
            if (gvCustomers.HeaderRow != null)
            {
                if ((DropDownList)gvCustomers.HeaderRow.FindControl("ddlParent") != null)
                {
                    ddl = (DropDownList)gvCustomers.HeaderRow.FindControl("ddlParent");
                }
            }
            else
                ddl = null;

            return ddl;
        }

        private DropDownList GetCityDDL()
        {
            DropDownList ddl = new DropDownList();
            if (gvCustomers.HeaderRow != null)
            {
                if ((DropDownList)gvCustomers.HeaderRow.FindControl("ddlCity") != null)
                {
                    ddl = (DropDownList)gvCustomers.HeaderRow.FindControl("ddlCity");
                }
            }
            else
                ddl = null;

            return ddl;
        }

        private DropDownList GetRMDDL()
        {
            DropDownList ddl = new DropDownList();
            if (gvCustomers.HeaderRow != null)
            {
                if ((DropDownList)gvCustomers.HeaderRow.FindControl("ddlAssignedRM") != null)
                {
                    ddl = (DropDownList)gvCustomers.HeaderRow.FindControl("ddlAssignedRM");
                }
            }
            else
                ddl = null;

            return ddl;
        }

        private TextBox GetCustNameTextBox()
        {
            TextBox txt = new TextBox();
            if (gvCustomers.HeaderRow != null)
            {
                if ((TextBox)gvCustomers.HeaderRow.FindControl("txtCustNameSearch") != null)
                {
                    txt = (TextBox)gvCustomers.HeaderRow.FindControl("txtCustNameSearch");
                }
            }
            else
                txt = null;

            return txt;
        }

        private TextBox GetPANTextBox()
        {
            TextBox txt = new TextBox();
            if (gvCustomers.HeaderRow != null)
            {
                if ((TextBox)gvCustomers.HeaderRow.FindControl("txtPAN") != null)
                {
                    txt = (TextBox)gvCustomers.HeaderRow.FindControl("txtPAN");
                }
            }
            else
                txt = null;

            return txt;
        }

        private TextBox GetAreaTextBox()
        {
            TextBox txt = new TextBox();
            if (gvCustomers.HeaderRow != null)
            {
                if ((TextBox)gvCustomers.HeaderRow.FindControl("txtAreaSearch") != null)
                {
                    txt = (TextBox)gvCustomers.HeaderRow.FindControl("txtAreaSearch");
                }
            }
            else
                txt = null;

            return txt;
        }

        private TextBox GetPincodeTextBox()
        {
            TextBox txt = new TextBox();
            if (gvCustomers.HeaderRow != null)
            {
                if ((TextBox)gvCustomers.HeaderRow.FindControl("txtPincodeSearch") != null)
                {
                    txt = (TextBox)gvCustomers.HeaderRow.FindControl("txtPincodeSearch");
                }
            }
            else
                txt = null;

            return txt;
        }

        protected void ddlBMBranchList_SelectedIndexChanged(object sender, EventArgs e)
        {
            hdnPincodeFilter.Value = "";
            hdnAreaFilter.Value = "";
            hdnNameFilter.Value = "";
            hdnCityFilter.Value = "";
            hdnParentFilter.Value = "";
            hdnRMFilter.Value = "";
            hndPAN.Value = "";

            if (ddlBMBranchList.SelectedIndex == 0)
            {
                hndAll.Value = "1";
                hndBranchID.Value = "0";
                hndBranchHeadId.Value = ddlBMBranchList.SelectedValue;
                this.BindCustomer(mypager.CurrentPage);
            }
            else
            {
                hndAll.Value = "0";
                hndBranchID.Value = ddlBMBranchList.SelectedValue;
                hndBranchHeadId.Value = "0";
                this.BindCustomer(mypager.CurrentPage);
            }
        }

        protected void imgBtnExport_Click(object sender, ImageClickEventArgs e)
        {
            ModalPopupExtender1.TargetControlID = "imgBtnExport";
            ModalPopupExtender1.Show();
        }

        protected void btnExportExcel_Click2(object sender, EventArgs e)
        {
            gvCustomers.Columns[0].Visible = false;
            gvCustomers.HeaderRow.Visible = true;

            if (hdnDownloadPageType.Value.ToString() == "single")
            {
                this.BindCustomer(mypager.CurrentPage);
            }
            else
            {
                BindGrid(mypager.CurrentPage, 1);
                Page.ClientScript.RegisterStartupScript(this.GetType(), "Message", "AferExportAll('ctrl_AdviserCustomer_btnPrintGrid');", true);
            }

            ExportGridTO(hdnDownloadFormat.Value.ToString());
            
            this.BindCustomer(mypager.CurrentPage);
            gvCustomers.Columns[0].Visible = true;

        }

        protected void imageExcel_Click(object sender, ImageClickEventArgs e)
        {
            ModalPopupExtender1.TargetControlID = "imageExcel";
            ModalPopupExtender1.Show();

        }

        /* For Binding the Branch Dropdowns */

        private void BindBranchDropDown()
        {

            try
            {

                DataSet ds = advisorBranchBo.GetBranchsRMForBMDp(0, bmID, 0);
                if (ds != null)
                {
                    ddlBMBranchList.DataSource = ds.Tables[1]; ;
                    ddlBMBranchList.DataValueField = ds.Tables[1].Columns["AB_BranchId"].ToString();
                    ddlBMBranchList.DataTextField = ds.Tables[1].Columns["AB_BranchName"].ToString();
                    ddlBMBranchList.DataBind();
                }
                ddlBMBranchList.Items.Insert(0, new System.Web.UI.WebControls.ListItem("All", bmID.ToString()));
            }
            catch (BaseApplicationException Ex)
            {
                throw Ex;
            }
            catch (Exception Ex)
            {
                BaseApplicationException exBase = new BaseApplicationException(Ex.Message, Ex);
                NameValueCollection FunctionInfo = new NameValueCollection();

                FunctionInfo.Add("Method", "ViewRM.ascx:BindBranchDropDown()");

                object[] objects = new object[4];

                FunctionInfo = exBase.AddObject(FunctionInfo, objects);
                exBase.AdditionalInformation = FunctionInfo;
                ExceptionManager.Publish(exBase);
                throw exBase;
            }
        }

        /* End For Binding the Branch Dropdowns */
    }
}
