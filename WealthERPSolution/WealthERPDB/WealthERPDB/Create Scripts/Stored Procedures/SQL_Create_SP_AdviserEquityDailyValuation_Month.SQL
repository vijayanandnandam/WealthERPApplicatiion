/****** Object:  StoredProcedure [dbo].[SP_AdviserEquityDailyValuation_Month]    Script Date: 06/24/2009 10:59:08 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_AdviserEquityDailyValuation_Month]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[SP_AdviserEquityDailyValuation_Month]
GO
/****** Object:  StoredProcedure [dbo].[SP_AdviserEquityDailyValuation_Month]    Script Date: 06/24/2009 10:59:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_AdviserEquityDailyValuation_Month]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP_AdviserEquityDailyValuation_Month]

@WTD_Year INT

AS

SELECT  
	--DISTINCT MONTH (ToDate( FormatNumber([WTD_Month];"00") ;"MM")) 
	 --CAST(MONTH(WTD_Month) AS VARCHAR(10))  AS TradeMonth
	DISTINCT CONVERT(VARCHAR(3),WTD_Date,100) AS TradeMonth,
	WTD_Month
FROM
     WerpTradeDate 
WHERE WTD_Year=@WTD_Year
GROUP BY 
WTD_Date,
	WTD_Month
	
ORDER BY WTD_Month ASC;


--exec  [dbo].[SP_AdviserEquityDailyValuation_Month] 2008

' 
END
GO
