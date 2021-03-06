/****** Object:  StoredProcedure [dbo].[SP_GetFixedIncomeList]    Script Date: 06/24/2009 12:02:48 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_GetFixedIncomeList]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[SP_GetFixedIncomeList]
GO
/****** Object:  StoredProcedure [dbo].[SP_GetFixedIncomeList]    Script Date: 06/24/2009 12:02:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_GetFixedIncomeList]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'  
-- =============================================  
-- Author:  <Author,,Name>  
-- Create date: <Create Date,,>  
-- Description: <Description,,>  
-- =============================================  
CREATE PROCEDURE [dbo].[SP_GetFixedIncomeList]  
(
@CP_PortfolioId INT, 
@CurrentPage INT =1 ,
@SortOrder VARCHAR(20)=''CFINP_Name ASC''
 )
AS
BEGIN

DECLARE @intStartRow int; 
DECLARE @intEndRow int;
SET @intStartRow = (@CurrentPage -1) * 10 + 1;  
SET @intEndRow = @CurrentPage * 10;
WITH Entries AS 
(
	SELECT 
		CFINP_FINPId,
		CFIA_AccountId,
		PAIC_AssetInstrumentCategoryCode,
		PAG_AssetGroupCode,
		XDI_DebtIssuerCode,
		XIB_InterestBasisCode,
		XF_CompoundInterestFrequencyCode,
		XF_InterestPayableFrequencyCode,
		CFINP_Name,
		CFINP_PrincipalAmount,
		CFINP_InterestAmtPaidOut,
		CFINP_InterestAmtAcculumated,
		CFINP_InterestRate,
		CFINP_PurchasePrice,
		CFINP_PurchaseValue,
		CFINP_PurchaseDate,
		CFINP_MaturityDate,
		CFINP_MaturityValue,
		CFINP_IsInterestAccumulated,
		CFINP_CurrentPrice,
		CFINP_CurrentValue,
		PAIC_AssetInstrumentCategoryName,
		ROW_NUMBER() over ( ORDER BY
							CASE WHEN @SortOrder = ''Name DESC''
							THEN CFINP_Name END DESC,
							CASE WHEN @SortOrder = ''Name ASC''
							THEN CFINP_Name END ASC,
							CASE WHEN @SortOrder = ''Category DESC''
							THEN PAIC_AssetInstrumentCategoryName END DESC,
							CASE WHEN @SortOrder = ''Category ASC''
							THEN PAIC_AssetInstrumentCategoryName END ASC
							 ) as RowNum   
	FROM dbo.ViewFixedIncomeNP 
	WHERE CP_PortfolioId = @CP_PortfolioId  
)
SELECT * FROM Entries WHERE  RowNum BETWEEN @intStartRow AND @intEndRow 

SELECT COUNT (*) FROM dbo.ViewFixedIncomeNP  WHERE CP_PortfolioId = @CP_PortfolioId   
END


  ' 
END
GO
