/****** Object:  Table [dbo].[XMLMeasureCode]    Script Date: 06/23/2009 19:03:23 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[XMLMeasureCode]') AND type in (N'U'))
DROP TABLE [dbo].[XMLMeasureCode]
GO
/****** Object:  Table [dbo].[XMLMeasureCode]    Script Date: 06/23/2009 19:03:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[XMLMeasureCode]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[XMLMeasureCode](
	[XMC_MeasureCode] [varchar](5) NOT NULL,
	[XMC_Measure] [varchar](30) NULL,
	[XMC_AssetGroup] [varchar](20) NULL,
	[XMC_CreatedBy] [int] NULL,
	[XMC_CreatedOn] [datetime] NULL,
	[XMC_ModifiedBy] [int] NULL,
	[XMC_ModifiedOn] [datetime] NULL,
 CONSTRAINT [PK_XMLMeasureCode] PRIMARY KEY CLUSTERED 
(
	[XMC_MeasureCode] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
