/****** Object:  StoredProcedure [dbo].[SP_DeletePersonalNetPostion]    Script Date: 06/24/2009 11:15:08 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_DeletePersonalNetPostion]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[SP_DeletePersonalNetPostion]
GO
/****** Object:  StoredProcedure [dbo].[SP_DeletePersonalNetPostion]    Script Date: 06/24/2009 11:15:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_DeletePersonalNetPostion]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE SP_DeletePersonalNetPostion
@CPNP_PersonalNPId INT

AS

BEGIN
		
	DECLARE @ErrorMessage VARCHAR(1000);
	
	BEGIN TRY
		
		    BEGIN TRANSACTION -- Start the transaction..

				DELETE FROM CustomerPersonalNetPosition
				WHERE CPNP_PersonalNPId = @CPNP_PersonalNPId;
				
			COMMIT TRAN -- Transaction Success!
		
	END TRY
	
	BEGIN CATCH
		        IF @@TRANCOUNT > 0
					ROLLBACK TRAN --RollBack in case of Error
					
				SELECT @ErrorMessage = ERROR_MESSAGE();
				RAISERROR(@ErrorMessage, 16, 1)
	END CATCH	
		
END' 
END
GO
