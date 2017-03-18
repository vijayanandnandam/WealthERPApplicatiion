﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data.Common;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Specialized;
using Microsoft.ApplicationBlocks.ExceptionManagement;
using Microsoft.Practices.EnterpriseLibrary.Data;
using VoUser;


namespace DaoCustomerRiskProfiling
{
    public class RiskProfileDao
    {

        //Getting List of Question
        public DataSet GetRiskProfileQuestion(int advisorId)
        {
            Database db;
            DbCommand dbGetCustomerList = null;
            DataSet dsGetCustomerList = null;
            try
            {
                db = DatabaseFactory.CreateDatabase("wealtherp");
                dbGetCustomerList = db.GetStoredProcCommand("SP_GetRiskProfileQuestion");
                db.AddInParameter(dbGetCustomerList, "@A_AdviserId", DbType.Int32, advisorId);
                dsGetCustomerList = db.ExecuteDataSet(dbGetCustomerList);
            }
            catch (BaseApplicationException ex)
            {
                throw ex;
            }
            catch (Exception ex)
            {
                BaseApplicationException baseEx = new BaseApplicationException(ex.Message, ex);
                NameValueCollection FunctionInfo = new NameValueCollection();
                FunctionInfo.Add("Method", "RiskProfileDao.cs:GetRiskProfileQuestion()");
                throw baseEx;
            }
            return dsGetCustomerList;
        }


        //Getting Option for Each Question
        public DataSet GetQuestionOption(int questionId,int advisorId)
        {
            Database db;
            DataSet dsGetQuestionOption;
            DbCommand dbGetQuestionOption;
            try
            {
                db = DatabaseFactory.CreateDatabase("wealtherp");
                dbGetQuestionOption = db.GetStoredProcCommand("SP_GetQuestionOption");
                db.AddInParameter(dbGetQuestionOption, "@QuestionId", DbType.Int32, questionId);
                db.AddInParameter(dbGetQuestionOption, "@advisorId", DbType.Int32, advisorId);
                dsGetQuestionOption = db.ExecuteDataSet(dbGetQuestionOption);

            }
            catch (BaseApplicationException ex)
            {
                throw ex;
            }
            catch (Exception ex)
            {
                BaseApplicationException baseEx = new BaseApplicationException(ex.Message, ex);
                NameValueCollection FunctionInfo = new NameValueCollection();
                FunctionInfo.Add("Method", "RiskProfileDao.cs:GetQuestionOption()");
                object[] objects = new object[1];
                objects[0] = questionId;
                FunctionInfo = baseEx.AddObject(FunctionInfo, objects);
                baseEx.AdditionalInformation = FunctionInfo;
                ExceptionManager.Publish(baseEx);
                throw baseEx;
            }
            return dsGetQuestionOption;
        }


        //Getting Risk Profile Rules
        public DataSet GetRiskProfileRules(int adviserId)
        {
            Database db;
            DataSet dsGetRiskProfileRules;
            DbCommand dbGetRiskProfileRules;
            try
            {
                db = DatabaseFactory.CreateDatabase("wealtherp");
                dbGetRiskProfileRules = db.GetStoredProcCommand("SP_GetRiskProfileRules");
                db.AddInParameter(dbGetRiskProfileRules, "@AdviserId", DbType.Int32, adviserId);
                dsGetRiskProfileRules = db.ExecuteDataSet(dbGetRiskProfileRules);

            }
            catch (BaseApplicationException ex)
            {
                throw ex;
            }
            catch (Exception ex)
            {
                BaseApplicationException baseEx = new BaseApplicationException(ex.Message, ex);
                NameValueCollection FunctionInfo = new NameValueCollection();
                FunctionInfo.Add("Method", "RiskProfileDao.cs:GetRiskProfileRules()");
                throw baseEx;
            }
            return dsGetRiskProfileRules;
        }


        //Getting CustomerId by name
        public DataSet GetCustomerDOBById(int customerId)
        {
            Database db;
            DataSet dsGetCustomerIdByName;
            DbCommand dbGetCustomerIdByName;
            try
            {
                db = DatabaseFactory.CreateDatabase("wealtherp");
                dbGetCustomerIdByName = db.GetStoredProcCommand("SP_GetCustomerDOBById");
                db.AddInParameter(dbGetCustomerIdByName, "@CustomerId", DbType.Int32, customerId);
                dsGetCustomerIdByName = db.ExecuteDataSet(dbGetCustomerIdByName);

            }
            catch (BaseApplicationException ex)
            {
                throw ex;
            }
            catch (Exception ex)
            {
                BaseApplicationException baseEx = new BaseApplicationException(ex.Message, ex);
                NameValueCollection FunctionInfo = new NameValueCollection();
                FunctionInfo.Add("Method", "RiskProfileDao.cs:GetCustomerDOBById()");
                object[] objects = new object[1];
                objects[0] = customerId;
                FunctionInfo = baseEx.AddObject(FunctionInfo, objects);
                baseEx.AdditionalInformation = FunctionInfo;
                ExceptionManager.Publish(baseEx);
                throw baseEx;
            }
            return dsGetCustomerIdByName;
        }

        //Adding  Customer RiskProfile Details
        public void AddCustomerRiskProfileDetails(int AdviserId, int customerId, int crpscore, DateTime riskdate, string riskclasscode, RMVo rmvo, int IsDirectRiskClass,DateTime CustDOB)
        {
            Database db;
            DbCommand dbAddCustomerRiskProfileDetails;
            try
            {
                db = DatabaseFactory.CreateDatabase("wealtherp");
                dbAddCustomerRiskProfileDetails = db.GetStoredProcCommand("SP_AddRiskProfileAndAssetAllocationToCustomer");
                db.AddInParameter(dbAddCustomerRiskProfileDetails, "@AdviserId", DbType.Int32, AdviserId);
                db.AddInParameter(dbAddCustomerRiskProfileDetails, "@C_CustomerId", DbType.Int32, customerId);
                if (IsDirectRiskClass==0)
                    db.AddInParameter(dbAddCustomerRiskProfileDetails, "@CRP_Score", DbType.Int32, crpscore);
                db.AddInParameter(dbAddCustomerRiskProfileDetails, "@CRP_Date", DbType.DateTime, riskdate);
                db.AddInParameter(dbAddCustomerRiskProfileDetails, "@XRC_RiskClassCode", DbType.String, riskclasscode);
                db.AddInParameter(dbAddCustomerRiskProfileDetails, "@CRP_CreatedBy", DbType.Int32, rmvo.RMId);
                db.AddInParameter(dbAddCustomerRiskProfileDetails, "@CRP_ModifiedBy", DbType.Int32, rmvo.RMId);
                //db.AddOutParameter(dbAddCustomerRiskProfileDetails, "@RPId", DbType.Int32, 1000);
                db.AddInParameter(dbAddCustomerRiskProfileDetails, "@CRP_IsDirectRiskClass", DbType.Int32, IsDirectRiskClass);
                if (!string.IsNullOrEmpty(CustDOB.ToString()))
                    db.AddInParameter(dbAddCustomerRiskProfileDetails, "@DOB", DbType.DateTime, CustDOB);
                db.AddOutParameter(dbAddCustomerRiskProfileDetails, "@RiskProfileIdDirect", DbType.Int32, 1000);
                db.AddOutParameter(dbAddCustomerRiskProfileDetails, "@RiskProfileIdInDirect", DbType.Int32, 1000);

                db.ExecuteNonQuery(dbAddCustomerRiskProfileDetails);

            }
            catch (BaseApplicationException ex)
            {
                throw ex;
            }
            catch (Exception ex)
            {
                BaseApplicationException baseEx = new BaseApplicationException(ex.Message, ex);
                NameValueCollection FunctionInfo = new NameValueCollection();
                FunctionInfo.Add("Method", "RiskProfileDao.cs:GetQuestionOption()");
                object[] objects = new object[1];
                objects[0] = customerId;
                FunctionInfo = baseEx.AddObject(FunctionInfo, objects);
                baseEx.AdditionalInformation = FunctionInfo;
                ExceptionManager.Publish(baseEx);
                throw baseEx;
            }

        }

        //Adding Roisk Profile Response Question
        public void AddCustomerResponseToQuestion(int RpId, int questionId, int optionId, RMVo rmvo)
        {
            Database db;
            DbCommand dbAddCustomerRiskProfileDetails;
            try
            {
                db = DatabaseFactory.CreateDatabase("wealtherp");
                dbAddCustomerRiskProfileDetails = db.GetStoredProcCommand("SP_AddCustomerResponseToQuestion");
                db.AddInParameter(dbAddCustomerRiskProfileDetails, "@RpId", DbType.Int32, RpId);
                db.AddInParameter(dbAddCustomerRiskProfileDetails, "@QM_QuestionId", DbType.Int32, questionId);
                db.AddInParameter(dbAddCustomerRiskProfileDetails, "@QOM_OptionId", DbType.Int32, optionId);
                db.AddInParameter(dbAddCustomerRiskProfileDetails, "@CRTQ_CreatedBy", DbType.Int32, rmvo.RMId);
                db.AddInParameter(dbAddCustomerRiskProfileDetails, "@CRTQ_ModifiedBy", DbType.String, rmvo.RMId);
                db.ExecuteNonQuery(dbAddCustomerRiskProfileDetails);


            }
            catch (BaseApplicationException ex)
            {
                throw ex;
            }
            catch (Exception ex)
            {
                BaseApplicationException baseEx = new BaseApplicationException(ex.Message, ex);
                NameValueCollection FunctionInfo = new NameValueCollection();
                FunctionInfo.Add("Method", "RiskProfileDao.cs:AddCustomerResponseToQuestion()");
                object[] objects = new object[1];
                objects[0] = questionId;
                FunctionInfo = baseEx.AddObject(FunctionInfo, objects);
                baseEx.AdditionalInformation = FunctionInfo;
                ExceptionManager.Publish(baseEx);
                throw baseEx;
            }

        }

        //Getting Risk Class 
        public DataSet GetRiskClass(string RiskClassCode)
        {
            Database db;
            DataSet dsGetRiskClass;
            DbCommand dbGetRiskClass;
            try
            {
                db = DatabaseFactory.CreateDatabase("wealtherp");
                dbGetRiskClass = db.GetStoredProcCommand("SP_GetRiskClass");
                db.AddInParameter(dbGetRiskClass, "@RiskCode", DbType.String, RiskClassCode);
                dsGetRiskClass = db.ExecuteDataSet(dbGetRiskClass);

            }
            catch (BaseApplicationException ex)
            {
                throw ex;
            }
            catch (Exception ex)
            {
                BaseApplicationException baseEx = new BaseApplicationException(ex.Message, ex);
                NameValueCollection FunctionInfo = new NameValueCollection();
                FunctionInfo.Add("Method", "RiskProfileDao.cs:GetQuestionOption()");
                object[] objects = new object[1];
                objects[0] = RiskClassCode;
                FunctionInfo = baseEx.AddObject(FunctionInfo, objects);
                baseEx.AdditionalInformation = FunctionInfo;
                ExceptionManager.Publish(baseEx);
                throw baseEx;
            }
            return dsGetRiskClass;
        }

        //Get Risk profile Id from CustomerRiskProfile Databse 
        public DataSet GetRpId(int customerId,int isDirect)
        {
            Database db;
            DataSet dsGetRpId;
            DbCommand dbGetRpId;
            try
            {
                db = DatabaseFactory.CreateDatabase("wealtherp");
                dbGetRpId = db.GetStoredProcCommand("SP_GetRpIdByCustomerId");
                db.AddInParameter(dbGetRpId, "@CustomerId", DbType.Int32, customerId);
                db.AddInParameter(dbGetRpId, "@isDirect", DbType.Int16, isDirect);
                dsGetRpId = db.ExecuteDataSet(dbGetRpId);

            }
            catch (BaseApplicationException ex)
            {
                throw ex;
            }
            catch (Exception ex)
            {
                BaseApplicationException baseEx = new BaseApplicationException(ex.Message, ex);
                NameValueCollection FunctionInfo = new NameValueCollection();
                FunctionInfo.Add("Method", "RiskProfileDao.cs:GetRpId()");
                object[] objects = new object[1];
                objects[0] = customerId;
                FunctionInfo = baseEx.AddObject(FunctionInfo, objects);
                baseEx.AdditionalInformation = FunctionInfo;
                ExceptionManager.Publish(baseEx);
                throw baseEx;
            }
            return dsGetRpId;
        }

        //Getting Asset allocation Rules

        public DataSet GetAssetAllocationRules(string riskclasscode, int adviserId)
        {
            Database db;
            DataSet dsGetAssetAllocationRules;
            DbCommand dbGetAssetAllocationRules;
            try
            {
                db = DatabaseFactory.CreateDatabase("wealtherp");
                dbGetAssetAllocationRules = db.GetStoredProcCommand("SP_GetAssetAllocationRules");
                db.AddInParameter(dbGetAssetAllocationRules, "@XRC_RiskClassCode", DbType.String, riskclasscode);
                db.AddInParameter(dbGetAssetAllocationRules, "@AdviserId", DbType.Int32, adviserId);
                dsGetAssetAllocationRules = db.ExecuteDataSet(dbGetAssetAllocationRules);

            }
            catch (BaseApplicationException ex)
            {
                throw ex;
            }
            catch (Exception ex)
            {
                BaseApplicationException baseEx = new BaseApplicationException(ex.Message, ex);
                NameValueCollection FunctionInfo = new NameValueCollection();
                FunctionInfo.Add("Method", "RiskProfileDao.cs:GetQuestionOption()");
                object[] objects = new object[1];
                objects[0] = riskclasscode;
                FunctionInfo = baseEx.AddObject(FunctionInfo, objects);
                baseEx.AdditionalInformation = FunctionInfo;
                ExceptionManager.Publish(baseEx);
                throw baseEx;
            }
            return dsGetAssetAllocationRules;

        }


        /// <summary>
        /// To Get Customers Recomonded Asset Allocation Data to bind the Recomonded asset allocation chart in Finance Profile
        /// </summary>
        /// Created by Vinayak Patil on 05-11-2011
        /// <param name="CustomerId"></param>
        /// <returns></returns>

        public DataSet GetAssetAllocationData(int CustomerId)
        {
            Database db;
            DataSet dsGetAssetAllocationData;
            DbCommand dbGetAssetAllocationData;
            try
            {
                db = DatabaseFactory.CreateDatabase("wealtherp");
                dbGetAssetAllocationData = db.GetStoredProcCommand("SP_GetCustomersRecomondedAssetAllocationData");
                db.AddInParameter(dbGetAssetAllocationData, "@CustomerId", DbType.Int32, CustomerId);
                dsGetAssetAllocationData = db.ExecuteDataSet(dbGetAssetAllocationData);

            }
            catch (BaseApplicationException ex)
            {
                throw ex;
            }
            catch (Exception ex)
            {
                BaseApplicationException baseEx = new BaseApplicationException(ex.Message, ex);
                NameValueCollection FunctionInfo = new NameValueCollection();
                FunctionInfo.Add("Method", "RiskProfileDao.cs:GetAssetAllocationData()");
                object[] objects = new object[1];
                objects[0] = CustomerId;
                FunctionInfo = baseEx.AddObject(FunctionInfo, objects);
                baseEx.AdditionalInformation = FunctionInfo;
                ExceptionManager.Publish(baseEx);
                throw baseEx;
            }
            return dsGetAssetAllocationData;
        }

        //Adding Asset allocation Details in dbo.CustomerAssetAllocation
        public void AddAssetAllocationDetails(int riskprofileid, int assetClassificationCode, double recommendedPercentage, double currentPercentage, DateTime clientapprovedon, RMVo rmvo)
        {
            Database db;
            DbCommand dbAddAssetAllocationDetails;
            try
            {
                db = DatabaseFactory.CreateDatabase("wealtherp");
                dbAddAssetAllocationDetails = db.GetStoredProcCommand("SP_AddAssetAllocationDetails");
                db.AddInParameter(dbAddAssetAllocationDetails, "@CRP_RiskProfileId", DbType.Int32, riskprofileid);
                db.AddInParameter(dbAddAssetAllocationDetails, "@WAC_AssetClassificationCode", DbType.Int32, assetClassificationCode);
                db.AddInParameter(dbAddAssetAllocationDetails, "@CAA_RecommendedPercentage", DbType.Double, recommendedPercentage);
                db.AddInParameter(dbAddAssetAllocationDetails, "@CAA_CurrentPercentage", DbType.Double, currentPercentage);
                db.AddInParameter(dbAddAssetAllocationDetails, "@CAA_ClientApprovedOn", DbType.DateTime, clientapprovedon);
                db.AddInParameter(dbAddAssetAllocationDetails, "@CAA_CreatedBy", DbType.Int32, rmvo.UserId);
                db.AddInParameter(dbAddAssetAllocationDetails, "@CAA_ModifiedBy", DbType.Int32, rmvo.UserId);
                db.ExecuteNonQuery(dbAddAssetAllocationDetails);

            }
            catch (BaseApplicationException ex)
            {
                throw ex;
            }
            catch (Exception ex)
            {
                BaseApplicationException baseEx = new BaseApplicationException(ex.Message, ex);
                NameValueCollection FunctionInfo = new NameValueCollection();
                FunctionInfo.Add("Method", "RiskProfileDao.cs:AddCustomerResponseToQuestion()");
                object[] objects = new object[1];
                objects[0] = riskprofileid;
                FunctionInfo = baseEx.AddObject(FunctionInfo, objects);
                baseEx.AdditionalInformation = FunctionInfo;
                ExceptionManager.Publish(baseEx);
                throw baseEx;
            }
        }

        public DataSet GetCustomerRiskProfile(int customerid,int advisorId, int isDirectType)
        {
            Database db;
            DataSet dsGetCustomerRiskProfile = null;
            DbCommand dbGetCustomerRiskProfile;
            try
            {
                db = DatabaseFactory.CreateDatabase("wealtherp");
                dbGetCustomerRiskProfile = db.GetStoredProcCommand("SP_GetCustomerRiskProfile");
                db.AddInParameter(dbGetCustomerRiskProfile, "@C_CustomerId", DbType.Int32, customerid);
                db.AddInParameter(dbGetCustomerRiskProfile, "@A_AdvisorId", DbType.Int32, advisorId);
                db.AddInParameter(dbGetCustomerRiskProfile, "@isDirectType", DbType.Int16, isDirectType);
                dsGetCustomerRiskProfile = db.ExecuteDataSet(dbGetCustomerRiskProfile);
            }
            catch (BaseApplicationException ex)
            {
                throw ex;
            }
            catch (Exception ex)
            {
                BaseApplicationException baseEx = new BaseApplicationException(ex.Message, ex);
                NameValueCollection FunctionInfo = new NameValueCollection();
                FunctionInfo.Add("Method", "RiskProfileDao.cs:GetQuestionOption()");
                object[] objects = new object[1];
                objects[0] = customerid;
                FunctionInfo = baseEx.AddObject(FunctionInfo, objects);
                baseEx.AdditionalInformation = FunctionInfo;
                ExceptionManager.Publish(baseEx);
                throw baseEx;
            }
            return dsGetCustomerRiskProfile;
        }

        public DataSet GetRiskClassForRisk(string riskclasscode)
        {
            Database db;
            DataSet dsGetOptionAndRiskClassForRisk = null;
            DbCommand dbGetOptionAndRiskClassForRisk;
            try
            {
                db = DatabaseFactory.CreateDatabase("wealtherp");
                dbGetOptionAndRiskClassForRisk = db.GetStoredProcCommand("SP_RiskClassForRisk");
                db.AddInParameter(dbGetOptionAndRiskClassForRisk, "@XRC_RiskClassCode", DbType.String, riskclasscode);
                dsGetOptionAndRiskClassForRisk = db.ExecuteDataSet(dbGetOptionAndRiskClassForRisk);

            }
            catch (BaseApplicationException ex)
            {
                throw ex;
            }
            catch (Exception ex)
            {
                BaseApplicationException baseEx = new BaseApplicationException(ex.Message, ex);
                NameValueCollection FunctionInfo = new NameValueCollection();
                FunctionInfo.Add("Method", "RiskProfileDao.cs:GetQuestionOption()");
                object[] objects = new object[2];
                objects[1] = riskclasscode;
                FunctionInfo = baseEx.AddObject(FunctionInfo, objects);
                baseEx.AdditionalInformation = FunctionInfo;
                ExceptionManager.Publish(baseEx);
                throw baseEx;
            }
            return dsGetOptionAndRiskClassForRisk;
        }

        public DataSet GetAssetAllocationDetails(int riskprofileid)
        {
            Database db;
            DataSet dsGetAssetAllocationDetails = null;
            DbCommand dbGetAssetAllocationDetails;
            try
            {
                db = DatabaseFactory.CreateDatabase("wealtherp");
                dbGetAssetAllocationDetails = db.GetStoredProcCommand("SP_GetAssetAllocationDetails");
                db.AddInParameter(dbGetAssetAllocationDetails, "@CRP_RiskProfileId", DbType.Int32, riskprofileid);
                dsGetAssetAllocationDetails = db.ExecuteDataSet(dbGetAssetAllocationDetails);

            }
            catch (BaseApplicationException ex)
            {
                throw ex;
            }
            catch (Exception ex)
            {
                BaseApplicationException baseEx = new BaseApplicationException(ex.Message, ex);
                NameValueCollection FunctionInfo = new NameValueCollection();
                FunctionInfo.Add("Method", "RiskProfileDao.cs:GetQuestionOption()");
                object[] objects = new object[1];
                objects[0] = riskprofileid;
                FunctionInfo = baseEx.AddObject(FunctionInfo, objects);
                baseEx.AdditionalInformation = FunctionInfo;
                ExceptionManager.Publish(baseEx);
                throw baseEx;
            }
            return dsGetAssetAllocationDetails;
        }

        public void UpdateAssetAllocationDetails(int riskprofileid, int assetClassificationCode, double recommendedPercentage, double currentPercentage, DateTime clientapprovedon, RMVo rmvo)
        {
            Database db;
            DbCommand dbUpdateAssetAllocationDetails;
            try
            {
                db = DatabaseFactory.CreateDatabase("wealtherp");
                dbUpdateAssetAllocationDetails = db.GetStoredProcCommand("SP_UpdateAssetAllocationDetails");              

                db.AddInParameter(dbUpdateAssetAllocationDetails, "@CRP_RiskProfileId", DbType.Int32, riskprofileid);
                db.AddInParameter(dbUpdateAssetAllocationDetails, "@WAC_AssetClassificationCode", DbType.Int32, assetClassificationCode);
                db.AddInParameter(dbUpdateAssetAllocationDetails, "@CAA_RecommendedPercentage", DbType.Double, recommendedPercentage);
                db.AddInParameter(dbUpdateAssetAllocationDetails, "@CAA_CurrentPercentage", DbType.Double, currentPercentage);
                db.AddInParameter(dbUpdateAssetAllocationDetails, "@CAA_ClientApprovedOn", DbType.DateTime, clientapprovedon);              
                db.AddInParameter(dbUpdateAssetAllocationDetails, "@CAA_ModifiedBy", DbType.Int32, rmvo.UserId);
                db.ExecuteNonQuery(dbUpdateAssetAllocationDetails);

            }
            catch (BaseApplicationException ex)
            {
                throw ex;
            }
            catch (Exception ex)
            {
                BaseApplicationException baseEx = new BaseApplicationException(ex.Message, ex);
                NameValueCollection FunctionInfo = new NameValueCollection();
                FunctionInfo.Add("Method", "RiskProfileDao.cs:AddCustomerResponseToQuestion()");
                object[] objects = new object[1];
                objects[0] = riskprofileid;
                FunctionInfo = baseEx.AddObject(FunctionInfo, objects);
                baseEx.AdditionalInformation = FunctionInfo;
                ExceptionManager.Publish(baseEx);
                throw baseEx;
            }

        }
        /// <summary>
        /// Its gives the All Assets for a paticular Customer
        /// </summary>
        /// <param name="customerId"></param>
        /// <returns></returns>
        public DataSet GetCustomerAssets(int customerId,int isProspect)
        {
            Database db;
            DataSet dsGetCustomerAsset;
            DbCommand dbGetCustomerAsset;
            try
            {
                db = DatabaseFactory.CreateDatabase("wealtherp");
                dbGetCustomerAsset = db.GetStoredProcCommand("SP_GetCustomerAssets");
                db.AddInParameter(dbGetCustomerAsset, "@CustomerId", DbType.Int32, customerId);
                db.AddInParameter(dbGetCustomerAsset, "@IsProspect", DbType.String, isProspect.ToString());
                dsGetCustomerAsset = db.ExecuteDataSet(dbGetCustomerAsset);

            }
            catch (BaseApplicationException ex)
            {
                throw ex;
            }
            catch (Exception ex)
            {
                BaseApplicationException baseEx = new BaseApplicationException(ex.Message, ex);
                NameValueCollection FunctionInfo = new NameValueCollection();
                FunctionInfo.Add("Method", "RiskProfileDao.cs:GetCustomerAssets()");
                object[] objects = new object[1];
                objects[0] = customerId;
                FunctionInfo = baseEx.AddObject(FunctionInfo, objects);
                baseEx.AdditionalInformation = FunctionInfo;
                ExceptionManager.Publish(baseEx);
                throw baseEx;
            }
            return dsGetCustomerAsset;
        }

        /// <summary>
        /// To Get all The Riskclasses for Advisers..
        /// </summary>
        /// Created by Vinayak Patil.
        /// <param name="adviserId"></param>
        /// <returns></returns>
        public DataSet GetAdviserRiskClasses(int adviserId)
        {
            Database db;
            DbCommand getAdviserRiskClassesCmd;
            DataSet dsAdviserRiskClasses = null;

            try
            {
                db = DatabaseFactory.CreateDatabase("wealtherp");
                getAdviserRiskClassesCmd = db.GetStoredProcCommand("SP_GetAdviserRiskClasses");
                db.AddInParameter(getAdviserRiskClassesCmd, "@adviserId", DbType.Int16, adviserId);
                dsAdviserRiskClasses = db.ExecuteDataSet(getAdviserRiskClassesCmd);
                //if (dsAdviserRiskClasses.Tables[0].Rows.Count == 0)
                //{
                //    getAdviserRiskClassesCmd = db.GetStoredProcCommand("SP_GetAdviserRiskClasses");
                //    db.AddInParameter(getAdviserRiskClassesCmd, "@adviserId", DbType.Int16, 1000);
                //    dsAdviserRiskClasses = db.ExecuteDataSet(getAdviserRiskClassesCmd);
                //}
            }
            catch (BaseApplicationException Ex)
            {
                throw Ex;
            }
            catch (Exception Ex)
            {
                BaseApplicationException exBase = new BaseApplicationException(Ex.Message, Ex);
                NameValueCollection FunctionInfo = new NameValueCollection();
                FunctionInfo.Add("Method", "RiskProfileDao.cs:GetAdviserRiskClasses()");
                object[] objects = new object[2];
                objects[0] = adviserId;
                FunctionInfo = exBase.AddObject(FunctionInfo, objects);
                exBase.AdditionalInformation = FunctionInfo;
                ExceptionManager.Publish(exBase);
                throw exBase;
            }
            return dsAdviserRiskClasses;
        }

        ///// <summary>
        ///// To Get Customers Recomonded Asset Allocation Data to bind the Asset allocation Gridview in Finance Profile
        ///// </summary>
        ///// Created by Bhoopendra Prakash Sahoo on 02-08-2011
        ///// <param name="AdvisorId"></param>
        ///// <param name="CustomerId"></param>
        ///// <returns></returns>

        //public DataSet GetAssetAllocationTableData(int AdvisorId, int CustomerId)
        //{
        //    Database db;
        //    DataSet dsAssetAllocation;
        //    DbCommand cmdAssetAllocation;
        //    try
        //    {
        //        db = DatabaseFactory.CreateDatabase("wealtherp");
        //        cmdAssetAllocation = db.GetStoredProcCommand("SP_RPT_GetFPReportDetails");
        //        db.AddInParameter(cmdAssetAllocation, "@AdvisorId", DbType.Int32, AdvisorId);
        //        db.AddInParameter(cmdAssetAllocation, "@CustomerId", DbType.Int32, CustomerId);
        //        db.AddOutParameter(cmdAssetAllocation, "@RiskClass", DbType.String, 50);
        //        db.AddOutParameter(cmdAssetAllocation, "@InsuranceSUMAssured", DbType.Decimal, 20);
        //        db.AddOutParameter(cmdAssetAllocation, "@AssetTotal", DbType.Decimal, 20);
        //        db.AddOutParameter(cmdAssetAllocation, "@DynamicRiskClsaaAdvisor", DbType.Int32, 2);
        //        db.AddOutParameter(cmdAssetAllocation, "@FinancialAssetToal", DbType.Int32, 2);
        //        dsAssetAllocation = db.ExecuteDataSet(cmdAssetAllocation);

        //    }
        //    catch (BaseApplicationException ex)
        //    {
        //        throw ex;
        //    }
        //    catch (Exception ex)
        //    {
        //        BaseApplicationException baseEx = new BaseApplicationException(ex.Message, ex);
        //        NameValueCollection FunctionInfo = new NameValueCollection();
        //        FunctionInfo.Add("Method", "RiskProfileDao.cs:GetAssetAllocationTableData()");
        //        object[] objects = new object[2];
        //        objects[0] = AdvisorId;
        //        objects[1] = CustomerId;
        //        FunctionInfo = baseEx.AddObject(FunctionInfo, objects);
        //        baseEx.AdditionalInformation = FunctionInfo;
        //        ExceptionManager.Publish(baseEx);
        //        throw baseEx;
        //    }
        //    return dsAssetAllocation;
        //}

        ///// <summary>
        ///// Adding Customer Risk profile directly by DP
        ///// </summary>
        ///// Dev by: VInayak Patil.
        ///// <param name="customerId"></param>
        ///// <param name="riskdate"></param>
        ///// <param name="riskclasscode"></param>
        ///// <param name="rmvo"></param>
        //public void AddCustomerRiskProfileDetailsDirectlyBYDP(int customerId, DateTime riskdate, string riskclasscode, RMVo rmvo, int IsDirectRiskClass)
        //{
        //    Database db;
        //    DbCommand dbAddCustomerRiskProfileDetailsDirectlyBYDP;
        //    try
        //    {
        //        db = DatabaseFactory.CreateDatabase("wealtherp");
        //        dbAddCustomerRiskProfileDetailsDirectlyBYDP = db.GetStoredProcCommand("SP_AddCustomerRiskProfileDetails");
        //        db.AddInParameter(dbAddCustomerRiskProfileDetailsDirectlyBYDP, "@C_CustomerId", DbType.Int32, customerId);
        //        db.AddInParameter(dbAddCustomerRiskProfileDetailsDirectlyBYDP, "@CRP_Date", DbType.DateTime, riskdate);
        //        db.AddInParameter(dbAddCustomerRiskProfileDetailsDirectlyBYDP, "@XRC_RiskClassCode", DbType.String, riskclasscode);
        //        db.AddInParameter(dbAddCustomerRiskProfileDetailsDirectlyBYDP, "@CRP_CreatedBy", DbType.Int32, rmvo.RMId);
        //        db.AddInParameter(dbAddCustomerRiskProfileDetailsDirectlyBYDP, "@CRP_ModifiedBy", DbType.Int32, rmvo.RMId);
        //        db.AddOutParameter(dbAddCustomerRiskProfileDetailsDirectlyBYDP, "@RPId", DbType.Int32, 1000);
        //        db.AddInParameter(dbAddCustomerRiskProfileDetailsDirectlyBYDP, "@CRP_IsDirectRiskClass", DbType.Int32, 1);
        //        db.ExecuteNonQuery(dbAddCustomerRiskProfileDetailsDirectlyBYDP);

        //    }
        //    catch (BaseApplicationException ex)
        //    {
        //        throw ex;
        //    }
        //    catch (Exception ex)
        //    {
        //        BaseApplicationException baseEx = new BaseApplicationException(ex.Message, ex);
        //        NameValueCollection FunctionInfo = new NameValueCollection();
        //        FunctionInfo.Add("Method", "RiskProfileDao.cs:GetQuestionOption()");
        //        object[] objects = new object[1];
        //        objects[0] = customerId;
        //        FunctionInfo = baseEx.AddObject(FunctionInfo, objects);
        //        baseEx.AdditionalInformation = FunctionInfo;
        //        ExceptionManager.Publish(baseEx);
        //        throw baseEx;
        //    }

        //}

        public DataSet GetModelPortFolio(int customerId, string riskCode, int isRiskModel)
        {
            Database db;
            DbCommand dbGetModelPortFolio = null;
            DataSet dsGetModelPortFolio = null;
            try
            {
                db = DatabaseFactory.CreateDatabase("wealtherp");
                dbGetModelPortFolio = db.GetStoredProcCommand("SP_GetModelPortFolio");
                db.AddInParameter(dbGetModelPortFolio, "@CustomerId", DbType.Int32, customerId);
                db.AddInParameter(dbGetModelPortFolio, "@riskCode", DbType.String, riskCode);
                db.AddInParameter(dbGetModelPortFolio, "@XAMP_IsRiskModel", DbType.Int16, isRiskModel);
                
                dsGetModelPortFolio = db.ExecuteDataSet(dbGetModelPortFolio);
            }
            catch (BaseApplicationException ex)
            {
                throw ex;
            }
            catch (Exception ex)
            {
                BaseApplicationException baseEx = new BaseApplicationException(ex.Message, ex);
                NameValueCollection FunctionInfo = new NameValueCollection();
                FunctionInfo.Add("Method", "RiskProfileDao.cs:GetModelPortFolio()");
                throw baseEx;
            }
            return dsGetModelPortFolio;
        }
        public DataSet GetAssetAllocationMIS(string userType, int advisorId, int rmId, int customerId, int branchHeadId, int branchId, int All, int isGroup)
        {
            Database db;
            DataSet dsAssetAllocationMIS;
            DbCommand dbAssetAllocationMISCmd;
            try
            {
                db = DatabaseFactory.CreateDatabase("wealtherp");
                dbAssetAllocationMISCmd = db.GetStoredProcCommand("SP_GetAssetAllocationMIS");
                db.AddInParameter(dbAssetAllocationMISCmd, "@userType", DbType.String, userType);
                db.AddInParameter(dbAssetAllocationMISCmd, "@adviserId", DbType.Int32, advisorId);
                db.AddInParameter(dbAssetAllocationMISCmd, "@BranchId", DbType.Int32, branchId);
                db.AddInParameter(dbAssetAllocationMISCmd, "@RmId", DbType.Int32, rmId);
                db.AddInParameter(dbAssetAllocationMISCmd, "@BranchHeadId", DbType.Int32, branchHeadId);
                db.AddInParameter(dbAssetAllocationMISCmd, "@CustomerId", DbType.Int32, customerId);
                db.AddInParameter(dbAssetAllocationMISCmd, "@IsGroup", DbType.Int16, isGroup);
                db.AddInParameter(dbAssetAllocationMISCmd, "@all", DbType.Int32, All);
                dsAssetAllocationMIS = db.ExecuteDataSet(dbAssetAllocationMISCmd);

            }
            catch (BaseApplicationException ex)
            {
                throw ex;
            }

            return dsAssetAllocationMIS;
        }
        public DataSet GetFPUtilityUserDetailsList(DateTime fromDate, DateTime toDate)
        {
            Database db;
            DataSet ds;
            DbCommand cmd;
            try
            {
                db = DatabaseFactory.CreateDatabase("wealtherp");
                cmd = db.GetStoredProcCommand("SPROC_GetFPUtilityUserDetailsList");
                db.AddInParameter(cmd, "@FromDate", DbType.DateTime, fromDate);
                db.AddInParameter(cmd, "@Todate", DbType.DateTime, toDate);
                ds = db.ExecuteDataSet(cmd);

            }
            catch (BaseApplicationException ex)
            {
                throw ex;
            }

            return ds;
        }
    }
}