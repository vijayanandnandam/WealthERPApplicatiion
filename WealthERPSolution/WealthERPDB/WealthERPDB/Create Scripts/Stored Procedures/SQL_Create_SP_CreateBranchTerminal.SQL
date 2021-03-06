/****** Object:  StoredProcedure [dbo].[SP_CreateBranchTerminal]    Script Date: 06/24/2009 11:03:47 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_CreateBranchTerminal]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[SP_CreateBranchTerminal]
GO
/****** Object:  StoredProcedure [dbo].[SP_CreateBranchTerminal]    Script Date: 06/24/2009 11:03:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_CreateBranchTerminal]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP_CreateBranchTerminal]
@AT_TerminalId NUMERIC(10,0),
@AB_BranchId	int	,
@AT_CreatedBy	int,	
@AT_ModifiedBy	int	

as

insert into AdviserTerminal
(
AT_TerminalId,
AB_BranchId,
AT_CreatedBy,
AT_CreatedOn,
AT_ModifiedBy,
AT_ModifiedOn


)
 values
(
@AT_TerminalId,
@AB_BranchId,
@AT_CreatedBy,
current_timestamp,
@AT_ModifiedBy,
current_timestamp

)
' 
END
GO
