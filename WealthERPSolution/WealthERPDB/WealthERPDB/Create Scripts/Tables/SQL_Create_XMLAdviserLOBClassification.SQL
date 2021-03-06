/****** Object:  Table [dbo].[XMLAdviserLOBClassification]    Script Date: 06/23/2009 19:02:37 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[XMLAdviserLOBClassification]') AND type in (N'U'))
DROP TABLE [dbo].[XMLAdviserLOBClassification]
GO
/****** Object:  Table [dbo].[XMLAdviserLOBClassification]    Script Date: 06/23/2009 19:02:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[XMLAdviserLOBClassification]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[XMLAdviserLOBClassification](
	[XALC_LOBClassificationCode] [varchar](5) NOT NULL,
	[XALAG_LOBAssetGroupsCode] [varchar](5) NULL,
	[XALC_LOBCategoryCode] [varchar](5) NULL,
	[XALES_SegmentCode] [varchar](5) NULL,
	[XALC_CreatedBy] [int] NULL,
	[XALC_CreatedOn] [datetime] NULL,
	[XALC_ModifiedBy] [int] NULL,
	[XALC_ModifiedOn] [datetime] NULL,
 CONSTRAINT [PK_LOBClassification] PRIMARY KEY CLUSTERED 
(
	[XALC_LOBClassificationCode] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_XMLAdviserLOBClassification_XMLAdviserLOBAssetGroup]') AND parent_object_id = OBJECT_ID(N'[dbo].[XMLAdviserLOBClassification]'))
ALTER TABLE [dbo].[XMLAdviserLOBClassification]  WITH CHECK ADD  CONSTRAINT [FK_XMLAdviserLOBClassification_XMLAdviserLOBAssetGroup] FOREIGN KEY([XALAG_LOBAssetGroupsCode])
REFERENCES [dbo].[XMLAdviserLOBAssetGroup] ([XALAG_LOBAssetGroupsCode])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_XMLAdviserLOBClassification_XMLAdviserLOBAssetGroup]') AND parent_object_id = OBJECT_ID(N'[dbo].[XMLAdviserLOBClassification]'))
ALTER TABLE [dbo].[XMLAdviserLOBClassification] CHECK CONSTRAINT [FK_XMLAdviserLOBClassification_XMLAdviserLOBAssetGroup]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_XMLAdviserLOBClassification_XMLAdviserLOBCategory]') AND parent_object_id = OBJECT_ID(N'[dbo].[XMLAdviserLOBClassification]'))
ALTER TABLE [dbo].[XMLAdviserLOBClassification]  WITH CHECK ADD  CONSTRAINT [FK_XMLAdviserLOBClassification_XMLAdviserLOBCategory] FOREIGN KEY([XALC_LOBCategoryCode])
REFERENCES [dbo].[XMLAdviserLOBCategory] ([XALC_LOBCategoryCode])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_XMLAdviserLOBClassification_XMLAdviserLOBCategory]') AND parent_object_id = OBJECT_ID(N'[dbo].[XMLAdviserLOBClassification]'))
ALTER TABLE [dbo].[XMLAdviserLOBClassification] CHECK CONSTRAINT [FK_XMLAdviserLOBClassification_XMLAdviserLOBCategory]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_XMLAdviserLOBClassification_XMLAdviserLOBEquitySegment]') AND parent_object_id = OBJECT_ID(N'[dbo].[XMLAdviserLOBClassification]'))
ALTER TABLE [dbo].[XMLAdviserLOBClassification]  WITH CHECK ADD  CONSTRAINT [FK_XMLAdviserLOBClassification_XMLAdviserLOBEquitySegment] FOREIGN KEY([XALES_SegmentCode])
REFERENCES [dbo].[XMLAdviserLOBEquitySegment] ([XALES_SegmentCode])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_XMLAdviserLOBClassification_XMLAdviserLOBEquitySegment]') AND parent_object_id = OBJECT_ID(N'[dbo].[XMLAdviserLOBClassification]'))
ALTER TABLE [dbo].[XMLAdviserLOBClassification] CHECK CONSTRAINT [FK_XMLAdviserLOBClassification_XMLAdviserLOBEquitySegment]
GO
