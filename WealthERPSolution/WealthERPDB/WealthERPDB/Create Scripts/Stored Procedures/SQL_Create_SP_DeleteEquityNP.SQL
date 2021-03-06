/****** Object:  StoredProcedure [dbo].[SP_DeleteEquityNP]    Script Date: 06/24/2009 11:14:39 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_DeleteEquityNP]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[SP_DeleteEquityNP]
GO
/****** Object:  StoredProcedure [dbo].[SP_DeleteEquityNP]    Script Date: 06/24/2009 11:14:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_DeleteEquityNP]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'


CREATE PROCEDURE [dbo].[SP_DeleteEquityNP]
@C_CustomerId INT,
@CENP_ValuationDate datetime
AS
Delete A from CustomerEquityNetPosition A,CustomerEquityTradeAccount B,CustomerPortfolio C
  where A.CETA_AccountId=B.CETA_AccountId and B.CP_PortfolioId=C.CP_PortfolioId
  and C.C_CustomerId=@C_CustomerId and A.CENP_ValuationDate=@CENP_ValuationDate


' 
END
GO
