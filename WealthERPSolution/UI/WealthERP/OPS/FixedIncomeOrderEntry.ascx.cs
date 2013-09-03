﻿using System;
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
using BoCustomerProfiling;
using BoCustomerPortfolio;
using VOAssociates;
using BOAssociates;
using iTextSharp.text.pdf;
using System.IO;
using BoCommon;
using System.Transactions;


namespace WealthERP.OPS
{
    public partial class FixedIncomeOrderEntry : System.Web.UI.UserControl
    {
        string path = "";
        string TargetPath = "";
        string imageUploadPath = "";
        CustomerProofUploadsVO CPUVo = new CustomerProofUploadsVO();

        System.Drawing.Image thumbnail_image = null;
        System.Drawing.Image original_image = null;
        System.Drawing.Bitmap final_image = null;
        System.Drawing.Graphics graphic = null;
        MemoryStream ms = null;
        CustomerVo customerVo = new CustomerVo();
        //RMVo rmVo = new RMVo();
        //AdvisorStaffBo advisorStaffBo = new AdvisorStaffBo();
        DataSet dsCustomerProof = new DataSet();
        CustomerBo customerBo = new CustomerBo();
        //CustomerVo customerVo = new CustomerVo();
        int custBankAccId;
        int customerId;
        //AdvisorVo adviserVo = new AdvisorVo();
        string strGuid = string.Empty;
        RepositoryBo repoBo;
        float fStorageBalance;
        float fMaxStorage;
        string linkAction = "";
        DataRow drCustomerAssociates;
        DataSet dsCustomerAssociates;
        DataTable dtCustomerAssociates = new DataTable();
        DataTable dtCustomerAssociatesRaw = new DataTable();
        //------------------
        //CustomerVo customerVo = new CustomerVo();
        CustomerAccountBo customerAccountBo = new CustomerAccountBo();
        //CustomerBo customerBo = new CustomerBo();
        AdvisorVo advisorVo;
        UserVo userVo;
        RMVo rmVo = new RMVo();
        FIOrderVo FiOrdVO = new FIOrderVo();
        FIOrderBo FiOrdBo = new FIOrderBo ();
        int orderId;
        int orderNumber = 0;
        int customerid;
        string defaultInterestRate;
        protected void Page_Load(object sender, EventArgs e)
        {
            
            userVo = (UserVo)Session[SessionContents.UserVo];
            if (!string.IsNullOrEmpty(Session["advisorVo"].ToString()))
                advisorVo = (AdvisorVo)Session["advisorVo"];
            if (!string.IsNullOrEmpty(Session[SessionContents.RmVo].ToString()))
                rmVo = (RMVo)Session[SessionContents.RmVo];
            orderNumber = FiOrdBo.GetOrderNumber();
            orderNumber = orderNumber + 1;
            lblGetOrderNo.Text = orderNumber.ToString();
            if (!IsPostBack)
            {
                FICategory();
                FIIssuer(advisorVo.advisorId);
                GetFIModeOfHolding();
               

            }
            if (Session["customerid"] != null)
            {
                customerid = Convert.ToInt32 (Session["customerid"]);
                LoadNominees();
               GetCustomerAssociates(customerid);
            }

            

        }
        public void LoadNominees()
        {
            customerVo.CustomerId = customerid;
            try
            {
                dsCustomerAssociates = customerAccountBo.GetCustomerAssociatedRel(customerVo.CustomerId);
                dtCustomerAssociatesRaw = dsCustomerAssociates.Tables[0];

                dtCustomerAssociates.Columns.Add("MemberCustomerId");
                dtCustomerAssociates.Columns.Add("AssociationId");
                dtCustomerAssociates.Columns.Add("Name");
                dtCustomerAssociates.Columns.Add("Relationship");

                foreach (DataRow dr in dtCustomerAssociatesRaw.Rows)
                {

                    drCustomerAssociates = dtCustomerAssociates.NewRow();
                    drCustomerAssociates[0] = dr["C_AssociateCustomerId"].ToString();
                    drCustomerAssociates[1] = dr["CA_AssociationId"].ToString();
                    drCustomerAssociates[2] = dr["C_FirstName"].ToString() + " " + dr["C_LastName"].ToString();
                    drCustomerAssociates[3] = dr["XR_Relationship"].ToString();
                    dtCustomerAssociates.Rows.Add(drCustomerAssociates);
                }

                if (dtCustomerAssociates.Rows.Count > 0)
                {
                    gvNominees.DataSource = dtCustomerAssociates;
                    gvNominees.DataBind();
                    gvNominees.Visible = true;

                    trNoNominee.Visible = false;
                    //trNomineeCaption.Visible = true;
                    trNominees.Visible = true;
                }
                else
                {
                    trNoNominee.Visible = true;
                    //trNomineeCaption.Visible = false;
                    trNominees.Visible = false;
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
                FunctionInfo.Add("Method", "CustomerAccountAdd.ascx:LoadNominees()");
                object[] objects = new object[1];
                objects[0] = customerVo;
                FunctionInfo = exBase.AddObject(FunctionInfo, objects);
                exBase.AdditionalInformation = FunctionInfo;
                ExceptionManager.Publish(exBase);
                throw exBase;

            }
        }

        private void TaxStatus()
        {

           
        }

        protected void OnPayAmtTextchanged(object sender, EventArgs e)
        {
            if (!string.IsNullOrEmpty(txtPayAmt.Text))
            {

                txtMatAmt.Text = Convert.ToString(Convert.ToDouble(txtPayAmt.Text) + (Convert.ToDouble(txtPayAmt.Text) * Convert.ToDouble(hdnDefaulteInteresRate.Value) / 100));
            }

        }
        private bool UploadFile(out bool blZeroBalance, out bool blFileSizeExceeded)
        {
            // We need to see if the adviser has a folder in Vault path retrieved from the web.config
            // Case 1: If not, then encode the adviser id and create a folder with the encoded id
            // then create a folder for the repository category within the encoded folder
            // then store the encoded advisor_adviserID + customerID + GUID + file name
            // Case 2: If folder exists, check if the category folder exists. 
            // If not then, create a folder with the category code and store the file as done above.
            // If yes, then just store the file as done above.
            // Once this is done, store the info in the DB with the file path.

            string Temppath = System.Configuration.ConfigurationManager.AppSettings["UploadCustomerProofImages"];
            string UploadedFileName = String.Empty;
            bool blResult = false;
            blZeroBalance = false;
            blFileSizeExceeded = false;
            string extension = String.Empty;
            float fileSize = 0;

            try
            {
                //customerVo = (CustomerVo)Session[SessionContents.CustomerVo];

                //// Uploading of file mandatory during button submit
                //if (radUploadProof.UploadedFiles.Count != 0)
                //{
                //    // Put this part under a transaction scope
                //    using (TransactionScope scope1 = new TransactionScope())
                //    {
                //        UploadedFile file = radUploadProof.UploadedFiles[0];
                //        fileSize = float.Parse(file.ContentLength.ToString()) / 1048576; // Converting bytes to MB
                //        extension = file.GetExtension();

                //        // If space is there to upload file
                //        if (fStorageBalance >= fileSize)
                //        {
                //            if (fileSize <= 2)   // If upload file size is less than 2 MB then upload
                //            {
                //                // Check if directory for advisor exists, and if not then create a new directoty
                //                if (Directory.Exists(Temppath))
                //                {
                //                    path = Temppath + "\\advisor_" + rmVo.AdviserId + "\\";
                //                    if (!System.IO.Directory.Exists(path))
                //                    {
                //                        System.IO.Directory.CreateDirectory(path);
                //                    }
                //                }
                //                else
                //                {
                //                    System.IO.Directory.CreateDirectory(Temppath);
                //                    path = Temppath + "\\advisor_" + rmVo.AdviserId + "\\";
                //                    if (!System.IO.Directory.Exists(path))
                //                    {
                //                        System.IO.Directory.CreateDirectory(path);
                //                    }
                //                    //path = Server.MapPath("TempCustomerProof") + "\\advisor_" + rmVo.AdviserId + "\\";
                //                }

                //                strGuid = Guid.NewGuid().ToString();
                //                string newFileName = SaveFileIntoServer(file, strGuid, path, customerVo.CustomerId);

                //                // Update DB with details
                //                CPUVo.CustomerId = customerVo.CustomerId;
                //                CPUVo.ProofTypeCode = Convert.ToInt32(ddlProofType.SelectedValue);
                //                CPUVo.ProofCode = Convert.ToInt32(ddlProof.SelectedValue);
                //                CPUVo.ProofCopyTypeCode = ddlProofCopyType.SelectedValue;
                //                CPUVo.ProofImage = path + "\\" + newFileName;

                //                blResult = CreateDBReferrenceForProofUploads(CPUVo);

                //                if (blResult)
                //                {
                //                    // Once the adding of Document is a success, then update the balance storage in advisor subscription table
                //                    fStorageBalance = UpdateAdvisorStorageBalance(fileSize, 0, fStorageBalance);
                //                    LoadImages();
                //                }
                //            }
                //            else
                //            {
                //                blFileSizeExceeded = true;
                //            }
                //        }
                //        else
                //        {
                //            blZeroBalance = true;
                //        }

                //        scope1.Complete();   // Commit the transaction scope if no errors
                //    }
                //}
                //else
                //{
                //    ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "pageloadscript", "alert('Please select a document file to upload!');", true);
                //}
            }
            catch (BaseApplicationException Ex)
            {
                throw Ex;
            }
            catch (Exception Ex)
            {
                //object[] objects = new object[1];
                //objects[0] = CPUVo;
                //PageException(objects, Ex, "ViewCustomerProofs.ascx:AddClick()");
            }
            return blResult;

            #region Old Code

            //    FileIOPermission fp = new FileIOPermission(FileIOPermissionAccess.AllAccess, path);
            //    PermissionSet ps = new PermissionSet(PermissionState.None);
            //    ps.AddPermission(fp);
            //    DirectoryInfo[] DI = new DirectoryInfo(path).GetDirectories("*.*", SearchOption.AllDirectories);
            //    FileInfo[] FI = new DirectoryInfo(path).GetFiles("*.*", SearchOption.AllDirectories);

            //    foreach (FileInfo F1 in FI)
            //    {
            //        DirSize += F1.Length;
            //    }
            //    //Converting in Mega bytes
            //    DirSize = DirSize / 1048576;

            //    #region Update Code 1

            //    if (Session["ImagePath"] != null)
            //    {
            //        // If Uploaded File Exists
            //        FileInfo fi = new FileInfo(Session["ImagePath"].ToString());
            //        float alreadyUploadedFileSize = fi.Length;
            //        alreadyUploadedFileSize = alreadyUploadedFileSize / 1048576;
            //        DirSize = DirSize - alreadyUploadedFileSize;
            //    }

            //    #endregion

            //    if ((fileSize < adviserVo.VaultSize) && (DirSize < adviserVo.VaultSize))
            //    {
            //        foreach (UploadedFile f in radUploadProof.UploadedFiles)
            //        {
            //            int l = (int)f.InputStream.Length;
            //            byte[] bytes = new byte[l];
            //            f.InputStream.Read(bytes, 0, l);

            //            imageUploadPath = customerVo.CustomerId + "_" + guid + "_" + f.GetName();
            //            if (btnSubmit.Text == "Submit")
            //            {
            //                // Submit part
            //                if (extension != ".pdf")
            //                {
            //                    UploadImage(path, f, imageUploadPath);
            //                }
            //                else
            //                {
            //                    f.SaveAs(path + "\\" + imageUploadPath);
            //                }
            //            }

            //            #region Update Code 2

            //            else
            //            {
            //                if (extension != ".pdf")
            //                {
            //                    File.Delete(path + UploadedFileName);
            //                    DataTable dtGetPerticularProofs = new DataTable();
            //                    if (Session["ProofID"] != null)
            //                    {
            //                        int ProofIdToDelete = Convert.ToInt32(Session["ProofID"].ToString());
            //                        dtGetPerticularProofs = GetUploadedImagePaths(ProofIdToDelete);
            //                        string imageAttachmentPath = dtGetPerticularProofs.Rows[0]["CPU_Image"].ToString();
            //                        if (customerBo.DeleteCustomerUploadedProofs(customerVo.CustomerId, ProofIdToDelete))
            //                        {
            //                            File.Delete(imageAttachmentPath);
            //                            ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "ViewCustomerProofs", "loadcontrol('ViewCustomerProofs','login');", true);
            //                        }
            //                    }
            //                }
            //                f.SaveAs(path + "\\" + imageUploadPath);
            //            }

            //            #endregion

            //        }
            //    }
            //    else
            //    {
            //        ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "pageloadscript", "alert('Sorry your Document attachment size exceeds the allowable limit..!');", true);
            //    }
            //}

            //CPUVo.CustomerId = customerVo.CustomerId;
            //CPUVo.ProofTypeCode = Convert.ToInt32(ddlProofType.SelectedValue);
            //CPUVo.ProofCode = Convert.ToInt32(ddlProof.SelectedValue);
            //CPUVo.ProofCopyTypeCode = ddlProofCopyType.SelectedValue;
            //if (imageUploadPath == "")
            //    CPUVo.ProofImage = path + "\\" + UploadedFileName;
            //else
            //    CPUVo.ProofImage = path + "\\" + imageUploadPath;
            //CreateDBReferrenceForProofUploads(CPUVo);

            //LoadImages();
            //Session["ImagePath"] = null;

            #endregion
        }
        private bool CreateDBReferrenceForProofUploads(CustomerProofUploadsVO CPUVo)
        {
            string createOrUpdate = "";
            int proofUploadID = 0;
            bool bStatus = false;

            //if (btnSubmit.Text.Trim().Equals("Submit"))
            //{
                createOrUpdate = "Submit";
                if (CPUVo != null)
                {
                    bStatus = customerBo.CreateCustomersProofUploads(CPUVo, proofUploadID, createOrUpdate);
                }
            //}
            //else if (btnSubmit.Text.Trim().Equals(Constants.Update.ToString()))
            //{
            //    createOrUpdate = Constants.Update.ToString();
            //    proofUploadID = Convert.ToInt32(Session["ProofID"].ToString());
            //    if (CPUVo != null)
            //    {
            //        bStatus = customerBo.CreateCustomersProofUploads(CPUVo, proofUploadID, createOrUpdate);
            //    }
            //}

            return bStatus;
        }

        private void UploadImage(string path, UploadedFile f, string imageUploadPath)
        {
            TargetPath = path;

            UploadedFile jpeg_image_upload = f;

            // Retrieve the uploaded image
            original_image = System.Drawing.Image.FromStream(jpeg_image_upload.InputStream);
            original_image.Save(TargetPath + imageUploadPath);//"O_" + 

            int width = original_image.Width;
            int height = original_image.Height;
            //int new_width, new_height;

            //int target_width = 140;
            //int target_height = 100;

            //CreateThumbnail(original_image, ref final_image, ref graphic, ref ms, jpeg_image_upload, width, height, target_width, target_height, "", true, false, out new_width, out new_height, imageUploadPath); // , out thumbnail_id

            //File.Delete(TargetPath + "O_" + System.IO.Path.GetFileName(jpeg_image_upload.FileName));
        }
        private string SaveFileIntoServer(UploadedFile file, string strGuid, string strPath, int intCustId)
        {
            string fileExtension = String.Empty;
            fileExtension = file.GetExtension();
            string strRenameFilename = file.GetName();
            strRenameFilename = strRenameFilename.Replace(' ', '_');
            string newFileName = intCustId + "_" + strGuid + "_" + strRenameFilename;

            // Save Document file in the path
            if (fileExtension != ".pdf")
                UploadImage(strPath, file, newFileName);
            else
                file.SaveAs(strPath + "\\" + newFileName);

            return newFileName;
        }
        //private void saveJpeg(string p, System.Drawing.Bitmap final_image, int p_3)
        //{
        //    // Encoder parameter for image quality
        //    EncoderParameter qualityParam =
        //       new EncoderParameter(System.Drawing.Imaging.Encoder.Quality, (long)p_3);

        //    // Jpeg image codec
        //    ImageCodecInfo jpegCodec =
        //       this.getEncoderInfo("image/png");

        //    if (jpegCodec == null)
        //        return;

        //    EncoderParameters encoderParams = new EncoderParameters(1);
        //    encoderParams.Param[0] = qualityParam;

        //    final_image.Save(p, jpegCodec, encoderParams);
        //}
        //private void UploadImage(string path, UploadedFile f, string imageUploadPath)
        //{
        //    TargetPath = path;

        //    UploadedFile jpeg_image_upload = f;

        //    // Retrieve the uploaded image
        //    original_image = System.Drawing.Image.FromStream(jpeg_image_upload.InputStream);
        //    original_image.Save(TargetPath + imageUploadPath);//"O_" + 

        //    int width = original_image.Width;
        //    int height = original_image.Height;
        //    //int new_width, new_height;

        //    //int target_width = 140;
        //    //int target_height = 100;

        //    //CreateThumbnail(original_image, ref final_image, ref graphic, ref ms, jpeg_image_upload, width, height, target_width, target_height, "", true, false, out new_width, out new_height, imageUploadPath); // , out thumbnail_id

        //    //File.Delete(TargetPath + "O_" + System.IO.Path.GetFileName(jpeg_image_upload.FileName));
        //}
        //private bool UploadFile(out bool blZeroBalance, out bool blFileSizeExceeded)
        //{
        //    // We need to see if the adviser has a folder in Vault path retrieved from the web.config
        //    // Case 1: If not, then encode the adviser id and create a folder with the encoded id
        //    // then create a folder for the repository category within the encoded folder
        //    // then store the encoded advisor_adviserID + customerID + GUID + file name
        //    // Case 2: If folder exists, check if the category folder exists. 
        //    // If not then, create a folder with the category code and store the file as done above.
        //    // If yes, then just store the file as done above.
        //    // Once this is done, store the info in the DB with the file path.

        //    string Temppath = System.Configuration.ConfigurationManager.AppSettings["UploadCustomerProofImages"];
        //    string UploadedFileName = String.Empty;
        //    bool blResult = false;
        //    blZeroBalance = false;
        //    blFileSizeExceeded = false;
        //    string extension = String.Empty;
        //    float fileSize = 0;

        //    try
        //    {
        //        customerVo = (CustomerVo)Session[SessionContents.CustomerVo];

        //        // Uploading of file mandatory during button submit
        //        if (radUploadProof.UploadedFiles.Count != 0)
        //        {
        //            // Put this part under a transaction scope
        //            using (TransactionScope scope1 = new TransactionScope())
        //            {
        //                UploadedFile file = radUploadProof.UploadedFiles[0];
        //                fileSize = float.Parse(file.ContentLength.ToString()) / 1048576; // Converting bytes to MB
        //                extension = file.GetExtension();

        //                // If space is there to upload file
        //                if (fStorageBalance >= fileSize)
        //                {
        //                    if (fileSize <= 2)   // If upload file size is less than 2 MB then upload
        //                    {
        //                        // Check if directory for advisor exists, and if not then create a new directoty
        //                        if (Directory.Exists(Temppath))
        //                        {
        //                            path = Temppath + "\\advisor_" + rmVo.AdviserId + "\\";
        //                            if (!System.IO.Directory.Exists(path))
        //                            {
        //                                System.IO.Directory.CreateDirectory(path);
        //                            }
        //                        }
        //                        else
        //                        {
        //                            System.IO.Directory.CreateDirectory(Temppath);
        //                            path = Temppath + "\\advisor_" + rmVo.AdviserId + "\\";
        //                            if (!System.IO.Directory.Exists(path))
        //                            {
        //                                System.IO.Directory.CreateDirectory(path);
        //                            }
        //                            //path = Server.MapPath("TempCustomerProof") + "\\advisor_" + rmVo.AdviserId + "\\";
        //                        }

        //                        strGuid = Guid.NewGuid().ToString();
        //                        string newFileName = SaveFileIntoServer(file, strGuid, path, customerVo.CustomerId);

        //                        // Update DB with details
        //                        CPUVo.CustomerId = customerVo.CustomerId;
        //                        CPUVo.ProofTypeCode = Convert.ToInt32(ddlProofType.SelectedValue);
        //                        CPUVo.ProofCode = Convert.ToInt32(ddlProof.SelectedValue);
        //                        CPUVo.ProofCopyTypeCode = ddlProofCopyType.SelectedValue;
        //                        CPUVo.ProofImage = path + "\\" + newFileName;

        //                        blResult = CreateDBReferrenceForProofUploads(CPUVo);

        //                        if (blResult)
        //                        {
        //                            // Once the adding of Document is a success, then update the balance storage in advisor subscription table
        //                            fStorageBalance = UpdateAdvisorStorageBalance(fileSize, 0, fStorageBalance);
        //                            LoadImages();
        //                        }
        //                    }
        //                    else
        //                    {
        //                        blFileSizeExceeded = true;
        //                    }
        //                }
        //                else
        //                {
        //                    blZeroBalance = true;
        //                }

        //                scope1.Complete();   // Commit the transaction scope if no errors
        //            }
        //        }
        //        else
        //        {
        //            ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "pageloadscript", "alert('Please select a document file to upload!');", true);
        //        }
        //    }
        //    catch (BaseApplicationException Ex)
        //    {
        //        throw Ex;
        //    }
        //    catch (Exception Ex)
        //    {
        //        object[] objects = new object[1];
        //        //objects[0] = CPUVo;
        //        //PageException(objects, Ex, "ViewCustomerProofs.ascx:AddClick()");
        //    }
        //    return blResult;

           
        //}

        private void GetCustomerAssociates(int customerid)
        {
            //DataSet dsAssociates = FiOrdBo.GetCustomerAssociates(customerid);
            //gvAssociation.DataSource = dsAssociates.Tables[0];
            //gvAssociation.DataBind();
        }
        //protected void rgvOrderSteps_NeedDataSource(object source, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        //{
        //    //DataSet dsAssociates = FiOrdBo.GetCustomerAssociates(customerid);
        //    //this.rgvCustGrid.DataSource = dsAssociates.Tables[0];
        ////}
        private void FICategory( )
        {
            DataSet dsBankName = FiOrdBo.GetFICategory();

    


            if (dsBankName.Tables[0].Rows.Count > 0)
            {
                 
                    ddlCategory.DataSource = dsBankName;
                    ddlCategory.DataValueField = dsBankName.Tables[0].Columns["PAIC_AssetInstrumentCategoryCode"].ToString();
                    ddlCategory.DataTextField = dsBankName.Tables[0].Columns["PAIC_AssetInstrumentCategoryName"].ToString();
                    ddlCategory.DataBind();
                 
                ddlCategory.Items.Insert(0, new ListItem("Select", "Select"));

            }
            else
            {
                ddlCategory.Items.Clear();
                ddlCategory.DataSource = null;
                ddlCategory.DataBind();
                ddlCategory.Items.Insert(0, new ListItem("Select", "Select"));
            }
        }


        private void GetFIModeOfHolding()
        {
            DataSet dsDepoBank = FiOrdBo.GetFIModeOfHolding();


            if (dsDepoBank.Tables[0].Rows.Count > 0)
            {

                ddlModeofHOldingFI.DataSource = dsDepoBank.Tables[0];
                ddlModeofHOldingFI.DataValueField = dsDepoBank.Tables[0].Columns["XMOH_ModeOfHoldingCode"].ToString();
                ddlModeofHOldingFI.DataTextField = dsDepoBank.Tables[0].Columns["XMOH_ModeOfHolding"].ToString();
                ddlModeofHOldingFI.DataBind();

                ddlModeofHOldingFI.Items.Insert(0, new ListItem("Select", "Select"));

            }
            else
            {
                ddlModeofHOldingFI.Items.Clear();
                ddlModeofHOldingFI.DataSource = null;
                ddlModeofHOldingFI.DataBind();
                ddlCategory.Items.Insert(0, new ListItem("Select", "Select"));
            }
        }

        private void  FIIssuer(int AdviserId)
        {
            DataSet dsIssuer = FiOrdBo.GetFIIssuer(AdviserId);
            if (dsIssuer.Tables[0].Rows.Count > 0)
            {
                ddlIssuer .DataSource = dsIssuer;
                ddlIssuer.DataValueField = dsIssuer.Tables[0].Columns["PFIIM_IssuerId"].ToString();
                ddlIssuer.DataTextField = dsIssuer.Tables[0].Columns["PFIIM_IssuerName"].ToString();
                ddlIssuer.DataBind();
                ddlIssuer.Items.Insert(0, new ListItem("Select", "Select"));
            }
            else
            {
                ddlIssuer.Items.Clear();
                ddlIssuer.DataSource = null;
                ddlIssuer.DataBind();
                ddlIssuer.Items.Insert(0, new ListItem("Select", "Select"));
            }
        }
        protected void rbtnYes_CheckedChanged(object sender, EventArgs e)
        {
            customerVo.CustomerId = customerid;

            try
            {
                if (rbtnYes.Checked)
                {
                    ddlModeofHOldingFI.Enabled = true;

                    dsCustomerAssociates = customerAccountBo.GetCustomerAssociatedRel(customerVo.CustomerId);
                    dtCustomerAssociates.Rows.Clear();
                    dtCustomerAssociatesRaw = dsCustomerAssociates.Tables[0];

                    dtCustomerAssociates.Columns.Clear();
                    dtCustomerAssociates.Columns.Add("MemberCustomerId");
                    dtCustomerAssociates.Columns.Add("AssociationId");
                    dtCustomerAssociates.Columns.Add("Name");
                    dtCustomerAssociates.Columns.Add("Relationship");

                    foreach (DataRow dr in dtCustomerAssociatesRaw.Rows)
                    {
                        drCustomerAssociates = dtCustomerAssociates.NewRow();
                        drCustomerAssociates[0] = dr["C_AssociateCustomerId"].ToString();
                        drCustomerAssociates[1] = dr["CA_AssociationId"].ToString();
                        drCustomerAssociates[2] = dr["C_FirstName"].ToString() + " " + dr["C_LastName"].ToString();
                        drCustomerAssociates[3] = dr["XR_Relationship"].ToString();
                        dtCustomerAssociates.Rows.Add(drCustomerAssociates);
                    }

                    if (dtCustomerAssociates.Rows.Count > 0)
                    {
                        trNoJointHolders.Visible = false;
                        trJoinHolders.Visible = true;
                        trJointHolderGrid.Visible = true;
                        gvJointHoldersList.DataSource = dtCustomerAssociates;
                        gvJointHoldersList.DataBind();
                        gvJointHoldersList.Visible = true;
                    }
                    else
                    {
                        trNoJointHolders.Visible = true;
                        trJoinHolders.Visible = false;
                        trJointHolderGrid.Visible = false;
                    }
                    ddlModeofHOldingFI.SelectedIndex = 0;
                }
                else
                {
                    ddlModeofHOldingFI.SelectedValue = "SI";
                    ddlModeofHOldingFI.Enabled = false;
                    trJoinHolders.Visible = false;
                    trJointHolderGrid.Visible = false;
                    trNoJointHolders.Visible = false;
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
                FunctionInfo.Add("Method", "CustomerAccountAdd.ascx:rbtnYes_CheckedChanged()");
                object[] objects = new object[1];
                objects[0] = customerVo;
                FunctionInfo = exBase.AddObject(FunctionInfo, objects);
                exBase.AdditionalInformation = FunctionInfo;
                ExceptionManager.Publish(exBase);
                throw exBase;

            }
        }
        private void FIScheme(int AdviserId, string IssuerID)
        {
            DataSet dsScheme = FiOrdBo.GetFIScheme(AdviserId, IssuerID);
            if (dsScheme.Tables[0].Rows.Count > 0)
            {
                ddlScheme.DataSource = dsScheme;
                ddlScheme.DataValueField = dsScheme.Tables[0].Columns["PFISM_SchemeId"].ToString();
                ddlScheme.DataTextField = dsScheme.Tables[0].Columns["PFISM_SchemeName"].ToString();
                ddlScheme.DataBind();
                ddlScheme.Items.Insert(0, new ListItem("Select", "Select"));
            }
            else
            {
                ddlScheme.Items.Clear();
                ddlScheme.DataSource = null;
                ddlScheme.DataBind();
                ddlScheme.Items.Insert(0, new ListItem("Select", "Select"));
            }
        }
        //FISeriesDetails
        private void FISeriesDetails(int SeriesID)
        {
            DataSet dsScheme = FiOrdBo.GetFISeriesDetailssDetails(SeriesID);
            DataTable dtSeriesDetails = dsScheme.Tables[0];
            string Tenure;
            string CouponType;
            
            if (dtSeriesDetails.Rows.Count > 0)
            {
                foreach (DataRow dr in dtSeriesDetails.Rows)
                {
                    Tenure = dr["PFISD_Tenure"].ToString();
                    hdnDefaulteInteresRate.Value  = dr["PFISD_defaultInterestRate"].ToString();
                  CouponType = dr["PFISD_CouponType"].ToString();
                  txtSeries.Text = "Tenure-" + Tenure + "/" + "InterestRate-" + hdnDefaulteInteresRate.Value + "/" + "InterestType-" + CouponType;
                }
                               
               
                
            }
            

        }
        private void FISeries(int  SeriesID)
        {
            DataSet dsScheme = FiOrdBo.GetFISeries(SeriesID);
            if (dsScheme.Tables[0].Rows.Count > 0)
            {
                ddlSeries.DataSource = dsScheme;
                ddlSeries.DataValueField = dsScheme.Tables[0].Columns["PFISD_SeriesId"].ToString();
                ddlSeries.DataTextField = dsScheme.Tables[0].Columns["PFISD_SeriesName"].ToString();
                ddlSeries.DataBind();
                ddlSeries.Items.Insert(0, new ListItem("Select", "Select"));
            }
            else
            {
                ddlSeries.Items.Clear();
                ddlSeries.DataSource = null;
                ddlSeries.DataBind();
                ddlSeries.Items.Insert(0, new ListItem("Select", "Select"));
            }
        }
        private void BindBank(int customerId)
        {
            //DataSet dsBankName = mfOrderBo.GetCustomerBank(customerId);
            //if (dsBankName.Tables[0].Rows.Count > 0)
            //{
            //    ddlBankName.DataSource = dsBankName;
            //    ddlBankName.DataValueField = dsBankName.Tables[0].Columns["CB_CustBankAccId"].ToString();
            //    ddlBankName.DataTextField = dsBankName.Tables[0].Columns["WERPBM_BankName"].ToString();
            //    ddlBankName.DataBind();
            //    ddlBankName.Items.Insert(0, new ListItem("Select", "Select"));
            //}
            //else
            //{
            //    ddlBankName.Items.Clear();
            //    ddlBankName.DataSource = null;
            //    ddlBankName.DataBind();
            //    ddlBankName.Items.Insert(0, new ListItem("Select", "Select"));
            //}
        }
         
        protected void ddlSchemeOption_SelectedIndexChanged(object sender, EventArgs e)
        {
        }

        protected void ddlFrequency_SelectedIndexChanged(object sender, EventArgs e)
        {
        }

        protected void ddlTranstype_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlTranstype.SelectedValue == "Select")
            {
                trDepRen.Visible = false;
            }
            else if (ddlTranstype.SelectedValue == "Renewal")
            {
                trDepRen.Visible = true;
            }
            else if (ddlTranstype.SelectedValue == "New")
            {
                trDepRen.Visible = false ;
            }

        }
        protected void ddlCategory_SelectedIndexChanged(object sender, EventArgs e)
        {
        }
        protected void ddlIssuer_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlIssuer.SelectedIndex !=0)
            FIScheme(advisorVo.advisorId,  ddlIssuer.SelectedValue);
        }
        protected void ddlScheme_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlScheme.SelectedIndex != 0)
                FISeries(Convert.ToInt32(ddlScheme.SelectedValue));
        }

        protected void ddlSeries_SelectedIndexChanged(object sender, EventArgs e)
        {

            if (ddlSeries.SelectedIndex != 0)
                FISeriesDetails(Convert.ToInt32(ddlSeries.SelectedValue));
        }

        protected void ddlBankName_SelectedIndexChanged(object sender, EventArgs e)
        {

        }
        protected void txtOrderDate_DateChanged(object sender, EventArgs e)
        {
        }

        protected void txtApplicationDt_DateChanged(object sender, EventArgs e)
        {
        }
        protected void txtCustomerId_ValueChanged1(object sender, EventArgs e)
        {
            if (!string.IsNullOrEmpty(txtCustomerId.Value.ToString().Trim()))
            {
                //trJointHoldersList.Visible = false;
                //ScriptManager.RegisterStartupScript(Page, Page.GetType(), "confirm", " ShowIsa();", true);
                //ScriptManager.RegisterStartupScript(Page, Page.GetType(), "confirm", " ShowIsa();", true);
               // ddlAMCList.Enabled = true;
                customerVo = customerBo.GetCustomer(int.Parse(txtCustomerId.Value));
                Session["customerVo"] = customerVo;
                //txtBranch.Text = customerVo.BranchName;
                //txtRM.Text = customerVo.RMName;
                //txtPanSearch.Text = customerVo.PANNum;
                //hdnCustomerId.Value = txtCustomerId.Value;
                //customerId = int.Parse(txtCustomerId.Value);
               // if (ddlsearch.SelectedItem.Value == "2")
               //     lblgetcust.Text = customerVo.FirstName + ' ' + customerVo.MiddleName + ' ' + customerVo.LastName;

                //= rmVo.FirstName + ' ' + rmVo.MiddleName + ' ' + rmVo.LastName;
               // BindBank(customerId);
                //BindPortfolioDropdown(customerId);
               // ddltransType.SelectedIndex = 0;
              //  BindISAList();
            }
        }

    }
}