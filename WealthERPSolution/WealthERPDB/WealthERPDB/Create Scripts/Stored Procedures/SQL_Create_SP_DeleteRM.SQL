/****** Object:  StoredProcedure [dbo].[SP_DeleteRM]    Script Date: 06/24/2009 11:15:17 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_DeleteRM]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[SP_DeleteRM]
GO
/****** Object:  StoredProcedure [dbo].[SP_DeleteRM]    Script Date: 06/24/2009 11:15:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_DeleteRM]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP_DeleteRM]

@AR_RMId INT,
@U_UserId INT


AS

BEGIN
DECLARE @ErrorMessage VARCHAR(1000);
	    BEGIN TRY --Start the Try Block..

			BEGIN TRANSACTION -- Start the transaction..
        
				DELETE FROM dbo.AdviserRM WHERE AR_RMId=@AR_RMId
			
				DELETE FROM dbo.[User] WHERE U_UserId = @U_UserId            

			COMMIT TRAN -- Transaction Success!

		END TRY

		BEGIN CATCH
		
			ROLLBACK TRAN
				
				SELECT @ErrorMessage = ERROR_MESSAGE();
				RAISERROR(@ErrorMessage, 16, 1)
				RAISERROR(''YOU CAN NOT DELETE BECAUSE RM - %d HAS SOME DEPENDENT DATA EXISTS... ''	,16,1,@AR_RMId);

		END CATCH	
	
	
END


--EXEC dbo.SP_DeleteRM 1037, 1665
	
' 
END
GO
