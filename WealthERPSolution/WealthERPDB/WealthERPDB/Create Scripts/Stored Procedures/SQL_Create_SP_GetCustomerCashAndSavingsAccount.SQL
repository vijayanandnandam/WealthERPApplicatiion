/****** Object:  StoredProcedure [dbo].[SP_GetCustomerCashAndSavingsAccount]    Script Date: 06/24/2009 11:59:13 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_GetCustomerCashAndSavingsAccount]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[SP_GetCustomerCashAndSavingsAccount]
GO
/****** Object:  StoredProcedure [dbo].[SP_GetCustomerCashAndSavingsAccount]    Script Date: 06/24/2009 11:59:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_GetCustomerCashAndSavingsAccount]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP_GetCustomerCashAndSavingsAccount]
@CCSA_AccountId INT
AS
SELECT CCSA.*,PAIC.PAIC_AssetInstrumentCategoryName FROM CustomerCashSavingsAccount  AS CCSA
INNER JOIN dbo.ProductAssetInstrumentCategory AS PAIC 
ON CCSA.PAIC_AssetInstrumentCategoryCode = PAIC.PAIC_AssetInstrumentCategoryCode AND CCSA.PAG_AssetGroupCode = PAIC.PAG_AssetGroupCode

WHERE @CCSA_AccountId=CCSA_AccountId' 
END
GO
