/****** Object:  StoredProcedure [dbo].[SP_GetSystemAlerts]    Script Date: 06/24/2009 12:05:03 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_GetSystemAlerts]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[SP_GetSystemAlerts]
GO
/****** Object:  StoredProcedure [dbo].[SP_GetSystemAlerts]    Script Date: 06/24/2009 12:05:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_GetSystemAlerts]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================

CREATE PROCEDURE [dbo].[SP_GetSystemAlerts]

AS

BEGIN
		SET NOCOUNT ON
		
		SELECT 
			AEL_EventID,
			AEL_EventCode,
			AEL_EventType,
			AEL_Reminder

		FROM 
			dbo.AlertEventLookup
		WHERE
			AEL_IsAvailable = 1
			AND
			AEL_Reminder = 0
			
		SET NOCOUNT OFF
END' 
END
GO
