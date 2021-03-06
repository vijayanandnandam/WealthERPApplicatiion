/****** Object:  StoredProcedure [dbo].[SP_CreateCustomerFixedIncomeAccount]    Script Date: 06/24/2009 11:12:53 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_CreateCustomerFixedIncomeAccount]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[SP_CreateCustomerFixedIncomeAccount]
GO
/****** Object:  StoredProcedure [dbo].[SP_CreateCustomerFixedIncomeAccount]    Script Date: 06/24/2009 11:12:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_CreateCustomerFixedIncomeAccount]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP_CreateCustomerFixedIncomeAccount]

@CP_PortfolioId int,
@CFIA_AccountNum varchar(30),
@PAG_AssetGroupCode char(2),
@PAIC_AssetInstrumentCategoryCode char(4),
@CFIA_AccountSource varchar(30),
@CFIA_IsHeldJointly tinyint,
@XMOH_ModeOfHoldingCode CHAR(5),
@CFIA_CreatedBy int,
@CFIA_ModifiedBy INT,
@CFIA_AccountId INT OUTPUT



AS
	
	
INSERT INTO CustomerFixedIncomeAccount
(
CP_PortfolioId,
CFIA_AccountNum,
PAG_AssetGroupCode,
PAIC_AssetInstrumentCategoryCode,
CFIA_AccountSource,
CFIA_ISHeldJointly,
XMOH_ModeOfHoldingCode,
CFIA_CreatedBy,
CFIA_CreatedOn,
CFIA_ModifiedOn,
CFIA_ModifiedBy
)
VALUES
(
@CP_PortfolioId,
@CFIA_AccountNum,
@PAG_AssetGroupCode,
@PAIC_AssetInstrumentCategoryCode,
@CFIA_AccountSource,
@CFIA_ISHeldJointly,
@XMOH_ModeOfHoldingCode,
@CFIA_CreatedBy,
CURRENT_TIMESTAMP,
CURRENT_TIMESTAMP,
@CFIA_ModifiedBy
)
SELECT @CFIA_AccountId=SCOPE_IDENTITY()' 
END
GO
