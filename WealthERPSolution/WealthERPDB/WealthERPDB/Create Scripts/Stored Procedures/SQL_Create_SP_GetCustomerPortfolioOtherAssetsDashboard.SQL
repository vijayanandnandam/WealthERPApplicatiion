/****** Object:  StoredProcedure [dbo].[SP_GetCustomerPortfolioOtherAssetsDashboard]    Script Date: 06/24/2009 12:01:28 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_GetCustomerPortfolioOtherAssetsDashboard]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[SP_GetCustomerPortfolioOtherAssetsDashboard]
GO
/****** Object:  StoredProcedure [dbo].[SP_GetCustomerPortfolioOtherAssetsDashboard]    Script Date: 06/24/2009 12:01:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_GetCustomerPortfolioOtherAssetsDashboard]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE PROCEDURE [dbo].[SP_GetCustomerPortfolioOtherAssetsDashboard]
@PortfolioId INT

AS

SET NOCOUNT ON
	
	/* 1 - Retrieving Top 2 Cash n Saving Assets */
	SELECT 
		TOP 2
		PAG_AssetGroupName AS AssetType,
		CCSNP_Name AS AssetParticulars,
		0 AS PurchaseCost,
		ISNULL(CAST(CCSNP_CurrentValue AS BIGINT), 0) AS CurrentValue
	FROM
		ViewCashSavingsNP
	WHERE
		CP_PortfolioId = @PortfolioId
	--ORDER BY CCSNP_CurrentValue
	
	UNION
	/* 2 - Retrieving Top 2 Collectibles Assets */	
	SELECT
		TOP 2
		PAG_AssetGroupName AS AssetType,
		CCNP_Name AS AssetParticulars,
		ISNULL(CAST(CCNP_PurchaseValue AS BIGINT), 0) AS PurchaseCost,
		ISNULL(CAST(CCNP_CurrentValue AS BIGINT), 0) AS CurrentValue
	FROM
		ViewCollectiblesNP
	WHERE
		CP_PortfolioId = @PortfolioId
	--ORDER BY CCNP_CurrentValue
	
	UNION
	/* 3 - Retrieving Top 2 Gold Assets */	
	SELECT
		TOP 2
		PAG_AssetGroupName AS AssetType,
		CGNP_Name AS AssetParticulars,
		ISNULL(CAST(CGNP_PurchaseValue AS BIGINT), 0) AS PurchaseCost,
		ISNULL(CAST(CGNP_CurrentValue AS BIGINT), 0) AS CurrentValue
	FROM
		ViewGoldNP
	WHERE
		CP_PortfolioId = @PortfolioId
	--ORDER BY CGNP_CurrentValue
	
	UNION
	/* 4 - Retrieving Top 2 Pension Assets */	
	SELECT
		TOP 2
		PAG_AssetGroupName AS AssetType,
		CPGNP_OrganizationName AS AssetParticulars,
		0 AS PurchaseCost,
		ISNULL(CAST(CPGNP_CurrentValue AS BIGINT), 0) AS CurrentValue
	FROM
		ViewPensionGratuities
	WHERE
		CP_PortfolioId = @PortfolioId
	--ORDER BY CPGNP_CurrentValue
		
	UNION
	/* 5 - Retrieving Top 2 Pension Assets */	
	SELECT
		TOP 2
		PAG_AssetGroupName AS AssetType,
		CPNP_Name AS AssetParticulars,
		ISNULL(CAST(CPNP_PurchaseValue AS BIGINT), 0) AS PurchaseCost,
		ISNULL(CAST(CPNP_CurrentValue AS BIGINT), 0) AS CurrentValue
	FROM
		ViewPersonalNP
	WHERE
		CP_PortfolioId = @PortfolioId
	--ORDER BY CPNP_CurrentValue
		
	UNION
	/* 6 - Retrieving Top 2 Property Assets */	
	SELECT
		TOP 2
		PAG_AssetGroupName AS AssetType,
		CPNP_Name AS AssetParticulars,
		ISNULL(CAST(CPNP_PurchaseValue AS BIGINT), 0) AS PurchaseCost,
		ISNULL(CAST(CPNP_CurrentValue AS BIGINT), 0) AS CurrentValue
	FROM
		ViewPropertyNP
	WHERE
		CP_PortfolioId = @PortfolioId
	--ORDER BY CPNP_CurrentValue
	
SET NOCOUNT OFF 


-- exec 1632' 
END
GO
GRANT EXECUTE ON [dbo].[SP_GetCustomerPortfolioOtherAssetsDashboard] TO [public] AS [dbo]
GO
