﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Data.Sql;
using Microsoft.Practices.EnterpriseLibrary.Data;
using Microsoft.Practices.EnterpriseLibrary.Data.Sql;
using System.Data.Common;
using System.Collections.Specialized;
using Microsoft.ApplicationBlocks.ExceptionManagement;
using VoCustomerPortfolio;
using VoUser;
using VoCustomerProfiling;

namespace DaoCustomerPortfolio
{
    /// <summary>
    /// alteration in the stored procedure --- SP_GetCustomerMFFolios
    /// </summary>
    public class CustomerTransactionDao
    {
        #region Equity Transactions
        public List<CustomerAccountsVo> GetCustomerEQAccount(int PortfolioId)
        {
            DataSet ds = null;
            Database db;
            DbCommand getCustomerEQAccCmd;
            List<CustomerAccountsVo> AccountList = null;
            CustomerAccountsVo AccountVo = new CustomerAccountsVo();
            DataTable dtEQAcc = new DataTable();
            try
            {
                db = DatabaseFactory.CreateDatabase("wealtherp");
                getCustomerEQAccCmd = db.GetStoredProcCommand("SP_GetCustomerTradeAccounts");
                db.AddInParameter(getCustomerEQAccCmd, "@PortfolioId", DbType.Int32, PortfolioId);

                ds = db.ExecuteDataSet(getCustomerEQAccCmd);

                if (ds.Tables[0].Rows.Count > 0)
                {
                    dtEQAcc = ds.Tables[0];
                    AccountList = new List<CustomerAccountsVo>();
                    foreach (DataRow dr in dtEQAcc.Rows)
                    {
                        AccountVo = new CustomerAccountsVo();
                        AccountVo.AccountId = int.Parse(dr["CETA_AccountId"].ToString());
                        AccountVo.BrokerName = dr["XB_BrokerName"].ToString();
                        AccountVo.TradeNum = dr["CETA_TradeAccountNum"].ToString();
                        if (dr["CETA_BrokerDeliveryPercentage"].ToString() != "" && dr["CETA_BrokerSpeculativePercentage"].ToString() != "" && dr["CETA_OtherCharges"].ToString() != "")
                        {
                            AccountVo.BrokerageDeliveryPercentage = double.Parse(dr["CETA_BrokerDeliveryPercentage"].ToString());
                            AccountVo.BrokerageSpeculativePercentage = double.Parse(dr["CETA_BrokerSpeculativePercentage"].ToString());
                            AccountVo.OtherCharges = double.Parse(dr["CETA_OtherCharges"].ToString());
                        }
                        else
                        {
                            AccountVo.BrokerageDeliveryPercentage = 0.0;
                            AccountVo.BrokerageSpeculativePercentage = 0.0;
                            AccountVo.OtherCharges = 0.0;

                        }
                        if (dr["CETA_AccountOpeningDate"].ToString() != string.Empty)
                            AccountVo.AccountOpeningDate = DateTime.Parse(dr["CETA_AccountOpeningDate"].ToString());
                        else
                            AccountVo.AccountOpeningDate = DateTime.MinValue;

                        AccountList.Add(AccountVo);

                    }
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
                FunctionInfo.Add("Method", "CustomerTransactionDao.cs:GetCustomerMFFolios()");
                object[] objects = new object[2];
                objects[0] = PortfolioId;
                FunctionInfo = exBase.AddObject(FunctionInfo, objects);
                exBase.AdditionalInformation = FunctionInfo;
                ExceptionManager.Publish(exBase);
                throw exBase;

            }
            return AccountList;
        }
        public bool AddEquityTransaction(EQTransactionVo eqTransactionVo, int userId)
        {
            bool bResult = false;
            int transactionId = 0;
            Database db;
            DbCommand createEquityTransactionCmd;
            try
            {
                db = DatabaseFactory.CreateDatabase("wealtherp");
                createEquityTransactionCmd = db.GetStoredProcCommand("SP_AddEquityTransaction");

                db.AddInParameter(createEquityTransactionCmd, "@CETA_AccountId", DbType.Int32, eqTransactionVo.AccountId);
                db.AddInParameter(createEquityTransactionCmd, "@PEM_ScripCode", DbType.String, eqTransactionVo.ScripCode);
                db.AddInParameter(createEquityTransactionCmd, "@CET_TradeNum", DbType.Int64, eqTransactionVo.TradeNum);
                db.AddInParameter(createEquityTransactionCmd, "@CET_OrderNum", DbType.Int64, eqTransactionVo.OrderNum);
                db.AddInParameter(createEquityTransactionCmd, "@CET_BuySell", DbType.String, eqTransactionVo.BuySell);
                db.AddInParameter(createEquityTransactionCmd, "@CET_IsSpeculative", DbType.Int16, eqTransactionVo.IsSpeculative);
                db.AddInParameter(createEquityTransactionCmd, "@XE_ExchangeCode", DbType.String, eqTransactionVo.Exchange);
                db.AddInParameter(createEquityTransactionCmd, "@CET_TradeDate", DbType.DateTime, eqTransactionVo.TradeDate);
                db.AddInParameter(createEquityTransactionCmd, "@CET_Rate", DbType.Decimal, eqTransactionVo.Rate);
                db.AddInParameter(createEquityTransactionCmd, "@CET_Quantity", DbType.Decimal, eqTransactionVo.Quantity);
                db.AddInParameter(createEquityTransactionCmd, "@CET_Brokerage", DbType.Decimal, eqTransactionVo.Brokerage);
                db.AddInParameter(createEquityTransactionCmd, "@CET_ServiceTax", DbType.Decimal, eqTransactionVo.ServiceTax);
                db.AddInParameter(createEquityTransactionCmd, "@CET_EducationCess", DbType.Decimal, eqTransactionVo.EducationCess);
                db.AddInParameter(createEquityTransactionCmd, "@CET_STT", DbType.Decimal, eqTransactionVo.STT);
                db.AddInParameter(createEquityTransactionCmd, "@CET_OtherCharges", DbType.Decimal, eqTransactionVo.OtherCharges);
                db.AddInParameter(createEquityTransactionCmd, "@CET_RateInclBrokerage", DbType.Decimal, eqTransactionVo.RateInclBrokerage);
                db.AddInParameter(createEquityTransactionCmd, "@CET_TradeTotal", DbType.Decimal, eqTransactionVo.TradeTotal);
                db.AddInParameter(createEquityTransactionCmd, "@XB_BrokerCode", DbType.String, eqTransactionVo.BrokerCode);
                db.AddInParameter(createEquityTransactionCmd, "@CET_IsSplit", DbType.Int16, eqTransactionVo.IsSplit);
                db.AddInParameter(createEquityTransactionCmd, "@CET_SplitCustEqTransId", DbType.Int32, eqTransactionVo.SplitTransactionId);
                db.AddInParameter(createEquityTransactionCmd, "@XES_SourceCode", DbType.String, eqTransactionVo.SourceCode);
                db.AddInParameter(createEquityTransactionCmd, "@WETT_TransactionCode", DbType.Int16, eqTransactionVo.TransactionCode);
                db.AddInParameter(createEquityTransactionCmd, "@CET_IsSourceManual", DbType.Int16, eqTransactionVo.IsSourceManual);
                db.AddInParameter(createEquityTransactionCmd, "@CET_ModifiedBy", DbType.String, userId);
                db.AddInParameter(createEquityTransactionCmd, "@CET_CreatedBy", DbType.String, userId);
                db.AddOutParameter(createEquityTransactionCmd, "CET_EqTransId", DbType.Int32, 5000);
                db.ExecuteNonQuery(createEquityTransactionCmd);

                transactionId = int.Parse(db.GetParameterValue(createEquityTransactionCmd, "CET_EqTransId").ToString());

                if (transactionId > 0)
                    bResult = true;

            }
            catch (BaseApplicationException Ex)
            {
                throw Ex;
            }
            catch (Exception Ex)
            {
                BaseApplicationException exBase = new BaseApplicationException(Ex.Message, Ex);
                NameValueCollection FunctionInfo = new NameValueCollection();

                FunctionInfo.Add("Method", "CustomerTransactionDao.cs:AddEquityTransaction()");


                object[] objects = new object[2];
                objects[0] = eqTransactionVo;
                objects[1] = userId;

                FunctionInfo = exBase.AddObject(FunctionInfo, objects);
                exBase.AdditionalInformation = FunctionInfo;
                ExceptionManager.Publish(exBase);
                throw exBase;

            }

            return bResult;
        }

        public List<EQTransactionVo> GetEquityTransactions(int customerId,
                                                            int portfolioId,
                                                            DateTime FromDate, DateTime ToDate
                                                            )
        {
            List<EQTransactionVo> eqTransactionsList = null;
            EQTransactionVo eqTransactionVo = new EQTransactionVo();
            Database db;
            DbCommand getEquityTransactionsCmd;
            DataSet dsGetEquityTransactions;
            DataTable dtGetEquityTransactions;

            //genDictTranType = new Dictionary<string, string>();
            //genDictExchange = new Dictionary<string, string>();
            //genDictTradeDate = new Dictionary<string, string>();

            //Count = 0;

            try
            {
                db = DatabaseFactory.CreateDatabase("wealtherp");
                getEquityTransactionsCmd = db.GetStoredProcCommand("SP_GetCustomerEquityTransactions");
                db.AddInParameter(getEquityTransactionsCmd, "@C_CustomerId", DbType.Int32, customerId);
                //db.AddInParameter(getEquityTransactionsCmd, "@currentPage", DbType.Int32, currentPage);
                db.AddInParameter(getEquityTransactionsCmd, "@CP_PortfolioId", DbType.Int32, portfolioId);
                //db.AddInParameter(getEquityTransactionsCmd, "@export", DbType.Int32, export);
                //if (ScripFilter != "")
                //    db.AddInParameter(getEquityTransactionsCmd, "@scripFilter", DbType.String, ScripFilter);
                //else
                //    db.AddInParameter(getEquityTransactionsCmd, "@scripFilter", DbType.String, DBNull.Value);
                //if (TradeNumFilter != "")
                //    db.AddInParameter(getEquityTransactionsCmd, "@tradeNumFilter", DbType.String, TradeNumFilter);
                //else
                //    db.AddInParameter(getEquityTransactionsCmd, "@tradeNumFilter", DbType.String, DBNull.Value);
                //if (ExchangeFilter != "")
                //    db.AddInParameter(getEquityTransactionsCmd, "@exchangeFilter", DbType.String, ExchangeFilter);
                //else
                //    db.AddInParameter(getEquityTransactionsCmd, "@exchangeFilter", DbType.String, DBNull.Value);
                //if (TradeDateFilter != "")
                //    db.AddInParameter(getEquityTransactionsCmd, "@tradeDateFilter", DbType.String, TradeDateFilter);
                //else
                //    db.AddInParameter(getEquityTransactionsCmd, "@tradeDateFilter", DbType.String, DBNull.Value);
                //if (TranTypeFilter != "")
                //    db.AddInParameter(getEquityTransactionsCmd, "@tranTypeFilter", DbType.String, TranTypeFilter);
                //else
                //    db.AddInParameter(getEquityTransactionsCmd, "@tranTypeFilter", DbType.String, DBNull.Value);

                //db.AddInParameter(getEquityTransactionsCmd, "@sortExpression", DbType.String, SortExpression);
                db.AddInParameter(getEquityTransactionsCmd, "@fromDate", DbType.DateTime, FromDate);
                db.AddInParameter(getEquityTransactionsCmd, "@toDate", DbType.DateTime, ToDate);
                dsGetEquityTransactions = db.ExecuteDataSet(getEquityTransactionsCmd);
                if (dsGetEquityTransactions.Tables[0].Rows.Count > 0)
                {
                    dtGetEquityTransactions = dsGetEquityTransactions.Tables[0];
                    eqTransactionsList = new List<EQTransactionVo>();
                    foreach (DataRow dr in dtGetEquityTransactions.Rows)
                    {
                        eqTransactionVo = new EQTransactionVo();
                        eqTransactionVo.TransactionId = int.Parse(dr["CET_EqTransId"].ToString());
                        eqTransactionVo.CustomerId = int.Parse(dr["C_CustomerId"].ToString());
                        eqTransactionVo.PortfolioId = int.Parse(dr["CP_PortfolioId"].ToString());
                        eqTransactionVo.AccountId = int.Parse(dr["CETA_AccountId"].ToString());
                        eqTransactionVo.ScripCode = int.Parse(dr["PEM_ScripCode"].ToString());
                        eqTransactionVo.ScripName = dr["PEM_CompanyName"].ToString();
                        eqTransactionVo.Ticker = dr["PEM_Ticker"].ToString();
                        eqTransactionVo.TradeAccountNum = (dr["CETA_TradeAccountNum"].ToString());
                        eqTransactionVo.OrderNum = Int64.Parse(dr["CET_OrderNum"].ToString());
                        eqTransactionVo.BuySell = dr["CET_BuySell"].ToString();
                        eqTransactionVo.IsSpeculative = int.Parse(dr["CET_IsSpeculative"].ToString());
                        if (dr["CET_IsSpeculative"].ToString() == "1")
                            eqTransactionVo.TradeType = "S";
                        else
                            eqTransactionVo.TradeType = "D";

                        eqTransactionVo.Exchange = dr["XE_ExchangeCode"].ToString();
                        eqTransactionVo.TradeDate = DateTime.Parse(dr["CET_TradeDate"].ToString());
                        eqTransactionVo.Rate = float.Parse(dr["CET_Rate"].ToString());
                        eqTransactionVo.Quantity = float.Parse(dr["CET_Quantity"].ToString());
                        eqTransactionVo.Brokerage = float.Parse(dr["CET_Brokerage"].ToString());
                        eqTransactionVo.ServiceTax = float.Parse(dr["CET_ServiceTax"].ToString());
                        eqTransactionVo.EducationCess = float.Parse(dr["CET_EducationCess"].ToString());
                        eqTransactionVo.STT = float.Parse(dr["CET_STT"].ToString());
                        eqTransactionVo.OtherCharges = float.Parse(dr["CET_OtherCharges"].ToString());
                        eqTransactionVo.RateInclBrokerage = float.Parse(dr["CET_RateInclBrokerage"].ToString());
                        eqTransactionVo.TradeTotal = double.Parse(dr["CET_TradeTotal"].ToString());
                        eqTransactionVo.BrokerCode = dr["XB_BrokerCode"].ToString();
                        eqTransactionVo.IsSplit = int.Parse(dr["CET_IsSplit"].ToString());
                        eqTransactionVo.SplitTransactionId = int.Parse(dr["CET_SplitCustEqTransId"].ToString());
                        if (!string.IsNullOrEmpty(dr["CET_IsSourceManual"].ToString()))
                            eqTransactionVo.IsSourceManual = int.Parse(dr["CET_IsSourceManual"].ToString());

                        eqTransactionVo.SourceCode = dr["XES_SourceCode"].ToString();
                        eqTransactionVo.TransactionCode = int.Parse(dr["WETT_TransactionCode"].ToString());
                        eqTransactionVo.TransactionType = dr["WETT_TransactionTypeName"].ToString();
                        eqTransactionVo.IsCorpAction = int.Parse(dr["WETT_IsCorpAxn"].ToString());
                        eqTransactionVo.TransactionStatus = dr["WTS_TransactionStatus"].ToString();
                        eqTransactionsList.Add(eqTransactionVo);
                    }
                }

                //if (dsGetEquityTransactions.Tables[2].Rows.Count > 0)
                //{
                //    string type = string.Empty;
                //    string mode = string.Empty;
                //    string tranType = string.Empty;

                //    foreach (DataRow dr in dsGetEquityTransactions.Tables[2].Rows)
                //    {
                //        if (dr["CET_IsSpeculative"].ToString() == "1")
                //            mode = "Speculation";
                //        else if (dr["CET_IsSpeculative"].ToString() == "0")
                //            mode = "Delivery";
                //        if (dr["WETT_TransactionCode"].ToString() == "1")
                //            type = "Buy";
                //        else if (dr["WETT_TransactionCode"].ToString() == "2")
                //            type = "Sell";
                //        else if (dr["WETT_TransactionCode"].ToString() == "13")
                //            type = "Holdings";
                //        tranType = type + "/" + mode;

                //        //if (!genDictTranType.ContainsKey(tranType))
                //        //{
                //        //    genDictTranType.Add(tranType, tranType);
                //        //}
                //    }
                //}

                //if (dsGetEquityTransactions.Tables[3].Rows.Count > 0)
                //{
                //    foreach (DataRow dr in dsGetEquityTransactions.Tables[3].Rows)
                //    {
                //        genDictExchange.Add(dr["XE_ExchangeCode"].ToString(), dr["XE_ExchangeCode"].ToString());
                //    }
                //}

                //if (dsGetEquityTransactions.Tables[4].Rows.Count > 0)
                //{
                //    foreach (DataRow dr in dsGetEquityTransactions.Tables[4].Rows)
                //    {
                //        genDictTradeDate.Add(DateTime.Parse(dr["CET_TradeDate"].ToString()).ToShortDateString(), DateTime.Parse(dr["CET_TradeDate"].ToString()).ToShortDateString());
                //    }
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

                FunctionInfo.Add("Method", "CustomerTransactionDao.cs:GetEquityTransactions()");

                object[] objects = new object[1];
                objects[0] = customerId;

                FunctionInfo = exBase.AddObject(FunctionInfo, objects);
                exBase.AdditionalInformation = FunctionInfo;
                ExceptionManager.Publish(exBase);
                throw exBase;

            }

            // if (dsGetEquityTransactions.Tables[1].Rows.Count > 0)
            // Count = Int32.Parse(dsGetEquityTransactions.Tables[1].Rows[0]["CNT"].ToString());

            return eqTransactionsList;
        }

        public List<EQTransactionVo> GetEquityTransactions(int customerId, int portfolioId)
        {
            List<EQTransactionVo> eqTransactionsList = null;
            EQTransactionVo eqTransactionVo = new EQTransactionVo();
            Database db;
            DbCommand getEquityTransactionsCmd;
            DataSet dsGetEquityTransactions;
            DataTable dtGetEquityTransactions;
            try
            {
                db = DatabaseFactory.CreateDatabase("wealtherp");
                getEquityTransactionsCmd = db.GetStoredProcCommand("SP_GetCustomerPortfolioEquityTransactions");
                db.AddInParameter(getEquityTransactionsCmd, "@C_CustomerId", DbType.Int32, customerId);
                db.AddInParameter(getEquityTransactionsCmd, "@CP_PortfolioId", DbType.Int32, portfolioId);

                dsGetEquityTransactions = db.ExecuteDataSet(getEquityTransactionsCmd);
                if (dsGetEquityTransactions.Tables[0].Rows.Count > 0)
                {
                    dtGetEquityTransactions = dsGetEquityTransactions.Tables[0];
                    eqTransactionsList = new List<EQTransactionVo>();
                    foreach (DataRow dr in dtGetEquityTransactions.Rows)
                    {
                        eqTransactionVo = new EQTransactionVo();
                        eqTransactionVo.TransactionId = int.Parse(dr["CET_EqTransId"].ToString());
                        eqTransactionVo.CustomerId = int.Parse(dr["C_CustomerId"].ToString());
                        eqTransactionVo.PortfolioId = int.Parse(dr["CP_PortfolioId"].ToString());
                        eqTransactionVo.AccountId = int.Parse(dr["CETA_AccountId"].ToString());
                        eqTransactionVo.ScripCode = int.Parse(dr["PEM_ScripCode"].ToString());
                        eqTransactionVo.ScripName = dr["PEM_CompanyName"].ToString();
                        eqTransactionVo.Ticker = dr["PEM_Ticker"].ToString();
                        eqTransactionVo.TradeAccountNum = (dr["CET_TradeNum"].ToString());
                        eqTransactionVo.OrderNum = Int64.Parse(dr["CET_OrderNum"].ToString());
                        eqTransactionVo.BuySell = dr["CET_BuySell"].ToString();
                        eqTransactionVo.IsSpeculative = int.Parse(dr["CET_IsSpeculative"].ToString());
                        if (dr["CET_IsSpeculative"].ToString() == "1")
                            eqTransactionVo.TradeType = "S";
                        else
                            eqTransactionVo.TradeType = "D";

                        eqTransactionVo.Exchange = dr["XE_ExchangeCode"].ToString();
                        eqTransactionVo.TradeDate = DateTime.Parse(dr["CET_TradeDate"].ToString());
                        eqTransactionVo.Rate = float.Parse(dr["CET_Rate"].ToString());
                        eqTransactionVo.Quantity = float.Parse(dr["CET_Quantity"].ToString());
                        eqTransactionVo.Brokerage = float.Parse(dr["CET_Brokerage"].ToString());
                        eqTransactionVo.ServiceTax = float.Parse(dr["CET_ServiceTax"].ToString());
                        eqTransactionVo.EducationCess = float.Parse(dr["CET_EducationCess"].ToString());
                        eqTransactionVo.STT = float.Parse(dr["CET_STT"].ToString());
                        eqTransactionVo.OtherCharges = float.Parse(dr["CET_OtherCharges"].ToString());
                        eqTransactionVo.RateInclBrokerage = float.Parse(dr["CET_RateInclBrokerage"].ToString());
                        eqTransactionVo.TradeTotal = float.Parse(dr["CET_TradeTotal"].ToString());
                        eqTransactionVo.BrokerCode = dr["XB_BrokerCode"].ToString();
                        eqTransactionVo.IsSplit = int.Parse(dr["CET_IsSplit"].ToString());
                        eqTransactionVo.SplitTransactionId = int.Parse(dr["CET_SplitCustEqTransId"].ToString());
                        if (!string.IsNullOrEmpty(dr["CET_IsSourceManual"].ToString()))
                            eqTransactionVo.IsSourceManual = int.Parse(dr["CET_IsSourceManual"].ToString());
                        eqTransactionVo.SourceCode = dr["XES_SourceCode"].ToString();
                        eqTransactionVo.TransactionCode = int.Parse(dr["WETT_TransactionCode"].ToString());
                        eqTransactionVo.TransactionType = dr["WETT_TransactionTypeName"].ToString();
                        eqTransactionVo.IsCorpAction = int.Parse(dr["WETT_IsCorpAxn"].ToString());
                        eqTransactionsList.Add(eqTransactionVo);
                    }
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

                FunctionInfo.Add("Method", "CustomerTransactionDao.cs:GetEquityTransactions()");


                object[] objects = new object[1];
                objects[0] = customerId;

                FunctionInfo = exBase.AddObject(FunctionInfo, objects);
                exBase.AdditionalInformation = FunctionInfo;
                ExceptionManager.Publish(exBase);
                throw exBase;

            }



            return eqTransactionsList;
        }

        public List<EQTransactionVo> GetEquityTransactions(int customerId, int eqCode, DateTime tradeDate)
        {
            List<EQTransactionVo> eqTransactionsList = null;

            EQTransactionVo eqTransactionVo = new EQTransactionVo();
            Database db;
            DbCommand getEquityTransactionsCmd;
            DataSet dsGetEquityTransactions;
            DataTable dtGetEquityTransactions;
            try
            {
                db = DatabaseFactory.CreateDatabase("wealtherp");
                getEquityTransactionsCmd = db.GetStoredProcCommand("SP_GetCustomerEquitySpecificTransactions");
                db.AddInParameter(getEquityTransactionsCmd, "@C_CustomerId", DbType.Int32, customerId);
                db.AddInParameter(getEquityTransactionsCmd, "@PEM_ScripCode", DbType.Int32, eqCode);
                db.AddInParameter(getEquityTransactionsCmd, "@CET_TradeDate", DbType.DateTime, tradeDate);
                dsGetEquityTransactions = db.ExecuteDataSet(getEquityTransactionsCmd);
                if (dsGetEquityTransactions.Tables[0].Rows.Count > 0)
                {
                    dtGetEquityTransactions = dsGetEquityTransactions.Tables[0];
                    eqTransactionsList = new List<EQTransactionVo>();
                    foreach (DataRow dr in dtGetEquityTransactions.Rows)
                    {
                        eqTransactionVo = new EQTransactionVo();
                        eqTransactionVo.TransactionId = int.Parse(dr["CET_EqTransId"].ToString());
                        eqTransactionVo.CustomerId = int.Parse(dr["C_CustomerId"].ToString());
                        eqTransactionVo.PortfolioId = int.Parse(dr["CP_PortfolioId"].ToString());
                        eqTransactionVo.AccountId = int.Parse(dr["CETA_AccountId"].ToString());
                        eqTransactionVo.ScripCode = int.Parse(dr["PEM_ScripCode"].ToString());
                        eqTransactionVo.ScripName = dr["PEM_CompanyName"].ToString();
                        eqTransactionVo.Ticker = dr["PEM_Ticker"].ToString();
                        eqTransactionVo.TradeAccountNum = (dr["CET_TradeNum"].ToString());
                        eqTransactionVo.OrderNum = Int64.Parse(dr["CET_OrderNum"].ToString());
                        eqTransactionVo.BuySell = dr["CET_BuySell"].ToString();
                        eqTransactionVo.IsSpeculative = int.Parse(dr["CET_IsSpeculative"].ToString());
                        if (dr["CET_IsSpeculative"].ToString() == "1")
                            eqTransactionVo.TradeType = "S";
                        else
                            eqTransactionVo.TradeType = "D";

                        eqTransactionVo.Exchange = dr["XE_ExchangeCode"].ToString();
                        eqTransactionVo.TradeDate = DateTime.Parse(dr["CET_TradeDate"].ToString());
                        eqTransactionVo.Rate = float.Parse(dr["CET_Rate"].ToString());
                        eqTransactionVo.Quantity = float.Parse(dr["CET_Quantity"].ToString());
                        eqTransactionVo.Brokerage = float.Parse(dr["CET_Brokerage"].ToString());
                        eqTransactionVo.ServiceTax = float.Parse(dr["CET_ServiceTax"].ToString());
                        eqTransactionVo.EducationCess = float.Parse(dr["CET_EducationCess"].ToString());
                        eqTransactionVo.STT = float.Parse(dr["CET_STT"].ToString());
                        eqTransactionVo.OtherCharges = float.Parse(dr["CET_OtherCharges"].ToString());
                        eqTransactionVo.RateInclBrokerage = float.Parse(dr["CET_RateInclBrokerage"].ToString());
                        eqTransactionVo.TradeTotal = float.Parse(dr["CET_TradeTotal"].ToString());
                        eqTransactionVo.BrokerCode = dr["XB_BrokerCode"].ToString();
                        eqTransactionVo.IsSplit = int.Parse(dr["CET_IsSplit"].ToString());
                        eqTransactionVo.SplitTransactionId = int.Parse(dr["CET_SplitCustEqTransId"].ToString());
                        if (!string.IsNullOrEmpty(dr["CET_IsSourceManual"].ToString()))
                            eqTransactionVo.IsSourceManual = int.Parse(dr["CET_IsSourceManual"].ToString());
                        eqTransactionVo.SourceCode = dr["XES_SourceCode"].ToString();
                        eqTransactionVo.TransactionCode = int.Parse(dr["WETT_TransactionCode"].ToString());
                        eqTransactionVo.TransactionType = dr["WETT_TransactionTypeName"].ToString();
                        eqTransactionVo.IsCorpAction = int.Parse(dr["WETT_IsCorpAxn"].ToString());

                        eqTransactionsList.Add(eqTransactionVo);
                    }
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

                FunctionInfo.Add("Method", "CustomerTransactionDao.cs:GetEquityTransactions()");


                object[] objects = new object[2];
                objects[0] = customerId;
                objects[1] = eqCode;

                FunctionInfo = exBase.AddObject(FunctionInfo, objects);
                exBase.AdditionalInformation = FunctionInfo;
                ExceptionManager.Publish(exBase);
                throw exBase;

            }
            return eqTransactionsList;
        }

        public List<EQTransactionVo> GetEquityTransactions(int customerId, int portfolioId, int eqCode, DateTime tradeDate, int accountId)
        {
            List<EQTransactionVo> eqTransactionsList = null;

            EQTransactionVo eqTransactionVo = new EQTransactionVo();
            Database db;
            DbCommand getEquityTransactionsCmd;
            DataSet dsGetEquityTransactions;
            DataTable dtGetEquityTransactions;
            try
            {
                db = DatabaseFactory.CreateDatabase("wealtherp");
                getEquityTransactionsCmd = db.GetStoredProcCommand("SP_GetCustomerPortfolioEquitySpecificTransactions");
                db.AddInParameter(getEquityTransactionsCmd, "@C_CustomerId", DbType.Int32, customerId);
                db.AddInParameter(getEquityTransactionsCmd, "@CP_PortfolioId", DbType.Int32, portfolioId);
                db.AddInParameter(getEquityTransactionsCmd, "@PEM_ScripCode", DbType.Int32, eqCode);
                db.AddInParameter(getEquityTransactionsCmd, "@CET_TradeDate", DbType.DateTime, tradeDate);
                db.AddInParameter(getEquityTransactionsCmd, "@AccountId", DbType.Int32, accountId);
                dsGetEquityTransactions = db.ExecuteDataSet(getEquityTransactionsCmd);
                if (dsGetEquityTransactions.Tables[0].Rows.Count > 0)
                {
                    dtGetEquityTransactions = dsGetEquityTransactions.Tables[0];
                    eqTransactionsList = new List<EQTransactionVo>();
                    foreach (DataRow dr in dtGetEquityTransactions.Rows)
                    {
                        eqTransactionVo = new EQTransactionVo();
                        eqTransactionVo.TransactionId = int.Parse(dr["CET_EqTransId"].ToString());
                        eqTransactionVo.CustomerId = int.Parse(dr["C_CustomerId"].ToString());
                        eqTransactionVo.PortfolioId = int.Parse(dr["CP_PortfolioId"].ToString());
                        eqTransactionVo.AccountId = int.Parse(dr["CETA_AccountId"].ToString());
                        eqTransactionVo.ScripCode = int.Parse(dr["PEM_ScripCode"].ToString());
                        eqTransactionVo.ScripName = dr["PEM_CompanyName"].ToString();
                        eqTransactionVo.Ticker = dr["PEM_Ticker"].ToString();
                        eqTransactionVo.TradeAccountNum = (dr["CET_TradeNum"].ToString());
                        eqTransactionVo.OrderNum = Int64.Parse(dr["CET_OrderNum"].ToString());
                        eqTransactionVo.BuySell = dr["CET_BuySell"].ToString();
                        if (dr["CET_IsSpeculative"].ToString() != String.Empty)
                        {
                            eqTransactionVo.IsSpeculative = int.Parse(dr["CET_IsSpeculative"].ToString());
                            if (dr["CET_IsSpeculative"].ToString() == "1")
                                eqTransactionVo.TradeType = "S";
                            else
                                eqTransactionVo.TradeType = "D";
                        }
                        else
                        {
                            eqTransactionVo.IsSpeculative = 0;
                            eqTransactionVo.TradeType = "D";
                        }
                        eqTransactionVo.Exchange = dr["XE_ExchangeCode"].ToString();
                        eqTransactionVo.TradeDate = DateTime.Parse(dr["CET_TradeDate"].ToString());
                        eqTransactionVo.Rate = float.Parse(dr["CET_Rate"].ToString());
                        eqTransactionVo.Quantity = float.Parse(dr["CET_Quantity"].ToString());
                        eqTransactionVo.Brokerage = float.Parse(dr["CET_Brokerage"].ToString());
                        eqTransactionVo.ServiceTax = float.Parse(dr["CET_ServiceTax"].ToString());
                        eqTransactionVo.EducationCess = float.Parse(dr["CET_EducationCess"].ToString());
                        eqTransactionVo.STT = float.Parse(dr["CET_STT"].ToString());
                        eqTransactionVo.OtherCharges = float.Parse(dr["CET_OtherCharges"].ToString());
                        eqTransactionVo.RateInclBrokerage = float.Parse(dr["CET_RateInclBrokerage"].ToString());
                        eqTransactionVo.TradeTotal = float.Parse(dr["CET_TradeTotal"].ToString());
                        eqTransactionVo.BrokerCode = dr["XB_BrokerCode"].ToString();
                        eqTransactionVo.IsSplit = int.Parse(dr["CET_IsSplit"].ToString());
                        eqTransactionVo.SplitTransactionId = int.Parse(dr["CET_SplitCustEqTransId"].ToString());
                        if (!string.IsNullOrEmpty(dr["CET_IsSourceManual"].ToString()))
                            eqTransactionVo.IsSourceManual = int.Parse(dr["CET_IsSourceManual"].ToString());

                        eqTransactionVo.SourceCode = dr["XES_SourceCode"].ToString();
                        eqTransactionVo.TransactionCode = int.Parse(dr["WETT_TransactionCode"].ToString());
                        eqTransactionVo.TransactionType = dr["WETT_TransactionTypeName"].ToString();
                        eqTransactionVo.IsCorpAction = int.Parse(dr["WETT_IsCorpAxn"].ToString());
                        eqTransactionVo.TransactionStatus = dr["WTS_TransactionStatus"].ToString();

                        eqTransactionsList.Add(eqTransactionVo);
                    }
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

                FunctionInfo.Add("Method", "CustomerTransactionDao.cs:GetEquityTransactions()");


                object[] objects = new object[2];
                objects[0] = customerId;
                objects[1] = eqCode;

                FunctionInfo = exBase.AddObject(FunctionInfo, objects);
                exBase.AdditionalInformation = FunctionInfo;
                ExceptionManager.Publish(exBase);
                throw exBase;

            }
            return eqTransactionsList;
        }

        public EQTransactionVo GetEquityTransaction(int eqTransactionId)
        {
            EQTransactionVo eqTransactionVo = null;

            Database db;
            DbCommand getEquityTransactionCmd;
            DataSet dsGetEquityTransaction;
            DataTable dtGetEquityTransaction;
            try
            {
                db = DatabaseFactory.CreateDatabase("wealtherp");
                getEquityTransactionCmd = db.GetStoredProcCommand("SP_GetCustomerEquityTransaction");
                db.AddInParameter(getEquityTransactionCmd, "@CET_EqTransId", DbType.Int32, eqTransactionId);
                dsGetEquityTransaction = db.ExecuteDataSet(getEquityTransactionCmd);
                if (dsGetEquityTransaction.Tables[0].Rows.Count > 0)
                {
                    dtGetEquityTransaction = dsGetEquityTransaction.Tables[0];

                    eqTransactionVo = new EQTransactionVo();

                    foreach (DataRow dr in dtGetEquityTransaction.Rows)
                    {
                        eqTransactionVo.TransactionId = int.Parse(dr["CET_EqTransId"].ToString());
                        //eqTransactionVo.CustomerId = int.Parse(dr["C_CustomerId"].ToString());
                        //eqTransactionVo.PortfolioId = int.Parse(dr["CP_PortfolioId"].ToString());
                        eqTransactionVo.AccountId = int.Parse(dr["CETA_AccountId"].ToString());
                        eqTransactionVo.ScripCode = int.Parse(dr["PEM_ScripCode"].ToString());
                        //eqTransactionVo.ScripName = dr["PEM_CompanyName"].ToString();
                        //eqTransactionVo.Ticker = dr["PEM_Ticker"].ToString();
                        eqTransactionVo.TradeAccountNum = (dr["CET_TradeNum"].ToString());
                        eqTransactionVo.OrderNum = Int64.Parse(dr["CET_OrderNum"].ToString());
                        eqTransactionVo.BuySell = dr["CET_BuySell"].ToString();
                        eqTransactionVo.IsSpeculative = int.Parse(dr["CET_IsSpeculative"].ToString());
                        if (dr["CET_IsSpeculative"].ToString() == "1")
                            eqTransactionVo.TradeType = "S";
                        else
                            eqTransactionVo.TradeType = "D";

                        eqTransactionVo.Exchange = dr["XE_ExchangeCode"].ToString();
                        eqTransactionVo.TradeDate = DateTime.Parse(dr["CET_TradeDate"].ToString());
                        eqTransactionVo.Rate = float.Parse(dr["CET_Rate"].ToString());
                        eqTransactionVo.Quantity = float.Parse(dr["CET_Quantity"].ToString());
                        eqTransactionVo.Brokerage = float.Parse(dr["CET_Brokerage"].ToString());
                        eqTransactionVo.ServiceTax = float.Parse(dr["CET_ServiceTax"].ToString());
                        eqTransactionVo.EducationCess = float.Parse(dr["CET_EducationCess"].ToString());
                        eqTransactionVo.STT = float.Parse(dr["CET_STT"].ToString());
                        eqTransactionVo.OtherCharges = float.Parse(dr["CET_OtherCharges"].ToString());
                        eqTransactionVo.RateInclBrokerage = float.Parse(dr["CET_RateInclBrokerage"].ToString());
                        eqTransactionVo.TradeTotal = float.Parse(dr["CET_TradeTotal"].ToString());
                        eqTransactionVo.BrokerCode = dr["XB_BrokerCode"].ToString();
                        eqTransactionVo.IsSplit = int.Parse(dr["CET_IsSplit"].ToString());
                        eqTransactionVo.SplitTransactionId = int.Parse(dr["CET_SplitCustEqTransId"].ToString());
                        if (!string.IsNullOrEmpty(dr["CET_IsSourceManual"].ToString()))
                            eqTransactionVo.IsSourceManual = int.Parse(dr["CET_IsSourceManual"].ToString());
                        eqTransactionVo.SourceCode = dr["XES_SourceCode"].ToString();
                        eqTransactionVo.TransactionCode = int.Parse(dr["WETT_TransactionCode"].ToString());
                        //eqTransactionVo.TransactionType = dr["WETT_TransactionTypeName"].ToString();
                        //eqTransactionVo.IsCorpAction = int.Parse(dr["WETT_IsCorpAxn"].ToString());

                    }
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

                FunctionInfo.Add("Method", "CustomerTransactionDao.cs:GetEquityTransaction()");


                object[] objects = new object[1];
                objects[0] = eqTransactionId;

                FunctionInfo = exBase.AddObject(FunctionInfo, objects);
                exBase.AdditionalInformation = FunctionInfo;
                ExceptionManager.Publish(exBase);
                throw exBase;

            }


            return eqTransactionVo;
        }

        public DataSet PopulateDDExchange(int portfolioId)
        {
            Database db;
            DbCommand populateDDExchangeCmd;
            DataSet dsPopulateDDExchange = null;

            try
            {
                db = DatabaseFactory.CreateDatabase("wealtherp");
                populateDDExchangeCmd = db.GetStoredProcCommand("SP_PopulateDDExchange");
                db.AddInParameter(populateDDExchangeCmd, "@CP_PortfolioId", DbType.Int32, portfolioId);
                dsPopulateDDExchange = db.ExecuteDataSet(populateDDExchangeCmd);
            }
            catch (BaseApplicationException Ex)
            {
                throw Ex;
            }
            catch (Exception Ex)
            {
                BaseApplicationException exBase = new BaseApplicationException(Ex.Message, Ex);
                NameValueCollection FunctionInfo = new NameValueCollection();
                FunctionInfo.Add("Method", "CustomerTransactionDao.cs:PopulateDDExchange()");

                object[] objects = new object[1];
                objects[0] = portfolioId;

                FunctionInfo = exBase.AddObject(FunctionInfo, objects);
                exBase.AdditionalInformation = FunctionInfo;
                ExceptionManager.Publish(exBase);
                throw exBase;
            }
            return dsPopulateDDExchange;
        }

        public bool UpdateEquityTransaction(EQTransactionVo eqTransactionVo, int userId)
        {
            bool bResult = false;
            Database db;
            DbCommand updateEQTransactionCmd;
            try
            {
                db = DatabaseFactory.CreateDatabase("wealtherp");
                updateEQTransactionCmd = db.GetStoredProcCommand("SP_UpdateEquityTransaction");

                db.AddInParameter(updateEQTransactionCmd, "CET_EqTransId", DbType.Int32, eqTransactionVo.TransactionId);
                db.AddInParameter(updateEQTransactionCmd, "@CETA_AccountId", DbType.Int32, eqTransactionVo.AccountId);
                db.AddInParameter(updateEQTransactionCmd, "@PEM_ScripCode", DbType.String, eqTransactionVo.ScripCode);
                if (eqTransactionVo.TradeAccountNum != "")
                    db.AddInParameter(updateEQTransactionCmd, "@CET_TradeNum", DbType.Decimal, eqTransactionVo.TradeAccountNum);
                else
                    db.AddInParameter(updateEQTransactionCmd, "@CET_TradeNum", DbType.Int64, DBNull.Value);

                db.AddInParameter(updateEQTransactionCmd, "@CET_OrderNum", DbType.Decimal, eqTransactionVo.OrderNum);
                db.AddInParameter(updateEQTransactionCmd, "@CET_BuySell", DbType.String, eqTransactionVo.BuySell);
                db.AddInParameter(updateEQTransactionCmd, "@CET_IsSpeculative", DbType.Int16, eqTransactionVo.IsSpeculative);
                db.AddInParameter(updateEQTransactionCmd, "@XE_ExchangeCode", DbType.String, eqTransactionVo.Exchange);
                db.AddInParameter(updateEQTransactionCmd, "@CET_TradeDate", DbType.DateTime, eqTransactionVo.TradeDate);
                db.AddInParameter(updateEQTransactionCmd, "@CET_Rate", DbType.Decimal, eqTransactionVo.Rate);
                db.AddInParameter(updateEQTransactionCmd, "@CET_Quantity", DbType.Decimal, eqTransactionVo.Quantity);
                db.AddInParameter(updateEQTransactionCmd, "@CET_Brokerage", DbType.Decimal, eqTransactionVo.Brokerage);
                db.AddInParameter(updateEQTransactionCmd, "@CET_ServiceTax", DbType.Decimal, eqTransactionVo.ServiceTax);
                db.AddInParameter(updateEQTransactionCmd, "@CET_EducationCess", DbType.Decimal, eqTransactionVo.EducationCess);
                db.AddInParameter(updateEQTransactionCmd, "@CET_STT", DbType.Decimal, eqTransactionVo.STT);
                db.AddInParameter(updateEQTransactionCmd, "@CET_OtherCharges", DbType.Decimal, eqTransactionVo.OtherCharges);
                db.AddInParameter(updateEQTransactionCmd, "@CET_RateInclBrokerage", DbType.Decimal, eqTransactionVo.RateInclBrokerage);
                db.AddInParameter(updateEQTransactionCmd, "@CET_TradeTotal", DbType.Decimal, eqTransactionVo.TradeTotal);
                db.AddInParameter(updateEQTransactionCmd, "@XB_BrokerCode", DbType.String, eqTransactionVo.BrokerCode);
                db.AddInParameter(updateEQTransactionCmd, "@CET_IsSplit", DbType.Int16, eqTransactionVo.IsSplit);
                db.AddInParameter(updateEQTransactionCmd, "@CET_SplitCustEqTransId", DbType.Int32, eqTransactionVo.SplitTransactionId);
                db.AddInParameter(updateEQTransactionCmd, "@XES_SourceCode", DbType.String, eqTransactionVo.SourceCode);
                db.AddInParameter(updateEQTransactionCmd, "@WETT_TransactionCode", DbType.Int16, eqTransactionVo.TransactionCode);
                db.AddInParameter(updateEQTransactionCmd, "@CET_IsSourceManual", DbType.Int16, eqTransactionVo.IsSourceManual);
                db.AddInParameter(updateEQTransactionCmd, "@CET_ModifiedBy", DbType.String, userId);
                if (db.ExecuteNonQuery(updateEQTransactionCmd) != 0)

                    bResult = true;

            }
            catch (BaseApplicationException Ex)
            {
                throw Ex;
            }
            catch (Exception Ex)
            {
                BaseApplicationException exBase = new BaseApplicationException(Ex.Message, Ex);
                NameValueCollection FunctionInfo = new NameValueCollection();

                FunctionInfo.Add("Method", "CustomerTransactionDao.cs:UpdateEquityTransaction()");


                object[] objects = new object[2];
                objects[0] = eqTransactionVo;
                objects[1] = userId;

                FunctionInfo = exBase.AddObject(FunctionInfo, objects);
                exBase.AdditionalInformation = FunctionInfo;
                ExceptionManager.Publish(exBase);
                throw exBase;

            }
            return bResult;
        }

        public bool DeleteEQTransaction(int eqTransactionId)
        {
            bool bResult = false;
            Database db;
            DbCommand deleteEquityTransactionCmd;

            try
            {
                db = DatabaseFactory.CreateDatabase("wealtherp");
                deleteEquityTransactionCmd = db.GetStoredProcCommand("SP_DeleteEQTransactions");

                db.AddInParameter(deleteEquityTransactionCmd, "@CET_EqTransId", DbType.Int32, eqTransactionId);
                if (db.ExecuteNonQuery(deleteEquityTransactionCmd) != 0)

                    bResult = true;
            }
            catch (BaseApplicationException Ex)
            {
                throw Ex;
            }
            catch (Exception Ex)
            {
                BaseApplicationException exBase = new BaseApplicationException(Ex.Message, Ex);
                NameValueCollection FunctionInfo = new NameValueCollection();

                FunctionInfo.Add("Method", "CustomerTransactionDao.cs:DeleteEQTransaction()");

                object[] objects = new object[1];
                objects[0] = eqTransactionId;

                FunctionInfo = exBase.AddObject(FunctionInfo, objects);
                exBase.AdditionalInformation = FunctionInfo;
                ExceptionManager.Publish(exBase);
                throw exBase;
            }
            return bResult;
        }

        public CustomerAccountsVo GetCustomerEQAccountDetails(int AccountId, int PortfolioId)
        {

            CustomerAccountsVo AccountVo = new CustomerAccountsVo();
            Database db;
            DbCommand getEQTransactionCmd;
            DataSet dsGetEQTransaction;
            DataRow dr;
            try
            {
                db = DatabaseFactory.CreateDatabase("wealtherp");
                getEQTransactionCmd = db.GetStoredProcCommand("SP_GetCustomerTradeAccountDetails");
                db.AddInParameter(getEQTransactionCmd, "@AccountId", DbType.Int32, AccountId);
                db.AddInParameter(getEQTransactionCmd, "@PortfolioId", DbType.Int32, PortfolioId);

                dsGetEQTransaction = db.ExecuteDataSet(getEQTransactionCmd);
                if (dsGetEQTransaction.Tables[0].Rows.Count > 0)
                {
                    dr = dsGetEQTransaction.Tables[0].Rows[0];
                    AccountVo = new CustomerAccountsVo();
                    AccountVo.AccountId = int.Parse(dr["CETA_AccountId"].ToString());
                    AccountVo.PortfolioId = int.Parse(dr["CP_PortfolioId"].ToString());
                    AccountVo.BrokerCode = dr["XB_BrokerCode"].ToString();
                    AccountVo.TradeNum = dr["CETA_TradeAccountNum"].ToString();
                    if (dr["CETA_AccountOpeningDate"].ToString() != string.Empty)
                        AccountVo.AccountOpeningDate = DateTime.Parse(dr["CETA_AccountOpeningDate"].ToString());
                    else
                        AccountVo.AccountOpeningDate = DateTime.MinValue;
                    if (dr["CETA_BrokerDeliveryPercentage"].ToString() != "")
                        AccountVo.BrokerageDeliveryPercentage = double.Parse(dr["CETA_BrokerDeliveryPercentage"].ToString());
                    else
                        AccountVo.BrokerageDeliveryPercentage = 0;
                    if (dr["CETA_BrokerSpeculativePercentage"].ToString() != "")
                        AccountVo.BrokerageSpeculativePercentage = double.Parse(dr["CETA_BrokerSpeculativePercentage"].ToString());
                    else
                        AccountVo.BrokerageSpeculativePercentage = 0;
                    if (dr["CETA_OtherCharges"].ToString() != "")
                        AccountVo.OtherCharges = double.Parse(dr["CETA_OtherCharges"].ToString());
                    else
                        AccountVo.OtherCharges = 0;
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
                FunctionInfo.Add("Method", "CustomerTransactionDao.cs:GetCustomerMFFolioDetails()");
                object[] objects = new object[1];
                //objects[0] = FolioId;
                FunctionInfo = exBase.AddObject(FunctionInfo, objects);
                exBase.AdditionalInformation = FunctionInfo;
                ExceptionManager.Publish(exBase);
                throw exBase;

            }

            return AccountVo;


        }

        public bool UpdateCustomerEQAccountDetails(CustomerAccountsVo AccountVo, int userId)
        {
            bool blResult = false;
            Database db;
            DbCommand updateMFFolioDetailsCmd;
            try
            {
                db = DatabaseFactory.CreateDatabase("wealtherp");
                updateMFFolioDetailsCmd = db.GetStoredProcCommand("SP_UpdateCustomerTradeAccountDetails");
                db.AddInParameter(updateMFFolioDetailsCmd, "@CETA_AccountId", DbType.Int32, AccountVo.AccountId);
                db.AddInParameter(updateMFFolioDetailsCmd, "@CP_PortfolioId", DbType.Int32, AccountVo.PortfolioId);
                db.AddInParameter(updateMFFolioDetailsCmd, "@XB_BrokerCode", DbType.String, AccountVo.BrokerCode);
                db.AddInParameter(updateMFFolioDetailsCmd, "@CETA_TradeAccountNum", DbType.String, AccountVo.TradeNum);
                db.AddInParameter(updateMFFolioDetailsCmd, "@CETA_BrokerDeliveryPercentage", DbType.Double, AccountVo.BrokerageDeliveryPercentage);
                db.AddInParameter(updateMFFolioDetailsCmd, "@CETA_BrokerSpeculativePercentage", DbType.Double, AccountVo.BrokerageSpeculativePercentage);
                db.AddInParameter(updateMFFolioDetailsCmd, "@CETA_OtherCharges", DbType.Double, AccountVo.OtherCharges);
                if (AccountVo.AccountOpeningDate != DateTime.MinValue)
                    db.AddInParameter(updateMFFolioDetailsCmd, "@CETA_AccountOpeningDate", DbType.DateTime, AccountVo.AccountOpeningDate);
                db.AddInParameter(updateMFFolioDetailsCmd, "@ModifiedBy", DbType.Int32, userId);
                if (db.ExecuteNonQuery(updateMFFolioDetailsCmd) != 0)
                    blResult = true;
            }
            catch (BaseApplicationException Ex)
            {
                throw Ex;
            }
            catch (Exception Ex)
            {
                BaseApplicationException exBase = new BaseApplicationException(Ex.Message, Ex);
                NameValueCollection FunctionInfo = new NameValueCollection();
                FunctionInfo.Add("Method", "CustomerTransactionDao.cs:UpdateCustomerMFFolioDetails()");
                object[] objects = new object[2];
                objects[0] = AccountVo;
                objects[1] = userId;
                FunctionInfo = exBase.AddObject(FunctionInfo, objects);
                exBase.AdditionalInformation = FunctionInfo;
                ExceptionManager.Publish(exBase);
                throw exBase;

            }
            return blResult;
        }


        #endregion Equity Transactions

        #region Mutual Fund Transactions
        public bool RunMFTRansactionsCancellationJob()
        {
            bool bResult = false;
            Database db;
            DbCommand MFCancellationJobCmd;
            try
            {
                db = DatabaseFactory.CreateDatabase("wealtherp");
                MFCancellationJobCmd = db.GetStoredProcCommand("SP_MFTransactionCancellationJob");
                MFCancellationJobCmd.CommandTimeout = 60 * 60;
                db.ExecuteNonQuery(MFCancellationJobCmd);
                bResult = true;
            }
            catch (BaseApplicationException Ex)
            {
                throw Ex;
            }
            catch (Exception Ex)
            {
                BaseApplicationException exBase = new BaseApplicationException(Ex.Message, Ex);
                NameValueCollection FunctionInfo = new NameValueCollection();

                FunctionInfo.Add("Method", "CustomerTransactionDao.cs:AddMFTransaction()");


                object[] objects = new object[1];
                objects[0] = bResult;


                FunctionInfo = exBase.AddObject(FunctionInfo, objects);
                exBase.AdditionalInformation = FunctionInfo;
                ExceptionManager.Publish(exBase);
                throw exBase;

            }
            return bResult;
        }
        public int AddMFTransaction(MFTransactionVo mfTransactionVo, int userId)
        {
            int transactionId = 0;
            Database db;
            DbCommand createMFTransactionCmd;
            try
            {
                db = DatabaseFactory.CreateDatabase("wealtherp");
                createMFTransactionCmd = db.GetStoredProcCommand("SP_AddMutualFundTransaction");

                db.AddInParameter(createMFTransactionCmd, "@CMFA_AccountId", DbType.Int32, mfTransactionVo.AccountId);
                db.AddInParameter(createMFTransactionCmd, "@PASP_SchemePlanCode", DbType.Int32, mfTransactionVo.MFCode);
                db.AddInParameter(createMFTransactionCmd, "@CMFT_TransactionDate", DbType.DateTime, mfTransactionVo.TransactionDate);
                db.AddInParameter(createMFTransactionCmd, "@CMFT_BuySell", DbType.String, mfTransactionVo.BuySell);

                db.AddInParameter(createMFTransactionCmd, "@CMFT_DividendRate", DbType.Decimal, mfTransactionVo.DividendRate);
                db.AddInParameter(createMFTransactionCmd, "@CMFT_NAV", DbType.Decimal, mfTransactionVo.NAV);
                db.AddInParameter(createMFTransactionCmd, "@CMFT_Price", DbType.Decimal, mfTransactionVo.Price);
                db.AddInParameter(createMFTransactionCmd, "@CMFT_Amount", DbType.Decimal, mfTransactionVo.Amount);
                db.AddInParameter(createMFTransactionCmd, "@CMFT_Units", DbType.Decimal, mfTransactionVo.Units);
                db.AddInParameter(createMFTransactionCmd, "@CMFT_STT", DbType.Decimal, mfTransactionVo.STT);
                db.AddInParameter(createMFTransactionCmd, "@CMFT_IsSourceManual", DbType.Int32, mfTransactionVo.IsSourceManual);

                db.AddInParameter(createMFTransactionCmd, "@XES_SourceCode", DbType.String, mfTransactionVo.Source);
                db.AddInParameter(createMFTransactionCmd, "@CMFT_SwitchSourceTrxId", DbType.Int32, mfTransactionVo.SwitchSourceTrxId);
                db.AddInParameter(createMFTransactionCmd, "@WMTT_TransactionClassificationCode", DbType.String, mfTransactionVo.TransactionClassificationCode);
                db.AddInParameter(createMFTransactionCmd, "@CMFT_ModifiedBy", DbType.Int32, userId);
                db.AddInParameter(createMFTransactionCmd, "@CMFT_CreatedBy", DbType.Int32, userId);
                db.AddOutParameter(createMFTransactionCmd, "CMFT_MFTransId", DbType.Int32, 50000);

                if (db.ExecuteNonQuery(createMFTransactionCmd) != 0)
                    transactionId = int.Parse(db.GetParameterValue(createMFTransactionCmd, "CMFT_MFTransId").ToString());


            }
            catch (BaseApplicationException Ex)
            {
                throw Ex;
            }
            catch (Exception Ex)
            {
                BaseApplicationException exBase = new BaseApplicationException(Ex.Message, Ex);
                NameValueCollection FunctionInfo = new NameValueCollection();

                FunctionInfo.Add("Method", "CustomerTransactionDao.cs:AddMFTransaction()");


                object[] objects = new object[2];
                objects[0] = mfTransactionVo;
                objects[1] = userId;

                FunctionInfo = exBase.AddObject(FunctionInfo, objects);
                exBase.AdditionalInformation = FunctionInfo;
                ExceptionManager.Publish(exBase);
                throw exBase;

            }
            return transactionId;
        }

        public List<MFTransactionVo> GetMFTransactions(int customerId, int portfolioId, DateTime FromDate, DateTime ToDate)
        {
            List<MFTransactionVo> mfTransactionsList = null;
            MFTransactionVo mfTransactionVo = new MFTransactionVo();
            Database db;
            DbCommand getMFTransactionsCmd;
            DataSet dsGetMFTransactions;
            DataTable dtGetMFTransactions;
            //genDictTranType = new Dictionary<string, string>();
            //genDictTranTrigger = new Dictionary<string, string>();
            //genDictTranDate = new Dictionary<string, string>();

            //Count = 0;

            try
            {
                db = DatabaseFactory.CreateDatabase("wealtherp");
                getMFTransactionsCmd = db.GetStoredProcCommand("SP_GetCustomerMutualFundTransactions");
                db.AddInParameter(getMFTransactionsCmd, "@C_CustomerId", DbType.Int32, customerId);
                db.AddInParameter(getMFTransactionsCmd, "@CP_PortfolioId", DbType.Int32, portfolioId);
                //db.AddInParameter(getMFTransactionsCmd, "@CurrentPage", DbType.Int32, CurrentPage);
                //db.AddInParameter(getMFTransactionsCmd, "@export", DbType.Int32, export);
                //if (SchemeFilter != "")
                //    db.AddInParameter(getMFTransactionsCmd, "@schemeFilter", DbType.String, SchemeFilter);
                //else
                //    db.AddInParameter(getMFTransactionsCmd, "@schemeFilter", DbType.String, DBNull.Value);
                //if (folioFilter != "")
                //    db.AddInParameter(getMFTransactionsCmd, "@folioFilter", DbType.String, folioFilter);
                //else
                //    db.AddInParameter(getMFTransactionsCmd, "@folioFilter", DbType.String, DBNull.Value);
                //if (TypeFilter != "")
                //    db.AddInParameter(getMFTransactionsCmd, "@typeFilter", DbType.String, TypeFilter);
                //else
                //    db.AddInParameter(getMFTransactionsCmd, "@typeFilter", DbType.String, DBNull.Value);
                //if (TriggerFilter != "")
                //    db.AddInParameter(getMFTransactionsCmd, "@triggerFilter", DbType.String, TriggerFilter);
                //else
                //    db.AddInParameter(getMFTransactionsCmd, "@triggerFilter", DbType.String, DBNull.Value);
                //if (DateFilter != "")
                //    db.AddInParameter(getMFTransactionsCmd, "@dateFilter", DbType.String, DateFilter);
                //else
                //    db.AddInParameter(getMFTransactionsCmd, "@dateFilter", DbType.String, DBNull.Value);
                //if (TransactionCode != "")
                //    db.AddInParameter(getMFTransactionsCmd, "@TransactionStatusCode", DbType.Int16, Int16.Parse(TransactionCode));
                //else
                //    db.AddInParameter(getMFTransactionsCmd, "@TransactionStatusCode", DbType.Int16, 1);

                //if (ProcessId != 0)
                //    db.AddInParameter(getMFTransactionsCmd, "@ProcessId", DbType.String, ProcessId);
                //else
                //    db.AddInParameter(getMFTransactionsCmd, "@ProcessId", DbType.String, DBNull.Value);

                //db.AddInParameter(getMFTransactionsCmd, "@sortExpression", DbType.String, SortExpression);
                db.AddInParameter(getMFTransactionsCmd, "@FromTransactionDate", DbType.DateTime, FromDate);
                db.AddInParameter(getMFTransactionsCmd, "@ToTransactionDate", DbType.DateTime, ToDate);
                getMFTransactionsCmd.CommandTimeout = 60 * 60;
                dsGetMFTransactions = db.ExecuteDataSet(getMFTransactionsCmd);
                if (dsGetMFTransactions.Tables[0].Rows.Count > 0)
                {
                    dtGetMFTransactions = dsGetMFTransactions.Tables[0];
                    mfTransactionsList = new List<MFTransactionVo>();
                    foreach (DataRow dr in dtGetMFTransactions.Rows)
                    {
                        mfTransactionVo = new MFTransactionVo();
                        if (dr["ADUL_ProcessId"].ToString() != null && dr["ADUL_ProcessId"].ToString() != string.Empty)
                            mfTransactionVo.ProcessId = int.Parse(dr["ADUL_ProcessId"].ToString());
                        else
                            mfTransactionVo.ProcessId = 0;

                        if (dr["CMFT_SubBrokerCode"].ToString() != null && dr["CMFT_SubBrokerCode"].ToString() != string.Empty)
                            mfTransactionVo.SubBrokerCode = dr["CMFT_SubBrokerCode"].ToString();
                        else
                            mfTransactionVo.SubBrokerCode = "N/A";

                        if (dr["PAISC_AssetInstrumentSubCategoryName"].ToString() != null && dr["PAISC_AssetInstrumentSubCategoryName"].ToString() != string.Empty)
                            mfTransactionVo.SubCategoryName = dr["PAISC_AssetInstrumentSubCategoryName"].ToString();
                        else
                            mfTransactionVo.SubCategoryName = "N/A";
                        mfTransactionVo.TransactionId = int.Parse(dr["CMFT_MFTransId"].ToString());
                        mfTransactionVo.CustomerId = int.Parse(dr["C_CustomerId"].ToString());
                        mfTransactionVo.PortfolioId = int.Parse(dr["CP_PortfolioId"].ToString());
                        mfTransactionVo.AccountId = int.Parse(dr["CMFA_AccountId"].ToString());
                        mfTransactionVo.MFCode = int.Parse(dr["PASP_SchemePlanCode"].ToString());
                        mfTransactionVo.SchemePlan = dr["PASP_SchemePlanName"].ToString();
                        mfTransactionVo.BuySell = dr["CMFT_BuySell"].ToString();
                        mfTransactionVo.DividendRate = float.Parse(dr["CMFT_DividendRate"].ToString());
                        mfTransactionVo.TransactionDate = DateTime.Parse(dr["CMFT_TransactionDate"].ToString());
                        mfTransactionVo.NAV = float.Parse(dr["CMFT_NAV"].ToString());
                        mfTransactionVo.Price = float.Parse(dr["CMFT_Price"].ToString());
                        mfTransactionVo.Amount = float.Parse(dr["CMFT_Amount"].ToString());
                        mfTransactionVo.Units = float.Parse(dr["CMFT_Units"].ToString());
                        mfTransactionVo.STT = float.Parse(dr["CMFT_STT"].ToString());
                        if (!string.IsNullOrEmpty(dr["CMFT_IsSourceManual"].ToString()))
                            mfTransactionVo.IsSourceManual = int.Parse(dr["CMFT_IsSourceManual"].ToString());
                        mfTransactionVo.Source = dr["XES_SourceCode"].ToString();
                        mfTransactionVo.SwitchSourceTrxId = int.Parse(dr["CMFT_SwitchSourceTrxId"].ToString());
                        mfTransactionVo.TransactionClassificationCode = dr["WMTT_TransactionClassificationCode"].ToString();
                        mfTransactionVo.TransactionType = dr["WMTT_TransactionClassificationName"].ToString();
                        mfTransactionVo.TransactionTrigger = dr["WMTT_Trigger"].ToString();
                        mfTransactionVo.FinancialFlag = int.Parse(dr["WMTT_FinancialFlag"].ToString());
                        mfTransactionVo.Folio = dr["CMFA_FolioNum"].ToString();
                        mfTransactionVo.AMCCode = int.Parse(dr["PA_AMCCode"].ToString());
                        mfTransactionVo.AMCName = dr["PA_AMCName"].ToString();
                        mfTransactionVo.CategoryCode = dr["PAIC_AssetInstrumentCategoryCode"].ToString();
                        mfTransactionVo.Category = dr["PAIC_AssetInstrumentCategoryName"].ToString();
                        if (dr["WTS_TransactionStatusCode"].ToString() != null && dr["WTS_TransactionStatusCode"].ToString() != string.Empty)
                        {
                            mfTransactionVo.TransactionStatus = dr["WTS_TransactionStatus"].ToString();
                            mfTransactionVo.TransactionStatusCode = int.Parse(dr["WTS_TransactionStatusCode"].ToString());
                        }
                        else
                        {
                            mfTransactionVo.TransactionStatus = "OK";
                            mfTransactionVo.TransactionStatusCode = 1;

                        }
                        if (!string.IsNullOrEmpty(dr["CMFT_OriginalTransactionNumber"].ToString()))
                            mfTransactionVo.OriginalTransactionNumber = dr["CMFT_OriginalTransactionNumber"].ToString();
                        mfTransactionsList.Add(mfTransactionVo);
                    }
                }

                //if (dsGetMFTransactions.Tables[2].Rows.Count > 0)
                //{
                //    foreach (DataRow dr in dsGetMFTransactions.Tables[2].Rows)
                //    {
                //        genDictTranType.Add(dr["WMTT_TransactionClassificationName"].ToString(), dr["WMTT_TransactionClassificationName"].ToString());
                //    }
                //}

                //if (dsGetMFTransactions.Tables[3].Rows.Count > 0)
                //{
                //    foreach (DataRow dr in dsGetMFTransactions.Tables[3].Rows)
                //    {
                //        genDictTranDate.Add(DateTime.Parse(dr["CMFT_TransactionDate"].ToString()).ToShortDateString(), DateTime.Parse(dr["CMFT_TransactionDate"].ToString()).ToShortDateString());
                //    }
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

                FunctionInfo.Add("Method", "CustomerTransactionDao.cs:GetMFTransactions()");

                object[] objects = new object[1];
                objects[0] = customerId;

                FunctionInfo = exBase.AddObject(FunctionInfo, objects);
                exBase.AdditionalInformation = FunctionInfo;
                ExceptionManager.Publish(exBase);
                throw exBase;

            }
            //if (dsGetMFTransactions.Tables[1].Rows.Count > 0)
            //    Count = Int32.Parse(dsGetMFTransactions.Tables[1].Rows[0]["CNT"].ToString());

            return mfTransactionsList;
        }

        public int GetMFTransactions(int customerId, int portfolioId, string flag)
        {

            Database db;
            DbCommand getMFTransactionsCPCmd;
            DataSet dsGetMFTransactionsCP;

            try
            {
                db = DatabaseFactory.CreateDatabase("wealtherp");
                getMFTransactionsCPCmd = db.GetStoredProcCommand("SP_GetCustomerMutualFundTransactions");
                db.AddInParameter(getMFTransactionsCPCmd, "@C_CustomerId", DbType.Int32, customerId);
                db.AddInParameter(getMFTransactionsCPCmd, "@CP_PortfolioId", DbType.Int32, portfolioId);
                db.AddInParameter(getMFTransactionsCPCmd, "@Flag", DbType.String, flag);
                dsGetMFTransactionsCP = db.ExecuteDataSet(getMFTransactionsCPCmd);

            }
            catch (BaseApplicationException ex)
            {
                throw ex;
            }
            catch (Exception Ex)
            {
                BaseApplicationException exBase = new BaseApplicationException(Ex.Message, Ex);
                NameValueCollection FunctionInfo = new NameValueCollection();

                FunctionInfo.Add("Method", "CustomerTransactionDao.cs:GetMFTransactions()");


                object[] objects = new object[3];
                objects[0] = flag;
                objects[1] = customerId;
                objects[2] = portfolioId;
                FunctionInfo = exBase.AddObject(FunctionInfo, objects);
                exBase.AdditionalInformation = FunctionInfo;
                ExceptionManager.Publish(exBase);
                throw exBase;

            }
            return int.Parse(dsGetMFTransactionsCP.Tables[0].Rows[0][0].ToString());

        }

        public List<MFTransactionVo> GetMFTransactions(int customerId, int portfolioId)
        {
            List<MFTransactionVo> mfTransactionsList = null;
            MFTransactionVo mfTransactionVo = new MFTransactionVo();
            Database db;
            DbCommand getMFTransactionsCmd;
            DataSet dsGetMFTransactions;
            DataTable dtGetMFTransactions;
            try
            {
                db = DatabaseFactory.CreateDatabase("wealtherp");
                getMFTransactionsCmd = db.GetStoredProcCommand("SP_GetCustomerPortfolioMutualFundTransactions");
                db.AddInParameter(getMFTransactionsCmd, "@C_CustomerId", DbType.Int32, customerId);
                db.AddInParameter(getMFTransactionsCmd, "@CP_PortfolioId", DbType.Int32, portfolioId);
                dsGetMFTransactions = db.ExecuteDataSet(getMFTransactionsCmd);
                if (dsGetMFTransactions.Tables[0].Rows.Count > 0)
                {
                    dtGetMFTransactions = dsGetMFTransactions.Tables[0];
                    mfTransactionsList = new List<MFTransactionVo>();
                    foreach (DataRow dr in dtGetMFTransactions.Rows)
                    {
                        mfTransactionVo = new MFTransactionVo();
                        mfTransactionVo.TransactionId = int.Parse(dr["CMFT_MFTransId"].ToString());
                        mfTransactionVo.CustomerId = int.Parse(dr["C_CustomerId"].ToString());
                        mfTransactionVo.PortfolioId = int.Parse(dr["CP_PortfolioId"].ToString());
                        mfTransactionVo.AccountId = int.Parse(dr["CMFA_AccountId"].ToString());
                        mfTransactionVo.MFCode = int.Parse(dr["PASP_SchemePlanCode"].ToString());
                        mfTransactionVo.SchemePlan = dr["PASP_SchemePlanName"].ToString();
                        mfTransactionVo.BuySell = dr["CMFT_BuySell"].ToString();
                        mfTransactionVo.DividendRate = float.Parse(dr["CMFT_DividendRate"].ToString());
                        mfTransactionVo.TransactionDate = DateTime.Parse(dr["CMFT_TransactionDate"].ToString());
                        mfTransactionVo.NAV = float.Parse(dr["CMFT_NAV"].ToString());
                        mfTransactionVo.Price = float.Parse(dr["CMFT_Price"].ToString());
                        mfTransactionVo.Amount = float.Parse(dr["CMFT_Amount"].ToString());
                        mfTransactionVo.Units = float.Parse(dr["CMFT_Units"].ToString());
                        mfTransactionVo.STT = float.Parse(dr["CMFT_STT"].ToString());
                        if (!string.IsNullOrEmpty(dr["CMFT_IsSourceManual"].ToString()))
                            mfTransactionVo.IsSourceManual = int.Parse(dr["CMFT_IsSourceManual"].ToString());
                        mfTransactionVo.Source = dr["XES_SourceCode"].ToString();
                        mfTransactionVo.SwitchSourceTrxId = int.Parse(dr["CMFT_SwitchSourceTrxId"].ToString());
                        mfTransactionVo.TransactionClassificationCode = dr["WMTT_TransactionClassificationCode"].ToString();
                        mfTransactionVo.TransactionType = dr["WMTT_TransactionClassificationName"].ToString();
                        mfTransactionVo.TransactionTrigger = dr["WMTT_Trigger"].ToString();
                        mfTransactionVo.FinancialFlag = int.Parse(dr["WMTT_FinancialFlag"].ToString());


                        mfTransactionsList.Add(mfTransactionVo);
                    }
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

                FunctionInfo.Add("Method", "CustomerTransactionDao.cs:GetMFTransactions()");


                object[] objects = new object[2];
                objects[0] = customerId;
                objects[1] = portfolioId;

                FunctionInfo = exBase.AddObject(FunctionInfo, objects);
                exBase.AdditionalInformation = FunctionInfo;
                ExceptionManager.Publish(exBase);
                throw exBase;

            }
            return mfTransactionsList;
        }

        public List<MFTransactionVo> GetMFTransactions(int customerId, int accountId, int mfCode, DateTime tradeDate)
        {
            List<MFTransactionVo> mfTransactionsList = null;
            MFTransactionVo mfTransactionVo = new MFTransactionVo();
            Database db;
            DbCommand getMFTransactionsCmd;
            DataSet dsGetMFTransactions;
            DataTable dtGetMFTransactions;
            try
            {
                db = DatabaseFactory.CreateDatabase("wealtherp");
                getMFTransactionsCmd = db.GetStoredProcCommand("SP_GetCustomerMutualFundSpecificTransactions");
                db.AddInParameter(getMFTransactionsCmd, "@C_CustomerId", DbType.Int32, customerId);
                db.AddInParameter(getMFTransactionsCmd, "@PASP_SchemePlanCode", DbType.Int32, mfCode);
                db.AddInParameter(getMFTransactionsCmd, "@CMFA_AccountId", DbType.Int32, accountId);
                db.AddInParameter(getMFTransactionsCmd, "@CMFT_TransactionDate", DbType.DateTime, tradeDate);

                dsGetMFTransactions = db.ExecuteDataSet(getMFTransactionsCmd);
                if (dsGetMFTransactions.Tables[0].Rows.Count > 0)
                {
                    dtGetMFTransactions = dsGetMFTransactions.Tables[0];
                    mfTransactionsList = new List<MFTransactionVo>();
                    foreach (DataRow dr in dtGetMFTransactions.Rows)
                    {
                        mfTransactionVo = new MFTransactionVo();
                        mfTransactionVo.TransactionId = int.Parse(dr["CMFT_MFTransId"].ToString());
                        mfTransactionVo.CustomerId = int.Parse(dr["C_CustomerId"].ToString());
                        mfTransactionVo.PortfolioId = int.Parse(dr["CP_PortfolioId"].ToString());
                        mfTransactionVo.AccountId = int.Parse(dr["CMFA_AccountId"].ToString());
                        mfTransactionVo.MFCode = int.Parse(dr["PASP_SchemePlanCode"].ToString());
                        mfTransactionVo.SchemePlan = dr["PASP_SchemePlanName"].ToString();
                        mfTransactionVo.BuySell = dr["CMFT_BuySell"].ToString();
                        mfTransactionVo.DividendRate = float.Parse(dr["CMFT_DividendRate"].ToString());
                        mfTransactionVo.TransactionDate = DateTime.Parse(dr["CMFT_TransactionDate"].ToString());
                        mfTransactionVo.NAV = float.Parse(dr["CMFT_NAV"].ToString());
                        mfTransactionVo.Price = float.Parse(dr["CMFT_Price"].ToString());
                        mfTransactionVo.Amount = float.Parse(dr["CMFT_Amount"].ToString());
                        mfTransactionVo.Units = float.Parse(dr["CMFT_Units"].ToString());
                        mfTransactionVo.STT = float.Parse(dr["CMFT_STT"].ToString());
                        mfTransactionVo.IsSourceManual = int.Parse(dr["CMFT_IsSourceManual"].ToString());
                        mfTransactionVo.Source = dr["XES_SourceCode"].ToString();
                        mfTransactionVo.SwitchSourceTrxId = int.Parse(dr["CMFT_SwitchSourceTrxId"].ToString());
                        mfTransactionVo.TransactionClassificationCode = dr["WMTT_TransactionClassificationCode"].ToString();
                        mfTransactionVo.TransactionType = dr["WMTT_TransactionClassificationName"].ToString();
                        mfTransactionVo.TransactionTrigger = dr["WMTT_Trigger"].ToString();
                        mfTransactionVo.FinancialFlag = int.Parse(dr["WMTT_FinancialFlag"].ToString());

                        mfTransactionsList.Add(mfTransactionVo);
                    }
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

                FunctionInfo.Add("Method", "CustomerTransactionDao.cs:GetMFTransactions()");


                object[] objects = new object[4];
                objects[0] = customerId;
                objects[1] = accountId;
                objects[2] = mfCode;
                objects[3] = tradeDate;

                FunctionInfo = exBase.AddObject(FunctionInfo, objects);
                exBase.AdditionalInformation = FunctionInfo;
                ExceptionManager.Publish(exBase);
                throw exBase;

            }

            return mfTransactionsList;
        }

        public List<MFTransactionVo> GetMFTransactions(int customerId, int portfolioId, int accountId, int mfCode, DateTime tradeDate)
        {
            List<MFTransactionVo> mfTransactionsList = null;


            MFTransactionVo mfTransactionVo = new MFTransactionVo();
            Database db;
            DbCommand getMFTransactionsCmd;
            DataSet dsGetMFTransactions;
            DataTable dtGetMFTransactions;
            try
            {
                db = DatabaseFactory.CreateDatabase("wealtherp");
                getMFTransactionsCmd = db.GetStoredProcCommand("SP_GetCustomerPortfolioMutualFundSpecificTransactions");
                db.AddInParameter(getMFTransactionsCmd, "@C_CustomerId", DbType.Int32, customerId);
                db.AddInParameter(getMFTransactionsCmd, "@CP_PortfolioId", DbType.Int32, portfolioId);
                db.AddInParameter(getMFTransactionsCmd, "@PASP_SchemePlanCode", DbType.Int32, mfCode);
                db.AddInParameter(getMFTransactionsCmd, "@CMFA_AccountId", DbType.Int32, accountId);
                db.AddInParameter(getMFTransactionsCmd, "@CMFT_TransactionDate", DbType.DateTime, tradeDate);

                dsGetMFTransactions = db.ExecuteDataSet(getMFTransactionsCmd);
                if (dsGetMFTransactions.Tables[0].Rows.Count > 0)
                {
                    dtGetMFTransactions = dsGetMFTransactions.Tables[0];
                    mfTransactionsList = new List<MFTransactionVo>();
                    foreach (DataRow dr in dtGetMFTransactions.Rows)
                    {
                        mfTransactionVo = new MFTransactionVo();
                        mfTransactionVo.TransactionId = int.Parse(dr["CMFT_MFTransId"].ToString());
                        mfTransactionVo.CustomerId = int.Parse(dr["C_CustomerId"].ToString());
                        mfTransactionVo.PortfolioId = int.Parse(dr["CP_PortfolioId"].ToString());
                        mfTransactionVo.AccountId = int.Parse(dr["CMFA_AccountId"].ToString());
                        mfTransactionVo.MFCode = int.Parse(dr["PASP_SchemePlanCode"].ToString());
                        mfTransactionVo.SchemePlan = dr["PASP_SchemePlanName"].ToString();
                        mfTransactionVo.BuySell = dr["CMFT_BuySell"].ToString();
                        mfTransactionVo.DividendRate = float.Parse(dr["CMFT_DividendRate"].ToString());
                        mfTransactionVo.TransactionDate = DateTime.Parse(dr["CMFT_TransactionDate"].ToString());
                        mfTransactionVo.NAV = float.Parse(dr["CMFT_NAV"].ToString());
                        mfTransactionVo.Price = float.Parse(dr["CMFT_Price"].ToString());
                        mfTransactionVo.Amount = float.Parse(dr["CMFT_Amount"].ToString());
                        mfTransactionVo.Units = double.Parse(dr["CMFT_Units"].ToString());
                        mfTransactionVo.STT = float.Parse(dr["CMFT_STT"].ToString());
                        mfTransactionVo.IsSourceManual = int.Parse(dr["CMFT_IsSourceManual"].ToString());
                        mfTransactionVo.Source = dr["XES_SourceCode"].ToString();
                        if (dr["CMFT_SwitchSourceTrxId"] != null && dr["CMFT_SwitchSourceTrxId"].ToString() != String.Empty)
                            mfTransactionVo.SwitchSourceTrxId = int.Parse(dr["CMFT_SwitchSourceTrxId"].ToString());
                        mfTransactionVo.TransactionClassificationCode = dr["WMTT_TransactionClassificationCode"].ToString();
                        mfTransactionVo.TransactionType = dr["WMTT_TransactionClassificationName"].ToString();
                        mfTransactionVo.TransactionTrigger = dr["WMTT_Trigger"].ToString();
                        mfTransactionVo.FinancialFlag = int.Parse(dr["WMTT_FinancialFlag"].ToString());

                        mfTransactionsList.Add(mfTransactionVo);
                    }
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

                FunctionInfo.Add("Method", "CustomerTransactionDao.cs:GetMFTransactions()");


                object[] objects = new object[5];
                objects[0] = customerId;
                objects[1] = portfolioId;
                objects[2] = accountId;
                objects[3] = mfCode;
                objects[4] = tradeDate;

                FunctionInfo = exBase.AddObject(FunctionInfo, objects);
                exBase.AdditionalInformation = FunctionInfo;
                ExceptionManager.Publish(exBase);
                throw exBase;

            }

            return mfTransactionsList;
        }

        public List<MFTransactionVo> GetMFRejectTransactions(int portfolioId, int adviserId)
        {
            List<MFTransactionVo> mfTransactionsList = null;
            MFTransactionVo mfTransactionVo = new MFTransactionVo();
            Database db;
            DbCommand getMFTransactionsCmd;
            DataSet dsGetMFTransactions;
            DataTable dtGetMFTransactions;
            try
            {
                db = DatabaseFactory.CreateDatabase("wealtherp");
                getMFTransactionsCmd = db.GetStoredProcCommand("SP_GetMFRejectTransactions");

                db.AddInParameter(getMFTransactionsCmd, "@CP_PortfolioId", DbType.Int32, portfolioId);
                db.AddInParameter(getMFTransactionsCmd, "@A_AdviserId", DbType.Int32, adviserId);
                dsGetMFTransactions = db.ExecuteDataSet(getMFTransactionsCmd);
                if (dsGetMFTransactions.Tables[0].Rows.Count > 0)
                {
                    dtGetMFTransactions = dsGetMFTransactions.Tables[0];
                    mfTransactionsList = new List<MFTransactionVo>();
                    foreach (DataRow dr in dtGetMFTransactions.Rows)
                    {
                        mfTransactionVo = new MFTransactionVo();
                        mfTransactionVo.CustomerName = dr["NAME"].ToString();
                        mfTransactionVo.TransactionId = int.Parse(dr["CMFT_MFTransId"].ToString());
                        mfTransactionVo.CustomerId = int.Parse(dr["C_CustomerId"].ToString());
                        mfTransactionVo.PortfolioId = int.Parse(dr["CP_PortfolioId"].ToString());
                        mfTransactionVo.AccountId = int.Parse(dr["CMFA_AccountId"].ToString());
                        mfTransactionVo.Folio = dr["CMFA_FolioNum"].ToString();
                        mfTransactionVo.MFCode = int.Parse(dr["PASP_SchemePlanCode"].ToString());
                        mfTransactionVo.SchemePlan = dr["PASP_SchemePlanName"].ToString();
                        mfTransactionVo.BuySell = dr["CMFT_BuySell"].ToString();
                        mfTransactionVo.DividendRate = float.Parse(dr["CMFT_DividendRate"].ToString());
                        mfTransactionVo.TransactionDate = DateTime.Parse(dr["CMFT_TransactionDate"].ToString());
                        mfTransactionVo.NAV = float.Parse(dr["CMFT_NAV"].ToString());
                        mfTransactionVo.Price = float.Parse(dr["CMFT_Price"].ToString());
                        mfTransactionVo.Amount = float.Parse(dr["CMFT_Amount"].ToString());
                        mfTransactionVo.Units = float.Parse(dr["CMFT_Units"].ToString());
                        mfTransactionVo.STT = float.Parse(dr["CMFT_STT"].ToString());
                        mfTransactionVo.IsSourceManual = int.Parse(dr["CMFT_IsSourceManual"].ToString());
                        mfTransactionVo.Source = dr["XES_SourceCode"].ToString();
                        mfTransactionVo.SwitchSourceTrxId = int.Parse(dr["CMFT_SwitchSourceTrxId"].ToString());
                        mfTransactionVo.TransactionClassificationCode = dr["WMTT_TransactionClassificationCode"].ToString();
                        mfTransactionVo.TransactionType = dr["WMTT_TransactionClassificationName"].ToString();
                        mfTransactionVo.TransactionTrigger = dr["WMTT_Trigger"].ToString();
                        mfTransactionVo.FinancialFlag = int.Parse(dr["WMTT_FinancialFlag"].ToString());


                        mfTransactionsList.Add(mfTransactionVo);
                    }
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

                FunctionInfo.Add("Method", "CustomerTransactionDao.cs:GetMFRejectTransactions(int portfolioId)");


                object[] objects = new object[2];
                objects[0] = portfolioId;


                FunctionInfo = exBase.AddObject(FunctionInfo, objects);
                exBase.AdditionalInformation = FunctionInfo;
                ExceptionManager.Publish(exBase);
                throw exBase;

            }
            return mfTransactionsList;
        }
        public List<MFTransactionVo> GetMFOriginalTransactions(int MFTransId)
        {
            List<MFTransactionVo> mfTransactionsList = null;
            MFTransactionVo mfTransactionVo = new MFTransactionVo();
            Database db;
            DbCommand getMFTransactionsCmd;
            DataSet dsGetMFTransactions;
            DataTable dtGetMFTransactions;
            try
            {
                db = DatabaseFactory.CreateDatabase("wealtherp");
                getMFTransactionsCmd = db.GetStoredProcCommand("SP_GetMFOriginalTransactions");

                db.AddInParameter(getMFTransactionsCmd, "@MFTransID", DbType.Int32, MFTransId);
                dsGetMFTransactions = db.ExecuteDataSet(getMFTransactionsCmd);
                if (dsGetMFTransactions.Tables[0].Rows.Count > 0)
                {
                    dtGetMFTransactions = dsGetMFTransactions.Tables[0];
                    mfTransactionsList = new List<MFTransactionVo>();
                    foreach (DataRow dr in dtGetMFTransactions.Rows)
                    {
                        mfTransactionVo = new MFTransactionVo();
                        mfTransactionVo.TransactionId = int.Parse(dr["CMFT_MFTransId"].ToString());
                        mfTransactionVo.CustomerId = int.Parse(dr["C_CustomerId"].ToString());
                        mfTransactionVo.PortfolioId = int.Parse(dr["CP_PortfolioId"].ToString());
                        mfTransactionVo.AccountId = int.Parse(dr["CMFA_AccountId"].ToString());
                        mfTransactionVo.Folio = dr["CMFA_FolioNum"].ToString();
                        mfTransactionVo.MFCode = int.Parse(dr["PASP_SchemePlanCode"].ToString());
                        mfTransactionVo.SchemePlan = dr["PASP_SchemePlanName"].ToString();
                        mfTransactionVo.BuySell = dr["CMFT_BuySell"].ToString();
                        mfTransactionVo.DividendRate = float.Parse(dr["CMFT_DividendRate"].ToString());
                        mfTransactionVo.TransactionDate = DateTime.Parse(dr["CMFT_TransactionDate"].ToString());
                        mfTransactionVo.NAV = float.Parse(dr["CMFT_NAV"].ToString());
                        mfTransactionVo.Price = float.Parse(dr["CMFT_Price"].ToString());
                        mfTransactionVo.Amount = float.Parse(dr["CMFT_Amount"].ToString());
                        mfTransactionVo.Units = float.Parse(dr["CMFT_Units"].ToString());
                        mfTransactionVo.STT = float.Parse(dr["CMFT_STT"].ToString());
                        mfTransactionVo.IsSourceManual = int.Parse(dr["CMFT_IsSourceManual"].ToString());
                        mfTransactionVo.Source = dr["XES_SourceCode"].ToString();
                        mfTransactionVo.SwitchSourceTrxId = int.Parse(dr["CMFT_SwitchSourceTrxId"].ToString());
                        mfTransactionVo.TransactionClassificationCode = dr["WMTT_TransactionClassificationCode"].ToString();
                        mfTransactionVo.TransactionType = dr["WMTT_TransactionClassificationName"].ToString();
                        mfTransactionVo.TransactionTrigger = dr["WMTT_Trigger"].ToString();
                        mfTransactionVo.FinancialFlag = int.Parse(dr["WMTT_FinancialFlag"].ToString());


                        mfTransactionsList.Add(mfTransactionVo);
                    }
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

                FunctionInfo.Add("Method", "CustomerTransactionDao.cs:GetMFOriginalTransactions(int portfolioId)");


                object[] objects = new object[2];
                objects[0] = MFTransId;


                FunctionInfo = exBase.AddObject(FunctionInfo, objects);
                exBase.AdditionalInformation = FunctionInfo;
                ExceptionManager.Publish(exBase);
                throw exBase;

            }
            return mfTransactionsList;
        }

        public List<MFSystematicVo> GetMFSystematicTransactionSetups(int adviserId, DateTime fromDate, DateTime toDate, string customerSearch, string schemeSearch, string transType, string portfolioType, out List<string> transactionTypeList)
        {
            List<MFSystematicVo> mfSystematicVoList = new List<MFSystematicVo>();
            MFSystematicVo mfSystematicVo;
            Database db;
            DbCommand getMFTransactionsCmd;
            DataSet dsGetMFTransactions;
            DataTable dtGetMFTransactions;
            DataTable dtTransactionType;
            transactionTypeList = new List<string>();
            try
            {
                db = DatabaseFactory.CreateDatabase("wealtherp");
                getMFTransactionsCmd = db.GetStoredProcCommand("SP_GetMFSystematicTransactionSetups");

                db.AddInParameter(getMFTransactionsCmd, "@A_AdviserId", DbType.Int32, adviserId);
                db.AddInParameter(getMFTransactionsCmd, "@StartDate", DbType.DateTime, fromDate);
                db.AddInParameter(getMFTransactionsCmd, "@EndDate", DbType.DateTime, toDate);
                if (schemeSearch != "")
                    db.AddInParameter(getMFTransactionsCmd, "@schemeFilter", DbType.String, schemeSearch);
                else
                    db.AddInParameter(getMFTransactionsCmd, "@schemeFilter", DbType.DateTime, DBNull.Value);
                if (customerSearch != "")
                    db.AddInParameter(getMFTransactionsCmd, "@NameFilter", DbType.String, customerSearch);
                else
                    db.AddInParameter(getMFTransactionsCmd, "@NameFilter", DbType.String, DBNull.Value);
                if (transType != "")
                    db.AddInParameter(getMFTransactionsCmd, "@typeFilter", DbType.String, transType);
                else
                    db.AddInParameter(getMFTransactionsCmd, "@typeFilter", DbType.String, DBNull.Value);
                if (portfolioType != "")
                    db.AddInParameter(getMFTransactionsCmd, "@portfolioType", DbType.String, portfolioType);
                else
                    db.AddInParameter(getMFTransactionsCmd, "@portfolioType", DbType.String, DBNull.Value);

                dsGetMFTransactions = db.ExecuteDataSet(getMFTransactionsCmd);
                if (dsGetMFTransactions.Tables[0].Rows.Count > 0)
                {
                    dtGetMFTransactions = dsGetMFTransactions.Tables[0];

                    mfSystematicVoList = new List<MFSystematicVo>();
                    foreach (DataRow dr in dtGetMFTransactions.Rows)
                    {
                        mfSystematicVo = new MFSystematicVo();
                        mfSystematicVo.AccountId = int.Parse(dr["CMFA_AccountId"].ToString());
                        mfSystematicVo.AdviserId = int.Parse(dr["A_AdviserId"].ToString());
                        mfSystematicVo.Amount = double.Parse(dr["CMFSS_Amount"].ToString());
                        mfSystematicVo.CustomerId = int.Parse(dr["C_CustomerId"].ToString());
                        mfSystematicVo.CustomerName = dr["CustomerName"].ToString();
                        mfSystematicVo.EndDate = DateTime.Parse(dr["CMFSS_EndDate"].ToString());
                        mfSystematicVo.FolioNum = dr["CMFA_FolioNum"].ToString();
                        mfSystematicVo.FrequencyCode = dr["XF_FrequencyCode"].ToString();
                        mfSystematicVo.PortfolioId = int.Parse(dr["CP_PortfolioId"].ToString());
                        mfSystematicVo.SchemePlanCode = int.Parse(dr["PASP_SchemePlanCode"].ToString());
                        mfSystematicVo.SchemePlanName = dr["PASP_SchemePlanName"].ToString();
                        mfSystematicVo.StartDate = DateTime.Parse(dr["CMFSS_StartDate"].ToString());
                        if (!string.IsNullOrEmpty(dr["PASP_SchemePlanCodeSwitch"].ToString()))
                            mfSystematicVo.SwitchSchemePlanCode = int.Parse(dr["PASP_SchemePlanCodeSwitch"].ToString());
                        else
                            mfSystematicVo.SwitchSchemePlanCode = 0;
                        if (dr["SwitchScheme"] != null)
                            mfSystematicVo.SwitchSchemePlanName = dr["SwitchScheme"].ToString();
                        if (!string.IsNullOrEmpty(dr["CMFSS_SystematicDate"].ToString()))
                        mfSystematicVo.SystematicDay = int.Parse(dr["CMFSS_SystematicDate"].ToString());
                        mfSystematicVo.SystematicSetupId = int.Parse(dr["CMFSS_SystematicSetupId"].ToString());
                        mfSystematicVo.SystematicTypeCode = dr["XSTT_SystematicTypeCode"].ToString();



                        mfSystematicVoList.Add(mfSystematicVo);
                    }
                }
                if (dsGetMFTransactions.Tables[1].Rows.Count != 0)
                {
                    dtTransactionType = dsGetMFTransactions.Tables[1];
                    foreach (DataRow drt in dtTransactionType.Rows)
                    {
                        if (drt["XSTT_SystematicTypeCode"].ToString() != "STP")
                        {
                            transactionTypeList.Add(drt["XSTT_SystematicTypeCode"].ToString());
                        }
                        else
                        {
                            transactionTypeList.Add("STB");
                            transactionTypeList.Add("STS");
                        }
                    }
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

                FunctionInfo.Add("Method", "CustomerTransactionDao.cs:GetMFOriginalTransactions(int portfolioId)");


                object[] objects = new object[3];
                objects[0] = adviserId;
                objects[1] = fromDate;
                objects[2] = toDate;

                FunctionInfo = exBase.AddObject(FunctionInfo, objects);
                exBase.AdditionalInformation = FunctionInfo;
                ExceptionManager.Publish(exBase);
                throw exBase;

            }
            return mfSystematicVoList;

        }

        public List<MFSystematicTransactionVo> GetMFSystematicTransactions(int adviserId, DateTime fromDate, DateTime toDate, string customerSearch, string schemeSearch, string transType, string portfolioType, out List<string> transactionTypeList)
        {
            List<MFSystematicTransactionVo> mfSystematicTransactionVoList = new List<MFSystematicTransactionVo>();
            MFSystematicTransactionVo mfSystematicTransactionVo;
            Database db;
            DbCommand getMFTransactionsCmd;
            DataSet dsGetMFTransactions;
            DataTable dtGetMFTransactions;
            DataTable dtTransactionType;
            transactionTypeList = new List<string>();
            try
            {
                db = DatabaseFactory.CreateDatabase("wealtherp");
                getMFTransactionsCmd = db.GetStoredProcCommand("SP_GetMFSystematicTransactions");

                db.AddInParameter(getMFTransactionsCmd, "@A_AdviserId", DbType.Int32, adviserId);
                db.AddInParameter(getMFTransactionsCmd, "@StartDate", DbType.DateTime, fromDate);
                db.AddInParameter(getMFTransactionsCmd, "@EndDate", DbType.DateTime, toDate);
                if (schemeSearch != "")
                    db.AddInParameter(getMFTransactionsCmd, "@schemeFilter", DbType.String, schemeSearch);
                else
                    db.AddInParameter(getMFTransactionsCmd, "@schemeFilter", DbType.DateTime, DBNull.Value);
                if (customerSearch != "")
                    db.AddInParameter(getMFTransactionsCmd, "@NameFilter", DbType.String, customerSearch);
                else
                    db.AddInParameter(getMFTransactionsCmd, "@NameFilter", DbType.String, DBNull.Value);
                if (transType != "")
                    db.AddInParameter(getMFTransactionsCmd, "@typeFilter", DbType.String, transType);
                else
                    db.AddInParameter(getMFTransactionsCmd, "@typeFilter", DbType.String, DBNull.Value);
                if (portfolioType != "")
                    db.AddInParameter(getMFTransactionsCmd, "@portfolioType", DbType.String, portfolioType);
                else
                    db.AddInParameter(getMFTransactionsCmd, "@portfolioType", DbType.String, DBNull.Value);

                dsGetMFTransactions = db.ExecuteDataSet(getMFTransactionsCmd);
                if (dsGetMFTransactions.Tables[0].Rows.Count > 0)
                {
                    dtGetMFTransactions = dsGetMFTransactions.Tables[0];
                    mfSystematicTransactionVoList = new List<MFSystematicTransactionVo>();
                    foreach (DataRow dr in dtGetMFTransactions.Rows)
                    {
                        mfSystematicTransactionVo = new MFSystematicTransactionVo();
                        mfSystematicTransactionVo.AccountId = int.Parse(dr["CMFA_AccountId"].ToString());
                        mfSystematicTransactionVo.Amount = double.Parse(dr["CMFT_Amount"].ToString());
                        mfSystematicTransactionVo.CustomerId = int.Parse(dr["C_CustomerId"].ToString());
                        mfSystematicTransactionVo.CustomerName = dr["CustomerName"].ToString();
                        mfSystematicTransactionVo.FolioNum = dr["CMFA_FolioNum"].ToString();
                        mfSystematicTransactionVo.MFTransId = int.Parse(dr["CMFT_MFTransId"].ToString());
                        mfSystematicTransactionVo.TransactionClassificationCode = dr["WMTT_TransactionClassificationCode"].ToString();
                        mfSystematicTransactionVo.PortfolioId = int.Parse(dr["CP_PortfolioId"].ToString());
                        mfSystematicTransactionVo.SchemePlanCode = int.Parse(dr["PASP_SchemePlanCode"].ToString());
                        mfSystematicTransactionVo.SchemePlanName = dr["PASP_SchemePlanName"].ToString();
                        mfSystematicTransactionVo.TransactionDate = DateTime.Parse(dr["CMFT_TransactionDate"].ToString());



                        mfSystematicTransactionVoList.Add(mfSystematicTransactionVo);
                    }
                }
                if (dsGetMFTransactions.Tables[1].Rows.Count != 0)
                {
                    dtTransactionType = dsGetMFTransactions.Tables[1];
                    foreach (DataRow drt in dtTransactionType.Rows)
                    {
                        transactionTypeList.Add(drt["WMTT_TransactionClassificationCode"].ToString());
                    }
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

                FunctionInfo.Add("Method", "CustomerTransactionDao.cs:GetMFSystematicTransactions(int adviserId, DateTime fromDate, DateTime toDate)");


                object[] objects = new object[3];
                objects[0] = adviserId;
                objects[1] = fromDate;
                objects[2] = toDate;

                FunctionInfo = exBase.AddObject(FunctionInfo, objects);
                exBase.AdditionalInformation = FunctionInfo;
                ExceptionManager.Publish(exBase);
                throw exBase;

            }
            return mfSystematicTransactionVoList;

        }


        public MFTransactionVo GetMFTransaction(int mfTransactionId)
        {
            MFTransactionVo mfTransactionVo = null;

            Database db;
            DbCommand getMFTransactionCmd;
            DataSet dsGetMFTransaction;
            DataRow dr;
            try
            {
                db = DatabaseFactory.CreateDatabase("wealtherp");
                getMFTransactionCmd = db.GetStoredProcCommand("SP_GetCustomerMFSpecificTransaction");
                db.AddInParameter(getMFTransactionCmd, "@CMFT_MFTransId", DbType.Int32, mfTransactionId);

                dsGetMFTransaction = db.ExecuteDataSet(getMFTransactionCmd);
                if (dsGetMFTransaction.Tables[0].Rows.Count > 0)
                {
                    dr = dsGetMFTransaction.Tables[0].Rows[0];
                    mfTransactionVo = new MFTransactionVo();


                    mfTransactionVo.TransactionId = int.Parse(dr["CMFT_MFTransId"].ToString());
                    mfTransactionVo.CustomerId = int.Parse(dr["C_CustomerId"].ToString());
                    mfTransactionVo.PortfolioId = int.Parse(dr["CP_PortfolioId"].ToString());
                    mfTransactionVo.AccountId = int.Parse(dr["CMFA_AccountId"].ToString());
                    mfTransactionVo.Folio = dr["CMFA_FolioNum"].ToString();
                    mfTransactionVo.MFCode = int.Parse(dr["PASP_SchemePlanCode"].ToString());
                    mfTransactionVo.SchemePlan = dr["PASP_SchemePlanName"].ToString();
                    mfTransactionVo.BuySell = dr["CMFT_BuySell"].ToString();
                    mfTransactionVo.DividendRate = float.Parse(dr["CMFT_DividendRate"].ToString());
                    mfTransactionVo.TransactionDate = DateTime.Parse(dr["CMFT_TransactionDate"].ToString());
                    mfTransactionVo.NAV = float.Parse(dr["CMFT_NAV"].ToString());
                    mfTransactionVo.Price = float.Parse(dr["CMFT_Price"].ToString());
                    mfTransactionVo.Amount = float.Parse(dr["CMFT_Amount"].ToString());
                    mfTransactionVo.Units = float.Parse(dr["CMFT_Units"].ToString());
                    mfTransactionVo.STT = float.Parse(dr["CMFT_STT"].ToString());
                    mfTransactionVo.IsSourceManual = int.Parse(dr["CMFT_IsSourceManual"].ToString());
                    mfTransactionVo.Source = dr["XES_SourceCode"].ToString();
                    mfTransactionVo.SwitchSourceTrxId = int.Parse(dr["CMFT_SwitchSourceTrxId"].ToString());
                    mfTransactionVo.TransactionClassificationCode = dr["WMTT_TransactionClassificationCode"].ToString();
                    mfTransactionVo.TransactionType = dr["WMTT_TransactionClassificationName"].ToString();
                    mfTransactionVo.TransactionTrigger = dr["WMTT_Trigger"].ToString();
                    mfTransactionVo.FinancialFlag = int.Parse(dr["WMTT_FinancialFlag"].ToString());
                    if (dr["WTS_TransactionStatusCode"].ToString() != null && dr["WTS_TransactionStatusCode"].ToString() != string.Empty)
                    {
                        mfTransactionVo.TransactionStatus = dr["WTS_TransactionStatus"].ToString();
                        mfTransactionVo.TransactionStatusCode = int.Parse(dr["WTS_TransactionStatusCode"].ToString());
                    }
                    else
                    {
                        mfTransactionVo.TransactionStatus = "OK";
                        mfTransactionVo.TransactionStatusCode = 1;

                    }
                    mfTransactionVo.AMCCode = int.Parse(dr["PA_AMCCode"].ToString());
                    mfTransactionVo.AMCName = dr["PA_AMCName"].ToString();
                    mfTransactionVo.CategoryCode = dr["PAIC_AssetInstrumentCategoryCode"].ToString();
                    mfTransactionVo.Category = dr["PAIC_AssetInstrumentCategoryName"].ToString();
                    mfTransactionVo.OriginalTransactionNumber = dr["CMFT_OriginalTransactionNumber"].ToString();
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

                FunctionInfo.Add("Method", "CustomerTransactionDao.cs:GetMFTransaction()");


                object[] objects = new object[1];
                objects[0] = mfTransactionId;

                FunctionInfo = exBase.AddObject(FunctionInfo, objects);
                exBase.AdditionalInformation = FunctionInfo;
                ExceptionManager.Publish(exBase);
                throw exBase;

            }

            return mfTransactionVo;
        }

        public bool UpdateMFTransaction(MFTransactionVo mfTransactionVo, int userId)
        {
            bool bResult = false;
            Database db;
            DbCommand updateMFTransactionCmd;
            try
            {
                db = DatabaseFactory.CreateDatabase("wealtherp");
                updateMFTransactionCmd = db.GetStoredProcCommand("SP_UpdateMFTransaction");

                db.AddInParameter(updateMFTransactionCmd, "@CMFT_MFTransId", DbType.Int32, mfTransactionVo.TransactionId);
                db.AddInParameter(updateMFTransactionCmd, "@CMFA_AccountId", DbType.Int32, mfTransactionVo.AccountId);
                db.AddInParameter(updateMFTransactionCmd, "@PASP_SchemePlanCode", DbType.String, mfTransactionVo.MFCode);
                db.AddInParameter(updateMFTransactionCmd, "@CMFT_TransactionDate", DbType.DateTime, mfTransactionVo.TransactionDate);
                db.AddInParameter(updateMFTransactionCmd, "@CMFT_BuySell", DbType.String, mfTransactionVo.BuySell);

                db.AddInParameter(updateMFTransactionCmd, "@CMFT_DividendRate", DbType.Decimal, mfTransactionVo.DividendRate);
                db.AddInParameter(updateMFTransactionCmd, "@CMFT_NAV", DbType.String, mfTransactionVo.NAV);
                db.AddInParameter(updateMFTransactionCmd, "@CMFT_Price", DbType.Decimal, mfTransactionVo.Price);
                db.AddInParameter(updateMFTransactionCmd, "@CMFT_Amount", DbType.Decimal, mfTransactionVo.Amount);
                db.AddInParameter(updateMFTransactionCmd, "@CMFT_Units", DbType.Decimal, mfTransactionVo.Units);
                db.AddInParameter(updateMFTransactionCmd, "@CMFT_STT", DbType.Decimal, mfTransactionVo.STT);
                db.AddInParameter(updateMFTransactionCmd, "@CMFT_IsSourceManual", DbType.String, mfTransactionVo.IsSourceManual);

                db.AddInParameter(updateMFTransactionCmd, "@XES_SourceCode", DbType.String, mfTransactionVo.Source);
                db.AddInParameter(updateMFTransactionCmd, "@CMFT_SwitchSourceTrxId", DbType.String, mfTransactionVo.SwitchSourceTrxId);
                db.AddInParameter(updateMFTransactionCmd, "@WMTT_TransactionClassificationCode", DbType.String, mfTransactionVo.TransactionClassificationCode);
                db.AddInParameter(updateMFTransactionCmd, "@CMFT_ModifiedBy", DbType.String, userId);



                if (db.ExecuteNonQuery(updateMFTransactionCmd) != 0)

                    bResult = true;

            }
            catch (BaseApplicationException Ex)
            {
                throw Ex;
            }
            catch (Exception Ex)
            {
                BaseApplicationException exBase = new BaseApplicationException(Ex.Message, Ex);
                NameValueCollection FunctionInfo = new NameValueCollection();

                FunctionInfo.Add("Method", "CustomerTransactionDao.cs:AddMFTransaction()");


                object[] objects = new object[2];
                objects[0] = mfTransactionVo;
                objects[1] = userId;

                FunctionInfo = exBase.AddObject(FunctionInfo, objects);
                exBase.AdditionalInformation = FunctionInfo;
                ExceptionManager.Publish(exBase);
                throw exBase;

            }
            return bResult;
        }
        public bool UpdateRejectedTransactionStatus(int MFTransId, int OriginalTransactionNumber)
        {
            bool bResult = false;
            Database db;
            DbCommand updateMFTransactionCmd;
            try
            {
                db = DatabaseFactory.CreateDatabase("wealtherp");
                updateMFTransactionCmd = db.GetStoredProcCommand("SP_UpdateMFRejectedTransactionStatus");

                db.AddInParameter(updateMFTransactionCmd, "@MFTransId", DbType.Int32, MFTransId);
                db.AddInParameter(updateMFTransactionCmd, "@OriginalTransId", DbType.Int32, OriginalTransactionNumber);




                if (db.ExecuteNonQuery(updateMFTransactionCmd) != 0)

                    bResult = true;

            }
            catch (BaseApplicationException Ex)
            {
                throw Ex;
            }
            catch (Exception Ex)
            {
                BaseApplicationException exBase = new BaseApplicationException(Ex.Message, Ex);
                NameValueCollection FunctionInfo = new NameValueCollection();

                FunctionInfo.Add("Method", "CustomerTransactionDao.cs:UpdateRejectedTransactionStatus(int MFTransId,int OriginalTransactionNumber)");


                object[] objects = new object[2];
                objects[0] = MFTransId;
                objects[1] = OriginalTransactionNumber;

                FunctionInfo = exBase.AddObject(FunctionInfo, objects);
                exBase.AdditionalInformation = FunctionInfo;
                ExceptionManager.Publish(exBase);
                throw exBase;

            }
            return bResult;
        }
        public bool DeleteMFTransaction(int mfTransactionId)
        {
            bool bResult = false;
            Database db;
            DbCommand deleteEquityTransactionCmd;

            try
            {
                db = DatabaseFactory.CreateDatabase("wealtherp");
                deleteEquityTransactionCmd = db.GetStoredProcCommand("SP_DeleteMFTransactions");

                db.AddInParameter(deleteEquityTransactionCmd, "@CMFT_MFTransId", DbType.Int32, mfTransactionId);
                if (db.ExecuteNonQuery(deleteEquityTransactionCmd) != 0)

                    bResult = true;
            }
            catch (BaseApplicationException Ex)
            {
                throw Ex;
            }
            catch (Exception Ex)
            {
                BaseApplicationException exBase = new BaseApplicationException(Ex.Message, Ex);
                NameValueCollection FunctionInfo = new NameValueCollection();

                FunctionInfo.Add("Method", "CustomerTransactionDao.cs:DeleteMFTransaction()");

                object[] objects = new object[1];
                objects[0] = mfTransactionId;

                FunctionInfo = exBase.AddObject(FunctionInfo, objects);
                exBase.AdditionalInformation = FunctionInfo;
                ExceptionManager.Publish(exBase);
                throw exBase;
            }
            return bResult;
        }


        public bool DeleteMFTransaction(MFTransactionVo mfTransactionVo, int adviserId,int UserId)
        {
            bool bResult = false;
            Database db;
            DbCommand DeleteMFTransactionCmd;
            try
            {
                db = DatabaseFactory.CreateDatabase("wealtherp");
                DeleteMFTransactionCmd = db.GetStoredProcCommand("SP_DeleteMFTransaction");
                db.AddInParameter(DeleteMFTransactionCmd, "@adviserId", DbType.Int32, adviserId);
                db.AddInParameter(DeleteMFTransactionCmd, "@UserId", DbType.Int32, UserId);
                db.AddInParameter(DeleteMFTransactionCmd, "@cmftTransactionId", DbType.Int32, mfTransactionVo.TransactionId);
                //db.AddInParameter(DeleteMFTransactionCmd, "@CustomerId", DbType.Int32, mfTransactionVo.CustomerId);
                db.AddInParameter(DeleteMFTransactionCmd, "@SchemeCode", DbType.Int32, mfTransactionVo.MFCode);
                db.AddInParameter(DeleteMFTransactionCmd, "@accountId", DbType.Int32, mfTransactionVo.AccountId);
                db.AddInParameter(DeleteMFTransactionCmd, "@OriginalTrnxNo", DbType.String, mfTransactionVo.OriginalTransactionNumber);
                db.AddInParameter(DeleteMFTransactionCmd, "@stausCode", DbType.Int16, mfTransactionVo.TransactionStatusCode);

                db.ExecuteNonQuery(DeleteMFTransactionCmd);
                bResult = true;

            }
            catch (BaseApplicationException Ex)
            {
                throw Ex;
            }
            catch (Exception Ex)
            {
                BaseApplicationException exBase = new BaseApplicationException(Ex.Message, Ex);
                NameValueCollection FunctionInfo = new NameValueCollection();

                FunctionInfo.Add("Method", "CustomerTransactionDao.cs:CancelMFTransaction(MFTransactionVo mfTransactionVo,int userId)");


                object[] objects = new object[2];
                objects[0] = mfTransactionVo;

                FunctionInfo = exBase.AddObject(FunctionInfo, objects);
                exBase.AdditionalInformation = FunctionInfo;
                ExceptionManager.Publish(exBase);
                throw exBase;

            }
            return bResult;
        }

        public bool CancelMFTransaction(MFTransactionVo mfTransactionVo, int userId)
        {
            bool bResult = false;
            Database db;
            DbCommand updateMFTransactionCmd;
            try
            {
                db = DatabaseFactory.CreateDatabase("wealtherp");
                updateMFTransactionCmd = db.GetStoredProcCommand("SP_CancelMutualFundTransaction");

                db.AddInParameter(updateMFTransactionCmd, "@CMFT_MFTransId", DbType.Int32, mfTransactionVo.TransactionId);
                db.AddInParameter(updateMFTransactionCmd, "@CMFA_AccountId", DbType.Int32, mfTransactionVo.AccountId);
                db.AddInParameter(updateMFTransactionCmd, "@PASP_SchemePlanCode", DbType.String, mfTransactionVo.MFCode);
                db.AddInParameter(updateMFTransactionCmd, "@CMFT_TransactionDate", DbType.DateTime, mfTransactionVo.TransactionDate);
                db.AddInParameter(updateMFTransactionCmd, "@CMFT_BuySell", DbType.String, mfTransactionVo.BuySell);

                db.AddInParameter(updateMFTransactionCmd, "@CMFT_DividendRate", DbType.Decimal, mfTransactionVo.DividendRate);
                db.AddInParameter(updateMFTransactionCmd, "@CMFT_NAV", DbType.String, mfTransactionVo.NAV);
                db.AddInParameter(updateMFTransactionCmd, "@CMFT_Price", DbType.Decimal, mfTransactionVo.Price);
                db.AddInParameter(updateMFTransactionCmd, "@CMFT_Amount", DbType.Decimal, mfTransactionVo.Amount);
                db.AddInParameter(updateMFTransactionCmd, "@CMFT_Units", DbType.Decimal, mfTransactionVo.Units);
                db.AddInParameter(updateMFTransactionCmd, "@CMFT_STT", DbType.Decimal, mfTransactionVo.STT);
                db.AddInParameter(updateMFTransactionCmd, "@CMFT_IsSourceManual", DbType.String, mfTransactionVo.IsSourceManual);

                db.AddInParameter(updateMFTransactionCmd, "@XES_SourceCode", DbType.String, mfTransactionVo.Source);
                db.AddInParameter(updateMFTransactionCmd, "@CMFT_SwitchSourceTrxId", DbType.String, mfTransactionVo.SwitchSourceTrxId);
                db.AddInParameter(updateMFTransactionCmd, "@WMTT_TransactionClassificationCode", DbType.String, mfTransactionVo.TransactionClassificationCode);
                db.AddInParameter(updateMFTransactionCmd, "@CMFT_ModifiedBy", DbType.String, userId);
                db.AddInParameter(updateMFTransactionCmd, "@CMFT_CreatedBy", DbType.String, userId);


                if (db.ExecuteNonQuery(updateMFTransactionCmd) != 0)

                    bResult = true;

            }
            catch (BaseApplicationException Ex)
            {
                throw Ex;
            }
            catch (Exception Ex)
            {
                BaseApplicationException exBase = new BaseApplicationException(Ex.Message, Ex);
                NameValueCollection FunctionInfo = new NameValueCollection();

                FunctionInfo.Add("Method", "CustomerTransactionDao.cs:CancelMFTransaction(MFTransactionVo mfTransactionVo,int userId)");


                object[] objects = new object[2];
                objects[0] = mfTransactionVo;
                objects[1] = userId;

                FunctionInfo = exBase.AddObject(FunctionInfo, objects);
                exBase.AdditionalInformation = FunctionInfo;
                ExceptionManager.Publish(exBase);
                throw exBase;

            }
            return bResult;
        }

        #endregion Mutual Fund Transactions
        public string getId()
        {
            Guid id;
            id = Guid.NewGuid();
            return id.ToString();
        }

        #region MF MUltiple Transaction View

        public DataSet GetLastTradeDate()
        {
            DataSet ds = null;
            Database db;
            DbCommand getLastTradeDateCmd;

            try
            {
                db = DatabaseFactory.CreateDatabase("wealtherp");
                getLastTradeDateCmd = db.GetStoredProcCommand("SP_GetLastTradeDate");
                ds = db.ExecuteDataSet(getLastTradeDateCmd);
            }
            catch (BaseApplicationException Ex)
            {
                throw Ex;
            }
            catch (Exception Ex)
            {
                BaseApplicationException exBase = new BaseApplicationException(Ex.Message, Ex);
                NameValueCollection FunctionInfo = new NameValueCollection();
                FunctionInfo.Add("Method", "CustomerTransactionDao.cs:GetLastTradeDate()");
                object[] objects = new object[0];
                FunctionInfo = exBase.AddObject(FunctionInfo, objects);
                exBase.AdditionalInformation = FunctionInfo;
                ExceptionManager.Publish(exBase);
                throw exBase;

            }
            return ds;
        }

        /// <summary>
        /// To get the portfolio type for the folio number
        /// </summary>
        /// <returns></returns>
        public DataSet GetPortfolioType(string folionum)
        {
            DataSet ds = null;
            Database db;
            DbCommand getportfoliotype;

            try
            {
                db = DatabaseFactory.CreateDatabase("wealtherp");
                getportfoliotype = db.GetStoredProcCommand("SP_GetPortfolioType");
                db.AddInParameter(getportfoliotype, "@folionum", DbType.String, folionum);
                ds = db.ExecuteDataSet(getportfoliotype);
            }
            catch (BaseApplicationException Ex)
            {
                throw Ex;
            }
            catch (Exception Ex)
            {
                BaseApplicationException exBase = new BaseApplicationException(Ex.Message, Ex);
                NameValueCollection FunctionInfo = new NameValueCollection();
                FunctionInfo.Add("Method", "CustomerTransactionDao.cs:GetPortfolioType()");
                object[] objects = new object[1];
                objects[0] = folionum;
                FunctionInfo = exBase.AddObject(FunctionInfo, objects);
                exBase.AdditionalInformation = FunctionInfo;
                ExceptionManager.Publish(exBase);
                throw exBase;

            }
            return ds;
        }

        /// <summary>
        /// Returns List of MF Transactions for the Selected RMId based on the Parameters
        /// </summary>
        /// <param name="Count">Out Parameter returns the number of Records</param>
        /// <param name="CurrentPage">Passes the Current Page Number for Paging</param>
        /// <param name="RMId">RelationShip Manager Id</param>
        /// <param name="GroupHeadId">Passes the Groupo HeadId if the List is for a Group</param>
        /// <param name="From">From Date</param>
        /// <param name="To">To Date</param>
        /// <param name="Manage">Parameter to Check Managed and UnManaged Portfolios</param>
        /// <param name="CustomerName">Name of the Customer for Search Purpose</param>
        /// <param name="Scheme">Scheme Search String Parameter</param>
        /// <param name="TranType">Transactiion Type Search Parameter</param>
        /// <param name="transactionStatus">Transaction Status Search Parameter</param>
        /// <param name="genDictTranType">Out Parameter Returns Dictionary of Available Transaction Types</param>
        /// <param name="FolioNumber">MF Folio Number Search Parameter</param>
        /// <param name="PasssedFolioValue">Folio Value Search Parameter</param>
        /// <returns></returns>
        public List<MFTransactionVo> GetRMCustomerMFTransactions(int RMId, int AdviserID, int GroupHeadId, DateTime From, DateTime To, int Manage, int AccountId, bool isCustomerTransactionOnly, int SchemePlanCode)
        {
            DataSet ds = null;
            Database db;
            DbCommand getRMCustomerMFTransactionsCmd;
            List<MFTransactionVo> mfTransactionsList = new List<MFTransactionVo>();
            MFTransactionVo mfTransactionVo = new MFTransactionVo();
            DataTable dtGetMFTransactions;
            //genDictTranType = new Dictionary<string, string>();
            //genDictCategory = new Dictionary<string, string>();
            //genDictAMC = new Dictionary<string, int>();
            try
            {
                db = DatabaseFactory.CreateDatabase("wealtherp");
                //pramod
                //if (CurrentPage == 5000)
                //{
                //    getRMCustomerMFTransactionsCmd = db.GetStoredProcCommand("SP_GetALLRMCustomerMFTransactions");

                //}
                //else
                //{
                getRMCustomerMFTransactionsCmd = db.GetStoredProcCommand("SP_GetRMCustomerMFTransactions");
                //}

                if (RMId != 0)
                    db.AddInParameter(getRMCustomerMFTransactionsCmd, "@RMId", DbType.Int32, RMId);
                else
                    db.AddInParameter(getRMCustomerMFTransactionsCmd, "@RMId", DbType.Int32, DBNull.Value);

                if (AdviserID != 0)
                    db.AddInParameter(getRMCustomerMFTransactionsCmd, "@AdviserID", DbType.Int32, AdviserID);
                else
                    db.AddInParameter(getRMCustomerMFTransactionsCmd, "@AdviserID", DbType.Int32, DBNull.Value);


                if (GroupHeadId != 0)
                {
                    db.AddInParameter(getRMCustomerMFTransactionsCmd, "@GroupHeadId", DbType.Int32, GroupHeadId);
                }
                else
                {
                    db.AddInParameter(getRMCustomerMFTransactionsCmd, "@GroupHeadId", DbType.Int32, DBNull.Value);
                }

                db.AddInParameter(getRMCustomerMFTransactionsCmd, "@isCustomerTransactionOnly", DbType.Int16, isCustomerTransactionOnly);
                //if (ProcessId != 0)
                //{
                //    db.AddInParameter(getRMCustomerMFTransactionsCmd, "@processId", DbType.Int32, ProcessId);
                //}
                //else
                //{
                //    db.AddInParameter(getRMCustomerMFTransactionsCmd, "@processId", DbType.Int32, DBNull.Value);
                //}
                db.AddInParameter(getRMCustomerMFTransactionsCmd, "@FromDate", DbType.DateTime, From);
                db.AddInParameter(getRMCustomerMFTransactionsCmd, "@ToDate", DbType.DateTime, To);
                db.AddInParameter(getRMCustomerMFTransactionsCmd, "@Manage", DbType.Int32, Manage);
                if (AccountId != 0)
                    db.AddInParameter(getRMCustomerMFTransactionsCmd, "@AccountId", DbType.String, AccountId);
                else
                    db.AddInParameter(getRMCustomerMFTransactionsCmd, "@AccountId", DbType.String, DBNull.Value);
                if (SchemePlanCode != 0)
                    db.AddInParameter(getRMCustomerMFTransactionsCmd, "@SchemePlanCode", DbType.String, SchemePlanCode);
                else
                    db.AddInParameter(getRMCustomerMFTransactionsCmd, "@SchemePlanCode", DbType.String, DBNull.Value);

                //db.AddInParameter(getRMCustomerMFTransactionsCmd, "@CurrentPage", DbType.Int32, CurrentPage);
                //if (CustomerName != string.Empty)
                //    db.AddInParameter(getRMCustomerMFTransactionsCmd, "@CustomerName", DbType.String, CustomerName);
                //else
                //    db.AddInParameter(getRMCustomerMFTransactionsCmd, "@CustomerName", DbType.String, DBNull.Value);
                //if (Scheme != string.Empty)
                //    db.AddInParameter(getRMCustomerMFTransactionsCmd, "@Scheme", DbType.String, Scheme);
                //else
                //    db.AddInParameter(getRMCustomerMFTransactionsCmd, "@Scheme", DbType.String, DBNull.Value);
                //if (TranType != string.Empty)
                //    db.AddInParameter(getRMCustomerMFTransactionsCmd, "@TranType", DbType.String, TranType);
                //else
                //    db.AddInParameter(getRMCustomerMFTransactionsCmd, "@TranType", DbType.String, DBNull.Value);
                //if (FolioNumber != string.Empty)
                //    db.AddInParameter(getRMCustomerMFTransactionsCmd, "@FolioNumber", DbType.String, FolioNumber);
                //else
                //    db.AddInParameter(getRMCustomerMFTransactionsCmd, "@FolioNumber", DbType.String, DBNull.Value);
                //if (PasssedFolioValue != null)
                //    db.AddInParameter(getRMCustomerMFTransactionsCmd, "@PasssedFolioValue", DbType.String, PasssedFolioValue);
                //else
                //    db.AddInParameter(getRMCustomerMFTransactionsCmd, "@PasssedFolioValue", DbType.String, DBNull.Value);
                //if (transactionStatus == "")
                //    db.AddInParameter(getRMCustomerMFTransactionsCmd, "@TransactionStatus", DbType.String, "1");
                //else
                //    db.AddInParameter(getRMCustomerMFTransactionsCmd, "@TransactionStatus", DbType.String, transactionStatus);
                //if (categoryCode == "")
                //    db.AddInParameter(getRMCustomerMFTransactionsCmd, "@CategoryCode", DbType.String, DBNull.Value);
                //else
                //    db.AddInParameter(getRMCustomerMFTransactionsCmd, "@CategoryCode", DbType.String, categoryCode);
                //if (AMCCode == 0)
                //    db.AddInParameter(getRMCustomerMFTransactionsCmd, "@AMCCode", DbType.Int32, DBNull.Value);
                //else
                //    db.AddInParameter(getRMCustomerMFTransactionsCmd, "@AMCCode", DbType.String, AMCCode);
                getRMCustomerMFTransactionsCmd.CommandTimeout = 60 * 60;
                ds = db.ExecuteDataSet(getRMCustomerMFTransactionsCmd);
                if (ds.Tables[0].Rows.Count > 0)
                {
                    dtGetMFTransactions = ds.Tables[0];
                    mfTransactionsList = new List<MFTransactionVo>();
                    foreach (DataRow dr in dtGetMFTransactions.Rows)
                    {
                        mfTransactionVo = new MFTransactionVo();

                        if (dr["ADUL_ProcessId"].ToString() != null && dr["ADUL_ProcessId"].ToString() != string.Empty)
                            mfTransactionVo.ProcessId = int.Parse(dr["ADUL_ProcessId"].ToString());
                        else
                            mfTransactionVo.ProcessId = 0;

                        if (dr["CMFT_SubBrokerCode"].ToString() != null && dr["CMFT_SubBrokerCode"].ToString() != string.Empty)
                            mfTransactionVo.SubBrokerCode = dr["CMFT_SubBrokerCode"].ToString();
                        else
                            mfTransactionVo.SubBrokerCode = "N/A";

                        if (dr["PAISC_AssetInstrumentSubCategoryName"].ToString() != null && dr["PAISC_AssetInstrumentSubCategoryName"].ToString() != string.Empty)
                            mfTransactionVo.SubCategoryName = dr["PAISC_AssetInstrumentSubCategoryName"].ToString();
                        else
                            mfTransactionVo.SubCategoryName = "N/A";

                        mfTransactionVo.TransactionId = int.Parse(dr["CMFT_MFTransId"].ToString());
                        mfTransactionVo.CustomerId = int.Parse(dr["C_CustomerId"].ToString());
                        mfTransactionVo.CustomerName = dr["Name"].ToString();
                        mfTransactionVo.PortfolioId = int.Parse(dr["CP_PortfolioId"].ToString());
                        mfTransactionVo.AccountId = int.Parse(dr["CMFA_AccountId"].ToString());
                        mfTransactionVo.AMCCode = int.Parse(dr["PA_AMCCode"].ToString());
                        mfTransactionVo.AMCName = dr["PA_AMCName"].ToString();
                        mfTransactionVo.MFCode = int.Parse(dr["PASP_SchemePlanCode"].ToString());
                        mfTransactionVo.SchemePlan = dr["PASP_SchemePlanName"].ToString();
                        mfTransactionVo.Category = dr["PAIC_AssetInstrumentCategoryName"].ToString();
                        mfTransactionVo.CategoryCode = dr["PAIC_AssetInstrumentCategoryCode"].ToString();
                        mfTransactionVo.BuySell = dr["CMFT_BuySell"].ToString();
                        mfTransactionVo.DividendRate = float.Parse(dr["CMFT_DividendRate"].ToString());
                        mfTransactionVo.TransactionDate = DateTime.Parse(dr["CMFT_TransactionDate"].ToString());
                        mfTransactionVo.NAV = float.Parse(dr["CMFT_NAV"].ToString());
                        mfTransactionVo.Price = float.Parse(dr["CMFT_Price"].ToString());
                        mfTransactionVo.Amount = float.Parse(dr["CMFT_Amount"].ToString());
                        mfTransactionVo.Units = float.Parse(dr["CMFT_Units"].ToString());
                        mfTransactionVo.STT = float.Parse(dr["CMFT_STT"].ToString());
                        mfTransactionVo.Source = dr["XES_SourceCode"].ToString();
                        mfTransactionVo.SwitchSourceTrxId = int.Parse(dr["CMFT_SwitchSourceTrxId"].ToString());
                        mfTransactionVo.TransactionClassificationCode = dr["WMTT_TransactionClassificationCode"].ToString();
                        mfTransactionVo.TransactionType = dr["WMTT_TransactionClassificationName"].ToString();
                        mfTransactionVo.TransactionTrigger = dr["WMTT_Trigger"].ToString();
                        mfTransactionVo.FinancialFlag = int.Parse(dr["WMTT_FinancialFlag"].ToString());
                        mfTransactionVo.Folio = dr["CMFA_FolioNum"].ToString();
                        mfTransactionVo.PortfolioName = dr["CP_PortfolioName"].ToString();
                        mfTransactionVo.CreatedOn = DateTime.Parse(dr["CMFT_CreatedOn"].ToString());
                        if (dr["WTS_TransactionStatusCode"].ToString() != null && dr["WTS_TransactionStatusCode"].ToString() != string.Empty)
                        {
                            mfTransactionVo.TransactionStatus = dr["WTS_TransactionStatus"].ToString();
                            mfTransactionVo.TransactionStatusCode = int.Parse(dr["WTS_TransactionStatusCode"].ToString());
                        }
                        else
                        {
                            mfTransactionVo.TransactionStatus = "OK";
                            mfTransactionVo.TransactionStatusCode = 1;

                        }
                        if (!string.IsNullOrEmpty(dr["CMFT_ExternalBrokerageAmount"].ToString()))
                            mfTransactionVo.BrokerageAmount = float.Parse(dr["CMFT_ExternalBrokerageAmount"].ToString());

                        mfTransactionsList.Add(mfTransactionVo);
                    }
                }
                //pramod
                //if (ds.Tables.Count > 1)
                //{
                //    if (ds.Tables[2].Rows.Count > 0)
                //    {
                //        foreach (DataRow dr in ds.Tables[2].Rows)
                //        {
                //            genDictTranType.Add(dr["WMTT_TransactionClassificationName"].ToString(), dr["WMTT_TransactionClassificationName"].ToString());
                //        }
                //    }
                //    if (ds.Tables[3].Rows.Count > 0)
                //    {
                //        foreach (DataRow dr in ds.Tables[3].Rows)
                //        {
                //            genDictCategory.Add(dr["PAIC_AssetInstrumentCategoryName"].ToString(), dr["PAIC_AssetInstrumentCategoryCode"].ToString());
                //        }
                //    }
                //    if (ds.Tables[4].Rows.Count > 0)
                //    {
                //        foreach (DataRow dr in ds.Tables[4].Rows)
                //        {
                //            genDictAMC.Add(dr["PA_AMCName"].ToString(), int.Parse(dr["PA_AMCCode"].ToString()));
                //        }
                //    }
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
                FunctionInfo.Add("Method", "CustomerTransactionDao.cs:GetRMCustomerMFTransactions()");
                object[] objects = new object[3];
                objects[0] = RMId;
                objects[1] = GroupHeadId;
                objects[2] = From;
                objects[3] = To;
                objects[4] = Manage;
                //objects[5] = Scheme;
                //objects[6] = genDictTranType;
                //objects[7] = FolioNumber;
                //objects[8] = CustomerName;
                //objects[9] = CurrentPage;
                //objects[10] = PasssedFolioValue;

                FunctionInfo = exBase.AddObject(FunctionInfo, objects);
                exBase.AdditionalInformation = FunctionInfo;
                ExceptionManager.Publish(exBase);
                throw exBase;

            }

            //
            //if (ds.Tables.Count > 1)
            //{
            //    if (ds.Tables[1].Rows.Count > 0)
            //        Count = Int32.Parse(ds.Tables[1].Rows[0]["CNT"].ToString());
            //}
            return mfTransactionsList;
        }


        public DataSet GetRMCustomerTrailCommission(int RMId, int AdviserID, int GroupHeadId, DateTime From, DateTime To, int Manage, int AccountId)
        {
            DataSet ds = null;
            Database db;
            DbCommand getRMCustomerMFTransactionsCmd;
            try
            {
                db = DatabaseFactory.CreateDatabase("wealtherp");

                getRMCustomerMFTransactionsCmd = db.GetStoredProcCommand("SP_GetRMCustomerTrailCommission");

                if (RMId != 0)
                    db.AddInParameter(getRMCustomerMFTransactionsCmd, "@RMId", DbType.Int32, RMId);
                else
                    db.AddInParameter(getRMCustomerMFTransactionsCmd, "@RMId", DbType.Int32, DBNull.Value);

                if (AdviserID != 0)
                    db.AddInParameter(getRMCustomerMFTransactionsCmd, "@AdviserID", DbType.Int32, AdviserID);
                else
                    db.AddInParameter(getRMCustomerMFTransactionsCmd, "@AdviserID", DbType.Int32, DBNull.Value);


                if (GroupHeadId != 0)
                {
                    db.AddInParameter(getRMCustomerMFTransactionsCmd, "@GroupHeadId", DbType.Int32, GroupHeadId);
                }
                else
                {
                    db.AddInParameter(getRMCustomerMFTransactionsCmd, "@GroupHeadId", DbType.Int32, DBNull.Value);
                }


                db.AddInParameter(getRMCustomerMFTransactionsCmd, "@FromDate", DbType.DateTime, From);
                db.AddInParameter(getRMCustomerMFTransactionsCmd, "@ToDate", DbType.DateTime, To);
                db.AddInParameter(getRMCustomerMFTransactionsCmd, "@Manage", DbType.Int32, Manage);
                if (AccountId != 0)
                    db.AddInParameter(getRMCustomerMFTransactionsCmd, "@AccountId", DbType.String, AccountId);
                else
                    db.AddInParameter(getRMCustomerMFTransactionsCmd, "@AccountId", DbType.String, DBNull.Value);



                getRMCustomerMFTransactionsCmd.CommandTimeout = 60 * 60;
                ds = db.ExecuteDataSet(getRMCustomerMFTransactionsCmd);

            }
            catch (BaseApplicationException Ex)
            {
                throw Ex;
            }
            catch (Exception Ex)
            {
                BaseApplicationException exBase = new BaseApplicationException(Ex.Message, Ex);
                NameValueCollection FunctionInfo = new NameValueCollection();
                FunctionInfo.Add("Method", "CustomerTransactionDao.cs:GetRMCustomerMFTransactions()");
                object[] objects = new object[5];
                objects[0] = RMId;
                objects[1] = GroupHeadId;
                objects[2] = From;
                objects[3] = To;
                objects[4] = Manage;
                FunctionInfo = exBase.AddObject(FunctionInfo, objects);
                exBase.AdditionalInformation = FunctionInfo;
                ExceptionManager.Publish(exBase);
                throw exBase;

            }
            return ds;

        }


        public List<MFTransactionVo> GetAdviserCustomerMFTransactions(out int Count, int CurrentPage, int adviserId, int GroupHeadId, DateTime From, DateTime To, int Manage, string CustomerName, string Scheme, string TranType, string transactionStatus, out Dictionary<string, string> genDictTranType, string FolioNumber, string PasssedFolioValue, string categoryCode, int AMCCode, out Dictionary<string, string> genDictCategory, out Dictionary<string, int> genDictAMC)
        {
            DataSet ds = null;
            Database db;
            DbCommand getRMCustomerMFTransactionsCmd;
            List<MFTransactionVo> mfTransactionsList = new List<MFTransactionVo>();
            MFTransactionVo mfTransactionVo = new MFTransactionVo();
            DataTable dtGetMFTransactions;
            Count = 0;
            genDictTranType = new Dictionary<string, string>();
            genDictCategory = new Dictionary<string, string>();
            genDictAMC = new Dictionary<string, int>();
            try
            {
                db = DatabaseFactory.CreateDatabase("wealtherp");
                //pramod
                if (CurrentPage == 5000)
                {
                    getRMCustomerMFTransactionsCmd = db.GetStoredProcCommand("SP_GetALLAdviserCustomerMFTransactions");

                }
                else
                {
                    getRMCustomerMFTransactionsCmd = db.GetStoredProcCommand("SP_GetAdviserCustomerMFTransactions");
                }

                db.AddInParameter(getRMCustomerMFTransactionsCmd, "@AdviserId", DbType.Int32, adviserId);
                if (GroupHeadId != 0)
                {
                    db.AddInParameter(getRMCustomerMFTransactionsCmd, "@GroupHeadId", DbType.Int32, GroupHeadId);
                }
                else
                {
                    db.AddInParameter(getRMCustomerMFTransactionsCmd, "@GroupHeadId", DbType.Int32, DBNull.Value);
                }
                db.AddInParameter(getRMCustomerMFTransactionsCmd, "@FromDate", DbType.DateTime, From);
                db.AddInParameter(getRMCustomerMFTransactionsCmd, "@ToDate", DbType.DateTime, To);
                db.AddInParameter(getRMCustomerMFTransactionsCmd, "@Manage", DbType.Int32, Manage);
                db.AddInParameter(getRMCustomerMFTransactionsCmd, "@CurrentPage", DbType.Int32, CurrentPage);
                if (CustomerName != string.Empty)
                    db.AddInParameter(getRMCustomerMFTransactionsCmd, "@CustomerName", DbType.String, CustomerName);
                else
                    db.AddInParameter(getRMCustomerMFTransactionsCmd, "@CustomerName", DbType.String, DBNull.Value);
                if (Scheme != string.Empty)
                    db.AddInParameter(getRMCustomerMFTransactionsCmd, "@Scheme", DbType.String, Scheme);
                else
                    db.AddInParameter(getRMCustomerMFTransactionsCmd, "@Scheme", DbType.String, DBNull.Value);
                if (TranType != string.Empty)
                    db.AddInParameter(getRMCustomerMFTransactionsCmd, "@TranType", DbType.String, TranType);
                else
                    db.AddInParameter(getRMCustomerMFTransactionsCmd, "@TranType", DbType.String, DBNull.Value);
                if (FolioNumber != string.Empty)
                    db.AddInParameter(getRMCustomerMFTransactionsCmd, "@FolioNumber", DbType.String, FolioNumber);
                else
                    db.AddInParameter(getRMCustomerMFTransactionsCmd, "@FolioNumber", DbType.String, DBNull.Value);
                if (PasssedFolioValue != string.Empty)
                    db.AddInParameter(getRMCustomerMFTransactionsCmd, "@PasssedFolioValue", DbType.String, PasssedFolioValue);
                else
                    db.AddInParameter(getRMCustomerMFTransactionsCmd, "@PasssedFolioValue", DbType.String, DBNull.Value);
                if (transactionStatus == "")
                    db.AddInParameter(getRMCustomerMFTransactionsCmd, "@TransactionStatus", DbType.String, "1");
                else
                    db.AddInParameter(getRMCustomerMFTransactionsCmd, "@TransactionStatus", DbType.String, transactionStatus);
                if (categoryCode == "")
                    db.AddInParameter(getRMCustomerMFTransactionsCmd, "@CategoryCode", DbType.String, DBNull.Value);
                else
                    db.AddInParameter(getRMCustomerMFTransactionsCmd, "@CategoryCode", DbType.String, categoryCode);
                if (AMCCode == 0)
                    db.AddInParameter(getRMCustomerMFTransactionsCmd, "@AMCCode", DbType.Int32, DBNull.Value);
                else
                    db.AddInParameter(getRMCustomerMFTransactionsCmd, "@AMCCode", DbType.String, AMCCode);
                getRMCustomerMFTransactionsCmd.CommandTimeout = 60 * 60;
                ds = db.ExecuteDataSet(getRMCustomerMFTransactionsCmd);
                if (ds.Tables[0].Rows.Count > 0)
                {
                    dtGetMFTransactions = ds.Tables[0];
                    mfTransactionsList = new List<MFTransactionVo>();
                    foreach (DataRow dr in dtGetMFTransactions.Rows)
                    {
                        mfTransactionVo = new MFTransactionVo();
                        mfTransactionVo.TransactionId = int.Parse(dr["CMFT_MFTransId"].ToString());
                        mfTransactionVo.CustomerId = int.Parse(dr["C_CustomerId"].ToString());
                        mfTransactionVo.CustomerName = dr["Name"].ToString();
                        mfTransactionVo.PortfolioId = int.Parse(dr["CP_PortfolioId"].ToString());
                        mfTransactionVo.AccountId = int.Parse(dr["CMFA_AccountId"].ToString());
                        mfTransactionVo.AMCCode = int.Parse(dr["PA_AMCCode"].ToString());
                        mfTransactionVo.AMCName = dr["PA_AMCName"].ToString();
                        mfTransactionVo.MFCode = int.Parse(dr["PASP_SchemePlanCode"].ToString());
                        mfTransactionVo.SchemePlan = dr["PASP_SchemePlanName"].ToString();
                        mfTransactionVo.Category = dr["PAIC_AssetInstrumentCategoryName"].ToString();
                        mfTransactionVo.CategoryCode = dr["PAIC_AssetInstrumentCategoryCode"].ToString();
                        mfTransactionVo.BuySell = dr["CMFT_BuySell"].ToString();
                        mfTransactionVo.DividendRate = float.Parse(dr["CMFT_DividendRate"].ToString());
                        mfTransactionVo.TransactionDate = DateTime.Parse(dr["CMFT_TransactionDate"].ToString());
                        mfTransactionVo.NAV = float.Parse(dr["CMFT_NAV"].ToString());
                        mfTransactionVo.Price = float.Parse(dr["CMFT_Price"].ToString());
                        mfTransactionVo.Amount = float.Parse(dr["CMFT_Amount"].ToString());
                        mfTransactionVo.Units = float.Parse(dr["CMFT_Units"].ToString());
                        mfTransactionVo.STT = float.Parse(dr["CMFT_STT"].ToString());
                        mfTransactionVo.Source = dr["XES_SourceCode"].ToString();
                        mfTransactionVo.SwitchSourceTrxId = int.Parse(dr["CMFT_SwitchSourceTrxId"].ToString());
                        mfTransactionVo.TransactionClassificationCode = dr["WMTT_TransactionClassificationCode"].ToString();
                        mfTransactionVo.TransactionType = dr["WMTT_TransactionClassificationName"].ToString();
                        mfTransactionVo.TransactionTrigger = dr["WMTT_Trigger"].ToString();
                        mfTransactionVo.FinancialFlag = int.Parse(dr["WMTT_FinancialFlag"].ToString());
                        mfTransactionVo.Folio = dr["CMFA_FolioNum"].ToString();
                        mfTransactionVo.PortfolioName = dr["CP_PortfolioName"].ToString();
                        if (dr["WTS_TransactionStatusCode"].ToString() != null && dr["WTS_TransactionStatusCode"].ToString() != string.Empty)
                        {
                            mfTransactionVo.TransactionStatus = dr["WTS_TransactionStatus"].ToString();
                            mfTransactionVo.TransactionStatusCode = int.Parse(dr["WTS_TransactionStatusCode"].ToString());
                        }
                        else
                        {
                            mfTransactionVo.TransactionStatus = "OK";
                            mfTransactionVo.TransactionStatusCode = 1;

                        }
                        mfTransactionsList.Add(mfTransactionVo);
                    }
                }
                //pramod
                if (ds.Tables.Count > 1)
                {
                    if (ds.Tables[2].Rows.Count > 0)
                    {
                        foreach (DataRow dr in ds.Tables[2].Rows)
                        {
                            genDictTranType.Add(dr["WMTT_TransactionClassificationName"].ToString(), dr["WMTT_TransactionClassificationName"].ToString());
                        }
                    }
                    if (ds.Tables[3].Rows.Count > 0)
                    {
                        foreach (DataRow dr in ds.Tables[3].Rows)
                        {
                            genDictCategory.Add(dr["PAIC_AssetInstrumentCategoryName"].ToString(), dr["PAIC_AssetInstrumentCategoryCode"].ToString());
                        }
                    }
                    if (ds.Tables[4].Rows.Count > 0)
                    {
                        foreach (DataRow dr in ds.Tables[4].Rows)
                        {
                            genDictAMC.Add(dr["PA_AMCName"].ToString(), int.Parse(dr["PA_AMCCode"].ToString()));
                        }
                    }
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
                FunctionInfo.Add("Method", "CustomerTransactionDao.cs:GetAdviserCustomerMFTransactions()");
                object[] objects = new object[11];
                objects[0] = adviserId;
                objects[1] = GroupHeadId;
                objects[2] = From;
                objects[3] = To;
                objects[4] = Manage;
                objects[5] = Scheme;
                objects[6] = genDictTranType;
                objects[7] = FolioNumber;
                objects[8] = CustomerName;
                objects[9] = CurrentPage;
                objects[10] = PasssedFolioValue;

                FunctionInfo = exBase.AddObject(FunctionInfo, objects);
                exBase.AdditionalInformation = FunctionInfo;
                ExceptionManager.Publish(exBase);
                throw exBase;

            }

            //
            if (ds.Tables.Count > 1)
            {
                if (ds.Tables[1].Rows.Count > 0)
                    Count = Int32.Parse(ds.Tables[1].Rows[0]["CNT"].ToString());
            }
            return mfTransactionsList;
        }
        #endregion MF MUltiple Transaction View


        #region Equity Multiple Transaction View


        public DataSet GetRMCustomerEqTransactions(int RMId, int adviserId, int GroupHeadId, DateTime From, DateTime To, int Manage)
        {
            DataSet ds = null;
            Database db;
            DbCommand getRMCustomerMFTransactionsCmd;
            List<EQTransactionVo> eqTransactionsList = new List<EQTransactionVo>();
            EQTransactionVo EqTransactionVo = new EQTransactionVo();
            DataTable dtGetMFTransactions;
            //Count = 0;
            //genDictTranType = new Dictionary<string, string>();
            try
            {
                db = DatabaseFactory.CreateDatabase("wealtherp");
                getRMCustomerMFTransactionsCmd = db.GetStoredProcCommand("SP_GetRMCustomerEQTransactions");
                db.AddInParameter(getRMCustomerMFTransactionsCmd, "@RMId", DbType.Int32, RMId);
                db.AddInParameter(getRMCustomerMFTransactionsCmd, "@AdviserID", DbType.Int32, adviserId);
                if (GroupHeadId != 0)
                {
                    db.AddInParameter(getRMCustomerMFTransactionsCmd, "@GroupHeadId", DbType.Int32, GroupHeadId);
                }
                else
                {
                    db.AddInParameter(getRMCustomerMFTransactionsCmd, "@GroupHeadId", DbType.Int32, DBNull.Value);
                }
                db.AddInParameter(getRMCustomerMFTransactionsCmd, "@FromDate", DbType.DateTime, From);
                db.AddInParameter(getRMCustomerMFTransactionsCmd, "@ToDate", DbType.DateTime, To);
                db.AddInParameter(getRMCustomerMFTransactionsCmd, "@Manage", DbType.Int32, Manage);
                //db.AddInParameter(getRMCustomerMFTransactionsCmd, "@CurrentPage", DbType.Int32, CurrentPage);

                //db.AddInParameter(getRMCustomerMFTransactionsCmd, "@ExportFlag", DbType.Int32, exportFlag);

                //if (CustomerName != string.Empty)
                //    db.AddInParameter(getRMCustomerMFTransactionsCmd, "@CustomerName", DbType.String, CustomerName);
                //else
                //    db.AddInParameter(getRMCustomerMFTransactionsCmd, "@CustomerName", DbType.String, DBNull.Value);
                //if (Scrip != string.Empty)
                //    db.AddInParameter(getRMCustomerMFTransactionsCmd, "@Scrip", DbType.String, Scrip);
                //else
                //    db.AddInParameter(getRMCustomerMFTransactionsCmd, "@Scrip", DbType.String, DBNull.Value);
                //if (TranType != string.Empty)
                //    db.AddInParameter(getRMCustomerMFTransactionsCmd, "@TranType", DbType.String, TranType);
                //else
                //    db.AddInParameter(getRMCustomerMFTransactionsCmd, "@TranType", DbType.String, DBNull.Value);
                //if (FolioNumber != string.Empty)
                //    db.AddInParameter(getRMCustomerMFTransactionsCmd, "@FolioNumber", DbType.String, FolioNumber);
                //else
                //    db.AddInParameter(getRMCustomerMFTransactionsCmd, "@FolioNumber", DbType.String, DBNull.Value);


                ds = db.ExecuteDataSet(getRMCustomerMFTransactionsCmd);


                //if (ds.Tables.Count > 1 && ds.Tables[2].Rows.Count > 0)
                //{
                //    foreach (DataRow dr in ds.Tables[2].Rows)
                //    {
                //        genDictTranType.Add(dr["WETT_TransactionTypeName"].ToString(), dr["WETT_TransactionCode"].ToString());
                //    }
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
                FunctionInfo.Add("Method", "CustomerTransactionDao.cs:GetRMCustomerMFTransactions()");
                object[] objects = new object[5];
                objects[0] = RMId;
                objects[1] = GroupHeadId;
                objects[2] = From;
                objects[3] = To;
                objects[4] = Manage;
                FunctionInfo = exBase.AddObject(FunctionInfo, objects);
                exBase.AdditionalInformation = FunctionInfo;
                ExceptionManager.Publish(exBase);
                throw exBase;

            }
            //if (ds.Tables.Count > 1 && ds.Tables[1].Rows.Count > 0)
            //    Count = Int32.Parse(ds.Tables[1].Rows[0]["CNT"].ToString());

            return ds;
            //return eqTransactionsList;
        }
        public DataSet GetAdviserCustomerEqTransactions(out int Count, int CurrentPage, int adviserId, int GroupHeadId, DateTime From, DateTime To, int Manage, string CustomerName, string Scrip, string TranType, out Dictionary<string, string> genDictTranType, string FolioNumber, int exportFlag)
        {
            DataSet ds = null;
            Database db;
            DbCommand getRMCustomerMFTransactionsCmd;
            List<EQTransactionVo> eqTransactionsList = new List<EQTransactionVo>();
            EQTransactionVo EqTransactionVo = new EQTransactionVo();

            Count = 0;
            genDictTranType = new Dictionary<string, string>();
            try
            {
                db = DatabaseFactory.CreateDatabase("wealtherp");
                getRMCustomerMFTransactionsCmd = db.GetStoredProcCommand("SP_GetAdviserCustomerEQTransactions");
                db.AddInParameter(getRMCustomerMFTransactionsCmd, "@AdviserId", DbType.Int32, adviserId);
                if (GroupHeadId != 0)
                {
                    db.AddInParameter(getRMCustomerMFTransactionsCmd, "@GroupHeadId", DbType.Int32, GroupHeadId);
                }
                else
                {
                    db.AddInParameter(getRMCustomerMFTransactionsCmd, "@GroupHeadId", DbType.Int32, DBNull.Value);
                }
                db.AddInParameter(getRMCustomerMFTransactionsCmd, "@FromDate", DbType.DateTime, From);
                db.AddInParameter(getRMCustomerMFTransactionsCmd, "@ToDate", DbType.DateTime, To);
                db.AddInParameter(getRMCustomerMFTransactionsCmd, "@Manage", DbType.Int32, Manage);
                db.AddInParameter(getRMCustomerMFTransactionsCmd, "@CurrentPage", DbType.Int32, CurrentPage);

                db.AddInParameter(getRMCustomerMFTransactionsCmd, "@ExportFlag", DbType.Int32, exportFlag);

                if (CustomerName != string.Empty)
                    db.AddInParameter(getRMCustomerMFTransactionsCmd, "@CustomerName", DbType.String, CustomerName);
                else
                    db.AddInParameter(getRMCustomerMFTransactionsCmd, "@CustomerName", DbType.String, DBNull.Value);
                if (Scrip != string.Empty)
                    db.AddInParameter(getRMCustomerMFTransactionsCmd, "@Scrip", DbType.String, Scrip);
                else
                    db.AddInParameter(getRMCustomerMFTransactionsCmd, "@Scrip", DbType.String, DBNull.Value);
                if (TranType != string.Empty)
                    db.AddInParameter(getRMCustomerMFTransactionsCmd, "@TranType", DbType.String, TranType);
                else
                    db.AddInParameter(getRMCustomerMFTransactionsCmd, "@TranType", DbType.String, DBNull.Value);
                if (FolioNumber != string.Empty)
                    db.AddInParameter(getRMCustomerMFTransactionsCmd, "@FolioNumber", DbType.String, FolioNumber);
                else
                    db.AddInParameter(getRMCustomerMFTransactionsCmd, "@FolioNumber", DbType.String, DBNull.Value);


                ds = db.ExecuteDataSet(getRMCustomerMFTransactionsCmd);


                if (ds.Tables.Count > 1 && ds.Tables[2].Rows.Count > 0)
                {
                    foreach (DataRow dr in ds.Tables[2].Rows)
                    {
                        genDictTranType.Add(dr["WETT_TransactionTypeName"].ToString(), dr["WETT_TransactionCode"].ToString());
                    }
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
                FunctionInfo.Add("Method", "CustomerTransactionDao.cs:GetAdviserCustomerMFTransactions()");
                object[] objects = new object[5];
                objects[0] = adviserId;
                objects[1] = GroupHeadId;
                objects[2] = From;
                objects[3] = To;
                objects[4] = Manage;
                FunctionInfo = exBase.AddObject(FunctionInfo, objects);
                exBase.AdditionalInformation = FunctionInfo;
                ExceptionManager.Publish(exBase);
                throw exBase;

            }
            if (ds.Tables.Count > 1 && ds.Tables[1].Rows.Count > 0)
                Count = Int32.Parse(ds.Tables[1].Rows[0]["CNT"].ToString());

            return ds;
            //return eqTransactionsList;
        }
        #endregion MF MUltiple Transaction View


        #region MFFolio

        public List<CustomerAccountsVo> GetCustomerMFFolios(int PortfolioId, int CustomerId)
        {
            DataSet ds = null;
            Database db;
            DbCommand getCustomerMFFOlioCmd;
            List<CustomerAccountsVo> AccountList = null;
            CustomerAccountsVo AccountVo = new CustomerAccountsVo();
            DataTable dtMFFOlio = new DataTable();
            try
            {
                db = DatabaseFactory.CreateDatabase("wealtherp");
                getCustomerMFFOlioCmd = db.GetStoredProcCommand("SP_GetCustomerMFFolios");
                db.AddInParameter(getCustomerMFFOlioCmd, "@PortfolioId", DbType.Int32, PortfolioId);
                db.AddInParameter(getCustomerMFFOlioCmd, "@CustomerId", DbType.Int32, CustomerId);
                //db.AddInParameter(getCustomerMFFOlioCmd, "@currentPage", DbType.Int32, CurrentPage);
                ds = db.ExecuteDataSet(getCustomerMFFOlioCmd);

                DataRow[] drJointHolder;

                if (ds.Tables[0].Rows.Count > 0)
                {
                    dtMFFOlio = ds.Tables[0];
                    AccountList = new List<CustomerAccountsVo>();
                    foreach (DataRow dr in dtMFFOlio.Rows)
                    {
                        string jointHolderName = "";
                        AccountVo = new CustomerAccountsVo();
                        AccountVo.AccountId = int.Parse(dr["CMFA_AccountId"].ToString());
                        AccountVo.AccountNum = dr["CMFA_FolioNum"].ToString();
                        if (dr["ADUL_ProcessId"].ToString() == null || dr["ADUL_ProcessId"].ToString() == "")
                        {
                            AccountVo.ProcessId = 0;
                        }
                        else
                        {
                            AccountVo.ProcessId = int.Parse(dr["ADUL_ProcessId"].ToString());
                        }
                        if (dr["CMFA_AccountOpeningDate"].ToString() != string.Empty)
                            AccountVo.AccountOpeningDate = DateTime.Parse(dr["CMFA_AccountOpeningDate"].ToString());
                        else
                            AccountVo.AccountOpeningDate = DateTime.MinValue;

                        if (dr["PA_AMCCode"].ToString() != string.Empty)
                            AccountVo.AMCCode = int.Parse(dr["PA_AMCCode"].ToString());
                        if (dr["PA_AMCName"].ToString() != string.Empty)
                            AccountVo.AMCName = dr["PA_AMCName"].ToString();
                        //AccountVo.Name = dr["CMFA_INV_NAME"].ToString(); // to capture the original cosumer name

                        if (dr["XMOH_ModeOfHolding"].ToString() != string.Empty)
                            AccountVo.ModeOfHolding = dr["XMOH_ModeOfHolding"].ToString();
                        if (dr["XMOH_ModeOfHoldingCode"].ToString() != string.Empty)

                            AccountVo.ModeOfHoldingCode = dr["XMOH_ModeOfHoldingCode"].ToString();
                        if (AccountVo.ModeOfHoldingCode == "JO")
                        {
                            drJointHolder = ds.Tables[2].Select("CMFA_AccountId=" + AccountVo.AccountId + "AND CMFAA_AssociationType =" + "'" + "Joint Holder" + "'");

                            if (drJointHolder.Count() > 0)
                            {
                                foreach (DataRow dr1 in drJointHolder)
                                {
                                    if (jointHolderName != "")
                                    {
                                        jointHolderName = jointHolderName + "/" + dr1["JointHolderName"].ToString();
                                    }
                                    else
                                    {
                                        jointHolderName = dr1["JointHolderName"].ToString();
                                    }
                                }
                            }
                        }
                        AccountVo.Name = jointHolderName;
                        AccountList.Add(AccountVo);

                    }
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
                FunctionInfo.Add("Method", "CustomerTransactionDao.cs:GetCustomerMFFolios()");
                object[] objects = new object[2];
                objects[0] = PortfolioId;
                objects[1] = CustomerId;
                FunctionInfo = exBase.AddObject(FunctionInfo, objects);
                exBase.AdditionalInformation = FunctionInfo;
                ExceptionManager.Publish(exBase);
                throw exBase;

            }

            //Count = Int32.Parse(ds.Tables[1].Rows[0]["cnt"].ToString());
            return AccountList;
        }


        public CustomerAccountsVo GetCustomerMFFolioDetails(int FolioId)
        {

            CustomerAccountsVo AccountVo = new CustomerAccountsVo();
            CustomerBankAccountVo CustomerBankAccountVo = new CustomerBankAccountVo();


            Database db;
            DbCommand getMFTransactionCmd;
            DataSet dsGetMFTransaction;
            DataRow dr;
            DataRow dr1;
            int bankId = 0;
            try
            {
                db = DatabaseFactory.CreateDatabase("wealtherp");
                getMFTransactionCmd = db.GetStoredProcCommand("SP_GetCustomerMFFolioDetails");
                db.AddInParameter(getMFTransactionCmd, "@FolioId", DbType.Int32, FolioId);

                dsGetMFTransaction = db.ExecuteDataSet(getMFTransactionCmd);
                if (dsGetMFTransaction.Tables[0].Rows.Count > 0)
                {
                    dr = dsGetMFTransaction.Tables[0].Rows[0];
                    AccountVo = new CustomerAccountsVo();
                    if (dr["CMFA_AccountId"].ToString() != string.Empty)
                        AccountVo.AccountId = int.Parse(dr["CMFA_AccountId"].ToString());
                    AccountVo.AccountNum = dr["CMFA_FolioNum"].ToString();
                    if (dr["CMFA_AccountOpeningDate"].ToString() != string.Empty)
                        AccountVo.AccountOpeningDate = DateTime.Parse(dr["CMFA_AccountOpeningDate"].ToString());
                    else
                        AccountVo.AccountOpeningDate = DateTime.MinValue;
                    if (!string.IsNullOrEmpty(dr["PA_AMCCode"].ToString()))
                        AccountVo.AMCCode = int.Parse(dr["PA_AMCCode"].ToString());
                    Int32.TryParse(dr["CB_CustPrimaryBankAccId"].ToString(), out bankId);
                    if (dr["CMFA_IsJointlyHeld"].ToString() != string.Empty)
                        AccountVo.IsJointHolding = int.Parse(dr["CMFA_IsJointlyHeld"].ToString());
                    AccountVo.ModeOfHoldingCode = dr["XMOH_ModeOfHoldingCode"].ToString();
                    AccountVo.BankId = bankId;
                    AccountVo.Name = dr["CMFA_INV_NAME"].ToString();

                    //newly added
                    AccountVo.CAddress1 = dr["CMGCXP_ADDRESS1"].ToString();
                    AccountVo.CAddress2 = dr["CMGCXP_ADDRESS2"].ToString();
                    AccountVo.CAddress3 = dr["CMGCXP_ADDRESS3"].ToString();
                    AccountVo.CCity = dr["CMGCXP_CITY"].ToString();
                    if (!string.IsNullOrEmpty(dr["CMGCXP_PINCODE"].ToString()))
                        AccountVo.CPinCode = int.Parse(dr["CMGCXP_PINCODE"].ToString());
                    AccountVo.JointName1 = dr["CMGCXP_JOINT_NAME1"].ToString();
                    AccountVo.JointName2 = dr["CMGCXP_JOINT_NAME2"].ToString();
                    if (!string.IsNullOrEmpty(dr["CMGCXP_PHONE_OFF"].ToString()))
                        AccountVo.CPhoneOffice = Convert.ToInt64(dr["CMGCXP_PHONE_OFF"].ToString());
                    if (!string.IsNullOrEmpty(dr["CMGCXP_PHONE_RES"].ToString()))
                        AccountVo.CPhoneRes = Convert.ToInt64(dr["CMGCXP_PHONE_RES"].ToString());
                    if (!string.IsNullOrEmpty(dr["CMGCXP_PHONE_OFF"].ToString()))
                        AccountVo.CEmail = dr["CMGCXP_EMAIL"].ToString();
                    if (!string.IsNullOrEmpty(dr["CMFA_PANNO"].ToString()))
                        AccountVo.PanNumber = dr["CMFA_PANNO"].ToString();
                    if (!string.IsNullOrEmpty(dr["CMFA_BROKERCODE"].ToString()))
                        AccountVo.BrokerCode = dr["CMFA_BROKERCODE"].ToString();
                    if (!string.IsNullOrEmpty(dr["XCT_CustomerTypeCode"].ToString()))
                        AccountVo.XCT_CustomerTypeCode = dr["XCT_CustomerTypeCode"].ToString();
                    if (!string.IsNullOrEmpty(dr["XCST_CustomerSubTypeCode"].ToString()))
                        AccountVo.XCST_CustomerSubTypeCode = dr["XCST_CustomerSubTypeCode"].ToString();
                    if (!string.IsNullOrEmpty(dr["CMFA_BankNameInExtFile"].ToString()))
                        AccountVo.BankNameInExtFile = dr["CMFA_BankNameInExtFile"].ToString();


                    if (!string.IsNullOrEmpty(dr["CMGCXP_DOB"].ToString()))
                        AccountVo.CDOB = DateTime.Parse(dr["CMGCXP_DOB"].ToString());

                }

                if (dsGetMFTransaction.Tables[1].Rows.Count > 0)
                {
                    dr1 = dsGetMFTransaction.Tables[1].Rows[0];
                    AccountVo.AccountType = dr1["XBAT_BankAccountTypeCode"].ToString();
                    AccountVo.BankAccountNum = dr1["CB_AccountNum"].ToString();
                    AccountVo.ModeOfOperation = dr1["XMOH_ModeOfHoldingCode"].ToString();
                    if (!string.IsNullOrEmpty(dr1["WERPBDTM_BankName"].ToString()))
                        AccountVo.BankName = dr1["WERPBDTM_BankName"].ToString();
                    AccountVo.BranchName = dr1["CB_BranchName"].ToString();
                    AccountVo.BranchAdrLine1 = dr1["CB_BranchAdrLine1"].ToString();
                    AccountVo.BranchAdrLine2 = dr1["CB_BranchAdrLine2"].ToString();
                    AccountVo.BranchAdrLine3 = dr1["CB_BranchAdrLine3"].ToString();
                    AccountVo.BranchAdrCity = dr1["CB_BranchAdrCity"].ToString();
                    if (!string.IsNullOrEmpty(dr1["CB_BranchAdrPinCode"].ToString()))
                        AccountVo.BranchAdrPinCode = int.Parse(dr1["CB_BranchAdrPinCode"].ToString());
                    if (!string.IsNullOrEmpty(dr1["CB_MICR"].ToString()))
                        AccountVo.MICR = int.Parse(dr1["CB_MICR"].ToString());
                    if (!string.IsNullOrEmpty(dr1["CB_IFSC"].ToString()))
                        AccountVo.IFSC = dr1["CB_IFSC"].ToString();
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
                FunctionInfo.Add("Method", "CustomerTransactionDao.cs:GetCustomerMFFolioDetails()");
                object[] objects = new object[1];
                objects[0] = FolioId;
                FunctionInfo = exBase.AddObject(FunctionInfo, objects);
                exBase.AdditionalInformation = FunctionInfo;
                ExceptionManager.Publish(exBase);
                throw exBase;

            }



            return AccountVo;


        }

        public bool UpdateCustomerMFFolioDetails(CustomerAccountsVo AccountVo, int userId)
        {
            bool blResult = false;
            Database db;
            DbCommand updateMFFolioDetailsCmd;
            try
            {
                db = DatabaseFactory.CreateDatabase("wealtherp");
                updateMFFolioDetailsCmd = db.GetStoredProcCommand("SP_UpdateCustomerMFFolioDetails");
                db.AddInParameter(updateMFFolioDetailsCmd, "@CMFA_AccountId", DbType.Int32, AccountVo.AccountId);
                db.AddInParameter(updateMFFolioDetailsCmd, "@CMFA_FolioNum", DbType.String, AccountVo.AccountNum);
                db.AddInParameter(updateMFFolioDetailsCmd, "@PA_AMCCode", DbType.Int32, AccountVo.AMCCode);
                db.AddInParameter(updateMFFolioDetailsCmd, "@CMFA_IsJointlyHeld", DbType.Int32, AccountVo.IsJointHolding);
                if (AccountVo.AccountOpeningDate != DateTime.MinValue)
                    db.AddInParameter(updateMFFolioDetailsCmd, "@CMFA_AccountOpeningDate", DbType.DateTime, AccountVo.AccountOpeningDate);
                else
                    db.AddInParameter(updateMFFolioDetailsCmd, "@CMFA_AccountOpeningDate", DbType.DateTime, DBNull.Value);
                db.AddInParameter(updateMFFolioDetailsCmd, "@XMOH_ModeOfHoldingCode", DbType.String, AccountVo.ModeOfHoldingCode);


                #region newly added
                db.AddInParameter(updateMFFolioDetailsCmd, "@CP_PortfolioId", DbType.Int32, AccountVo.PortfolioId);
                db.AddInParameter(updateMFFolioDetailsCmd, "@PAG_AssetGroupCode", DbType.String, AccountVo.AssetClass);


                db.AddInParameter(updateMFFolioDetailsCmd, "@ModifiedBy", DbType.Int32, userId);
                if (AccountVo.BankId != 0)
                {
                    db.AddInParameter(updateMFFolioDetailsCmd, "@CB_CustBankAccId", DbType.Int32, AccountVo.BankId);
                }
                else
                {
                    db.AddInParameter(updateMFFolioDetailsCmd, "@CB_CustBankAccId", DbType.Int32, DBNull.Value);
                }
                if (!string.IsNullOrEmpty(AccountVo.Name))
                {
                    db.AddInParameter(updateMFFolioDetailsCmd, "@CMFA_InvestorName", DbType.String, AccountVo.Name);
                }
                else
                {
                    db.AddInParameter(updateMFFolioDetailsCmd, "@CMFA_InvestorName", DbType.String, DBNull.Value);
                }
                if (!string.IsNullOrEmpty(AccountVo.PanNumber))
                {
                    db.AddInParameter(updateMFFolioDetailsCmd, "@CMFA_PANNO", DbType.String, AccountVo.PanNumber);
                }
                else
                {
                    db.AddInParameter(updateMFFolioDetailsCmd, "@CMFA_PANNO", DbType.String, DBNull.Value);
                }
                if (!string.IsNullOrEmpty(AccountVo.BrokerCode))
                {
                    db.AddInParameter(updateMFFolioDetailsCmd, "@CMFA_BROKERCODE", DbType.String, AccountVo.BrokerCode);
                }
                else
                {
                    db.AddInParameter(updateMFFolioDetailsCmd, "@CMFA_BROKERCODE", DbType.String, DBNull.Value);
                }

                if (AccountVo.XCT_CustomerTypeCode != null && AccountVo.XCT_CustomerTypeCode != "0")
                {
                    db.AddInParameter(updateMFFolioDetailsCmd, "@XCT_CustomerTypeCode", DbType.String, AccountVo.XCT_CustomerTypeCode);
                }
                else
                {
                    db.AddInParameter(updateMFFolioDetailsCmd, "@XCT_CustomerTypeCode", DbType.String, DBNull.Value);
                }

                if (AccountVo.XCST_CustomerSubTypeCode != "0")
                {
                    db.AddInParameter(updateMFFolioDetailsCmd, "@XCST_CustomerSubTypeCode", DbType.String, AccountVo.XCST_CustomerSubTypeCode);
                }
                else
                {
                    db.AddInParameter(updateMFFolioDetailsCmd, "@XCST_CustomerSubTypeCode", DbType.String, DBNull.Value);
                }



                if (!string.IsNullOrEmpty(AccountVo.CAddress1))
                {
                    db.AddInParameter(updateMFFolioDetailsCmd, "@CMGCXP_ADDRESS1", DbType.String, AccountVo.CAddress1);
                }
                else
                {
                    db.AddInParameter(updateMFFolioDetailsCmd, "@CMGCXP_ADDRESS1", DbType.String, DBNull.Value);
                }
                if (!string.IsNullOrEmpty(AccountVo.CAddress2))
                {
                    db.AddInParameter(updateMFFolioDetailsCmd, "@CMGCXP_ADDRESS2", DbType.String, AccountVo.CAddress2);
                }
                else
                {
                    db.AddInParameter(updateMFFolioDetailsCmd, "@CMGCXP_ADDRESS2", DbType.String, DBNull.Value);
                }
                if (!string.IsNullOrEmpty(AccountVo.CAddress3))
                {
                    db.AddInParameter(updateMFFolioDetailsCmd, "@CMGCXP_ADDRESS3", DbType.String, AccountVo.CAddress3);
                }
                else
                {
                    db.AddInParameter(updateMFFolioDetailsCmd, "@CMGCXP_ADDRESS3", DbType.String, DBNull.Value);
                }
                if (!string.IsNullOrEmpty(AccountVo.CCity))
                {
                    db.AddInParameter(updateMFFolioDetailsCmd, "@CMGCXP_CITY", DbType.String, AccountVo.CCity);
                }
                else
                {
                    db.AddInParameter(updateMFFolioDetailsCmd, "@CMGCXP_CITY", DbType.String, DBNull.Value);
                }
                if (AccountVo.CPinCode != 0)
                {
                    db.AddInParameter(updateMFFolioDetailsCmd, "@CMGCXP_PINCODE", DbType.Int32, AccountVo.CPinCode);
                }
                else
                {
                    db.AddInParameter(updateMFFolioDetailsCmd, "@CMGCXP_PINCODE", DbType.Int32, DBNull.Value);
                }
                if (!string.IsNullOrEmpty(AccountVo.JointName1))
                {
                    db.AddInParameter(updateMFFolioDetailsCmd, "@CMGCXP_JOINT_NAME1", DbType.String, AccountVo.JointName1);
                }
                else
                {
                    db.AddInParameter(updateMFFolioDetailsCmd, "@CMGCXP_JOINT_NAME1", DbType.String, DBNull.Value);
                }
                if (!string.IsNullOrEmpty(AccountVo.JointName2))
                {
                    db.AddInParameter(updateMFFolioDetailsCmd, "@CMGCXP_JOINT_NAME2", DbType.String, AccountVo.JointName2);
                }
                else
                {
                    db.AddInParameter(updateMFFolioDetailsCmd, "@CMGCXP_JOINT_NAME2", DbType.String, DBNull.Value);
                }
                if (AccountVo.CPhoneOffice != 0)
                {
                    db.AddInParameter(updateMFFolioDetailsCmd, "@CMGCXP_PHONE_OFF", DbType.Int64, AccountVo.CPhoneOffice);
                }
                else
                {
                    db.AddInParameter(updateMFFolioDetailsCmd, "@CMGCXP_PHONE_OFF", DbType.Int64, DBNull.Value);
                }
                if (!string.IsNullOrEmpty(AccountVo.Name))
                {
                    db.AddInParameter(updateMFFolioDetailsCmd, "@CMGCXP_PHONE_RES", DbType.Int64, AccountVo.CPhoneRes);
                }
                else
                {
                    db.AddInParameter(updateMFFolioDetailsCmd, "@CMGCXP_PHONE_RES", DbType.Int64, DBNull.Value);
                }
                if (!string.IsNullOrEmpty(AccountVo.CEmail))
                {
                    db.AddInParameter(updateMFFolioDetailsCmd, "@CMGCXP_EMAIL", DbType.String, AccountVo.CEmail);
                }
                else
                {
                    db.AddInParameter(updateMFFolioDetailsCmd, "@CMGCXP_EMAIL", DbType.String, DBNull.Value);
                }
                if (!string.IsNullOrEmpty(AccountVo.CMGCXP_BankCity))
                {
                    db.AddInParameter(updateMFFolioDetailsCmd, "@CMGCXP_BankCity", DbType.String, AccountVo.CMGCXP_BankCity);
                }
                else
                {
                    db.AddInParameter(updateMFFolioDetailsCmd, "@CMGCXP_BankCity", DbType.String, DBNull.Value);
                }
                if (AccountVo.CDOB != DateTime.MinValue)
                {
                    db.AddInParameter(updateMFFolioDetailsCmd, "@CMGCXP_DOB", DbType.DateTime, AccountVo.CDOB);
                }
                else
                {
                    db.AddInParameter(updateMFFolioDetailsCmd, "@CMGCXP_DOB", DbType.DateTime, DBNull.Value);
                }

                //added for Bank details 

                if (!string.IsNullOrEmpty(AccountVo.BankName))
                {
                    db.AddInParameter(updateMFFolioDetailsCmd, "@WERPBM_BankCode", DbType.String, AccountVo.BankName);
                }
                else
                {
                    db.AddInParameter(updateMFFolioDetailsCmd, "@WERPBM_BankCode", DbType.String, DBNull.Value);
                }

                if (AccountVo.CustomerId != 0)
                {
                    db.AddInParameter(updateMFFolioDetailsCmd, "@C_CustomerId", DbType.Int32, AccountVo.CustomerId);
                }
                else
                {
                    db.AddInParameter(updateMFFolioDetailsCmd, "@C_CustomerId", DbType.Int32, DBNull.Value);
                }
                if (!string.IsNullOrEmpty(AccountVo.AccountType))
                {
                    db.AddInParameter(updateMFFolioDetailsCmd, "@XBAT_BankAccountTypeCode", DbType.String, AccountVo.AccountType);
                }
                else
                {
                    db.AddInParameter(updateMFFolioDetailsCmd, "@XBAT_BankAccountTypeCode", DbType.String, DBNull.Value);
                }

                if (!string.IsNullOrEmpty(AccountVo.BankAccountNum))
                {
                    db.AddInParameter(updateMFFolioDetailsCmd, "@CB_AccountNum", DbType.String, AccountVo.BankAccountNum);
                }
                else
                {
                    db.AddInParameter(updateMFFolioDetailsCmd, "@CB_AccountNum", DbType.String, DBNull.Value);
                }

                if (!string.IsNullOrEmpty(AccountVo.BranchName))
                {
                    db.AddInParameter(updateMFFolioDetailsCmd, "@CB_BranchName", DbType.String, AccountVo.BranchName);
                }
                else
                {
                    db.AddInParameter(updateMFFolioDetailsCmd, "@CB_BranchName", DbType.String, DBNull.Value);
                }
                if (!string.IsNullOrEmpty(AccountVo.BranchAdrLine1))
                {
                    db.AddInParameter(updateMFFolioDetailsCmd, "@CB_BranchAdrLine1", DbType.String, AccountVo.BranchAdrLine1);
                }
                else
                {
                    db.AddInParameter(updateMFFolioDetailsCmd, "@CB_BranchAdrLine1", DbType.String, DBNull.Value);
                }
                if (!string.IsNullOrEmpty(AccountVo.BranchAdrLine2))
                {
                    db.AddInParameter(updateMFFolioDetailsCmd, "@CB_BranchAdrLine2", DbType.String, AccountVo.BranchAdrLine2);
                }
                else
                {
                    db.AddInParameter(updateMFFolioDetailsCmd, "@CB_BranchAdrLine2", DbType.String, DBNull.Value);
                }
                if (!string.IsNullOrEmpty(AccountVo.BranchAdrLine3))
                {
                    db.AddInParameter(updateMFFolioDetailsCmd, "@CB_BranchAdrLine3", DbType.String, AccountVo.BranchAdrLine3);
                }
                else
                {
                    db.AddInParameter(updateMFFolioDetailsCmd, "@CB_BranchAdrLine3", DbType.String, DBNull.Value);
                }
                if (AccountVo.BranchAdrPinCode != 0)
                {
                    db.AddInParameter(updateMFFolioDetailsCmd, "@CB_BranchAdrPinCode", DbType.Int32, AccountVo.BranchAdrPinCode);
                }
                else
                {
                    db.AddInParameter(updateMFFolioDetailsCmd, "@CB_BranchAdrPinCode", DbType.Int32, DBNull.Value);
                }
                if (!string.IsNullOrEmpty(AccountVo.BranchAdrCity))
                {
                    db.AddInParameter(updateMFFolioDetailsCmd, "@CB_BranchAdrCity", DbType.String, AccountVo.BranchAdrCity);
                }
                else
                {
                    db.AddInParameter(updateMFFolioDetailsCmd, "@CB_BranchAdrCity", DbType.String, DBNull.Value);
                }
                if (!string.IsNullOrEmpty(AccountVo.BranchAdrState))
                {
                    db.AddInParameter(updateMFFolioDetailsCmd, "@CB_BranchAdrState", DbType.String, AccountVo.BranchAdrState);
                }
                else
                {
                    db.AddInParameter(updateMFFolioDetailsCmd, "@CB_BranchAdrState", DbType.String, DBNull.Value);
                }

                db.AddInParameter(updateMFFolioDetailsCmd, "@CB_BranchAdrCountry", DbType.String, "India");


                if (AccountVo.Balance != 0)
                {
                    db.AddInParameter(updateMFFolioDetailsCmd, "@CB_Balance", DbType.Int32, AccountVo.Balance);
                }
                else
                {
                    db.AddInParameter(updateMFFolioDetailsCmd, "@CB_Balance", DbType.Int32, DBNull.Value);
                }
                if (AccountVo.MICR != 0)
                {
                    db.AddInParameter(updateMFFolioDetailsCmd, "@CB_MICR", DbType.Int32, AccountVo.MICR);
                }
                else
                {
                    db.AddInParameter(updateMFFolioDetailsCmd, "@CB_MICR", DbType.Int32, DBNull.Value);
                }
                if (!string.IsNullOrEmpty(AccountVo.IFSC))
                {
                    db.AddInParameter(updateMFFolioDetailsCmd, "@CB_IFSC", DbType.String, AccountVo.IFSC);
                }
                else
                {
                    db.AddInParameter(updateMFFolioDetailsCmd, "@CB_IFSC", DbType.String, DBNull.Value);
                }


                #endregion



                if (db.ExecuteNonQuery(updateMFFolioDetailsCmd) != 0)
                    blResult = true;
            }
            catch (BaseApplicationException Ex)
            {
                throw Ex;
            }
            catch (Exception Ex)
            {
                BaseApplicationException exBase = new BaseApplicationException(Ex.Message, Ex);
                NameValueCollection FunctionInfo = new NameValueCollection();
                FunctionInfo.Add("Method", "CustomerTransactionDao.cs:UpdateCustomerMFFolioDetails()");
                object[] objects = new object[2];
                objects[0] = AccountVo;
                objects[1] = userId;
                FunctionInfo = exBase.AddObject(FunctionInfo, objects);
                exBase.AdditionalInformation = FunctionInfo;
                ExceptionManager.Publish(exBase);
                throw exBase;

            }
            return blResult;
        }

        public DataSet GetMFFolioAccountAssociates(int FolioId, int CustomerId)
        {


            Database db;
            DbCommand getMFFolioAccountAssociatesCmd;
            DataSet dsGetMFFolioAccountAssociates;
            try
            {
                db = DatabaseFactory.CreateDatabase("wealtherp");
                getMFFolioAccountAssociatesCmd = db.GetStoredProcCommand("SP_GetMFFolioAssociates");
                db.AddInParameter(getMFFolioAccountAssociatesCmd, "@CMFA_AccountId", DbType.Int32, FolioId);
                db.AddInParameter(getMFFolioAccountAssociatesCmd, "@CustomerId", DbType.Int32, CustomerId);
                dsGetMFFolioAccountAssociates = db.ExecuteDataSet(getMFFolioAccountAssociatesCmd);

            }
            catch (BaseApplicationException Ex)
            {
                throw Ex;
            }
            catch (Exception Ex)
            {
                BaseApplicationException exBase = new BaseApplicationException(Ex.Message, Ex);
                NameValueCollection FunctionInfo = new NameValueCollection();
                FunctionInfo.Add("Method", "CustomerTransactionDao.cs:GetMFFolioAccountAssociates()");
                object[] objects = new object[2];
                objects[0] = FolioId;
                objects[1] = CustomerId;
                FunctionInfo = exBase.AddObject(FunctionInfo, objects);
                exBase.AdditionalInformation = FunctionInfo;
                ExceptionManager.Publish(exBase);
                throw exBase;

            }

            return dsGetMFFolioAccountAssociates;


        }


        public bool DeleteMFFolioAccountAssociates(int FolioId)
        {
            bool blResult = false;
            Database db;
            DbCommand deleteMFFolioDetailsCmd;
            try
            {
                db = DatabaseFactory.CreateDatabase("wealtherp");
                deleteMFFolioDetailsCmd = db.GetStoredProcCommand("SP_DeleteMFFolioAccountAssociates");
                db.AddInParameter(deleteMFFolioDetailsCmd, "@CMFA_AccountId", DbType.Int32, FolioId);

                if (db.ExecuteNonQuery(deleteMFFolioDetailsCmd) != 0)
                    blResult = true;
            }
            catch (BaseApplicationException Ex)
            {
                throw Ex;
            }
            catch (Exception Ex)
            {
                BaseApplicationException exBase = new BaseApplicationException(Ex.Message, Ex);
                NameValueCollection FunctionInfo = new NameValueCollection();
                FunctionInfo.Add("Method", "CustomerTransactionDao.cs:UpdateCustomerMFFolioDetails()");
                object[] objects = new object[1];
                objects[0] = FolioId;

                FunctionInfo = exBase.AddObject(FunctionInfo, objects);
                exBase.AdditionalInformation = FunctionInfo;
                ExceptionManager.Publish(exBase);
                throw exBase;

            }
            return blResult;
        }

        #endregion MFFolio

        // To get whether supplied Trasaction Classification Name is Buy or sell
        public string GetTransactionType(string transname)
        {
            string transactionType = "";
            Database db;
            DbCommand dbTransactionType;
            DataSet dsTransactionType;
            try
            {
                db = DatabaseFactory.CreateDatabase("wealtherp");
                dbTransactionType = db.GetStoredProcCommand("SP_GetTransactionType");
                db.AddInParameter(dbTransactionType, "@TransactionName", DbType.String, transname);
                dsTransactionType = db.ExecuteDataSet(dbTransactionType);
                transactionType = dsTransactionType.Tables[0].Rows[0]["WMTT_BuySell"].ToString();
            }
            catch (BaseApplicationException ex)
            {
                throw ex;
            }
            catch (Exception ex)
            {
                BaseApplicationException exBase = new BaseApplicationException(ex.Message, ex);
                NameValueCollection FunctionInfo = new NameValueCollection();
                FunctionInfo.Add("Method", "CustomerTransactionDao.cs:GetTransactionType()");
                object[] objects = new object[1];
                objects[0] = transname;
                FunctionInfo = exBase.AddObject(FunctionInfo, objects);
                exBase.AdditionalInformation = FunctionInfo;
                ExceptionManager.Publish(exBase);
                throw exBase;
            }
            return transactionType;
        }

        /// <summary>
        /// To check whether TradeAccount No. associated with Transaction <<Vinayak Patil>>
        /// </summary>
        /// <param name="eqTradeAccId"></param>
        /// <returns></returns>

        public bool CheckEQTradeAccNoAssociatedWithTransactions(int eqTradeAccId)
        {
            bool bResult = false;
            Database db;
            DbCommand CheckEQTradeAccNoAssociatedWithTransactionsCmd;
            DataSet dsCheckEQTradeAccNoAssociatedWithTransactions = new DataSet();

            try
            {
                db = DatabaseFactory.CreateDatabase("wealtherp");
                CheckEQTradeAccNoAssociatedWithTransactionsCmd = db.GetStoredProcCommand("CheckFolioAndTradeAssociation");

                db.AddInParameter(CheckEQTradeAccNoAssociatedWithTransactionsCmd, "@EQTrade_AccId", DbType.Int32, eqTradeAccId);
                dsCheckEQTradeAccNoAssociatedWithTransactions = db.ExecuteDataSet(CheckEQTradeAccNoAssociatedWithTransactionsCmd);
                if (dsCheckEQTradeAccNoAssociatedWithTransactions.Tables[0].Rows[0]["NoOfEQRecords"].ToString() != "0")

                    bResult = true;
            }
            catch (BaseApplicationException Ex)
            {
                throw Ex;
            }
            catch (Exception Ex)
            {
                BaseApplicationException exBase = new BaseApplicationException(Ex.Message, Ex);
                NameValueCollection FunctionInfo = new NameValueCollection();

                FunctionInfo.Add("Method", "CustomerTransactionDao.cs:CheckEQTradeAccNoAssociatedWithTransactions()");

                object[] objects = new object[1];
                objects[0] = eqTradeAccId;

                FunctionInfo = exBase.AddObject(FunctionInfo, objects);
                exBase.AdditionalInformation = FunctionInfo;
                ExceptionManager.Publish(exBase);
                throw exBase;
            }
            return bResult;
        }

        /// <summary>
        /// To Delete Trade Account <<Vinayak Patil>>
        /// </summary>
        /// <param name="eqTradeAccId"></param>
        /// <returns></returns>

        public bool DeleteTradeAccount(int eqTradeAccId)
        {
            bool bResult = false;
            Database db;
            DbCommand DeleteTradeAccountCmd;

            try
            {

                db = DatabaseFactory.CreateDatabase("wealtherp");
                DeleteTradeAccountCmd = db.GetStoredProcCommand("SP_DeleteEQTradeAccount");

                db.AddInParameter(DeleteTradeAccountCmd, "@EQTrade_AccId", DbType.Int32, eqTradeAccId);
                if (db.ExecuteNonQuery(DeleteTradeAccountCmd) != 0)

                    bResult = true;

            }
            catch (BaseApplicationException Ex)
            {
                throw Ex;
            }
            catch (Exception Ex)
            {
                BaseApplicationException exBase = new BaseApplicationException(Ex.Message, Ex);
                NameValueCollection FunctionInfo = new NameValueCollection();
                FunctionInfo.Add("Method", "CustomerTransactionDao.cs:DeleteTradeAccount()");
                object[] objects = new object[2];
                objects[0] = eqTradeAccId;

                FunctionInfo = exBase.AddObject(FunctionInfo, objects);
                exBase.AdditionalInformation = FunctionInfo;
                ExceptionManager.Publish(exBase);
                throw exBase;

            }
            return bResult;
        }

        /// <summary>
        /// To check whether MFFolio associated with MF Transaction <<Vinayak Patil>>
        /// </summary>
        /// <param name="FolioId"></param>
        /// <returns></returns>

        public bool CheckMFFOlioAssociatedWithTransactions(int FolioId)
        {
            bool bResult = false;
            Database db;
            DbCommand CheckEQTradeAccNoAssociatedWithTransactionsCmd;
            DataSet dsCheckEQTradeAccNoAssociatedWithTransactions = new DataSet();

            try
            {
                db = DatabaseFactory.CreateDatabase("wealtherp");
                CheckEQTradeAccNoAssociatedWithTransactionsCmd = db.GetStoredProcCommand("CheckFolioAndTradeAssociation");

                db.AddInParameter(CheckEQTradeAccNoAssociatedWithTransactionsCmd, "@MFFolio_AccId", DbType.Int32, FolioId);
                dsCheckEQTradeAccNoAssociatedWithTransactions = db.ExecuteDataSet(CheckEQTradeAccNoAssociatedWithTransactionsCmd);
                if (dsCheckEQTradeAccNoAssociatedWithTransactions.Tables[1].Rows[0]["NoOfMFRecords"].ToString() != "0")

                    bResult = true;
            }
            catch (BaseApplicationException Ex)
            {
                throw Ex;
            }
            catch (Exception Ex)
            {
                BaseApplicationException exBase = new BaseApplicationException(Ex.Message, Ex);
                NameValueCollection FunctionInfo = new NameValueCollection();

                FunctionInfo.Add("Method", "CustomerTransactionDao.cs:CheckEQTradeAccNoAssociatedWithTransactions()");

                object[] objects = new object[1];
                objects[0] = FolioId;

                FunctionInfo = exBase.AddObject(FunctionInfo, objects);
                exBase.AdditionalInformation = FunctionInfo;
                ExceptionManager.Publish(exBase);
                throw exBase;
            }
            return bResult;
        }

        /// <summary>
        /// To Delete MF Folio <<Vinayak Patil>>
        /// </summary>
        /// <param name="FolioId"></param>
        /// <returns></returns>

        public bool DeleteMFFolio(int FolioId)
        {
            bool bResult = false;
            int count = 0;
            Database db;
            DbCommand DeleteTradeAccountCmd;
            DataSet dsDeleteTradeAccount = new DataSet();
            try
            {

                db = DatabaseFactory.CreateDatabase("wealtherp");
                DeleteTradeAccountCmd = db.GetStoredProcCommand("SP_DeleteMFFolio");

                db.AddInParameter(DeleteTradeAccountCmd, "@MFFolio_AccId", DbType.Int32, FolioId);
                db.AddOutParameter(DeleteTradeAccountCmd, "@CountFlag", DbType.Int32, 50);
                DeleteTradeAccountCmd.CommandTimeout = 60 * 60;
                dsDeleteTradeAccount = db.ExecuteDataSet(DeleteTradeAccountCmd);

                Object objFromDate = db.GetParameterValue(DeleteTradeAccountCmd, "@CountFlag");
                if (objFromDate != DBNull.Value)
                    count = Int32.Parse(db.GetParameterValue(DeleteTradeAccountCmd, "@CountFlag").ToString());

                if (count > 0)
                    bResult = false;

                else
                    bResult = true;



            }
            catch (BaseApplicationException Ex)
            {
                throw Ex;
            }
            catch (Exception Ex)
            {
                BaseApplicationException exBase = new BaseApplicationException(Ex.Message, Ex);
                NameValueCollection FunctionInfo = new NameValueCollection();
                FunctionInfo.Add("Method", "CustomerTransactionDao.cs:DeleteTradeAccount()");
                object[] objects = new object[2];
                objects[0] = FolioId;

                FunctionInfo = exBase.AddObject(FunctionInfo, objects);
                exBase.AdditionalInformation = FunctionInfo;
                ExceptionManager.Publish(exBase);
                throw exBase;

            }
            return bResult;
        }
        public bool CancelEquityTransaction(EQTransactionVo eqTransactionVo, int userId)
        {
            bool bResult = false;
            Database db;
            DbCommand CancelEQTrnxCmd;
            try
            {
                db = DatabaseFactory.CreateDatabase("wealtherp");
                CancelEQTrnxCmd = db.GetStoredProcCommand("SP_CancelEquityTransaction");
                db.AddInParameter(CancelEQTrnxCmd, "@EqTransId", DbType.Int32, eqTransactionVo.TransactionId);
                db.AddInParameter(CancelEQTrnxCmd, "@CETA_AccountId", DbType.Int32, eqTransactionVo.AccountId);
                db.AddInParameter(CancelEQTrnxCmd, "@PEM_ScripCode", DbType.Int32, eqTransactionVo.ScripCode);
                if (!string.IsNullOrEmpty(eqTransactionVo.TradeAccountNum))
                    db.AddInParameter(CancelEQTrnxCmd, "@CET_TradeNum", DbType.Decimal, eqTransactionVo.TradeAccountNum);
                else
                    db.AddInParameter(CancelEQTrnxCmd, "@CET_TradeNum", DbType.String, DBNull.Value);
                db.AddInParameter(CancelEQTrnxCmd, "@CET_OrderNum", DbType.Decimal, eqTransactionVo.OrderNum);
                db.AddInParameter(CancelEQTrnxCmd, "@CET_BuySell", DbType.String, eqTransactionVo.BuySell);
                db.AddInParameter(CancelEQTrnxCmd, "@CET_IsSpeculative", DbType.String, eqTransactionVo.IsSpeculative);
                if (!string.IsNullOrEmpty(eqTransactionVo.Exchange))
                    db.AddInParameter(CancelEQTrnxCmd, "@XE_ExchangeCode", DbType.String, eqTransactionVo.Exchange);
                else
                    db.AddInParameter(CancelEQTrnxCmd, "@XE_ExchangeCode", DbType.String, DBNull.Value);
                db.AddInParameter(CancelEQTrnxCmd, "@CET_TradeDate", DbType.DateTime, eqTransactionVo.TradeDate);
                db.AddInParameter(CancelEQTrnxCmd, "@CET_Rate", DbType.Decimal, eqTransactionVo.Rate);
                db.AddInParameter(CancelEQTrnxCmd, "@CET_Quantity", DbType.Decimal, eqTransactionVo.Quantity);
                db.AddInParameter(CancelEQTrnxCmd, "@CET_Brokerage", DbType.Decimal, eqTransactionVo.Brokerage);
                db.AddInParameter(CancelEQTrnxCmd, "@CET_ServiceTax", DbType.Decimal, eqTransactionVo.ServiceTax);
                db.AddInParameter(CancelEQTrnxCmd, "@CET_EducationCess", DbType.Decimal, eqTransactionVo.EducationCess);
                db.AddInParameter(CancelEQTrnxCmd, "@CET_STT", DbType.Decimal, eqTransactionVo.STT);
                db.AddInParameter(CancelEQTrnxCmd, "@CET_OtherCharges", DbType.Decimal, eqTransactionVo.OtherCharges);
                db.AddInParameter(CancelEQTrnxCmd, "@CET_RateInclBrokerage", DbType.Decimal, eqTransactionVo.RateInclBrokerage);
                db.AddInParameter(CancelEQTrnxCmd, "@CET_TradeTotal", DbType.Decimal, eqTransactionVo.TradeTotal);
                db.AddInParameter(CancelEQTrnxCmd, "@XB_BrokerCode", DbType.String, eqTransactionVo.BrokerCode);
                db.AddInParameter(CancelEQTrnxCmd, "@CET_IsSplit", DbType.Int16, eqTransactionVo.IsSplit);
                db.AddInParameter(CancelEQTrnxCmd, "@CET_SplitCustEqTransId", DbType.Int32, eqTransactionVo.SplitTransactionId);
                //db.AddInParameter(CancelEQTrnxCmd, "@XES_SourceCode", DbType.String, eqTransactionVo.SourceCode);
                db.AddInParameter(CancelEQTrnxCmd, "@WETT_TransactionCode", DbType.Int16, eqTransactionVo.TransactionCode);
                db.AddInParameter(CancelEQTrnxCmd, "@CET_IsSourceManual", DbType.Int16, eqTransactionVo.IsSourceManual);
                db.AddInParameter(CancelEQTrnxCmd, "@CET_ModifiedBy", DbType.String, userId);
                db.AddInParameter(CancelEQTrnxCmd, "@CET_CreatedBy", DbType.String, userId);

                if (db.ExecuteNonQuery(CancelEQTrnxCmd) != 0)

                    bResult = true;

            }
            catch (BaseApplicationException Ex)
            {
                throw Ex;
            }
            catch (Exception Ex)
            {
                BaseApplicationException exBase = new BaseApplicationException(Ex.Message, Ex);
                NameValueCollection FunctionInfo = new NameValueCollection();

                FunctionInfo.Add("Method", "CustomerTransactionDao.cs:CancelMFTransaction(MFTransactionVo mfTransactionVo,int userId)");


                object[] objects = new object[2];
                objects[0] = eqTransactionVo;
                objects[1] = userId;

                FunctionInfo = exBase.AddObject(FunctionInfo, objects);
                exBase.AdditionalInformation = FunctionInfo;
                ExceptionManager.Publish(exBase);
                throw exBase;

            }
            return bResult;
        }
        public DataSet GetLastMFTradeDate()
        {
            DataSet ds = null;
            Database db;
            DbCommand getLastTradeDateCmd;

            try
            {
                db = DatabaseFactory.CreateDatabase("wealtherp");
                getLastTradeDateCmd = db.GetStoredProcCommand("SP_GetLastMFValuationDate");
                ds = db.ExecuteDataSet(getLastTradeDateCmd);
            }
            catch (BaseApplicationException Ex)
            {
                throw Ex;
            }
            catch (Exception Ex)
            {
                BaseApplicationException exBase = new BaseApplicationException(Ex.Message, Ex);
                NameValueCollection FunctionInfo = new NameValueCollection();
                FunctionInfo.Add("Method", "CustomerTransactionDao.cs:GetLastTradeDate()");
                object[] objects = new object[0];
                FunctionInfo = exBase.AddObject(FunctionInfo, objects);
                exBase.AdditionalInformation = FunctionInfo;
                ExceptionManager.Publish(exBase);
                throw exBase;

            }
            return ds;
        }

        public List<MFTransactionVo> GetRMCustomerMFBalance(int RMId, int AdviserID, int GroupHeadId, DateTime From, DateTime To, int Manage, int AccountId)
        {
            DataSet ds = null;
            Database db;
            DbCommand getRMCustomerMFBalanceCmd;
            List<MFTransactionVo> mfBalanceList = new List<MFTransactionVo>();
            MFTransactionVo mfBalanceVo = new MFTransactionVo();
            DataTable dtGetMFBalance;

            try
            {
                db = DatabaseFactory.CreateDatabase("wealtherp");

                getRMCustomerMFBalanceCmd = db.GetStoredProcCommand("SP_GetRMCustomerMFBalance");
                //}

                if (RMId != 0)
                    db.AddInParameter(getRMCustomerMFBalanceCmd, "@RMId", DbType.Int32, RMId);
                else
                    db.AddInParameter(getRMCustomerMFBalanceCmd, "@RMId", DbType.Int32, DBNull.Value);

                if (AdviserID != 0)
                    db.AddInParameter(getRMCustomerMFBalanceCmd, "@AdviserID", DbType.Int32, AdviserID);
                else
                    db.AddInParameter(getRMCustomerMFBalanceCmd, "@AdviserID", DbType.Int32, DBNull.Value);


                if (GroupHeadId != 0)
                {
                    db.AddInParameter(getRMCustomerMFBalanceCmd, "@GroupHeadId", DbType.Int32, GroupHeadId);
                }
                else
                {
                    db.AddInParameter(getRMCustomerMFBalanceCmd, "@GroupHeadId", DbType.Int32, DBNull.Value);
                }

                db.AddInParameter(getRMCustomerMFBalanceCmd, "@FromDate", DbType.DateTime, From);
                db.AddInParameter(getRMCustomerMFBalanceCmd, "@ToDate", DbType.DateTime, To);
                db.AddInParameter(getRMCustomerMFBalanceCmd, "@Manage", DbType.Int32, Manage);
                if (AccountId != 0)
                    db.AddInParameter(getRMCustomerMFBalanceCmd, "@AccountId", DbType.String, AccountId);
                else
                    db.AddInParameter(getRMCustomerMFBalanceCmd, "@AccountId", DbType.String, DBNull.Value);

                getRMCustomerMFBalanceCmd.CommandTimeout = 60 * 60;
                ds = db.ExecuteDataSet(getRMCustomerMFBalanceCmd);
                if (ds.Tables[0].Rows.Count > 0)
                {
  
                    dtGetMFBalance = ds.Tables[0];
                    mfBalanceList = new List<MFTransactionVo>();
                    foreach (DataRow dr in dtGetMFBalance.Rows)
                    {
                        mfBalanceVo = new MFTransactionVo();
                        if (dr["PAISC_AssetInstrumentSubCategoryName"].ToString() != null && dr["PAISC_AssetInstrumentSubCategoryName"].ToString() != string.Empty)
                            mfBalanceVo.SubCategoryName = dr["PAISC_AssetInstrumentSubCategoryName"].ToString();
                        else
                            mfBalanceVo.SubCategoryName = "N/A";

                        mfBalanceVo.TransactionId = int.Parse(dr["CMFT_MFTransId"].ToString());
                        mfBalanceVo.CustomerId = int.Parse(dr["C_CustomerId"].ToString());
                        mfBalanceVo.CustomerName = dr["Name"].ToString();
                        mfBalanceVo.PortfolioId = int.Parse(dr["CP_PortfolioId"].ToString());
                        mfBalanceVo.AccountId = int.Parse(dr["CMFA_AccountId"].ToString());
                        mfBalanceVo.MFCode = int.Parse(dr["PASP_SchemePlanCode"].ToString());
                        mfBalanceVo.SchemePlan = dr["PASP_SchemePlanName"].ToString();
                        mfBalanceVo.Category = dr["PAIC_AssetInstrumentCategoryName"].ToString();
                        mfBalanceVo.CategoryCode = dr["PAIC_AssetInstrumentCategoryCode"].ToString();
                        mfBalanceVo.TransactionDate = DateTime.Parse(dr["CMFT_TransactionDate"].ToString());
                        mfBalanceVo.Price = float.Parse(dr["CMFT_Price"].ToString());
                        mfBalanceVo.Amount = double.Parse(dr["CMFT_Amount"].ToString());
                        mfBalanceVo.Units = double.Parse(dr["CMFT_Units"].ToString());
                        mfBalanceVo.TransactionClassificationCode = dr["WMTT_TransactionClassificationCode"].ToString();
                        mfBalanceVo.TransactionType = dr["WMTT_TransactionClassificationName"].ToString();
                        mfBalanceVo.Folio = dr["CMFA_FolioNum"].ToString();
                        mfBalanceVo.Age = int.Parse(dr["CMFTB_Age"].ToString());
                        mfBalanceVo.Balance = double.Parse(dr["ABS_Return"].ToString());
                        mfBalanceVo.CurrentValue = double.Parse(dr["CMFTB_CurrentValue"].ToString());
                        mfBalanceVo.NAV = float.Parse(dr["NAV"].ToString());
                        mfBalanceList.Add(mfBalanceVo);
                    }
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
                FunctionInfo.Add("Method", "CustomerTransactionDao.cs:GetRMCustomerMFBalance()");
                object[] objects = new object[3];
                objects[0] = RMId;
                objects[1] = GroupHeadId;
                objects[2] = From;
                objects[3] = To;
                objects[4] = Manage;
                //objects[5] = Scheme;
                //objects[6] = genDictTranType;
                //objects[7] = FolioNumber;
                //objects[8] = CustomerName;
                //objects[9] = CurrentPage;
                //objects[10] = PasssedFolioValue;

                FunctionInfo = exBase.AddObject(FunctionInfo, objects);
                exBase.AdditionalInformation = FunctionInfo;
                ExceptionManager.Publish(exBase);
                throw exBase;

            }

            //
            //if (ds.Tables.Count > 1)
            //{
            //    if (ds.Tables[1].Rows.Count > 0)
            //        Count = Int32.Parse(ds.Tables[1].Rows[0]["CNT"].ToString());
            //}
            return mfBalanceList;
        }


    }
}
