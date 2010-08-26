﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using VoEmailSMS;
using VoUser;
using BoAdvisorProfiling;
using BoAlerts;
using BoCommon;

namespace WealthERP.Advisor
{
    public partial class AdviserCustomerSMSAlerts : System.Web.UI.UserControl
    {
        DataSet dsAdviserCustomerAlerts;
        protected void Page_Load(object sender, EventArgs e)
        {
            setAdviserSMSLicenseInfo();
            GetAdviserCustomerAlerts();
        }
        public void GetAdviserCustomerAlerts()
        {
            int adviserId = 0;

            hdnCustomerIdWithoutMobileNumber.Value = "";
            hdnCustomerNameWithoutMobileNumber.Value = "";
            DataRow drAdviserCustomerAlert = null;
            if (Session["advisorVo"] != null)
                adviserId = ((AdvisorVo)Session["advisorVo"]).advisorId;
            AlertsBo alertsBo = new AlertsBo();
            dsAdviserCustomerAlerts = alertsBo.GetAdviserCustomerSMSAlerts(adviserId);
            if (dsAdviserCustomerAlerts != null)
            {
                DataTable dtAdviserCustomerAlerts = new DataTable();
                dtAdviserCustomerAlerts.Columns.Add("CustomerId");
                dtAdviserCustomerAlerts.Columns.Add("AlertId");
                dtAdviserCustomerAlerts.Columns.Add("CustomerName");
                dtAdviserCustomerAlerts.Columns.Add("Name");
                dtAdviserCustomerAlerts.Columns.Add("AlertMessage");
                dtAdviserCustomerAlerts.Columns.Add("TimesSMSSent");
                dtAdviserCustomerAlerts.Columns.Add("LastSMSDate");
                dtAdviserCustomerAlerts.Columns.Add("AlertDate");
                dtAdviserCustomerAlerts.Columns.Add("Mobile");
                for (int i = 0; i < dsAdviserCustomerAlerts.Tables[0].Rows.Count; i++)
                {
                    drAdviserCustomerAlert = dtAdviserCustomerAlerts.NewRow();
                    if (dsAdviserCustomerAlerts.Tables[0].Rows[i]["CustomerId"] != null && dsAdviserCustomerAlerts.Tables[0].Rows[i]["AlertId"]!=null)
                    {
                        drAdviserCustomerAlert["CustomerId"] = dsAdviserCustomerAlerts.Tables[0].Rows[i]["CustomerId"].ToString();
                        drAdviserCustomerAlert["AlertId"] = dsAdviserCustomerAlerts.Tables[0].Rows[i]["AlertId"].ToString();
                        if (dsAdviserCustomerAlerts.Tables[0].Rows[i]["CustomerName"] != null)
                        {
                            drAdviserCustomerAlert["CustomerName"] = dsAdviserCustomerAlerts.Tables[0].Rows[i]["CustomerName"].ToString();
                        }
                        else
                        {
                            drAdviserCustomerAlert["CustomerName"] = "";
                        }
                        if (dsAdviserCustomerAlerts.Tables[1].Rows[i]["Name"].ToString() != null)
                        {
                            drAdviserCustomerAlert["Name"] = dsAdviserCustomerAlerts.Tables[1].Rows[i]["Name"].ToString();
                        }
                        else
                        {
                            drAdviserCustomerAlert["Name"] = "";
                        }
                        if (dsAdviserCustomerAlerts.Tables[0].Rows[i]["AlertMessage"].ToString() != null)
                        {
                            drAdviserCustomerAlert["AlertMessage"] = dsAdviserCustomerAlerts.Tables[0].Rows[i]["AlertMessage"].ToString();
                        }
                        else
                        {
                            drAdviserCustomerAlert["AlertMessage"] = "";
                        }
                        if (dsAdviserCustomerAlerts.Tables[1].Rows[i]["TimesSMSSent"].ToString() != null && dsAdviserCustomerAlerts.Tables[1].Rows[i]["TimesSMSSent"].ToString() != "")
                        {
                            drAdviserCustomerAlert["TimesSMSSent"] = dsAdviserCustomerAlerts.Tables[1].Rows[i]["TimesSMSSent"].ToString();
                        }
                        else
                        {
                            drAdviserCustomerAlert["TimesSMSSent"] = "";
                        }

                        if (dsAdviserCustomerAlerts.Tables[1].Rows[i]["LastSMSDate"].ToString() != null && dsAdviserCustomerAlerts.Tables[1].Rows[i]["LastSMSDate"].ToString() !="")
                        {
                            DateTime lastSMSDate=DateTime.Parse(dsAdviserCustomerAlerts.Tables[1].Rows[i]["LastSMSDate"].ToString());
                            drAdviserCustomerAlert["LastSMSDate"] = lastSMSDate.ToShortDateString();
                        }
                        else
                        {
                            drAdviserCustomerAlert["LastSMSDate"] = "";
                        }
                        if (dsAdviserCustomerAlerts.Tables[0].Rows[i]["AlertDate"].ToString() != null && dsAdviserCustomerAlerts.Tables[0].Rows[i]["AlertDate"].ToString() != "")
                        {
                            DateTime alertDate = DateTime.Parse(dsAdviserCustomerAlerts.Tables[0].Rows[i]["AlertDate"].ToString());
                            drAdviserCustomerAlert["AlertDate"] = alertDate.ToShortDateString();
                        }
                        else
                        {
                            drAdviserCustomerAlert["AlertDate"] = "";
                        }
                        drAdviserCustomerAlert["Mobile"] = dsAdviserCustomerAlerts.Tables[0].Rows[i]["Mobile"].ToString();
                        if (Int64.Parse(dsAdviserCustomerAlerts.Tables[0].Rows[i]["Mobile"].ToString()) != 0)
                        {
                            hdnCustomerIdWithoutMobileNumber.Value += dsAdviserCustomerAlerts.Tables[0].Rows[i]["CustomerId"].ToString() + ",";
                            //if (hdnCustomerIdWithoutMobileNumber.Value != null)
                            //{
                            //    Session["CustomersWithoutMobileNumber"] = hdnCustomerIdWithoutMobileNumber.Value;
                            //}
                            //hdnCustomerNameWithoutMobileNumber.Value += dsAdviserCustomerAlerts.Tables[0].Rows[i]["CustomerName"].ToString() + ",";
                        }
                        if (drAdviserCustomerAlert != null)
                        {
                            dtAdviserCustomerAlerts.Rows.Add(drAdviserCustomerAlert);
                        }
                        
                        
                    }                   
                    
                }
                gvCustomerSMSAlerts.DataSource = dtAdviserCustomerAlerts;
                gvCustomerSMSAlerts.DataBind();
                gvCustomerSMSAlerts.Visible = true;
                pnlCustomerSMSAlerts.Visible = true;
                lblNoRecords.Visible = false;
                btnSend.Visible = true;

            }
            else
            {
                lblNoRecords.Visible = true;
                gvCustomerSMSAlerts.Visible = false;
                pnlCustomerSMSAlerts.Visible = true;
                btnSend.Visible = false;
            }

        }
        public void setAdviserSMSLicenseInfo()
        {
            AdvisorBo adviserBo = new AdvisorBo();
            DataSet dsAdviserSubscriptionDetails;
            int smsLicense = 0;
            int adviserId=0;
            if(Session["advisorVo"]!=null)
                adviserId=((AdvisorVo)Session["advisorVo"]).advisorId;
            dsAdviserSubscriptionDetails=adviserBo.GetAdviserSubscriptionDetails(adviserId);
            if (dsAdviserSubscriptionDetails != null)
            {
                DataRow drAdviserSubscriptionDetails = dsAdviserSubscriptionDetails.Tables[0].Rows[0];
                smsLicense = int.Parse(drAdviserSubscriptionDetails["AS_SMSLicenece"].ToString());
            }
            if (smsLicense == 0)
            {
                lblLincenceValue.Text = "No SMS Licence Left!!";
            }
            else
            {
                lblLincenceValue.Text=smsLicense.ToString();
            }
        }
        protected void gvCustomerSMSAlerts_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                if (e.Row.Cells[2].Text == "0")
                {
                    ((CheckBox)e.Row.FindControl("chkCustomerSMSAlert")).Visible = false;
                    e.Row.Cells[2].Text = "";
                }
                else
                {
                    ((CheckBox)e.Row.FindControl("chkCustomerSMSAlert")).Visible = true;                    
                  
                }                

            }
           
        }
        protected void btnUpdateMobileNo_Click(object sender, EventArgs e)
        {
            //List<TextBox> txtMobileNoList=(TextBox)gvCustomerSMSAlerts.FindControl("txtMobileNo");
            AlertsBo alertsBo = new AlertsBo();
            string customerId = "";            
            foreach (GridViewRow gvr in gvCustomerSMSAlerts.Rows)
            {
                TextBox txtMobileNo = (TextBox)gvr.FindControl("txtMobileNo");
                if (txtMobileNo.Text != "0" && txtMobileNo.Text != null)
                {
                    customerId = gvCustomerSMSAlerts.DataKeys[gvr.RowIndex].Value.ToString();
                    alertsBo.UpdateCustomerMobileNumber(int.Parse(customerId),Int64.Parse(txtMobileNo.Text));
                    hdnCustomerIdWithoutMobileNumber.Value += "1,";
                }
            }
            
        }

        protected void btnSend_Click(object sender, EventArgs e)
        {
            //System.Threading.Thread.Sleep(2000);
            int smsCount = 0;
            int smsLicence = 0;
            SMSVo smsVo = new SMSVo();
            List<int> alertIdList = new List<int>();
            EmailSMSBo emailSMSBo = new EmailSMSBo();
            List<SMSVo> smsVoList = new List<SMSVo>();
            AdvisorBo advisorBo = new AdvisorBo();
            AlertsBo alertsBo = new AlertsBo();
            string mobileNo;
            int adviserId = 0;
            if (Session["advisorVo"] != null)
                adviserId = ((AdvisorVo)Session["advisorVo"]).advisorId;
            if (lblLincenceValue.Text != "No SMS Licence Left!!")
                smsLicence = int.Parse(lblLincenceValue.Text.ToString());
            int i = 0;
            foreach (GridViewRow gvRow in gvCustomerSMSAlerts.Rows)
            {
                if (gvRow.RowType == DataControlRowType.DataRow)
                {
                    if (((CheckBox)gvRow.FindControl("chkCustomerSMSAlert")).Checked)
                    {
                        smsVo = new SMSVo();
                        if (dsAdviserCustomerAlerts != null)
                        {
                            mobileNo = dsAdviserCustomerAlerts.Tables[0].Rows[i]["Mobile"].ToString();
                            if (mobileNo != "0")
                            {
                                if (mobileNo.Length <= 10)
                                    smsVo.Mobile = Int64.Parse("91" + dsAdviserCustomerAlerts.Tables[0].Rows[i]["Mobile"].ToString());
                                else
                                    smsVo.Mobile = Int64.Parse(mobileNo);
                            }
                        }
                        smsVo.Message = gvRow.Cells[3].Text.ToString();
                        smsVo.CustomerId = int.Parse(gvCustomerSMSAlerts.DataKeys[gvRow.RowIndex].Values["CustomerId"].ToString());
                        smsVo.IsSent = 0;
                        if (dsAdviserCustomerAlerts.Tables[0].Rows[i]["AlertId"].ToString() != null)
                        {
                            smsVo.AlertId = int.Parse(dsAdviserCustomerAlerts.Tables[0].Rows[i]["AlertId"].ToString());
                        }
                        else
                        {
                            smsVo.AlertId = 0;
                        }
                        smsVoList.Add(smsVo);
                        alertIdList.Add(int.Parse(gvCustomerSMSAlerts.DataKeys[gvRow.RowIndex].Values["AlertId"].ToString()));
                        smsCount++;

                    }
                }
                i++;
            }
            if (smsCount <= smsLicence && smsCount != 0)
            {
                smsVoList = emailSMSBo.AddToSMSQueue(smsVoList);

                smsLicence = smsLicence - smsCount;
                advisorBo.UpdateAdviserSMSLicence(adviserId, smsLicence);
                advisorBo.AddToAdviserSMSLog(smsVoList, adviserId, "Alert");
                alertsBo.UpdateAlertStatus(alertIdList, 1);
                if (smsLicence == 0)
                {
                    lblLincenceValue.Text = "No SMS Licence Left!!";
                }
                else
                {
                    lblLincenceValue.Text = smsLicence.ToString();
                }
                GetAdviserCustomerAlerts();
            }
            else if (smsCount == 0)
            {
                ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "pageloadscript", "alert('Please select an Alert!!');", true);

            }
            else
            {
                ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "pageloadscript", "alert('You dont have enough SMS Credits to process this request');", true);

            }
        }

    }
}