/****** Object:  StoredProcedure [dbo].[SP_GetCustomerFixedIncomeAccounts]    Script Date: 06/24/2009 12:00:05 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_GetCustomerFixedIncomeAccounts]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[SP_GetCustomerFixedIncomeAccounts]
GO
/****** Object:  StoredProcedure [dbo].[SP_GetCustomerFixedIncomeAccounts]    Script Date: 06/24/2009 12:00:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_GetCustomerFixedIncomeAccounts]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP_GetCustomerFixedIncomeAccounts]
@CP_PortfolioId INT,
@PAG_AssetGroupCode varchar(5),
@PAIC_AssetInstrumentCategoryCode varchar(5)

AS

SELECT * FROM CustomerFixedIncomeAccount WHERE CP_PortfolioId=@CP_PortfolioId AND PAG_AssetGroupCode=@PAG_AssetGroupCode AND PAIC_AssetInstrumentCategoryCode=@PAIC_AssetInstrumentCategoryCode' 
END
GO
