/****** Object:  StoredProcedure [dbo].[SP_GetFixedIncomeNetPosition]    Script Date: 06/24/2009 12:02:50 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_GetFixedIncomeNetPosition]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[SP_GetFixedIncomeNetPosition]
GO
/****** Object:  StoredProcedure [dbo].[SP_GetFixedIncomeNetPosition]    Script Date: 06/24/2009 12:02:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_GetFixedIncomeNetPosition]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP_GetFixedIncomeNetPosition]
@CFINP_FINPId INT
AS
BEGIN
	SELECT 
		* 
	FROM 
		CustomerFixedIncomeNetPosition 
	WHERE 
		CFINP_FINPId = @CFINP_FINPId
END' 
END
GO
