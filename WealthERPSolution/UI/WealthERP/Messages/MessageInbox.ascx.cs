﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using VoUser;
using BoCommon;
using System.Data;
using WealthERP.Base;
using Telerik.Web.UI;

namespace WealthERP.Messages
{
    public partial class MessageInbox : System.Web.UI.UserControl
    {
        UserVo userVo;
        MessageBo msgBo;

        protected void Page_Load(object sender, EventArgs e)
        {
            SessionBo.CheckSession();
            userVo = (UserVo)Session[SessionContents.UserVo];
            //ScriptManager.RegisterStartupScript(Page, typeof(Page),
        }

        protected void RadGrid1_NeedDataSource(object source, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            DataSet dsInbox = new DataSet();
            msgBo = new MessageBo();

            dsInbox = msgBo.GetInboxRecords(userVo.UserId);

            if (dsInbox.Tables[0].Rows.Count > 0)
            {
                RadGrid1.DataSource = dsInbox.Tables[0];
                trContent.Visible = true;
                trNoRecords.Visible = false;
                ViewState["dsInbox"] = dsInbox;
            }
            else
            {
                // display no records found
                lblNoRecords.Visible = true;
                trContent.Visible = false;
                trNoRecords.Visible = true;
            }
        }

        protected void RadGrid1_ItemCommand(object sender, GridCommandEventArgs e)
        {
            if (e.CommandName == "Read")
            {
                GridDataItem dataItem = e.Item as GridDataItem;
                string strKeyValue = dataItem.GetDataKeyValue("MR_MessageRecipientId").ToString();

                /*
                 * check if the message has alreaDY been read by user. If yes, then do not update DB.
                 * Else if not read then update DB flag.
                 */
                tblMessageHeaders.Visible = true;
                DataSet dsInbox = (DataSet)ViewState["dsInbox"];
                foreach (DataRow dr in dsInbox.Tables[0].Rows)
                {
                    if (dr["MR_MessageRecipientId"].ToString() == strKeyValue)
                    {
                        string strMessage = dr["Message"].ToString();
                        string result = string.Empty;
                        for (int i = 0; i < strMessage.Length; i++)
                            result += (i % 100 == 0 && i != 0) ? (strMessage[i].ToString() + "<br/>") : strMessage[i].ToString();
                        lblMessageContent.Text = result;
                        lblSenderContent.Text = dr["Sender"].ToString();
                        lblSubjectContent.Text = dr["Subject"].ToString();
                        lblSentContent.Text = dataItem["Received"].Text;
                        break;
                    }
                }

                if (!Boolean.Parse(dataItem["ReadByUser"].Text))
                {
                    // If message is read first time, update DB that the message is read.
                    Int64 intRecipientId = Int64.Parse(strKeyValue);
                    bool blResult = false;
                    // update DB with read flag
                    msgBo = new MessageBo();
                    blResult = msgBo.UpdateMessageReadFlag(intRecipientId);

                    if (blResult)
                    {
                        // this should retrieve only the flag values and update the existing dataset which is stored in the cache with new flag values.
                        RadGrid1.Rebind();
                    }
                }
            }
        }

        protected void RadGrid1_ItemDataBound(object sender, GridItemEventArgs e)
        {
            if (e.Item is GridPagerItem)
            {
                RadComboBox rbCmBx = (RadComboBox)e.Item.FindControl("PageSizeComboBox");
                rbCmBx.Visible = false;

                Label lblPageSize = (Label)e.Item.FindControl("ChangePageSizeLabel");
                lblPageSize.Text = "";
            }
            else if (e.Item is GridHeaderItem)
            {
                CheckBox chkBxHeader = (CheckBox)e.Item.FindControl("hdrCheckBox");
                if (chkBxHeader != null)
                    chkBxHeader.Attributes.Add("onclick", "javascript:checkAllBoxes()");
            }
            else if (e.Item is GridDataItem)
            {
                GridDataItem dataBoundItem = e.Item as GridDataItem;
                if (dataBoundItem["Subject"].Text.Length > 75)
                {
                    dataBoundItem["Subject"].Text = dataBoundItem["Subject"].Text.Substring(0, 75) + ".....";
                }
                if (dataBoundItem["Received"].Text.Length > 30)
                {
                    dataBoundItem["Received"].Text = dataBoundItem["Received"].Text.Substring(0, 30) + ".....";
                }
            }
        }

        protected void btnDelete_Click(object sender, EventArgs e)
        {
 
        }


    }
}