/****** Object:  StoredProcedure [dbo].[SP_UpdateKarvyProfileStagingIsFolioNew]    Script Date: 06/24/2009 12:07:12 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_UpdateKarvyProfileStagingIsFolioNew]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[SP_UpdateKarvyProfileStagingIsFolioNew]
GO
/****** Object:  StoredProcedure [dbo].[SP_UpdateKarvyProfileStagingIsFolioNew]    Script Date: 06/24/2009 12:07:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_UpdateKarvyProfileStagingIsFolioNew]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE PROCEDURE [dbo].[SP_UpdateKarvyProfileStagingIsFolioNew]
AS
   update CustomerMFKarvyXtrnlProfileStaging 
     set CMFKXPS_IsFolioNew=0,CMFA_AccountId = c.CMFA_AccountId 
     from CustomerMFKarvyXtrnlProfileStaging s,CustomerMutualFundAccount c 
     where s.CMFKXPS_Folio=c.CMFA_FolioNum and s.CMFKXPS_IsFolioNew=1


' 
END
GO
