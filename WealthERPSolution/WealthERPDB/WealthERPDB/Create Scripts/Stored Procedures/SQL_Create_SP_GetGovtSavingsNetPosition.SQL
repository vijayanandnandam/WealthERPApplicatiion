/****** Object:  StoredProcedure [dbo].[SP_GetGovtSavingsNetPosition]    Script Date: 06/24/2009 12:03:02 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_GetGovtSavingsNetPosition]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[SP_GetGovtSavingsNetPosition]
GO
/****** Object:  StoredProcedure [dbo].[SP_GetGovtSavingsNetPosition]    Script Date: 06/24/2009 12:03:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_GetGovtSavingsNetPosition]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP_GetGovtSavingsNetPosition]
(
@CP_PortfolioId INT,
@CurrentPage INT =1,
@SortOrder VARCHAR(20) =''''
)
AS

BEGIN
DECLARE @intStartRow int; 
DECLARE @intEndRow int;
SET @intStartRow = (@CurrentPage -1) * 10 + 1;  
SET @intEndRow = @CurrentPage * 10;
WITH Entries AS 
(
SELECT * ,
ROW_NUMBER() over ( ORDER BY
							CASE WHEN @SortOrder = ''Category DESC''
							THEN PAIC_AssetInstrumentCategoryName END DESC,
							CASE WHEN @SortOrder = ''Category ASC''
							THEN PAIC_AssetInstrumentCategoryName END ASC,
							CASE WHEN @SortOrder = ''Particulars DESC''
							THEN CGSNP_Name END DESC,
							CASE WHEN @SortOrder = ''Particulars ASC''
							THEN CGSNP_Name END ASC,
							CASE WHEN @SortOrder = ''DepositDate DESC''
							THEN CGSNP_PurchaseDate END DESC,
							CASE WHEN @SortOrder = ''DepositDate ASC''
							THEN CGSNP_PurchaseDate END ASC,
							CASE WHEN @SortOrder = ''MaturityDate DESC''
							THEN CGSNP_MaturityDate END DESC,
							CASE WHEN @SortOrder = ''MaturityDate ASC''
							THEN CGSNP_MaturityDate END ASC,
							CASE WHEN @SortOrder = ''DepositAmount DESC''
							THEN CGSNP_DepositAmount END DESC,
							CASE WHEN @SortOrder = ''DepositAmount ASC''
							THEN CGSNP_DepositAmount END ASC,
							CASE WHEN @SortOrder = ''RateOfInterest DESC''
							THEN CGSNP_InterestRate END DESC,
							CASE WHEN @SortOrder = ''RateOfInterest ASC''
							THEN CGSNP_InterestRate END ASC,
							CASE WHEN @SortOrder = ''CurrentValue DESC''
							THEN CGSNP_CurrentValue END DESC,
							CASE WHEN @SortOrder = ''CurrentValue ASC''
							THEN CGSNP_CurrentValue END ASC,
							CASE WHEN @SortOrder = ''MaturityValue DESC''
							THEN CGSNP_MaturityValue END DESC,
							CASE WHEN @SortOrder = ''MaturityValue ASC''
							THEN CGSNP_MaturityValue END ASC
						) as RowNum 
FROM dbo.ViewGovtSavingsNP WHERE CP_PortfolioId=@CP_PortfolioId
)
SELECT * FROM Entries where RowNum BETWEEN @intStartRow AND @intEndRow

SELECT COUNT(*) FROM dbo.ViewGovtSavingsNP WHERE CP_PortfolioId=@CP_PortfolioId



END
' 
END
GO
