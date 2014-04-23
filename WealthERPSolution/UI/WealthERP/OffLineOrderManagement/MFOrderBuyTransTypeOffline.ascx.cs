﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using BoOnlineOrderManagement;
using System.Data;
using System.IO;
using BoCommon;
using VoCommon;
using VoUser;
using WealthERP.Base;
using System.Configuration;
using BoOps;

namespace WealthERP.OffLineOrderManagement
{
    public partial class MFOrderBuyTransTypeOffline : System.Web.UI.UserControl
    {

        CommonProgrammingBo commonProgrammingBo;
        DataSet dsextractType;
        OnlineNCDBackOfficeBo onlineNCDBackOfficebo = new OnlineNCDBackOfficeBo();
        OperationBo operationBo = new OperationBo();
        string fileExtension = string.Empty;
        string strGuid = string.Empty;
        string ExtractPath = string.Empty;
        AdvisorVo advisorVo = new AdvisorVo();
        DataSet dsExtractTypeDataForFileCreation;
        DateTime orderDate;

        DataTable dtTableForExtract;
        string filename;
        string delimeter;

        protected void Page_Load(object sender, EventArgs e)
        {
            SessionBo.CheckSession();
            advisorVo = (AdvisorVo)Session[SessionContents.AdvisorVo];
            ExtractPath = Server.MapPath("UploadFiles");

            if (!IsPostBack)
            {
                //txtExtractDate.MaxDate = DateTime.Now;
                // fromdate = DateTime.Now.AddDays(-1);
                txtFromDate.SelectedDate = DateTime.Now.AddDays(-1);
                txtToDate.SelectedDate = DateTime.Now;
                BindddlExtractType();
               // txtExtractDate.SelectedDate = DateTime.Now;
                //BindOrderStatus();
            }
        }

        protected void BindddlExtractType()
        {
            dsextractType = new DataSet();
            dsextractType = onlineNCDBackOfficebo.GetNCDIPOAccountingExtractType();
            if (dsextractType != null && dsextractType.Tables[0].Rows.Count > 0)
            {
                ddlExtractType.DataSource = dsextractType;
                ddlExtractType.DataValueField = dsextractType.Tables[0].Columns["WUXFT_XMLFileTypeId"].ToString();
                ddlExtractType.DataTextField = dsextractType.Tables[0].Columns["WUXFT_XMLFileName"].ToString();
                ddlExtractType.DataBind();
            }
            ddlExtractType.Items.Insert(0, new System.Web.UI.WebControls.ListItem("--SELECT--", "0"));
            ddlExtractType.SelectedIndex = 0;
        }
        protected void btnExtract_Click(object sender, EventArgs e)
        {
            DateTime fromdate;
            DateTime todate;
            DataSet dsBackOfficeAccountingExtract = new DataSet();
            dsExtractTypeDataForFileCreation = onlineNCDBackOfficebo.GetNCDIPOExtractTypeDataForFileCreation(orderDate, advisorVo.advisorId, Convert.ToInt32(ddlExtractType.SelectedValue), Convert.ToDateTime(txtFromDate.SelectedDate), Convert.ToDateTime(txtToDate.SelectedDate));
            if (dsExtractTypeDataForFileCreation.Tables.Count <= 0)
            {
                ShowMessage("No Data Available");

                return;
            }
            else if (dsExtractTypeDataForFileCreation.Tables[0].Rows.Count <= 0)
            {
                ShowMessage("No Data Available");
                return;
            }
            CreateFileForextractAndSaveinServer();
            CreateDataTableForExtract();


        }
        protected void CreateFileForextractAndSaveinServer()
        {
            commonProgrammingBo = new CommonProgrammingBo();
            string strFileNameAndDelimeter = string.Empty;

            strFileNameAndDelimeter = commonProgrammingBo.SetFileNameAndDelimeter(Convert.ToInt32(ddlExtractType.SelectedValue), DateTime.Now);
            SetFileNameAndDelimeter(strFileNameAndDelimeter);
            //SetFileNameAndDelimeter(Convert.ToInt32(ddlExtractType.SelectedValue));
            File.WriteAllText(Path.Combine(ExtractPath, filename), ", System.Text.Encoding.Default");
        }
        protected void CreateDataTableForExtract()
        {
           
                CreateTextFile(Convert.ToInt32(ddlExtractType.SelectedValue));
            
        }
        protected void CreateTextFile(int FileID)
        {
            string file = string.Empty;
            if (!string.IsNullOrEmpty(filename))
            {
              

                #region ExportDataTabletoFile
                StreamWriter str = new StreamWriter(Server.MapPath("UploadFiles/" + filename), false, System.Text.Encoding.Default);

                string Columns = string.Empty;

                if (FileID == 46)
                {
                    foreach (DataColumn column in dsExtractTypeDataForFileCreation.Tables[0].Columns)
                    {
                        Columns += column.ColumnName + delimeter;
                    }
                    str.WriteLine(Columns.Remove(Columns.Length - 1, 1));
                }


                foreach (DataRow datarow in dsExtractTypeDataForFileCreation.Tables[0].Rows)
                {
                    string row = string.Empty;
                    foreach (object items in datarow.ItemArray)
                    {
                        row += items.ToString().Trim() + delimeter;
                    }
                    str.WriteLine(row.Remove(row.Length - 1, 1));
                }
                str.Flush();
                str.Close();
                #endregion
                #region download notepad or text file.
                Response.ContentType = "application/octet-stream";



                Response.AppendHeader("Content-Disposition", "attachment;filename=" + filename);
                string aaa = Server.MapPath("~/UploadFiles/" + filename);
                Response.TransmitFile(Server.MapPath("~/UploadFiles/" + filename));
                HttpContext.Current.ApplicationInstance.CompleteRequest();
                Response.End();
                #endregion
            }
        }
        protected void SetFileNameAndDelimeter(string strFileNameAndDelimeter)
        {
            string[] FileNameAndDelimeter = strFileNameAndDelimeter.Split('~');
            filename = FileNameAndDelimeter[0];
            delimeter = FileNameAndDelimeter[1];
        }
        private void ShowMessage(string msg)
        {
            tblMessage.Visible = true;
            msgRecordStatus.InnerText = msg;
            ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "mykey", "hide();", true);
        }


    }
}