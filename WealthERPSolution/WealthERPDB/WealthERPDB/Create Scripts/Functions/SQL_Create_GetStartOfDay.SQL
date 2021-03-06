/****** Object:  UserDefinedFunction [dbo].[GetStartOfDay]    Script Date: 06/24/2009 15:30:22 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetStartOfDay]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[GetStartOfDay]
GO
/****** Object:  UserDefinedFunction [dbo].[GetStartOfDay]    Script Date: 06/24/2009 15:30:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetStartOfDay]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
execute dbo.sp_executesql @statement = N'Create Function [dbo].[GetStartOfDay](@CurDate Datetime)  
Returns Datetime  
As  
Begin  
 Declare @month As Datetime  
 Set @month = @CurDate  
 Return CAST(DATEPART(year, @month) As NVarchar(5)) + ''-'' + CAST(DATEPART(month, @month) As NVarchar(3)) + ''-'' + CAST(DATEPART(day, @month) As NVarchar(3)) + '' 00:00:00.000''  
End  
  
  
  
  
  
  
  
  
  
  
  ' 
END

GO
