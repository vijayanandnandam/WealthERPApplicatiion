/****** Object:  UserDefinedFunction [dbo].[FN_GetSchemeCode]    Script Date: 06/24/2009 15:30:13 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FN_GetSchemeCode]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[FN_GetSchemeCode]
GO
/****** Object:  UserDefinedFunction [dbo].[FN_GetSchemeCode]    Script Date: 06/24/2009 15:30:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FN_GetSchemeCode]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
execute dbo.sp_executesql @statement = N'CREATE FUNCTION [dbo].[FN_GetSchemeCode]
(
	@WerpCode INT,
	@Code VARCHAR(15)
)

RETURNS VARCHAR(255)

AS

BEGIN
	
	DECLARE @returnCode VARCHAR(255);
	
	SELECT @returnCode = B.PASC_AMC_ExternalCode
	FROM 
		ProductAMCSchemePlan A
		INNER JOIN 
		ProductAMCSchemeMapping B 
	ON 
	B.PASP_SchemePlanCode = A.PASP_SchemePlanCode
	WHERE
		B.PASC_AMC_ExternalType = @Code
		AND
		A.PASP_SchemePlanCode = @WerpCode
		
	RETURN @returnCode;
	
	
END' 
END

GO
