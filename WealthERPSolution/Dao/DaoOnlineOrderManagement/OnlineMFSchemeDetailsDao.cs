﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Collections;
using System.Data.Sql;
using VoOnlineOrderManagemnet;
using Microsoft.Practices.EnterpriseLibrary.Data;
using System.Data.Common;
using Microsoft.ApplicationBlocks.ExceptionManagement;
using System.Collections.Specialized;

namespace DaoOnlineOrderManagement
{
    public class OnlineMFSchemeDetailsDao
    {
        OnlineMFSchemeDetailsVo OnlineMFSchemeDetailsVo = new OnlineMFSchemeDetailsVo();
        public OnlineMFSchemeDetailsVo GetSchemeDetails(int amcCode, int schemeCode, string category, out DataTable dtNavDetails)
        {
            Database db;
            DataSet GetSchemeDetailsDs;
            DbCommand GetSchemeDetailsCmd;
            try
            {
                db = DatabaseFactory.CreateDatabase("wealtherp");
                GetSchemeDetailsCmd = db.GetStoredProcCommand("SPROC_Onl_GetMFSchemeDetails");
                db.AddInParameter(GetSchemeDetailsCmd, "@amcCode", DbType.Int32, amcCode);
                db.AddInParameter(GetSchemeDetailsCmd, "@schemePlanCode", DbType.Int32, schemeCode);
                if (category != "0")
                    db.AddInParameter(GetSchemeDetailsCmd, "@category", DbType.String, category);

                GetSchemeDetailsDs = db.ExecuteDataSet(GetSchemeDetailsCmd);
                dtNavDetails = GetSchemeDetailsDs.Tables[1];
                if (GetSchemeDetailsDs.Tables[0].Rows.Count > 0)
                {
                    foreach (DataRow dr in GetSchemeDetailsDs.Tables[0].Rows)
                    {
                        OnlineMFSchemeDetailsVo.amcName = dr["PA_AMCName"].ToString();
                        OnlineMFSchemeDetailsVo.schemeName = dr["PASP_SchemePlanName"].ToString();
                        OnlineMFSchemeDetailsVo.fundManager = dr["PMFRD_FundManagerName"].ToString();
                        OnlineMFSchemeDetailsVo.schemeBanchMark = dr["PMFRD_BenchmarksIndexName"].ToString();
                        OnlineMFSchemeDetailsVo.category = dr["PAIC_AssetInstrumentCategoryName"].ToString();
                        OnlineMFSchemeDetailsVo.exitLoad = int.Parse(dr["PASPD_ExitLoadPercentage"].ToString());
                        if (dr["PMFRD_EquityStyleBoxLong"].ToString() != "")
                            OnlineMFSchemeDetailsVo.schemeBox = int.Parse(dr["PMFRD_EquityStyleBoxLong"].ToString());
                        if (dr["PMFRD_FixedIncStyleBoxLong"].ToString() != "")
                            OnlineMFSchemeDetailsVo.schemeBoxFixed = int.Parse(dr["PMFRD_FixedIncStyleBoxLong"].ToString());
                        OnlineMFSchemeDetailsVo.SchemeReturn3Year = dr["SchemeReturn3Year"].ToString();
                        OnlineMFSchemeDetailsVo.SchemeReturn5Year = dr["SchemeReturn5Year"].ToString();
                        OnlineMFSchemeDetailsVo.SchemeReturn10Year = dr["SchemeReturn10Year"].ToString();
                        OnlineMFSchemeDetailsVo.benchmarkReturn1stYear = dr["PMFRD_Return1Year_BM"].ToString();
                        OnlineMFSchemeDetailsVo.benchmark3rhYear = dr["PMFRD_Return3Year_BM"].ToString();
                        OnlineMFSchemeDetailsVo.benchmark5thdYear = dr["PMFRD_Return5Year_BM"].ToString();
                        if (dr["SchemeRisk3Year"].ToString() != "")
                            OnlineMFSchemeDetailsVo.SchemeRisk3Year = dr["SchemeRisk3Year"].ToString();
                        if (dr["SchemeRisk5Year"].ToString() != "")
                            OnlineMFSchemeDetailsVo.SchemeRisk5Year = dr["SchemeRisk5Year"].ToString();
                        if (dr["SchemeRisk10Year"].ToString() != "")
                            OnlineMFSchemeDetailsVo.SchemeRisk10Year = dr["SchemeRisk10Year"].ToString();
                        if (dr["PASPD_IsPurchaseAvailable"].ToString() == "True")
                            OnlineMFSchemeDetailsVo.isPurchaseAvaliable = 1;
                        if (dr["PASPD_IsRedeemAvailable"].ToString() == "True")
                            OnlineMFSchemeDetailsVo.isRedeemAvaliable = 1;
                        if (dr["PASPD_IsSIPAvailable"].ToString() == "True")
                            OnlineMFSchemeDetailsVo.isSIPAvaliable = 1;
                        OnlineMFSchemeDetailsVo.SchemeRating3Year = int.Parse(dr["SchemeRating3Year"].ToString());
                        OnlineMFSchemeDetailsVo.SchemeRating5Year = int.Parse(dr["SchemeRating5Year"].ToString());
                        OnlineMFSchemeDetailsVo.SchemeRating10Year = int.Parse(dr["SchemeRating10Year"].ToString());
                        OnlineMFSchemeDetailsVo.minmumInvestmentAmount = int.Parse(dr["PASPD_InitialPurchaseAmount"].ToString());
                        OnlineMFSchemeDetailsVo.multipleOf = int.Parse(dr["PASPD_InitialMultipleAmount"].ToString());
                        OnlineMFSchemeDetailsVo.minSIPInvestment = int.Parse(dr["PASPSD_MinAmount"].ToString());
                        OnlineMFSchemeDetailsVo.SIPmultipleOf = int.Parse(dr["PASPSD_MultipleAmount"].ToString());
                        OnlineMFSchemeDetailsVo.mornigStar = int.Parse(dr["SchemeRatingOverall"].ToString());
                        OnlineMFSchemeDetailsVo.overAllRating = int.Parse(dr["SchemeRatingOverall"].ToString());
                        OnlineMFSchemeDetailsVo.navDate = dr["PASPSP_Date"].ToString();
                        if (dr["CMFNP_CurrentValue"].ToString() != "")
                            OnlineMFSchemeDetailsVo.NAV = Convert.ToDecimal(dr["CMFNP_CurrentValue"]);
                    }
                }
            }
            catch (BaseApplicationException Ex)
            {
                throw Ex;
            }
            return OnlineMFSchemeDetailsVo;
        }
        public bool DeleteSchemeFromCustomerWatch(int schemeCode, int customerId, string productType)
        {
            bool bResult = false;
            Database db;
            DbCommand createCmd;
            try
            {
                db = DatabaseFactory.CreateDatabase("wealtherp");
                createCmd = db.GetStoredProcCommand("SPROC_ONL_DeleteProductFromWatchList");
                db.AddInParameter(createCmd, "@customerId", DbType.Int32, customerId);
                db.AddInParameter(createCmd, "@productId", DbType.Int32, schemeCode);
                db.AddInParameter(createCmd, "@productType", DbType.String, productType);
                if (db.ExecuteNonQuery(createCmd) != 0)
                    bResult = true;
                else
                    bResult = false;
            }
            catch (BaseApplicationException Ex)
            {
                throw Ex;
            }
            catch (Exception Ex)
            {
                BaseApplicationException exBase = new BaseApplicationException(Ex.Message, Ex);
                NameValueCollection FunctionInfo = new NameValueCollection();
                FunctionInfo.Add("Method", "DeleteSchemeFromCustomerWatch(int schemeCode, int customerId,string productType)");
                object[] objects = new object[3];
                objects[0] = customerId;
                objects[1] = schemeCode;
                FunctionInfo = exBase.AddObject(FunctionInfo, objects);
                exBase.AdditionalInformation = FunctionInfo;
                ExceptionManager.Publish(exBase);
                throw exBase;

            }
            return bResult;
        }
        public bool CustomerAddMFSchemeToWatch(int customerId, int schemeCode, string assetGroup, int userId)
        {
            bool bResult = false;
            Database db;
            DbCommand createCmd;
            try
            {
                db = DatabaseFactory.CreateDatabase("wealtherp");
                createCmd = db.GetStoredProcCommand("SPROC_ONL_AddProductToCustomerWatchList");
                db.AddInParameter(createCmd, "@customerId", DbType.Int32, customerId);
                db.AddInParameter(createCmd, "@productId", DbType.Int32, schemeCode);
                db.AddInParameter(createCmd, "@assetGroup", DbType.String, assetGroup);
                db.AddInParameter(createCmd, "@userId", DbType.Int64, userId);
                if (db.ExecuteNonQuery(createCmd) != 0)
                    bResult = true;
                else
                    bResult = false;
            }
            catch (BaseApplicationException Ex)
            {
                throw Ex;
            }
            catch (Exception Ex)
            {
                BaseApplicationException exBase = new BaseApplicationException(Ex.Message, Ex);
                NameValueCollection FunctionInfo = new NameValueCollection();
                FunctionInfo.Add("Method", "OnlineMFSchemeDetailsDao.cs:CustomerAddMFSchemeToWatch()");
                object[] objects = new object[3];
                objects[0] = customerId;
                objects[1] = schemeCode;
                objects[2] = assetGroup;
                objects[3] = userId;
                FunctionInfo = exBase.AddObject(FunctionInfo, objects);
                exBase.AdditionalInformation = FunctionInfo;
                ExceptionManager.Publish(exBase);
                throw exBase;

            }
            return bResult;
        }


        public string GetCmotCode(int schemeplanCode)
        {
            Database db;
            DataSet ds;
            DbCommand cmdGetCmotCode;
            string cmotCode = string.Empty;
            try
            {
                db = DatabaseFactory.CreateDatabase("wealtherp");
                //checking year
                cmdGetCmotCode = db.GetStoredProcCommand("SPROC_Onl_GetCMOTCode");
                db.AddInParameter(cmdGetCmotCode, "@schemePlanCode", DbType.Int32, schemeplanCode);
                db.AddOutParameter(cmdGetCmotCode, "@CMOTCode", DbType.String, 20);
                ds = db.ExecuteDataSet(cmdGetCmotCode);
                if (db.ExecuteNonQuery(cmdGetCmotCode) != 0)
                {
                    cmotCode = db.GetParameterValue(cmdGetCmotCode, "cmotCode").ToString();
                }
            }
            catch (BaseApplicationException Ex)
            {
                throw Ex;
            }
            return cmotCode;
        }

        public List<OnlineMFSchemeDetailsVo> GetCompareMFSchemeDetails(string schemeCompareList, int exchangeType)
        {
            List<OnlineMFSchemeDetailsVo> onlineMFSchemeDetailsList = new List<OnlineMFSchemeDetailsVo>();
            Database db;
            DataSet GetSchemeDetailsDs;
            DbCommand GetSchemeDetailsCmd;
            try
            {
                db = DatabaseFactory.CreateDatabase("wealtherp");
                GetSchemeDetailsCmd = db.GetStoredProcCommand("SPROC_Onl_GetMFSchemeCompareDetails");
                db.AddInParameter(GetSchemeDetailsCmd, "@schemePlanCode", DbType.String, schemeCompareList);
                db.AddInParameter(GetSchemeDetailsCmd, "@exchangeType", DbType.Int32, exchangeType);
                GetSchemeDetailsDs = db.ExecuteDataSet(GetSchemeDetailsCmd);
                if (GetSchemeDetailsDs.Tables[0].Rows.Count > 0)
                {
                    foreach (DataRow dr in GetSchemeDetailsDs.Tables[0].Rows)
                    {
                        OnlineMFSchemeDetailsVo.amcName = dr["PA_AMCName"].ToString();
                        OnlineMFSchemeDetailsVo.schemeName = dr["PASP_SchemePlanName"].ToString();
                        if (!string.IsNullOrEmpty(dr["PMFRD_FundManagerName"].ToString()))
                            OnlineMFSchemeDetailsVo.fundManager = dr["PMFRD_FundManagerName"].ToString();
                        if (!string.IsNullOrEmpty(dr["PMFRD_BenchmarksIndexName"].ToString()))
                            OnlineMFSchemeDetailsVo.schemeBanchMark = dr["PMFRD_BenchmarksIndexName"].ToString();
                        if (!string.IsNullOrEmpty(dr["PAIC_AssetInstrumentCategoryName"].ToString()))
                            OnlineMFSchemeDetailsVo.category = dr["PAIC_AssetInstrumentCategoryName"].ToString();
                        if (!string.IsNullOrEmpty(dr["PASPD_ExitLoadPercentage"].ToString()))
                            OnlineMFSchemeDetailsVo.exitLoad = int.Parse(dr["PASPD_ExitLoadPercentage"].ToString());
                        if (!string.IsNullOrEmpty(dr["PMFRD_FixedIncStyleBoxLong"].ToString()))
                            OnlineMFSchemeDetailsVo.schemeBox = int.Parse(dr["PMFRD_FixedIncStyleBoxLong"].ToString());
                        if (!string.IsNullOrEmpty(dr["SchemeReturn3Year"].ToString()))

                            OnlineMFSchemeDetailsVo.SchemeReturn3Year = dr["SchemeReturn3Year"].ToString();
                        if (!string.IsNullOrEmpty(dr["SchemeReturn5Year"].ToString()))

                            OnlineMFSchemeDetailsVo.SchemeReturn5Year = dr["SchemeReturn5Year"].ToString();
                        if (!string.IsNullOrEmpty(dr["SchemeReturn10Year"].ToString()))

                            OnlineMFSchemeDetailsVo.SchemeReturn10Year = dr["SchemeReturn10Year"].ToString();
                        if (!string.IsNullOrEmpty(dr["PMFRD_Return1Year_BM"].ToString()))

                            OnlineMFSchemeDetailsVo.benchmarkReturn1stYear = dr["PMFRD_Return1Year_BM"].ToString();
                        if (!string.IsNullOrEmpty(dr["PMFRD_Return3Year_BM"].ToString()))

                            OnlineMFSchemeDetailsVo.benchmark3rhYear = dr["PMFRD_Return3Year_BM"].ToString();
                        if (!string.IsNullOrEmpty(dr["PMFRD_Return5Year_BM"].ToString()))

                            OnlineMFSchemeDetailsVo.benchmark5thdYear = dr["PMFRD_Return5Year_BM"].ToString();
                        if (dr["SchemeRisk3Year"].ToString() != "")
                            OnlineMFSchemeDetailsVo.SchemeRisk3Year = dr["SchemeRisk3Year"].ToString();
                        if (dr["SchemeRisk5Year"].ToString() != "")
                            OnlineMFSchemeDetailsVo.SchemeRisk5Year = dr["SchemeRisk5Year"].ToString();
                        if (dr["SchemeRisk10Year"].ToString() != "")
                            OnlineMFSchemeDetailsVo.SchemeRisk10Year = dr["SchemeRisk10Year"].ToString();
                        if (dr["PASPD_IsPurchaseAvailable"].ToString() == "True")
                            OnlineMFSchemeDetailsVo.isPurchaseAvaliable = 1;
                        if (dr["PASPD_IsRedeemAvailable"].ToString() == "True")
                            OnlineMFSchemeDetailsVo.isRedeemAvaliable = 1;
                        if (dr["PASPD_IsSIPAvailable"].ToString() == "True")
                            OnlineMFSchemeDetailsVo.isSIPAvaliable = 1;
                        if (!string.IsNullOrEmpty(dr["PASPD_InitialPurchaseAmount"].ToString()))

                            OnlineMFSchemeDetailsVo.minmumInvestmentAmount = int.Parse(dr["PASPD_InitialPurchaseAmount"].ToString());
                        if (!string.IsNullOrEmpty(dr["PASPD_InitialMultipleAmount"].ToString()))

                            OnlineMFSchemeDetailsVo.multipleOf = int.Parse(dr["PASPD_InitialMultipleAmount"].ToString());
                        if (!string.IsNullOrEmpty(dr["PASPSD_MinAmount"].ToString()))

                            OnlineMFSchemeDetailsVo.minSIPInvestment = int.Parse(dr["PASPSD_MinAmount"].ToString());
                        if (!string.IsNullOrEmpty(dr["PASPSD_MultipleAmount"].ToString()))

                            OnlineMFSchemeDetailsVo.SIPmultipleOf = int.Parse(dr["PASPSD_MultipleAmount"].ToString());
                        if (!string.IsNullOrEmpty(dr["SchemeRatingOverall"].ToString()))

                            OnlineMFSchemeDetailsVo.overAllRating = int.Parse(dr["SchemeRatingOverall"].ToString());

                        OnlineMFSchemeDetailsVo.navDate = dr["PASPSP_Date"].ToString();
                        if (dr["CMFNP_CurrentValue"].ToString() != "")
                            OnlineMFSchemeDetailsVo.NAV = Convert.ToDecimal(dr["CMFNP_CurrentValue"]);
                        onlineMFSchemeDetailsList.Add(OnlineMFSchemeDetailsVo);

                    }
                }
            }
            catch (BaseApplicationException Ex)
            {
                throw Ex;
            }
            return onlineMFSchemeDetailsList;
        }
        public DataSet GetSIPCustomeSchemePlan(int customerId, int AMCCode, int exchangeType)
        {
            DataSet dsGetSIPCustomeSchemePlan;
            Database db;
            DbCommand GetSIPCustomeSchemePlancmd;
            try
            {
                db = DatabaseFactory.CreateDatabase("wealtherp");
                GetSIPCustomeSchemePlancmd = db.GetStoredProcCommand("SPROC_Onl_CustomerOrderSchemePlan");
                db.AddInParameter(GetSIPCustomeSchemePlancmd, "@customerId", DbType.Int32, customerId);
                db.AddInParameter(GetSIPCustomeSchemePlancmd, "@AMCCode", DbType.Int32, AMCCode);
                db.AddInParameter(GetSIPCustomeSchemePlancmd, "@exchangeType", DbType.Int32, exchangeType);
                dsGetSIPCustomeSchemePlan = db.ExecuteDataSet(GetSIPCustomeSchemePlancmd);
            }
            catch (BaseApplicationException Ex)
            {
                throw (Ex);
            }
            return dsGetSIPCustomeSchemePlan;
        }
        public DataTable GetAMCandCategoryWiseScheme(int AMCCode, string category, int exchangeType)
        {
            Database db;
            DbCommand GetdtGetAMCandCategoryWiseScheme;
            DataTable dtGetAMCandCategoryWiseScheme;
            DataSet dsGetAMCandCategoryWiseScheme;
            try
            {
                db = DatabaseFactory.CreateDatabase("wealtherp");
                GetdtGetAMCandCategoryWiseScheme = db.GetStoredProcCommand("SPROC_ONL_GetAMCandCategoryWiseScheme");
                db.AddInParameter(GetdtGetAMCandCategoryWiseScheme, "@amcCode", DbType.Int32, AMCCode);
                if (category != "0")
                    db.AddInParameter(GetdtGetAMCandCategoryWiseScheme, "@category", DbType.String, category);
                db.AddInParameter(GetdtGetAMCandCategoryWiseScheme, "@exchangeType", DbType.Int32, exchangeType);


                dsGetAMCandCategoryWiseScheme = db.ExecuteDataSet(GetdtGetAMCandCategoryWiseScheme);
                dtGetAMCandCategoryWiseScheme = dsGetAMCandCategoryWiseScheme.Tables[0];
            }
            catch (BaseApplicationException Ex)
            {
                throw (Ex);
            }
            catch (Exception Ex)
            {
                BaseApplicationException exBase = new BaseApplicationException(Ex.Message, Ex);
                NameValueCollection FunctionInfo = new NameValueCollection();
                FunctionInfo.Add("Method", "OnlineMFSchemeDetailsDao.cs:GetAMCandCategoryWiseScheme(int AMCCode,string category)");
                object[] objects = new object[2];
                objects[0] = AMCCode;
                objects[1] = category;
                FunctionInfo = exBase.AddObject(FunctionInfo, objects);
                exBase.AdditionalInformation = FunctionInfo;
                ExceptionManager.Publish(exBase);
                throw exBase;

            }
            return dtGetAMCandCategoryWiseScheme;
        }



        public static DataTable GetSchemeNavHistory(int schemePlanCode, DateTime? fromDate, DateTime? toDate)
        {
            Database db;
            DbCommand GetSchemeNavHistorycmd;
            DataSet dsdtGetSchemeNavHistory;
            try
            {
                db = DatabaseFactory.CreateDatabase("wealtherp");
                GetSchemeNavHistorycmd = db.GetStoredProcCommand("SPROC_ONL_GetSchemeNavHistory");
                db.AddInParameter(GetSchemeNavHistorycmd, "@SchemePlanCode", DbType.Int32, schemePlanCode);
                db.AddInParameter(GetSchemeNavHistorycmd, "@FromDate", DbType.Date, fromDate);
                db.AddInParameter(GetSchemeNavHistorycmd, "@ToDate", DbType.Date, toDate);
                dsdtGetSchemeNavHistory = db.ExecuteDataSet(GetSchemeNavHistorycmd);

            }
            catch (BaseApplicationException Ex)
            {
                throw (Ex);
            }
            catch (Exception Ex)
            {
                BaseApplicationException exBase = new BaseApplicationException(Ex.Message, Ex);
                NameValueCollection FunctionInfo = new NameValueCollection();
                FunctionInfo.Add("Method", "OnlineMFSchemeDetailsDao.cs:GetSchemeNavHistory(int schemePlanCode, DateTime? fromDate, DateTime? toDate)");
                object[] objects = new object[3];
                objects[0] = schemePlanCode;
                objects[1] = fromDate;
                objects[2] = toDate;
                FunctionInfo = exBase.AddObject(FunctionInfo, objects);
                exBase.AdditionalInformation = FunctionInfo;
                ExceptionManager.Publish(exBase);
                throw exBase;

            }
            return dsdtGetSchemeNavHistory.Tables[0];
        }
        public DataTable GetschemedetailsNAV(int schemeplanCode)
        {
            Database db;
            DbCommand cmdGetschemedetailsNAV;
            DataTable dtGetschemedetailsNAV;
            DataSet dsGetschemedetailsNAV;
            try
            {
                db = DatabaseFactory.CreateDatabase("wealtherp");
                cmdGetschemedetailsNAV = db.GetStoredProcCommand("SPROC_OnlGetNAVDiffrence");
                db.AddInParameter(cmdGetschemedetailsNAV, "@schemePlanCode", DbType.Int32, schemeplanCode);
                dsGetschemedetailsNAV = db.ExecuteDataSet(cmdGetschemedetailsNAV);
                dtGetschemedetailsNAV = dsGetschemedetailsNAV.Tables[0];
            }
            catch (BaseApplicationException Ex)
            {
                throw (Ex);
            }
            catch (Exception Ex)
            {
                BaseApplicationException exBase = new BaseApplicationException(Ex.Message, Ex);
                NameValueCollection FunctionInfo = new NameValueCollection();
                FunctionInfo.Add("Method", "OnlineMFSchemeDetailsDao.cs: GetschemedetailsNAV(int schemeplanCode);");
                object[] objects = new object[2];
                objects[0] = schemeplanCode;
                FunctionInfo = exBase.AddObject(FunctionInfo, objects);
                exBase.AdditionalInformation = FunctionInfo;
                ExceptionManager.Publish(exBase);
                throw exBase;

            }
            return dtGetschemedetailsNAV;
        }

    }
}
