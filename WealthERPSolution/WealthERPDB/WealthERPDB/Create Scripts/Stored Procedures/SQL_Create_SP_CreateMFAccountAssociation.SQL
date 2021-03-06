/****** Object:  StoredProcedure [dbo].[SP_CreateMFAccountAssociation]    Script Date: 06/24/2009 11:13:38 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_CreateMFAccountAssociation]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[SP_CreateMFAccountAssociation]
GO
/****** Object:  StoredProcedure [dbo].[SP_CreateMFAccountAssociation]    Script Date: 06/24/2009 11:13:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_CreateMFAccountAssociation]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP_CreateMFAccountAssociation]
@CMFA_AccountId INT,
@CA_AssociationId INT,
@CMFAA_AssociationType VARCHAR(30),
@CMFAA_CreatedBy INT,
@CMFAA_ModifiedBy INT
AS
INSERT INTO CustomerMutualFundAccountAssociates 
(
CMFA_AccountId,
CA_AssociationId,
CMFAA_AssociationType,
CMFAA_CreatedBy,
CMFAA_CreatedOn,
CMFAA_ModifiedBy,
CMFAA_ModifiedOn
)
VALUES
(
@CMFA_AccountId,
@CA_AssociationId,
@CMFAA_AssociationType,
@CMFAA_CreatedBy,
CURRENT_TIMESTAMP,
@CMFAA_ModifiedBy,
CURRENT_TIMESTAMP
)
' 
END
GO
