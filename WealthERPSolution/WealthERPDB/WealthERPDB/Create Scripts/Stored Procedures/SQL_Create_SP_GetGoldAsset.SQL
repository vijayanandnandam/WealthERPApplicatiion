/****** Object:  StoredProcedure [dbo].[SP_GetGoldAsset]    Script Date: 06/24/2009 12:02:53 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_GetGoldAsset]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[SP_GetGoldAsset]
GO
/****** Object:  StoredProcedure [dbo].[SP_GetGoldAsset]    Script Date: 06/24/2009 12:02:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_GetGoldAsset]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP_GetGoldAsset]

@CGNP_GoldNPId int

as

select CGNP.*,PAIC.PAIC_AssetInstrumentCategoryName from CustomerGoldNetPosition  AS CGNP
INNER JOIN dbo.ProductAssetInstrumentCategory AS PAIC
ON CGNP.PAIC_AssetInstrumentCategoryCode = PAIC.PAIC_AssetInstrumentCategoryCode


where CGNP_GoldNPId=@CGNP_GoldNPId

' 
END
GO
