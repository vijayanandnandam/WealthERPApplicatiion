/****** Object:  StoredProcedure [dbo].[SP_GetAdvDailyUploadLog]    Script Date: 06/24/2009 11:57:25 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_GetAdvDailyUploadLog]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[SP_GetAdvDailyUploadLog]
GO
/****** Object:  StoredProcedure [dbo].[SP_GetAdvDailyUploadLog]    Script Date: 06/24/2009 11:57:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_GetAdvDailyUploadLog]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'  
  
-- =============================================  
-- Author:  <Benson>  
-- Create date: <9th June 2009>  
-- Description: <Description,,>  
-- =============================================  
CREATE procedure [dbo].[SP_GetAdvDailyUploadLog]  
	@A_AdviserId BIGINT
	,@currentPage INT   
AS 

SET NOCOUNT ON

IF(@currentPage IS NULL)     
 BEGIN
 	
	SELECT 
	[ADUL_ProcessId]  
	,[ADUL_FileName]  
	,[XESFT_FileTypeId]  
    ,[ADUL_TotalNoOfRecords]  
    ,[U_UserId]  
    ,[ADUL_XMLFileName]  
    ,[A_AdviserId]  
    ,[ADUL_Comment]  
    ,[ADUL_StartTime]  
    ,[ADUL_EndTime]  
    ,[ADUL_NoOfCustomersCreated]  
    ,[ADUL_NoOfTransactionsCreated]  
    ,[ADUL_NoOfFoliosCreated]  
    ,[ADUL_NoOfRejectRecords]  
    ,case when [ADUL_IsXMLConvesionComplete] = 1  
		then ''Y''  
		else ''N'' end as [ADUL_IsXMLConvesionComplete]  
    ,case when [ADUL_IsInsertionToInputComplete] = 1  
		then ''Y''  
		else ''N'' end as [ADUL_IsInsertionToInputComplete]  
    ,case when [ADUL_IsInsertionToStagingComplete] = 1  
		then ''Y''  
		else ''N'' end as [ADUL_IsInsertionToStagingComplete]  
    ,case when [ADUL_IsInsertionToWerpComplete] = 1  
		then ''Y''  
		else ''N'' end as [ADUL_IsInsertionToWerpComplete]  
    ,case when [ADUL_IsInsertionToXtrnlComplete] = 1  
		then ''Y''  
		else ''N'' end as [ADUL_IsInsertionToXtrnlComplete]   
  FROM AdviserDailyUploadLog  
  WHERE [A_AdviserId] = @A_AdviserId
 	
 END
 
 ELSE IF (@currentPage IS NOT NULL)
 BEGIN
 	
  DECLARE @intStartRow int;     
  DECLARE @intEndRow int;    
  SET @intStartRow = (@currentPage -1) * 10 + 1;      
  SET @intEndRow = @currentPage * 10;  
     
  WITH Entries AS    
  (    
   select   
   ROW_NUMBER() over ( ORDER BY    
     [ADUL_ProcessId] ASC ) as RowNum   
    ,[ADUL_ProcessId]  
	,[ADUL_FileName]  
	,[XESFT_FileTypeId]  
    ,[ADUL_TotalNoOfRecords]  
    ,[U_UserId]  
    ,[ADUL_XMLFileName]  
    ,[A_AdviserId]  
    ,[ADUL_Comment]  
    ,[ADUL_StartTime]  
    ,[ADUL_EndTime]  
    ,[ADUL_NoOfCustomersCreated]  
    ,[ADUL_NoOfTransactionsCreated]  
    ,[ADUL_NoOfFoliosCreated]  
    ,[ADUL_NoOfRejectRecords]  
    ,case when [ADUL_IsXMLConvesionComplete] = 1  
		then ''Y''  
		else ''N'' end as [ADUL_IsXMLConvesionComplete]  
    ,case when [ADUL_IsInsertionToInputComplete] = 1  
		then ''Y''  
		else ''N'' end as [ADUL_IsInsertionToInputComplete]  
    ,case when [ADUL_IsInsertionToStagingComplete] = 1  
		then ''Y''  
		else ''N'' end as [ADUL_IsInsertionToStagingComplete]  
    ,case when [ADUL_IsInsertionToWerpComplete] = 1  
		then ''Y''  
		else ''N'' end as [ADUL_IsInsertionToWerpComplete]  
    ,case when [ADUL_IsInsertionToXtrnlComplete] = 1  
		then ''Y''  
		else ''N'' end as [ADUL_IsInsertionToXtrnlComplete]    
        
	FROM AdviserDailyUploadLog  
	WHERE [A_AdviserId] = @A_AdviserId     
  )    
    
	SELECT * FROM Entries WHERE RowNum BETWEEN @intStartRow AND @intEndRow    
       
	SELECT COUNT(*) AS CNT 
	FROM AdviserDailyUploadLog  
	WHERE [A_AdviserId] = @A_AdviserId
 	
 END
  
 SET NOCOUNT OFF' 
END
GO
